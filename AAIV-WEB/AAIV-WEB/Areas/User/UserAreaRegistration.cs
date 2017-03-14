using System.Web.Mvc;

namespace AAIV_WEB.Areas.User
{
    public class UserAreaRegistration : AreaRegistration 
    {
        public override string AreaName 
        {
            get 
            {
                return "User";
            }
        }

        public override void RegisterArea(AreaRegistrationContext context) 
        {
            context.MapRoute(
                "User_default",
                "User/{controller}/{action}/{id}",
                new { controller = "Face", action = "Index", id = UrlParameter.Optional }
            );
        }
    }
}