using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Threading;
using System.Web.UI.HtmlControls;
using System.Security.Cryptography;
using Newtonsoft.Json;
using System.Web.Services;

public partial class CMSView_home : System.Web.UI.Page
{
    public string yearCopyright = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        yearCopyright = DateTime.Now.ToString("yyyy", new System.Globalization.CultureInfo("en-US"));
    }
}