namespace SomedayIsle.Planning.Events
{
    using System;
    using Nuclear.Domain;

    /// <summary>
    /// JourneyCreated
    /// </summary>
    public sealed class JourneyCreated : DomainEvent
    {
        public Guid Id { get; set; }

        public string Name { get; set; }
        public string Description { get; set; }

        public DateTimeOffset Timestamp { get; set; }

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
        public Guid JourneyId { get; set; }
        public Guid StopId { get; set; }

        public string Name { get; set; }
        public string Description { get; set; }

        public StopAddedToJourney(Guid journeyId, Guid stopId, string name, string description)
        {
            this.JourneyId = journeyId;
            this.StopId = stopId;
            this.Name = name;
            this.Description = description;
        }
    }
}
