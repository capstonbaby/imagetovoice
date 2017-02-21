using AutoMapper;
using CapstoneProject.WebAPI.Models.Entities;
using CapstoneProject.WebAPI.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace AAIV_WEB
{
    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            ApiEndPoint.Entry(this.AdditionalMapperConfig);
        }

        public void AdditionalMapperConfig(IMapperConfiguration config)
        {
            config.CreateMap<Person, PersonViewModel>();
            config.CreateMap<PersonViewModel, Person>();
        }
    }
}
