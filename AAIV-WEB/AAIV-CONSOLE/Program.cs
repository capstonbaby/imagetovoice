using AAIV_WEB.Utils;
using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace AAIV_CONSOLE
{
    class Program
    {
        static void Main(string[] args)
        {
            //string image_Url = @"http://res.cloudinary.com/trains/image/upload/v1489615022/images_2_orhsvz.jpg";
            string getConcept = @"http://127.0.0.1:5000/clarifai/v1.0/getconcepts";
            var getConceptResponse = HttpClientHelper.Get(getConcept);
            getConceptResponse = getConceptResponse.Trim(); // xóa các khoảng trắng vô nghĩ ở 2 đầu
            int count = 1;
            for (int i = 1; i < getConceptResponse.Length; i++)
                if (getConceptResponse[i] == ' ' && getConceptResponse[i - 1] != ' ')
                    count++;
            Console.WriteLine("List Concept:" + getConceptResponse);
            Console.WriteLine("Total Concept:" + count);
            Console.WriteLine("****************************************************************");

            string[] lines = System.IO.File.ReadAllLines(@"D:\giaydep.txt");
            //Console.WriteLine("Contents of imageUrl.txt = ");
            int count_1 = 0;
            int count_2 = 0;
            int count_3 = 0;
            int count_4 = 0;
            int count_5 = 0;
            int count_6 = 0;
            int count_7 = 0;
            int count_8 = 0;
            int count_9 = 0;
            int count_10 = 0;
            foreach (string line in lines)
            {
                //Console.WriteLine("\t" + line);

                string detectURI = Constant.DETECT_API + line;
                var detectResponse = HttpClientHelper.Get(detectURI);
                int count_1_1 = 0;
                int count_1_2 = 0;
                int count_1_3 = 0;
                int count_1_4 = 0;
                int count_1_5 = 0;
                int count_1_6 = 0;
                int count_1_7 = 0;
                int count_1_8 = 0;
                int count_1_9 = 0;
                int count_1_10 = 0;

                var obj = JObject.Parse(detectResponse);
                var conceptList = obj["outputs"][0]["data"]["concepts"];

                int numOfConcept = conceptList.Count();

                //Console.WriteLine("------------List concept has value > 0.9-------------");

                for (int i = 0; i < numOfConcept; i++)
                {
                    int id = (int)conceptList[i]["id"];
                    double value = (double)conceptList[i]["value"];

                    if (value > 0.9)
                    {
                        count_1++;
                        count_1_1++;
                        //Console.WriteLine("ID:" + id + " - Value: " + value);
                    }
                }
                //Console.WriteLine("Total count: " + count_1_1);
                //Console.WriteLine("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");


                //Console.WriteLine("------------List concept has 0.8 < value < 0.9-------------");

                for (int i = 0; i < numOfConcept; i++)
                {
                    int id = (int)conceptList[i]["id"];
                    double value = (double)conceptList[i]["value"];
                    if (value > 0.8 && value < 0.9)
                    {
                        count_2++;
                        count_1_2++;
                        //Console.WriteLine("ID:" + id + " - Value: " + value);

                    }
                }
                //Console.WriteLine("Total count: " + count_1_2);
                //Console.WriteLine("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");


                //Console.WriteLine("------------List concept has 0.7 < value < 0.8-------------");

                for (int i = 0; i < numOfConcept; i++)
                {
                    int id = (int)conceptList[i]["id"];
                    double value = (double)conceptList[i]["value"];
                    if (value > 0.7 && value < 0.8)
                    {
                        count_3++;
                        count_1_3++;
                        //Console.WriteLine("ID:" + id + " - Value: " + value);

                    }
                }
                //Console.WriteLine("Total count: " + count_1_3);
                //Console.WriteLine("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");


                //Console.WriteLine("------------List concept has 0.6 < value < 0.7-------------");

                for (int i = 0; i < numOfConcept; i++)
                {
                    int id = (int)conceptList[i]["id"];
                    double value = (double)conceptList[i]["value"];
                    if (value > 0.6 && value < 0.7)
                    {
                        count_4++;
                        count_1_4++;
                        //Console.WriteLine("ID:" + id + " - Value: " + value);

                    }
                }
                //Console.WriteLine("Total count: " + count_1_4);
                //Console.WriteLine("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");


                //Console.WriteLine("------------List concept has 0.5 < value < 0.6-------------");

                for (int i = 0; i < numOfConcept; i++)
                {
                    int id = (int)conceptList[i]["id"];
                    double value = (double)conceptList[i]["value"];
                    if (value > 0.5 && value < 0.6)
                    {
                        count_5++;
                        count_1_5++;
                        //Console.WriteLine("ID:" + id + " - Value: " + value);

                    }
                }
                //Console.WriteLine("Total count: " + count_1_5);
                //Console.WriteLine("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");


                //Console.WriteLine("------------List concept has 0.4 < value < 0.5-------------");

                for (int i = 0; i < numOfConcept; i++)
                {
                    int id = (int)conceptList[i]["id"];
                    double value = (double)conceptList[i]["value"];
                    if (value > 0.4 && value < 0.5)
                    {
                        count_6++;
                        count_1_6++;
                        //Console.WriteLine("ID:" + id + " - Value: " + value);

                    }
                }
                //Console.WriteLine("Total count: " + count_1_6);
                //Console.WriteLine("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");


                //Console.WriteLine("------------List concept has 0.3 < value < 0.4-------------");
                for (int i = 0; i < numOfConcept; i++)
                {
                    int id = (int)conceptList[i]["id"];
                    double value = (double)conceptList[i]["value"];
                    if (value > 0.3 && value < 0.4)
                    {
                        count_7++;
                        count_1_7++;
                        //Console.WriteLine("ID:" + id + " - Value: " + value);

                    }
                }
                //Console.WriteLine("Total count: " + count_1_7);
                //Console.WriteLine("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");

                //Console.WriteLine("------------List concept has 0.2 < value < 0.3-------------");
                for (int i = 0; i < numOfConcept; i++)
                {
                    int id = (int)conceptList[i]["id"];
                    double value = (double)conceptList[i]["value"];
                    if (value > 0.2 && value < 0.3)
                    {
                        count_8++;
                        count_1_8++;
                        //Console.WriteLine("ID:" + id + " - Value: " + value);

                    }
                }
                //Console.WriteLine("Total count: " + count_1_8);
                //Console.WriteLine("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");

                //Console.WriteLine("------------List concept has 0.1 < value < 0.2-------------");
                for (int i = 0; i < numOfConcept; i++)
                {
                    int id = (int)conceptList[i]["id"];
                    double value = (double)conceptList[i]["value"];
                    if (value > 0.1 && value < 0.2)
                    {
                        count_9++;
                        count_1_9++;
                        //Console.WriteLine("ID:" + id + " - Value: " + value);

                    }
                }
                //Console.WriteLine("Total count: " + count_1_9);
                //Console.WriteLine("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");


                //Console.WriteLine("------------List concept has value < 0.1-------------");
                for (int i = 0; i < numOfConcept; i++)
                {
                    int id = (int)conceptList[i]["id"];
                    double value = (double)conceptList[i]["value"];
                    if (value < 0.1)
                    {
                        count_10++;
                        count_1_10++;
                        //Console.WriteLine("ID:" + id + " - Value: " + value);

                    }
                }
                //Console.WriteLine("Total count: " + count_1_10);
                //Console.WriteLine("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
            }
            Console.WriteLine("Value > 0.9: " + count_1);
            Console.WriteLine("0.8 < value < 0.9: " + count_2);
            Console.WriteLine("0.7 < value < 0.8: " + count_3);
            Console.WriteLine("0.6 < value < 0.7: " + count_4);
            Console.WriteLine("0.5 < value < 0.6: " + count_5);
            Console.WriteLine("0.4 < value < 0.5: " + count_6);
            Console.WriteLine("0.3 < value < 0.4: " + count_7);
            Console.WriteLine("0.2 < value < 0.3: " + count_8);
            Console.WriteLine("0.1 < value < 0.2: " + count_9);
            Console.WriteLine("Value < 0.1: " + count_10);
            Console.ReadLine();
            Console.ReadKey();
        }
    }
}