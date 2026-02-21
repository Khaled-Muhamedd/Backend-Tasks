using System.Diagnostics;

namespace console_Application_2
{
    internal class Program
    {
        #region Methods (Functions)

        static Grade GetGrade(int score)
        {
            if (score >= 90) return Grade.A;
            if (score >= 80) return Grade.B;
            if (score >= 70) return Grade.C;
            if (score >= 60) return Grade.D;
            return Grade.F;
        }
        //average score
        static double CalculateAverage(int[] scores)
        {
            int sum = 0;
            for (int i = 0; i < scores.Length; i++)
            {
                sum += scores[i];
            }
            return (double)sum / scores.Length;
        }
        //get the minimum and maximum score
        static void GetMinMax(int[] scores, out int min, out int max)
        {
            min = scores[0];
            max = scores[0];

            for (int i = 1; i < scores.Length; i++)
            {
                if (scores[i] < min) min = scores[i];
                if (scores[i] > max) max = scores[i];
            }
        }
        #endregion
        static void Main(string[] args)
        {
            int[] studentScores = new int[5];

            for (int i = 0; i < studentScores.Length; i++)
            {
                Console.Write($"Enter score for Student {i + 1}: ");
                studentScores[i] = int.Parse(Console.ReadLine());
            }

            Console.WriteLine("\n--- Report ---");
            for (int i = 0; i < studentScores.Length; i++)
            {
                int currentScore = studentScores[i];
                Grade currentGrade = GetGrade(currentScore); 
                Console.WriteLine($"Student {i + 1}: {currentScore} -> Grade: {currentGrade}");
            }

            double avg = CalculateAverage(studentScores);

            int minScore, maxScore;
            GetMinMax(studentScores, out minScore, out maxScore);

            Console.WriteLine($"\nAverage: {avg:F1}");
            Console.WriteLine($"Minimum Score: {minScore}");
            Console.WriteLine($"Highest Score: {maxScore}");

            Console.ReadKey();
        }
    }
}
