using System;
using System.IO;
using iTextSharp.text;
using iTextSharp.text.pdf;

namespace LabelSplitterNet
{
    class MainClass
    {
        public static void Main(string[] args)
        {
            var shipperType = 1; //ups

            var rectangle1 = new Rectangle(20, 55, 570, 380);
            var rectangle2 = new Rectangle(10, 40, 390, 260);
            var x = -380;
            var y = 280;

            if (shipperType == 2) //fedex
            {
                rectangle1 = new Rectangle(10, 40, 645, 430);
                rectangle2 = new Rectangle(10, 40, 390, 260);
                x = -410;
                y = 280;
            }

            var urlPDF = Directory.GetCurrentDirectory() + "/package.pdf";
            var urlPDFOutput = Directory.GetCurrentDirectory() + "/packagePrint.pdf";
                        
            var reader = new PdfReader(urlPDF);
			var document = new Document();

			var writer = PdfWriter.GetInstance(document, new FileStream(urlPDFOutput, FileMode.Create, FileAccess.Write));
			document.Open();
			var cb = writer.DirectContent;

            for (int i = 1; i <= reader.NumberOfPages; i++)
            {
                document.SetPageSize(rectangle1);
				document.NewPage();

                var page = writer.GetImportedPage(reader, i);

				cb.AddTemplate(page, 0, 0);

                document.SetPageSize(rectangle2);
				document.NewPage();

				cb.AddTemplate(page, 0, -1, 1, 0, x, y);
            }

			document.Close();
            writer.Close();


			Console.WriteLine("Label Creator Done!");
            //Console.ReadLine();
        }
    }
}
