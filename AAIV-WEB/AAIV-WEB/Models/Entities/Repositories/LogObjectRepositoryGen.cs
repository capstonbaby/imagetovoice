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
    
    
    public partial interface ILogObjectRepository : SkyWeb.DatVM.Data.IBaseRepository<LogObject>
    {
    }
    
    public partial class LogObjectRepository : SkyWeb.DatVM.Data.BaseRepository<LogObject>, ILogObjectRepository
    {
    	public LogObjectRepository(System.Data.Entity.DbContext dbContext) : base(dbContext)
        {
        }
    }
}
