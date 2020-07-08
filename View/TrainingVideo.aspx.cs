using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.Configuration;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class TrainingVideo : System.Web.UI.Page
{
    public string connString = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        connString = ConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(connString);
        db.Open();

        if (!Page.IsPostBack)
        {
            List<string> _Userinfo = new List<string>();
            _Userinfo = (List<string>)Session["Userinfo"];

            if (Session["Userinfo"] != null)
            {
                string StaffName = _Userinfo[0].ToString();
                string Email = _Userinfo[1].ToString();
                string ShrtName = _Userinfo[3].ToString();

                HdnStaffName.Value = ShrtName;
            }
        }

        getVdoCover(db);
    }

    protected void getVdoCover(SqlConnection db)
    {
        try
        {
            StringBuilder groupApps = new StringBuilder();

            groupApps.AppendLine(" SELECT * FROM ");
            groupApps.AppendLine(" (SELECT [File_ID] ");
            groupApps.AppendLine(" ,[File_Type_ID] ");
            groupApps.AppendLine(" ,[File_Name] ");
            groupApps.AppendLine(" ,[File_Dept] ");
            groupApps.AppendLine(" ,[File_Title] ");
            groupApps.AppendLine(" ,[File_CreatedBy] ");
            groupApps.AppendLine(" ,[File_UpdatedBy] ");
            groupApps.AppendLine(" ,[File_CreatedDate] ");
            groupApps.AppendLine(" ,[File_UpdatedDate] ");
            groupApps.AppendLine(" ,[File_Highlight] ");
            groupApps.AppendLine(" ,[File_Status] ");
            groupApps.AppendLine(" ,[File_Deleted] ");
            groupApps.AppendLine(" ,ROW_NUMBER() OVER ( ");
            groupApps.AppendLine(" PARTITION BY [File_Dept] ");
            groupApps.AppendLine(" ORDER BY [File_CreatedDate] DESC ");
            groupApps.AppendLine(" ) AS [ROW_NUMBER] ");
            groupApps.AppendLine(" FROM [WSE_HR].[dbo].[HR_Training_FileUpload] WHERE [File_Highlight] = 1 and [File_Status] = 1) groups ");
            groupApps.AppendLine(" WHERE groups.[ROW_NUMBER] = 1 ");
            groupApps.AppendLine(" ORDER BY groups.File_CreatedDate DESC ");

            SqlCommand command = new SqlCommand(groupApps.ToString(), db);
            DataTable table = new DataTable();
            table.Load(command.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                foreach (DataRow row in table.Rows)
                {
                    string iframe = row[2].ToString();
                    row["File_Name"] = Regex.Match(iframe, "<iframe.+?src=[\"'](.+?)[\"'].*?>", RegexOptions.IgnoreCase).Groups[1].Value;
                }

                RptVDO.DataSource = table;
                RptVDO.DataBind();
            }
        }
        catch
        {
        }
    }

    [WebMethod]
    public static string cntVideo(string FileID, string User)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);
        string msg = "";
        try
        {
            db.Open();

            string query = "INSERT INTO [dbo].[HR_VideoClick] ([C_FileID], [C_UserID], [C_CreatedDate]) VALUES ('" + FileID + "', '" + User + "', '" + DateTime.Now + "')";
            SqlCommand command = new SqlCommand(query.ToString(), db);
            DataTable table = new DataTable();
            table.Load(command.ExecuteReader());
        }
        catch (Exception ex)
        {
        }
        finally
        {
            db.Close();
        }
        return msg;
    }
}