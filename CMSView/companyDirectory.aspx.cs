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
using System.IO;

public partial class CMSView_companyDirectory : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);


        try
        {
            db.Open();

            StringBuilder sb = new StringBuilder();
            SqlCommand sql = new SqlCommand(sb.ToString(), db);
            DataTable table = new DataTable();

            if (!Page.IsPostBack)
            {
                sb = new StringBuilder();
                sb.AppendLine(" SELECT AN_AnnouncementTypeID, ");
                sb.AppendLine(" AN_TypeName ");
                sb.AppendLine(" FROM HR_AnnouncementType ");
                sb.AppendLine(" WHERE 1=1 ");
                sb.AppendLine(" and AN_Deleted is null ");

                sql = new SqlCommand(sb.ToString(), db);

                table = new DataTable();
                table.Load(sql.ExecuteReader());

                if (table.Rows.Count > 0)
                {
                    ddlType.DataSource = table;
                    DdlType_.DataSource = table;
                }

                ddlType.DataBind();
                DdlType_.DataBind();
                DdlType_.Items.Insert(0, new ListItem("ALL", ""));

                sb = new StringBuilder();
                sb.AppendLine(" SELECT GP_ID, ");
                sb.AppendLine(" GP_DisplayName ");
                sb.AppendLine(" FROM HR_Group ");
                sb.AppendLine(" WHERE 1=1 ");
                sb.AppendLine(" and GP_Deleted is null ");

                sql = new SqlCommand(sb.ToString(), db);

                table = new DataTable();
                table.Load(sql.ExecuteReader());

                if (table.Rows.Count > 0)
                {
                    ddlGroup.DataSource = table;
                    DdlGroup_.DataSource = table;
                }

                ddlGroup.DataBind();
                DdlGroup_.DataBind();

                ddlGroup.Items.Insert(0, new ListItem("ALL", "0"));
                DdlGroup_.Items.Insert(0, new ListItem("ALL", "0"));
            }
            else
            {
                string Action = HdnAction.Value;
                string AnID = HdnAnID.Value;

                if (Action.Equals("confirm"))
                {
                    string DIR_ID = AnID;
                    string Type = ddlType.SelectedValue;
                    string Group = ddlGroup.SelectedValue;
                    string Title = txtTitle.Text;

                    string Detail = "";
                    if (Type.Equals("1"))
                    {
                        Detail = editorDetailEN.Value.ToString();
                    }
                    else
                    {
                        Detail = txtDetail.Text;
                    }

                    string StartDate = txtStartDate.Text;

                    string[] startdateSplit = StartDate.Split('/');

                    StartDate = startdateSplit[2].ToString() + "-" + startdateSplit[1] + "-" + startdateSplit[0].ToString();

                    string EndDate = txtEndDate.Text;

                    if (!EndDate.Equals(""))
                    {
                        string[] enddateSplit = EndDate.Split('/');

                        EndDate = enddateSplit[2].ToString() + "-" + enddateSplit[1] + "-" + enddateSplit[0].ToString();
                    }

                    bool check = gridCheck.Checked;
                    string OrderBy = TxtOrderBy.Text;

                    if (OrderBy.Equals(""))
                    {
                        OrderBy = "999";
                    }

                    string Status = DdlStatus.Text;

                    if (DIR_ID.Equals(""))
                    {
                        sb = new StringBuilder();
                        sb.AppendLine(" INSERT INTO HR_Announcement ");
                        sb.AppendLine(" ( ");
                        sb.AppendLine(" 	DIR_Type, ");
                        sb.AppendLine(" 	DIR_Group, ");
                        sb.AppendLine(" 	DIR_Title, ");
                        sb.AppendLine(" 	DIR_Detail, ");
                        sb.AppendLine(" 	DIR_StartDate, ");
                        sb.AppendLine(" 	DIR_EndDate, ");
                        sb.AppendLine(" 	DIR_SlideOrder, ");
                        sb.AppendLine(" 	DIR_Status, ");
                        sb.AppendLine(" 	DIR_Highlight ");
                        sb.AppendLine(" ) ");
                        sb.AppendLine(" VALUES ");
                        sb.AppendLine(" ( ");
                        sb.AppendLine(" 	@DIR_Type, ");
                        sb.AppendLine(" 	@DIR_Group, ");
                        sb.AppendLine(" 	@DIR_Title, ");
                        sb.AppendLine(" 	@DIR_Detail, ");
                        sb.AppendLine(" 	@DIR_StartDate, ");
                        sb.AppendLine(" 	@DIR_EndDate, ");
                        sb.AppendLine(" 	@DIR_SlideOrder, ");
                        sb.AppendLine(" 	@DIR_Status, ");
                        sb.AppendLine(" 	@DIR_Highlight ");
                        sb.AppendLine(" ) ");
                        sb.AppendLine("  ");
                        sb.AppendLine(" SELECT SCOPE_IDENTITY() ");

                        sql = new SqlCommand(sb.ToString(), db);
                        sql.Parameters.AddWithValue("DIR_Type", Type);
                        sql.Parameters.AddWithValue("DIR_Group", Group);
                        sql.Parameters.AddWithValue("DIR_Title", Title);
                        sql.Parameters.AddWithValue("DIR_Detail", Detail);
                        sql.Parameters.AddWithValue("DIR_StartDate", StartDate);

                        if (EndDate.Equals(""))
                        {
                            sql.Parameters.AddWithValue("DIR_EndDate", DBNull.Value);
                        }
                        else
                        {
                            sql.Parameters.AddWithValue("DIR_EndDate", EndDate);
                        }

                        sql.Parameters.AddWithValue("DIR_SlideOrder", OrderBy);
                        sql.Parameters.AddWithValue("DIR_Status", Status);
                        sql.Parameters.AddWithValue("DIR_Highlight", check);

                        DIR_ID = sql.ExecuteScalar().ToString();
                    }
                    else
                    {
                        sb = new StringBuilder();
                        sb.AppendLine(" UPDATE HR_Announcement ");
                        sb.AppendLine(" SET DIR_Type = @DIR_Type ");
                        sb.AppendLine(" , DIR_Group = @DIR_Group ");
                        sb.AppendLine(" , DIR_Title = @DIR_Title ");
                        sb.AppendLine(" , DIR_Detail = @DIR_Detail ");
                        sb.AppendLine(" , DIR_StartDate = @DIR_StartDate ");
                        sb.AppendLine(" , DIR_EndDate = @DIR_EndDate ");
                        sb.AppendLine(" , DIR_SlideOrder = @DIR_SlideOrder ");
                        sb.AppendLine(" , DIR_Status = @DIR_Status ");
                        sb.AppendLine(" , DIR_Highlight = @DIR_Highlight ");
                        sb.AppendLine(" WHERE 1=1 ");
                        sb.AppendLine(" and DIR_ID = @DIR_ID ");

                        sql = new SqlCommand(sb.ToString(), db);
                        sql.Parameters.AddWithValue("DIR_Type", Type);
                        sql.Parameters.AddWithValue("DIR_Group", Group);
                        sql.Parameters.AddWithValue("DIR_Title", Title);
                        sql.Parameters.AddWithValue("DIR_Detail", Detail);
                        sql.Parameters.AddWithValue("DIR_StartDate", StartDate);

                        if (EndDate.Equals(""))
                        {
                            sql.Parameters.AddWithValue("DIR_EndDate", DBNull.Value);
                        }
                        else
                        {
                            sql.Parameters.AddWithValue("DIR_EndDate", EndDate);
                        }

                        sql.Parameters.AddWithValue("DIR_SlideOrder", OrderBy);
                        sql.Parameters.AddWithValue("DIR_Status", Status);
                        sql.Parameters.AddWithValue("DIR_Highlight", check);
                        sql.Parameters.AddWithValue("DIR_ID", DIR_ID);

                        sql.ExecuteNonQuery();
                    }

                    if (Type.Equals("3") || Type.Equals("4") || Type.Equals("1"))
                    {
                        if (postedFile.HasFile)
                        {
                            string PathDocument = Server.MapPath("~/") + "images/Announcement/" + DIR_ID + "/document/";
                            if (!Directory.Exists(PathDocument))
                            {
                                Directory.CreateDirectory(PathDocument);
                            }

                            string filename = Path.GetFileName(postedFile.FileName);
                            postedFile.SaveAs(PathDocument + filename);

                            sb = new StringBuilder();
                            sb.AppendLine(" UPDATE HR_Announcement ");
                            sb.AppendLine(" SET DIR_UploadDoc = '" + filename + "' ");
                            sb.AppendLine(" WHERE 1=1 ");
                            sb.AppendLine(" and DIR_ID = '" + DIR_ID + "' ");

                            sql = new SqlCommand(sb.ToString(), db);
                            sql.ExecuteNonQuery();
                        }
                    }

                    if (Type.Equals("1") || Type.Equals("2"))
                    {
                        if (postedImageFile.HasFile)
                        {
                            string PathImage = Server.MapPath("~/") + "images/Announcement/" + DIR_ID + "/images/";
                            if (!Directory.Exists(PathImage))
                            {
                                Directory.CreateDirectory(PathImage);
                            }

                            string filename = Path.GetFileName(postedImageFile.FileName);
                            postedImageFile.SaveAs(PathImage + filename);

                            sb = new StringBuilder();
                            sb.AppendLine(" UPDATE HR_Announcement ");
                            sb.AppendLine(" SET DIR_UploadImage = '" + filename + "' ");
                            sb.AppendLine(" WHERE 1=1 ");
                            sb.AppendLine(" and DIR_ID = '" + DIR_ID + "' ");

                            sql = new SqlCommand(sb.ToString(), db);
                            sql.ExecuteNonQuery();
                        }
                    }

                    ScriptManager.RegisterStartupScript(this, this.GetType(), "submit", "sweetsuccess();", true);
                }
            }

            string page = HdnPage.Value;
            int Maxperpage = 20;

            int paging = page == "" ? 1 : Convert.ToInt32(page);
            int startrow = (Maxperpage * (paging - 1)) + 1;
            int endrow = (Maxperpage * paging);

            string Status_ = DdlStatus_.SelectedValue;
            string Type_ = DdlType_.SelectedValue;
            string Group_ = DdlGroup_.SelectedValue;

            sb = new StringBuilder();
            sb.AppendLine(" SELECT DIR_Title, ");
            sb.AppendLine(" DIR_ID, ");
            sb.AppendLine(" DIR_StartDate, ");
            sb.AppendLine(" DIR_EndDate, ");
            sb.AppendLine(" DIR_UploadDoc, ");
            sb.AppendLine(" DIR_UploadImage, ");
            sb.AppendLine(" case when DIR_Status = 1 then 'Active' else 'In-Active' end as [Status], ");
            sb.AppendLine(" AN_TypeName, ");
            sb.AppendLine(" case when an.DIR_Group = 0 or an.DIR_Group is null then 'ALL' else GP_DisplayName end as GP_DisplayName, ");
            sb.AppendLine(" DIR_Highlight, ");
            sb.AppendLine(" DIR_SlideOrder, ");
            sb.AppendLine(" ROW_NUMBER() OVER(ORDER BY isnull(DIR_StartDate, 0) DESC) AS row ");
            sb.AppendLine(" FROM HR_Announcement as an ");
            sb.AppendLine(" LEFT JOIN HR_AnnouncementType as at on an.DIR_Type = AN_AnnouncementTypeID ");
            sb.AppendLine(" LEFT JOIN HR_Group as gr on an.DIR_Group = gr.GP_ID ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and an.DIR_Deleted is null ");

            if (!Status_.Equals(""))
            {
                sb.AppendLine(" and DIR_Status = '" + Status_ + "' ");
            }

            if (!Type_.Equals(""))
            {
                sb.AppendLine(" and an.DIR_Type = '" + Type_ + "' ");
            }

            if (!Group_.Equals("0"))
            {
                sb.AppendLine(" and an.DIR_Group = '" + Group_ + "' ");
            }

            sb.AppendLine(" ORDER BY DIR_ID DESC ");

            //Response.Write(sb.ToString());

            sql = new SqlCommand(sb.ToString(), db);

            table = new DataTable();
            table.Load(sql.ExecuteReader());

            double p = Math.Ceiling(Convert.ToDouble(table.Rows.Count) / Convert.ToDouble(Maxperpage));

            string showpage = "";

            #region
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
            #endregion

            DataView Dvtable = table.DefaultView;

            if (table.Rows.Count > 0)
            {
                Dvtable.RowFilter = "row >= " + startrow + " and row <= " + endrow;
            }

            table = Dvtable.ToTable();

            if (table.Rows.Count > 0)
            {
                RptAnnouncement.DataSource = table;
            }

            RptAnnouncement.DataBind();
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

    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
    }

    [WebMethod]
    public static string Deleted(string anid)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        string message = "false";
        try
        {
            db.Open();

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" UPDATE HR_Announcement ");
            sb.AppendLine(" SET DIR_Deleted = 1 ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and DIR_ID = " + anid + " ");

            SqlCommand sql = new SqlCommand(sb.ToString(), db);
            sql.ExecuteNonQuery();

            message = "success";
        }
        catch (Exception ex)
        {
            message = "Please contact IT !!!!!!!!";
        }
        finally
        {
            db.Close();
        }

        return message;
    }

    [WebMethod]
    public static string getAnnouncement(string anid)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        string message = "";
        string Type = "";
        string Group = "";
        string Title = "";
        string Detail = "";
        string StartDate = "";
        string EndDate = "";
        string Document = "";
        string Images = "";
        string OrderBy = "";
        string Status = "";
        string Hilight = "";

        try
        {
            db.Open();

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" SELECT DIR_Title, ");
            sb.AppendLine(" DIR_ID, ");
            sb.AppendLine(" DIR_StartDate, ");
            sb.AppendLine(" DIR_Detail, ");
            sb.AppendLine(" DIR_EndDate, ");
            sb.AppendLine(" DIR_UploadDoc, ");
            sb.AppendLine(" DIR_UploadImage, ");
            sb.AppendLine(" case when DIR_Status = 1 then '1' else '0' end as [Status], ");
            sb.AppendLine(" DIR_Type, ");
            sb.AppendLine(" DIR_Group, ");
            sb.AppendLine(" case when DIR_Highlight = 1 then '1' else '0' end as [Highlight], ");
            sb.AppendLine(" DIR_SlideOrder ");
            sb.AppendLine(" FROM HR_Announcement as an ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and an.DIR_Deleted is null ");
            sb.AppendLine(" and an.DIR_ID = '" + anid + "' ");

            SqlCommand sql = new SqlCommand(sb.ToString(), db);

            DataTable table = new DataTable();
            table.Load(sql.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                Type = table.Rows[0]["DIR_Type"].ToString();
                Group = table.Rows[0]["DIR_Group"].ToString();
                Title = table.Rows[0]["DIR_Title"].ToString();
                Detail = table.Rows[0]["DIR_Detail"].ToString();
                StartDate = Convert.ToDateTime(table.Rows[0]["DIR_StartDate"]).ToString("dd/MM/yyyy", new System.Globalization.CultureInfo("en-US"));

                EndDate = table.Rows[0]["DIR_StartDate"].ToString() != "" ? "" : Convert.ToDateTime(table.Rows[0]["DIR_EndDate"]).ToString("dd/MM/yyyy", new System.Globalization.CultureInfo("en-US"));
                Document = table.Rows[0]["DIR_UploadDoc"].ToString();
                Images = table.Rows[0]["DIR_UploadImage"].ToString();
                OrderBy = table.Rows[0]["DIR_SlideOrder"].ToString();
                Status = table.Rows[0]["Status"].ToString();
                Hilight = table.Rows[0]["Highlight"].ToString();
            }

            message = "success";
        }
        catch (Exception ex)
        {
            message = "Please contact IT!!";
            //message = ex.Message + "_" + ex.StackTrace;
        }
        finally
        {
            db.Close();
        }

        var objResponse = new { message = message, Type = Type, Group = Group, Title = Title, Detail = Detail, StartDate = StartDate, EndDate = EndDate, Document = Document, Images = Images, OrderBy = OrderBy, Status = Status, Hilight = Hilight };
        return JsonConvert.SerializeObject(objResponse);
    }
}