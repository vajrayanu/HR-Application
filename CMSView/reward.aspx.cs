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

public partial class CMSView_reward : System.Web.UI.Page
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
                sb.AppendLine(" SELECT rw.RW_ID, ");
                sb.AppendLine(" RewardName, ");
                sb.AppendLine(" RewardPicture, ");
                sb.AppendLine(" RewardPoint, ");
                sb.AppendLine(" RewardStore, ");
                sb.AppendLine(" rw.CreatedDate, ");
                sb.AppendLine(" CONVERT(date, rw.ExpiredDate) as ExpiredDate, ");
                sb.AppendLine(" case when RewardStatus = 1 then 'Active' else 'In-Active' end as [Status] ");
                sb.AppendLine(" FROM HR_Rewards as rw ");
                sb.AppendLine(" WHERE 1=1 ");

                SqlCommand sql = new SqlCommand(sb.ToString(), db);

                DataTable table = new DataTable();
                table.Load(sql.ExecuteReader());

                if (table.Rows.Count > 0)
                {
                    RptReward.DataSource = table;
                }

                RptReward.DataBind();
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
    public static string Onsubmit(string Title, string Store, string Point, string Status, string User, string rwid, string ExpireDate)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        string message = "Please contact IT!!";
        string PF_Name = "";

        string DatetimeNow = DateTime.Now.ToString("yyyy-MM-dd HH:mm", new System.Globalization.CultureInfo("en-US"));

        StringBuilder sb = new StringBuilder();
        SqlCommand sql = new SqlCommand(sb.ToString(), db);
        try
        {
            db.Open();

            string[] ExpireDateSplit = ExpireDate.Split('/');

            ExpireDate = ExpireDateSplit[2].ToString() + "-" + ExpireDateSplit[1] + "-" + ExpireDateSplit[0].ToString();

            if (rwid.Equals(""))
            {
                sb = new StringBuilder();
                sb.AppendLine(" INSERT INTO HR_Rewards ");
                sb.AppendLine(" ( ");
                sb.AppendLine(" 	RewardName, ");
                sb.AppendLine(" 	RewardStore, ");
                sb.AppendLine(" 	RewardPoint, ");
                sb.AppendLine(" 	RewardStatus, ");
                sb.AppendLine(" 	CreatedDate, ");
                sb.AppendLine(" 	UpdatedDate, ");
                sb.AppendLine(" 	UpdatedBy, ");
                sb.AppendLine(" 	ExpiredDate ");
                sb.AppendLine(" ) ");
                sb.AppendLine(" VALUES ");
                sb.AppendLine(" ( ");
                sb.AppendLine(" 	@RewardName, ");
                sb.AppendLine(" 	@RewardStore, ");
                sb.AppendLine(" 	@RewardPoint, ");
                sb.AppendLine(" 	@RewardStatus, ");
                sb.AppendLine(" 	GETDATE(), ");
                sb.AppendLine(" 	GETDATE(), ");
                sb.AppendLine(" 	@UpdatedBy, ");
                sb.AppendLine(" 	@ExpiredDate ");
                sb.AppendLine(" ) ");
                sb.AppendLine(" SELECT SCOPE_IDENTITY() ");

                sql = new SqlCommand(sb.ToString(), db);
                sql.Parameters.AddWithValue("RewardName", Title);
                sql.Parameters.AddWithValue("RewardStore", Store);
                sql.Parameters.AddWithValue("RewardPoint", Point);
                sql.Parameters.AddWithValue("RewardStatus", Status);
                sql.Parameters.AddWithValue("UpdatedBy", User);
                sql.Parameters.AddWithValue("ExpiredDate", ExpireDate);

                rwid = sql.ExecuteScalar().ToString();

                message = "Insert";
            }
            else
            {
                sb = new StringBuilder();
                sb.AppendLine(" UPDATE HR_Rewards ");
                sb.AppendLine(" SET ");
                sb.AppendLine(" RewardName = @RewardName, ");
                sb.AppendLine(" RewardStore = @RewardStore, ");
                sb.AppendLine(" RewardPoint = @RewardPoint, ");
                sb.AppendLine(" RewardStatus = @RewardStatus, ");
                sb.AppendLine(" UpdatedDate = GETDATE(), ");
                sb.AppendLine(" UpdatedBy = @UpdatedBy, ");
                sb.AppendLine(" ExpiredDate = @ExpiredDate ");
                sb.AppendLine(" WHERE 1=1 ");
                sb.AppendLine(" and RW_ID = @rwid ");

                sql = new SqlCommand(sb.ToString(), db);
                sql.Parameters.AddWithValue("rwid", rwid);
                sql.Parameters.AddWithValue("RewardName", Title);
                sql.Parameters.AddWithValue("RewardStore", Store);
                sql.Parameters.AddWithValue("RewardPoint", Point);
                sql.Parameters.AddWithValue("RewardStatus", Status);
                sql.Parameters.AddWithValue("UpdatedBy", User);
                sql.Parameters.AddWithValue("ExpiredDate", ExpireDate);

                sql.ExecuteNonQuery();

                message = "Edit";
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

        var objResponse = new { message = message, rwid = rwid, DatetimeNow = DatetimeNow };
        return JsonConvert.SerializeObject(objResponse);
    }
}