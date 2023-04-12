
using System;
using System.Configuration;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Security.Principal;
using System.Web.Mvc;
using BSMDataAccess;
using BSMWeb.Helpers;
using BSMWeb.Models;

[MemberAuthorize(new UserType[]
{
	UserType.BMSUSER,
	UserType.BSMADMIN,
	UserType.BSMMAN
})]
public class EmployeeTrainingController : Controller
{
	private BSMEntities db = new BSMEntities();

	private string _connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

	private string userName = WindowsIdentity.GetCurrent().Name;

	public ActionResult Index()
	{
		Employee employee = Helper.GetSessionEmployee(base.HttpContext);
		if (employee.UserType == 2)
		{
			IQueryable<EmployeeTraining> employeeTrainings2 = from x in db.EmployeeTrainings.Include((EmployeeTraining e) => e.Employee).Include((EmployeeTraining e) => e.Skill).Include((EmployeeTraining e) => e.Training)
															  where x.EmployeeId == (int?)employee.EmployeeId
															  select x;
			return View(from x in employeeTrainings2.ToList()
						orderby x.Employee.LastName
						select x);
		}
		IQueryable<EmployeeTraining> employeeTrainings = db.EmployeeTrainings.Include((EmployeeTraining e) => e.Employee).Include((EmployeeTraining e) => e.Skill).Include((EmployeeTraining e) => e.Training);
		return View(from x in employeeTrainings.ToList()
					orderby x.Employee.LastName
					select x);
	}

	[MemberAuthorize(new UserType[]
	{
		UserType.BSMADMIN,
		UserType.BSMMAN
	})]
	public ActionResult Details(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		EmployeeTraining employeeTraining = db.EmployeeTrainings.Find(id);
		if (employeeTraining == null)
		{
			return HttpNotFound();
		}
		return View(employeeTraining);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Create()
	{
		base.ViewBag.EmployeeId = new SelectList(db.Employees, "EmployeeId", "FirstName");
		base.ViewBag.SkillsId = new SelectList(db.Skills, "SkillsId", "SkillsDescription");
		base.ViewBag.TrainingId = new SelectList(db.Trainings, "TrainingId", "TrainingDescription");
		return View();
	}

	[HttpPost]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Create([Bind(Include = "EmployeeTrainingId,EmployeeId,SkillsId,TrainingId,AcquiredOn,ExpiresOn")] EmployeeTraining employeeTraining)
	{
		if (base.ModelState.IsValid)
		{
			Employee employee = Helper.GetSessionEmployee(base.HttpContext);
			DataViewer.AddCurrentloggedInUser(_connectionString, employee.Username);
			db.EmployeeTrainings.Add(employeeTraining);
			db.SaveChanges();
			Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), "Successfully created " + employeeTraining.Training.TrainingDescription + " for " + employeeTraining.Employee.Username + " ");
			return RedirectToAction("Index");
		}
		base.ViewBag.EmployeeId = new SelectList(db.Employees, "EmployeeId", "FullName", employeeTraining.EmployeeId);
		base.ViewBag.SkillsId = new SelectList(db.Skills, "SkillsId", "SkillsDescription", employeeTraining.SkillsId);
		base.ViewBag.TrainingId = new SelectList(db.Trainings, "TrainingId", "TrainingDescription", employeeTraining.TrainingId);
		return View(employeeTraining);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Edit(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		EmployeeTraining employeeTraining = db.EmployeeTrainings.Find(id);
		if (employeeTraining == null)
		{
			return HttpNotFound();
		}
		base.ViewBag.EmployeeId = new SelectList(db.Employees, "EmployeeId", "FirstName", employeeTraining.EmployeeId);
		base.ViewBag.SkillsId = new SelectList(db.Skills, "SkillsId", "SkillsDescription", employeeTraining.SkillsId);
		base.ViewBag.TrainingId = new SelectList(db.Trainings, "TrainingId", "TrainingDescription", employeeTraining.TrainingId);
		return View(employeeTraining);
	}

	[HttpPost]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Edit([Bind(Include = "EmployeeTrainingId,EmployeeId,SkillsId,TrainingId,AcquiredOn,ExpiresOn")] EmployeeTraining employeeTraining)
	{
		if (base.ModelState.IsValid)
		{
			Employee employee = Helper.GetSessionEmployee(base.HttpContext);
			DataViewer.AddCurrentloggedInUser(_connectionString, employee.Username);
			db.Entry(employeeTraining).State = EntityState.Modified;
			db.SaveChanges();
			return RedirectToAction("Index");
		}
		base.ViewBag.EmployeeId = new SelectList(db.Employees, "EmployeeId", "FullName", employeeTraining.EmployeeId);
		base.ViewBag.SkillsId = new SelectList(db.Skills, "SkillsId", "SkillsDescription", employeeTraining.SkillsId);
		base.ViewBag.TrainingId = new SelectList(db.Trainings, "TrainingId", "TrainingDescription", employeeTraining.TrainingId);
		return View(employeeTraining);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Delete(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		EmployeeTraining employeeTraining = db.EmployeeTrainings.Find(id);
		if (employeeTraining == null)
		{
			return HttpNotFound();
		}
		return View(employeeTraining);
	}

	[HttpPost]
	[ActionName("Delete")]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult DeleteConfirmed(int id)
	{
		Employee employee = Helper.GetSessionEmployee(base.HttpContext);
		DataViewer.AddCurrentloggedInUser(_connectionString, employee.Username);
		EmployeeTraining employeeTraining = db.EmployeeTrainings.Find(id);
		db.EmployeeTrainings.Remove(employeeTraining);
		db.SaveChanges();
		Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), "Successfully deleted " + employeeTraining.Training.TrainingDescription + " for " + employeeTraining.Employee.Username + " ");
		return RedirectToAction("Index");
	}

	protected override void Dispose(bool disposing)
	{
		if (disposing)
		{
			db.Dispose();
		}
		base.Dispose(disposing);
	}

	[HttpPost]
	public ActionResult UpdateStatus([Bind(Include = "EmployeeTrainingId,Completed")] EmployeeTraining employeeTraining)
	{
		Employee employee = Helper.GetSessionEmployee(base.HttpContext);
		DateTime? dateTime = DateTime.UtcNow;
		EmployeeTraining training = db.EmployeeTrainings.FirstOrDefault((EmployeeTraining x) => x.EmployeeTrainingId == employeeTraining.EmployeeTrainingId && x.EmployeeId == (int?)employee.EmployeeId);
		if (employeeTraining.Completed == true)
		{
			training.CompletedTimestamp = dateTime;
		}
		else
		{
			training.CompletedTimestamp = null;
		}
		training.Completed = employeeTraining.Completed;
		db.Entry(training).State = EntityState.Modified;
		db.SaveChanges();
		Helper.CreateLog(db, employee.Username, training.Employee.Username + " Completed Training " + training.Skill.SkillsDescription);
		if (employeeTraining.Completed == true)
		{
			return Json(dateTime.Value.ToString("dd/MM/yyyy HH:mm:ss"));
		}
		return Json(null);
	}
}
