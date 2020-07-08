using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using System.Configuration;
using System.Data.SqlClient;
using System.Web.Services;
using System.Text;
using Newtonsoft.Json;

public partial class CMSView_hrForm : System.Web.UI.Page
{
    public string Username = string.Empty;
    public string UserID = string.Empty;
    public string UserGroup = string.Empty;
    public string UserSelected = string.Empty;
    public string UserLogin = string.Empty;
    protected void Page_Load(object sender, EventArgs e)
    {
        hdAnnID.Value = "";
        List<string> _Userinfo = new List<string>();
        _Userinfo = (List<string>)Session["Userinfo"];

        if (Session["Userinfo"] != null)
        {
            Username = _Userinfo[0].ToString();
            UserID = _Userinfo[1].ToString();
            UserGroup = _Userinfo[2].ToString();
            UserLogin = _Userinfo[3].ToLower().ToString();
        }
        else
        {
            Response.Redirect(ResolveClientUrl("~/Login"), true);
        }
    }

    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        string connStr = ConfigurationManager.ConnectionStrings["connStrPortalDB"].ConnectionString;
        SqlConnection db = new SqlConnection(connStr);

        string annID = hdAnnID.Value;
        string status = annID != "" ? "update" : "add";

        try
        {
            db.Open();

            string group = ddlGroup.SelectedValue;
            string title = txtTitle.Text;
            string detail = txtDetail.Text;
            string startDate = txtStartDate.Text;
            string endDate = txtEndDate.Text;
            HttpPostedFile myUpload = Request.Files["postedFile"];
            String strFileName = Path.GetFileName(myUpload.FileName);
            string confirmValue = Request.Form["confirmValue"];

            if (confirmValue == "Yes")
            {
                string currentDate = DateTime.Now.ToString("yyyy-MM-dd HH:mm", new System.Globalization.CultureInfo("en-US"));
                string currentYear = DateTime.Now.Year.ToString();
                string filePath = "../assets/slide/" + currentYear + "/";
                string fullPath = filePath + strFileName;

                StringBuilder sb = new StringBuilder();
                sb = new StringBuilder();

                sb.AppendLine(" INSERT INTO ");
                sb.AppendLine(" [Announcement]( ");
                sb.AppendLine(" [ANN_Title], [ANN_Detail], [ANN_ImgName], [ANN_PathFileName], ");
                sb.AppendLine(" [ANN_StartDate], [ANN_EndDate], [ANN_Group], [ANN_UserLogon], [ANN_CreateDate])");
                sb.AppendLine(" VALUES( '" + title + "', '" + detail + "', '" + strFileName + "', '" + fullPath  + "', ");
                sb.AppendLine(" '" + startDate + "', '" + endDate + "', '" + group + "', '" + UserLogin + "', '" + currentDate + "')");

                HttpContext.Current.Response.Write("<br><br>" + sb + "<br><br>");

                SqlCommand sql = new SqlCommand(sb.ToString(), db);
                sql = new SqlCommand(sb.ToString(), db);
                sql.ExecuteNonQuery();

                bool folderExists = Directory.Exists(Server.MapPath(filePath));
                if (!folderExists)
                {
                    Directory.CreateDirectory(Server.MapPath(filePath));
                }
                myUpload.SaveAs(Server.MapPath(filePath + strFileName));

                ScriptManager.RegisterStartupScript(this, this.GetType(), "submit", "swal('Done!', 'It was succesfully update!', 'success');", true);
            }
            else
            {
                ScriptManager.RegisterStartupScript(this, this.GetType(), "submit", "swal('Cancelled', '" + annID + "', 'error');", true);
            }
        }
        catch (Exception ex)
        {
            ScriptManager.RegisterStartupScript(this, this.GetType(), "submit", "swal('Cannot " + status + "!', 'Please try again', 'error');", true);
            HttpContext.Current.Response.Write("====================== db close ======================<br><br>" + ex.Message + "<br>" + ex.StackTrace);
        }
        finally
        {
            db.Close();
           // HttpContext.Current.Response.Write("====================== db close ======================");
        }
    }

    [WebMethod]
    public static string updateAnnouncement()
    {
        string connStr = ConfigurationManager.ConnectionStrings["connStrPortalDB"].ConnectionString;
        SqlConnection db = new SqlConnection(connStr);

        string status = "";
        //HttpContext.Current.Response.Write("====================== in update ann ======================" + postedFile);
        try
        {
            //db.Open();

            //StringBuilder sb = new StringBuilder();
            //sb = new StringBuilder();



            //HttpPostedFile myUpoad = HttpContext.Current.Request.Files["postedFile"];

            //String strFileName = Path.GetFileName(myUpoad.FileName);
            //string currentYear = DateTime.Now.Year.ToString();
            //string path = "~/assets/slide/" + currentYear + "/";

            //bool folderExists = Directory.Exists(HttpContext.Current.Server.MapPath(path));
            //if (!folderExists)
            //{
            //    Directory.CreateDirectory(HttpContext.Current.Server.MapPath(path));
            //}
            //myUpoad.SaveAs(HttpContext.Current.Server.MapPath(path + strFileName));


            //HttpContext.Current.Response.Write("====================== in try update data ======================");

            //        [ANN_Title]
            //  ,[ANN_Detail]
            //  ,[ANN_ImgName]
            //  ,[ANN_PathFileName]
            //  ,[ANN_StartDate]
            //  ,[ANN_EndDate]
            //  ,[ANN_Group]
            //sb.AppendLine(" INSERT INTO ");
            //        sb.AppendLine(" [UserLog]( [ANN_Title], [ANN_Detail], [ANN_PathFileName] ) ");
            //        sb.AppendLine(" VALUES( '" + userLogin + "', " + appID + ", '" + currentDate + "' )");

            //SqlCommand sql = new SqlCommand(sb.ToString(), db);
            //sql = new SqlCommand(sb.ToString(), db);
            //sql.ExecuteNonQuery();
        }
        catch (Exception ex)
        {
            status = "Please contact IT.";
            HttpContext.Current.Response.Write("============== catch xxxxxxxxxxxxxxxxxxxxxxx =========" + ex.Message +"<br>"+ ex.StackTrace);
        }
        finally
        {
            db.Close();
            HttpContext.Current.Response.Write("====================== db close ======================");
        }

        updateAnn e = new updateAnn();
        e.status = status;

        return JsonConvert.SerializeObject(e);
    }

    public class updateAnn
    {
        public string status;
        public string annID;
    }

} 