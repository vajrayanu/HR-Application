using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class companyDirectory : System.Web.UI.Page
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

    [WebMethod]
    public static string GetDetailAnnouncement(string anid)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        string Message = "";
        string Detail = "";
        string UploadDoc = "";
        string UploadImage = "";

        try
        {
            db.Open();

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT DIR_Detail, ");
            sb.AppendLine(" DIR_UploadDoc, ");
            sb.AppendLine(" DIR_UploadImage ");
            sb.AppendLine(" FROM HR_Announcement as an ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and an.DIR_ID = '" + anid + "' ");

            SqlCommand sql = new SqlCommand(sb.ToString(), db);

            DataTable table = new DataTable();
            table.Load(sql.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                Detail = table.Rows[0]["DIR_Detail"].ToString();
                UploadDoc = table.Rows[0]["DIR_UploadDoc"].ToString();
                UploadImage = table.Rows[0]["DIR_UploadImage"].ToString();
            }

            Message = "200";
        }
        catch (Exception ex)
        {
            Message = "500";
        }
        finally
        {
            db.Close();
        }

        var objResponse = new { Message = Message, Detail = Detail, UploadDoc = UploadDoc, UploadImage = UploadImage };
        return JsonConvert.SerializeObject(objResponse);
    }

    [WebMethod]
    public static string GetAnnouncement(string page, string group)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        List<Announcement> Announcement = new List<Announcement>();
        Announcement an = new Announcement();

        int _page = Convert.ToInt32(page) + 1;
        string loadmore = "";

        try
        {
            db.Open();

            int top = _page * 8;

            int startrow = (8 * (_page - 1)) + 1;
            int endrow = (8 * _page);

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT TOP " + top + " DIR_Title, ");
            sb.AppendLine(" DIR_UploadImage, ");
            sb.AppendLine(" DIR_ID, ");
            sb.AppendLine(" DIR_Detail, ");
            sb.AppendLine(" DIR_UploadDoc, ");
            sb.AppendLine(" DIR_UploadImage, ");
            sb.AppendLine(" DIR_StartDate, ");
            sb.AppendLine(" DIR_Type, ");
            sb.AppendLine(" ROW_NUMBER() OVER(ORDER BY DIR_SlideOrder, DIR_StartDate DESC) AS row ");
            sb.AppendLine(" FROM HR_Announcement as an ");
            sb.AppendLine(" LEFT JOIN HR_Group as gr on an.DIR_Group = gr.GP_ID ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and (gr.GP_Name = '" + group + "' or an.DIR_Group = 0) ");
            sb.AppendLine(" and an.DIR_Deleted is null ");
            sb.AppendLine(" and an.DIR_Status = 1 ");
            sb.AppendLine(" and an.DIR_Type in (1,3) ");
            sb.AppendLine(" and CONVERT(date, an.DIR_StartDate) <= CONVERT(date, GETDATE()) ");
            sb.AppendLine(" and (CONVERT(date, an.DIR_EndDate) > CONVERT(date, GETDATE()) or an.DIR_EndDate is null) ");
            sb.AppendLine(" ORDER BY DIR_SlideOrder, DIR_StartDate DESC ");

            SqlCommand sql = new SqlCommand(sb.ToString(), db);

            DataTable table = new DataTable();
            table.Load(sql.ExecuteReader());

            DataView Dvtable = table.DefaultView;
            if (table.Rows.Count > 0)
            {
                Dvtable.RowFilter = "row >= " + startrow + " and row <= " + endrow;
            }

            table = Dvtable.ToTable();

            if (table.Rows.Count > 0)
            {
                for (int i = 0; i < table.Rows.Count; i++)
                {
                    an = new Announcement();
                    an.Title = table.Rows[i]["DIR_Title"].ToString();
                    an.Detail = table.Rows[i]["DIR_Detail"].ToString();
                    an.AnnouncementType = table.Rows[i]["DIR_Type"].ToString();
                    an.ANID = table.Rows[i]["DIR_ID"].ToString();
                    an.Doc = table.Rows[i]["DIR_UploadDoc"].ToString();
                    an.Image = table.Rows[i]["DIR_UploadImage"].ToString();
                    an.StartDate = Convert.ToDateTime(table.Rows[i]["DIR_StartDate"]).ToString("yyyy-MM-dd", new System.Globalization.CultureInfo("en-US"));

                    Announcement.Add(an);
                }
            }

            if (table.Rows.Count < 8)
            {
                loadmore = "1";
            }
        }
        catch (Exception ex)
        {
        }
        finally
        {
            db.Close();
        }

        var objResponse = new { Announcement = Announcement, Page = _page, loadmore = loadmore };
        return JsonConvert.SerializeObject(objResponse);
    }

    public class Announcement
    {
        public string Title;
        public string Detail;
        public string AnnouncementType;
        public string ANID;
        public string Doc;
        public string Image;
        public string StartDate;
    }
}