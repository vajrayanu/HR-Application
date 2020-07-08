using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.Globalization;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

public partial class View_Home : System.Web.UI.Page
{
    public string UserName = string.Empty;
    public string connString = "";
    public string UserGroup = "";
    public string UserID = "";
    public string UserLogin = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        connString = ConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(connString);

        List<string> _Userinfo = new List<string>();
        _Userinfo = (List<string>)Session["Userinfo"];

        try
        {
            db.Open();

            if (Session["Userinfo"] != null)
            {
                UserName = _Userinfo[0].ToString();
                txtUserName.Text = UserName;
                UserID = _Userinfo[1].ToString();
                UserGroup = _Userinfo[2].ToString();
                UserLogin = _Userinfo[3].ToLower().ToString();

                HdnUsername.Value = UserLogin;

                getEmployeeDatials(UserID, db);
                getSickLeave(UserID, db);
                getNewEmployee(db);
                getEmployeeBirthDay(UserID, db);
                getWSEApp(UserGroup, db);
                check_checkin(UserID, db);
                getSlideHilight(db);
            }
            else
            {
                Response.Redirect("Login", true);
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
    public static string editEmployeeDatials(string NickName, string Phone, string LineID, string FacebookID, string EmployeeID)
    {
        string message ="";

        try
        {
            string connString = ConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
            SqlConnection db = new SqlConnection(connString);
            StringBuilder groupApps = new StringBuilder();

            groupApps.AppendLine(" SELECT [ED_EmployeeDetailID] ,[ED_EmployeeID] ,[ED_NickName] ,[ED_PhoneNo] ,[ED_LineID] ,[ED_FacebookID] ,[ED_Deleted] ,[ED_CreatedDate] FROM [WSE_HR].[dbo].[EmployeeDetail] WHERE [ED_EmployeeID] = " + "'" + EmployeeID + "'" );
            db.Open();
            SqlCommand command = new SqlCommand(groupApps.ToString(), db);
            DataTable table = new DataTable();
            table.Load(command.ExecuteReader());

            if (table.Rows.Count == 0)
            {
                string query = " INSERT INTO [dbo].[EmployeeDetail] ([ED_EmployeeID],  [ED_NickName] , [ED_PhoneNo] , [ED_LineID] , [ED_FacebookID] , [ED_Deleted] , [ED_CreatedDate] ) VALUES ('"+EmployeeID+"','"+NickName+"','"+Phone+"','"+LineID+"','"+FacebookID+"','"+0+"','"+DateTime.Now+"')";
                SqlCommand cmd = new SqlCommand(query, db);
                cmd.ExecuteNonQuery();
            }
            else
            {
                string query = " UPDATE [dbo].[EmployeeDetail] SET [ED_EmployeeID] = '"+EmployeeID+ "', [ED_NickName] = '"+NickName+ "', [ED_PhoneNo] = '"+Phone+ "', [ED_LineID] = '"+LineID+ "', [ED_FacebookID]='"+FacebookID+ "', [ED_Deleted]= '" +0+ "', [ED_CreatedDate]='"+DateTime.Now+ "' WHERE [ED_EmployeeID] = '" + EmployeeID + "'";
                SqlCommand cmd = new SqlCommand(query, db);
                cmd.ExecuteNonQuery();
            }
            message = "true";
        }
        catch (Exception ex)
        {
            message ="false";
        }
        return message;

    }
    protected void getEmployeeDatials(string email, SqlConnection db)
    {
        try
        {
            StringBuilder groupApps = new StringBuilder();

            groupApps.AppendLine(" declare @email varchar(150) ");
            groupApps.AppendLine(" set @email =" + "'" + email + "'");
            groupApps.AppendLine(" select top 1 ED_EmployeeID ");
            groupApps.AppendLine(" , Email ");
            groupApps.AppendLine(" , ED_NickName ");
            groupApps.AppendLine(" , DepartmentCenter as EmployeeType ");
            groupApps.AppendLine(" , Center as Workplace ");
            groupApps.AppendLine(" , BirthDate ");
            groupApps.AppendLine(" , ED_PhoneNo ");
            groupApps.AppendLine(" , ED_LineID ");
            groupApps.AppendLine(" , ED_FacebookID ");
            groupApps.AppendLine(" from   [wse-ihr].WSEiHR.dbo.WSEEmployeeDetails as e ");
            groupApps.AppendLine(" left join EmployeeDetail as d on e.EmployeeID = d.ED_EmployeeID ");
            groupApps.AppendLine(" where 1=1 ");
            groupApps.AppendLine(" and email = @email ");
            groupApps.AppendLine(" order by StartDate desc ");
            //db.Open();
            SqlCommand command = new SqlCommand(groupApps.ToString(), db);
            DataTable table = new DataTable();
            table.Load(command.ExecuteReader());

            empWorkPlace.Text = table.Rows[0]["Workplace"].ToString();
            empNickName.Text = table.Rows[0]["ED_NickName"].ToString();
            empType.Text = table.Rows[0]["EmployeeType"].ToString();
            empPhone.Text = table.Rows[0]["ED_PhoneNo"].ToString();
            empLine.Text = table.Rows[0]["ED_LineID"].ToString();
            empFacebook.Text = table.Rows[0]["ED_FacebookID"].ToString();
        }

        catch
        {

        }
    }
    protected void getNewEmployee(SqlConnection db)
    {
        SqlDataReader rdr = null;

        try
        {
            SqlCommand command = new SqlCommand("select top 10  FirstName, LastName, Position, Department, Center, Email, StartDate from vWSE_NewEmployee order by StartDate desc", db);
            command.CommandType = CommandType.Text;
            rdr = command.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Columns.Add("ImgPath", typeof(System.String));
            dt.Load(rdr);

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    try
                    {
                        var email = row["Email"].ToString();
                        if (email == null)
                        {
                            row["ImgPath"] = ResolveClientUrl("~/images/iconperson.png");
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
                                row["ImgPath"] = ImgUrl;
                            }
                        }
                    }
                    catch
                    {
                        row["ImgPath"] = ResolveClientUrl("~/images/iconperson.png");
                    }
                }
                ImgNewEmp.DataSource = dt;
                ImgNewEmp.DataBind();
            }
        }
        catch (Exception ex)
        {
            //Response.Write("<br>==ex Err : " + ex.Message + " | StackTrace : " + ex.StackTrace);
        }
    }
    protected void getSickLeave(string emailID, SqlConnection db)
    {
        SqlDataReader rdr = null;

        try
        {
            SqlCommand command = new SqlCommand("select * from WSE_HR.dbo.vWSE_EmployeeLeave where Email ="+"'"+emailID+"'", db);
            command.CommandType = CommandType.Text;
            rdr = command.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(rdr);

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    try
                    {
                        var email = row["Email"].ToString();
                        if (email == null)
                        {
                            ImageProfile.ImageUrl = ResolveClientUrl("~/~/images/iconperson.png");
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
                                ImageProfile.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(byteImage);
                            }
                        }
                    }
                    catch
                    {
                        ImageProfile.ImageUrl = ResolveClientUrl("~/~/images/iconperson.png");
                    }
                }
            }
            Dept.Text = dt.Rows[0]["Department"].ToString();
            Position.Text = dt.Rows[0]["Position"].ToString();
            EmpID.Text = dt.Rows[0]["EmployeeID"].ToString();
            SickLeave.Text = dt.Rows[0]["SickLeave"].ToString();
            TotalSickLeave.Text = dt.Rows[0]["TotalSickLeave"].ToString();
            AnnualLeave.Text = dt.Rows[0]["AnnualLeave"].ToString();
            TotalAnnualLeave.Text = dt.Rows[0]["TotalAnnualLeave"].ToString();
            empStartWorking.Text = ((DateTime)dt.Rows[0]["StartDate"]).ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);
            empBirthday.Text = ((DateTime)dt.Rows[0]["BirthDate"]).ToString("dd/MM/yyyy", CultureInfo.InvariantCulture);

            string empBhd = Convert.ToDateTime(dt.Rows[0]["BirthDate"]).ToString();
            empBirthday.Text = String.Format("{0:dd/MM/yyyy}", dt.Rows[0]["BirthDate"]);

            int age = 0;
            DateTime dateOfBirth = Convert.ToDateTime(empBhd);
            age = DateTime.Now.Year - dateOfBirth.Year;
            if (DateTime.Now.DayOfYear < dateOfBirth.DayOfYear)
            {
                age = age - 1;
                EmpAge.Text = age.ToString();
            }
            else
            {
                EmpAge.Text = age.ToString();
            }
            
        }
        catch (Exception ex)
        {
            //Response.Write("<br>==ex Err : " + ex.Message + " | StackTrace : " + ex.StackTrace);
        }
    }
    protected void getEmployeeBirthDay(string UserID, SqlConnection db)
    {
        SqlDataReader rdr = null;

        try
        {
            StringBuilder sbSql = new StringBuilder();

            sbSql.AppendLine(" declare @UserID varchar(150) ");
            sbSql.AppendLine(" set @UserID = '" + UserID + "'  ");
            sbSql.AppendLine("  ");
            sbSql.AppendLine(" declare @temp table ");
            sbSql.AppendLine(" ( ");
            sbSql.AppendLine("   department varchar(50) , center varchar(50) ");
            sbSql.AppendLine(" ) ");
            sbSql.AppendLine("  ");
            sbSql.AppendLine(" insert @temp ");
            sbSql.AppendLine(" select top 1 Department , Center ");
            sbSql.AppendLine(" from vWSE_EmployeeLeave ");
            sbSql.AppendLine(" where 1=1 ");
            sbSql.AppendLine(" and ResignStatus = 1 ");
            sbSql.AppendLine(" and email = @UserID ");
            sbSql.AppendLine("  ");
            sbSql.AppendLine("  ");
            sbSql.AppendLine(" SELECT * ");
            sbSql.AppendLine("   FROM [vWSE_EmployeeBirthDay] ");
            sbSql.AppendLine("   where 1=1 ");
            sbSql.AppendLine("   and Department = (select Department from @temp) ");
            sbSql.AppendLine("   and Center = (select center from @temp) ");

            SqlCommand command = new SqlCommand(sbSql.ToString(), db);
            command.CommandType = CommandType.Text;
            rdr = command.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Columns.Add("ImgPath", typeof(System.String));
            dt.Load(rdr);

            if (dt.Rows.Count > 0)
            {
                foreach (DataRow row in dt.Rows)
                {
                    try
                    {
                        var email = row["Email"].ToString();
                        if (email == null)
                        {
                            row["ImgPath"] = ResolveClientUrl("~/images/iconperson.png");
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
                                row["ImgPath"] = ImgUrl;
                            }
                        }
                    }
                    catch
                    {
                        row["ImgPath"] = ResolveClientUrl("~/images/iconperson.png");
                    }
                }
                ImgBirthDay.DataSource = dt;
                ImgBirthDay.DataBind();
            }
        }
        catch (Exception ex)
        {
            //Response.Write("<br>==ex Err : " + ex.Message + " | StackTrace : " + ex.StackTrace);
        }
    }
    protected void getWSEApp(string dept, SqlConnection db)
    {
        try
        {
            StringBuilder groupApps = new StringBuilder();

            groupApps.AppendLine(" declare @channel varchar(25) ");
            groupApps.AppendLine(" set @channel =" + "'"+dept+"'");
            groupApps.AppendLine(" SELECT App_ApplicationName ");
            groupApps.AppendLine(" , App_ApplicationLink ");
            groupApps.AppendLine(" , App_icon ");
            groupApps.AppendLine(" , app_Detail ");
            groupApps.AppendLine(" FROM Application_List as al ");
            groupApps.AppendLine(" left join Application_Permission as ap on al.app_ID = apm_app_id ");
            groupApps.AppendLine(" left join Employee_Profile as ep on ep.EP_ID = ap.apm_ep_id ");
            groupApps.AppendLine(" where 1=1 ");
            groupApps.AppendLine(" and ep_employeeprofile = @channel ");
            groupApps.AppendLine(" and app_deleted = 'false' ");
            groupApps.AppendLine(" and apm_deleted = 'false' ");
            groupApps.AppendLine(" and apm_disabled = 'false' ");

            SqlCommand command = new SqlCommand(groupApps.ToString(), db);
            DataTable table = new DataTable();
            table.Load(command.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                RptWseApps.DataSource = table;
                RptWseApps.DataBind();
            }
        }
        catch
        {

        }
    }

    protected void getSlideHilight(SqlConnection db)
    {
        try
        {
            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT TOP 1 DIR_Title, ");
            sb.AppendLine(" DIR_UploadImage, ");
            sb.AppendLine(" DIR_Detail, ");
            sb.AppendLine(" DIR_ID ");
            sb.AppendLine(" FROM HR_Announcement as an ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and an.DIR_Deleted is null ");
            sb.AppendLine(" and an.DIR_Status = 1 ");
            sb.AppendLine(" and an.DIR_Highlight = 1 ");
            sb.AppendLine(" and an.DIR_Type = 2 ");
            sb.AppendLine(" and CONVERT(date, an.DIR_StartDate) <= CONVERT(date, GETDATE()) ");
            sb.AppendLine(" and (CONVERT(date, an.DIR_EndDate) > CONVERT(date, GETDATE()) or an.DIR_EndDate is null) ");
            sb.AppendLine(" ORDER BY DIR_SlideOrder, DIR_StartDate DESC ");

            SqlCommand command = new SqlCommand(sb.ToString(), db);
            DataTable table = new DataTable();
            table.Load(command.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                string DIR_Title = table.Rows[0]["DIR_Title"].ToString();
                string DIR_Detail = table.Rows[0]["DIR_Detail"].ToString();
                string DIR_ID = table.Rows[0]["DIR_ID"].ToString();
                string DIR_UploadImage = table.Rows[0]["DIR_UploadImage"].ToString();

                if (!DIR_UploadImage.Equals(""))
                {
                    ImgHilight.ImageUrl =  ResolveClientUrl("~/~/images/Announcement/" + DIR_ID + "/images/" + DIR_UploadImage);
                    ImgHilight.Attributes.Add("title", DIR_Title);
                    ImgHilight.Attributes.Add("detail", DIR_Detail);
                }
                else
                {
                    ImgHilight.ImageUrl = ResolveClientUrl("~/~/images/nohilight.png");
                }
            }
            else
            {
                ImgHilight.ImageUrl = ResolveClientUrl("~/~/images/nohilight.png");
            }
        }
        catch
        {

        }
    }

    protected void check_checkin(string Email, SqlConnection db)
    {
        StringBuilder sb = new StringBuilder();
        sb.AppendLine(" SELECT ck.SC_ID ");
        sb.AppendLine(" FROM HR_StaffCheckin as ck ");
        sb.AppendLine(" WHERE 1=1 ");
        sb.AppendLine(" and ck.Email = '" + Email + "' ");
        sb.AppendLine(" and CONVERT(date, ck.CheckinDate) = CONVERT(date, GETDATE()) ");

        SqlCommand sql = new SqlCommand(sb.ToString(), db);

        DataTable table = new DataTable();
        table.Load(sql.ExecuteReader());

        if (table.Rows.Count > 0)
        {
            PhNotCheckin.Visible = false;
            PhCheckin.Visible = true;
        }
        else
        {
            PhNotCheckin.Visible = true;
            PhCheckin.Visible = false;
        }
    }

    [WebMethod]
    public static string Checkin()
    {
        includefunction inc = new includefunction();

        string message = "Please contact IT!!";

        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        try
        {
            db.Open();

            string Email = inc.GetEmailByCookieOrSession();

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT * ");
            sb.AppendLine(" FROM HR_StaffCheckin as ck ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and ck.Email = '" + Email + "' ");
            sb.AppendLine(" and CONVERT(date, ck.CheckinDate) = CONVERT(date, GETDATE()) ");

            SqlCommand command = new SqlCommand(sb.ToString(), db);
            DataTable table = new DataTable();
            table.Load(command.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                message = "already checkin";
            }
            else
            {
                sb = new StringBuilder();
                sb.AppendLine(" INSERT INTO HR_StaffCheckin ");
                sb.AppendLine(" ( ");
                sb.AppendLine(" 	Email, ");
                sb.AppendLine(" 	CheckinDate ");
                sb.AppendLine(" ) ");
                sb.AppendLine(" VALUES ");
                sb.AppendLine(" ( ");
                sb.AppendLine(" 	@Email, ");
                sb.AppendLine(" 	GETDATE() ");
                sb.AppendLine(" ) ");

                SqlCommand sql = new SqlCommand(sb.ToString(), db);
                sql.Parameters.AddWithValue("Email", Email);

                sql.ExecuteNonQuery();

                sb = new StringBuilder();
                sb.AppendLine(" SELECT pc.Point ");
                sb.AppendLine(" FROM HR_PointCondition as pc ");
                sb.AppendLine(" WHERE 1=1 ");
                sb.AppendLine(" and pc.PA_ID = 1 ");
                sb.AppendLine(" and CONVERT(date, StartDate) < GETDATE() ");
                sb.AppendLine(" and (CONVERT(date, EndDate) > GETDATE() or EndDate is null) ");
                sb.AppendLine(" ORDER BY CreatedDate DESC ");

                sql = new SqlCommand(sb.ToString(), db);
                table = new DataTable();
                table.Load(sql.ExecuteReader());

                if (table.Rows.Count > 0)
                {
                    int point = table.Rows[0]["Point"].ToString() == "" ? 0 : Convert.ToInt32(table.Rows[0]["Point"]);

                    sb = new StringBuilder();
                    sb.AppendLine(" INSERT INTO HR_PointTrans ");
                    sb.AppendLine(" ( ");
                    sb.AppendLine(" 	Email, ");
                    sb.AppendLine(" 	TransActionDate, ");
                    sb.AppendLine(" 	TransActionValue, ");
                    sb.AppendLine(" 	TransDesc, ");
                    sb.AppendLine(" 	CalculateDate, ");
                    sb.AppendLine(" 	IsCalculate_Flag, ");
                    sb.AppendLine(" 	PointSummary ");
                    sb.AppendLine(" ) ");
                    sb.AppendLine(" VALUES ");
                    sb.AppendLine(" ( ");
                    sb.AppendLine(" 	@Email, ");
                    sb.AppendLine(" 	GETDATE(), ");
                    sb.AppendLine(" 	@TransActionValue, ");
                    sb.AppendLine(" 	@TransDesc, ");
                    sb.AppendLine(" 	GETDATE(), ");
                    sb.AppendLine(" 	1, ");
                    sb.AppendLine(" 	@PointSummary ");
                    sb.AppendLine(" ) ");

                    sql = new SqlCommand(sb.ToString(), db);
                    sql.Parameters.AddWithValue("Email", Email);
                    sql.Parameters.AddWithValue("TransActionValue", "");
                    sql.Parameters.AddWithValue("TransDesc", "Check-in");
                    sql.Parameters.AddWithValue("PointSummary", point);

                    sql.ExecuteNonQuery();

                    sb = new StringBuilder();
                    sb.AppendLine(" SELECT * ");
                    sb.AppendLine(" FROM Point_Balance as pb ");
                    sb.AppendLine(" WHERE 1=1 ");
                    sb.AppendLine(" and pb.Email = '" + Email + "' ");
                    sql = new SqlCommand(sb.ToString(), db);

                    sql = new SqlCommand(sb.ToString(), db);
                    table = new DataTable();
                    table.Load(sql.ExecuteReader());

                    if (table.Rows.Count > 0)
                    {
                        sb = new StringBuilder();
                        sb.AppendLine(" UPDATE Point_Balance ");
                        sb.AppendLine(" SET Point_Balance = ISNULL(Point_Balance, 0) + @Point_Balance ");
                        sb.AppendLine(" WHERE 1=1 ");
                        sb.AppendLine(" and Email = @Email ");

                        sql = new SqlCommand(sb.ToString(), db);
                        sql.Parameters.AddWithValue("Point_Balance", point);
                        sql.Parameters.AddWithValue("Email", Email);
                        sql.ExecuteNonQuery();
                    }
                    else
                    {
                        sb = new StringBuilder();
                        sb.AppendLine(" INSERT INTO Point_Balance ");
                        sb.AppendLine(" ( ");
                        sb.AppendLine(" 	Email, ");
                        sb.AppendLine(" 	Point_Balance, ");
                        sb.AppendLine(" 	UpdateDate ");
                        sb.AppendLine(" ) ");
                        sb.AppendLine(" VALUES ");
                        sb.AppendLine(" ( ");
                        sb.AppendLine(" 	@Email, ");
                        sb.AppendLine(" 	@Point_Balance, ");
                        sb.AppendLine(" 	GETDATE() ");
                        sb.AppendLine(" ) ");

                        sql = new SqlCommand(sb.ToString(), db);
                        sql.Parameters.AddWithValue("Point_Balance", point);
                        sql.Parameters.AddWithValue("Email", Email);

                        sql.ExecuteNonQuery();
                    }
                }

                message = "success";
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

        return message;
    }

    [WebMethod]
    public static string SendEMailHR(string Detail, string EmployeeID, string Username)
    {
        EmailPattern SendEmail = new EmailPattern();

        string message = "Please contact IT!!";

        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        try
        {
            db.Open();

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT Fname, ");
            sb.AppendLine(" Lname, ");
            sb.AppendLine(" Email, ");
            sb.AppendLine(" Department, ");
            sb.AppendLine(" Center, ");
            sb.AppendLine(" Position ");
            sb.AppendLine(" FROM CRM.dbo.vWSE_HR_EmployeeData as emp ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and emp.PersonCode = '" + EmployeeID + "' ");

            SqlCommand sql = new SqlCommand(sb.ToString(), db);
            DataTable table = new DataTable();

            table.Load(sql.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                StringBuilder BodyMessage = new StringBuilder();
                StreamReader myFile = new StreamReader(HttpContext.Current.Server.MapPath("../Template/htmlTemplate.html"));

                BodyMessage.Append(myFile.ReadToEnd());
                myFile.Close();

                string FName = table.Rows[0]["Fname"].ToString();
                string Lname = table.Rows[0]["Lname"].ToString();
                string Email = table.Rows[0]["Email"].ToString();
                string Department = table.Rows[0]["Department"].ToString();
                string Center = table.Rows[0]["Center"].ToString();
                string Position = table.Rows[0]["Position"].ToString();

                BodyMessage.Replace("{EmpID}", EmployeeID);
                BodyMessage.Replace("{FName}", FName);
                BodyMessage.Replace("{LName}", Lname);
                BodyMessage.Replace("{Email}", Email);
                BodyMessage.Replace("{Department}", Department);
                BodyMessage.Replace("{Center}", Center);
                BodyMessage.Replace("{Position}", Position);
                BodyMessage.Replace("{Detail}", Detail);
                BodyMessage.Replace("{Sender}", FName);

                string mailto = ConfigurationManager.AppSettings["email"].ToString();
                string mailCC = ConfigurationManager.AppSettings["ccemail"].ToString();

                if (mailCC.Equals(""))
                {
                    mailCC += Email;
                }
                else
                {
                    mailCC += "," + Email;
                }

                sb = new StringBuilder();
                sb.AppendLine(" INSERT INTO HR_RequestInformation ");
                sb.AppendLine(" ( ");
                sb.AppendLine(" 	EmpID, ");
                sb.AppendLine(" 	Username, ");
                sb.AppendLine(" 	Message, ");
                sb.AppendLine(" 	CreatedDate ");
                sb.AppendLine(" ) ");
                sb.AppendLine(" VALUES ");
                sb.AppendLine(" ( ");
                sb.AppendLine(" 	@EmpID, ");
                sb.AppendLine(" 	@Username, ");
                sb.AppendLine(" 	@Message, ");
                sb.AppendLine(" 	GETDATE() ");
                sb.AppendLine(" ) ");

                sql = new SqlCommand(sb.ToString(), db);
                sql.Parameters.AddWithValue("EmpID", EmployeeID);
                sql.Parameters.AddWithValue("Username", Username);
                sql.Parameters.AddWithValue("Message", Detail);

                sql.ExecuteNonQuery();

                EmailPattern.SendMail("Request change employee infornmation", mailto, mailCC, BodyMessage.ToString());

                message = "success";
            }
        }
        catch (Exception ex)
        {
            message = ex.Message + "<br/>" + ex.StackTrace;
        }
        finally
        {
            db.Close();
        }

        return message;
    }
}