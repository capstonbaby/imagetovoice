
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
    

public partial interface IPersonGroupService : SkyWeb.DatVM.Data.IBaseService<PersonGroup>
{
}

public partial class PersonGroupService : SkyWeb.DatVM.Data.BaseService<PersonGroup>, IPersonGroupService
{
    public PersonGroupService(SkyWeb.DatVM.Data.IUnitOfWork unitOfWork, Repositories.IPersonGroupRepository repository) : base(unitOfWork, repository)
    {
    }
}

}
