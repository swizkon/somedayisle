using Nuclear.Messaging;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SomedayIsle.TicketOffice.Events
{
    public sealed class TicketPurchased : Event
    {
        public Guid TicketId;
        public Guid JourneyId;
        public Guid UserId;

        public decimal Price;
        public string Description;

        public TicketPurchased(Guid ticketId, Guid JourneyId, decimal price, string description)
        {
            this.TicketId = ticketId;
            this.Price = price;
            this.Description = description;
        }
    }
}
