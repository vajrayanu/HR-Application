using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Configuration;
using System.Text;
using System.Threading;
using System.Web.UI.HtmlControls;
using System.Security.Cryptography;
using Newtonsoft.Json;
using System.Web.Services;

public partial class requestTimeOff : System.Web.UI.Page
{
    public string connString = "";
    public string Username = string.Empty;
    public string UserGroup = string.Empty;
    public string UserSelected = string.Empty;
    public string UserLogin = string.Empty;
    public string UserEmail = string.Empty;
    public string annualLeave = "0";
    public int totalAnnualLeave = 0;
    public string sickLeave = "0";
    public int totalSickLeave = 0;
    public double withOutPayLeave = 0;
    public double otherLeave = 0;
    public string lastVacation = "";
    public string lastSickLeave = "";
    public string lastWithOutPay = "";
    public string lastOtherLeave = "";


    protected void Page_Load(object sender, EventArgs e)
    {
        connString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;

        List<string> _Userinfo = new List<string>();
        _Userinfo = (List<string>)Session["Userinfo"];

        if (Session["Userinfo"] != null)
        {
            Username = _Userinfo[0].ToString();
            UserEmail = _Userinfo[1].ToString();
            UserGroup = _Userinfo[2].ToString();
            UserLogin = _Userinfo[3].ToLower().ToString();

            DataTable tbLeaveHis = new DataTable();

            getLeave(connString, UserEmail);
            tbLeaveHis = getLeaveHistory(connString, UserEmail);
            showLeaveHistory(tbLeaveHis);

        }
        else
        {
            Response.Redirect("Login", true);
        }
    }

    protected void getLeave(string connString, string UserEmail)
    {
        SqlConnection db = new SqlConnection(connString);

        try
        {
            db.Open();
            StringBuilder sqLeave = new StringBuilder();

            string[] splUser = UserLogin.Split('.');

            sqLeave.AppendLine(" SELECT [TotalAnnualLeave],[AnnualLeave],[TotalSickLeave],[SickLeave] ");
            sqLeave.AppendLine(" FROM[WSE_HR].[dbo].[vWSE_EmployeeLeave] ");
            sqLeave.AppendLine(" where Email = '" + UserEmail + "' ");

            SqlCommand sql = new SqlCommand(sqLeave.ToString(), db);
            DataTable table = new DataTable();
            sql.CommandTimeout = 240;
            table.Load(sql.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                annualLeave = table.Rows[0]["AnnualLeave"].ToString();
                totalAnnualLeave = Convert.ToInt32(table.Rows[0]["TotalAnnualLeave"]);
                sickLeave = table.Rows[0]["SickLeave"].ToString();
                totalSickLeave = Convert.ToInt32(table.Rows[0]["TotalSickLeave"]);
            }
        }
        catch (Exception ex)
        {
            //Response.Write("SalePlan:ajax_perform_loaddetail:GetLeadIn Err : " + ex.Message + " | StackTrace : " + ex.StackTrace);
        }
        finally
        {
            db.Close();
        }
    }

    protected void showLeaveHistory(DataTable tbLeaveHistory)
    {
        try
        {
            if (tbLeaveHistory.Rows.Count > 0)
            {
                double calWithOutPayLeave = 0;
                double calOtherLeave = 0;

                for (int i = 0; i < tbLeaveHistory.Rows.Count; i++)
                {
                    DataRow rowData = tbLeaveHistory.Rows[i];
                    HtmlTableRow row = new HtmlTableRow();

                    string leaveStartDate = String.Format("{0:dd/MM/yyyy}", rowData["LeaveStartDate"]);
                    string leaveEndDate = String.Format("{0:dd/MM/yyyy}", rowData["LeaveEndDate"]);
                    string leaveName = rowData["Leave_NameE"].ToString();
                    string leaveDateTotal = rowData["Leave_DateTotal"].ToString();
                    string leaveType = rowData["leave_type"].ToString();
                    string leaveCount = rowData["leaveCount"].ToString();
                    string approve = rowData["Approve"].ToString();
                    string approved = rowData["Approved"].ToString();
                    string iconStatus = "";
                    string approveStatus = "";
                    string dataShow = "";

                    if (i < 5)
                    {                        
                        switch (leaveName)
                        {
                            case "Annual Leave":
                                lastVacation += "<li>" + leaveStartDate + " - " + leaveEndDate + "</li>";
                                break;
                            case "Sick Leave":
                                lastSickLeave += "<li>" + leaveStartDate + " - " + leaveEndDate + "</li>";
                                break;
                            case "Leave without pay":
                                lastWithOutPay += "<li>" + leaveStartDate + " - " + leaveEndDate + "</li>";
                                break;
                            default:
                                 lastOtherLeave += "<li>" + leaveStartDate + " - " + leaveEndDate + "</li>";
                                break;
                        }
                    }

                    for (int cellcount = 0; cellcount < 8; cellcount++)
                    {
                        HtmlTableCell cell;
                        cell = new HtmlTableCell();

                        switch (approve)
                        {
                            case "A":
                                iconStatus = "<i class='fas fa-check-circle color-green'></i>";
                                break;
                            case "N":
                                iconStatus = "<i class='fas fa-times-circle color-red'></i>";
                                approveStatus = approved;
                                break;
                            default:
                                iconStatus = "<i class='fas fa-hourglass-half'></i>";
                                approveStatus = approved;
                                break;
                        }

                        switch (cellcount)
                        {
                            case 0:
                                var iconName = "";
                                switch (leaveName)
                                {
                                    case "Annual Leave":
                                        iconName = "fas fa-umbrella-beach";
                                        break;
                                    case "Sick Leave":
                                        iconName = "fas fa-thermometer-three-quarters";
                                        break;
                                    case "Leave without pay":
                                        iconName = "fab fa-creative-commons-nc";
                                        calWithOutPayLeave = calWithOutPayLeave + Convert.ToDouble(leaveCount);
                                        withOutPayLeave = calWithOutPayLeave;
                                        break;
                                    default:
                                        iconName = "fas fa-info";
                                        calOtherLeave = calOtherLeave + Convert.ToDouble(leaveCount);
                                        otherLeave = calOtherLeave;
                                        break;
                                }

                                dataShow = "<i data-toggle='tooltip' title='" + leaveName + "' class='" + iconName + "'></i>";

                                break;
                            case 1:
                                dataShow = leaveStartDate;
                                break;
                            case 2:
                                dataShow = leaveEndDate;
                                break;
                            case 3:
                                dataShow = leaveDateTotal;
                                break;
                            case 4:
                                dataShow = leaveType;
                                break;
                            case 5:
                                dataShow = leaveCount;
                                break;
                            case 6:
                                dataShow = iconStatus;
                                break;
                            case 7:
                                dataShow = approveStatus;
                                break;
                        }

                        cell.Controls.Add(new LiteralControl(dataShow));

                        row.Cells.Add(cell);
                    }
                    tbLeaveHis.Controls.Add(row);
                }
            }
        }
        catch (Exception ex)
        {
            //Response.Write("SalePlan:ajax_perform_loaddetail:GetLeadIn Err : " + ex.Message + " | StackTrace : " + ex.StackTrace);
        }
    }

    protected DataTable getLeaveHistory(string connString, string UserEmail)
    {
        SqlConnection db = new SqlConnection(connString);

        try
        {
            db.Open();
            StringBuilder sqLeave = new StringBuilder();

            string[] splUser = UserLogin.Split('.');

            sqLeave.AppendLine(" SELECT [LeaveStartDate] ");
            sqLeave.AppendLine(" ,[LeaveEndDate] ");
            sqLeave.AppendLine(" ,[Leave_NameE] ");
            sqLeave.AppendLine(" ,[Leave_DateTotal] ");
            sqLeave.AppendLine(" ,[leave_type] ");
            sqLeave.AppendLine(" ,[leaveCount] ");
            sqLeave.AppendLine(" ,[Approve], [Approved] ");
            sqLeave.AppendLine(" FROM [WSE_HR].[dbo].[vWSE_EmployeeLeaveDetail] ");
            sqLeave.AppendLine(" where email = '" + UserEmail + "' ");
            sqLeave.AppendLine(" Order by LeaveStartDate desc ");

            SqlCommand sql = new SqlCommand(sqLeave.ToString(), db);
            DataTable dbTable = new DataTable();
            sql.CommandTimeout = 240;
            dbTable.Load(sql.ExecuteReader());
            
            return dbTable;
        }
        catch (Exception ex)
        {
            //Response.Write("SalePlan:ajax_perform_loaddetail:GetLeadIn Err : " + ex.Message + " | StackTrace : " + ex.StackTrace);
            return new DataTable();
        }
        finally
        {
            db.Close();
        }
    }

}