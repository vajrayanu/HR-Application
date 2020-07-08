using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.Configuration;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CMSView_FileUpload : System.Web.UI.Page
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
                    string ShrtName = _Userinfo[3].ToString();

                    HdnStaffName.Value = ShrtName;
                }
            }

            string page = HdnPage.Value;

            int paging = page == "" ? 1 : Convert.ToInt32(page);
            int startrow = (20 * (paging - 1)) + 1;
            int endrow = (20 * paging);

            string status = DdlStatus.SelectedValue;

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT [File_ID] ");
            sb.AppendLine(" ,[File_Type_ID] ");
            sb.AppendLine(" ,[File_Name] ");
            sb.AppendLine(" ,[File_Dept] ");
            sb.AppendLine(" ,[File_Title] ");
            sb.AppendLine(" ,[File_CreatedBy]  ");
            sb.AppendLine(" ,[File_UpdatedBy]  ");
            sb.AppendLine(" ,[File_CreatedDate] ");
            sb.AppendLine(" ,[File_UpdatedDate] ");
            sb.AppendLine(" ,[File_Highlight] ");
            sb.AppendLine(" ,[File_Status] ");
            sb.AppendLine(" ,[File_Deleted] ");
            sb.AppendLine(" ,ROW_NUMBER() OVER(ORDER BY isnull(File_CreatedDate, 0) DESC) AS row ");
            sb.AppendLine(" FROM [WSE_HR].[dbo].[HR_Training_FileUpload] ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and File_Deleted = 0 ");

            if (status.Equals("1"))
            {
                sb.AppendLine(" and [File_Status] = '1' ");
            }
            else if (status.Equals("0"))
            {
                sb.AppendLine(" and [File_Status] = '0' ");
            }
            else if (status.Equals("H"))
            {
                sb.AppendLine(" and [File_Highlight] = '1' ");
            }

            SqlCommand sql = new SqlCommand(sb.ToString(), db);

            DataTable table = new DataTable();
            DataColumn col = new DataColumn("File_Type", typeof(string));
            DataColumn col1 = new DataColumn("File_Status_ID", typeof(string));
            DataColumn col2 = new DataColumn("File_Highlight_ID", typeof(string));
            table.Columns.Add(col);
            table.Columns.Add(col1);
            table.Columns.Add(col2);
            table.Load(sql.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                foreach (DataRow row in table.Rows)
                {
                    var type = row[4].ToString();
                    var fhilight = row[12].ToString();
                    var fstatus = row[13].ToString();
                    if (type == "2")
                    {
                        row["File_type"] = "IFrame";
                    }
                    else if (type == "1")
                    {
                        row["File_type"] = "File";
                    }

                    if (fstatus == "1")
                    {
                        row["File_Status_ID"] = "Active";
                    }
                    else if (fstatus == "0")
                    {
                        row["File_Status_ID"] = "Inactive";
                    }

                    if (fhilight == "True")
                    {
                        row["File_Highlight_ID"] = "Yes";
                    }
                    else if (fstatus == "False")
                    {
                        row["File_Highlight_ID"] = "No";
                    }
                }
            }

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
                RptVdo.DataSource = table;
            }

            RptVdo.DataBind();
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

    protected void btnup1(object sender, EventArgs e)
    {
        string connString = ConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(connString);
        db.Open();
        string shrtname = HdnStaffName.Value;
        int x = int.Parse(cnt.Value);
        int y = int.Parse(mcnt.Value);
        int scnt = x - y;
        try
        {
            for (int i = 0; i <= scnt; i++)
            {
                string titleName = Request.Form["txtFile" + i];
                string deptName = Request.Form["ddl" + i];
                string iframe = Request.Unvalidated["txtarea" + i];
                string hilight = Request.Form["checkbox" + i];
                if (titleName == null)
                {
                    for (int j = i; j < 100; j++)
                    {
                        titleName = Request.Form["txtFile" + j];
                        deptName = Request.Form["ddl" + j];
                        iframe = Request.Unvalidated["txtarea" + j];
                        hilight = Request.Form["checkbox" + j];
                        if (titleName != null)
                        {
                            string query1 = " INSERT INTO [dbo].[HR_Training_FileUpload] ([File_Type_ID] ,[File_Name] ,[File_Dept] ,[File_Title] ,[File_CreatedBy] ,[File_UpdatedBy] ,[File_CreatedDate] ,[File_UpdatedDate], [File_Highlight], [File_Status], [File_Deleted]) VALUES ('" + 2 + "','" + iframe + "','" + deptName + "','" + titleName + "','" + shrtname + "','" + shrtname + "','" + DateTime.Now + "','" + DateTime.Now + "','" + hilight + "','" + '1' + "' ,'" + '0' + "')";
                            SqlCommand cmd1 = new SqlCommand(query1, db);
                            cmd1.ExecuteNonQuery();
                            i = j;
                            if (i < scnt)
                            {
                                break;
                            }
                        }
                    }
                }
                else if (titleName != null)
                {
                    string query = " INSERT INTO [dbo].[HR_Training_FileUpload] ([File_Type_ID] ,[File_Name] ,[File_Dept] ,[File_Title] ,[File_CreatedBy] ,[File_UpdatedBy] ,[File_CreatedDate] ,[File_UpdatedDate], [File_Highlight], [File_Status], [File_Deleted]) VALUES ('" + 2 + "','" + iframe + "','" + deptName + "','" + titleName + "','" + shrtname + "','" + shrtname + "','" + DateTime.Now + "','" + DateTime.Now + "', '" + hilight + "','" + '1' + "' ,'" + '0' + "')";
                    SqlCommand cmd = new SqlCommand(query, db);
                    cmd.ExecuteNonQuery();
                }
            }
            Response.Write("<script>alert('successful');</script>");
            Response.Redirect("Video");
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('" + ex.Message + "');</script>");
        }

    }

    protected void btnup(object sender, EventArgs e)
    {
        string connString = ConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(connString);
        db.Open();
        string shrtname = HdnStaffName.Value;
        string path = "~/images/test/";
        try
        {
            for (int i = 0; i < Request.Files.Count; i++)
            {
                string deptName = Request.Form["txtFile" + i];
                HttpPostedFile PostedFile = Request.Files[i];
                string fileName = PostedFile.FileName;
                string query = " INSERT INTO [dbo].[HR_Training_FileUpload] ([File_Type_ID] ,[File_Name] ,[File_Dept] ,[File_Title] ,[File_CreatedBy] ,[File_UpdatedBy] ,[File_CreatedDate] ,[File_UpdatedDate], [File_Status], [File_Deleted]) VALUES ('" + 1 + "','" + fileName + "','" + deptName + "','','" + shrtname + "','" + shrtname + "','" + DateTime.Now + "','" + DateTime.Now + "','" + '1' + "' ,'" + '0' + "')";

                SqlCommand cmd = new SqlCommand(query, db);
                cmd.ExecuteNonQuery();
                if (PostedFile.ContentLength > 0)
                {
                    string FileName = System.IO.Path.GetFileName(PostedFile.FileName);
                    PostedFile.SaveAs(Server.MapPath(path + FileName));
                }
            }
            Response.Write("<script>alert('successful');</script>");
            Response.Redirect("Video");
        }
        catch (Exception ex)
        {
            Response.Write("<script>alert('" + ex.Message + "');</script>");
        }

    }

    [WebMethod]
    public static string Onsubmit(string FileID, string FileName, string FileTitle, string User, string FileDepartment, string FileHighlight, string FileStatus)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        string message = "Please contact IT!!";
        string msg;

        string DatetimeNow = DateTime.Now.ToString("yyyy-MM-dd HH:mm", new System.Globalization.CultureInfo("en-US"));

        try
        {
            db.Open();
            string query = " UPDATE [dbo].[HR_Training_FileUpload] SET [File_Name] = '" + FileName + "', [File_Dept] = '" + FileDepartment + "', [File_Title] = '" + FileTitle + "', [File_UpdatedBy] = '" + User + "', [File_UpdatedDate]='" + DateTime.Now + "', [File_Highlight] = '" + FileHighlight + "', [File_Status]='" + FileStatus + "' WHERE [File_ID] = '" + FileID + "'";
            SqlCommand cmd = new SqlCommand(query, db);
            cmd.ExecuteNonQuery();

        }
        catch (Exception ex)
        {
            message = "Please contact IT!!";
        }
        finally
        {
            db.Close();
        }
        return msg = "true";
    }

    [WebMethod]
    public static string OnDelete(string FileID, string User)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        string message = "Please contact IT!!";
        string msg;

        string DatetimeNow = DateTime.Now.ToString("yyyy-MM-dd HH:mm", new System.Globalization.CultureInfo("en-US"));

        try
        {
            db.Open();
            string query = " UPDATE [dbo].[HR_Training_FileUpload] SET [File_Deleted] = '1', [File_UpdatedBy] = '" + User + "', [File_UpdatedDate]='" + DateTime.Now + "' WHERE [File_ID] = '" + FileID + "'";
            SqlCommand cmd = new SqlCommand(query, db);
            cmd.ExecuteNonQuery();

        }
        catch (Exception ex)
        {
            message = "Please contact IT!!";
        }
        finally
        {
            db.Close();
        }
        return msg = "true";
    }
}