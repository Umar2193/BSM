
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

[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
public class EmployeesController : Controller
{
	private BSMEntities db = new BSMEntities();

	private string _connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

	private string userName = WindowsIdentity.GetCurrent().Name;

	private Employee employee;

	[HttpGet]
	public ActionResult Index()
	{
		IOrderedQueryable<Employee> employees = from x in db.Employees.Include((Employee e) => e.Department).Include((Employee e) => e.JobTitle)
												orderby x.LastName
												select x;
		return View(employees.ToList());
	}

	[HttpGet]
	public ActionResult Details(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		Employee employee = db.Employees.Find(id);
		if (employee == null)
		{
			return HttpNotFound();
		}
		return View(employee);
	}

	[HttpGet]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Create()
	{
		int[] array = (from Id in db.DepartmentTypes
					   where Id.DepartmentTypeName == "Employee Department"
					   select Id.DepartmentTypeId).ToArray();
		int deptTypeId = 0;
		int[] array2 = array;
		foreach (int i in array2)
		{
			deptTypeId = Convert.ToInt32(i);
		}
		var departmentId = (from Id in db.Departments
							where Id.DepartmentTypeId == (int?)deptTypeId
							select new { Id.DepartmentId, Id.DepartmentName }).ToList();
		base.ViewBag.DepartmentId = new SelectList(departmentId, "DepartmentId", "DepartmentName");
		base.ViewBag.JobTitleId = new SelectList(db.JobTitles, "JobTitleId", "JobTitleName");
		return View();
	}

	[HttpPost]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Create([Bind(Include = "EmployeeId,FirstName,LastName,JobTitleId,DepartmentId,EmployeeStatus")] Employee employee)
	{
		if (base.ModelState.IsValid)
		{
			Employee sessionEmployee = Helper.GetSessionEmployee(base.HttpContext);
			DataViewer.AddCurrentloggedInUser(_connectionString, sessionEmployee.Username);
			db.Employees.Add(employee);
			db.SaveChanges();
			Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), "Successfully created " + employee.Username + " ");
			return RedirectToAction("Index");
		}
		base.ViewBag.DepartmentId = new SelectList(db.Departments, "DepartmentId", "DepartmentName", employee.DepartmentId);
		base.ViewBag.JobTitleId = new SelectList(db.JobTitles, "JobTitleId", "JobTitleName", employee.JobTitleId);
		return View(employee);
	}

	[HttpGet]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Edit(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		Employee employee = db.Employees.Find(id);
		if (employee == null)
		{
			return HttpNotFound();
		}
		int[] array = (from Id in db.DepartmentTypes
					   where Id.DepartmentTypeName == "Employee Department"
					   select Id.DepartmentTypeId).ToArray();
		int deptTypeId = 0;
		int[] array2 = array;
		foreach (int i in array2)
		{
			deptTypeId = Convert.ToInt32(i);
		}
		var departmentId = (from Id in db.Departments
							where Id.DepartmentTypeId == (int?)deptTypeId
							select new { Id.DepartmentId, Id.DepartmentName }).ToList();
		base.ViewBag.DepartmentId = new SelectList(departmentId, "DepartmentId", "DepartmentName", employee.DepartmentId);
		base.ViewBag.JobTitleId = new SelectList(db.JobTitles, "JobTitleId", "JobTitleName", employee.JobTitleId);
		return View(employee);
	}

	[HttpPost]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Edit([Bind(Include = "EmployeeId,FirstName,LastName,JobTitleId,DepartmentId,EmployeeStatus")] Employee employee)
	{
		if (base.ModelState.IsValid)
		{
			Employee sessionEmployee = Helper.GetSessionEmployee(base.HttpContext);
			DataViewer.AddCurrentloggedInUser(_connectionString, sessionEmployee.Username);
			db.Entry(employee).State = EntityState.Modified;
			db.SaveChanges();
			Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), $"Successfully edited {employee.Username} (id:{employee.EmployeeId})");
			return RedirectToAction("Index");
		}
		base.ViewBag.DepartmentId = new SelectList(db.Departments, "DepartmentId", "DepartmentName", employee.DepartmentId);
		base.ViewBag.JobTitleId = new SelectList(db.JobTitles, "JobTitleId", "JobTitleName", employee.JobTitleId);
		return View(employee);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Delete(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		Employee employee = db.Employees.Find(id);
		if (employee == null)
		{
			return HttpNotFound();
		}
		return View(employee);
	}

	[HttpPost]
	[ActionName("Delete")]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult DeleteConfirmed(int id)
	{
		Employee employee = db.Employees.Find(id);
		db.Employees.Remove(employee);
		db.SaveChanges();
		Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), "Successfully deleted " + employee.Username + " ");
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
}
