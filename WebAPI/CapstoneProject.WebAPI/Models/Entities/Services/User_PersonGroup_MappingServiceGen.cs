//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CapstoneProject.WebAPI.Models.Entities.Services
{
    using System;
    using System.Collections.Generic;
    
    
    public partial interface IUser_PersonGroup_MappingService : SkyWeb.DatVM.Data.IBaseService<User_PersonGroup_Mapping>
    {
    }
    
    public partial class User_PersonGroup_MappingService : SkyWeb.DatVM.Data.BaseService<User_PersonGroup_Mapping>, IUser_PersonGroup_MappingService
    {
        public User_PersonGroup_MappingService(SkyWeb.DatVM.Data.IUnitOfWork unitOfWork, Repositories.IUser_PersonGroup_MappingRepository repository) : base(unitOfWork, repository)
        {
        }
    }
}
