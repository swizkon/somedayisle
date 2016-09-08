using System;

namespace SomedayIsle.Travelers
{
    public class Ticket
    {
        private decimal _price;
        private Guid _journeyId;

        public Guid JourneyId
        {
            get
            {
                return _journeyId;
            }
        }

        public decimal Price
        {
            get
            {
                return _price;
            }
        }

        public Ticket(Guid journeyId, decimal price)
        {
            _journeyId = journeyId;
            _price = price;
        }

        public override string ToString()
        {
            return $"JourneyId: {JourneyId}, Price: {Price}";
        }

        public override int GetHashCode()
        {
            return ToString().GetHashCode();
        }
    }
}