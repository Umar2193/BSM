using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using BSMWeb.Helpers;
using BSMWeb.Models;

[Route("TrainingStatus")]
[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
public class TrainingStatusController : Controller
{
	private BSMEntities db = new BSMEntities();

	private Employee employee;

	public ActionResult Index()
	{
		return View(from x in db.Trainings.ToList()
					orderby x.TrainingDescription
					select x);
	}

	public ActionResult Details(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		Training training = db.Trainings.Find(id);
		if (training == null)
		{
			return HttpNotFound();
		}
		return View(training);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Create()
	{
		return View();
	}

	[HttpPost]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Create([Bind(Include = "TrainingId,TrainingDescription")] Training training)
	{
		if (base.ModelState.IsValid)
		{
			db.Trainings.Add(training);
			db.SaveChanges();
			Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), "Successfully created " + training.TrainingDescription);
			return RedirectToAction("Index");
		}
		return View(training);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Edit(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		Training training = db.Trainings.Find(id);
		if (training == null)
		{
			return HttpNotFound();
		}
		return View(training);
	}

	[HttpPost]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Edit([Bind(Include = "TrainingId,TrainingDescription")] Training training)
	{
		if (base.ModelState.IsValid)
		{
			db.Entry(training).State = EntityState.Modified;
			db.SaveChanges();
			Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), $"Successfully edited {training.TrainingDescription} (id:{training.TrainingId})");
			return RedirectToAction("Index");
		}
		return View(training);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Delete(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		Training training = db.Trainings.Find(id);
		if (training == null)
		{
			return HttpNotFound();
		}
		return View(training);
	}

	[HttpPost]
	[ActionName("Delete")]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult DeleteConfirmed(int id)
	{
		Training training = db.Trainings.Find(id);
		db.Trainings.Remove(training);
		db.SaveChanges();
		Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), $"Successfully deleted {training.TrainingDescription} (id:{training.TrainingId})");
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
