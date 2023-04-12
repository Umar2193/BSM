
using System.Configuration;
using System.Data;
using System.Net;
using System.Web.Mvc;
using BSMDataAccess;
using BSMWeb.Models;

[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
public class AuditLogsController : Controller
{
	private string _connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

	private BSMEntities db = new BSMEntities();

	[HttpGet]
	public ActionResult Index()
	{
		string reviewerName = null;
		string auditDate = null;
		DataSet dataSet = DataViewer.GetReviewSheet(_connectionString, reviewerName, auditDate);
		return View(dataSet);
	}

	[HttpPost]
	public ActionResult Index(string auditDate, string reviewerName)
	{
		string _auditDate = null;
		string _reviewerName = null;
		if (auditDate != "")
		{
			_auditDate = auditDate;
		}
		if (reviewerName != "")
		{
			_reviewerName = reviewerName;
		}
		DataSet dataSet = DataViewer.GetReviewSheet(_connectionString, _reviewerName, _auditDate);
		return View(dataSet);
	}

	public ActionResult Details(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		AuditLog auditLog = db.AuditLogs.Find(id);
		if (auditLog == null)
		{
			return HttpNotFound();
		}
		return View(auditLog);
	}

	public ActionResult Create()
	{
		return View();
	}

	[HttpPost]
	[ValidateAntiForgeryToken]
	public ActionResult Create([Bind(Include = "AuditLogId,ReviewerName,AuditDate,ActionTaken,Comments")] AuditLog auditLog)
	{
		if (base.ModelState.IsValid)
		{
			db.AuditLogs.Add(auditLog);
			db.SaveChanges();
			return RedirectToAction("Index");
		}
		return View(auditLog);
	}

	public ActionResult Edit(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		AuditLog auditLog = db.AuditLogs.Find(id);
		if (auditLog == null)
		{
			return HttpNotFound();
		}
		return View(auditLog);
	}

	[HttpPost]
	[ValidateAntiForgeryToken]
	public ActionResult Edit(string id, string Comments)
	{
		DataViewer.EditAuditLog(_connectionString, id, Comments);
		return RedirectToAction("Index");
	}

	public ActionResult Delete(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		AuditLog auditLog = db.AuditLogs.Find(id);
		if (auditLog == null)
		{
			return HttpNotFound();
		}
		return View(auditLog);
	}

	[HttpPost]
	[ActionName("Delete")]
	[ValidateAntiForgeryToken]
	public ActionResult DeleteConfirmed(int id)
	{
		AuditLog auditLog = db.AuditLogs.Find(id);
		db.AuditLogs.Remove(auditLog);
		db.SaveChanges();
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
