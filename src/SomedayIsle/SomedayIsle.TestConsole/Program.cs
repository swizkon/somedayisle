using SomedayIsle.Projections;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SomedayIsle.TestConsole
{
    public class Program
    {
        static void Main(string[] args)
        {
            MySqlAgent agent = new MySqlAgent();

            string journeyName = null;

            do {
                Console.WriteLine("Enter a name of a journey:");
                journeyName = Console.ReadLine();
                agent.CreateJourney(Guid.NewGuid(), journeyName, "");
            } while(!String.IsNullOrEmpty(journeyName));

            var journeys = agent.Journeys();

            foreach (var journey in journeys)
            {
                Console.WriteLine(journey.Title);
                agent.DropJourney(journey.Id);
            }

            Console.ReadKey();
        }
    }
}
