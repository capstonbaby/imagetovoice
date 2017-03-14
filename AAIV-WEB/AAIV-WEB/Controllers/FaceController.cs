using AAIV_WEB.Models.Entities;
using AAIV_WEB.Models.Entities.Services;
using AAIV_WEB.Models.ViewModels;
using AutoMapper.QueryableExtensions;
using CloudinaryDotNet;
using CloudinaryDotNet.Actions;
using Microsoft.AspNet.Identity;
using Microsoft.ProjectOxford.Face;
using SkyWeb.DatVM.Mvc;
using System;
using System.Collections.Generic;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace AAIV_WEB.Controllers
{
    [Authorize]
    public class FaceController : BaseController
    {
        private static string API_KEY = "3fafcdb48bdc4ef6b20d61524bfac93c";

        private readonly FaceServiceClient faceServiceClient = new FaceServiceClient(API_KEY);

        private static Account account = new Account(
            "debwqzo2g", "852288139213848", "qsuCuMnpTZ11_WxuIuQ5kPZmdr4"
            );

        private Cloudinary cloudinary = new Cloudinary(account);

        // GET: Face
        public ActionResult Index()
        {
            var service = this.Service<IAspNetUserService>();
            var personService = this.Service<IPersonService>();
            var faceService = this.Service<IFaceService>();


            // PErson Group
            var curUser = Util.getCurrentUser(this);

            if (curUser != null)
            {
                var personList = personService.GetActive(q => q.PersonGroupId == curUser.Id)
                    .ProjectTo<PersonEditViewModel>(this.MapperConfig)
                    .ToList();

                foreach (var person in personList)
                {
                    var img = faceService.GetActive(q => q.PersonID == person.PersonId).FirstOrDefault();
                    if (img != null)
                    {
                        person.PersonAvatar = img.ImageURL;
                    }
                }

                return this.View(personList);
            }

            return RedirectToAction("Login", "Account");
        }

        [HttpGet]
        public ActionResult NewPerson()
        {
            PersonEditViewModel model = (PersonEditViewModel)TempData["personEditViewModel"];
            if (model == null)
            {
                model = new PersonEditViewModel();
            }
            return View(model);
        }

        [HttpPost]
        public async Task<ActionResult> NewPerson(PersonEditViewModel person, IEnumerable<HttpPostedFileBase> file)
        {
            var personService = this.Service<IPersonService>();
            var personGroupService = this.Service<IPersonGroupService>();
            var userService = this.Service<IAspNetUserService>();
            var faceService = this.Service<IFaceService>();
            var logService = this.Service<ILogService>();
            var progressHub = new ProgressHub();
            progressHub.SendMessage("20%", 20);

            if (User.Identity.IsAuthenticated)
            {
                try
                {
                    var user = Util.getCurrentUser(this);
                    var personGroup = personGroupService.Get(user.Id);

                    //create in Microsoft
                    var personCreateResult = await faceServiceClient.CreatePersonAsync(personGroup.PersonGroupId, person.Name, person.Description);
                    progressHub.SendMessage("33%", 33);

                    //create in database
                    var newPerson = new Person
                    {
                        Name = person.Name,
                        Description = person.Description,
                        PersonGroupId = personGroup.PersonGroupId,
                        Active = true,
                        PersonId = personCreateResult.PersonId.ToString(),
                        IsTrained = true,
                    };
                    await personService.CreateAsync(newPerson);
                    progressHub.SendMessage("50%", 50);

                    //Solve Log image file to MCS + db
                    if (person.LogImage != null)
                    {
                        //create face in Microsoft
                        var addFaceResult = await faceServiceClient.AddPersonFaceAsync
                                                (personGroup.PersonGroupId, personCreateResult.PersonId, person.LogImage);

                        //create face in db
                        var persistedFaceId = addFaceResult.PersistedFaceId.ToString();
                        var face = new Models.Entities.Face
                        {
                            ImageURL = person.LogImage,
                            PersistedFaceId = persistedFaceId,
                            PersonID = newPerson.PersonId,
                            Active = true
                        };

                        await faceService.CreateAsync(face);

                        //Deactive log in db
                        await logService.DeactivateAsync(logService.Get(person.LogID));


                    }

                    //Upload new chosen iamge files
                    if (file.FirstOrDefault() != null)
                    {
                        foreach (var imageFile in file)
                        {
                            string pic = System.IO.Path.GetFileName(imageFile.FileName);
                            string path = System.IO.Path.Combine(
                                                   Server.MapPath("~/images"), pic);
                            // file is uploaded
                            imageFile.SaveAs(path);

                            var uploadParams = new ImageUploadParams()
                            {
                                File = new FileDescription(path)
                            };

                            var uploadResult = cloudinary.Upload(uploadParams).Uri.ToString();

                            //create face in Microsoft
                            var addFaceResult = await faceServiceClient.AddPersonFaceAsync(personGroup.PersonGroupId, personCreateResult.PersonId, uploadResult);


                            //create face in db
                            var persistedFaceId = addFaceResult.PersistedFaceId.ToString();
                            var face = new Models.Entities.Face
                            {
                                ImageURL = uploadResult,
                                PersistedFaceId = persistedFaceId,
                                PersonID = newPerson.PersonId,
                                Active = true
                            };
                            await faceService.CreateAsync(face);

                        }

                    }
                    //Set Progress bar
                    progressHub.SendMessage("70%", 70);
                    //Train
                    await faceServiceClient.TrainPersonGroupAsync(personGroup.PersonGroupId);
                    progressHub.SendMessage("Complete !", 100);
                    Thread.Sleep(1000);

                    // after successfully uploading redirect the user
                    if (person.LogID != 0)
                    {
                        return RedirectToAction("ShowLogs", "Face");
                    }
                    else
                    {
                        return RedirectToAction("Index", "Face");
                    }

                }
                catch (Exception ex)
                {
                    throw ex;
                }
            }
            else
            {
                return RedirectToAction("Login", "Account");
            }
        }

        public ActionResult Uploader()
        {
            bool isSavedSuccessfully = true;
            string fName = "";
            foreach (string fileName in Request.Files)
            {
                HttpPostedFileBase file = Request.Files[fileName];
                //Save file content goes here
                fName = file.FileName;
                if (file != null && file.ContentLength > 0)
                {

                    var fileName1 = Path.GetFileName(file.FileName);

                    string pathString = System.IO.Path.Combine(Server.MapPath("~/images"), fileName1);

                    file.SaveAs(pathString);

                }

            }

            if (isSavedSuccessfully)
            {
                return Json(new { Message = fName });
            }
            else
            {
                return Json(new { Message = "Error in saving file" });
            }
        }

        [HttpPost]
        public ActionResult NewPersonFromLog(int logID, string imgUrl, string name, string mode, string personToUpdate)
        {
            var person = new Person();
            person.Name = name;

            var model = this.Mapper.Map<PersonEditViewModel>(person);

            model.LogImage = imgUrl;
            model.LogID = logID;
            TempData["personEditViewModel"] = model;

            return RedirectToAction("NewPerson", "Face");


        }


        public async Task<JsonResult> DeletePerson(string id)
        {
            var personService = this.Service<IPersonService>();
            var personGroupService = this.Service<IPersonGroupService>();
            var userService = this.Service<IAspNetUserService>();
            var faceService = this.Service<IFaceService>();

            if (User.Identity.IsAuthenticated)
            {
                var user = Util.getCurrentUser(this);
                var personGroup = personGroupService.Get(user.Id);

                var deletePerson = personService.Get(id);
                //Delete in Microsoft
                Guid personID = new Guid(deletePerson.PersonId);
                await faceServiceClient.DeletePersonAsync(personGroup.PersonGroupId, personID);

                //Delete in Database

                await personService.DeactivateAsync(deletePerson);

                foreach (var item in deletePerson.Faces)
                {
                    await faceService.DeactivateAsync(item);
                }

                //Train Person
                await faceServiceClient.TrainPersonGroupAsync(personGroup.PersonGroupId);

                return Json(new { message = "Xóa thành công", success = true });
            }
            else
            {
                return Json(new { message = "Xóa thất bại", success = false });
            }
        }

        public ActionResult UpdatePerson(string id)
        {
            var personService = this.Service<IPersonService>();
            var personGroupService = this.Service<IPersonGroupService>();
            var userService = this.Service<IAspNetUserService>();
            var faceService = this.Service<IFaceService>();

            var person = personService.Get(id);
            var faceList = faceService.GetActive(q => q.PersonID.Equals(person.PersonId))
                            .ProjectTo<FaceViewModel>(this.MapperConfig);
            var personViewModel = new PersonViewModel(person);
            var model = this.Mapper.Map<PersonEditViewModel>(personViewModel);
            model.FaceList = faceList.ToList();

            return View(model);
        }

        [HttpPost]
        public async Task<ActionResult> UpdatePerson(PersonViewModel person, IEnumerable<HttpPostedFileBase> file)
        {
            var personService = this.Service<IPersonService>();
            var personGroupService = this.Service<IPersonGroupService>();
            var userService = this.Service<IAspNetUserService>();
            var faceService = this.Service<IFaceService>();

            if (User.Identity.IsAuthenticated)

            {
                var user = Util.getCurrentUser(this);
                var personGroupID = personGroupService.Get(user.Id).PersonGroupId;

                //Update in Microsoft

                var updatePerson = personService.Get(person.PersonId);
                Guid personID = new Guid(updatePerson.PersonId);

                var personUpdateResult = faceServiceClient.UpdatePersonAsync(personGroupID, personID, person.Name, person.Description);

                //Update in Database
                updatePerson.Name = person.Name;
                updatePerson.Description = person.Description;
                personService.Save();

                //Upload imageS
                if (file.Count() > 0 && file.FirstOrDefault() != null)
                {
                    foreach (var imageFile in file)
                    {
                        string pic = System.IO.Path.GetFileName(imageFile.FileName);
                        string path = System.IO.Path.Combine(
                                               Server.MapPath("~/images"), pic);
                        // file is uploaded
                        imageFile.SaveAs(path);

                        var uploadParams = new ImageUploadParams()
                        {
                            File = new FileDescription(path)
                        };

                        var uploadResult = cloudinary.Upload(uploadParams).Uri.ToString();

                        //create face in Microsoft
                        var addFaceResult = await faceServiceClient.AddPersonFaceAsync(personGroupID, personID, uploadResult);

                        //train
                        await faceServiceClient.TrainPersonGroupAsync(personGroupID);

                        //create face in db
                        var persistedFaceId = addFaceResult.PersistedFaceId.ToString();
                        var face = new Models.Entities.Face
                        {
                            ImageURL = uploadResult,
                            PersistedFaceId = persistedFaceId,
                            PersonID = person.PersonId,
                            Active = true
                        };
                        await faceService.CreateAsync(face);

                    }
                }

                return RedirectToAction("UpdatePerson", "Face", new { id = person.PersonId });
            }
            else
            {
                return RedirectToAction("Login", "Account");
            }

        }

        public async Task<ActionResult> UpdateDeleteFace(HttpPostedFileBase fileModal, string persistedFaceId, string mode, PersonViewModel person)
        {

            var personService = this.Service<IPersonService>();
            var personGroupService = this.Service<IPersonGroupService>();
            var userService = this.Service<IAspNetUserService>();
            var faceService = this.Service<IFaceService>();

            var user = Util.getCurrentUser(this);
            var personGroupID = personGroupService.Get(user.Id).PersonGroupId;

            //Delete in Microsoft
            Guid personID = new Guid(person.PersonId);
            Guid persistedFaceID = new Guid(persistedFaceId);

            await faceServiceClient.DeletePersonFaceAsync(personGroupID, personID, persistedFaceID);

            //Delete in Database
            var deleteFace = faceService.GetActive(q => q.PersistedFaceId == persistedFaceId).FirstOrDefault();
            await faceService.DeactivateAsync(deleteFace);

            if (mode == "UpdateFace")
            {
                //Upload imageS
                if (fileModal != null)
                {

                    {
                        string pic = System.IO.Path.GetFileName(fileModal.FileName);
                        string path = System.IO.Path.Combine(
                                               Server.MapPath("~/images"), pic);
                        // file is uploaded
                        fileModal.SaveAs(path);

                        var uploadParams = new ImageUploadParams()
                        {
                            File = new FileDescription(path)
                        };

                        var uploadResult = cloudinary.Upload(uploadParams).Uri.ToString();

                        //create face in Microsoft
                        var addFaceResult = await faceServiceClient.AddPersonFaceAsync(personGroupID, personID, uploadResult);

                        //create face in db
                        var newPersistedFaceId = addFaceResult.PersistedFaceId.ToString();
                        var face = new Models.Entities.Face
                        {
                            ImageURL = uploadResult,
                            PersistedFaceId = newPersistedFaceId,
                            PersonID = person.PersonId,
                            Active = true
                        };
                        await faceService.CreateAsync(face);



                    }
                }
            }

            //train
            await faceServiceClient.TrainPersonGroupAsync(personGroupID);
            return RedirectToAction("UpdatePerson", "Face", new { id = person.PersonId });
        }

        public ActionResult ShowLogs()
        {
            var curUser = Util.getCurrentUser(this);
            var logService = this.Service<ILogService>();
            var personService = this.Service<IPersonService>();

            var logList = logService.GetActive(q => q.UserID.Equals(curUser.Id))
                        .ProjectTo<LogViewModel>(this.MapperConfig);

            var personList = personService.GetActive().ProjectTo<PersonViewModel>(this.MapperConfig);
            ViewBag.personList = personList;

            return this.View(logList);
        }

        public async Task<JsonResult> DeleteLog(int id)
        {
            var logService = this.Service<ILogService>();

            var logToDelete = logService.Get(id);
            if (User.Identity.IsAuthenticated)
            {
                await logService.DeactivateAsync(logToDelete);

                return Json(new { message = "Xóa thành công", success = true });
            }
            else
            {
                return Json(new { message = "Xóa thất bại", success = false });
            }
        }

        public async Task<JsonResult> UpdateLogToPerson(string personID, int logID)
        {
            var personService = this.Service<IPersonService>();
            var personGroupService = this.Service<IPersonGroupService>();
            var userService = this.Service<IAspNetUserService>();
            var faceService = this.Service<IFaceService>();
            var logService = this.Service<ILogService>();

            var user = Util.getCurrentUser(this);
            var personGroupID = personGroupService.Get(user.Id).PersonGroupId;

            var log = logService.Get(logID);

            Guid personId = new Guid(personID);

            //create face in Microsoft
            var addFaceResult = await faceServiceClient.AddPersonFaceAsync(personGroupID, personId, log.ImageURL);

            //create face in db
            var newPersistedFaceId = addFaceResult.PersistedFaceId.ToString();
            var face = new Models.Entities.Face
            {
                ImageURL = log.ImageURL,
                PersistedFaceId = newPersistedFaceId,
                PersonID = personID,
                Active = true
            };
            await faceService.CreateAsync(face);

            if (User.Identity.IsAuthenticated)
            {
                await logService.DeactivateAsync(log);

                return Json(new { message = "Cập nhật thành công", success = true });
            }
            else
            {
                return Json(new { message = "Cập nhật thất bại", success = false });
            }

        }

    }
}