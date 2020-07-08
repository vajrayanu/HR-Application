using Newtonsoft.Json.Linq;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading;
using System.Threading.Tasks;
using System.Web.Configuration;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using Newtonsoft.Json;
using Microsoft.Exchange.WebServices.Data;

public partial class calendar : System.Web.UI.Page
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
                    string StaffName = _Userinfo[0].ToString();
                    string Email = _Userinfo[1].ToString();

                    HdnStaffName.Value = StaffName;
                    HdnEmail.Value = Email;
                }
                else
                {
                    Response.Redirect(ResolveClientUrl("~"));
                }

                ScriptManager.RegisterStartupScript(this.Page, this.GetType(), "createcalendar", "createcalendar(1);", true);
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
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static object LoadCalendar(string from, string to)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        List<d_calendar> list_ca = new List<d_calendar>();
        d_calendar ca = new d_calendar();

        try
        {
            db.Open();

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT cr.UniqueID, ");
            sb.AppendLine(" cr.StartDate, ");
            sb.AppendLine(" cr.EndDate, ");
            sb.AppendLine(" cr.Creator, ");
            sb.AppendLine(" cr.Subject, ");
            sb.AppendLine(" cr.Name, ");
            sb.AppendLine(" cr.CID, ");
            sb.AppendLine(" cr.HR_Calendar ");
            sb.AppendLine(" FROM Calendar_Room as cr ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and cr.Deleted is null ");
            sb.AppendLine(" and cr.HR_Calendar = 1 ");
            sb.AppendLine(" and CONVERT(date, StartDate) between @Start and @end ");

            SqlCommand sql = new SqlCommand(sb.ToString(), db);
            sql.Parameters.AddWithValue("Start", from);
            sql.Parameters.AddWithValue("End", to);

            DataTable table = new DataTable();
            table.Load(sql.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                for (int i = 0; i < table.Rows.Count; i++)
                {
                    string UniqueID = table.Rows[i]["UniqueID"].ToString();
                    string CID = table.Rows[i]["CID"].ToString();
                    string StartDate = table.Rows[i]["StartDate"].ToString();
                    string EndDate = table.Rows[i]["EndDate"].ToString();
                    string Creator = table.Rows[i]["Creator"].ToString();
                    string Subject = table.Rows[i]["Subject"].ToString();
                    string Name = table.Rows[i]["Name"].ToString();

                    ca = new d_calendar();
                    ca.id = UniqueID;
                    ca.start = Convert.ToDateTime(StartDate).ToString("yyyy-MM-dd HH:mm", new System.Globalization.CultureInfo("en-US"));
                    ca.end = Convert.ToDateTime(EndDate).ToString("yyyy-MM-dd HH:mm", new System.Globalization.CultureInfo("en-US"));
                    ca.timestart = Convert.ToDateTime(StartDate).ToString("HH:mm", new System.Globalization.CultureInfo("en-US"));
                    ca.timeend = Convert.ToDateTime(EndDate).ToString("HH:mm tt", new System.Globalization.CultureInfo("en-US"));
                    ca.title = Subject;
                    ca.creator = Creator;
                    ca.HRCalendar = table.Rows[i]["HR_Calendar"].ToString();

                    string bgcolor = "";
                    switch (Name)
                    {
                        case "Creation":
                            bgcolor = "#dcf1de";
                            break;
                        case "Inspiration":
                            bgcolor = "#ddf3fe";
                            break;
                        case "Motivation":
                            bgcolor = "#fde5d3";
                            break;
                        case "Imagination":
                            bgcolor = "#fbf4cf";
                            break;
                    }

                    ca.backgroundColor = bgcolor;
                    ca.border_color = bgcolor;
                    ca.Room = Name;
                    ca.cid = CID;

                    list_ca.Add(ca);
                }
            }
        }
        catch (Exception ex)
        {
            ca = new d_calendar();
            ca.title = ex.Message + "_" + ex.StackTrace;
            list_ca.Add(ca);
        }
        finally
        {
            db.Close();
        }

        return list_ca;
    }

    [WebMethod]
    public static string GetData(string ID, string EmailStaff)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        calendar_detail e = new calendar_detail();

        try
        {
            db.Open();

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT cr.CID, ");
            sb.AppendLine(" cr.UniqueID, ");
            sb.AppendLine(" cr.StartDate, ");
            sb.AppendLine(" cr.EndDate, ");
            sb.AppendLine(" cr.Subject, ");
            sb.AppendLine(" cr.Creator, ");
            sb.AppendLine(" cr.Name, ");
            sb.AppendLine(" cr.HR_Calendar ");
            sb.AppendLine(" FROM Calendar_Room as cr ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and cr.CID = '" + ID + "' ");
			sb.AppendLine(" and cr.Deleted is null ");

            SqlCommand sql = new SqlCommand(sb.ToString(), db);

            DataTable table = new DataTable();
            table.Load(sql.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                string StartDate = table.Rows[0]["StartDate"].ToString();
                string EndDate = table.Rows[0]["EndDate"].ToString();
                string CID = table.Rows[0]["CID"].ToString();
                string UniqueID = table.Rows[0]["UniqueID"].ToString();
                string HR_Calendar = table.Rows[0]["HR_Calendar"].ToString();

                DateTime Select_StartDate = Convert.ToDateTime(StartDate);

                e = new calendar_detail();
                e.id = UniqueID;
                e.cid = CID;
                e.start = Convert.ToDateTime(StartDate).ToString("yyyy-MM-dd HH:mm", new System.Globalization.CultureInfo("en-US"));
                e.end = Convert.ToDateTime(EndDate).ToString("yyyy-MM-dd HH:mm", new System.Globalization.CultureInfo("en-US"));
                e.timestart = Convert.ToDateTime(StartDate).ToString("HH:mm", new System.Globalization.CultureInfo("en-US"));
                e.timeend = Convert.ToDateTime(EndDate).ToString("HH:mm tt", new System.Globalization.CultureInfo("en-US"));
                e.title = table.Rows[0]["Subject"].ToString();
                e.creator = table.Rows[0]["Creator"].ToString();
                e.Room = table.Rows[0]["Name"].ToString();
                e.HRCalendar = table.Rows[0]["HR_Calendar"].ToString();

                sb = new StringBuilder();
                sb.AppendLine(" SELECT ca.CAID, ");
                sb.AppendLine(" ca.Email, ");
                sb.AppendLine(" ca.Name, ");
                sb.AppendLine(" ca.BookingDate ");
                sb.AppendLine(" FROM Calendar_Attendee as ca ");
                sb.AppendLine(" WHERE 1=1 ");
                sb.AppendLine(" and ca.CID = '" + CID + "' ");
                sb.AppendLine(" and ca.Deleted is null ");

                sql = new SqlCommand(sb.ToString(), db);

                table = new DataTable();
                table.Load(sql.ExecuteReader());

                string List = "";
                if (table.Rows.Count > 0)
                {
                    for (int i = 0; i < table.Rows.Count; i++)
                    {
                        string CAID = table.Rows[i]["CAID"].ToString();
                        string EmailAttendee = table.Rows[i]["Email"].ToString();
                        string NameAttendee = table.Rows[i]["Name"].ToString();
                        string BookingDate = Convert.ToDateTime(table.Rows[i]["BookingDate"]).ToString("yyyy-MM-dd HH:mm", new System.Globalization.CultureInfo("en-US"));

                        if (EmailAttendee.Equals(EmailStaff))
                        {
                            e.attendee = "1";
                            break;
                        }
                        else
                        {
                            e.attendee = "0";
                        }
                    }
                }
                else
                {
                    e.attendee = "0";
                }
            }
        }
        catch (Exception ex)
        {
            e = new calendar_detail();
            e.title = ex.Message + "_" + ex.StackTrace;
        }
        finally
        {
            db.Close();
        }

        return JsonConvert.SerializeObject(e);
    }

    [WebMethod]
    public static string Register(string Email, string CID)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        string message = "";

        try
        {
            db.Open();

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT cr.UniqueID, ");
            sb.AppendLine(" cr.Name, ");
            sb.AppendLine(" ca.Email, ");
            sb.AppendLine(" ca.UID, ");
            sb.AppendLine(" ca.Name ");
            sb.AppendLine(" FROM Calendar_Room as cr ");
            sb.AppendLine(" LEFT JOIN Calendar_Attendee as ca on cr.CID = ca.CID ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and cr.CID = '" + CID + "' ");
			sb.AppendLine(" and cr.Deleted is null ");
			sb.AppendLine(" and ca.Deleted is null ");

            SqlCommand sql = new SqlCommand(sb.ToString(), db);

            DataTable table = new DataTable();
            table.Load(sql.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                string UniqueID = table.Rows[0]["UniqueID"].ToString();
                string UID = table.Rows[0]["UID"].ToString();
                string RoomName = table.Rows[0]["Name"].ToString();

                string UserEmail = "";
                string Location = "";
                string RoomEmail = "";
                switch (RoomName)
                {
                    case "Creation":
                        UserEmail = "Creation";
                        Location = "Creation (30 Persons)";
                        RoomEmail = "Creation@wallstreetenglish.in.th";
                        break;
                    case "Inspiration":
                        UserEmail = "Inspiration";
                        Location = "Inspiration (5 Persons)";
                        RoomEmail = "Inspiration@wallstreetenglish.in.th";
                        break;
                    case "Motivation":
                        UserEmail = "Motivation";
                        Location = "Motivation (10 Persons)";
                        RoomEmail = "Motivation@wallstreetenglish.in.th";
                        break;
                    case "Imagination":
                        UserEmail = "Imagination";
                        Location = "Imagination (5 Persons)";
                        RoomEmail = "Imagination@wallstreetenglish.in.th";
                        break;
                }

                ExchangeService service = new ExchangeService();
                service.Credentials = new WebCredentials(UserEmail, "");
                //service.TraceEnabled = true;
                //service.TraceFlags = TraceFlags.All;
                service.AutodiscoverUrl(RoomEmail);

                Appointment appointment = Appointment.Bind(service, new ItemId(UniqueID), new PropertySet(AppointmentSchema.Subject, AppointmentSchema.Start, AppointmentSchema.End));

                for (int i = 0; i < table.Rows.Count; i++)
                {
                    string EmailAttendee = table.Rows[i]["Email"].ToString();
                    // Set properties on the appointment.
                    if (!EmailAttendee.Equals(""))
                    {
                        appointment.RequiredAttendees.Add(EmailAttendee);
                        //appointment.RequiredAttendees.Add("wattana.c@wallstreetenglish.in.th");
                    }
                }

                DataView Dvtable = table.DefaultView;
                Dvtable.RowFilter = "Email = '" + Email + "'";

                DataTable table_result = new DataTable();
                table_result = Dvtable.ToTable();

                if (table_result.Rows.Count > 0)
                {

                }
                else
                {
                    appointment.RequiredAttendees.Add(Email);
                }

                sb = new StringBuilder();
                sb.AppendLine(" SELECT em.Fname, ");
                sb.AppendLine(" em.Lname ");
                sb.AppendLine(" FROM CRM.dbo.vWSE_HR_EmployeeData as em ");
                sb.AppendLine(" WHERE 1=1 ");
                sb.AppendLine(" and em.Email = '" + Email + "' ");
                sql = new SqlCommand(sb.ToString(), db);

                table = new DataTable();
                table.Load(sql.ExecuteReader());

                string EmpName = "";
                if (table.Rows.Count > 0)
                {
                    EmpName = table.Rows[0]["Fname"].ToString() + " " + table.Rows[0]["Lname"].ToString();
                }

                sb = new StringBuilder();
                sb.AppendLine(" INSERT INTO Calendar_Attendee ");
                sb.AppendLine(" ( ");
                sb.AppendLine(" 	UniqueID, ");
                sb.AppendLine(" 	Email, ");
                sb.AppendLine(" 	Name, ");
                sb.AppendLine(" 	CID, ");
                sb.AppendLine(" 	UID, ");
                sb.AppendLine(" 	BookingDate ");
                sb.AppendLine(" ) ");
                sb.AppendLine(" VALUES ");
                sb.AppendLine(" ( ");
                sb.AppendLine(" 	@UniqueID, ");
                sb.AppendLine(" 	@Email, ");
                sb.AppendLine(" 	@Name, ");
                sb.AppendLine(" 	@CID, ");
                sb.AppendLine(" 	@UID, ");
                sb.AppendLine(" 	GETDATE() ");
                sb.AppendLine(" ) ");

                sql = new SqlCommand(sb.ToString(), db);
                sql.Parameters.AddWithValue("UniqueID", UniqueID);
                sql.Parameters.AddWithValue("Email", Email);
                sql.Parameters.AddWithValue("Name", EmpName);
                sql.Parameters.AddWithValue("CID", CID);
                sql.Parameters.AddWithValue("UID", UID);

                sql.ExecuteNonQuery();

                // Save the appointment.
                //appointment.Save(folderToAccess, SendInvitationsMode.SendToNone);
                appointment.Update(ConflictResolutionMode.AlwaysOverwrite, SendInvitationsOrCancellationsMode.SendOnlyToChanged);
            }

            message = "true";
        }
        catch (Exception ex)
        {
            message = "Please Contact IT Team.";
        }
        finally
        {
            db.Close();
        }

        return message;
    }

    [WebMethod]
    public static string Cancel(string Email, string CID)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        string message = "";

        try
        {
            db.Open();

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT cr.UniqueID, ");
            sb.AppendLine(" cr.Name, ");
            sb.AppendLine(" ca.Email, ");
            sb.AppendLine(" ca.UID, ");
            sb.AppendLine(" ca.Name ");
            sb.AppendLine(" FROM Calendar_Room as cr ");
            sb.AppendLine(" LEFT JOIN Calendar_Attendee as ca on cr.CID = ca.CID ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and cr.CID = '" + CID + "' ");
			sb.AppendLine(" and cr.Deleted is null ");
			sb.AppendLine(" and ca.Deleted is null ");

            SqlCommand sql = new SqlCommand(sb.ToString(), db);

            DataTable table = new DataTable();
            table.Load(sql.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                string UniqueID = table.Rows[0]["UniqueID"].ToString();
                string UID = table.Rows[0]["UID"].ToString();
                string RoomName = table.Rows[0]["Name"].ToString();

                string UserEmail = "";
                string Location = "";
                string RoomEmail = "";
                switch (RoomName)
                {
                    case "Creation":
                        UserEmail = "Creation";
                        Location = "Creation (30 Persons)";
                        RoomEmail = "Creation@wallstreetenglish.in.th";
                        break;
                    case "Inspiration":
                        UserEmail = "Inspiration";
                        Location = "Inspiration (5 Persons)";
                        RoomEmail = "Inspiration@wallstreetenglish.in.th";
                        break;
                    case "Motivation":
                        UserEmail = "Motivation";
                        Location = "Motivation (10 Persons)";
                        RoomEmail = "Motivation@wallstreetenglish.in.th";
                        break;
                    case "Imagination":
                        UserEmail = "Imagination";
                        Location = "Imagination (5 Persons)";
                        RoomEmail = "Imagination@wallstreetenglish.in.th";
                        break;
                }

                ExchangeService service = new ExchangeService();
                service.Credentials = new WebCredentials(UserEmail, "");
                //service.TraceEnabled = true;
                //service.TraceFlags = TraceFlags.All;
                service.AutodiscoverUrl(RoomEmail);

                Appointment appointment = Appointment.Bind(service, new ItemId(UniqueID));

                for (int i = 0; i < appointment.RequiredAttendees.Count; i++)
                {
                    if ((appointment.RequiredAttendees[i].Address).ToUpper() == (Email).ToUpper())
                    {
                        appointment.RequiredAttendees.RemoveAt(i);
                        break;
                    }
                }

                appointment.Update(ConflictResolutionMode.AlwaysOverwrite, SendInvitationsOrCancellationsMode.SendOnlyToChanged);

                sb = new StringBuilder();
                sb.AppendLine(" SELECT ca.CAID ");
                sb.AppendLine(" FROM Calendar_Attendee as ca ");
                sb.AppendLine(" WHERE 1=1 ");
				sb.AppendLine(" and ca.Deleted is null ");
                sb.AppendLine(" and ca.CID = '" + CID + "' ");
                sb.AppendLine(" and ca.Email = '" + Email + "' ");

                sql = new SqlCommand(sb.ToString(), db);

                table = new DataTable();
                table.Load(sql.ExecuteReader());

                string CAID = "";
                if (table.Rows.Count > 0)
                {
                    CAID = table.Rows[0]["CAID"].ToString();
                }

                sb = new StringBuilder();
                sb.AppendLine(" UPDATE Calendar_Attendee ");
                sb.AppendLine(" SET CancelDate = GETDATE(), ");
                sb.AppendLine(" Deleted = 1 ");
                sb.AppendLine(" WHERE 1=1 ");
                sb.AppendLine(" and CAID = '" + CAID + "' ");

                sql = new SqlCommand(sb.ToString(), db);

                sql.ExecuteNonQuery();

                message = "true";
            }
            else
            {
                message = "Please Contact IT Team.";
            }
        }
        catch (Exception ex)
        {
            message = "Please Contact IT Team.";
        }
        finally
        {
            db.Close();
        }

        return message;
    }

    public class d_calendar
    {
        public string id;
        public string cid;
        public string start;
        public string end;
        public string timestart;
        public string timeend;
        public string title;
        public string backgroundColor;
        public string border_color;
        public string creator;
        public string Room;
        public string HRCalendar;
    }

    public class calendar_detail
    {
        public string id;
        public string cid;
        public string start;
        public string end;
        public string timestart;
        public string timeend;
        public string title;
        public string creator;
        public string Room;
        public string attendee;
        public string HRCalendar;
    }
}