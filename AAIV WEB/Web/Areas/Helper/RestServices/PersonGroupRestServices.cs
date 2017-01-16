using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using Web.Areas.Helper.Models;

namespace Web.Areas.Helper.RestServices
{
    public class PersonGroupRestServices
    {
        readonly Uri uri = new Uri("http://localhost/CapstoneProject.WebAPI/api/face/");

        public async Task<List<PersonGroupModel>> getPersonGroupsAsync()
        {
            using (HttpClient client = new HttpClient())
            {
                List<PersonGroupModel> result = await JsonConvert.DeserializeObjectAsync<List<PersonGroupModel>>(
                    await client.GetStringAsync(uri + "getgroups")
                );

                return result;
            }
        }

        public async Task<List<PersonModel>> getPeopleInGroupAsync(string personGroupId)
        {
            using (HttpClient client = new HttpClient())
            {
                client.BaseAddress = uri;

                var content = new FormUrlEncodedContent(new[]
                {
                    new KeyValuePair<string, string>("personGroupId", personGroupId)
                });

                var result = await client.PostAsync("getpeopleingroup", content);

                return await JsonConvert.DeserializeObjectAsync<List<PersonModel>>(await result.Content.ReadAsStringAsync());
            };
        }
    }
}
