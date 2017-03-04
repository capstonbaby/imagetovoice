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
            var service = this.Service<IPersonService>();

            var entity = service.GetActive(q => q.PersonGroupID == 2);

            var model = entity.ProjectTo<PersonViewModel>(this.MapperConfig);

            return View(model);
        }

        [HttpGet]
        public async Task<ActionResult> NewPerson()
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
            else
            {
                return RedirectToAction("Login", "Account");
            }
        }
    }
}