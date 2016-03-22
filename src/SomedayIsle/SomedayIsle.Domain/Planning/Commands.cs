using Nuclear.Messaging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SomedayIsle.Planning.Commands
{
    public class CreateJourney : Command
    {
        public readonly Guid Id;
        public readonly string Title;
        public readonly string Description;

        public CreateJourney(Guid id, string title, string description)
        {
            this.Id = id;
            this.Title = title;
            this.Description = description;
        }
    }

    public class AddStopToJourney : Command
    {
        public readonly Guid JourneyId;
        public readonly Guid StopId;

        public string Name;
        public string Description;

        public AddStopToJourney(Guid journeyId, Guid stopId, string name, string description)
        {
            this.JourneyId = journeyId;
            this.StopId = stopId;
            this.Name = name;
            this.Description = description;
        }
    }
}
