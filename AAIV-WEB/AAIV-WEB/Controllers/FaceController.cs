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
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace AAIV_WEB.Controllers
{
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
            var curUser = Utils.getCurrentUser(this);
            if(curUser != null)
            {
                var entity = service.GetActive(q => q.PersonGroupId == curUser.PersonGroupId).FirstOrDefault();
                var personList = personService.GetActive(q => q.PersonGroupID == entity.PersonGroupId)
                    .ProjectTo<PersonEditViewModel>(this.MapperConfig)
                    .ToList();

                foreach (var person in personList)
                {
                    var imgUrl = faceService.GetActive(q => q.PersonID == person.ID).First().ImageURL;
                    person.PersonAvatar = imgUrl;
                }

                return this.View(personList);
            }

            return RedirectToAction("Login", "Account");
        }

        [HttpGet]
        public ActionResult NewPerson()
        {
            var person = new PersonViewModel();
            return View(person);
        }

        [HttpPost]
        public async Task<ActionResult> NewPerson(PersonViewModel person, IEnumerable<HttpPostedFileBase> file)
        {
            var personService = this.Service<IPersonService>();
            var personGroupService = this.Service<IPersonGroupService>();
            var userService = this.Service<IAspNetUserService>();
            var faceService = this.Service<IFaceService>();

            if (User.Identity.IsAuthenticated)
            {
                try
                {
                    var userId = User.Identity.GetUserId();
                    var user = userService.Get(userId);
                    var personGroup = user.PersonGroup;

                    //create in Microsoft
                    var personCreateResult = await faceServiceClient.CreatePersonAsync(personGroup.PersonGroupName, person.Name, person.Description);

                    //create in database
                    var newPerson = new Person
                    {
                        Name = person.Name,
                        Description = person.Description,
                        PersonGroupID = personGroup.ID,
                        Active = true,
                        PersonId = personCreateResult.PersonId.ToString()
                    };
                    await personService.CreateAsync(newPerson);


                    if (file != null)
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
                            var addFaceResult = await faceServiceClient.AddPersonFaceAsync(personGroup.PersonGroupName, personCreateResult.PersonId, uploadResult);

                            //create face in db
                            var persistedFaceId = addFaceResult.PersistedFaceId.ToString();
                            var face = new Models.Entities.Face
                            {
                                ImageURL = uploadResult,
                                PersistedFaceId = persistedFaceId,
                                PersonID = newPerson.ID,
                                Active = true
                            };
                            await faceService.CreateAsync(face);

                        }
                    }
                    // after successfully uploading redirect the user
                    return RedirectToAction("Index", "Face");
                }
                catch (Exception ex)
                {

                    throw;
                }
            }
            else
            {
                return RedirectToAction("Login", "Account");
            }
        }

        public async Task<JsonResult> DeletePerson(int id)
        {
            var personService = this.Service<IPersonService>();
            var personGroupService = this.Service<IPersonGroupService>();
            var userService = this.Service<IAspNetUserService>();
            var faceService = this.Service<IFaceService>();

            if (User.Identity.IsAuthenticated)
            {
                var userId = User.Identity.GetUserId();
                var user = userService.Get(userId);
                var personGroup = user.PersonGroup;

                var deletePerson = personService.Get(id);
                //Delete in Microsoft
                Guid personID = new Guid(deletePerson.PersonId);
                await faceServiceClient.DeletePersonAsync(personGroup.PersonGroupName, personID);

                //Delete in Database

                await personService.DeactivateAsync(deletePerson);

                var faces = faceService.GetActive(q => q.PersonID == deletePerson.ID).ToList();
                foreach (var item in faces)
                {
                    await faceService.DeactivateAsync(item);
                }


                return Json(new { message = "Xóa thành công", success = true });
            }
            else
            {
                return Json(new { message = "Xóa thất bại", success = false });
            }
            
        }

        public ActionResult UpdatePerson(int id)
        {
            var personService = this.Service<IPersonService>();
            var personGroupService = this.Service<IPersonGroupService>();
            var userService = this.Service<IAspNetUserService>();
            var faceService = this.Service<IFaceService>();

            var person = personService.Get(id);
            var faceList = faceService.GetActive(q => q.PersonID == id)
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
                var userId = User.Identity.GetUserId();
                var user = userService.Get(userId);
                var personGroupID = user.PersonGroup.PersonGroupName;

                //Update in Microsoft

                var updatePerson = personService.Get(person.ID);
                Guid personID = new Guid(updatePerson.PersonId);

                var personUpdateResult = faceServiceClient.UpdatePersonAsync(personGroupID,personID,person.Name,person.Description);

                //Update in Database
                
                
                updatePerson.Name = person.Name;
                updatePerson.Description = person.Description;
                personService.Save();

                //Upload imageS
                if (file != null)
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

                        //create face in db
                        var persistedFaceId = addFaceResult.PersistedFaceId.ToString();
                        var face = new Models.Entities.Face
                        {
                            ImageURL = uploadResult,
                            PersistedFaceId = persistedFaceId,
                            PersonID = person.ID,
                            Active = true
                        };
                        await faceService.CreateAsync(face);

                    }
                }


                    return RedirectToAction("Index", "Face");
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

            var userId = User.Identity.GetUserId();
            var user = userService.Get(userId);
            var personGroupID = user.PersonGroup.PersonGroupName;

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
                                PersonID = person.ID,
                                Active = true
                            };
                            await faceService.CreateAsync(face);

                        }
                    }
                }

            return RedirectToAction("Index", "Face");
        }
    }
}