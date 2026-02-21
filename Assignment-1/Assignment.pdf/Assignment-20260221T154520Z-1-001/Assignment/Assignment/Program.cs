using System;
using System.Collections.Generic;
using System.Linq;

namespace CSharpAssignment
{
    class Program
    {
        // Class-level field for scope demonstrations
        static int classField = 100;

        static void Main(string[] args)
        {
            Console.WriteLine("╔════════════════════════════════════════════════════════════════════╗");
            Console.WriteLine("║           C# FUNDAMENTALS - ASSIGNMENT WITH ANSWERS                ║");
            Console.WriteLine("║                      20 Questions                                  ║");
            Console.WriteLine("╚════════════════════════════════════════════════════════════════════╝\n");



            #region Question 1: Regions
            // ══════════════════════════════════════════════════════════════════════
            // QUESTION 2: REGIONS
            // ══════════════════════════════════════════════════════════════════════
            //
            // Q: What is the purpose of #region and #endregion directives in C#? 
            //    How do they help in code organization?
            //
            // ══════════════════════════════════════════════════════════════════════

            //Nested Region Example
            //[ ANSWER ]
            /*region and endregion help us to define the block of code to organize it that you can expand or collapse it*/

            Console.WriteLine("\n" + new string('-', 70) + "\n");
            #endregion

            #region Question 2: Variable Declaration - Explicit vs Implicit
            // ══════════════════════════════════════════════════════════════════════
            // QUESTION 3: VARIABLE DECLARATION - EXPLICIT VS IMPLICIT
            // ══════════════════════════════════════════════════════════════════════
            //
            // Q: What is the difference between explicit and implicit variable 
            //    declaration in C#? Provide examples of both.
            //
            // ══════════════════════════════════════════════════════════════════════



            // EXPLICIT DECLARATION 

            //[ ANSWER ]
            /*In an explicit declaration, you specifically state the data type (e.g., int, string, bool)
             * before the variable name. The compiler knows exactly what type of data the variable will
             * hold because you told it.*/
            int age = 25;
            string name = "Gemini";
            double price = 19.99;

            // IMPLICIT DECLARATION 
            //[ ANSWER ]
            /*In an implicit declaration, you use the var keyword, and the compiler infers the data type 
             * based on the value you assign to the variable. The compiler determines the type at compile time.*/
            var city = "New York"; // Inferred as string
            #endregion

            #region Question 3: Constants
            // ══════════════════════════════════════════════════════════════════════
            // QUESTION 4: CONSTANTS
            // ══════════════════════════════════════════════════════════════════════
            //
            // Q: Write the syntax for declaring a constant in C#. Why would you use 
            //    a constant instead of a regular variable?
            //
            // ══════════════════════════════════════════════════════════════════════



            // Constant examples
            //[ ANSWER ]
            /*In C#, a constant is a type of field or local variable whose value is set at
             * compile time and can never be changed during the execution of the program.*/

            const double Pi = 3.14159;
            #endregion

            #region Question 4: Class-level vs Method-level Scope
            // ══════════════════════════════════════════════════════════════════════
            // QUESTION 4: CLASS-LEVEL VS METHOD-LEVEL SCOPE
            // ══════════════════════════════════════════════════════════════════════
            //
            // Q: Explain the difference between class-level scope and method-level 
            //    scope with examples.
            //
            // ══════════════════════════════════════════════════════════════════════
            //[ ANSWER ]
            /*[1]=> Class-level scope refers to variables that are declared within a class but outside of any method. 
             * These variables are accessible to all methods within the class. For example, the 'classField' variable 
             * declared at the top of the Program class is a class-level variable and can be accessed by any method in the class.
              [2] => Method-level scope refers to variables that are declared within a method. These variables are only accessible within that method and cannot be
            accessed outside of it. For example, the 'age', 'name', and 'price' variables declared in the Main method are method-level variables and cannot be accessed outside of the Main method.*/
            #endregion

            #region Question 5: Block-level Scope
            // ══════════════════════════════════════════════════════════════════════
            // QUESTION 5: BLOCK-LEVEL SCOPE
            // ══════════════════════════════════════════════════════════════════════
            //
            // Q: What is block-level scope? Give an example showing a variable that 
            //    is only accessible within a specific block.
            //
            // ══════════════════════════════════════════════════════════════════════

            //[ ANSWER ]
            /*Block-level scope refers to variables that are declared within a specific block of code, such as within an if statement, loop, or any set of curly braces {}. 
             * These variables are only accessible within that block and cannot be accessed outside of it. For example:*/
            #endregion

            #region Question 6: Variable Lifetime - Local vs Static
            // ══════════════════════════════════════════════════════════════════════
            // QUESTION 6: VARIABLE LIFETIME - LOCAL VS STATIC
            // ══════════════════════════════════════════════════════════════════════
            //
            // Q: What is variable lifetime? Explain the lifetime of local variables 
            //    vs static variables.
            //
            // ══════════════════════════════════════════════════════════════════════

            //[ ANSWER ]
            /*Variable lifetime refers to the duration of time that a variable exists in memory during the execution of a program. 
             * [1] Local variables are created when a method is called and destroyed when the method exits. They only exist within the scope of that method. 
             * Static variables, on the other hand, are associated with the class rather than any instance of the class. They are created when the class
             * is first loaded and remain in memory for the entire duration of the program.
             * [2] Static variables can be accessed by all instances of the class
             * and even without creating an instance.*/

            #endregion

            #region Question 7: Garbage Collector
            // ══════════════════════════════════════════════════════════════════════
            // QUESTION 7: GARBAGE COLLECTOR
            // ══════════════════════════════════════════════════════════════════════
            //
            // Q: What is the Garbage Collector in C#? How does it affect the 
            //    lifetime of objects?
            //
            // ══════════════════════════════════════════════════════════════════════
            //[ ANSWER ]

            /*The Garbage Collector (GC) in C# is an automatic memory management system that helps to manage the allocation and release of memory for objects. 
             * The GC automatically frees up memory occupied by objects that are no longer in use, which helps to prevent memory leaks and optimize memory usage. 
             * When an object is created, it is allocated on the heap, and the GC keeps track of it. When there are no references to an object, the GC considers it eligible for collection and will eventually free the memory occupied by that object. 
             * This means that the lifetime of objects in C# is determined by their references and the GC's ability to identify when they are no longer needed.*/

            #endregion

            #region Question 8: Variable Shadowing
            // ══════════════════════════════════════════════════════════════════════
            // QUESTION 8: VARIABLE SHADOWING
            // ══════════════════════════════════════════════════════════════════════
            //
            // Q: What is variable shadowing in C#? Does C# allow shadowing in 
            //    nested blocks within the same method?
            //
            // ══════════════════════════════════════════════════════════════════════
            //[ ANSWER ]
            /*Variable shadowing occurs when a variable declared within a certain scope (e.g., a local variable) has the same name as a variable declared in an outer scope
             * (e.g., a class-level field*/
            #endregion

            #region Question 9: C# Naming Rules
            // ══════════════════════════════════════════════════════════════════════
            // QUESTION 9: C# NAMING RULES
            // ══════════════════════════════════════════════════════════════════════
            //
            // Q: List five rules that must be followed when naming variables in C#.
            //
            // ══════════════════════════════════════════════════════════════════════
            //[ ANSWER ]
            /*1. Variable names must start with a letter or an underscore (_). They cannot start with a number or any other special character.
             * 2. Variable names can only contain letters, digits, and underscores. They cannot contain spaces or special characters.
             * 3. Variable names are case-sensitive, meaning that 'myVariable' and 'MyVariable' would be considered different variables.
             * 4. Variable names cannot be the same as C# reserved keywords (e.g., int, string, class).
             * 5. Variable names should be descriptive and meaningful to improve code readability. It is recommended
             * to use camelCase for local variables and PascalCase for class names and constants.*/
            #endregion

            #region Question 10: Naming Conventions
            // ══════════════════════════════════════════════════════════════════════
            // QUESTION 10: NAMING CONVENTIONS
            // ══════════════════════════════════════════════════════════════════════
            //
            // Q: What naming conventions are recommended for: (a) local variables, 
            //    (b) class names, (c) constants?
            //
            // ══════════════════════════════════════════════════════════════════════

            //[ ANSWER ]
            /*a) Local variables: camelCase (Ex-1)=> myVariable, userName)
             * b) Class names: PascalCase (EX-2)=> MyClass, Customer)
             * c) Constants: PascalCase (EX-3)=> Pi, MaxValue)*/
            #endregion

            #region Question 11: Error Types
            // ══════════════════════════════════════════════════════════════════════
            // QUESTION 11: ERROR TYPES
            // ══════════════════════════════════════════════════════════════════════
            //
            // Q: Compare and contrast syntax errors, runtime errors, and logical 
            //    errors. Provide an example of each.
            //
            // ══════════════════════════════════════════════════════════════════════
            //[ ANSWER ]
            /*1. Syntax Errors: These occur when the code violates
             * the rules of the C# language. They are detected by the compiler and prevent the program from running.*/
            #endregion

            #region Question 12: Exception Handling Importance
            // ══════════════════════════════════════════════════════════════════════
            // QUESTION 12: EXCEPTION HANDLING IMPORTANCE
            // ══════════════════════════════════════════════════════════════════════
            //
            // Q: Why is exception handling important in C#? What would happen if 
            //    you don't handle exceptions?
            //
            // ══════════════════════════════════════════════════════════════════════
            //[ ANSWER ]
            /*Exception handling is important in C# because it allows developers to gracefully handle errors and unexpected situations that may occur during the execution of a program. 
             * If exceptions are not handled, they can cause the program to crash or behave unpredictably, leading to a poor user experience. 
             * Unhandled exceptions can also expose sensitive information about the application's internals, which can be a security risk. 
             * By using try-catch blocks and other exception handling mechanisms, developers can catch and manage exceptions, providing informative error messages to users and allowing the program to continue running or shut down gracefully.*/

            #endregion

            #region Question 13: try-catch-finally
            // ══════════════════════════════════════════════════════════════════════
            // QUESTION 13: TRY-CATCH-FINALLY
            // ══════════════════════════════════════════════════════════════════════
            //
            // Q: Write a code example demonstrating try-catch-finally. Explain when 
            //    the finally block executes.
            //
            // ══════════════════════════════════════════════════════════════════════
            //[ ANSWER ]
            try
            {
                // The code that might throw an exception
                int input = int.Parse(Console.ReadLine());
                int result = 100 / input;
                Console.WriteLine($"Result: {result}");
            }
            catch (DivideByZeroException ex)
            {
                // Executes ONLY if the user enters 0
                Console.WriteLine("Error: You cannot divide by zero!");
            }
            catch (FormatException ex)
            {
                // Executes ONLY if the user enters text instead of a number
                Console.WriteLine("Error: Please enter a valid numerical digit.");
            }
            #endregion

            #region Question 14: Common Built-in Exceptions
            // ══════════════════════════════════════════════════════════════════════
            // QUESTION 14: COMMON BUILT-IN EXCEPTIONS
            // ══════════════════════════════════════════════════════════════════════
            //
            // Q: List and explain five common built-in exceptions in C# with 
            //    scenarios when each would occur.
            //
            // ══════════════════════════════════════════════════════════════════════
            //[ ANSWER ]
            /*1. NullReferenceException: This exception occurs when you try to access a member of an object that is null. For example, if you declare a string variable but do not initialize it, and then try to call a method on it, you will get a NullReferenceException.
             * 2. IndexOutOfRangeException: This exception occurs when you try to access an index of an array or collection that is outside its bounds. For example, if you have an array of size 5 and try to access the element at index 10, you will get an IndexOutOfRangeException.
             * 3. InvalidOperationException: This exception occurs when a method call is invalid for the object's current state. For example, if you try to read from a closed file stream, you will get an InvalidOperationException.
             * 4. FormatException: This exception occurs when the format of an argument does not meet the parameter specifications of the invoked method. For example, if you try to parse a non-numeric string into an integer using int.Parse(), you will get a FormatException.
             * 5. DivideByZeroException: This exception occurs when you attempt to divide an integer by zero. For example, if you have an integer variable with a value of zero and try to divide another integer by it, you will get a DivideByZeroException.*/
            #endregion

            #region Question 15: Multiple catch Blocks
            // ══════════════════════════════════════════════════════════════════════
            // QUESTION 15: MULTIPLE CATCH BLOCKS
            // ══════════════════════════════════════════════════════════════════════
            //
            // Q: Why is the order of catch blocks important when handling multiple 
            //    exceptions? Write code showing correct ordering.
            //
            // ══════════════════════════════════════════════════════════════════════
            //[ ANSWER ]
            /* The order of catch blocks is important because C# evaluates them from top to bottom.
             * If a more general exception type (e.g., Exception) is placed before a more specific
             * exception type (e.g., DivideByZeroException), the general catch block will catch all
             * exceptions, including the specific ones, and the specific catch block will never be reached.*/

            #endregion

            #region Question 16: throw Keyword
            // ══════════════════════════════════════════════════════════════════════
            // QUESTION 16: THROW KEYWORD
            // ══════════════════════════════════════════════════════════════════════
            //
            // Q: What is the difference between 'throw' and 'throw ex' when 
            //    re-throwing an exception? Which one preserves the stack trace?
            //
            // ══════════════════════════════════════════════════════════════════════
            //[ ANSWER ]
            /*The 'throw' keyword is used to re-throw the current exception while preserving the original stack trace. When you use 'throw' without specifying an exception, it re-throws the exception that was caught in the catch block, allowing you to maintain the original context of the error.
             * On the other hand, 'throw ex' creates a new exception object and throws it, which resets the stack trace to the point where 'throw ex' is called. This means that you lose the original stack trace information, making it harder to diagnose where the exception originally occurred. Therefore, using 'throw'
             * is generally recommended when re-throwing exceptions to preserve the stack trace.*/
            #endregion

            #region Question 17: Stack and Heap Memory
            // ══════════════════════════════════════════════════════════════════════
            // QUESTION 17: STACK AND HEAP MEMORY
            // ══════════════════════════════════════════════════════════════════════
            //
            // Q: Explain the differences between Stack and Heap memory in C#. 
            //    What types of data are stored in each?
            //
            // ══════════════════════════════════════════════════════════════════════
            //  [ ANSWER ]
            /*Stack memory is a region of memory that stores value types (e.g., int, double, bool) and reference type references (e.g., object references). It operates in a last-in-first-out (LIFO) manner, meaning that the most recently added item is the first one to be removed. Stack memory is automatically managed and is typically faster than heap memory. When a method is called, its local variables are allocated on the stack, and when the method returns, those variables are automatically deallocated.
             * Heap memory, on the other hand, is a region of memory used for dynamic allocation of objects and reference types (e.g., classes, arrays). When you create an object using the 'new' keyword, it is allocated on the heap. Heap memory is managed by the Garbage Collector, which automatically frees up memory occupied by objects that are no longer in use. Heap memory allows for more flexible memory management but can be slower than stack memory due to the overhead of dynamic allocation and garbage collection.*/

            #endregion

            #region Question 18: Value Types vs Reference Types
            // ══════════════════════════════════════════════════════════════════════
            // QUESTION 18: VALUE TYPES VS REFERENCE TYPES
            // ══════════════════════════════════════════════════════════════════════
            //
            // Q: Write a code example showing how value types and reference types 
            //    behave differently when assigned to another variable.
            //
            // ══════════════════════════════════════════════════════════════════════
            //[ ANSWER ]
            //value type example
            int val1 = 10;
            int val2 = val1;
            val2 = 20;
            //structs => structures
            //reference type example

//classes 
//interfaces
//string 
//Arrays

            #endregion

#region Question 19: Object in C#
// ══════════════════════════════════════════════════════════════════════
// QUESTION 19: OBJECT IN C#
// ══════════════════════════════════════════════════════════════════════
//
// Q: Why is 'object' considered the base type of all types in C#? 
//    What methods does every type inherit from System.Object?
//
// ══════════════════════════════════════════════════════════════════════
//[ ANSWER ]
/*In C#, 'object' is considered the base type of all types because every type in
 * C# ultimately derives from the System.Object class. This means

#endregion

}


}


}