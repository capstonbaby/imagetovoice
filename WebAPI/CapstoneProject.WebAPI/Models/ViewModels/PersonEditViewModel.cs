using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace CapstoneProject.WebAPI.Models.ViewModels
{
    public class PersonEditViewModel : PersonViewModel
    {
        public List<FaceViewModel> Faces  { get; set; }
    }
}