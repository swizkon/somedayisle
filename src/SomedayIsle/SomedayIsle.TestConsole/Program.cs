using SomedayIsle.Projections;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using StructureMap;
using System.Configuration;
using System.Diagnostics;
using Nuclear.Messaging;
using Nuclear.Lazy;

namespace SomedayIsle.TestConsole
{
    public class Program
    {
        // IContainer ioc;

        static IContainer ConfigureContainer()
        {
            var container = new Container(cfg =>
            {
                cfg.For<Bus>().Use<Switchboard>();

                var store = cfg.ForConcreteType<MySqlAgent>().Configure;
                store
                    .Ctor<string>("connectionString")
                    .Is("Server=127.0.0.1;Database=somedayisle_projections;Uid=NHibernate;Pwd=NHibernate;");
            });

            return container;
        }



        static void Main(string[] args)
        {
            var settings = ConfigurationManager.AppSettings;
            var ioc = ConfigureContainer();


            IDictionary<Guid, string> journeys = new Dictionary<Guid, string>()
            {
                {Guid.NewGuid(), ""}
            };
            
            Bus bus = ioc.GetInstance<Bus>();



            // bus.Send()



            var agent = ioc.GetInstance<MySqlAgent>();

            string journeyName = null;

            do {
                Console.WriteLine("Enter a name of a journey:");
                journeyName = Console.ReadLine();

                if (!String.IsNullOrEmpty(journeyName))
                    agent.CreateJourney(Guid.NewGuid(), journeyName, "");

            } while(!String.IsNullOrEmpty(journeyName));



            var storedJourneys = agent.Journeys();

            foreach (var storedJourney in storedJourneys)
            {
                Console.WriteLine(storedJourney.Title);
                agent.DropJourney(storedJourney.Id);
            }

            if(Environment.UserInteractive)
            {
                Console.WriteLine("PRESS ANY KEY TO EXIT");
                Console.ReadKey();
            }
        }
    }
}
