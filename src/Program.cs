using System;

namespace deliverable
{
    class Program
    {
        // hard code the audience for now.
        private static readonly string _audience = "Aaron Cope";
        static void Main(string[] args)
        {
            var s = new dependency.Salutation();
            Console.WriteLine(s.Compose(_audience));
        }
    }
}