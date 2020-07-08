using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;


public partial class logout : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {            
        clearSession();
        Response.Redirect("Login", true);
    }

    protected void clearSession()
    {
        if (Request.Cookies["UserSettings"] != null)
        {
            HttpCookie myCookie = new HttpCookie("UserSettings");
            myCookie.Expires = DateTime.Now.AddDays(-1d);
            Response.Cookies.Add(myCookie);
        }
        Session["UserInfo"] = null;
        Session.Clear();
        //Response.Cookies.Clear();
        //Session.Abandon();
    }

}
