using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;

namespace BSMWeb
{
    public class RouteConfig
    {
        public static void RegisterRoutes(RouteCollection routes)
        {
            routes.IgnoreRoute("{resource}.axd/{*pathInfo}");

            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Data", action = "TrainingMatrix", id = UrlParameter.Optional }
            );
            routes.MapRoute(
                name: "Director",
                url: "{controller}/{action}/{id}",
                defaults: new { controller = "Director", action = "Index", id = UrlParameter.Optional }
            ); routes.MapRoute(
                 name: "Periodicity",
                 url: "{controller}/{action}/{id}",
                 defaults: new { controller = "Periodicity", action = "Index", id = UrlParameter.Optional }
             );
        }
    }
}
