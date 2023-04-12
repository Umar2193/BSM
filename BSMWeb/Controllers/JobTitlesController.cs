
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using BSMWeb.Helpers;
using BSMWeb.Models;

[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
public class JobTitlesController : Controller
{
	private BSMEntities db = new BSMEntities();

	private Employee employee;

	public ActionResult Index()
	{
		return View(db.JobTitles.ToList());
	}

	public ActionResult Details(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		JobTitle jobTitle = db.JobTitles.Find(id);
		if (jobTitle == null)
		{
			return HttpNotFound();
		}
		return View(jobTitle);
	}

	public ActionResult Create()
	{
		return View();
	}

	[HttpPost]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Create([Bind(Include = "JobTitleId,JobTitleName")] JobTitle jobTitle)
	{
		if (base.ModelState.IsValid)
		{
			db.JobTitles.Add(jobTitle);
			db.SaveChanges();
			Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), "Successfully created " + jobTitle.JobTitleName + " ");
			return RedirectToAction("Index");
		}
		return View(jobTitle);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Edit(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		JobTitle jobTitle = db.JobTitles.Find(id);
		if (jobTitle == null)
		{
			return HttpNotFound();
		}
		return View(jobTitle);
	}

	[HttpPost]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Edit([Bind(Include = "JobTitleId,JobTitleName")] JobTitle jobTitle)
	{
		if (base.ModelState.IsValid)
		{
			db.Entry(jobTitle).State = EntityState.Modified;
			db.SaveChanges();
			Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), $"Successfully edited {jobTitle.JobTitleName} id({jobTitle.JobTitleId}) ");
			return RedirectToAction("Index");
		}
		return View(jobTitle);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Delete(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		JobTitle jobTitle = db.JobTitles.Find(id);
		if (jobTitle == null)
		{
			return HttpNotFound();
		}
		return View(jobTitle);
	}

	[HttpPost]
	[ActionName("Delete")]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult DeleteConfirmed(int id)
	{
		JobTitle jobTitle = db.JobTitles.Find(id);
		db.JobTitles.Remove(jobTitle);
		db.SaveChanges();
		Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), "Successfully deleted " + jobTitle.JobTitleName + " ");
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
