
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
    
public partial class PictureViewModel : SkyWeb.DatVM.Mvc.BaseEntityViewModel<Models.Entities.Picture>
{
	
	
		public virtual string PictureId { get; set; }
	
		public virtual Nullable<int> ConceptId { get; set; }
	
		public virtual string Description { get; set; }
	
		public virtual string ImageURL { get; set; }
	
		public virtual bool Active { get; set; }
	

	public PictureViewModel() : base() { }
	public PictureViewModel(Models.Entities.Picture entity) : base(entity) { }

}

}
