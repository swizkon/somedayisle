using SomedayIsle.Planning.Commands;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;

namespace SomedayIsle.WebApp
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class WebApiApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);


            Guid journeyId = Guid.NewGuid();
            string title = "Complete the Tap Out XT 90 days challenge";
            string description = "";

            IoC.SendCommand(new CreateJourney(journeyId, title, description));

            List<string> stops = new List<string>();

            stops.Add("Week 1: Cross Core Combat");
            stops.Add("Week 1: Strenth & Force upper + Ultimate ABs");
            stops.Add("Week 1: Plyo XT");
            stops.Add("Week 1: Yoga XT");
            stops.Add("Week 1: Legs & Back");
            stops.Add("Week 1: Sprawl & Brawl");
            stops.Add("Week 1: Rest day");

            stops.Add("");
            stops.Add("");
            stops.Add("");
            stops.Add("");
            stops.Add("");
            stops.Add("");
            stops.Add("");
            stops.Add("");
            stops.Add("");
            stops.Add("");
            stops.Add("");
            stops.Add("");

            foreach (var stop in stops.Where(s => s != ""))
            {
                IoC.SendCommand(new AddStopToJourney(journeyId, Guid.NewGuid(), stop, ""));
            }
        }
    }
}