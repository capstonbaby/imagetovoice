using AAIV_WEB.Models.Entities;
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
        public string LogImage { get; set; }

        //Log
        public int LogID { get; set; }

    }

    public class ListPersonListViewModel
    {
        public List<List<Person>> ListPersonList { get; set; }

        public List<string> SelectedPersonIDs { get; set; }
    }
}