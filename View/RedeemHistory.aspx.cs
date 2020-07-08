using Newtonsoft.Json;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class RedeemHistory : System.Web.UI.Page
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
                }
                else
                {
                    Response.Redirect(ResolveClientUrl("~/"));
                }

                StringBuilder sb = new StringBuilder();
                sb.AppendLine(" SELECT rw.RewardName, ");
                sb.AppendLine(" rw.RewardPicture, ");
                sb.AppendLine(" rd.Quantity, ");
                sb.AppendLine(" rd.Point, ");
                sb.AppendLine(" rd.Status, ");
                sb.AppendLine(" rd.CreatedDate ");
                sb.AppendLine(" FROM HR_Redeem as rd ");
                sb.AppendLine(" LEFT JOIN HR_Rewards as rw on rd.RW_ID = rw.RW_ID ");
                sb.AppendLine(" WHERE 1=1 ");
                sb.AppendLine(" and rd.Username = '" + Username + "' ");
                sb.AppendLine(" ORDER BY rd.CreatedDate DESC ");

                SqlCommand sql = new SqlCommand(sb.ToString(), db);

                DataTable table = new DataTable();
                table.Load(sql.ExecuteReader());

                if (table.Rows.Count > 0)
                {
                    RptRedeem.DataSource = table;
                }

                RptRedeem.DataBind();
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
    public static string GetReward(string page)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        List<Reward> Reward = new List<Reward>();
        Reward rw = new Reward();

        int _page = Convert.ToInt32(page) + 1;
        string loadmore = "";

        try
        {
            db.Open();
            
            int top = _page * 6;

            int startrow = (6 * (_page - 1)) + 1;
            int endrow = (6 * _page);

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT TOP " + top + " RW_ID, ");
            sb.AppendLine(" RewardName, ");
            sb.AppendLine(" RewardStore, ");
            sb.AppendLine(" RewardPoint, ");
            sb.AppendLine(" RewardPicture, ");
            sb.AppendLine(" ROW_NUMBER() OVER(ORDER BY CreatedDate DESC) AS row ");
            sb.AppendLine(" FROM HR_Rewards as rw ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and rw.RewardStatus = '1' ");
            sb.AppendLine(" ORDER BY CreatedDate DESC ");

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
                    rw = new Reward();
                    rw.rwid = table.Rows[i]["RW_ID"].ToString();
                    rw.Title = table.Rows[i]["RewardName"].ToString();
                    rw.Store = table.Rows[i]["RewardStore"].ToString();
                    rw.Point = String.Format("{0:N0}", Convert.ToDouble(table.Rows[i]["RewardPoint"]));
                    rw.Picture = "../images/Reward/" + table.Rows[i]["RewardPicture"].ToString();

                    Reward.Add(rw);
                }
            }

            if (table.Rows.Count <= 8)
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

        var objResponse = new { Reward = Reward, Page = _page, loadmore = loadmore };
        return JsonConvert.SerializeObject(objResponse);
    }

    public class Reward
    {
        public string Title;
        public string Picture;
        public string Store;
        public string Point;
        public string rwid;
    }
}