using CapstoneProject.WebAPI.Common;
using CapstoneProject.WebAPI.Models;
using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Text;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;


namespace CapstoneProject.WebAPI.Controllers
{
    [RoutePrefix("api/face")]
    public class FaceReviewController : ApiController
    {
        [Route("creategroup")]
        [HttpPost]
        public async Task<HttpResponseMessage> CreateGroup(FormDataCollection formDataCollection)
        {
            string personGroupId = formDataCollection["personGroupId"];
            string userData = formDataCollection["userData"];
            string groupName = formDataCollection["groupName"];

            var client = new HttpClient();
            var queryString = HttpUtility.ParseQueryString(string.Empty);

            // Request headers
            client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", Assets.KEY_FACE_REVIEW);

            var uri = "https://api.projectoxford.ai/face/v1.0/persongroups/" + personGroupId + "?" + queryString;

            HttpResponseMessage response;

            string body = @"{'Name':'" + groupName + "','userData':'" + userData + "'}";

            // Request body
            byte[] byteData = Encoding.UTF8.GetBytes(body);

            using (var content = new ByteArrayContent(byteData))
            {
                content.Headers.ContentType = new MediaTypeHeaderValue("application/json");
                response = await client.PutAsync(uri, content);
            }
            return response;
        }

        [Route("createperson")]
        [HttpPost]
        public async Task<HttpResponseMessage> CreatePerson(FormDataCollection formDataCollection)
        {
            string personGroupId = formDataCollection["personGroupId"];
            string personName = formDataCollection["personName"];
            string userData = formDataCollection["userData"];

            var client = new HttpClient();
            var queryString = HttpUtility.ParseQueryString(string.Empty);

            // Request headers
            client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", Assets.KEY_FACE_REVIEW);

            var uri = "https://api.projectoxford.ai/face/v1.0/persongroups/" + personGroupId + "/persons?" + queryString;

            HttpResponseMessage response;

            string body = @"{'Name':'" + personName + "','userData':'" + userData + "'}";

            // Request body
            byte[] byteData = Encoding.UTF8.GetBytes(body);

            using (var content = new ByteArrayContent(byteData))
            {
                content.Headers.ContentType = new MediaTypeHeaderValue("application/json");
                response = await client.PostAsync(uri, content);
            }

            return response;
        }

        [Route("addpersonface")]
        [HttpPost]
        public async Task<HttpResponseMessage> CreatePersonFace(FormDataCollection formDataCollection)
        {
            string personGroupId = formDataCollection["personGroupId"];
            string personId = formDataCollection["personId"];
            string userData = formDataCollection["userData"];
            string urlImage = formDataCollection["urlImage"];

            var client = new HttpClient();
            var queryString = HttpUtility.ParseQueryString(string.Empty);

            // Request headers
            client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", Assets.KEY_FACE_REVIEW);

            // Request parameters
            queryString["userData"] = $"{userData}";
            //queryString["targetFace"] = $"{string}";
            var uri = "https://api.projectoxford.ai/face/v1.0/persongroups/" + personGroupId + "/persons/" + personId + "/persistedFaces?" + queryString;

            HttpResponseMessage response;

            string body = @"{'url':'" + urlImage + "'}";

            // Request body
            byte[] byteData = Encoding.UTF8.GetBytes(body);

            using (var content = new ByteArrayContent(byteData))
            {
                content.Headers.ContentType = new MediaTypeHeaderValue("application/json");
                response = await client.PostAsync(uri, content);
            }

            return response;
        }

        [Route("trainpersongroup")]
        [HttpPost]
        public async Task<HttpResponseMessage> TrainPersonGroup(FormDataCollection formDataCollection)
        {
            string personGroupId = formDataCollection["personGroupId"];

            var client = new HttpClient();
            var queryString = HttpUtility.ParseQueryString(string.Empty);

            // Request headers
            client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", Assets.KEY_FACE_REVIEW);

            var uri = "https://api.projectoxford.ai/face/v1.0/persongroups/"+personGroupId+"/train?" + queryString;

            HttpResponseMessage response;

            string body = "";

            // Request body
            byte[] byteData = Encoding.UTF8.GetBytes(body);

            using (var content = new ByteArrayContent(byteData))
            {
                content.Headers.ContentType = new MediaTypeHeaderValue("application/json");
                response = await client.PostAsync(uri, content);
            }
            return response;
        }

        [Route("createfaceid")]
        [HttpPost]
        public async Task<HttpResponseMessage> CreateFaceId(FormDataCollection formDataCollection)
        {
            string urlImage = formDataCollection["urlImage"];

            var client = new HttpClient();
            var queryString = HttpUtility.ParseQueryString(string.Empty);

            // Request headers
            client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", Assets.KEY_FACE_REVIEW);

            // Request parameters
            queryString["returnFaceId"] = "true";
            queryString["returnFaceLandmarks"] = "false";
            queryString["returnFaceAttributes"] = "gender";
            var uri = "https://api.projectoxford.ai/face/v1.0/detect?" + queryString;

            HttpResponseMessage response;

            string body = @"{'url':'" + urlImage + "'}";

            // Request body
            byte[] byteData = Encoding.UTF8.GetBytes(body);

            using (var content = new ByteArrayContent(byteData))
            {
                content.Headers.ContentType = new MediaTypeHeaderValue("application/json");
                response = await client.PostAsync(uri, content);
            }

            return response;
        }

        [Route("umbala")]
        [HttpPost]
        public async Task<HttpResponseMessage> DetectPerson(FormDataCollection formDataCollection)
        {
            //get from client
            string personGroupId = formDataCollection["personGroupId"];
            string faceid = formDataCollection["faceid"];

            //set to model for extract to json
            DetectPerson d = new DetectPerson();
            d.personGroupId = personGroupId;
            d.maxNumOfCandidatesReturned = 1;
            d.confidenceThreshold = 0.7;
            d.faceIds = new List<string> { faceid };

            var client = new HttpClient();
            var queryString = HttpUtility.ParseQueryString(string.Empty);

            // Request headers
            client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", Assets.KEY_FACE_REVIEW);

            var uri = "https://api.projectoxford.ai/face/v1.0/identify?" + queryString;

            HttpResponseMessage response;

            string body = JsonConvert.SerializeObject(d);

            // Request body
            byte[] byteData = Encoding.UTF8.GetBytes(body);

            using (var content = new ByteArrayContent(byteData))
            {
                content.Headers.ContentType = new MediaTypeHeaderValue("application/json");
                response = await client.PostAsync(uri, content);
            }

            return response;
        }
    }
}
