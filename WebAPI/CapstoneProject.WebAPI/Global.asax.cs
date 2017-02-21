using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;
using System.Web.Http;
using AutoMapper;
using CapstoneProject.WebAPI.Models.Entities;
using CapstoneProject.WebAPI.Models.ViewModels;

namespace CapstoneProject.WebAPI
{
    public class Global : HttpApplication
    {
        void Application_Start(object sender, EventArgs e)
        {
            // Code that runs on application startup
            AreaRegistration.RegisterAllAreas();
            GlobalConfiguration.Configure(WebApiConfig.Register);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            ApiEndPoint.Entry(this.AdditionalMapperConfig);
        }

        public void AdditionalMapperConfig(IMapperConfiguration config)
        {
            config.CreateMap<Person, PersonViewModel>();
            config.CreateMap<PersonViewModel, Person>();
        }
    }
}