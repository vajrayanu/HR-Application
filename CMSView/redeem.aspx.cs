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

public partial class CMSView_redeem : System.Web.UI.Page
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
                    string Email = _Userinfo[1].ToString();

                    HdnUser.Value = Username;
                    HdnEmail.Value = Email;
                }
                else
                {
                    Response.Redirect(ResolveClientUrl("~/"));
                }
            }

            string page = HdnPage.Value;

            int paging = page == "" ? 1 : Convert.ToInt32(page);
            int startrow = (20 * (paging - 1)) + 1;
            int endrow = (20 * paging);

            string status = DdlStatus.SelectedValue;
            string requestby = TxtRequestBy.Text;

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT rd.CreatedDate, ");
            sb.AppendLine(" rd.RD_ID, ");
            sb.AppendLine(" rw.RewardName, ");
            sb.AppendLine(" rd.Quantity, ");
            sb.AppendLine(" ISNULL(em.Fname, '') + ' ' + ISNULL(em.Lname, '') as EmpName, ");
            sb.AppendLine(" case when rd.Status = 'W' then 'Pending' else  ");
            sb.AppendLine(" case when rd.Status = 'A' then 'Completed' else  ");
            sb.AppendLine(" case when rd.Status = 'R' then 'Reject' else '' end end end as Status, ");
            sb.AppendLine(" ROW_NUMBER() OVER(ORDER BY isnull(rd.CreatedDate, 0) DESC) AS row ");
            sb.AppendLine(" FROM HR_Redeem as rd ");
            sb.AppendLine(" LEFT JOIN HR_Rewards as rw on rw.RW_ID = rd.RW_ID ");
            sb.AppendLine(" LEFT JOIN CRM.dbo.vWSE_HR_EmployeeData as em on em.Email = rd.Email ");
            sb.AppendLine(" WHERE 1=1 ");

            if (!status.Equals(""))
            {
                sb.AppendLine(" and rd.Status = '" + status + "' ");
            }

            if (!requestby.Equals(""))
            {
                sb.AppendLine(" and ISNULL(em.Fname, '') + ' ' + ISNULL(em.Lname, '') LIKE '%" + requestby + "%' ");
            }

            SqlCommand sql = new SqlCommand(sb.ToString(), db);

            DataTable table = new DataTable();
            table.Load(sql.ExecuteReader());

            double p = Math.Ceiling(Convert.ToDouble(table.Rows.Count) / Convert.ToDouble(20));

            string showpage = "";

            if (p > 1)
            {
                if (p < 6)
                {
                    for (int i = 0; i < p; i++)
                    {
                        if (paging == (i + 1))
                        {
                            showpage += "<span page=\"" + (i + 1) + "\" class=\"page_active\" >" + (i + 1) + "</span>";
                        }
                        else
                        {
                            showpage += "<span page=\"" + (i + 1) + "\" class=\"page_inactive\" >" + (i + 1) + "</span>";
                        }
                    }
                }
                else
                {
                    double maxpage = (paging + 4) >= p ? p : (paging + 4);
                    if (paging == 1 || paging == 2 || paging == 3)
                    {
                        switch (paging)
                        {
                            case 2:
                                maxpage = maxpage - 1;
                                break;
                            case 3:
                                maxpage = maxpage - 2;
                                break;
                        }

                        for (int i = 0; i < maxpage; i++)
                        {
                            if (paging == (i + 1))
                            {
                                showpage += "<span page=\"" + (i + 1) + "\" class=\"page_active\" >" + (i + 1) + "</span>";
                            }
                            else
                            {
                                showpage += "<span page=\"" + (i + 1) + "\" class=\"page_inactive\" >" + (i + 1) + "</span>";
                            }
                        }

                        if (p > (paging + 4))
                        {
                            showpage += "<span page=\"" + p + "\" class=\"page_inactive\">&raquo;</span>";
                        }
                    }
                    else if (paging == (p - 2) || paging == (p - 1) || paging == p)
                    {
                        int _maxpage = paging;
                        if (paging == (p - 2)) { maxpage = (paging - 2) >= 1 ? (paging - 2) : 1; _maxpage = paging + 2; }
                        else if (paging == (p - 1)) { maxpage = (paging - 3) >= 1 ? (paging - 3) : 1; _maxpage = paging + 1; }
                        else { maxpage = (paging - 4) >= 1 ? (paging - 4) : 1; }

                        //maxpage = (paging - 4) >= 1 ? (paging - 4) : 1;

                        Response.Write("maxpage: " + maxpage);



                        if ((paging - 4) > 1)
                        {
                            showpage += "<span page=\"1\" class=\"page_inactive\">&laquo;</span>";
                        }

                        for (int i = Convert.ToInt32(maxpage - 1); i < _maxpage; i++)
                        {
                            if (paging == (i + 1))
                            {
                                showpage += "<span page=\"" + (i + 1) + "\" class=\"page_active\" >" + (i + 1) + "</span>";
                            }
                            else
                            {
                                showpage += "<span page=\"" + (i + 1) + "\" class=\"page_inactive\" >" + (i + 1) + "</span>";
                            }
                        }
                    }
                    else
                    {
                        showpage += "<span page=\"1\" class=\"page_inactive\">&laquo;</span>";

                        showpage += "<span page=\"" + (paging - 2) + "\" class=\"page_inactive\" >" + (paging - 2) + "</span>";
                        showpage += "<span page=\"" + (paging - 1) + "\" class=\"page_inactive\" >" + (paging - 1) + "</span>";
                        showpage += "<span page=\"" + paging + "\" class=\"page_active\" >" + paging + "</span>";
                        showpage += "<span page=\"" + (paging + 1) + "\" class=\"page_inactive\" >" + (paging + 1) + "</span>";
                        showpage += "<span page=\"" + (paging + 2) + "\" class=\"page_inactive\" >" + (paging + 2) + "</span>";

                        showpage += "<span page=\"" + p + "\" class=\"page_inactive\">&raquo;</span>";
                    }
                }

                LitPage.Text = showpage;
                LitPageButton.Text = showpage;
            }
            else
            {
                LitPage.Text = "";
                LitPageButton.Text = "";
            }

            DataView Dvtable = table.DefaultView;
            if (table.Rows.Count > 0)
            {
                Dvtable.RowFilter = "row >= " + startrow + " and row <= " + endrow;
            }

            table = Dvtable.ToTable();

            if (table.Rows.Count > 0)
            {
                RptRedeem.DataSource = table;
            }

            RptRedeem.DataBind();
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
    public static string getredeem(string rdid)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        string message = "";
        string EmpName = "";
        string Center = "";
        string Email = "";
        string RewardName = "";
        string Quantity = "";
        string Point = "";
        string Status = "";
        string Picture = "";
        string UpdatedBy = "";
        string UpdatedDate = "";

        try
        {
            db.Open();

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT em.Fname + ' ' + em.Lname as EmpName, ");
            sb.AppendLine(" em.Center, ");
            sb.AppendLine(" rd.Email, ");
            sb.AppendLine(" rw.RewardName, ");
            sb.AppendLine(" rd.Quantity, ");
            sb.AppendLine(" rw.RewardPicture, ");
            sb.AppendLine(" rd.Point, ");
            sb.AppendLine(" rd.UpdatedBy, ");
            sb.AppendLine(" rd.UpdatedDate, ");
            sb.AppendLine(" rd.Status ");
            sb.AppendLine(" FROM HR_Redeem as rd ");
            sb.AppendLine(" LEFT JOIN CRM.dbo.vWSE_HR_EmployeeData as em on em.Email = rd.Email ");
            sb.AppendLine(" LEFT JOIN HR_Rewards as rw on rw.RW_ID = rd.RW_ID ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and rd.RD_ID = '" + rdid + "' ");

            SqlCommand sql = new SqlCommand(sb.ToString(), db);

            DataTable table = new DataTable();
            table.Load(sql.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                EmpName = table.Rows[0]["EmpName"].ToString();
                Center = table.Rows[0]["Center"].ToString();
                Email = table.Rows[0]["Email"].ToString();
                RewardName = table.Rows[0]["RewardName"].ToString();
                Quantity = table.Rows[0]["Quantity"].ToString();
                Point = table.Rows[0]["Point"].ToString();
                Status = table.Rows[0]["Status"].ToString();
                Picture = "../images/Reward/" + table.Rows[0]["RewardPicture"].ToString();
                UpdatedBy = table.Rows[0]["UpdatedBy"].ToString();
                UpdatedDate = Convert.ToDateTime(table.Rows[0]["UpdatedDate"]).ToString("dd/MM/yyyy HH:mm", new System.Globalization.CultureInfo("en-US"));
            }

            message = "success";
        }
        catch (Exception ex)
        {
            //message = "Please contact IT!!";
            message = ex.Message + "_" + ex.StackTrace;
        }
        finally
        {
            db.Close();
        }

        var objResponse = new { message = message, EmpName = EmpName, Center = Center, Email = Email, RewardName = RewardName, Quantity = Quantity, Point = Point, Status= Status, Picture = Picture, UpdatedBy = UpdatedBy, UpdatedDate = UpdatedDate };
        return JsonConvert.SerializeObject(objResponse);
    }

    [WebMethod]
    public static string Onsubmit(string rdid, string type, string User, string Email)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        string message = "Please contact IT!!";

        try
        {
            db.Open();

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" UPDATE HR_Redeem ");
            sb.AppendLine(" SET Status = '" + type + "', ");
            sb.AppendLine(" UpdatedBy = '" + User + "', ");
            sb.AppendLine(" UpdatedDate = GETDATE() ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and RD_ID = '" + rdid + "' ");

            SqlCommand sql = new SqlCommand(sb.ToString(), db);

            sql.ExecuteNonQuery();

            if (type.Equals("R"))
            {
                sb = new StringBuilder();
                sb.AppendLine(" SELECT Point * Quantity as Point ");
                sb.AppendLine(" FROM HR_Redeem as rd ");
                sb.AppendLine(" WHERE 1=1 ");
                sb.AppendLine(" and rd.RD_ID = '" + rdid + "' ");

                sql = new SqlCommand(sb.ToString(), db);

                DataTable table = new DataTable();
                table.Load(sql.ExecuteReader());

                if (table.Rows.Count > 0)
                {
                    string Point = table.Rows[0]["Point"].ToString();

                    sb = new StringBuilder();
                    sb.AppendLine(" UPDATE Point_Balance ");
                    sb.AppendLine(" SET Point_Balance = Point_Balance + @Point, ");
                    sb.AppendLine(" Point_Redeem = Point_Redeem - @Point ");
                    sb.AppendLine(" WHERE 1=1 ");
                    sb.AppendLine(" and Email = '" + Email + "' ");

                    sql = new SqlCommand(sb.ToString(), db);
                    sql.Parameters.AddWithValue("Point", Point);

                    sql.ExecuteNonQuery();
                }
            }

            message = "success";
        }
        catch (Exception ex)
        {
            message = "Please contact IT!!";
        }
        finally
        {
            db.Close();
        }

        var objResponse = new { message = message };
        return JsonConvert.SerializeObject(objResponse);
    }
}