
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
    

public partial interface ILogService : SkyWeb.DatVM.Data.IBaseService<Log>
{
}

public partial class LogService : SkyWeb.DatVM.Data.BaseService<Log>, ILogService
{
    public LogService(SkyWeb.DatVM.Data.IUnitOfWork unitOfWork, Repositories.ILogRepository repository) : base(unitOfWork, repository)
    {
    }
}

}
