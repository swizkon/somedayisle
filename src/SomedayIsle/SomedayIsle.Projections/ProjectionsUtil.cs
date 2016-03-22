using NHibernate;
using NHibernate.Cfg;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SomedayIsle.Projections
{
    class ProjectionsUtil
    {
        static bool schemaCreated = false;
        Configuration cfg;


        public ProjectionsUtil(Configuration config)
        {
            this.cfg = config;
        }


        public void Transaction(Action<ISession> unitOfWork)
        {
            using (ISessionFactory factory = cfg.BuildSessionFactory())
            using (ISession session = factory.OpenSession())
            using (ITransaction tx = session.BeginTransaction())
            {
                unitOfWork(session);
                tx.Commit();
            }
        }

        public IEnumerable<TModel> Query<TModel>(Func<ISession, IEnumerable<TModel>> unitOfWork)
        {
            /* Create a session and execute a query: */
            using (ISessionFactory factory = cfg.BuildSessionFactory())
            using (ISession session = factory.OpenSession())
            {
                return unitOfWork(session);
            }
        }


        public void CreateDatabaseSchemaFromConfiguration()
        {
            /*
            if (!schemaCreated)
                return; 
            */


            if (!schemaCreated)
            {
                NHibernate.Tool.hbm2ddl.SchemaExport schema = new NHibernate.Tool.hbm2ddl.SchemaExport(this.cfg);
                schema.Create(true, true);
                schemaCreated = true;
            }
        }
    }
}
