using AAIV_WEB.Models.Entities.Services;
using AAIV_WEB.Models.ViewModels;
using AutoMapper.QueryableExtensions;
using SkyWeb.DatVM.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AAIV_WEB.Controllers
{
    
    public class HomeController : BaseController
    {
        public ActionResult Index()
        {
            var service = this.Service<IPersonService>();
            var model = service.GetActive().ProjectTo<PersonViewModel>(this.MapperConfig);
            return View(model);
        }
    }
}