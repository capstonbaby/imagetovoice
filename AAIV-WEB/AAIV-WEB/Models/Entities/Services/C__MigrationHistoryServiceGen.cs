//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace AAIV_WEB.Models.Entities.Services
{
    using System;
    using System.Collections.Generic;
    
    
    public partial interface IC__MigrationHistoryService : SkyWeb.DatVM.Data.IBaseService<C__MigrationHistory>
    {
    }
    
    public partial class C__MigrationHistoryService : SkyWeb.DatVM.Data.BaseService<C__MigrationHistory>, IC__MigrationHistoryService
    {
        public C__MigrationHistoryService(SkyWeb.DatVM.Data.IUnitOfWork unitOfWork, Repositories.IC__MigrationHistoryRepository repository) : base(unitOfWork, repository)
        {
        }
    }
}