using Nuclear.Domain;
using SomedayIsle.Events;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SomedayIsle.Model
{
    internal class Journey : AggregateBase
    {
        private FinalDestination finalDestination;
        private string name;
        private string description;

        public Journey(Guid id, string name, string alias)
            : base(id)
        {
            ApplyChange(new JourneyCreated(id, name, alias));
        }

        public Journey(Guid id) : base(id)
        {
        }


        private void Apply(JourneyCreated e)
        {
            Id = e.Id;
            this.name =  e.Name;
            this.description = e.Description;
        }
    }
}
