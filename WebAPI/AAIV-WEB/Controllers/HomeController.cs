using CapstoneProject.WebAPI.Models.Entities.Services;
using SkyWeb.DatVM.Mvc;
using System.Web.Mvc;
using AutoMapper.QueryableExtensions;
using CapstoneProject.WebAPI.Models.ViewModels;

namespace AAIV_WEB.Controllers
{
    public class HomeController : BaseController
    {
        public ActionResult Index()
        {
            var service = this.Service<IPersonService>();
            var model = service.GetAllPerson().ProjectTo<PersonViewModel>(this.MapperConfig);
            return View(model);
        }

        public ActionResult About()
        {
            ViewBag.Message = "Your application description page.";

            return View();
        }

        public ActionResult Contact()
        {
            ViewBag.Message = "Your contact page.";

            return View();
        }
    }
}