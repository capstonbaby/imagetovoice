
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
    
public partial class sysdiagramViewModel : SkyWeb.DatVM.Mvc.BaseEntityViewModel<Models.Entities.sysdiagram>
{
	
	
		public virtual string name { get; set; }
	
		public virtual int principal_id { get; set; }
	
		public virtual int diagram_id { get; set; }
	
		public virtual Nullable<int> version { get; set; }
	
		public virtual byte[] definition { get; set; }
	

	public sysdiagramViewModel() : base() { }
	public sysdiagramViewModel(Models.Entities.sysdiagram entity) : base(entity) { }

}

}
