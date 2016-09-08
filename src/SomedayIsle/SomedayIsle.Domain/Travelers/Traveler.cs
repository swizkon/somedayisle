using SomedayIsle.Domain;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Transactions;

namespace SomedayIsle.Travelers
{
    public class Traveler
    {
        private decimal _credits;

        private ICollection<Ticket> _tickets;
        
        public Traveler()
        {
            _credits = 0m;
            _tickets = new List<Ticket>();
        }

        public void DepositCredits(decimal credits)
        {
            _credits += credits;
        }

        public bool PurchaseJourney(Guid journeyId, decimal price)
        {
            if (_credits < price)
                throw new InsufficientFundsException("Not enough credits to purchase the journey.");

            if (HasValidTicket(journeyId))
                throw new InvalidOperationException("Traveler allready has a ticket for the same journey.");

            _credits -= price;
            _tickets.Add(new Ticket(journeyId, price));

            return true;
        }

        public decimal CreditBalance()
        {
            return _credits;
        }

        public bool HasValidTicket(Guid journeyId)
        {
            return _tickets.Any(t => t.JourneyId == journeyId);
            // throw new NotImplementedException();
        }

        public ICollection<Ticket> ValidTickets() => _tickets;
    }
}
