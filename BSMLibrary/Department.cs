namespace BSMLibrary
{
    using System.ComponentModel.DataAnnotations;
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Threading.Tasks;
    public class Department
    {
        public int DepartmentId { get; set; }
        [Required(ErrorMessage = "Enter department!")]
        
        [Display(Name = "Department Name")]
        public string DepartmentName { get; set; }
        [Required(ErrorMessage = "Select department status!")]
        
        [Display(Name ="Status")]
        public bool DepartmentStatus { get; set; }
        [Required(ErrorMessage = "Select department type")]
        
        [Display(Name ="Department Type")]
        public int DepartmentTypeId { get; set; }
        public IEnumerable<DepartmentType> DeptType { get; set; }
    }
}
