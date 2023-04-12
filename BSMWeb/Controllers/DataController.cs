
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Linq;
using System.Web.Mvc;
using BSMDataAccess;
using BSMWeb.Models;

[MemberAuthorize(new UserType[]
{
	UserType.BSMADMIN,
	UserType.BSMMAN
})]
public class DataController : Controller
{
	private string _connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

	private BSMEntities db = new BSMEntities();

	[HttpGet]
	public ActionResult TrainingMatrix()
	{
		PopulateList();
		int departmentId = 0;
		int jobTitleId = 0;
		DataSet dataSet = DataViewer.GetTrainingMatrix(_connectionString, departmentId, jobTitleId);
		return View(dataSet);
	}

	[HttpPost]
	public ActionResult TrainingMatrix(FormCollection form, string departmentList, string jobTitleList)
	{
		int departmentId = 0;
		int jobTitleId = 0;
		form["departmentList"].ToString();
		departmentId = ((!(form["departmentList"].ToString() == "")) ? Convert.ToInt32(form["departmentList"].ToString()) : 0);
		PopulateList();
		DataSet dataSet = DataViewer.GetTrainingMatrix(_connectionString, departmentId, jobTitleId);
		return View(dataSet);
	}

	public void PopulateList()
	{
		var departmentList = db.Departments.Select((Department dept) => new { dept.DepartmentId, dept.DepartmentName }).ToList();
		var jobTitleList = db.JobTitles.Select((JobTitle title) => new { title.JobTitleId, title.JobTitleName }).ToList();
		base.ViewBag.Department = new SelectList(departmentList, "DepartmentId", "DepartmentName");
		base.ViewBag.JobTitle = new SelectList(jobTitleList, "JobTitleId", "JobTitleName");
	}

	[HttpGet]
	public ActionResult ReviewSheet()
	{
		return View();
	}

	public ActionResult TrainingArchive()
	{
		return View();
	}

	[HttpGet]
	public ActionResult ExpirySheet()
	{
		string searchDate = null;
		DataSet dataSet = DataViewer.GetExpirySheet(_connectionString, searchDate);
		return View(dataSet);
	}

	[HttpPost]
	public ActionResult ExpirySheet(string searchDate)
	{
		DataSet dataSet = DataViewer.GetExpirySheet(_connectionString, searchDate);
		return View(dataSet);
	}

	[HttpGet]
	public ActionResult TrainingReport()
	{
		DataSet dataSet = new DataSet();
		GetDepartment();
		int skillsId = 0;
		dataSet = DataViewer.GetTrainingReport(_connectionString, skillsId);
		base.ViewBag.departmentID = 0;
		base.ViewBag.skillID = 0;
		return View(dataSet);
	}

	[HttpPost]
	public ActionResult TrainingReport(string departmentList, string id)
	{
		int skillsId = Convert.ToInt32(id);
		DataSet dataSet = new DataSet();
		GetDepartment();
		dataSet = DataViewer.GetTrainingReport(_connectionString, skillsId);
		base.ViewBag.departmentID = departmentList;
		base.ViewBag.skillID = id;
		return View(dataSet);
	}

	public JsonResult GetSkills(int DepartmentId)
	{
		db.Configuration.ProxyCreationEnabled = false;
		List<SelectListItem> items = (from x in db.Skills
									  where x.DepartmentId == (int?)DepartmentId
									  select new SelectListItem
									  {
										  Value = x.SkillsId.ToString(),
										  Text = x.SkillsDescription.ToString()
									  }).ToList();
		return Json(items, JsonRequestBehavior.AllowGet);
	}

	public void GetDepartment()
	{
		int depType = (from deptType in db.DepartmentTypes
					   where deptType.DepartmentTypeName == "Skills Department"
					   select deptType.DepartmentTypeId).FirstOrDefault();
		var departmentList = (from dept in db.Departments
							  where dept.DepartmentTypeId == (int?)depType
							  select new { dept.DepartmentId, dept.DepartmentName }).ToList();
		base.ViewBag.Department = new SelectList(departmentList, "DepartmentId", "DepartmentName");
	}
}
