using CloudinaryDotNet;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace AAIV_WEB.Utils
{
    public static class Constant
    {
        public const string DEL_IMG_API = @"http://127.0.0.1:5000/clarifai/v1.0/deleteimage" + "?imageId=";
        public const string CREATE_CONCEPT_API = @"http://127.0.0.1:5000/clarifai/v1.0/createconcept" + "?id=";
        public const string CREATE_IMG_API = @"http://127.0.0.1:5000/clarifai/v1.0/createimage";
        public const string DETECT_API = @"http://127.0.0.1:5000/clarifai/v1.0/image" + "?url=";
        public const string DEL_CONCEPT_API = @"http://127.0.0.1:5000/clarifai/v1.0/deleteconcepts" + "?name=";
        public const string TRAIN_API = @"http://127.0.0.1:5000/clarifai/v1.0/trainmodel";
        public static string Get_Create_IMG_API_URL(string url, int conceptid)
        {
            return CREATE_IMG_API + "?url=" + url + "&conceptid=" + conceptid;
        }
    }
}