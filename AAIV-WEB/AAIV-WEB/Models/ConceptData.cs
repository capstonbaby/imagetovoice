using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAIV_WEB.Models
{
    public class ConceptData
    {
        public string app_id { get; set; }
        public int id { get; set; }
        public double value { get; set; }
        public string name { get; set; }
    }
    public class dataConcept
    {
        public List<ConceptData> data { get; set; }
    }
    public class outputs
    {
        public List<dataConcept> output { get; set; }
    }
}