using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Text.RegularExpressions;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class MoreTrainingVideo : System.Web.UI.Page
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

        var dept = Request.QueryString["Dept"];
        DeptID.Text = dept.ToString();
        getCoverTrainingVideo(dept, db);
        getMoreVdo(dept, db);
        getMoreVdoBottom(dept, db);
    }

    protected void getCoverTrainingVideo(string dept, SqlConnection db)
    {
        string query = "SELECT TOP 1 [File_ID] ,[File_Type_ID] ,[File_Name] ,[File_Dept] ,[File_Title] ,[File_CreatedBy] ,[File_UpdatedBy] ,[File_CreatedDate] ,[File_UpdatedDate] ,[File_Highlight] FROM[WSE_HR].[dbo].[HR_Training_FileUpload] WHERE [File_Dept] = '" + dept + "' and [File_Type_ID] = 2 and [File_Highlight] = '1' and [File_Status] = 1 and [File_Deleted] = 0 ORDER BY [File_CreatedDate] desc ";
        SqlCommand command = new SqlCommand(query.ToString(), db);
        DataTable table = new DataTable();
        table.Load(command.ExecuteReader());

        if (table.Rows.Count > 0)
        {
            foreach (DataRow row in table.Rows)
            {
                string iframe = row[2].ToString();
                row["File_Name"] = Regex.Match(iframe, "<iframe.+?src=[\"'](.+?)[\"'].*?>", RegexOptions.IgnoreCase).Groups[1].Value;
            }

            RptHVDO.DataSource = table;
            RptHVDO.DataBind();
        }
    }

    protected void getMoreVdo(string dept, SqlConnection db)
    {
        try
        {
            StringBuilder groupApps = new StringBuilder();

            groupApps.AppendLine(" SELECT TOP 3[File_ID] ");
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
            groupApps.AppendLine(" FROM [WSE_HR].[dbo].[HR_Training_FileUpload] ");
            groupApps.AppendLine(" WHERE [File_Status] = 1 and [File_Highlight] = 0 and [File_Dept] = '" + dept + "' and [File_Type_ID] = 2 and [File_Deleted] = 0 ");
            groupApps.AppendLine(" ORDER BY [File_CreatedDate] DESC ");

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

                RptMoreVDO.DataSource = table;
                RptMoreVDO.DataBind();
            }
        }
        catch
        {

        }
    }

    protected void getMoreVdoBottom(string dept, SqlConnection db)
    {
        try
        {
            StringBuilder groupApps = new StringBuilder();

            groupApps.AppendLine(" SELECT TOP 11 [File_ID] ");
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
            groupApps.AppendLine(" FROM [WSE_HR].[dbo].[HR_Training_FileUpload] ");
            groupApps.AppendLine(" WHERE [File_Status] = 1 and [File_Highlight] = 0 and [File_Dept] = '" + dept + "' and [File_Type_ID] = 2 and [File_Deleted] = 0 ");
            groupApps.AppendLine(" ORDER BY [File_CreatedDate] DESC ");

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

                for (int i = 1; i <= table.Rows.Count; i++)
                {
                    if (i <= 3)
                    {
                        table.Rows[i].Delete();
                    }
                }

                table.AcceptChanges();

                RptVDOBottom.DataSource = table;
                RptVDOBottom.DataBind();
            }
        }
        catch
        {

        }
    }
}