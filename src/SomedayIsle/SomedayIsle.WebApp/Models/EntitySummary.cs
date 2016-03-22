

namespace SomedayIsle.WebApp.Models
{
    using System.ComponentModel.DataAnnotations;

    public class EntitySummary
    {
        [Required()]
        public string Title { get; set; }
        public string Description { get; set; }
    }
}