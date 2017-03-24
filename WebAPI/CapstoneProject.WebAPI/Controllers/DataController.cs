using AutoMapper.QueryableExtensions;
using CapstoneProject.WebAPI.Common;
using CapstoneProject.WebAPI.Models;
using CapstoneProject.WebAPI.Models.Entities;
using CapstoneProject.WebAPI.Models.Entities.Services;
using CapstoneProject.WebAPI.Models.ViewModels;
using Microsoft.ProjectOxford.Face;
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
        public JsonResult GetPeopleInGroup(string personGroupId)
        {
            try
            {
                var service = this.Service<IPersonService>();
                var faceService = this.Service<IFaceService>();

                var personList = service.GetActive(q => q.PersonGroupId.Equals(personGroupId))
                    .ProjectTo<PersonEditViewModel>(this.MapperConfig)
                    .ToList();
                foreach (var person in personList)
                {
                    var faces = faceService.GetActive(q => q.PersonID.Equals(person.PersonId))
                        .ProjectTo<FaceViewModel>(this.MapperConfig)
                        .ToList();
                    person.Faces = faces;
                }

                return Json(new
                {
                    success = true,
                    data = personList.Select(q => new
                    {
                        personid = q.PersonId,
                        name = q.Name,
                        userData = q.Description,
                        faces = q.Faces.Select(f => new
                        {
                            persistedFaceId = f.PersistedFaceId,
                            imageUrl = f.ImageURL
                        }),
                    }),
                });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = "Get People in group failed",
                    error = ex.Message,
                });
            }
        }

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
                    success = false,
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
                var faceService = this.Service<IFaceService>();
                var faceServiceClient = Assets.client;

                var entity = service.Get(model.PersonId);
                if (entity != null)
                {
                    entity.Name = model.Name;
                    entity.Description = model.Description;

                    //delete all face of person in database and Microsoft
                    var personFaces = faceService.GetActive(q => q.PersonID.Equals(model.PersonId)).ToList();
                    foreach (var face in personFaces)
                    {
                        await faceService.DeleteAsync(face);
                        await faceServiceClient.DeletePersonFaceAsync(model.PersonGroupId, new Guid(model.PersonId), new Guid(face.PersistedFaceId));
                    }

                    //update person in database
                    await service.UpdateAsync(entity);

                    //update person in microsoft
                    await faceServiceClient.UpdatePersonAsync(model.PersonGroupId, new Guid(model.PersonId), model.Name, model.Description);

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

        public async Task<JsonResult> DeletePerson(string personId)
        {
            var personService = this.Service<IPersonService>();
            var faceService = this.Service<IFaceService>();
            var faceServiceClient = Assets.client;

            try
            {
                //Deactive Person in DB
                var person = personService.Get(personId);
                await personService.DeactivateAsync(person);

                var faceList = person.Faces.ToList();
                foreach (var face in faceList)
                {
                    await faceService.DeactivateAsync(face);
                }

                //Delete person in MCS
                await faceServiceClient.DeletePersonAsync(person.PersonGroupId, new Guid(personId));
                //Train person group after delete
                await faceServiceClient.TrainPersonGroupAsync(person.PersonGroupId);

                return Json(new
                {
                    success = true,
                    message = "Delete person successfully"
                });
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = "Delete person failed",
                    error = ex.Message
                });
            }
        }

        public async Task<JsonResult> GetPersonInfo(List<string> personIds)
        {
            try
            {
                var service = this.Service<IPersonService>();
                var userService = this.Service<IAspNetUserService>();

                var result = new List<Person>();

                if (personIds != null)
                {
                    foreach (var personId in personIds)
                    {
                        var person = service.Get(personId);
                        if (person != null)
                        {
                            result.Add(person);
                        }
                    }

                    return Json(new
                    {
                        success = true,
                        message = "Get person info successfully",
                        data = result.Select(q => new
                        {
                            personid = q.PersonId,
                            name = q.Name,
                            userdata = q.Description
                        })
                    });
                }
                else
                {
                    return Json(new
                    {
                        success = false,
                        message = "person not found",
                    });
                }
            }
            catch (Exception ex)
            {
                return Json(new
                {
                    success = false,
                    message = "Update detect count failed",
                    error = ex.Message
                });
            }
        }


        //Log
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

        public async Task<JsonResult> CreateLog(LogViewModel model, string userId, string personGroupId)
        {
            var service = this.Service<ILogService>();
            var personService = this.Service<IPersonService>();
            var faceService = this.Service<IFaceService>();
            var faceServiceClient = Assets.client;

            model.CreatedDate = DateTime.Now;
            model.UserID = userId;

            model.Active = true;

            var entity = model.ToEntity();

            try
            {
                //create log in DB
                await service.CreateAsync(entity);

                //check person name in DB
                var person = personService.GetActive(q => q.Name.ToLower().Equals(model.Name.ToLower())).FirstOrDefault();

                //person available in DB => add face in log to person
                if (null != person)
                {
                    //in MS
                    var addPersonFaceResult = await faceServiceClient.AddPersonFaceAsync(personGroupId, new Guid(person.PersonId), model.ImageURL);

                    //in DB
                    var face = new Face
                    {
                        PersistedFaceId = addPersonFaceResult.PersistedFaceId.ToString(),
                        ImageURL = model.ImageURL,
                        PersonID = person.PersonId,
                        Active = true
                    };
                    await faceService.CreateAsync(face);
                }
                else //no person match in the DB, create new person + add face in MS & DB
                {
                    //create new person + add person face in MS
                    var createPersonResult = await faceServiceClient.CreatePersonAsync(personGroupId, model.Name, "");
                    var addPersonFaceResult = await faceServiceClient.AddPersonFaceAsync(personGroupId, createPersonResult.PersonId, model.ImageURL);

                    //create person + face in DB
                    var newPerson = new Person
                    {
                        PersonId = createPersonResult.PersonId.ToString(),
                        PersonGroupId = personGroupId,
                        Name = model.Name,
                        Active = true,
                    };
                    await personService.CreateAsync(newPerson);

                    var newPersonFace = new Face
                    {
                        PersistedFaceId = addPersonFaceResult.PersistedFaceId.ToString(),
                        PersonID = newPerson.PersonId,
                        ImageURL = model.ImageURL,
                        Active = true
                    };
                    await faceService.CreateAsync(newPersonFace);
                }

                //train person group
                await faceServiceClient.TrainPersonGroupAsync(personGroupId);

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