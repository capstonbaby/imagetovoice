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
    
    
    public partial interface IFaceService : SkyWeb.DatVM.Data.IBaseService<Face>
    {
    }
    
    public partial class FaceService : SkyWeb.DatVM.Data.BaseService<Face>, IFaceService
    {
        public FaceService(SkyWeb.DatVM.Data.IUnitOfWork unitOfWork, Repositories.IFaceRepository repository) : base(unitOfWork, repository)
        {
        }
    }
}