using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Web;

namespace SomedayIsle.WebApp.Models
{
    public class JourneyFormModel
    {
        // [System.ComponentModel.DataAnnotations.]
        [UIHint("HiddenId")]
        public Guid Id { get; set; }

        /*
        [Required()]
        public string Title { get; set; }
        public string Description { get; set; }
         * */

        [UIHint("EntitySummary")]
        public EntitySummary Summary { get; set; }

        public JourneyFormModel()
        {
            this.Summary = new EntitySummary();
        }
    }

}