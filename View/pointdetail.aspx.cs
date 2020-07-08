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

public partial class pointdetail : System.Web.UI.Page
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
                string Username = "";
                string Email = "";

                List<string> _Userinfo = new List<string>();
                _Userinfo = (List<string>)Session["Userinfo"];

                if (Session["Userinfo"] != null)
                {
                    Username = _Userinfo[3].ToString();
                    Email = _Userinfo[1].ToString();

                    HdnUser.Value = Username;
                    HdnEmail.Value = Email;
                }
                else
                {
                    Response.Redirect(ResolveClientUrl("~/"));
                }

                string rwid = "";

                try
                {
                    rwid = Request.QueryString["rwid"].ToString();
                }
                catch { }

                if (rwid.Equals(""))
                {
                    rwid = Page.RouteData.Values["rwid"].ToString();
                }

                HdnRWID.Value = rwid;

                StringBuilder sb = new StringBuilder();
                sb.AppendLine(" SELECT RewardName, ");
                sb.AppendLine(" RewardStore, ");
                sb.AppendLine(" RewardPoint, ");
                sb.AppendLine(" RewardPicture ");
                sb.AppendLine(" FROM HR_Rewards as rw ");
                sb.AppendLine(" WHERE 1=1 ");
                sb.AppendLine(" and RW_ID = '" + rwid + "' ");

                SqlCommand sql = new SqlCommand(sb.ToString(), db);

                DataTable table = new DataTable();
                table.Load(sql.ExecuteReader());

                double rw_point = 0;

                if (table.Rows.Count > 0)
                {
                    LitTitle.Text = table.Rows[0]["RewardName"].ToString();

                    ImgReward.ImageUrl = ResolveClientUrl("~/images/Reward/" + table.Rows[0]["RewardPicture"].ToString());

                    rw_point = Convert.ToDouble(table.Rows[0]["RewardPoint"]);

                    LitPoint.Text = String.Format("{0:N0}", rw_point);
                    LitStore.Text = table.Rows[0]["RewardStore"].ToString();
                }

                sb = new StringBuilder();
                sb.AppendLine(" SELECT Point_Balance ");
                sb.AppendLine(" FROM Point_Balance as pb ");
                sb.AppendLine(" WHERE 1=1 ");
                sb.AppendLine(" and pb.Email = '" + Email + "' ");

                sql = new SqlCommand(sb.ToString(), db);

                table = new DataTable();
                table.Load(sql.ExecuteReader());

                double point_balance = 0;

                if (table.Rows.Count > 0)
                {
                    point_balance = table.Rows[0]["Point_Balance"].ToString() != "" ? Convert.ToDouble(table.Rows[0]["Point_Balance"]) : 0;

                    LitCurrentPoint.Text = String.Format("{0:N0}", point_balance);
                }

                if (point_balance < rw_point)
                {
                    btncart.Disabled = true;
                }
                else
                {
                    btncart.Disabled = false;
                }
            }
        }
        catch (Exception ex)
        {
        }
        finally
        {
            db.Close();
        }
    }

    [WebMethod]
    public static string redeem(string RWID, string User, string Email)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        string message = "";

        string Point_bl = "";
        try
        {
            db.Open();

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT rw.RewardPoint ");
            sb.AppendLine(" FROM HR_Rewards as rw ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and rw.RW_ID = '" + RWID + "' ");

            SqlCommand sql = new SqlCommand(sb.ToString(), db);

            DataTable table = new DataTable();
            table.Load(sql.ExecuteReader());

            double Reward_Point = 0;
            if (table.Rows.Count > 0)
            {
                Reward_Point = Convert.ToDouble(table.Rows[0]["RewardPoint"]);
            }

            sb = new StringBuilder();
            sb.AppendLine(" SELECT pb.Point_Balance ");
            sb.AppendLine(" FROM Point_Balance as pb ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and pb.Email = '" + Email + "' ");

            sql = new SqlCommand(sb.ToString(), db);

            table = new DataTable();
            table.Load(sql.ExecuteReader());

            double Point_Balance = 0;
            if (table.Rows.Count > 0)
            {
                Point_Balance = table.Rows[0]["Point_Balance"].ToString() != "" ? Convert.ToDouble(table.Rows[0]["Point_Balance"]) : 0;
            }

            if (Point_Balance < Reward_Point)
            {
                message = "point";
            }
            else
            {
                sb = new StringBuilder();
                sb.AppendLine(" INSERT INTO HR_Redeem ");
                sb.AppendLine(" ( ");
                sb.AppendLine(" 	Username, ");
                sb.AppendLine(" 	RW_ID, ");
                sb.AppendLine(" 	Email, ");
                sb.AppendLine(" 	Point, ");
                sb.AppendLine(" 	Quantity, ");
                sb.AppendLine(" 	Status, ");
                sb.AppendLine(" 	CreatedDate, ");
                sb.AppendLine(" 	CreatedBy, ");
                sb.AppendLine(" 	UpdatedDate, ");
                sb.AppendLine(" 	UpdatedBy ");
                sb.AppendLine(" ) ");
                sb.AppendLine(" VALUES ");
                sb.AppendLine(" ( ");
                sb.AppendLine(" 	@Username, ");
                sb.AppendLine(" 	@RW_ID, ");
                sb.AppendLine("     @Email, ");
                sb.AppendLine(" 	@Point, ");
                sb.AppendLine(" 	@Quantity, ");
                sb.AppendLine(" 	@Status, ");
                sb.AppendLine(" 	GETDATE(), ");
                sb.AppendLine(" 	@CreatedBy, ");
                sb.AppendLine(" 	GETDATE(), ");
                sb.AppendLine(" 	@UpdatedBy ");
                sb.AppendLine(" ) ");

                sql = new SqlCommand(sb.ToString(), db);
                sql.Parameters.AddWithValue("Username", User);
                sql.Parameters.AddWithValue("RW_ID", RWID);
                sql.Parameters.AddWithValue("Email", Email);
                sql.Parameters.AddWithValue("Point", Reward_Point);
                sql.Parameters.AddWithValue("Quantity", "1");
                sql.Parameters.AddWithValue("Status", "W");
                sql.Parameters.AddWithValue("CreatedBy", User);
                sql.Parameters.AddWithValue("UpdatedBy", User);

                sql.ExecuteNonQuery();

                sb = new StringBuilder();
                sb.AppendLine(" UPDATE Point_Balance ");
                sb.AppendLine(" SET Point_Balance = Point_Balance - @Reward_Point, ");
                sb.AppendLine(" Point_Redeem = ISNULL(Point_Redeem, 0) + @Reward_Point ");
                sb.AppendLine(" WHERE 1=1 ");
                sb.AppendLine(" and Email = '" + Email + "' ");

                sql = new SqlCommand(sb.ToString(), db);
                sql.Parameters.AddWithValue("Reward_Point", Reward_Point);

                sql.ExecuteNonQuery();

                message = "Insert";

                Point_bl = String.Format("{0:N0}", Point_Balance - Reward_Point);
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

        var objResponse = new { message = message, Point_bl = Point_bl };
        return JsonConvert.SerializeObject(objResponse);
    }
}