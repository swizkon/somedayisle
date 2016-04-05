using EventStore.ClientAPI;
using EventStore.ClientAPI.SystemData;
using Newtonsoft.Json;
using Newtonsoft.Json.Linq;
using Nuclear.Domain;
using Nuclear.EventSourcing;
using Nuclear.EventSourcing.MySql;
using Nuclear.EventStore;
using Nuclear.Lazy;
using Nuclear.Messaging;
using SomedayIsle.Planning.Commands;
using SomedayIsle.Planning.Events;
using SomedayIsle.Planning.Models;
using SomedayIsle.Projections;
using StructureMap;
using System;
using System.Configuration;
using System.Net;
using System.Text;
using MassTransit;

namespace SomedayIsle.TestConsole
{
    /*
    public class SimpleConfig
    {
        private int tick;
        public SimpleConfig()
        {
            this.tick = Environment.TickCount;
            Console.WriteLine("SimpleConfig() at " + this.tick);
        }

        public int Tick()
        {
            return this.tick;
        }
    }
    */

    public class Broker
    {
        // MassTransit.Bus; 
        public Broker()
        {
            var b = MassTransit.Bus.Factory.CreateUsingInMemory(cfg =>
            {
                cfg.ReceiveEndpoint("queue_name", ep =>
                {
                    //configure the endpoint
                });
            });

            b.Start();

        }
    }

    public class Program
    {
        // IContainer ioc;
        static readonly Nuclear.Messaging.Bus bus = ConfigureBus();

        static Nuclear.Messaging.Bus ConfigureBus()
        {
            return new Switchboard();
        }


        static readonly IContainer container = ConfigureContainer();



        static IContainer ConfigureContainer()
        {
            var container = new Container(cfg =>
            {
                // cfg.For<Bus>().Use<Switchboard>();

                // cfg.ForConcreteType<SimpleConfig>().Configure.Singleton();

                cfg.For<MySqlConnectionString>().Use("", () =>
                {
                    var connectionString = "Server=127.0.0.1;Database=eventstore_db;Uid=eventstoreuser;Pwd=changeit;";
                    return new MySqlConnectionString(connectionString);
                });

                cfg.For<IEventStoreConnection>().Use("", () =>
                {
                    var connection = EventStoreConnection.Create(new IPEndPoint(IPAddress.Loopback, 1113));
                    connection.ConnectAsync().Wait();
                    return connection;
                }).Singleton();

                var store = cfg.ForConcreteType<MySqlAgent>().Configure;
                store
                    .Ctor<string>("connectionString")
                    .Is("Server=127.0.0.1;Database=somedayisle_projections;Uid=NHibernate;Pwd=NHibernate;")
                    .Singleton();

            });

            return container;
        }


        /*
        static IAggregateEventStore EventStore()
        {
            return new MySqlEventSource(container.GetInstance<MySqlConnectionString>(), bus);
            // return new EventStoreRepository(container.GetInstance<IEventStoreConnection>(), bus);
        }
        */


        static void Main(string[] args)
        {

            // var settings = ConfigurationManager.AppSettings;

            bus.RegisterHandler<CreateJourney>((c) =>
            {
                // IAggregateEventStore aggStore = EventStore();
                var repository = new RepositoryFactory(bus, container).Build<Journey>();
                var journey = new Journey(c.Id, c.Title, c.Description);
                repository.Save(journey);
            });

            bus.RegisterHandler<AddStopToJourney>((c) =>
            {
                // IAggregateEventStore aggStore = EventStore();
                // var repository = new EventSourcedAggregateRepository<Journey>(aggStore);
                var repository = new RepositoryFactory(bus, container).Build<Journey>();
                var journey = repository.GetById(c.JourneyId);
                journey.AddStop(c.StopId, c.Name);
                repository.Save(journey);
            });


            bus.RegisterSubscriber<JourneyCreated>((e) => {
                var agent = container.GetInstance<MySqlAgent>();

                if (!String.IsNullOrEmpty(e.Name))
                    agent.CreateJourney(e.Id, e.Name, e.Description, e.Timestamp);

                foreach (var storedJourney in agent.Journeys())
                {
                    Console.WriteLine("");
                    Console.WriteLine(storedJourney.Title);
                    Console.WriteLine(storedJourney.CreationDate);
                }
            });




            bus.RegisterSubscriber<StopAddedToJourney>((e) =>
            {
                Console.WriteLine("====================");
                Console.WriteLine("StopAddedToJourney: " + e.Name);

                var agent = container.GetInstance<MySqlAgent>();

                if (!String.IsNullOrEmpty(e.Name))
                    agent.RegisterStop(e.JourneyId, e.StopId, e.Name, e.Description);

                foreach (var stop in agent.Stops(e.JourneyId))
                {
                    Console.WriteLine(stop.Title);
                }
            });


            /*
            RepublishAllEvents("journey" ,bus, container.GetInstance<IEventStoreConnection>());

            Console.WriteLine("COntinue ? (y/n)");
            if (Console.ReadKey().Key != ConsoleKey.Y)
                return;
            */

            Guid journeyId = Guid.NewGuid();
            string title = "Complete the Tap Out XT 90 days challenge";
            string description = "";

            bus.Send(new CreateJourney(journeyId, title, description));

            string stopName = null;
            do
            {
                Console.WriteLine("Enter a name of a stop:");
                stopName = Console.ReadLine();

                if (!String.IsNullOrEmpty(stopName))
                    bus.Send(new AddStopToJourney(journeyId, Guid.NewGuid(), stopName, ""));

            } while (!String.IsNullOrEmpty(stopName));


            /*
            var agent = container.GetInstance<MySqlAgent>();

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
            */


            if(Environment.UserInteractive)
            {
                Console.WriteLine("PRESS ANY KEY TO EXIT");
                Console.ReadKey();
            }
        }


        /*
        private static void RepublishAllEvents(Bus bus, IEventStoreConnection connection)
        {
            long processedTotal = 0;
            AllEventsSlice currentSlice;
            var nextPosition = Position.Start;
            do
            {
                // $ce-journey
                currentSlice = connection
                                .ReadAllEventsForwardAsync(nextPosition, 100, false, userCredentials: new UserCredentials("admin", "changeit"))
                                .Result;

                nextPosition = currentSlice.NextPosition;

                foreach (var evnt in currentSlice.Events)
                {
                    Console.WriteLine(evnt.OriginalEvent);
                    Console.WriteLine(evnt.OriginalEvent.Data.Length);
                    Console.WriteLine(evnt.OriginalEvent.Metadata.Length);

                    processedTotal += 1;
                    DomainEvent aggrEvent = (DomainEvent)DeserializeEvent(evnt.OriginalEvent.Metadata, evnt.OriginalEvent.Data);
                    if(aggrEvent != null)
                        bus.Publish(aggrEvent);

                    Console.WriteLine(processedTotal);
                }

            } while (!currentSlice.IsEndOfStream);
        }
        */

        /*
        private static void RepublishAllEvents(string category, Bus bus, IEventStoreConnection connection)
        {
            long processedTotal = 0;
            StreamEventsSlice currentSlice;
            var nextSliceStart = 0;
            do
            {
                // $ce-journey
                currentSlice = connection
                    .ReadStreamEventsForwardAsync(
                            "$ce-" + category, nextSliceStart, 100, true, userCredentials: new UserCredentials("admin", "changeit"))
                                .Result;

                nextSliceStart = currentSlice.NextEventNumber;

                foreach (var evnt in currentSlice.Events)
                {
                    Console.WriteLine(evnt.OriginalEvent);
                    Console.WriteLine(evnt.OriginalEvent.Data.Length);
                    Console.WriteLine(evnt.OriginalEvent.Metadata.Length);

                    processedTotal += 1;
                    DomainEvent aggrEvent = (DomainEvent)DeserializeEvent(evnt.Event.Metadata, evnt.Event.Data);
                    if (aggrEvent != null)
                        bus.Publish(aggrEvent);

                    Console.WriteLine(processedTotal);
                }

            } while (!currentSlice.IsEndOfStream);
        }
        */

        public static DomainEvent DeserializeEvent(byte[] metadata, byte[] data)
        {
            Console.WriteLine(Encoding.UTF8.GetString(metadata));
            try
            {
                var eventClrTypeName = JObject.Parse(Encoding.UTF8.GetString(metadata)).Property("EventClrTypeName").Value;

                Console.WriteLine(eventClrTypeName);

                return (DomainEvent) JsonConvert.DeserializeObject(Encoding.UTF8.GetString(data), Type.GetType((string)eventClrTypeName));
            }
            catch (Exception)
            {
                return null;
            }
        }
    }
}
