using CapstoneProject.WebAPI.Models.Entities;
using CapstoneProject.WebAPI.Models.Entities.Services;
using CapstoneProject.WebAPI.Models.ViewModels;
using SkyWeb.DatVM.Mvc;
using System;
using System.Collections.Generic;
using System.Data.Entity.Infrastructure;
using System.Linq;
using System.Net.Http.Formatting;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace CapstoneProject.WebAPI.Controllers
{
    public class DataController : BaseController
    {
        public async Task<JsonResult> CreatePerson(PersonViewModel model)
        {
            var service = this.Service<IPersonService>();

            try
            {
                await service.CreatePersonAsync(model);
                return Json(new { message = "Create Person Successful"});
            }
            catch (Exception ex)
            {
                return Json(new { message = "Create Person Failed", error = ex.Message });
            }
        }

    }
}