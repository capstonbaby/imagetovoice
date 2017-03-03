using AAIV_WEB.Models.Entities;
using AAIV_WEB.Models.Entities.Services;
using AAIV_WEB.Models.ViewModels;
using AutoMapper.QueryableExtensions;
using Microsoft.AspNet.Identity;
using Microsoft.ProjectOxford.Face;
using SkyWeb.DatVM.Mvc;
using System;
using System.Collections.Generic;
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

        // GET: Face
        public ActionResult Index()
        {
            var service = this.Service<IPersonService>();

            var entity = service.GetActive(q => q.PersonGroupID == 2);

            var model = entity.ProjectTo<PersonViewModel>(this.MapperConfig);

            return View(model);
        }

        public async Task<ActionResult> NewPerson()
        {

            var userid = User.Identity.GetUserId();

            var aspNetUserService = this.Service<IAspNetUserService>();
            var personGroupService = this.Service<IPersonGroupService>();
            var personService = this.Service<IPersonService>();

            var userEntity = aspNetUserService.Get(userid);
            var userModel = new AspNetUserViewModel(userEntity);

            var persongroupId = userModel.PersonGroupId;
            var personGroup = personGroupService.Get(persongroupId);



            var createPersonResult = await faceServiceClient.CreatePersonAsync(personGroup.PersonGroupName, "Thằng Mới");
            var personID = createPersonResult.PersonId.ToString();

            var newPerson = new Person
            {
                PersonId = personID,
                Name = "Thằng mới",
                Description = "",
                PersonGroupID = persongroupId.Value,
                Active = true
            };

            try
            {
                await personService.CreateAsync(newPerson);
            }
            catch (Exception ex)
            {

            }

            return RedirectToAction("Index", "Face");
        }
    }
}