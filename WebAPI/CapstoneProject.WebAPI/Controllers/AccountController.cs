using CapstoneProject.WebAPI.Models;
using CapstoneProject.WebAPI.Models.Entities;
using CapstoneProject.WebAPI.Models.Entities.Services;
using Microsoft.AspNet.Identity.Owin;
using Microsoft.ProjectOxford.Face;
using SkyWeb.DatVM.Mvc;
using SkyWeb.DatVM.Mvc.Autofac;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;

namespace CapstoneProject.WebAPI.Controllers
{
    public class AccountController : BaseController
    {
        private static string API_KEY = "3fafcdb48bdc4ef6b20d61524bfac93c";

        private readonly FaceServiceClient faceServiceClient = new FaceServiceClient(API_KEY);

        private ApplicationSignInManager _signInManager;
        private ApplicationUserManager _userManager;

        public AccountController()
        {
        }

        public AccountController(ApplicationUserManager userManager, ApplicationSignInManager signInManager)
        {
            UserManager = userManager;
            SignInManager = signInManager;
        }

        public ApplicationSignInManager SignInManager
        {
            get
            {
                return _signInManager ?? HttpContext.GetOwinContext().Get<ApplicationSignInManager>();
            }
            private set
            {
                _signInManager = value;
            }
        }

        public ApplicationUserManager UserManager
        {
            get
            {
                return _userManager ?? HttpContext.GetOwinContext().GetUserManager<ApplicationUserManager>();
            }
            private set
            {
                _userManager = value;
            }
        }

        public async Task<JsonResult> Login(LoginViewModel model)
        {
            try
            {
                var result = await SignInManager.PasswordSignInAsync(model.Email, model.Password, true, shouldLockout: false);
                var userService = this.Service<IAspNetUserService>();
                var personGroupService = this.Service<IPersonGroupService>();

                switch (result)
                {
                    case SignInStatus.Success:
                        {
                            var user = userService.Get(q => q.Email.Equals(model.Email)).FirstOrDefault();
                            if (user.Active)
                            {
                                var personGroupList = personGroupService.GetActive(q => q.UserId.Equals(user.Id)).ToList();
                                var popular_groupId = personGroupList.Where(q => q.Type == 1).FirstOrDefault().PersonGroupId;
                                var normal_groupId = personGroupList.Where(q => q.Type == 2).FirstOrDefault().PersonGroupId;
                                var fresh_groupId = personGroupList.Where(q => q.Type == 3).FirstOrDefault().PersonGroupId;

                                return Json(new
                                {
                                    success = true,
                                    message = "Login Successfully",
                                    data = new
                                    {
                                        username = user.UserName,
                                        popular_personGroupId = popular_groupId,
                                        normal_personGroupId = normal_groupId,
                                        fresh_personGroupId = fresh_groupId,
                                        userId = user.Id
                                    },
                                });
                            }
                            else
                            {
                                return Json(new
                                {
                                    success = false,
                                    message = "Tài Khoản đã bị khóa",
                                });
                            }
                            
                        }
                    case SignInStatus.Failure:
                        {
                            return Json(new
                            {
                                success = false,
                                message = "Đăng nhập thất bại",
                            });
                        }
                    default:
                        return Json(new
                        {
                            success = false,
                            message = "Đăng nhập thất bại",
                        });
                }
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = "Đăng nhập thất bại",
                    error = ex.Message
                });
            }
        }

        public async Task<JsonResult> Register(RegisterViewModel model)
        {
            var userService = this.Service<IAspNetUserService>();
            var personGroupService = this.Service<IPersonGroupService>();

            if (ModelState.IsValid)
            {
                if (!model.Password.Equals(model.ConfirmPassword))
                {
                    return Json(new
                    {
                        success = false,
                        message = "Register Failled",
                        error = "Confirm Password miss matched"
                    });
                }
                try
                {
                    var user = new ApplicationUser { UserName = model.Email, Email = model.Email };
                    var result = await UserManager.CreateAsync(user, model.Password);
                    if (result.Succeeded)
                    {
                        try
                        {
                            var userEntity = userService.Get(user.Id);
                            if (userEntity != null)
                            {

                                //create person group in MCS
                                await faceServiceClient.CreatePersonGroupAsync(user.Id, user.UserName, null);

                                //create person group in Db
                                await personGroupService.CreateAsync(new PersonGroup
                                {
                                    PersonGroupId = user.Id,
                                    PersonGroupName = user.UserName,
                                    Active = true,
                                });

                                return Json(new
                                {
                                    success = true,
                                    message = "Register Successfully"
                                });
                            }

                        }
                        //add person group failled
                        catch (Exception ex)
                        {
                            await UserManager.DeleteAsync(user);
                            return Json(new
                            {
                                success = false,
                                message = "Register Failled",
                                error = ex.Message
                            });
                        }
                    }
                    //create user result not success
                    return Json(new
                    {
                        success = false,
                        message = "Register Failled",
                        error = result.Errors.FirstOrDefault()
                    });
                }
                // Create User Failled
                catch (Exception ex)
                {
                    return Json(new
                    {
                        success = false,
                        message = "Register Failled",
                        error = ex.Message
                    });
                }
                
            }

            // If we got this far, something failed, redisplay form
            return Json(new
            {
                success = false,
                message = "Register Failled",
                error = "Model state is invalid"
            });
        }
    }
}