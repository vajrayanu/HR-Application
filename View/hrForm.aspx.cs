using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text;
using System.Data;

public partial class hrForm : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        try
        {
            db.Open();

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT DIR_Title, ");
            sb.AppendLine(" DIR_UploadDoc, ");
            sb.AppendLine(" DIR_ID ");
            sb.AppendLine(" FROM HR_Announcement as an ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and an.DIR_Deleted is null ");
            sb.AppendLine(" and an.DIR_Status = 1 ");
            sb.AppendLine(" and an.DIR_Type = 4 ");
            sb.AppendLine(" and CONVERT(date, an.DIR_StartDate) <= CONVERT(date, GETDATE()) ");
            sb.AppendLine(" and (CONVERT(date, an.DIR_EndDate) > CONVERT(date, GETDATE()) or an.DIR_EndDate is null) ");
            sb.AppendLine(" ORDER BY DIR_SlideOrder, DIR_StartDate DESC ");

            SqlCommand sql = new SqlCommand(sb.ToString(), db);

            DataTable table = new DataTable();
            table.Load(sql.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                RptHRForm.DataSource = table;
            }

            RptHRForm.DataBind();
        }
        catch (Exception ex)
        {
            Response.Write(ex.Message + "<br/>");
            Response.Write(ex.StackTrace + "<br/>");
        }
        finally
        {
            db.Close();
        }
    }
}