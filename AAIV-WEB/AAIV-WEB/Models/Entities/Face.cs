//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace AAIV_WEB.Models.Entities
{
    using System;
    using System.Collections.Generic;
    
    public partial class Face
    {
        public int ID { get; set; }
        public int PersonID { get; set; }
        public string PersistedFaceId { get; set; }
        public string ImageURL { get; set; }
        public bool Active { get; set; }
    
        public virtual Person Person { get; set; }
    }
}
