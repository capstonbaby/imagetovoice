//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CapstoneProject.WebAPI.Models.ViewModels
{
    using System;
    using System.Collections.Generic;
    
    public partial class LogViewModel : SkyWeb.DatVM.Mvc.BaseEntityViewModel<CapstoneProject.WebAPI.Models.Entities.Log>
    {
    	
    			public virtual int ID { get; set; }
    			public virtual System.DateTime CreatedDate { get; set; }
    			public virtual string UserID { get; set; }
    			public virtual string ImageURL { get; set; }
    			public virtual int ImageType { get; set; }
    			public virtual bool Active { get; set; }
    	
    	public LogViewModel() : base() { }
    	public LogViewModel(CapstoneProject.WebAPI.Models.Entities.Log entity) : base(entity) { }
    
    }
}
