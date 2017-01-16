using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.Areas.Helper.Models
{
    public class PersonModel
    {
        public string personId { get; set; }
        public List<string> persistedFaceIds { get; set; }
        public string name { get; set; }
        public object userData { get; set; }
    }
}