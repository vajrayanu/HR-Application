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

public partial class point : System.Web.UI.Page
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
                StringBuilder sb = new StringBuilder();
                sb.AppendLine(" SELECT TOP 8 RW_ID, ");
                sb.AppendLine(" RewardName, ");
                sb.AppendLine(" RewardStore, ");
                sb.AppendLine(" RewardPoint, ");
                sb.AppendLine(" RewardPicture, ");
                sb.AppendLine(" CONVERT(date, rw.ExpiredDate), ");
                sb.AppendLine(" ROW_NUMBER() OVER(ORDER BY CreatedDate DESC) AS row ");
                sb.AppendLine(" FROM HR_Rewards as rw ");
                sb.AppendLine(" WHERE 1=1 ");
                sb.AppendLine(" and rw.RewardStatus = '1' ");
                sb.AppendLine(" and CONVERT(date, rw.ExpiredDate) >= CONVERT(date, GETDATE()) ");
                sb.AppendLine(" ORDER BY CreatedDate DESC ");

                SqlCommand sql = new SqlCommand(sb.ToString(), db);

                DataTable table = new DataTable();
                table.Load(sql.ExecuteReader());

                if (table.Rows.Count > 0)
                {
                    RptReward.DataSource = table;
                }

                RptReward.DataBind();

                if (table.Rows.Count < 8)
                {
                    PnMore.Visible = false;
                }

                sb = new StringBuilder();
                sb.AppendLine(" SELECT TOP 5 em.Fname ");
                sb.AppendLine(" ,em.Lname ");
                sb.AppendLine(" ,em.Department ");
                sb.AppendLine(" ,em.Position ");
                sb.AppendLine(" ,pb.Point_Balance ");
                sb.AppendLine(" ,em.Email ");
                sb.AppendLine(" FROM Point_Balance as pb ");
                sb.AppendLine(" LEFT JOIN crm.dbo.vWSE_HR_EmployeeData as em on em.Email = pb.Email ");
                sb.AppendLine(" WHERE 1=1 ");
                sb.AppendLine(" and ResignStatus = 1 ");
                sb.AppendLine(" and EndDate is null ");
                sb.AppendLine(" ORDER BY Point_Balance DESC ");

                sql = new SqlCommand(sb.ToString(), db);

                table = new DataTable();
                table.Load(sql.ExecuteReader());

                if (table.Rows.Count > 0)
                {
                    table.Columns.Add("Img");

                    foreach (DataRow row in table.Rows)
                    {
                        try
                        {
                            var email = row["Email"].ToString();
                            if (email == null)
                            {
                                row["Img"] = ResolveClientUrl("~/images/iconperson.png");
                            }

                            HttpWebRequest request = WebRequest.Create("https://mail.wallstreetenglish.in.th/ews/Exchange.asmx/s/GetUserPhoto?email=" + email + "&size=HR240x240") as HttpWebRequest;
                            // Submit the request.
                            System.Net.NetworkCredential netCredential = new System.Net.NetworkCredential("it.report", "Report345!");
                            request.Credentials = netCredential;
                            using (HttpWebResponse resp = request.GetResponse() as HttpWebResponse)
                            {
                                // Take the response and save it as an image.
                                Bitmap image = new Bitmap(resp.GetResponseStream());
                                using (MemoryStream ms = new MemoryStream())
                                {
                                    image.Save(ms, System.Drawing.Imaging.ImageFormat.Png);
                                    byte[] byteImage = ms.ToArray();
                                    var ImgUrl = "data:image/png;base64," + Convert.ToBase64String(byteImage);
                                    row["Img"] = ImgUrl;
                                }
                            }
                        }
                        catch
                        {
                            row["Img"] = ResolveClientUrl("~/images/iconperson.png");
                        }
                    }

                    RptTop.DataSource = table;
                }

                RptTop.DataBind();
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
            
            int top = _page * 8;

            int startrow = (8 * (_page - 1)) + 1;
            int endrow = (8 * _page);

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