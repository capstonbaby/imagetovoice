//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace AAIV_WEB.Models.Entities.Repositories
{
    using System;
    using System.Collections.Generic;
    
    
    public partial interface IsysdiagramRepository : SkyWeb.DatVM.Data.IBaseRepository<sysdiagram>
    {
    }
    
    public partial class sysdiagramRepository : SkyWeb.DatVM.Data.BaseRepository<sysdiagram>, IsysdiagramRepository
    {
    	public sysdiagramRepository(System.Data.Entity.DbContext dbContext) : base(dbContext)
        {
        }
    }
}
