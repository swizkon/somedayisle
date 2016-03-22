using Nuclear.EventSourcing.MySql;
using Nuclear.Lazy;
using Nuclear.Messaging;
using SomedayIsle.Planning.Commands;
using SomedayIsle.Planning.Events;
using SomedayIsle.Planning.Models;
using SomedayIsle.Projections;
using StructureMap;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace SomedayIsle.WebApp
{
    public class IoC
    {
        // IContainer ioc;
        static readonly Bus bus = ConfigureBus();

        static Bus ConfigureBus()
        {
            var b = new Switchboard();

            b.RegisterHandler<CreateJourney>((c) =>
            {
                // IAggregateEventStore aggStore = EventStore();
                var repository = new RepositoryFactory(bus, container).Build<Journey>();
                var journey = new Journey(c.Id, c.Title, c.Description);
                repository.Save(journey);
            });


            b.RegisterHandler<AddStopToJourney>((c) =>
            {
                // IAggregateEventStore aggStore = EventStore();
                // var repository = new EventSourcedAggregateRepository<Journey>(aggStore);
                var repository = new RepositoryFactory(bus, container).Build<Journey>();
                var journey = repository.GetById(c.JourneyId);
                journey.AddStop(c.StopId, c.Name);
                repository.Save(journey);
            });

            b.RegisterSubscriber<JourneyCreated>((e) =>
            {
                var agent = container.GetInstance<MySqlAgent>();
                if (!String.IsNullOrEmpty(e.Name))
                    agent.CreateJourney(e.Id, e.Name, e.Description, e.Timestamp);
            });


            b.RegisterSubscriber<StopAddedToJourney>((e) =>
            {
                var agent = container.GetInstance<MySqlAgent>();
                if (!String.IsNullOrEmpty(e.Name))
                    agent.RegisterStop(e.JourneyId, e.StopId, e.Name, e.Description);
            });

            return b;
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


                var store = cfg.ForConcreteType<MySqlAgent>().Configure;
                store
                    .Ctor<string>("connectionString")
                    .Is("Server=127.0.0.1;Database=somedayisle_projections;Uid=NHibernate;Pwd=NHibernate;")
                    .Singleton();

            });

            return container;
        }


        internal static void SendCommand<T>(T command) where T: Command
        {
            bus.Send(command);
        }

        internal static T Create<T>() where T: class
        {
            return container.GetInstance<T>();
        }
    }
}