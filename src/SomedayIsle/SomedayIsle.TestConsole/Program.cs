using SomedayIsle.Projections;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using StructureMap;

namespace SomedayIsle.TestConsole
{
    public class Program
    {
        // IContainer ioc;

        static IContainer ConfigureContainer()
        {
            var container = new Container(cfg =>
            {
                /*
                cfg .For<MySqlAgent>()
                    .Use<MySqlAgent>()
                    .Ctor<string>("connectionString")
                    .Is("Server=127.0.0.1;Database=somedayisle_projections;Uid=NHibernate;Pwd=NHibernate;");
                */
                var store = cfg.ForConcreteType<MySqlAgent>().Configure;
                store
                    .Ctor<string>("connectionString")
                    .Is("Server=127.0.0.1;Database=somedayisle_projections;Uid=NHibernate;Pwd=NHibernate;");
            });


            return container;

        }

        static void Main(string[] args)
        {
            //  "Server=127.0.0.1;Database=somedayisle_projections;Uid=NHibernate;Pwd=NHibernate;";

            var ioc = ConfigureContainer();

            var db = ioc.GetInstance<MySqlAgent>();

            // string connString = "Server=127.0.0.1;Database=somedayisle_projections;Uid=NHibernate;Pwd=NHibernate;";

            var agent = ioc.GetInstance<MySqlAgent>();

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
