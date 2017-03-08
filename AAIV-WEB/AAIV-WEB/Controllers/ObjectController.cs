using AAIV_WEB.Models.Entities;
using AAIV_WEB.Models.Entities.Services;
using AAIV_WEB.Models.ViewModels;
using AAIV_WEB.Utils;
using AutoMapper.QueryableExtensions;
using CloudinaryDotNet;
using CloudinaryDotNet.Actions;
using Newtonsoft.Json.Linq;
using SkyWeb.DatVM.Mvc;
using System;
using System.Collections.Generic;
using System.Data.Entity.Validation;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace AAIV_WEB.Controllers
{
    public class ObjectController : BaseController
    {
        public ActionResult Index()
        {
            var service = this.Service<ILogObjectService>();

            var model = service.GetActive().ProjectTo<LogObjectViewModel>(this.MapperConfig);

            return View(model);
        }
        public ActionResult createObject()
        {
            var conceptService = this.Service<IConceptService>();
            var conceptList = conceptService.GetActive().ProjectTo<ConceptViewModel>(this.MapperConfig);

            return View(conceptList);
        }
        public ActionResult createNewObject(string conceptName, string conceptDes, IEnumerable<HttpPostedFileBase> fileUpload)
        {
            Account account = new Account("trains", "445514799582782", "NIIYkOkkMtT_2uAtf2R3WWuEvLk");
            Cloudinary cloudinary = new Cloudinary(account);

            var conceptService = this.Service<IConceptService>();
            var addConcept = new Concept
            {
                ConceptName = conceptName,
                ConceptDescription = conceptDes,
                CreateDate = DateTime.Now,
                Active = true
            };
            try
            {
                conceptService.Create(addConcept);
            }
            catch (DbEntityValidationException e)
            {
            }

            var concepts = conceptService.Get(q => q.ConceptName.Equals(conceptName)).FirstOrDefault();
            int conceptid = concepts.ConceptId;

            string URI = @"http://127.0.0.1:5000/clarifai/v1.0/createconcept" + "?id=" + conceptid;
            var response = HttpClientHelper.Get(URI);

            if (fileUpload != null)
            {
                foreach (var image in fileUpload)
                {
                    byte[] imageSize = new byte[image.ContentLength];
                    image.InputStream.Read(imageSize, 0, (int)image.ContentLength);

                    var name = image.FileName;
                    var size = image.ContentLength;
                    var path = Server.MapPath(".") + "//uploads//" + name;
                    image.SaveAs(path);
                    var uploadParams = new ImageUploadParams()
                    {
                        File = new FileDescription(path)
                    };
                    var uploadResult = cloudinary.Upload(uploadParams);
                    var url = uploadResult.Uri.AbsoluteUri;

                    string URI1 = @"http://127.0.0.1:5000/clarifai/v1.0/createimage" + "?url=" + url + "&conceptid=" + conceptid;
                    var response1 = HttpClientHelper.Get(URI1);

                    string URI2 = @"http://127.0.0.1:5000/clarifai/v1.0/trainmodel";
                    var response2 = HttpClientHelper.Get(URI2);

                    var picService = this.Service<IPictureService>();
                    var logObjectService = this.Service<ILogObjectService>();

                    var addImage = new Picture
                    {
                        ConceptId = conceptid,
                        ImageURL = url,
                        Description = conceptDes
                    };
                    try
                    {
                        picService.Create(addImage);
                    }
                    catch (DbEntityValidationException e)
                    {
                    }
                }
            }
            return RedirectToAction("Index", "Object");//mới có tên action ah, tên controller đâu ? RedirectToAction(tên action, tên control)
        }
        public ActionResult addObject(int logId)
        {
            var service = this.Service<ILogObjectService>();
            var entity = service.Get(logId);

            var conceptService = this.Service<IConceptService>();
            var concepts = conceptService.GetActive().ProjectTo<ConceptViewModel>(this.MapperConfig);

            var model = new BigViewModel
            {
                ImageURL = entity.ImageURL,
                LogObjectViewModel = new LogObjectViewModel(entity),
                ConceptList = concepts,
                LogId = logId
            };
            return View(model);
        }
        public ActionResult addImageConcept(string ImageUrl, int? ConceptId, int logId)
        {
            if (ConceptId != null)
            {
                int conceptid = ConceptId.Value;

                string URI1 = @"http://127.0.0.1:5000/clarifai/v1.0/createimage" + "?url=" + ImageUrl + "&conceptid=" + conceptid;
                var response1 = HttpClientHelper.Get(URI1);

                string URI2 = @"http://127.0.0.1:5000/clarifai/v1.0/trainmodel";
                var response2 = HttpClientHelper.Get(URI2);

                var picService = this.Service<IPictureService>();
                var logObjectService = this.Service<ILogObjectService>();
                var entity = logObjectService.Get(logId);
                var conceptService = this.Service<IConceptService>();
                var conceptDes = conceptService.Get(q => q.ConceptId.Equals(conceptid)).FirstOrDefault();

                var addImage = new Picture
                {
                    ConceptId = conceptid,
                    ImageURL = ImageUrl,
                    Description = conceptDes.ConceptDescription
                };

                try
                {
                    picService.Create(addImage);
                    logObjectService.Deactivate(entity);
                }
                catch (DbEntityValidationException e)
                {
                }
                return RedirectToAction("Index", "Object");
            }
            return RedirectToAction("addNewConcept", "Object", new { imgUrl = ImageUrl, logId = logId });

        }
        public ActionResult addNewConcept(string imgUrl, int logId)
        {
            var model = new BigViewModel
            {
                ImageURL = imgUrl,
                LogObjectViewModel = null,
                ConceptList = null,
                LogId = logId
            };
            return View(model);
        }
        public ActionResult addImageNewConcept(string conceptName, string conceptDes, string imageUrl, int logId)
        {
            var conceptService = this.Service<IConceptService>();
            var addConcept = new Concept
            {
                ConceptName = conceptName,
                ConceptDescription = conceptDes,
                CreateDate = DateTime.Now,
                Active = false
            };
            try
            {
                conceptService.Create(addConcept);
            }
            catch (DbEntityValidationException e)
            {
            }

            var concepts = conceptService.Get(q => q.ConceptName.Equals(conceptName)).FirstOrDefault();
            int conceptid = concepts.ConceptId;

            string URI = @"http://127.0.0.1:5000/clarifai/v1.0/createconcept" + "?id=" + conceptid;
            var response = HttpClientHelper.Get(URI);

            string URI1 = @"http://127.0.0.1:5000/clarifai/v1.0/createimage" + "?url=" + imageUrl + "&conceptid=" + conceptid;
            var response1 = HttpClientHelper.Get(URI1);

            string URI2 = @"http://127.0.0.1:5000/clarifai/v1.0/trainmodel";
            var response2 = HttpClientHelper.Get(URI2);

            var picService = this.Service<IPictureService>();
            var logObjectService = this.Service<ILogObjectService>();
            var entity = logObjectService.Get(logId);

            var addImage = new Picture
            {
                ConceptId = conceptid,
                ImageURL = imageUrl,
                Description = conceptDes
            };

            try
            {
                picService.Create(addImage);
                logObjectService.Deactivate(entity);
            }
            catch (DbEntityValidationException e)
            {
            }

            return RedirectToAction("Index", "Object");
        }
        public ActionResult testPredict()
        {

            return View();
        }
        public ActionResult testConcept(IEnumerable<HttpPostedFileBase> fileUpload)
        {
            Account account = new Account("trains", "445514799582782", "NIIYkOkkMtT_2uAtf2R3WWuEvLk");
            Cloudinary cloudinary = new Cloudinary(account);

            if (fileUpload != null)
            {
                foreach (var image in fileUpload)
                {
                    byte[] imageSize = new byte[image.ContentLength];
                    image.InputStream.Read(imageSize, 0, (int)image.ContentLength);

                    var name = image.FileName;
                    var size = image.ContentLength;
                    var path = Server.MapPath(".") + "//uploads//" + name;
                    image.SaveAs(path);
                    var uploadParams = new ImageUploadParams()
                    {
                        File = new FileDescription(path)
                    };
                    var uploadResult = cloudinary.Upload(uploadParams);
                    var url = uploadResult.Uri.AbsoluteUri;

                    string URI = @"http://127.0.0.1:5000/clarifai/v1.0/image" + "?url=" + url;
                    var response = HttpClientHelper.Get(URI);

                    var obj = JObject.Parse(response);
                    var value = (double)obj["outputs"][0]["data"]["concepts"][0]["value"];
                    var id = (int)obj["outputs"][0]["data"]["concepts"][0]["id"];

                    var service = this.Service<IConceptService>();
                    var entity = service.Get(id);

                    if (value > 0.6)
                    {
                        var model = new ConceptViewModel
                        {
                            ConceptId = id,
                            ConceptName = entity.ConceptName,
                            ConceptDescription = entity.ConceptDescription,
                            CreateDate = entity.CreateDate
                        };
                        return View(model);
                    }
                }
            }
            return View();
        }
        public ActionResult viewAllConcept()
        {
            var service = this.Service<IConceptService>();
            var model = service.GetActive().ProjectTo<ConceptViewModel>(this.MapperConfig);

            return View(model);
        }
        public ActionResult editConcept(int conceptId)
        {
            var picService = this.Service<IPictureService>();
            var entityPicture = picService.Get(conceptId);
            var conService = this.Service<IConceptService>();
            var entityConcept = conService.Get(conceptId);
            var picture = picService.GetActive(q => q.ConceptId.Equals(conceptId)).ProjectTo<PictureViewModel>(this.MapperConfig);
            //var pictures = picService.get(q => q.conceptid.equals(conceptid)).firstordefault();

            var model = new BigViewModel
            {
                ConceptId = conceptId,
                ConceptName = entityConcept.ConceptName,
                ConceptDescription = entityConcept.ConceptDescription,
                PictureList = picture,
                CreateDate = entityConcept.CreateDate
            };
            return View(model);
        }
        public ActionResult updateNewConcept(int conceptId, string conceptName, string conceptDes, IEnumerable<HttpPostedFileBase> fileUpload)
        {
            Account account = new Account("trains", "445514799582782", "NIIYkOkkMtT_2uAtf2R3WWuEvLk");
            Cloudinary cloudinary = new Cloudinary(account);

            var conceptService = this.Service<IConceptService>();
            var updateConcept = new Concept
            {
                ConceptId = conceptId,
                ConceptName = conceptName,
                ConceptDescription = conceptDes,
                CreateDate = DateTime.Now,
                Active = true
            };
            try
            {
                conceptService.Update(updateConcept);
            }
            catch (DbEntityValidationException e)
            {
            }

            var concepts = conceptService.Get(q => q.ConceptName.Equals(conceptName)).FirstOrDefault();
            int conceptid = concepts.ConceptId;

            if (fileUpload != null)
            {
                foreach (var image in fileUpload)
                {
                    byte[] imageSize = new byte[image.ContentLength];
                    image.InputStream.Read(imageSize, 0, (int)image.ContentLength);

                    var name = image.FileName;
                    var size = image.ContentLength;
                    var path = Server.MapPath(".") + "//uploads//" + name;
                    image.SaveAs(path);
                    var uploadParams = new ImageUploadParams()
                    {
                        File = new FileDescription(path)
                    };
                    var uploadResult = cloudinary.Upload(uploadParams);
                    var url = uploadResult.Uri.AbsoluteUri;

                    string URI1 = @"http://127.0.0.1:5000/clarifai/v1.0/createimage" + "?url=" + url + "&conceptid=" + conceptid;
                    var response1 = HttpClientHelper.Get(URI1);

                    string URI2 = @"http://127.0.0.1:5000/clarifai/v1.0/trainmodel";
                    var response2 = HttpClientHelper.Get(URI2);

                    var picService = this.Service<IPictureService>();
                    var logObjectService = this.Service<ILogObjectService>();

                    var addImage = new Picture
                    {
                        ConceptId = conceptid,
                        ImageURL = url,
                        Description = conceptDes
                    };
                    try
                    {
                        picService.Create(addImage);
                    }
                    catch (DbEntityValidationException e)
                    {
                    }
                }
            }
            return RedirectToAction("viewAllConcept", "Object");
        }
    }
}