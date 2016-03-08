using Nuclear.Messaging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SomedayIsle.Commands
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
}
