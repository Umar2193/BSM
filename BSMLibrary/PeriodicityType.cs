namespace BSMLibrary
{
    using System.ComponentModel.DataAnnotations;
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    public class PeriodicityType
    {
        public int PeriodicityId { get; set; }
        [Required(ErrorMessage = "Enter Periodicity")]
        [Display(Name = "Periodicity")]
        public string Periodicity { get; set; }
    }
}
