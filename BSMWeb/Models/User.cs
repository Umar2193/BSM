using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace BSMWeb.Models
{
	public class User
	{
		public string FirstName { get; set; }

		public string LastName { get; set; }

		public UserType UserType { get; set; }

		public string Username { get; set; }
	}
}