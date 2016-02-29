using NHibernate;
using NHibernate.Cfg;
using NHibernate.Cfg.MappingSchema;
using NHibernate.Dialect;
using NHibernate.Mapping.ByCode;
using NHibernate.Mapping.ByCode.Conformist;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Reflection;
using System.Text;
using System.Threading.Tasks;


// NHibernate.Cfg.MappingSchema
// NHibernate.Mapping.ByCode


namespace SomedayIsle.Projections
{
    public class MySqlAgent
    {
        Configuration cfg;

        public MySqlAgent(string connectionString)
        {
            cfg = new Configuration()
                .DataBaseIntegration(db =>
                {
                    db.ConnectionString = connectionString;
                    db.Dialect<MySQLDialect>();
                });



            /* Add the mapping we defined: */
            var mapper = new ModelMapper();
            mapper.AddMappings(Assembly.GetExecutingAssembly().GetExportedTypes());

            HbmMapping mapping = mapper.CompileMappingForAllExplicitlyAddedEntities();
            cfg.AddMapping(mapping);
        }

        public void CreateJourney(Guid id, string title, string description)
        {
            /* Create a session and execute a query: */
            transaction((session, tx) =>
            {
                var j = new Journey()
                {
                    Id = id,
                    Title = title,
                    Description = description
                };
                session.Save(j);
                tx.Commit();
            });
        }

        public IEnumerable<Journey> Journeys()
        {
            /* Create a session and execute a query: */
            using (ISessionFactory factory = cfg.BuildSessionFactory())
            using (ISession session = factory.OpenSession())
            using (ITransaction tx = session.BeginTransaction())
            {
                return session.QueryOver<Journey>().List();
            }
        }

        public void DropJourney(Guid id)
        {
            Console.WriteLine("DropJourney(Guid " + id + ")");

            transaction((session, tx) =>
            {
                var obj = session.Get<Journey>(id);
                session.Delete(obj);
                tx.Commit();
            });
        }

        private void transaction(Action<ISession, ITransaction> a)
        {
            /* Create a session and execute a query: */
            using (ISessionFactory factory = cfg.BuildSessionFactory())
            using (ISession session = factory.OpenSession())
            using (ITransaction tx = session.BeginTransaction())
            {
                a(session, tx);
            }
        }
    }

    public class JourneyMap : ClassMapping<Journey>
    {
        public JourneyMap()
        {
            this.Table("journeys");
            this.Id(p => p.Id);
            this.Property(p => p.Title);
            this.Property(p => p.Description);
        }
    }

    public class Journey
    {
        public virtual Guid Id { get; set; }

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
