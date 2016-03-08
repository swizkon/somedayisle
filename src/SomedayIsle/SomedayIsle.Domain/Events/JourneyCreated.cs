using Nuclear.Messaging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace SomedayIsle.Events
{
    public sealed class JourneyCreated : Event
    {
        public Guid Id;

        public string Name;
        public string Description;

        public JourneyCreated(Guid id, string name, string description)
        {
            this.Id = id;
            this.Name = name;
            this.Description = description;
        }
    }
}
