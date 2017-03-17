using Microsoft.VisualStudio.TestTools.UnitTesting;
using AAIV_WEB.Areas.Admin.Controllers;
using System.Collections.Generic;
using AAIV_WEB.Utils;
using Newtonsoft.Json.Linq;
using AAIV_WEB.Models.Entities.Services;
using System;

namespace AAIV_TEST
{
    [TestClass]
    public class AAIVConceptTest
    {
        [TestMethod]
        public void TestConceptValue(string[] args)
        {
            var url = @"http://g.vatgia.vn/gallery_img/16/bho1362838765.png";
            if (url != null)
            {

                string detectURI = Constant.DETECT_API + url;
                var detectResponse = HttpClientHelper.Get(detectURI);
                if (detectResponse != null)
                {
                    var obj = JObject.Parse(detectResponse);
                    var conceptValue = (double)obj["outputs"][0]["data"]["concepts"][0]["value"];
                    var conceptId = (int)obj["outputs"][0]["data"]["concepts"][0]["id"];
                    int count = 0;
                    string countValue = conceptValue.ToString();

                    if (conceptValue < 0.4)
                    {
                        for(int i = 1; i < countValue.Length; i++)
                        {
                            count++;
                        }
                        Console.WriteLine("Nhỏ hơn 0.4: " + count);
                    }
                    else if (0.5 > conceptValue && conceptValue > 0.4)
                    {
                        for (int i = 1; i < countValue.Length; i++)
                        {
                            count++;
                        }
                        Console.WriteLine("Từ 0.4 đến 0.5: " + count);
                    }
                    else if (0.6 > conceptValue && conceptValue > 0.5)
                    {
                        for (int i = 1; i < countValue.Length; i++)
                        {
                            count++;
                        }
                        Console.WriteLine("Từ 0.5 đến 0.6: " + count);
                    }
                    else if (0.7 > conceptValue && conceptValue > 0.6)
                    {
                        for (int i = 1; i < countValue.Length; i++)
                        {
                            count++;
                        }
                        Console.WriteLine("Từ 0.6 đến 0.7: " + count);
                    }
                    else if (0.8 > conceptValue && conceptValue > 0.7)
                    {
                        for (int i = 1; i < countValue.Length; i++)
                        {
                            count++;
                        }
                        Console.WriteLine("Từ 0.7 đến 0.8: " + count);
                    }
                    else if (0.9 > conceptValue && conceptValue > 0.8)
                    {
                        for (int i = 1; i < countValue.Length; i++)
                        {
                            count++;
                        }
                        Console.WriteLine("Từ 0.8 đến 0.9: " + count);
                    }
                    else if (conceptValue > 0.9)
                    {
                        for (int i = 1; i < countValue.Length; i++)
                        {
                            count++;
                        }
                        Console.WriteLine("Lớn hơn 0.9" + count);
                    }
                    Console.ReadLine();
                    Console.ReadKey();

                }
            }
        }
    }
}

