
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

    public partial class PersonViewModel : SkyWeb.DatVM.Mvc.BaseEntityViewModel<Models.Entities.Person>
    {


        public virtual string PersonId { get; set; }

        public virtual int PersonGroupID { get; set; }

        public virtual string Name { get; set; }

        public virtual string Description { get; set; }

        public virtual bool IsTrained { get; set; }

        public virtual bool Active { get; set; }


        public PersonViewModel() : base() { }
        public PersonViewModel(Models.Entities.Person entity) : base(entity) { }

    }

}
