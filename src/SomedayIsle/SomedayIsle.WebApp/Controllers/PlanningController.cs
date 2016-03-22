using SomedayIsle.Planning.Commands;
using SomedayIsle.Projections;
using SomedayIsle.WebApp.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
// using System.Web.Http;
using System.Web.Mvc;

namespace SomedayIsle.WebApp.Controllers
{
    public class PlanningController : Controller
    {
        //
        // GET: /Planning/

        public ActionResult Index()
        {
            MySqlAgent db = IoC.Create<MySqlAgent>();
            var journeys = db.Journeys();
            return View(model: journeys);
        }

        //
        // GET: /Planning/Details/5

        public ActionResult Journeys(Guid id)
        {
            // Find a journey and its stops etc...
            return View();
        }

        //
        // GET: /Planning/Create

        public ActionResult CreateJourney()
        {
            JourneyFormModel template = new JourneyFormModel
            {
                 Id = Guid.NewGuid()
            };
            // CreateJourney
            return View(model: template);
        }

        //
        // POST: /Planning/Create

        [HttpPost]
        public ActionResult CreateJourney([System.Web.Http.FromBody] Guid id, [System.Web.Http.FromBody] string title, [System.Web.Http.FromBody] string description)
        {
            if (!this.ModelState.IsValid)
            {
                return View(model: new JourneyFormModel { Summary = new EntitySummary() });
            }

            try
            {
                // TODO: Add insert logic here
                IoC.SendCommand(new CreateJourney(id, title, description));

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Planning/Edit/5

        public ActionResult Edit(int id)
        {
            return View();
        }

        //
        // POST: /Planning/Edit/5

        [HttpPost]
        public ActionResult Edit(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add update logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }

        //
        // GET: /Planning/Delete/5

        public ActionResult Delete(int id)
        {
            return View();
        }

        //
        // POST: /Planning/Delete/5

        [HttpPost]
        public ActionResult Delete(int id, FormCollection collection)
        {
            try
            {
                // TODO: Add delete logic here

                return RedirectToAction("Index");
            }
            catch
            {
                return View();
            }
        }
    }
}
