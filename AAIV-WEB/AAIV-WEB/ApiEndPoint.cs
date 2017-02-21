using AAIV_WEB.Models.Entities;
using AutoMapper;
using SkyWeb.DatVM.Mvc.Autofac;
using System;
using System.Reflection;

namespace AAIV_WEB
{
    public class ApiEndPoint
    {
        public static void Entry(Action<IMapperConfiguration> additionalMapperConfig, params Autofac.Module[] additionalModules)
        {
            Action<IMapperConfiguration> fullMapperConfig = q =>
            {
                ApiEndPoint.ConfigAutoMapper(q);

                if (additionalMapperConfig != null)
                {
                    additionalMapperConfig(q);
                }
            };

            AutofacInitializer.Initialize(
                Assembly.GetExecutingAssembly(),
                typeof(CapstoneEntities),
                new MapperConfiguration(fullMapperConfig),
                additionalModules);
        }



        private static void ConfigAutoMapper(IMapperConfiguration config)
        {
            config.CreateMissingTypeMaps = true;
            config.AllowNullDestinationValues = false;
        }
    }
}