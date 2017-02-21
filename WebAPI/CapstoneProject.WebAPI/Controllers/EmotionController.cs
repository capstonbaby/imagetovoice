using CapstoneProject.WebAPI.Common;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Net.Http.Formatting;
using System.Net.Http.Headers;
using System.Text;
using System.Web;
using System.Web.Http;

namespace CapstoneProject.WebAPI.Controllers
{
    [RoutePrefix("api/emotion")]
    public class EmotionController : ApiController
    {
        [Route("detect")]
        [HttpPost]
        public async System.Threading.Tasks.Task<HttpResponseMessage> Detect(FormDataCollection formDataCollection)
        {
            string urlImage = formDataCollection["url"];

            var client = new HttpClient();
            var queryString = HttpUtility.ParseQueryString(string.Empty);

            // Request headers
            client.DefaultRequestHeaders.Add("Ocp-Apim-Subscription-Key", Assets.KEY_EMOTION_REVIEW);

            // Request parameters
            var uri = "https://westus.api.cognitive.microsoft.com/emotion/v1.0/recognize?" + queryString;

            HttpResponseMessage response;

            //string test = @"{'Url':'http://media.tumblr.com/045760551922a84cea95b3d09355aa6a/tumblr_inline_mh841fxg9I1qz4rgp.gif'}";
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
    }
}
