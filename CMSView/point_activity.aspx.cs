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
using System.Web.Services;
using Newtonsoft.Json;

public partial class CMSView_point_activity : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        try
        {
            db.Open();

            if (!Page.IsPostBack)
            {
                List<string> _Userinfo = new List<string>();
                _Userinfo = (List<string>)Session["Userinfo"];

                if (Session["Userinfo"] != null)
                {
                    string Username = _Userinfo[3].ToString();

                    HdnUser.Value = Username;
                }
                else
                {
                    Response.Redirect(ResolveClientUrl("~/"));
                }

                StringBuilder sb = new StringBuilder();
                sb.AppendLine(" SELECT PA_ID ");
                sb.AppendLine(" ,pf.PF_Name ");
                sb.AppendLine(" ,pf.PF_ID ");
                sb.AppendLine(" ,PA_Name ");
                sb.AppendLine(" ,case when PA_Status = 1 then 'Active' else 'In-Active' end as [Status]  ");
                sb.AppendLine(" ,UpdatedDate ");
                sb.AppendLine(" FROM HR_PointActivity as pa ");
                sb.AppendLine(" LEFT JOIN HR_PointFamily as pf on pf.PF_ID = pa.PF_ID ");
                sb.AppendLine(" WHERE 1=1 ");

                SqlCommand sql = new SqlCommand(sb.ToString(), db);

                DataTable table = new DataTable();
                table.Load(sql.ExecuteReader());

                if (table.Rows.Count > 0)
                {
                    RptPointActivity.DataSource = table;
                }

                RptPointActivity.DataBind();

                sb = new StringBuilder();
                sb.AppendLine(" SELECT PF_ID, ");
                sb.AppendLine(" PF_Name ");
                sb.AppendLine(" FROM HR_PointFamily as pf ");
                sb.AppendLine(" WHERE 1=1 ");
                sb.AppendLine(" and pf.PF_Status = 1 ");

                sql = new SqlCommand(sb.ToString(), db);

                table = new DataTable();
                table.Load(sql.ExecuteReader());

                if (table.Rows.Count > 0)
                {
                    DdlCategory.DataSource = table;
                }

                DdlCategory.DataBind();
                DdlCategory.Items.Insert(0, new ListItem("==== Select ====", ""));
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
    public static string Onsubmit(string Category, string Name, string User, string Status, string PAID)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        string message = "Please contact IT!!";
        string PF_Name = "";

        string DatetimeNow = DateTime.Now.ToString("yyyy-MM-dd HH:mm", new System.Globalization.CultureInfo("en-US"));

        StringBuilder sb = new StringBuilder();
        try
        {
            db.Open();

            sb = new StringBuilder();
            sb.AppendLine(" SELECT PA_ID ");
            sb.AppendLine(" FROM HR_PointActivity as pa ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and pa.PF_ID = '" + Category + "' ");
            sb.AppendLine(" and pa.PA_Name = '" + Name + "' ");

            SqlCommand sql = new SqlCommand(sb.ToString(), db);

            DataTable table = new DataTable();
            table.Load(sql.ExecuteReader());

            if (PAID.Equals(""))
            {
                if (table.Rows.Count > 0)
                {
                    message = "Point Activity is Dupicate. Please change name.";
                }
                else
                {
                    sb = new StringBuilder();
                    sb.AppendLine(" INSERT INTO HR_PointActivity ");
                    sb.AppendLine(" ( ");
                    sb.AppendLine(" 	PF_ID, ");
                    sb.AppendLine(" 	PA_Name, ");
                    sb.AppendLine(" 	PA_Status, ");
                    sb.AppendLine(" 	CreatedDate, ");
                    sb.AppendLine(" 	CreatedBy, ");
                    sb.AppendLine(" 	UpdatedDate, ");
                    sb.AppendLine(" 	UpdatedBy ");
                    sb.AppendLine(" ) ");
                    sb.AppendLine(" VALUES ");
                    sb.AppendLine(" ( ");
                    sb.AppendLine(" 	@PF_ID, ");
                    sb.AppendLine(" 	@PA_Name, ");
                    sb.AppendLine(" 	1, ");
                    sb.AppendLine(" 	GETDATE(), ");
                    sb.AppendLine(" 	@CreatedBy, ");
                    sb.AppendLine(" 	GETDATE(), ");
                    sb.AppendLine(" 	@UpdatedBy ");
                    sb.AppendLine(" ) ");

                    sql = new SqlCommand(sb.ToString(), db);
                    sql.Parameters.AddWithValue("PF_ID", Category);
                    sql.Parameters.AddWithValue("PA_Name", Name);
                    sql.Parameters.AddWithValue("CreatedBy", User);
                    sql.Parameters.AddWithValue("UpdatedBy", User);

                    sql.ExecuteNonQuery();

                    message = "Insert";
                }
            }
            else
            {
                sb = new StringBuilder();
                sb.AppendLine(" UPDATE HR_PointActivity ");
                sb.AppendLine(" SET PA_Name = '" + Name + "', ");
                sb.AppendLine(" PA_Status = '" + Status + "', ");
                sb.AppendLine(" UpdatedDate = GETDATE(), ");
                sb.AppendLine(" UpdatedBy = '" + User + "' ");
                sb.AppendLine(" WHERE 1=1 ");
                sb.AppendLine(" and PA_ID = '" + PAID + "' ");

                sql = new SqlCommand(sb.ToString(), db);

                sql.ExecuteNonQuery();

                message = "Edit";
            }

            sb = new StringBuilder();
            sb.AppendLine(" SELECT pf.PF_Name ");
            sb.AppendLine(" FROM HR_PointFamily as pf ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and pf.PF_ID = '" + Category + "' ");

            sql = new SqlCommand(sb.ToString(), db);

            table = new DataTable();
            table.Load(sql.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                PF_Name = table.Rows[0]["PF_Name"].ToString();
            }
        }
        catch (Exception ex)
        {
            message = "Please contact IT!!";
        }
        finally
        {
            db.Close();
        }

        var objResponse = new { message = message, paid = PAID, PF_Name = PF_Name, DatetimeNow = DatetimeNow };
        return JsonConvert.SerializeObject(objResponse);
    }

}