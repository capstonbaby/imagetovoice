using AAIV_WEB.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAIV_WEB.Areas.Admin.Models
{
    public class AspNetUserEditViewModel : AspNetUserViewModel
    {
        public PersonGroupViewModel personGroup { get; set; }
        public List<string> SeletedUsers { get; set; }
    }
}