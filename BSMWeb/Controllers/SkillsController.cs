
using System;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web.Mvc;
using BSMWeb.Helpers;
using BSMWeb.Models;

[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
public class SkillsController : Controller
{
	private BSMEntities db = new BSMEntities();

	private Employee employee;

	public ActionResult Index()
	{
		IOrderedQueryable<Skill> skills = from x in db.Skills.Include((Skill s) => s.Department)
										  orderby x.SkillsDescription
										  orderby x.SkillsDescription
										  select x;
		return View(skills.ToList());
	}

	public ActionResult Details(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		Skill skill = db.Skills.Find(id);
		if (skill == null)
		{
			return HttpNotFound();
		}
		return View(skill);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Create()
	{
		int[] array = (from Id in db.DepartmentTypes
					   where Id.DepartmentTypeName == "Skills Department"
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
		base.ViewBag.PeriodicityId = new SelectList(db.Periodicities, "PeriodicityId", "PeriodicityName");
		return View();
	}

	[HttpPost]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Create([Bind(Include = "SkillsId,SkillsDescription,PeriodicityId,QMNumber,DepartmentId,SkillStatus")] Skill skill)
	{
		if (base.ModelState.IsValid)
		{
			db.Skills.Add(skill);
			db.SaveChanges();
			Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), "Successfully created " + skill.SkillsDescription + " ");
			return RedirectToAction("Index");
		}
		base.ViewBag.DepartmentId = new SelectList(db.Departments, "DepartmentId", "DepartmentName", skill.DepartmentId);
		base.ViewBag.PeriodicityId = new SelectList(db.Periodicities, "PeriodicityId", "PeriodicityName", skill.PeriodicityId);
		return View(skill);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Edit(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		Skill skill = db.Skills.Find(id);
		if (skill == null)
		{
			return HttpNotFound();
		}
		int[] array = (from Id in db.DepartmentTypes
					   where Id.DepartmentTypeName == "Skills Department"
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
		base.ViewBag.PeriodicityId = new SelectList(db.Periodicities, "PeriodicityId", "PeriodicityName", skill.PeriodicityId);
		return View(skill);
	}

	[HttpPost]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Edit([Bind(Include = "SkillsId,SkillsDescription,PeriodicityId,QMNumber,DepartmentId,SkillStatus")] Skill skill)
	{
		if (base.ModelState.IsValid)
		{
			db.Entry(skill).State = EntityState.Modified;
			db.SaveChanges();
			Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), $"Successfully edited {skill.SkillsDescription} (id:{skill.SkillsId})");
			return RedirectToAction("Index");
		}
		base.ViewBag.DepartmentId = new SelectList(db.Departments, "DepartmentId", "DepartmentName", skill.DepartmentId);
		base.ViewBag.PeriodicityId = new SelectList(db.Periodicities, "PeriodicityId", "PeriodicityName", skill.PeriodicityId);
		return View(skill);
	}

	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult Delete(int? id)
	{
		if (!id.HasValue)
		{
			return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
		}
		Skill skill = db.Skills.Find(id);
		if (skill == null)
		{
			return HttpNotFound();
		}
		return View(skill);
	}

	[HttpPost]
	[ActionName("Delete")]
	[ValidateAntiForgeryToken]
	[MemberAuthorize(new UserType[] { UserType.BSMADMIN })]
	public ActionResult DeleteConfirmed(int id)
	{
		Skill skill = db.Skills.Find(id);
		db.Skills.Remove(skill);
		db.SaveChanges();
		Helper.CreateLog(db, Helper.GetSessionEmployee(base.HttpContext), $"Successfully deleted {skill.SkillsDescription} (id:{skill.SkillsId}) ");
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
