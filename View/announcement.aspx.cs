using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class announcement : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        try
        {
            List<string> _Userinfo = new List<string>();
            _Userinfo = (List<string>)Session["Userinfo"];

            string group = "";
            if (Session["Userinfo"] != null)
            {
                group = _Userinfo[2].ToString();
                HdnGroup.Value = group;
            }

            db.Open();

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT DIR_Title, ");
            sb.AppendLine(" DIR_UploadImage, ");
            sb.AppendLine(" DIR_ID ");
            sb.AppendLine(" FROM HR_Announcement as an ");
            sb.AppendLine(" LEFT JOIN HR_Group as gr on an.DIR_Group = gr.GP_ID ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and (gr.GP_Name = '" + group + "' or an.DIR_Group = 0) ");
            sb.AppendLine(" and an.DIR_Deleted is null ");
            sb.AppendLine(" and an.DIR_Status = 1 ");
            sb.AppendLine(" and an.DIR_Type = 2 ");
            sb.AppendLine(" and CONVERT(date, an.DIR_StartDate) <= CONVERT(date, GETDATE()) ");
            sb.AppendLine(" and (CONVERT(date, an.DIR_EndDate) > CONVERT(date, GETDATE()) or an.DIR_EndDate is null) ");
            sb.AppendLine(" ORDER BY DIR_SlideOrder, DIR_StartDate DESC ");

            SqlCommand sql = new SqlCommand(sb.ToString(), db);

            DataTable table = new DataTable();
            table.Load(sql.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                RptSlideNumber.DataSource = table;
                RptSlide.DataSource = table;
            }

            RptSlideNumber.DataBind();
            RptSlide.DataBind();

            sb = new StringBuilder();
            sb.AppendLine(" SELECT TOP 8 DIR_Title, ");
            sb.AppendLine(" DIR_UploadImage, ");
            sb.AppendLine(" DIR_ID, ");
            sb.AppendLine(" DIR_Detail, ");
            sb.AppendLine(" DIR_UploadDoc, ");
            sb.AppendLine(" DIR_UploadImage, ");
            sb.AppendLine(" DIR_StartDate, ");
            sb.AppendLine(" DIR_Type ");
            sb.AppendLine(" FROM HR_Announcement as an ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and an.DIR_Deleted is null ");
            sb.AppendLine(" and an.DIR_Status = 1 ");
            sb.AppendLine(" and an.DIR_Type in (1,3) ");
            sb.AppendLine(" and CONVERT(date, an.DIR_StartDate) <= CONVERT(date, GETDATE()) ");
            sb.AppendLine(" and (CONVERT(date, an.DIR_EndDate) > CONVERT(date, GETDATE()) or an.DIR_EndDate is null) ");
            sb.AppendLine(" ORDER BY DIR_SlideOrder, DIR_StartDate DESC ");

            sql = new SqlCommand(sb.ToString(), db);

            table = new DataTable();
            table.Load(sql.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                RptAnnouncement.DataSource = table;
            }

            RptAnnouncement.DataBind();

            if (table.Rows.Count < 8)
            {
                PnMore.Visible = false;
            }
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