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
    
    public partial class C__MigrationHistoryViewModel : SkyWeb.DatVM.Mvc.BaseEntityViewModel<Models.Entities.C__MigrationHistory>
    {
    	
    			public virtual string MigrationId { get; set; }
    			public virtual string ContextKey { get; set; }
    			public virtual byte[] Model { get; set; }
    			public virtual string ProductVersion { get; set; }
    	
    	public C__MigrationHistoryViewModel() : base() { }
    	public C__MigrationHistoryViewModel(Models.Entities.C__MigrationHistory entity) : base(entity) { }
    
    }
}
