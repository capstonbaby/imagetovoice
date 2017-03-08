using AAIV_WEB.Models.Entities;
using AAIV_WEB.Models.Entities.Services;
using AAIV_WEB.Models.ViewModels;
using AutoMapper.QueryableExtensions;
using SkyWeb.DatVM.Mvc;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using CloudinaryDotNet;
using CloudinaryDotNet.Actions;
using System.Data.Entity.Validation;
using AAIV_WEB.Utils;

namespace AAIV_WEB.Controllers
{
    public class ObjectClarifaiController : BaseController
    {
        // GET: Object
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
                    var logActive = new LogObject
                    {
                        Active = false
                    };

                    try
                    {
                        picService.Create(addImage);
                        logObjectService.Deactivate(logActive);
                    }
                    catch (DbEntityValidationException e)
                    {
                    }
                }
            }
            return RedirectToAction("Index", "ObjectClarifai");//mới có tên action ah, tên controller đâu ? RedirectToAction(tên action, tên control)
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
                ConceptList = concepts
            };
            return View(model);
        }
        public ActionResult addImageConcept(string ImageUrl, int? ConceptId)
        {
            if (ConceptId != null)
            {
                var conceptService = this.Service<IConceptService>();
                var concepts = conceptService.Get(q => q.ConceptId.Equals(ConceptId)).FirstOrDefault();
                string conceptname = concepts.ConceptName;

                string URI1 = @"http://127.0.0.1:5000/clarifai/v1.0/createimage" + "?url=" + ImageUrl + "&conceptid=" + conceptname;

                var response1 = HttpClientHelper.Get(URI1);

                string URI2 = @"http://127.0.0.1:5000/clarifai/v1.0/trainmodel";
                var response2 = HttpClientHelper.Get(URI2);

                var picService = this.Service<IPictureService>();
                //var concept = conceptService.Get(q => q.ConceptName.Equals(conceptname)).FirstOrDefault();
                var addImage = new Picture
                {
                    ConceptId = concepts.ConceptId,
                    ImageURL = ImageUrl,
                    Description = concepts.ConceptDescription
                };
                try
                {
                    picService.Create(addImage);
                }
                catch (DbEntityValidationException e)
                {
                }
                return RedirectToAction("Index", "ObjectClarifai");
            }
            return RedirectToAction("addNewConcept", "ObjectClarifai", new { imgUrl = ImageUrl });

        }
        public ActionResult addNewConcept(string imgUrl)
        {
            var model = new BigViewModel
            {
                ImageURL = imgUrl,
                LogObjectViewModel = null,
                ConceptList = null
            };
            return View(model);
        }
        public ActionResult addImageNewConcept(string conceptName, string conceptDes, string imageUrl)
        {
            string URI = @"http://127.0.0.1:5000/clarifai/v1.0/createconcept" + "?id=" + conceptName;
            var response = HttpClientHelper.Get(URI);

            var conceptService = this.Service<IConceptService>();
            var addConcept = new Concept
            {
                ConceptName = conceptName,
                ConceptDescription = conceptDes,
                Active = false

            };
            try
            {
                conceptService.Create(addConcept);
            }
            catch (DbEntityValidationException e)
            {
            }
            string URI1 = @"http://127.0.0.1:5000/clarifai/v1.0/createimage" + "?url=" + imageUrl + "&conceptid=" + conceptName;
            var response1 = HttpClientHelper.Get(URI1);

            string URI2 = @"http://127.0.0.1:5000/clarifai/v1.0/trainmodel";
            var response2 = HttpClientHelper.Get(URI2);

            var picService = this.Service<IPictureService>();
            var logObjectService = this.Service<ILogObjectService>();

            var concept = conceptService.Get(q => q.ConceptName.Equals(conceptName)).FirstOrDefault();
            var addImage = new Picture
            {
                ConceptId = concept.ConceptId,
                ImageURL = imageUrl,
                Description = conceptDes
            };
            var logActive = new LogObject
            {
                Active = false
            };

            try
            {
                picService.Create(addImage);
                logObjectService.Deactivate(logActive);
            }
            catch (DbEntityValidationException e)
            {
            }

            return RedirectToAction("Index", "ObjectClarifai");
        }
    }
}