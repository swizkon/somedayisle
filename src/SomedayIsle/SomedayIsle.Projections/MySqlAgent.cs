using NHibernate;
using NHibernate.Cfg;
using NHibernate.Cfg.MappingSchema;
using NHibernate.Dialect;
using NHibernate.Mapping.ByCode;
using NHibernate.Mapping.ByCode.Conformist;
using System;
using System.Collections.Generic;
using System.Reflection;


// NHibernate.Cfg.MappingSchema
// NHibernate.Mapping.ByCode


namespace SomedayIsle.Projections
{
    public class MySqlAgent
    {
        ProjectionsUtil projUtil;
        // Configuration cfg;

        public MySqlAgent(string connectionString)
        {
            var cfg = new Configuration()
                .DataBaseIntegration(db =>
                {
                    db.ConnectionString = connectionString;
                    db.Dialect<MySQLDialect>();
                });

            /* Add the mapping we defined: */
            var mapper = new ModelMapper();
            // mapper.AddMappings(Assembly.GetExecutingAssembly().GetExportedTypes());
            mapper.AddMapping(typeof(JourneyMap));
            mapper.AddMapping(typeof(StopMap));

            HbmMapping mapping = mapper.CompileMappingForAllExplicitlyAddedEntities();
            cfg.AddMapping(mapping);

            this.projUtil = new ProjectionsUtil(cfg);

            // this.projUtil.CreateDatabaseSchemaFromConfiguration();
        }


        public void CreateJourney(Guid id, string title, string description, DateTimeOffset creationDate)
        {
            /* Create a session and execute a query: */
            this.projUtil.Transaction((session) =>
            {
                var j = new JourneyDto()
                {
                    Id = id,
                    Title = title,
                    Description = description,
                    CreationDate = creationDate.ToUniversalTime().Date
                };
                session.SaveOrUpdate(j);
            });
        }

        public IEnumerable<JourneyDto> Journeys()
        {
            return this.projUtil.Query<JourneyDto>(
                (session) =>
                {
                    return session.QueryOver<JourneyDto>().List();
                }
                );
        }

        public void DropJourney(Guid id)
        {

            Console.WriteLine("DropJourney(Guid " + id + ")");

            this.projUtil.Transaction((session) =>
            {
                var obj = session.Get<JourneyDto>(id);
                session.Delete(obj);
            });
        }

        /*
        private void transaction(Action<ISession, ITransaction> a)
        {
            using (ISessionFactory factory = cfg.BuildSessionFactory())
            using (ISession session = factory.OpenSession())
            using (ITransaction tx = session.BeginTransaction())
            {
                a(session, tx);
            }
        }
        */

        public void RegisterStop(Guid journeyId, Guid stopId, string title, string description)
        {
            /* Create a session and execute a query: */
            this.projUtil.Transaction((session) =>
            {
                var j = new StopDto()
                {
                    JourneyId = journeyId,
                    StopId = stopId,
                    Title = title,
                    Description = description
                };
                session.SaveOrUpdate(j);
            });
        }

        public IEnumerable<StopDto> Stops(Guid journeyId)
        {
            Console.WriteLine("Stops(Guid journeyId)");

            return this.projUtil.Query<StopDto>(
                (session) =>
                {
                    return session.QueryOver<StopDto>().Where((o) => o.JourneyId == journeyId).List();
                }
                );
        }
    }


    public class JourneyMap : ClassMapping<JourneyDto>
    {
        public JourneyMap()
        {
            this.Table("journeys");
            this.Id(p => p.Id);
            this.Property(p => p.Title);
            this.Property(p => p.Description);
            this.Property(p => p.CreationDate);
        }
    }


    public class JourneyDto
    {
        public virtual Guid Id { get; set; }

        public virtual string Title { get; set; }

        public virtual string Description { get; set; }

        public virtual DateTime CreationDate { get; set; }
    }


    public class StopMap : ClassMapping<StopDto>
    {
        public StopMap()
        {
            this.Table("journey_stops");
            this.Id(p => p.StopId);
            this.Property(p => p.JourneyId);
            this.Property(p => p.Title);
            this.Property(p => p.Description);
        }
    }

    public class StopDto
    {
        public virtual Guid StopId { get; set; }

        public virtual Guid JourneyId { get; set; }

        public virtual string Title { get; set; }

        public virtual string Description { get; set; }
    }

    /*
    CREATE TABLE `journeys` (
      `Id` char(36) NOT NULL,
      `Title` varchar(200) NOT NULL,
      `Description` varchar(200) NOT NULL,
      PRIMARY KEY (`Id`)
    );
    */

}
