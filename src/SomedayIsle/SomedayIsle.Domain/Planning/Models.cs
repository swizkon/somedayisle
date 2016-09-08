using Nuclear.Domain;
using SomedayIsle.Planning.Events;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SomedayIsle.Planning.Models
{

    public class Journey : AggregateBase
    {
        private FinalDestination finalDestination;
        private string title;
        private string description;

        private IDictionary<Guid, string> stops = new Dictionary<Guid, string>();

        public Journey(Guid id, string title, string description)
            : base(id)
        {
            AcceptChange(new JourneyCreated(id, title, description, DateTimeOffset.Now));
        }

        public Journey(Guid id)
            : base(id)
        {
        }


        private void Apply(JourneyCreated e)
        {
            Id = e.Id;
            this.title = e.Name;
            this.description = e.Description;
            Console.WriteLine("Apply(JourneyCreated e)");
        }

        public void AddStop(Guid stopId, string title)
        {
            AcceptChange(new StopAddedToJourney(this.Id, stopId, title, description));
        }

        private void Apply(StopAddedToJourney e)
        {
            this.stops[e.StopId] = e.Name;
            Console.WriteLine("Apply(StopAddedToJourney e)");
        }
    }


    public class FinalDestination
    {
    }
}
