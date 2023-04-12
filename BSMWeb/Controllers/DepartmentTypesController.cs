
using System.Configuration;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using BSMWeb.Helpers;
using BSMWeb.Models;

[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
public class DepartmentTypesController : Controller
{
	private BSMEntities db = new BSMEntities();

	private string _connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

	private Employee employee;

	public ActionResult Index()
	{
		return View(db.DepartmentTypes.ToList());
	}

	public ActionResult Details(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		DepartmentType departmentType = db.DepartmentTypes.Find(id);
		if (departmentType == null)
		{
			return HttpNotFound();
		}
		return View(departmentType);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Create()
	{
		return View();
	}

	[HttpPost]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Create([Bind(Include = "DepartmentTypeId,DepartmentTypeName")] DepartmentType departmentType)
	{
		if (base.ModelState.IsValid)
		{
			db.DepartmentTypes.Add(departmentType);
			db.SaveChanges();
			Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), "Successfully created " + departmentType.DepartmentTypeName);
			return RedirectToAction("Index");
		}
		return View(departmentType);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Edit(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		DepartmentType departmentType = db.DepartmentTypes.Find(id);
		if (departmentType == null)
		{
			return HttpNotFound();
		}
		return View(departmentType);
	}

	[HttpPost]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Edit([Bind(Include = "DepartmentTypeId,DepartmentTypeName")] DepartmentType departmentType)
	{
		if (base.ModelState.IsValid)
		{
			db.Entry(departmentType).State = EntityState.Modified;
			db.SaveChanges();
			Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), $"Successfully edited {departmentType.DepartmentTypeName} (id:{departmentType.DepartmentTypeId})");
			return RedirectToAction("Index");
		}
		return View(departmentType);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Delete(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		DepartmentType departmentType = db.DepartmentTypes.Find(id);
		if (departmentType == null)
		{
			return HttpNotFound();
		}
		return View(departmentType);
	}

	[HttpPost]
	[ActionName("Delete")]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult DeleteConfirmed(int id)
	{
		DepartmentType departmentType = db.DepartmentTypes.Find(id);
		db.DepartmentTypes.Remove(departmentType);
		db.SaveChanges();
		Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), $"Successfully deleted {departmentType.DepartmentTypeName} (id:{departmentType.DepartmentTypeId})");
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
