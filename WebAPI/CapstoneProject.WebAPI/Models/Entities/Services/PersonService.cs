using CapstoneProject.WebAPI.Models.ViewModels;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;

namespace CapstoneProject.WebAPI.Models.Entities.Services
{
    public partial interface IPersonService
    {
        Task CreatePersonAsync(PersonViewModel model);
    }

    public partial class PersonService
    {
        public async Task CreatePersonAsync(PersonViewModel model)
        {
            var person = model.ToEntity();
            await CreateAsync(person);
        }
    }
}