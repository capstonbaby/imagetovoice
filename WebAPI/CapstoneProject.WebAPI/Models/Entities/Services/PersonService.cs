using AutoMapper.QueryableExtensions;
using CapstoneProject.WebAPI.Models.ViewModels;
using System.Linq;
using System.Threading.Tasks;

namespace CapstoneProject.WebAPI.Models.Entities.Services
{
    public partial interface IPersonService
    {
        Task CreatePersonAsync(PersonViewModel model);
        IQueryable<Person> GetAllPerson();
    }

    public partial class PersonService
    {
        public async Task CreatePersonAsync(PersonViewModel model)
        {
            var person = model.ToEntity();
            await CreateAsync(person);
        }

        public IQueryable<Person> GetAllPerson()
        {
            var entity = GetActive();
            return entity;
        }
    }
}