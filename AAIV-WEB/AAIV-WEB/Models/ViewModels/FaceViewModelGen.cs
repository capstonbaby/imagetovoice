
//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------


namespace AAIV_WEB.Models.ViewModels
{

    using System;
    using System.Collections.Generic;

    public partial class FaceViewModel : SkyWeb.DatVM.Mvc.BaseEntityViewModel<Models.Entities.Face>
    {


        public virtual string PersistedFaceId { get; set; }

        public virtual string PersonID { get; set; }

        public virtual string ImageURL { get; set; }

        public virtual bool Active { get; set; }


        public FaceViewModel() : base() { }
        public FaceViewModel(Models.Entities.Face entity) : base(entity) { }

    }

}
