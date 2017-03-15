using Microsoft.VisualStudio.TestTools.UnitTesting;
using AAIV_WEB.Areas.Admin.Controllers;
using System.Collections.Generic;

namespace AAIV_TEST
{
    [TestClass]
    public class AAIVConceptTest
    {
        [TestMethod]
        public void TestConceptValue(string url)
        {
                double checkValue = 0.4;
                ObjectController objController = new ObjectController();
                KeyValuePair<int,double> value = objController.getValueConcept(url);
                //Assert.AreEqual(true, (value > checkValue));
        }
    }
}
