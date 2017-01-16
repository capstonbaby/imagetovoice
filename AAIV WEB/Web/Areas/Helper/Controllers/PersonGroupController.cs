using System;
using System.Collections.Generic;
using System.Linq;
using System.Threading.Tasks;
using System.Web;
using System.Web.Mvc;
using Web.Areas.Helper.Models;
using Web.Areas.Helper.RestServices;
using Web.Controllers;

namespace Web.Areas.Helper.Controllers
{
    public class PersonGroupController : BaseController
    {
        private PersonGroupRestServices service = new PersonGroupRestServices();
        // GET: Helper/PersonGroup
        public async Task<ActionResult> Index()
        {
            List<PersonGroupCustomModel> model = new List<PersonGroupCustomModel>();

            var personGroupList = await service.getPersonGroupsAsync();
            foreach (var item in personGroupList)
            {
                var personList = await service.getPeopleInGroupAsync(item.personGroupId);
                PersonGroupCustomModel personGroup = new PersonGroupCustomModel()
                {
                    personGroup = item,
                    personList = personList,
                };
                model.Add(personGroup);
            }
            return View(model);
        }
    }
}