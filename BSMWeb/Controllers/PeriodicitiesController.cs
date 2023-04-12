
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using BSMWeb.Helpers;
using BSMWeb.Models;

[MemberAuthorize(new UserType[]
{
	UserType.BSMADMIN,
	UserType.BSMMAN
})]
public class PeriodicitiesController : Controller
{
	private BSMEntities db = new BSMEntities();

	private Employee employee;

	public ActionResult Index()
	{
		return View(db.Periodicities.ToList());
	}

	public ActionResult Details(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		Periodicity periodicity = db.Periodicities.Find(id);
		if (periodicity == null)
		{
			return HttpNotFound();
		}
		return View(periodicity);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Create()
	{
		return View();
	}

	[HttpPost]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Create([Bind(Include = "PeriodicityId,PeriodicityName")] Periodicity periodicity)
	{
		if (base.ModelState.IsValid)
		{
			db.Periodicities.Add(periodicity);
			db.SaveChanges();
			Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), "Successfully created " + periodicity.PeriodicityName + " ");
			return RedirectToAction("Index");
		}
		return View(periodicity);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Edit(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		Periodicity periodicity = db.Periodicities.Find(id);
		if (periodicity == null)
		{
			return HttpNotFound();
		}
		return View(periodicity);
	}

	[HttpPost]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Edit([Bind(Include = "PeriodicityId,PeriodicityName")] Periodicity periodicity)
	{
		if (base.ModelState.IsValid)
		{
			db.Entry(periodicity).State = EntityState.Modified;
			db.SaveChanges();
			Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), $"Successfully edited {periodicity.PeriodicityName} (id:{periodicity.PeriodicityId}) ");
			return RedirectToAction("Index");
		}
		return View(periodicity);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Delete(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		Periodicity periodicity = db.Periodicities.Find(id);
		if (periodicity == null)
		{
			return HttpNotFound();
		}
		return View(periodicity);
	}

	[HttpPost]
	[ActionName("Delete")]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult DeleteConfirmed(int id)
	{
		Periodicity periodicity = db.Periodicities.Find(id);
		db.Periodicities.Remove(periodicity);
		db.SaveChanges();
		Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), "Successfully deleted " + periodicity.PeriodicityName + " ");
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
