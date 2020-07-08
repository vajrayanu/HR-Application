using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Benefits : System.Web.UI.Page
{
    public string trate = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!this.IsPostBack)
        {
            getDropdownList();
            DataTable dt = new DataTable();
            dt.Columns.Add("Start");
            dt.Columns.Add("End");
            dt.Columns.Add("Rate");
            ViewState["dt"] = dt;
            BindGrid();
        }
    }

    protected void getDropdownList()
    {
        string connString = ConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(connString);
        SqlDataReader rdr = null;

        try
        {
            db.Open();
            SqlCommand command = new SqlCommand("select TV_CenterNoFrom, Center_Name, Center_FullName from vWSE_TravelingRate group by TV_CenterNoFrom, Center_Name, Center_FullName", db);
            command.CommandType = CommandType.Text;
            rdr = command.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(rdr);

            DDLstart.DataSource = dt;
            DDLstart.DataTextField = dt.Columns["Center_fullName"].ToString();
            DDLstart.DataValueField = dt.Columns["TV_CenterNoFrom"].ToString();
            DDLstart.DataBind();
            DDLstart.Items.Insert(0, new ListItem("-- Select Start --", " "));

            DDLDest.DataSource = dt;
            DDLDest.DataTextField = dt.Columns["Center_fullName"].ToString();
            DDLDest.DataValueField = dt.Columns["TV_CenterNoFrom"].ToString();
            DDLDest.DataBind();
            DDLDest.Items.Insert(0, new ListItem("-- Select Destination --", " "));
        }
        catch (Exception ex)
        {
            Response.Write("<br>==ex Err : " + ex.Message + " | StackTrace : " + ex.StackTrace);
        }
    }

    protected void BindGrid()
    {
        GridView1.DataSource = ViewState["dt"] as DataTable;
        GridView1.DataBind();
    }

    protected void btnInsert_Click(object sender, EventArgs e)
    {
        DataTable dt = ViewState["dt"] as DataTable;
        ViewState["dt"] = dt;
        var start = DDLstart.SelectedValue.ToString();
        var end = DDLDest.SelectedValue.ToString();
        if (start == end)
        {
            trate = "0";
        }else if(start == " " || end == " ")
        {
            trate = "0";
        }
        else
        {
            trate = getTravelingRate(start, end);
        }
        //var trate = getTravelingRate(start, end);
        dt.Rows.Add(DDLstart.SelectedItem.ToString(), DDLDest.SelectedItem.ToString(), trate);
        BindGrid();
        int sum = 0;
        foreach (DataRow dr in dt.Rows)
        {
            sum = sum + Convert.ToInt32(dr["Rate"]);
        }
        total.Text = sum.ToString();
        DDLstart.Text = " ";
        DDLDest.Text = " ";
    }

    protected void OnDelete(object sender, EventArgs e)
    {
        GridViewRow row = (sender as LinkButton).NamingContainer as GridViewRow;
        DataTable dt = ViewState["dt"] as DataTable;
        dt.Rows.RemoveAt(row.RowIndex);
        ViewState["dt"] = dt;
        BindGrid();
        int sum = 0;
        foreach (DataRow dr in dt.Rows)
        {
            sum = sum - Convert.ToInt32(dr["Rate"]);
        }
        total.Text = Math.Abs(sum).ToString();
    }

    protected static string getTravelingRate(string start, string end)
    {
        string connString = ConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(connString);
        SqlDataReader rdr = null;

        db.Open();
        SqlCommand command = new SqlCommand("select TV_AMT from vWSE_TravelingRate where TV_CenterNoFrom =" + start + "and TV_CenterNoTo=" + end, db);
        command.CommandType = CommandType.Text;
        rdr = command.ExecuteReader();
        DataTable dt = new DataTable();
        dt.Load(rdr);
        var rate = dt.Rows[0]["TV_AMT"].ToString();
        return rate;
    }
}