using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAIV_WEB.Models.ViewModels
{
    public class PersonEditViewModel : PersonViewModel
    {
        public string PersonAvatar { get; set; }
        public List<FaceViewModel> FaceList { get; set; }
    }
}