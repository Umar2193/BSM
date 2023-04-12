
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
public class DepartmentsController : Controller
{
	private BSMEntities db = new BSMEntities();

	private string _connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

	private string userName = WindowsIdentity.GetCurrent().Name;

	private Employee employee;

	[HttpGet]
	public ActionResult Index()
	{
		IOrderedQueryable<Department> departments = from x in db.Departments.Include((Department d) => d.DepartmentType)
													orderby x.DepartmentName
													select x;
		return View(departments.ToList());
	}

	[HttpGet]
	public ActionResult Details(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		Department department = db.Departments.Find(id);
		if (department == null)
		{
			return HttpNotFound();
		}
		return View(department);
	}

	[HttpGet]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Create()
	{
		base.ViewBag.DepartmentTypeId = new SelectList(db.DepartmentTypes, "DepartmentTypeId", "DepartmentTypeName");
		return View();
	}

	[HttpPost]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Create([Bind(Include = "DepartmentId,DepartmentName,DepartmentTypeId,DepartmrntStatus")] Department department)
	{
		if (base.ModelState.IsValid)
		{
			Employee employee = Helper.GetSessionEmployee(base.HttpContext);
			DataViewer.AddCurrentloggedInUser(_connectionString, employee.Username);
			db.Departments.Add(department);
			db.SaveChanges();
			Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), "Successfully created " + department.DepartmentName);
			return RedirectToAction("Index");
		}
		base.ViewBag.DepartmentTypeId = new SelectList(db.DepartmentTypes, "DepartmentTypeId", "DepartmentTypeName", department.DepartmentTypeId);
		return View(department);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Edit(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		Department department = db.Departments.Find(id);
		if (department == null)
		{
			return HttpNotFound();
		}
		base.ViewBag.DepartmentTypeId = new SelectList(db.DepartmentTypes, "DepartmentTypeId", "DepartmentTypeName", department.DepartmentTypeId);
		return View(department);
	}

	[HttpPost]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Edit([Bind(Include = "DepartmentId,DepartmentName,DepartmentTypeId,DepartmrntStatus")] Department department)
	{
		if (base.ModelState.IsValid)
		{
			db.Entry(department).State = EntityState.Modified;
			db.SaveChanges();
			Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), $"Successfully Edited {department.DepartmentName} ({department.DepartmentId})");
			return RedirectToAction("Index");
		}
		base.ViewBag.DepartmentTypeId = new SelectList(db.DepartmentTypes, "DepartmentTypeId", "DepartmentTypeName", department.DepartmentTypeId);
		return View(department);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Delete(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		Department department = db.Departments.Find(id);
		if (department == null)
		{
			return HttpNotFound();
		}
		return View(department);
	}

	[HttpPost]
	[ActionName("Delete")]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult DeleteConfirmed(int id)
	{
		Department department = db.Departments.Find(id);
		db.Departments.Remove(department);
		db.SaveChanges();
		Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), $"Successfully deleted {department.DepartmentName}(id:{department.DepartmentId})");
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
