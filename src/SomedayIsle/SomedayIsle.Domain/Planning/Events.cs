using Nuclear.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SomedayIsle.Planning.Events
{
    public sealed class JourneyCreated : DomainEvent
    {
        public Guid Id;

        public string Name;
        public string Description;

        public DateTimeOffset Timestamp;

        public JourneyCreated(Guid id, string name, string description, DateTimeOffset timestamp)
        {
            this.Id = id;
            this.Name = name;
            this.Description = description;
            this.Timestamp = timestamp;
        }
    }

    public sealed class StopAddedToJourney : DomainEvent
    {
        public Guid JourneyId;
        public Guid StopId;

        public string Name;
        public string Description;

        public StopAddedToJourney(Guid journeyId, Guid stopId, string name, string description)
        {
            this.JourneyId = journeyId;
            this.StopId = stopId;
            this.Name = name;
            this.Description = description;
        }
    }
}
