using AAIV_WEB.Areas.Admin.Models.ViewModels;
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
using System.Threading.Tasks;
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
            var conceptService = this.Service<IConceptService>();
            var conceptList = conceptService.GetActive().ProjectTo<ConceptViewModel>(this.MapperConfig);
            ViewBag.conceptList = conceptList;
            return View(model);
        }
        public ActionResult createObject()
        {
            var conceptService = this.Service<IConceptService>();
            var conceptList = conceptService.GetActive().ProjectTo<ConceptViewModel>(this.MapperConfig);

            return View(conceptList);
        }
        public async Task<ActionResult> createNewObject(string conceptName, string conceptDes, IEnumerable<HttpPostedFileBase> fileUpload)
        {

            // Validate data input
            if (string.IsNullOrEmpty(conceptName))
            {
                TempData["message"] = "Tên đồ vật không được bỏ trống!";
                return RedirectToAction("createObject", "Object");
            }
            //            
            var addConcept = new Concept
            {
                ConceptName = conceptName,
                ConceptDescription = conceptDes,
                CreateDate = DateTime.Now,
                Active = true
            };
            var conceptService = this.Service<IConceptService>();
            try
            {
                if (conceptService != null)
                {
                    // nope tra ve void thi biet the nao da duoc tao hay la chua
                    await conceptService.CreateAsync(addConcept);
                }
                else
                {
                    TempData["message"] = "Service không hoạt động!";
                    return RedirectToAction("createObject", "Object");
                }
                var concepts = conceptService.Get(q => q.ConceptName.Equals(conceptName)).FirstOrDefault();
                int conceptid = concepts.ConceptId;

                string createConceptURI = Constant.CREATE_CONCEPT_API + conceptid;
                var createConceptResponse = HttpClientHelper.Get(createConceptURI);
                if (createConceptResponse != null)
                {
                    var list_image = getImageURL(fileUpload);
                    if (list_image != null)
                    {
                        foreach (var image_url in list_image)
                        {
                            string createImgURI = Constant.Get_Create_IMG_API_URL(image_url, conceptid);
                            var createImgResponse = HttpClientHelper.Get(createImgURI);
                            string trainURI = Constant.TRAIN_API;
                            var trainResponse = HttpClientHelper.Get(trainURI);

                            if (createImgResponse != null && trainResponse != null)
                            {
                                var addImage = new Picture
                                {
                                    PictureId = createImgResponse,
                                    ConceptId = conceptid,
                                    ImageURL = image_url,
                                    Description = conceptDes
                                };
                                var picService = this.Service<IPictureService>();
                                var logObjectService = this.Service<ILogObjectService>();
                                if (picService != null)
                                {
                                    // nope tra ve void thi biet the nao da duoc tao hay la chua
                                    await picService.CreateAsync(addImage);
                                }
                                else
                                {
                                    TempData["message"] = "Service không hoạt động!";
                                    return RedirectToAction("createObject", "Object");
                                }
                            }
                            else
                            {
                                TempData["message"] = "Tạo mới thất bại! Vui lòng thử lại!";
                                return RedirectToAction("createObject", "Object");
                            }
                        }
                    }
                    else
                    {
                        TempData["message"] = "Vui lòng chọn hình ảnh!";
                        return RedirectToAction("createObject", "Object");
                    }
                }
                else
                {
                    TempData["message"] = "Tạo concept thất bại! Vui lòng thử lại!";
                    return RedirectToAction("createObject", "Object");
                }
            }
            catch (Exception e)
            {
                TempData["message"] = "Tạo mới thất bại! Vui lòng thử lại!";
                return RedirectToAction("createObject", "Object");
            }
            return RedirectToAction("viewAllConcept", "Object");
        }
        public ActionResult addObject(int logId)
        {
            var service = this.Service<ILogObjectService>();
            var entity = service.Get(logId);
            var conceptService = this.Service<IConceptService>();
            var concepts = conceptService.GetActive().ProjectTo<ConceptViewModel>(this.MapperConfig);
            if(entity != null)
            {
                var model = new BigViewModel
                {
                    ImageURL = entity.ImageURL,
                    LogObjectViewModel = new LogObjectViewModel(entity),
                    ConceptList = concepts,
                    LogId = logId
                };
                return View(model);
            }
            else
            {
                return RedirectToAction("Index", "Object");
            }
        }
        public async Task<ActionResult> addImageConcept(string ImageUrl, int? ConceptId, int logId)
        {
            if (ConceptId != null)
            {
                int conceptid = ConceptId.Value;
                string createImgURI = Constant.Get_Create_IMG_API_URL(ImageUrl, conceptid);
                var createImgResponse = HttpClientHelper.Get(createImgURI);
                string trainURI = Constant.TRAIN_API;
                var trainResponse = HttpClientHelper.Get(trainURI);

                if (createImgResponse != null && trainResponse != null)
                {
                    var conceptService = this.Service<IConceptService>();
                    if (conceptService != null)
                    {
                        var conceptDes = conceptService.Get(q => q.ConceptId.Equals(conceptid)).FirstOrDefault();
                        var addImage = new Picture
                        {
                            PictureId = createImgResponse,
                            ConceptId = conceptid,
                            ImageURL = ImageUrl,
                            Description = conceptDes.ConceptDescription
                        };
                        var picService = this.Service<IPictureService>();
                        var logObjectService = this.Service<ILogObjectService>();
                        if (picService != null && logObjectService != null)
                        {
                            var entity = logObjectService.Get(logId);
                            await picService.CreateAsync(addImage);
                            await logObjectService.DeactivateAsync(entity);                            
                        }
                        else
                        {
                            TempData["message"] = "Service không hoạt động!";
                            return RedirectToAction("addObject", "Object");
                        }
                        //return RedirectToAction("Index", "Object");
                        return Json(new { message = "Cập nhật thành công", success = true });
                    }
                    else
                    {
                        TempData["message"] = "Service không hoạt động!";
                        return RedirectToAction("addObject", "Object");
                    }
                }
                else
                {
                    TempData["message"] = "Tạo mới thất bại! Vui lòng thử lại!";
                    return RedirectToAction("addObject", "Object");
                }
            }
            //return RedirectToAction("addNewConcept", "Object", new { imgUrl = ImageUrl, logId = logId });
            return Json(new { message = "Cập nhật thất bại", success = false });

        }
        public ActionResult addNewConcept(int logId)
        {
            var logservice = this.Service<ILogObjectService>();
            var logentity = logservice.Get(logId);
            var model = new BigViewModel
            {
                ImageURL = logentity.ImageURL,
                LogObjectViewModel = null,
                ConceptList = null,
                LogId = logId
            };
            return View(model);
        }
        public async Task<ActionResult> addImageNewConcept(string conceptName, string conceptDes, string imageUrl, int logId)
        {
            // Validate data input
            if (string.IsNullOrEmpty(conceptName))
            {
                TempData["message"] = "Tên đồ vật không được bỏ trống!";
                return RedirectToAction("addNewConcept", "Object", new { imgUrl = imageUrl, logId = logId });
            }
            //    
            var addConcept = new Concept
            {
                ConceptName = conceptName,
                ConceptDescription = conceptDes,
                CreateDate = DateTime.Now,
                Active = false
            };
            var conceptService = this.Service<IConceptService>();
            if (conceptService != null)
            {
                await conceptService.CreateAsync(addConcept);
                var concepts = conceptService.Get(q => q.ConceptName.Equals(conceptName)).FirstOrDefault();

                string createConceptURI = Constant.CREATE_CONCEPT_API + concepts.ConceptId;
                var createConceptResponse = HttpClientHelper.Get(createConceptURI);
                if (createConceptResponse != null)
                {
                    string createImgURI = Constant.Get_Create_IMG_API_URL(imageUrl, concepts.ConceptId);
                    var createImgResponse = HttpClientHelper.Get(createImgURI);
                    string trainURI = Constant.TRAIN_API;
                    var trainResponse = HttpClientHelper.Get(trainURI);
                    if (createImgResponse != null && trainResponse != null)
                    {
                        var addImage = new Picture
                        {
                            PictureId = createImgResponse,
                            ConceptId = concepts.ConceptId,
                            ImageURL = imageUrl,
                            Description = conceptDes
                        };
                        var picService = this.Service<IPictureService>();
                        var logObjectService = this.Service<ILogObjectService>();
                        if (picService != null && logObjectService != null)
                        {
                            var entity = logObjectService.Get(logId);
                            await picService.CreateAsync(addImage);
                            await logObjectService.DeactivateAsync(entity);
                        }
                        else
                        {
                            TempData["message"] = "Service không hoạt động!";
                            return RedirectToAction("addNewConcept", "Object", new { imgUrl = imageUrl, logId = logId });
                        }
                    }
                    else
                    {
                        TempData["message"] = "Tạo mới thất bại! Vui lòng thử lại!";
                        return RedirectToAction("addNewConcept", "Object", new { imgUrl = imageUrl, logId = logId });
                    }
                }
                else
                {
                    TempData["message"] = "Tạo concept thất bại! Vui lòng thử lại!";
                    return RedirectToAction("addNewConcept", "Object", new { imgUrl = imageUrl, logId = logId });
                }
            }
            else
            {
                TempData["message"] = "Service không hoạt động!";
                return RedirectToAction("addNewConcept", "Object", new { imgUrl = imageUrl, logId = logId });
            }
            return RedirectToAction("Index", "Object");
        }
        public ActionResult testPredict()
        {
            return View();
        }
        public ActionResult testConcept(IEnumerable<HttpPostedFileBase> fileUpload)
        {
            var list_image = getImageURL(fileUpload);
            if (list_image != null)
            {
                foreach (var image_Url in list_image)
                {
                    string detectURI = Constant.DETECT_API + image_Url;
                    var detectResponse = HttpClientHelper.Get(detectURI);
                    if (detectResponse != null)
                    {
                        var obj = JObject.Parse(detectResponse);
                        var value = (double)obj["outputs"][0]["data"]["concepts"][0]["value"];
                        var id = (int)obj["outputs"][0]["data"]["concepts"][0]["id"];

                        var service = this.Service<IConceptService>();
                        if (service != null)
                        {
                            var entity = service.Get(id);
                            if (value > 0.4)
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
                            else
                            {
                                var model = new ConceptViewModel
                                {
                                    ConceptId = 0,
                                    ConceptName = "Không xác định được",
                                    ConceptDescription = "",
                                    CreateDate = null,
                                };
                                return View(model);
                            }
                        }
                        else
                        {
                            TempData["message"] = "Service không hoạt động!";
                            return RedirectToAction("testPredict", "Object");
                        }
                    }
                    else
                    {
                        TempData["message"] = "Không nhận dạng được vật thể!";
                        return RedirectToAction("testPredict", "Object");
                    }
                }
            }
            else
            {
                TempData["message"] = "Vui lòng chọn hình ảnh!";
                return RedirectToAction("testPredict", "Object");
            }
            return View();
        }
        public ActionResult viewAllConcept()
        {
            var service = this.Service<IConceptService>();
            var pictureService = this.Service<IPictureService>();
            var conceptPicture = "";
            var model = service.GetActive()
                .ProjectTo<ConceptEditViewModel>(this.MapperConfig)
                .ToList();

            foreach (var concept in model)
            {
                    conceptPicture = pictureService.GetActive(q => q.ConceptId == concept.ConceptId).First().ImageURL;
                    concept.ConceptPicture = conceptPicture;
            }

            return View(model);
        }
        public ActionResult editConcept(int conceptId)
        {
            var picService = this.Service<IPictureService>();
            var conService = this.Service<IConceptService>();
            var entityConcept = conService.Get(conceptId);
            var picture = picService.GetActive(q => q.ConceptId == conceptId).ProjectTo<PictureViewModel>(this.MapperConfig);
            if (entityConcept != null)
            {
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
            else
            {
                return RedirectToAction("viewAllConcept", "Object");
            }
        }
        public async Task<ActionResult> updateNewConcept(int conceptId, string conceptName, string conceptDes, IEnumerable<HttpPostedFileBase> fileUpload)
        {
            // Validate data input
            if (string.IsNullOrEmpty(conceptName))
            {
                TempData["message"] = "Tên đồ vật không được bỏ trống!";
                return RedirectToAction("editConcept", "Object", new { conceptId = conceptId });
            }
            //  
            var updateConcept = new Concept
            {
                ConceptId = conceptId,
                ConceptName = conceptName,
                ConceptDescription = conceptDes,
                CreateDate = DateTime.Now,
                Active = true
            };
            var conceptService = this.Service<IConceptService>();
            if (conceptService != null)
            {
                await conceptService.UpdateAsync(updateConcept);
                var concepts = conceptService.Get(q => q.ConceptName.Equals(conceptName)).FirstOrDefault();
                int conceptid = concepts.ConceptId;
                var list_image = getImageURL(fileUpload);
                if (list_image != null)
                {
                    foreach (var image_Url in list_image)
                    {
                        string createImgURI = Constant.Get_Create_IMG_API_URL(image_Url, conceptid);
                        var createImgResponse = HttpClientHelper.Get(createImgURI);
                        string trainURI = Constant.TRAIN_API;
                        var trainResponse = HttpClientHelper.Get(trainURI);
                        if (createImgResponse != null && trainResponse != null)
                        {
                            var addImage = new Picture
                            {
                                PictureId = createImgResponse,
                                ConceptId = conceptid,
                                ImageURL = image_Url,
                                Description = conceptDes
                            };
                            var picService = this.Service<IPictureService>();
                            if (picService != null)
                            {
                                await picService.CreateAsync(addImage);
                            }
                            else
                            {
                                TempData["message"] = "Service không hoạt động!";
                                return RedirectToAction("editConcept", "Object", new { conceptId = conceptId });
                            }
                        }
                        else
                        {
                            TempData["message"] = "Tạo hình ảnh thất bại! Vui lòng thử lại!";
                            return RedirectToAction("editConcept", "Object", new { conceptId = conceptId });
                        }
                    }
                }
            }
            else
            {
                TempData["message"] = "Service không hoạt động!";
                return RedirectToAction("editConcept", "Object", new { conceptId = conceptId });
            }
            return RedirectToAction("editConcept", "Object", new { conceptId = conceptId });
        }
        public async Task<ActionResult> updateDeleteImage(string conceptImageId, int conceptId)
        {
            string delImgURI = Constant.DEL_IMG_API + conceptImageId;
            var delImgResponse = HttpClientHelper.Get(delImgURI);
            string trainURI = Constant.TRAIN_API;
            var trainResponse = HttpClientHelper.Get(trainURI);
            if (delImgResponse != null && trainResponse != null)
            {
                var picService = this.Service<IPictureService>();
                if (picService != null)
                {
                    var entity = picService.Get(conceptImageId);
                    await picService.DeactivateAsync(entity);
                }
                else
                {
                    TempData["message"] = "Service không hoạt động!";
                    return RedirectToAction("editConcept", "Object", new { conceptId = conceptId });
                }
            }
            else
            {
                TempData["message"] = "Ảnh chưa được xóa! Vui lòng thử lại";
                return RedirectToAction("editConcept", "Object", new { conceptId = conceptId });
            }
            return RedirectToAction("editConcept", "Object", new { conceptId = conceptId });
        }
        public async Task<ActionResult> deleteConcept(int conceptId)
        {
            var conService = this.Service<IConceptService>();
            var picService = this.Service<IPictureService>();
            if (conService != null && picService != null)
            {
                var entityConcept = conService.Get(conceptId);
                var entityPic = picService.GetActive(q => q.ConceptId == conceptId).ProjectTo<PictureViewModel>(this.MapperConfig);
                foreach (var picEntity in entityPic.ToList())
                {
                    string delImgURI = Constant.DEL_IMG_API + picEntity.PictureId;
                    var delImgResponse = HttpClientHelper.Get(delImgURI);
                    if (delImgResponse != null)
                    {
                        var picItem = picService.Get(picEntity.PictureId);
                        await picService.DeactivateAsync(picItem);
                }
                    else
                    {
                    TempData["message"] = "Ảnh chưa được xóa! Vui lòng thử lại!";
                    return RedirectToAction("viewAllConcept", "Object");
                }
            }
                string delConceptURI = Constant.DEL_CONCEPT_API + conceptId;
                var delConceptPesponse = HttpClientHelper.Get(delConceptURI);
                string trainURI = Constant.TRAIN_API;
                var trainResponse = HttpClientHelper.Get(trainURI);
                if (delConceptPesponse != null && trainResponse != null)
                {
                    await conService.DeactivateAsync(entityConcept);
            }
            else
            {
                TempData["message"] = "Concept chưa được xóa! Vui lòng thử lại!";
                return RedirectToAction("viewAllConcept", "Object");
            }
        }
            else
            {
                TempData["message"] = "Service không hoạt động!";
                return RedirectToAction("viewAllConcept", "Object");
                //return Json(new { message = "Xóa Thất Bại", success = false });
            }
            return RedirectToAction("viewAllConcept", "Object");
            //return Json(new { message = "Xóa Thành Công", success = true });
        }
        public List<string> getImageURL(IEnumerable<HttpPostedFileBase> fileUpload)
        {
            Account account = new Account("trains", "445514799582782", "NIIYkOkkMtT_2uAtf2R3WWuEvLk");
            Cloudinary cloudinary = new Cloudinary(account);
            if (fileUpload != null)
            {
                List<string> listPicUrl = new List<string>();
                foreach (var image in fileUpload)
                {
                    if (image != null)
                    {
                        byte[] imageSize = new byte[image.ContentLength];
                        image.InputStream.Read(imageSize, 0, (int)image.ContentLength);

                        var name = image.FileName;
                        var size = image.ContentLength;
                        string path = System.IO.Path.Combine(Server.MapPath("~/uploads"), name);
                        image.SaveAs(path);
                        var uploadParams = new ImageUploadParams()
                        {
                            File = new FileDescription(path)
                        };
                        var uploadResult = cloudinary.Upload(uploadParams);
                        var url = uploadResult.Uri.AbsoluteUri;
                        listPicUrl.Add(url);
                    }
                }
                return listPicUrl;
            }
            return null;
        }
        public async Task<ActionResult> deleteImageBySelect(string picIdList, int conceptId)
        {
            var picIdArray = picIdList.Split(',');
            var picService = this.Service<IPictureService>();
            foreach (var picId in picIdArray)
            {
                string delImgURI = Constant.DEL_IMG_API + picId;
                var delImgResponse = HttpClientHelper.Get(delImgURI);
                string trainURI = Constant.TRAIN_API;
                var trainResponse = HttpClientHelper.Get(trainURI);
                if (delImgResponse != null && trainResponse != null)
                {
                    if (picService != null)
                    {
                        var entity = picService.Get(picId);
                        await picService.DeactivateAsync(entity);
                    }
                    else
                    {
                        TempData["message"] = "Service không hoạt động!";
                        return RedirectToAction("editConcept", "Object", new { conceptId = conceptId });
                    }
                }
                else
                {
                    
                    return RedirectToAction("editConcept", "Object", new { conceptId = conceptId });
                }
            }
            return RedirectToAction("editConcept", "Object", new { conceptId = conceptId });
        }
        public async Task<JsonResult> deleteLog(int logId)
        {
            var logObjectService = this.Service<ILogObjectService>();
            var entity = logObjectService.Get(logId);
            if (logObjectService != null)
            {
                await logObjectService.DeactivateAsync(entity);
                return Json(new { success = true, message = "Xoa thanh cong" });
            }
            else
            {
                TempData["message"] = "Xóa log thất bại! Vui lòng thử lại!";
                return Json(new { success = false, message = "Xóa log thất bại! Vui lòng thử lại!" });
            }
        }        
    }
}