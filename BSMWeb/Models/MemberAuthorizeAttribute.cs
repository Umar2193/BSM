using System.Collections.Generic;
using System.Linq;
using System.Web.Mvc;
using System.Web.Routing;
using BSMWeb.Models;
using Newtonsoft.Json;

public class MemberAuthorizeAttribute : ActionFilterAttribute
{
	private readonly List<UserType> _accountType;

	public MemberAuthorizeAttribute(params UserType[] accountType)
	{
		_accountType = accountType.ToList();
	}

	public override void OnActionExecuting(ActionExecutingContext context)
	{
		if (context.HttpContext.Session["User"] != null && !string.IsNullOrEmpty(context.HttpContext.Session["User"].ToString()) && context.HttpContext.Session["User"].ToString() != "null")
		{
			Employee user = JsonConvert.DeserializeObject<Employee>(context.HttpContext.Session["User"].ToString());
			if (user != null && !_accountType.Contains((UserType)user.UserType.Value))
			{
				context.Controller.TempData["Message"] = "Unauthorized access, Please login with the correct account";
				context.Result = new RedirectToRouteResult(new RouteValueDictionary(new
				{
					controller = "Login",
					action = "Index"
				}));
			}
		}
		else
		{
			context.Result = new RedirectToRouteResult(new RouteValueDictionary(new
			{
				controller = "Login",
				action = "Index"
			}));
		}
		base.OnActionExecuting(context);
	}
}
