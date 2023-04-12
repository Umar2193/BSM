using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows.Forms;
using BSMDataAccess.Core.Training_Matrix;
using bsmDataAccess.Core;

namespace Test
{
    public partial class Form1 : Form
    {
        public Form1()
        {
            InitializeComponent();
        }

        private void button1_Click(object sender, EventArgs e)
        {
            TeamSkill employeeSkill = new TeamSkill();
            RunParameters param = new RunParameters();
            param.EmployeeId = 1;
            param.TeamId = 1;
            param.AddedOn = DateTime.Now;
            param.SkillId = 1;
            string connectionString = "Server=DESKTOP-EBMPARV\\SQLEXPRESS;Database=BSM;Trusted_Connection=True;";
            DataTable dt = new DataTable();
            param.Success = employeeSkill.Save(param, connectionString);
            dt = employeeSkill.GetData(param, connectionString);
        }
    }
}
