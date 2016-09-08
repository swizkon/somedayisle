using NUnit.Framework;
using SomedayIsle.Domain;
using SomedayIsle.Travelers;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace SomedayIsleTests
{
    [TestFixture]
    public class TravelerTests
    {
        private Traveler traveler;

        [SetUp]
        public void BeforeTests()
        {
            traveler = new Traveler();
        }

        [Test]
        public void Traveler_Should_have_zero_credits_when_initiated()
        {
            Assert.That(traveler.CreditBalance(), Is.EqualTo(0m));
        }


        [Test]
        public void Traveler_Should_be_able_to_deposit_cash()
        {
            traveler.DepositCredits(30m);
            Assert.That(traveler.CreditBalance(), Is.EqualTo(30m));
        }


        [Test]
        public void Traveler_Should_be_able_to_purchase_tickets()
        {
            // Arrange
            traveler.DepositCredits(100m);
            Guid journeyId = Guid.NewGuid();

            // Act
            traveler.PurchaseJourney(journeyId, 30m);
            // Assert
        }

        [Test]
        public void Traveler_Credits_should_be_drawn_upon_purchase()
        {
            // Arrange
            Guid journeyId = Guid.NewGuid();

            traveler.DepositCredits(100m);

            // Act
            traveler.PurchaseJourney(journeyId, 50m);

            // Assert
            Assert.That(traveler.CreditBalance(), Is.EqualTo(50m));
        }


        [Test]
        public void Traveler_Should_not_be_able_to_purchase_ticket_with_insufficient_credits()
        {
            // Arrange
            Guid journeyId = Guid.NewGuid();

            // Act
            TestDelegate act = () => traveler.PurchaseJourney(journeyId, 50m);

            // Assert
            Assert.Throws<InsufficientFundsException>(act);
        }


        [Test]
        public void Traveler_Should_have_valid_ticket_after_purchase()
        {
            // Arrange
            Guid journeyId = Guid.NewGuid();
            traveler.DepositCredits(100m);

            // Act
            traveler.PurchaseJourney(journeyId, 30m);

            // Assert
            Assert.True(traveler.HasValidTicket(journeyId));
        }


        [Test]
        public void Traveler_Should_have_tickets_after_purchase()
        {
            // Arrange
            traveler.DepositCredits(100m);

            Guid journey1 = Guid.NewGuid();
            traveler.PurchaseJourney(journey1, 30m);

            Guid journey2 = Guid.NewGuid();
            traveler.PurchaseJourney(journey2, 30m);

            // Act
            var tickets = traveler.ValidTickets();//.ToList();
            

            // Assert
            Assert.True(tickets.Contains(new Ticket(journey1, 30m)));
            Assert.True(tickets.Contains(new Ticket(journey2, 30m)));
        }

    }
}
