namespace Assignment_4
{
    internal class Program
    {
        //Functions
        #region Functions
        #region Question 1
        #region Add
        static double Add(double a, double b)
        {
            return a + b;
        }
        #endregion

        #region subtract
        static double Subtract(double a, double b)
        {
            return a - b;
        }
        #endregion

        #region Multiply
        static double Multiply(double a, double b)
        {
            return a * b;
        }
        #endregion

        #region devide
        static double Devide(double a, double b)
        {
            if (b == 0)
            {
                Console.WriteLine("Error: Division by zero is not allowed.");
                return double.NaN; // Return Not-a-Number to indicate an error
            }
            return a / b;
        }
        #endregion
        #endregion

        #region Question 2
        static void CalculateCircle(double radius, out double area, out double circumference)
        {
            area = Math.PI * Math.Pow(radius, 2);

            circumference = 2 * Math.PI * radius;
        }
        #endregion
        #endregion
        static void Main(string[] args)
        {
            #region enum
            //int dayNumber;
            //bool isvalid;

            //do
            //{
            //    Console.WriteLine($"Enter the Day Of the number(1-7)");
            //    // TryParse method is used to convert the user input to an integer and check if it's a valid number between 1 and 7
            //    isvalid = int.TryParse(Console.ReadLine(), out dayNumber) && (dayNumber >= 1 && dayNumber <= 7);

            //    // If the input is valid, it casts the integer to the DaysOfWeek enum and prints the corresponding day. Otherwise, it prompts the user to enter a valid number.
            //    if (isvalid)
            //    {
            //        // Explict casting from int to enum
            //        DayOfWeek SelectedDay = (DayOfWeek)(dayNumber - 1);
            //        Console.WriteLine($"Day :{SelectedDay}");
            //        switch (SelectedDay)
            //        {
            //            case DayOfWeek.Saturday:
            //            case DayOfWeek.Friday:
            //                Console.WriteLine("It's a weekend!");
            //                break;
            //            default:
            //                Console.WriteLine("It's a workday.");
            //                break;
            //        }
            //    }
            //    else
            //    {
            //        Console.WriteLine("Invalid input. Please enter a number between 1 and 7.");
            //    }
            //} while (true);
            #endregion

            #region Arrays 

            #region Question 1
            //Console.WriteLine("Enter the size Of Array:");
            //if (!int.TryParse(Console.ReadLine(), out int size) || size <= 0)
            //{
            //    Console.WriteLine("Invalid size! Please enter a positive number.");
            //    return;
            //}

            //int[] numbers = new int[size];
            //int sum = 0;

            //for (int i = 0; i < size; i++)
            //{
            //    Console.Write($"Enter element {i + 1}: ");

            //    if (int.TryParse(Console.ReadLine(), out numbers[i]))
            //    {
            //        sum += numbers[i];
            //    }
            //    else
            //    {
            //        Console.WriteLine("Invalid input, skipping this element...");
            //        i--;
            //    }
            //}

            //double average = (double)sum / size;

            //Console.WriteLine("\n--- Results ---");
            //Console.WriteLine($"Sum of elements: {sum}");
            //Console.WriteLine($"Average: {average:F2}");
            #endregion

            #region Question 2 student grade
            //int studentNumbrer = 3;
            //int studentGrade = 4;
            //int[,] student = new int[studentNumbrer, studentGrade];
            //double classSum = 0;

            //Console.WriteLine("Enter Student Number And Stuedent Grade");
            //for (int i = 0; i < student.GetLength(0); i++)
            //{
            //    Console.WriteLine($"Enter Student{i + 1}");
            //    {
            //        for (int j = 0; j < student.GetLength(1); j++)
            //        {
            //            bool isValidGrade;
            //            do
            //            {
            //                Console.WriteLine($"Enter the grade for subject {j + 1}");
            //                student[i, j] = int.Parse(Console.ReadLine());
            //            } while (student[i, j] < 0 || student[i, j] > 100);
            //            Console.WriteLine();
            //        }
            //    }
            //}
            //Console.WriteLine("\n--- Final Results ---");
            //for (int i = 0; i < 3; i++)
            //{
            //    double studentSum = 0;
            //    for (int j = 0; j < 4; j++)
            //    {
            //        studentSum += student[i, j];
            //    }

            //    double studentAvg = studentSum / 4;
            //    classSum += studentSum;
            //    Console.WriteLine($"Student {i + 1} Average: {studentAvg}");
            //}
            #endregion
            #endregion

            #region Functions

            #region Question 1
            Console.WriteLine("Enter Firs Number");
            int num1 = int.Parse(Console.ReadLine());   
            Console.WriteLine("Enter Second Number");
            int num2 = int.Parse(Console.ReadLine());
            Console.WriteLine("choose operation: +, -, *, /");
            char operation =char.Parse(Console.ReadLine());
            double result = 0;

            switch (operation)
            {
                case '+':
                    result = Add(num1, num2); break;
                    case '-':
                    result = Subtract(num1, num2); break;
                    case '*':
                    result = Multiply(num1, num2); break;
                    case '/':
                    result = Devide(num1, num2); break;
                    default:
                    Console.WriteLine("Invalid operation! Please choose +, -, *, or /.");
                    break;
            }
            Console.WriteLine($"Result : {result}");
            #endregion

            #region Question 2
            Console.WriteLine("--- Circle Calculator ---");
            Console.Write("Enter the radius: ");
            double r = double.Parse(Console.ReadLine());

            double resultArea;
            double resultCircum;

            CalculateCircle(r, out resultArea, out resultCircum);

            Console.WriteLine($"The Area is: {resultArea:F2}");
            Console.WriteLine($"The Circumference is: {resultCircum:F2}");
            #endregion
            #endregion

        }
    }
}


