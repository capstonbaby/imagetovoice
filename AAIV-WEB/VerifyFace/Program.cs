using Microsoft.ProjectOxford.Face;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Text;
using System.Threading;
using System.Threading.Tasks;

namespace VerifyFace
{
    class Program
    {
        private static string imgFolder = @"E:\Capstone Project\Code\New folder\imagetovoice\AAIV-WEB\VerifyFace\ImageSource\";
        private static string personGroupID = "90fbc539-3eb6-4144-bb74-d2b709645296";
        private static string personID = "fae7e6d1-906d-4686-9c85-58f8f224e6af";
        private static int i = 1;
        private static double averageConfidence = 0;
        private static int faceCount = 0;

        static void Main(string[] args)
        {

            TestFace();
        }

        private static async void TestFace()
        {
            FaceServiceClient client = new FaceServiceClient("3fafcdb48bdc4ef6b20d61524bfac93c");

            foreach (var imagePath in Directory.GetFiles(imgFolder))
            {
                try
                {
                    using (Stream s = File.OpenRead(imagePath))
                    {
                        var detectResult = await client.DetectAsync(s);
                        var verifyResult = await client.VerifyAsync(detectResult.First().FaceId, personGroupID, new Guid(personID));

                        averageConfidence += verifyResult.Confidence;
                        faceCount++;

                        Console.WriteLine("#" + i + ": " + verifyResult.Confidence + " | " + verifyResult.IsIdentical);
                        Console.ReadLine();
                        File.Delete(imagePath);

                        Thread.Sleep(6000);
                    }
                }
                catch (Exception)
                {

                    continue;
                }
            }
            Console.WriteLine("Average Confidence = " + averageConfidence / faceCount);
            Console.ReadLine();
        }
    }
}
