using AAIV_WEB.Models.Entities;
using AAIV_WEB.Models.Entities.Services;
using AAIV_WEB.Models.ViewModels;
using AutoMapper.QueryableExtensions;
using CloudinaryDotNet;
using CloudinaryDotNet.Actions;
using Microsoft.ProjectOxford.Face;
using SkyWeb.DatVM.Mvc;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace AAIV_WEB.Areas.User.Controllers
{
    [Authorize(Roles = "User")]
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
            var personCount = 0;

            // Person Group
            var curUser = Util.getCurrentUser(this);

            if (curUser != null)
            {
                //Check quota
                personCount = personService.GetActive().Where(q => (q.PersonGroupId == curUser.Id)).Count();
                ViewBag.personCount = personCount;

                //var personList = personService.GetActive(q => q.PersonGroupId == curUser.Id)
                //    .ProjectTo<PersonEditViewModel>(this.MapperConfig)
                //    .ToList();

                var personList = personService.GetActive()
                    .Where(q => (q.PersonGroupId).Contains(curUser.Id))
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

                if (TempData["IsOver"] != null)
                {
                    ViewBag.IsOver = TempData["IsOver"].ToString();
                }
                return this.View(personList);
            }

            return RedirectToAction("Login", "Account");
        }

        [HttpGet]
        public ActionResult NewPerson()
        {
            var personService = this.Service<IPersonService>();
            var personGroupService = this.Service<IPersonGroupService>();
            var curUser = Util.getCurrentUser(this);
            if (null == curUser)
            {
                return RedirectToAction("Login", "Account", new { area = "" });
            }
            PersonEditViewModel model = (PersonEditViewModel)TempData["personEditViewModel"];

            var personGroup = personGroupService.Get(curUser.Id);
            if (personGroup != null)
            {
                var personCount = personService.GetActive(q => q.PersonGroupId.Equals(personGroup.PersonGroupId)).Count();
                if (personCount >= 10)
                {
                    TempData["IsOver"] = "isOver";
                    return this.RedirectToAction("Index","Face");
                }
                
            }

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


              //  }
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
                try
                {
                    var user = Util.getCurrentUser(this);

                    var deletePerson = personService.Get(id);

                    var personGroup = deletePerson.PersonGroupId;

                    //Delete in Microsoft
                    Guid personID = new Guid(deletePerson.PersonId);
                    await faceServiceClient.DeletePersonAsync(personGroup, personID);

                    //Delete in Database

                    await personService.DeactivateAsync(deletePerson);

                    foreach (var item in deletePerson.Faces)
                    {
                        await faceService.DeactivateAsync(item);
                    }

                    //Train Person
                    await faceServiceClient.TrainPersonGroupAsync(personGroup);

                    return Json(new { message = "Xóa thành công", success = true });
                }
                catch (Exception ex)
                {

                    throw;
                }
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

        public async Task<JsonResult> UpdatePersonInfo(PersonViewModel person)
        {
            var personService = this.Service<IPersonService>();
            var personGroupService = this.Service<IPersonGroupService>();
            var userService = this.Service<IAspNetUserService>();

            try
            {
                var user = Util.getCurrentUser(this);
                var personGroupID = person.PersonGroupId;

                //Update in Microsoft

                var updatePerson = personService.Get(person.PersonId);
                Guid personID = new Guid(updatePerson.PersonId);

                await faceServiceClient.UpdatePersonAsync(personGroupID, personID, person.Name, person.Description);

                //train
                await faceServiceClient.TrainPersonGroupAsync(personGroupID);

                //Update in Database
                updatePerson.Name = person.Name;
                updatePerson.Description = person.Description;
                personService.Save();

                return Json(new { message = "Cập nhật thành công", success = true });
            }
            catch (Exception ex)
            {
                return Json(new { message = "Cập nhật thất bại", success = false });
            }
        }

        [HttpPost]
        public async Task<JsonResult> AddPersonFace(PersonViewModel person, IEnumerable<HttpPostedFileBase> file)
        {
            var personService = this.Service<IPersonService>();
            var personGroupService = this.Service<IPersonGroupService>();
            var userService = this.Service<IAspNetUserService>();
            var faceService = this.Service<IFaceService>();

            try
            {
                var user = Util.getCurrentUser(this);
                //var personGroupID = personGroupService.Get(user.Id).PersonGroupId;
                var personGroupID = person.PersonGroupId;

                //Update in Microsoft

                var updatePerson = personService.Get(person.PersonId);
                Guid personID = new Guid(updatePerson.PersonId);

                //var personUpdateResult = faceServiceClient.UpdatePersonAsync(personGroupID, personID, person.Name, person.Description);

                //Update in Database
                //updatePerson.Name = person.Name;
                //updatePerson.Description = person.Description;
                //personService.Save();

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
                    //return Json(new { message = "Cập nhật thành công", success = true });
                }
                return Json(new { message = "Cập nhật thành công", success = true });
            }
            catch (Exception ex)
            {
                return Json(new { message = "Cập nhật thất bại", success = false });
            }

        }

        public async Task<ActionResult> UpdateDeleteFace(HttpPostedFileBase fileModal, string persistedFaceId, string mode, PersonViewModel person)
        {

            var personService = this.Service<IPersonService>();
            var personGroupService = this.Service<IPersonGroupService>();
            var userService = this.Service<IAspNetUserService>();
            var faceService = this.Service<IFaceService>();

            var user = Util.getCurrentUser(this);
            //var personGroupID = personGroupService.Get(user.Id).PersonGroupId;
            var personGroupID = person.PersonGroupId;

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

            var personList = personService.GetActive().Where(q => (q.PersonGroupId).Contains(curUser.Id)).ProjectTo<PersonEditViewModel>(this.MapperConfig)
                    .ToList();
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

            var personGroupID = (personService.GetActive(q => q.PersonId == personID).FirstOrDefault()).PersonGroupId;

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

        public async Task<ActionResult> CheckDuplicate()
        {
            var personGroupService = this.Service<IPersonGroupService>();
            var personService = this.Service<IPersonService>();
            var faceService = this.Service<IFaceService>();

            var currentUser = Util.getCurrentUser(this);
            var personGroup = personGroupService.Get(currentUser.Id);
            if (currentUser != null)
            {
                /*
                 * List of duplicate person. 
                 * Type: List<IGrouping<string, Person>> 
                 * => string: duplicate person name
                */
                var duplicatePersonList = personService.GetActive()
                    .Where(q => (q.PersonGroupId).Contains(currentUser.Id))
                    .GroupBy(q => q.Name.ToLower())
                    .Where(g => g.Count() > 1)
                    .ToList();

                var listPersonList = new ListPersonListViewModel();
                listPersonList.ListPersonList = new List<List<Person>>();
                /*
                 * Foreach duplicate case, order by the amount of faces of each person
                 * Get the person with the least amount of faces to be the prime person
                 * Use prime person faces to compare with others person by PersonId
                 * If found at least 1 match, add that person + faces to a list.
                 */
                foreach (var duplicate_case in duplicatePersonList)
                {

                    //order person list of each case by amount of faces
                    var personList = duplicate_case
                        .OrderBy(q => q.Faces.Count)
                        .ToList();
                    Person prime_person = null;

                    //check if prime person's face.count is not 0. 
                    //If face.count = 0 -> prime person = next person; personList remove that person from list
                    for (int i = 0; i < personList.Count; i++)
                    {
                        prime_person = personList.ElementAt(i);

                        if (prime_person.Faces.Count > 0)
                        {
                            break;  //found prime person, end loop
                        }

                        personList.RemoveAt(i); // person face.count = 0, remove person from list, continue loop
                    }

                    if (null != prime_person && prime_person.Faces.Count != 0)
                    {
                        /*
                         * Get the prime person face list to verify with other person
                         */
                        var prime_person_face_imgUrls = prime_person.Faces.Where(q => q.Active = true)
                            .Select(q => q.ImageURL)
                            .ToList();

                        var match_person_list = new List<Person>();
                        match_person_list.Add(prime_person);

                        /*
                         * use each face of prime person to verify with the other person. 
                         * If match found -> end loop + add that person to match_person_list
                         * else -> next face
                         */
                        for (int i = 0; i < prime_person_face_imgUrls.Count; i++)
                        {
                            if (personList.Count == 1)
                            {
                                break;
                            }

                            // detect to get face id from prime person image
                            var faceId = await faceServiceClient.DetectAsync(prime_person_face_imgUrls.ElementAt(i));
                            if (faceId.Length > 0)
                            {
                                for (int j = 1; j < personList.Count; j++)
                                {
                                    var result = await faceServiceClient.VerifyAsync(faceId[0].FaceId, personGroup.PersonGroupId, new Guid(personList.ElementAt(j).PersonId));
                                    if (result.IsIdentical)
                                    {
                                        match_person_list.Add(personList.ElementAt(j));
                                        personList.RemoveAt(j);
                                        j--;
                                    }
                                }
                            }
                        }
                        if (match_person_list.Count > 1)
                        {
                            listPersonList.ListPersonList.Add(match_person_list);
                        }
                    }
                }
                return this.View(listPersonList);
            }

            return RedirectToAction("Login", "Account", new { area = "" });
        }

        public async Task<ActionResult> CheckDuplicateByName()
        {
            var personGroupService = this.Service<IPersonGroupService>();
            var personService = this.Service<IPersonService>();
            var faceService = this.Service<IFaceService>();

            var currentUser = Util.getCurrentUser(this);
            var personGroup = personGroupService.Get(currentUser.Id);
            if (currentUser != null)
            {
                /*
                 * List of duplicate person. 
                 * Type: List<IGrouping<string, Person>> 
                 * => string: duplicate person name
                */
                var duplicatePersonList = personService.GetActive()
                    .Where(q => (q.PersonGroupId).Contains(currentUser.Id))
                    .GroupBy(q => q.Name.ToLower())
                    .Where(g => g.Count() > 1)
                    .ToList();

                var listPersonList = new ListPersonListViewModel();
                listPersonList.ListPersonList = new List<List<Person>>();

                foreach (var group in duplicatePersonList)
                {
                    var personList = group.OrderBy(q => q.Faces.Count).ToList();

                    //Filter persons have same face

                    //Create an isDuplicate array
                    bool[] isDuplicate = new bool[personList.Count];

                    //Get each person for finding duplicate
                    for (int i = 0; i < personList.Count; i++)
                    {
                        var prime_person = personList.ElementAt(i);

                        //Create a list of person which match with prime_person
                        var match_person_list = new List<Person>();
                        match_person_list.Add(prime_person);

                        //Check if person[i] is not duplicate yet and has >= 1 image
                        if ((!isDuplicate[i]) && (prime_person.Faces.Count > 0))
                        {
                            //Get all images of person[i]
                            var prime_person_image_list = prime_person.Faces.Where(q => q.Active = true)
                                                                            .Select(q => q.ImageURL).ToList();


                            //Get the rest persons to compare
                            for (int j = i + 1; j < personList.Count; j++)
                            {
                                var count = 0;
                                var person_to_compare = personList.ElementAt(j);
                                //Select each image of prime_person to compare with 
                                foreach (var image in prime_person_image_list)
                                {
                                    // detect to get face id from prime person image
                                    var faceId = await faceServiceClient.DetectAsync(image);

                                    if (faceId.Length > 0)
                                    {
                                        var result = await faceServiceClient.VerifyAsync(faceId[0].FaceId, personGroup.PersonGroupId, new Guid(personList.ElementAt(j).PersonId));
                                        var confident = result.Confidence;
                                        if (result.IsIdentical && confident > 0.7)
                                        {
                                            count++;
                                            //Check if more than 3 faces are identical
                                            if (count >= 3 || count >= (prime_person_image_list.Count / 2) + (prime_person_image_list.Count % 2 > 0 ? 1 : 0))
                                            {
                                                break;
                                            }
                                        }
                                    }
                                }
                                // Check if prime_person matchs with person[j] or not
                                if (count >= (prime_person_image_list.Count / 2) + (prime_person_image_list.Count % 2 > 0 ? 1 : 0) || count >= 3)
                                {
                                    //Matched
                                    //Add person[j] to match_list of current prime_person
                                    match_person_list.Add(personList.ElementAt(j));

                                    //Flag that person[j] is checked
                                    isDuplicate[j] = true;
                                }
                            }
                            // Check if prime_person has duplicate person or not
                            if (match_person_list.Count > 1)
                            {
                                //Add to listPersonList
                                listPersonList.ListPersonList.Add(match_person_list.OrderByDescending(q => q.Faces.Count).ToList());
                            }
                        }


                    }




                    //End of filter

                    //var list = group.OrderByDescending(q => q.Faces.Count).ToList();
                    //listPersonList.ListPersonList.Add(list);
                }

                return this.View(listPersonList);
            }
            return RedirectToAction("Login", "Account", new { area = "" });
        }

        public async Task<ActionResult> CheckDuplicateByFace()
        {
            var personGroupService = this.Service<IPersonGroupService>();
            var personService = this.Service<IPersonService>();
            var faceService = this.Service<IFaceService>();

            var currentUser = Util.getCurrentUser(this);
            var personGroup = personGroupService.Get(currentUser.Id);
            if (currentUser != null)
            {
                //Create a list contain list of duplicate persons
                var listPersonList = new ListPersonListViewModel();
                listPersonList.ListPersonList = new List<List<Person>>();

                //Get person list of current user -> Sort by number of face images
                var personList = personService.GetActive().Where(q => (q.PersonGroupId).Contains(currentUser.Id))
                                                          .OrderBy(q => q.Faces.Count).ToList();

                //Create an isDuplicate array
                bool[] isDuplicate = new bool[personList.Count];

                //Get each person for finding duplicate
                for (int i = 0; i < personList.Count; i++)
                {
                    var prime_person = personList.ElementAt(i);

                    //Create a list of person which match with prime_person
                    var match_person_list = new List<Person>();
                    match_person_list.Add(prime_person);

                    //Check if person[i] is not duplicate yet and has >= 1 image
                    if ((!isDuplicate[i]) && (prime_person.Faces.Count > 0))
                    {
                        //Get all images of person[i]
                        var prime_person_image_list = prime_person.Faces.Where(q => q.Active = true)
                                                                        .Select(q => q.ImageURL).ToList();

                        //Detect all images of person[i]
                        var prime_faceID_list = new List<Guid>();

                        foreach (var image in prime_person_image_list)
                        {
                            var detectResult = await faceServiceClient.DetectAsync(image);
                            prime_faceID_list.Add(detectResult.First().FaceId);
                        }

                        //Get the rest persons to compare
                        for (int j = i + 1; j < personList.Count; j++)
                        {
                            if (!isDuplicate[j])
                            {

                                var count = 0;
                                var person_to_compare = personList.ElementAt(j);

                                //Select each image of prime_person to compare with 
                                foreach (var faceID in prime_faceID_list)
                                {
                                    //// detect to get face id from prime person image
                                    //var faceId = await faceServiceClient.DetectAsync(image);

                                    if (faceID.ToString().Length > 0)
                                    {
                                        var result = await faceServiceClient.VerifyAsync(faceID, personGroup.PersonGroupId, new Guid(personList.ElementAt(j).PersonId));
                                        var confident = result.Confidence;
                                        if (result.IsIdentical && confident > 0.7)
                                        {
                                            count++;
                                            //Check if more than 3 faces are identical
                                            if (count >= 3 || count >= (prime_person_image_list.Count / 2) + (prime_person_image_list.Count % 2 > 0 ? 1 : 0))
                                            {
                                                break;
                                            }
                                        }

                                    }

                                }
                                // Check if prime_person matchs with person[j] or not
                                if (count >= (prime_person_image_list.Count / 2) + (prime_person_image_list.Count % 2 > 0 ? 1 : 0) || count >= 3)
                                {
                                    //Matched
                                    //Add person[j] to match_list of current prime_person
                                    match_person_list.Add(personList.ElementAt(j));

                                    //Flag that person[j] is checked
                                    isDuplicate[j] = true;
                                }
                            }
                            ////Sleep
                            //Thread.Sleep(5000);
                        }

                        // Check if prime_person has duplicate person or not
                        if (match_person_list.Count > 1)
                        {
                            //Add to listPersonList
                            listPersonList.ListPersonList.Add(match_person_list.OrderByDescending(q => q.Faces.Count).ToList());
                        }
                    }


                }

                return this.View(listPersonList);
            }
            return RedirectToAction("Login", "Account", new { area = "" });
        }

        public async Task<JsonResult> MergePerson(string personName, string personGroupId, List<string> SeletedPersonIDs)
        {
            var personService = this.Service<IPersonService>();
            var faceService = this.Service<IFaceService>();

            if (SeletedPersonIDs.Count == 1)
            {
                return Json(new
                {
                    success = false,
                    message = "Xin chọn nhiều hơn 1 người!"
                });
            }

            try
            {
                ////create new person in MS
                //var createPersonResult = await faceServiceClient.CreatePersonAsync(personGroupId, personName, "");

                ////add newly created person to DB
                //var newPerson = new Person
                //{
                //    PersonId = createPersonResult.PersonId.ToString(),
                //    Name = personName,
                //    PersonGroupId = personGroupId,
                //    Active = true,
                //};
                //await personService.CreateAsync(newPerson);


                //add face to person in MS
                var firstPersonID = new Guid(SeletedPersonIDs.First());

                //get all faces of all person
                for (int i = 1; i < SeletedPersonIDs.Count; i++)
                {
                    var id = SeletedPersonIDs.ElementAt(i);
                    var person = personService.Get(id);

                    //add faces of duplicate person to the new person + deactivate face in DB + add newly created face to DB
                    foreach (var face in person.Faces.ToList())
                    {
                        var addPersonFaceResult = await faceServiceClient.AddPersonFaceAsync(personGroupId, firstPersonID, face.ImageURL);
                        //Update PersonID of face to the firstPersonID
                        face.PersonID = firstPersonID.ToString();
                        await faceService.UpdateAsync(face);
                    }
                    //Delete duplicate person in MS
                    await faceServiceClient.DeletePersonAsync(personGroupId, new Guid(id));
                    //deactivate person in DB
                    await personService.DeactivateAsync(person);

                    //train person group
                    await faceServiceClient.TrainPersonGroupAsync(personGroupId);
                }
                return Json(new
                {
                    success = true,
                    message = "Thành công"
                });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = "Đã có lỗi xảy ra, vui lòng thử lại sau"
                });
            }
        }

        public async Task<JsonResult> MergePersonByFace(string personName, string personGroupId, List<string> SeletedPersonIDs)
        {
            var personService = this.Service<IPersonService>();
            var faceService = this.Service<IFaceService>();

            if (SeletedPersonIDs.Count == 1)
            {
                return Json(new
                {
                    success = false,
                    message = "Xin chọn nhiều hơn 1 người!"
                });
            }

            try
            {
                //Update Person name to new name
                //Update in Microsoft

                var updatePerson = personService.Get(SeletedPersonIDs.First());
                Guid personID = new Guid(updatePerson.PersonId);

                await faceServiceClient.UpdatePersonAsync(personGroupId, personID, personName, "");

                //Update in Database
                updatePerson.Name = personName;
                updatePerson.Description = "";
                personService.Save();


                //get all faces of all person
                for (int i = 1; i < SeletedPersonIDs.Count; i++)
                {
                    var id = SeletedPersonIDs.ElementAt(i);
                    var person = personService.Get(id);

                    //add faces of duplicate person to the new person + deactivate face in DB + add newly created face to DB
                    foreach (var face in person.Faces.ToList())
                    {
                        var addPersonFaceResult = await faceServiceClient.AddPersonFaceAsync(personGroupId, personID, face.ImageURL);
                        //Update PersonID of face to the firstPersonID
                        face.PersonID = personID.ToString();
                        await faceService.UpdateAsync(face);
                    }
                    //Delete duplicate person in MS
                    await faceServiceClient.DeletePersonAsync(personGroupId, new Guid(id));
                    //deactivate person in DB
                    await personService.DeactivateAsync(person);

                    //train person group
                    await faceServiceClient.TrainPersonGroupAsync(personGroupId);
                }
                return Json(new
                {
                    success = true,
                    message = "Thành công"
                });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = "Đã có lỗi xảy ra, vui lòng thử lại sau"
                });
            }
        }
    }


}
