//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Data.Repository
{
    using System;
    using System.Collections.Generic;
    using Model.Entities;
    
    
    public partial interface Itbl_LogRepository : Data.Repository.IBaseRepository<tbl_Log>
    {
    }
    
    public partial class tbl_LogRepository : Data.Repository.BaseRepository<tbl_Log>, Itbl_LogRepository
    {
    	public tbl_LogRepository(CapstoneEntities dbContext) : base(dbContext)
        {
        }
    }
}
