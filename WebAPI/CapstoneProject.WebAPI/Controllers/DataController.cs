﻿using CapstoneProject.WebAPI.Models.Entities;
using CapstoneProject.WebAPI.Models.Entities.Services;
using CapstoneProject.WebAPI.Models.ViewModels;
using Newtonsoft.Json;
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
                return Json(new { message = "Create Person Successfully" });
            }
            catch (Exception ex)
            {
                return Json(new { message = "Create Person Failed", error = ex });
            }
        }

        public JsonResult GetAllPersonFromPersonGroup(int personGroupId)
        {
            var service = this.Service<IPersonService>();
            var model = service.GetActive(q => q.PersonGroupID == personGroupId);

            return Json(model.Select(q => new
            {
                id = q.ID,
                personId = q.PersonGroupID,
                name = q.Name,
                description = q.Description,
            }));
        }

        public async Task<JsonResult> CreateLog(LogViewModel model)
        {
            var service = this.Service<ILogService>();

            model.CreatedDate = DateTime.Now;
            model.UserID = "36a65953-8d12-46cd-9500-fc33e9123aaf";

            model.Active = true;

            var entity = model.ToEntity();

            try
            {
                await service.CreateAsync(entity);
                return Json(new
                {
                    message = "Create Log Successfully",
                    response = new
                    {
                        logId = entity.ID,
                        createdate = entity.CreatedDate.ToString("dd/mm/yyyy hh:mm:ss")
                    }
                });

            }
            catch (Exception ex)
            {
                return Json(new { message = "Create Log Failed", error = ex.Message });
            }
        }

        public JsonResult GetAllLogFromUser(string userId)
        {
            var service = this.Service<ILogService>();
            var model = service.GetActive(q => q.UserID.Equals(userId)).ToList();

            return Json(model.Select(q => new
            {
                id = q.ID,
                imgUrl = q.ImageURL,
                createdate = q.CreatedDate.ToString("dd/mm/yyyy hh:mm:ss"),
            }));
        }

        public JsonResult GetLogFromId(int id)
        {
            var service = this.Service<ILogService>();

            var model = service.Get(id);

            return Json(new
            {
                id = model.ID,
                imgUrl = model.ImageURL,
            });
        }
    }
}