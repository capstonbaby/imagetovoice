using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.IO;
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
    [RoutePrefix("api/object")]
    public class ObjectController : ApiController
    {
        [Route("detect")]
        [HttpPost]
        public async Task<HttpResponseMessage> Detect(FormDataCollection formDataCollection)
        {
            string urlImage = formDataCollection["url"];
            string conceptDescription = "";

            var client = new HttpClient();
            client.DefaultRequestHeaders.Accept.Add(new MediaTypeWithQualityHeaderValue("application/json"));
            var uri = "http://127.0.0.1:5000/clarifai/v1.0/image?url=" + urlImage;

            HttpResponseMessage response = client.GetAsync(uri).Result;
            if (response.IsSuccessStatusCode)
            {
                String strRespone = await response.Content.ReadAsStringAsync();
                var data = (JObject)JsonConvert.DeserializeObject(strRespone);
                var arrObject = data["outputs"][0]["data"]["concepts"];
                var dataApi = new DataController();
                var numObject = arrObject.Count();
                for (int i=0;i < numObject; i++)
                {
                    Double value = Double.Parse(data["outputs"][0]["data"]["concepts"][i]["value"].ToString());
                    if(value > 0.6)
                    {
                        int conceptId = int.Parse(data["outputs"][0]["data"]["concepts"][0]["id"].ToString());
                        conceptDescription += dataApi.getDescriptionConcept(conceptId) + ". ";
                    }else
                    {
                        break;
                    }   
                }

                if (conceptDescription == "")
                {
                    conceptDescription = "error";
                }

                return new HttpResponseMessage()
                {
                    Content = new StringContent(conceptDescription, Encoding.UTF8, "text/html"),
                };
            }
            else
            {
                return new HttpResponseMessage()
                {
                    Content = new StringContent("error", Encoding.UTF8, "text/html"),
                };
            }

        }
    }
}
