
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web.Mvc;
using BSMDataAccess;
using BSMWeb.Helpers;
using BSMWeb.Models;
using Newtonsoft.Json;

public class LoginController : Controller
{
	private BSMEntities db = new BSMEntities();

	private string _connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

	public ActionResult Index()
	{
		return View();
	}

	[HttpPost]
	public ActionResult Authenticate(Employee employee)
	{
		DataSet t = DataViewer.GetEmployee(_connectionString, employee.Username, employee.Password);
		if (t != null)
		{
			Employee user = (from r in t.Tables[0].AsEnumerable()
							 select new Employee
							 {
								 EmployeeId = r.Field<int>("EmployeeId"),
								 Username = r.Field<string>("Username"),
								 UserType = r.Field<int>("UserType"),
								 FirstName = r.Field<string>("FirstName"),
								 LastName = r.Field<string>("LastName")
							 }).ToList().FirstOrDefault();
			if (user != null)
			{
				base.HttpContext.Session["User"] = JsonConvert.SerializeObject(user);
				if (user.UserType == 2)
				{
					Helper.CreateLog(db, employee.Username, "Login successful with username " + employee.Username);
					return RedirectToAction("index", "EmployeeTraining");
				}
				Helper.CreateLog(db, employee.Username, "Login successful with username " + employee.Username);
				return RedirectToAction("TrainingMatrix", "data");
			}
		}
		Helper.CreateLog(db, employee.Username, "Login failed with username " + employee.Username);
		base.TempData["Message"] = "Incorrect username or password";
		return View("Index");
	}

	public ActionResult Logout()
	{
		base.HttpContext.Session.Clear();
		return RedirectToAction("Index");
	}
}
