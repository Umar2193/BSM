// BSMWeb, Version=1.0.0.1, Culture=neutral, PublicKeyToken=null
// BSMWeb.Helpers.Helper
using System;
using System.Web;
using BSMWeb.Models;
using Newtonsoft.Json;
namespace BSMWeb.Helpers
{
	public static class Helper
	{
		public static Employee GetSessionEmployee(HttpContextBase context)
		{
			Employee employee = null;
			if (context.Session["User"] != null && !string.IsNullOrEmpty(context.Session["User"].ToString()) && context.Session["User"].ToString() != "null")
			{
				Employee user = JsonConvert.DeserializeObject<Employee>(context.Session["User"].ToString());
				if (user != null)
				{
					employee = user;
				}
			}
			return employee;
		}

		public static void CreateLog(BSMEntities db, string name, string actionTaken)
		{
			AuditLog auditLog = new AuditLog
			{
				ReviewerName = name,
				ActionTaken = actionTaken,
				AuditDate = DateTime.UtcNow
			};
			db.AuditLogs.Add(auditLog);
			db.SaveChanges();
		}

		public static void CreateLog(BSMEntities db, Employee employee, string actionTaken)
		{
			AuditLog auditLog = new AuditLog
			{
				ReviewerName = employee.Username,
				ActionTaken = actionTaken,
				AuditDate = DateTime.UtcNow
			};
			db.AuditLogs.Add(auditLog);
			db.SaveChanges();
		}
	}
}