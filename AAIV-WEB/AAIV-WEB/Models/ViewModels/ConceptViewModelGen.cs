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
    
    public partial class ConceptViewModel : SkyWeb.DatVM.Mvc.BaseEntityViewModel<Models.Entities.Concept>
    {
    	
    			public virtual int ConceptId { get; set; }
    			public virtual string ConceptName { get; set; }
    			public virtual string ConceptDescription { get; set; }
    			public virtual Nullable<System.DateTime> CreateDate { get; set; }
    			public virtual bool Active { get; set; }
    	
    	public ConceptViewModel() : base() { }
    	public ConceptViewModel(Models.Entities.Concept entity) : base(entity) { }
    
    }
}
