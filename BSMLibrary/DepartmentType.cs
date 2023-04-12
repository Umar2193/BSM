namespace BSMLibrary
{
    using System.ComponentModel.DataAnnotations;
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    public class DepartmentType
    {
        public int DepartmentTypeId { get; set; }
        [Required(ErrorMessage = "Enter Department Type")]
        [Display(Name ="Departmnt Type")]
        public string DepartmentTypeName { get; set; }
    }
}
