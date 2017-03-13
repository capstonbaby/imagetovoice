using CapstoneProject.WebAPI.Models;
using CapstoneProject.WebAPI.Models.Entities;
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
            var faceService = this.Service<IFaceService>();

            try
            {
                model.Active = true;
                await service.CreatePersonAsync(model);

                return Json(new
                {
                    success = true,
                    message = "Create Person Successfully"
                });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = true,
                    message = "Create Person Failed",
                    error = ex.Message
                });
            }
        }

        public async Task<JsonResult> AddPersonFace(FaceViewModel face)
        {
            try
            {
                var service = this.Service<IFaceService>();

                var entity = face.ToEntity();
                await service.CreateAsync(entity);

                return Json(new
                {
                    success = true,
                    message = "Add face successfully"
                });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = "Add face failed",
                    error = ex.Message
                });
            }
        }

        public async Task<JsonResult> UpdatePerson(PersonViewModel model)
        {
            try
            {
                var service = this.Service<IPersonService>();

                var entity = service.Get(q => q.PersonId == model.PersonId).FirstOrDefault();
                if(entity != null)
                {
                    entity.Name = model.Name;
                    entity.Description = model.Description;

                    await service.UpdateAsync(entity);

                    return Json(new
                    {
                        success = true,
                        message = "Update person successfully"
                    });
                }

                return Json(new
                {
                    success = false,
                    message = "Update Person Failed",
                    error = "Person not found"
                });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = "Update Person Failed",
                    error = ex.Message
                });
            }
        }

        public async Task<JsonResult> DeactiveLog(int logId)
        {
            try
            {
                var service = this.Service<ILogService>();
                var log = service.Get(logId);
                await service.DeactivateAsync(log);
                return Json(new { message = "Deactive Log File Successfully" });
            }
            catch (Exception ex)
            {
                return Json(new { message = "Deactive Log File Failled", error = ex.Message });
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

        public async Task<JsonResult> CreateLog(LogViewModel model, string userId)
        {
            var service = this.Service<ILogService>();

            model.CreatedDate = DateTime.Now;
            model.UserID = userId;

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
                name = q.Name
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

        //Object

        public async Task<JsonResult> CreateLogObject(LogObjectViewModel model, string userId)
        {
            var service = this.Service<ILogObjectService>();

            model.CreatedDate = DateTime.Now;
            model.UserID = userId;

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

        public string getDescriptionConcept(int conceptid)
        {
            var service = this.Service<IConceptService>();
            var model = service.GetActive(q => q.ConceptId.Equals(conceptid)).First();

            return model.ConceptDescription;
        }


    }
}