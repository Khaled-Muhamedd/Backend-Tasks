using System.Diagnostics;
using System.Text;

namespace Assignment_3
{
    internal class Program
    {
        static void Main(string[] args)
        {
            //-----------------------Question 01-----------------------
            //(a) Explain why this code is inefficient. Reference what happens in memory.
            /*First : because => At [Memory] Every time productList += ... is 
             * executed inside the loop, the original string is not modified. 
             * Instead, a new string object is allocated in the memory (Heap) to hold the concatenated result
             
            Second : [The Garbage Collector] => Since the loop runs 5,000 times, the code creates 5,000 temporary
            string objects. These objects quickly fill the memory, forcing the Garbage Collector (GC) to work 
            harder to clean them up, which significantly degrades the application's performance.*/

            //(b) Rewrite this code using StringBuilder to be more efficient.

            StringBuilder productList = new StringBuilder();

            for (int i = 1; i <= 5000; i++)
            {
                productList.Append("PROD-").Append(i).Append(",");
            }

            string finalResult = productList.ToString();

            //(c) Add timing code (using Stopwatch) to both versions and report the time difference

            Stopwatch sw1 = Stopwatch.StartNew();
            string sList = "";
            for (int i = 1; i <= 5000; i++)
            {
                sList += "PROD-" + i + ",";
            }
            sw1.Stop();
            Console.WriteLine($"String Version: {sw1.ElapsedMilliseconds} ms");

            // Version 2: Using StringBuilder
            Stopwatch sw2 = Stopwatch.StartNew();
            StringBuilder sbList = new StringBuilder();
            for (int i = 1; i <= 5000; i++)
            {
                sbList.Append("PROD-").Append(i).Append(",");
            }
            sw2.Stop();
            Console.WriteLine($"StringBuilder Version: {sw2.ElapsedMilliseconds} ms");

            //-----------------------------Question 02: Ticket Pricing System ------------------------------
            //Q02 (A):
            Console.Write("Enter Age: ");
            int age = int.Parse(Console.ReadLine());

            Console.Write("Enter Day of Week (1-7, where 6=Fri, 7=Sat): ");
            int day = int.Parse(Console.ReadLine());

            Console.Write("Do you have a student ID (yes/no): ");
            string hasStudentID = Console.ReadLine().ToLower();

            double basePrice = 0;
            string breakdown = "";

            // Determine Base Price
            if (age < 5)
            {
                basePrice = 0;
                breakdown = "Age < 5: Free";
            }
            else if (age >= 5 && age <= 12)
            {
                basePrice = 30;
                breakdown = "Age 5-12: 30 LE";
            }
            else if (age >= 13 && age <= 59)
            {
                basePrice = 50;
                breakdown = "Age 13-59: 50 LE";
            }
            else if (age >= 60)
            {
                basePrice = 25;
                breakdown = "Age 60+: 25 LE";
            }

            double finalPrice = basePrice;

            // Apply Weekend Surcharge
            if (basePrice > 0 && (day == 6 || day == 7))
            {
                finalPrice += 10;
                breakdown += "\nWeekend Surcharge: +10 EGP";
            }

            // Apply Student Discount
            if (basePrice > 0 && hasStudentID == "yes")
            {
                double discount = finalPrice * 0.20;
                finalPrice -= discount;
                breakdown += $"\nStudent Discount (20%): -{discount} EGP";
            }

            // (c) Display final price and breakdown
            Console.WriteLine("\n--- Price Breakdown ---");
            Console.WriteLine(breakdown);
            Console.WriteLine($"Final Price: {finalPrice} EGP");


            //-----------------------------Qeustion 03)-----------------------------
            //[A] : (a) A traditional switch statement
            string fileExtension = ".pdf";
            string fileType;

            switch (fileExtension)
            {
                case ".pdf":
                    fileType = "PDF Document";
                    break;
                case ".docx":
                case ".doc":
                    fileType = "Word Document";
                    break;
                case ".xlsx":
                case ".xls":
                    fileType = "Excel Spreadsheet";
                    break;
                case ".jpg":
                case ".png":
                case ".gif":
                    fileType = "Image File";
                    break;
                default:
                    fileType = "Unknown File Type";
                    break;
            }
            //[B] : A switch expression
            string FileExtension = ".pdf";

            string FileType = fileExtension switch
            {
                ".pdf" => "PDF Document",
                ".docx" or ".doc" => "Word Document",
                ".xlsx" or ".xls" => "Excel Spreadsheet",
                ".jpg" or ".png" or ".gif" => "Image File",
                _ => "Unknown File Type"
            };
            //----------------------------------Question 04)--------------------------------
            int temperature = 35;

            string weatherAdvice =
                temperature < 0 ? "Freezing! Stay indoors." :
                temperature < 15 ? "Cold. Wear a jacket." :
                temperature < 25 ? "Pleasant weather." :
                temperature < 35 ? "Warm. Stay hydrated." :
                "Hot! Avoid sun exposure.";
            //-------------------------Question 05)-----------------------------------
            string password;
            int attempts = 0;

            while (attempts < 5)
            {
                Console.Write($"Enter Password ({5 - attempts} tries left): ");
                password = Console.ReadLine();

                bool isLong = password.Length >= 8;
                bool hasUpper = false, hasDigit = false, hasSpace = false;

                foreach (char c in password)
                {
                    if (char.IsUpper(c)) hasUpper = true;
                    if (char.IsDigit(c)) hasDigit = true;
                    if (char.IsWhiteSpace(c)) hasSpace = true;
                }

                if (isLong && hasUpper && hasDigit && !hasSpace)
                {
                    Console.WriteLine("Password Accepted!");
                    return;
                }

                attempts++;
                Console.WriteLine("Invalid Password! Try again.");

                if (attempts == 5) Console.WriteLine("Account Locked.");




                //--------------------Question 06----------------------------
                int[] scores = { 85, 42, 91, 67, 55, 78, 39, 88, 72, 95, 60, 48 };

                // (a) Find and display all failing scores (below 50)
                Console.Write("Failing scores: ");
                foreach (int s in scores)
                {
                    if (s < 50) Console.Write(s + " ");
                }

                // (b) Find the first score above 90
                Console.WriteLine("\n----------------------------");
                foreach (int s in scores)
                {
                    if (s > 90)
                    {
                        Console.WriteLine($"First score above 90: {s}");
                        break; // Stop searching immediately
                    }
                }

                // (c) Calculate class average (excluding scores below 40)
                double sum = 0;
                int count = 0;
                foreach (int s in scores)
                {
                    if (s >= 40)
                    {
                        sum += s;
                        count++;
                    }
                }
                Console.WriteLine($"Class Average (excluding absent): {sum / count:F2}");

                // (d) Count grade ranges
                int a = 0, b = 0, c = 0, d = 0, f = 0;
                foreach (int s in scores)
                {
                    if (s >= 90) a++;
                    else if (s >= 80) b++;
                    else if (s >= 70) c++;
                    else if (s >= 60) d++;
                    else f++;
                }
                Console.WriteLine($"Grades Count: A:{a}, B:{b}, C:{c}, D:{d}, F:{f}");
            }
        }
    }
}
