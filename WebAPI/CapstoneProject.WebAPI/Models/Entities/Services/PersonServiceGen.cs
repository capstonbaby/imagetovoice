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
    
    
    public partial interface IPersonService : SkyWeb.DatVM.Data.IBaseService<Person>
    {
    }
    
    public partial class PersonService : SkyWeb.DatVM.Data.BaseService<Person>, IPersonService
    {
        public PersonService(SkyWeb.DatVM.Data.IUnitOfWork unitOfWork, Repositories.IPersonRepository repository) : base(unitOfWork, repository)
        {
        }
    }
}
