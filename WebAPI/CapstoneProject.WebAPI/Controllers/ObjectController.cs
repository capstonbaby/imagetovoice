using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Threading.Tasks;
using System.Web;
using System.Web.Http;

namespace CapstoneProject.WebAPI.Controllers
{
    [RoutePrefix("api/object")]
    public class ObjectController : ApiController
    {
        [Route("detect")]
        [HttpPost]
        public async Task<HttpResponseMessage> Detect(FormDataCollection formDataCollection)
        {
            string urlImage = formDataCollection["url"];

            var client = new HttpClient();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            //var uri = "http://detectobject.herokuapp.com/clarifai/v1.0/image?url=" + urlImage;
            var uri = "http://127.0.0.1:5000/clarifai/v1.0/image?url=" + urlImage;

            HttpResponseMessage response = client.GetAsync(uri).Result;
            if (response.IsSuccessStatusCode)
            {
                Console.WriteLine("success");
            }
            else
            {
                Console.WriteLine("error");
            }
            return response;

        }
    }
}
