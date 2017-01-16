using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace Web.Areas.Helper.Models
{
    public class PersonGroupModel
    {
        public string personGroupId { get; set; }
        public string name { get; set; }
        public string userData { get; set; }
    }

    public class PersonGroupCustomModel
    {
        public PersonGroupModel personGroup { get; set; }
        public List<PersonModel> personList { get; set; }
    }
}