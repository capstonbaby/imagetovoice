using Microsoft.Owin;
using Owin;

[assembly: OwinStartupAttribute(typeof(AAIV_WEB.Startup))]
namespace AAIV_WEB
{
    public partial class Startup
    {
        public void Configuration(IAppBuilder app)
        {
            ConfigureAuth(app);
            app.MapSignalR();
        }
    }
}
