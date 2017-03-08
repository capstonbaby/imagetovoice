using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAIV_WEB.Models.ViewModels
{
    public class BigViewModel : ConceptViewModel
    {
        public BigViewModel() : base() { }
        public LogObjectViewModel LogObjectViewModel { get; set; }
        public IEnumerable<ConceptViewModel> ConceptList { get; set; }
        public IEnumerable<PictureViewModel> PictureList { get; set; }
        //public PictureViewModel picture { get; set; }
        public int LogId { get; set; }
        public string ImageURL { get; internal set; }

    }
}