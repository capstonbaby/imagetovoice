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
    
    
    public partial interface IPictureService : SkyWeb.DatVM.Data.IBaseService<Picture>
    {
    }
    
    public partial class PictureService : SkyWeb.DatVM.Data.BaseService<Picture>, IPictureService
    {
        public PictureService(SkyWeb.DatVM.Data.IUnitOfWork unitOfWork, Repositories.IPictureRepository repository) : base(unitOfWork, repository)
        {
        }
    }
}
