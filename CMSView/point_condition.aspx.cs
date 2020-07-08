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

public partial class CMSView_point_condition : System.Web.UI.Page
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
                sb.AppendLine(" SELECT pa.PA_ID, ");
                sb.AppendLine(" pf.PF_Name + ': ' + pa.PA_Name as PA_Name ");
                sb.AppendLine(" FROM HR_PointActivity as pa ");
                sb.AppendLine(" LEFT JOIN HR_PointFamily as pf on pf.PF_ID = pa.PF_ID ");
                sb.AppendLine(" WHERE 1=1 ");
                sb.AppendLine(" and pa.PA_Status = '1' ");
                sb.AppendLine(" ORDER BY pa.PF_ID ");

                SqlCommand sql = new SqlCommand(sb.ToString(), db);

                DataTable table = new DataTable();
                table.Load(sql.ExecuteReader());

                if (table.Rows.Count > 0)
                {
                    DdlPointActivity.DataSource = table;
                }

                DdlPointActivity.DataBind();

                sb = new StringBuilder();
                sb.AppendLine(" SELECT pc.PC_ID, ");
                sb.AppendLine(" pc.PA_ID, ");
                sb.AppendLine(" PC_Name, ");
                sb.AppendLine(" PC_Condition, ");
                sb.AppendLine(" PC_ConditionEnd, ");
                sb.AppendLine(" Point, ");
                sb.AppendLine(" StartDate, ");
                sb.AppendLine(" EndDate, ");
                sb.AppendLine(" case when PC_Status = 1 then 'Active' else 'In-Active' end as [Status], ");
                sb.AppendLine(" pa.PA_Name ");
                sb.AppendLine(" FROM HR_PointCondition as pc ");
                sb.AppendLine(" LEFT JOIN HR_PointActivity as pa on pc.PA_ID = pa.PA_ID ");
                sb.AppendLine(" WHERE 1=1 ");
                //sb.AppendLine(" and pc.PC_Status = 1 ");
                //sb.AppendLine(" and pa.PA_Status = 1 ");
                sql = new SqlCommand(sb.ToString(), db);

                table = new DataTable();
                table.Load(sql.ExecuteReader());

                DataView view = new DataView(table);
                DataTable distinctValues = view.ToTable(true, "PA_Name", "PA_ID");

                string body = "";
                if (distinctValues.Rows.Count > 0)
                {
                    for (int i = 0; i < distinctValues.Rows.Count; i++)
                    {
                        string PA_ID_ = distinctValues.Rows[i]["PA_ID"].ToString();
                        string PA_Name = distinctValues.Rows[i]["PA_Name"].ToString();

                        body += "<div class=\"head_point\">";
                        body += PA_Name;
                        body += "</div>";

                        body += "<table id=\"tblPointCondition" + PA_ID_ + "\" class=\"table tblPointCondition" + PA_ID_ + "\" cellpadding=\"0\" cellspacing=\"0\" border=\"1\">";
                        body += "   <thead class=\"thead-dark\">";
                        body += "       <tr>";
                        body += "           <th>Point Name</th>";
                        body += "           <th>Point</th>";

                        if (PA_ID_.Equals("2"))
                        {
                            body += "           <th>Target</th>";
                            body += "           <th>End Target</th>";
                        }

                        body += "           <th>Start Date</th>";
                        body += "           <th>End Date</th>";
                        body += "           <th>Status</th>";
                        body += "           <th></th>";
                        body += "       </tr>";
                        body += "   </thead>";

                        DataView DvData = new DataView(table);
                        DvData.RowFilter = "PA_Name = '" + PA_Name + "' ";

                        DataTable DtbData = new DataTable();
                        DtbData = DvData.ToTable();

                        if (DtbData.Rows.Count > 0)
                        {
                            for (int j = 0; j < DtbData.Rows.Count; j++)
                            {
                                string PC_ID = DtbData.Rows[j]["PC_ID"].ToString();
                                string PA_ID = DtbData.Rows[j]["PA_ID"].ToString();
                                string Status = DtbData.Rows[j]["Status"].ToString();
                                string PC_Name = DtbData.Rows[j]["PC_Name"].ToString();
                                string PC_Condition = DtbData.Rows[j]["PC_Condition"].ToString();
                                string PC_ConditionEnd = DtbData.Rows[j]["PC_ConditionEnd"].ToString();
                                string Point = DtbData.Rows[j]["Point"].ToString();
                                string StartDate = Convert.ToDateTime(DtbData.Rows[j]["StartDate"]).ToString("yyyy-MM-dd", new System.Globalization.CultureInfo("en-US"));
                                string Show_StartDate = Convert.ToDateTime(DtbData.Rows[j]["StartDate"]).ToString("dd/MM/yyyy", new System.Globalization.CultureInfo("en-US"));
                                string EndDate = DtbData.Rows[j]["EndDate"].ToString() != "" ? Convert.ToDateTime(DtbData.Rows[j]["EndDate"]).ToString("yyyy-MM-dd", new System.Globalization.CultureInfo("en-US")) : "";
                                string Show_EndDate = DtbData.Rows[j]["EndDate"].ToString() != "" ? Convert.ToDateTime(DtbData.Rows[j]["EndDate"]).ToString("dd/MM/yyyy", new System.Globalization.CultureInfo("en-US")) : "";
                                string class_status = Status != "Active" ? "inactive" : "active";

                                body += "<tr id=\"pcrow" + PC_ID + "\" class=\"t_" + Status + "\">";

                                body += "   <td id=\"pcname" + PC_ID + "\">" + PC_Name + "</td>";
                                body += "   <td id=\"po" + PC_ID + "\">" + Point + "</td>";

                                if (PA_ID_.Equals("2"))
                                {
                                    body += "   <td id=\"target" + PC_ID + "\">" + PC_Condition + "</td>";
                                    body += "   <td id=\"endtarget" + PC_ID + "\">" + PC_ConditionEnd + "</td>";
                                }

                                body += "   <td id=\"startdate" + PC_ID + "\">" + StartDate + "</td>";
                                body += "   <td id=\"enddate" + PC_ID + "\">" + EndDate + "</td>";
                                body += "   <td id=\"status" + PC_ID + "\" class=\"" + class_status + "\">" + Status + "</td>";
                                body += "   <td id=\"edit" + PC_ID + "\" class=\"text-center\" pcid='" + PC_ID + "' endtarget=\"" + PC_ConditionEnd + "\" target=\"" + PC_Condition + "\" paid=\"" + PA_ID + "\" point=\"" + Point + "\" startdate=\"" + Show_StartDate + "\" enddate=\"" + Show_EndDate + "\" pcname=\"" + PC_Name + "\" status=\"" + Status + "\"><i class=\"fas fa-pencil-alt mr-2 pcedit\"></i></td>";

                                body += "</tr>";
                            }
                        }

                        body += "</table>";
                    }
                }

                tablebody.Text = body;
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
    public static string Onsubmit(string PointActivity, string PointName, string Point, string Target, string EndTarget, string StartDate, string EndDate, string PCID, string Status, string User)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        string message = "Please contact IT!!";
        string PA_Name = "";

        string DatetimeNow = DateTime.Now.ToString("yyyy-MM-dd HH:mm", new System.Globalization.CultureInfo("en-US"));

        StringBuilder sb = new StringBuilder();
        SqlCommand sql = new SqlCommand(sb.ToString(), db);
        try
        {
            db.Open();

            string[] startdateSplit = StartDate.Split('/');

            StartDate = startdateSplit[2].ToString() + "-" + startdateSplit[1] + "-" + startdateSplit[0].ToString();

            if (!EndDate.Equals(""))
            {
                string[] enddateSplit = EndDate.Split('/');

                EndDate = enddateSplit[2].ToString() + "-" + enddateSplit[1] + "-" + enddateSplit[0].ToString();
            }

            if (PCID.Equals(""))
            {
                sb = new StringBuilder();
                sb.AppendLine(" INSERT INTO HR_PointCondition ");
                sb.AppendLine(" ( ");
                sb.AppendLine(" 	PA_ID, ");
                sb.AppendLine(" 	PC_Name, ");
                sb.AppendLine(" 	PC_Condition, ");
                sb.AppendLine("     PC_ConditionEnd, ");
                sb.AppendLine(" 	Point, ");
                sb.AppendLine(" 	StartDate, ");

                if (!EndDate.Equals(""))
                {
                    sb.AppendLine(" 	EndDate, ");
                }

                sb.AppendLine(" 	PC_Status, ");
                sb.AppendLine(" 	CreatedDate, ");
                sb.AppendLine(" 	CreatedBy, ");
                sb.AppendLine(" 	UpdatedDate, ");
                sb.AppendLine(" 	UpdatedBy ");
                sb.AppendLine(" ) ");
                sb.AppendLine(" VALUES ");
                sb.AppendLine(" ( ");
                sb.AppendLine(" 	@PA_ID, ");
                sb.AppendLine(" 	@PC_Name, ");
                sb.AppendLine(" 	@PC_Condition, ");
                sb.AppendLine(" 	@PC_ConditionEnd, ");
                sb.AppendLine(" 	@Point, ");
                sb.AppendLine(" 	@StartDate, ");

                if (!EndDate.Equals(""))
                {
                    sb.AppendLine(" 	@EndDate, ");
                }

                sb.AppendLine(" 	@PC_Status, ");
                sb.AppendLine(" 	GETDATE(), ");
                sb.AppendLine(" 	@CreatedBy, ");
                sb.AppendLine(" 	GETDATE(), ");
                sb.AppendLine(" 	@UpdatedBy ");
                sb.AppendLine(" ) ");
                sb.AppendLine(" SELECT SCOPE_IDENTITY() ");

                sql = new SqlCommand(sb.ToString(), db);
                sql.Parameters.AddWithValue("PA_ID", PointActivity);
                sql.Parameters.AddWithValue("PC_Name", PointName);
                sql.Parameters.AddWithValue("PC_Condition", Target);
                sql.Parameters.AddWithValue("PC_ConditionEnd", EndTarget);
                sql.Parameters.AddWithValue("Point", Point);
                sql.Parameters.AddWithValue("StartDate", StartDate);

                if (!EndDate.Equals(""))
                {
                    sql.Parameters.AddWithValue("EndDate", EndDate);
                }

                sql.Parameters.AddWithValue("PC_Status", Status);
                sql.Parameters.AddWithValue("CreatedBy", User);
                sql.Parameters.AddWithValue("UpdatedBy", User);

                PCID = sql.ExecuteScalar().ToString();

                message = "Insert";
            }
            else
            {
                sb = new StringBuilder();
                sb.AppendLine(" UPDATE HR_PointCondition ");
                sb.AppendLine(" SET PC_Name = '" + PointName + "', ");
                sb.AppendLine(" PC_Condition = '" + Target + "', ");
                sb.AppendLine(" PC_ConditionEnd = '" + EndTarget + "', ");
                sb.AppendLine(" Point = '" + Point + "', ");
                sb.AppendLine(" StartDate = '" + StartDate + "', ");

                if (!EndDate.Equals(""))
                {
                    sb.AppendLine(" EndDate = '" + EndDate + "', ");
                }

                sb.AppendLine(" PC_Status = '" + Status + "', ");
                sb.AppendLine(" UpdatedDate = GETDATE(), ");
                sb.AppendLine(" UpdatedBy = '" + User + "' ");
                sb.AppendLine(" WHERE 1=1 ");
                sb.AppendLine(" and PC_ID = '" + PCID + "' ");

                sql = new SqlCommand(sb.ToString(), db);

                sql.ExecuteNonQuery();

                message = "Edit";
            }

            sb = new StringBuilder();
            sb.AppendLine(" SELECT pa.PA_Name ");
            sb.AppendLine(" FROM HR_PointActivity as pa ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and pa.PA_ID = '" + PointActivity + "' ");

            sql = new SqlCommand(sb.ToString(), db);

            DataTable table = new DataTable();
            table.Load(sql.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                PA_Name = table.Rows[0]["PA_Name"].ToString();
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

        var objResponse = new { message = message, paname = PA_Name, pcid = PCID, DatetimeNow = DatetimeNow };
        return JsonConvert.SerializeObject(objResponse);
    }
}