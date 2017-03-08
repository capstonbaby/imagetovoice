using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CapstoneProject.WebAPI.Models
{
    public class ResponseModel<T> where T : class
    {
        public bool Succeed { get; set; } = true;
        public string Message { get; set; }
        public List<string> Errors { get; set; }

        public T Data { get; set; }

        public void AddError(string error)
        {
            this.Errors.Add(error);
        }
    }

    public class LoginResponseModel
    {
        public string PersonGroupId { get; set; }
        public string UserId  { get; set; }
    }
}