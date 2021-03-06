﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated from a template.
//
//     Manual changes to this file may cause unexpected behavior in your application.
//     Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace CapstoneProject.WebAPI.Models.Entities
{
    using System;
    using System.Data.Entity;
    using System.Data.Entity.Infrastructure;
    
    public partial class CapstoneEntities : DbContext
    {
        public CapstoneEntities()
            : base("name=CapstoneEntities")
        {
        }
    
        protected override void OnModelCreating(DbModelBuilder modelBuilder)
        {
            throw new UnintentionalCodeFirstException();
        }
    
        public virtual DbSet<AspNetRole> AspNetRoles { get; set; }
        public virtual DbSet<AspNetUserClaim> AspNetUserClaims { get; set; }
        public virtual DbSet<AspNetUserLogin> AspNetUserLogins { get; set; }
        public virtual DbSet<AspNetUser> AspNetUsers { get; set; }
        public virtual DbSet<Concept> Concepts { get; set; }
        public virtual DbSet<Face> Faces { get; set; }
        public virtual DbSet<Log> Logs { get; set; }
        public virtual DbSet<LogObject> LogObjects { get; set; }
        public virtual DbSet<Person> People { get; set; }
        public virtual DbSet<PersonGroup> PersonGroups { get; set; }
        public virtual DbSet<Picture> Pictures { get; set; }
    }
}
