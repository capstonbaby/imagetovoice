using AAIV_WEB;
using AAIV_WEB.Areas.Admin.Models;
using AAIV_WEB.Models.Entities.Services;
using AAIV_WEB.Models.ViewModels;
using AutoMapper.QueryableExtensions;
using Microsoft.AspNet.Identity;
using SkyWeb.DatVM.Mvc;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace AAIV_WEB.Areas.Admin.Controllers
{
    [Authorize(Roles = "Admin")]
    public class UserController : BaseController
    {
        // GET: Admin/User
        public ActionResult Index()
        {
            var service = this.Service<IAspNetUserService>();
            var personGroupService = this.Service<IPersonGroupService>();

            //get all user with role User
            var userlist = service.Get()
                .Where(q => q.AspNetRoles.Any(a => a.Name.Equals("User")))
                .ProjectTo<AspNetUserEditViewModel>(this.MapperConfig)
                .ToList();
            return View(userlist);
        }
        [HttpPost]
        public async Task<ActionResult> DeactivateAccounts(AspNetUserEditViewModel model)
        {
            var service = this.Service<IAspNetUserService>();

            //get all accounts with role User
            var userlist = service.Get()
                .Where(q => q.AspNetRoles.Any(a => a.Name.Equals("User")))
                .ToList();

            //all Accounts is deactivated
            if (model.SeletedUsers == null)
            {
                foreach (var user in userlist)
                {
                    await service.DeactivateAsync(user);
                }
                return RedirectToAction("index");
            }

            foreach (var user in userlist)
            {
                await service.ActivateAsync(user);
            }
            //get user list that is NOT in the returned Selected Values (selected values means active users)
            var deactiveUserList = userlist
                .Where(l1 => !model.SeletedUsers.Any(q => q.Equals(l1.Id)))
                .ToList();

            foreach (var user in deactiveUserList)
            {
                await service.DeactivateAsync(user);
            }

            return RedirectToAction("index");
        }
    }
}