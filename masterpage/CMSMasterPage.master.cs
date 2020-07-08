using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Drawing;
using System.IO;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class masterpage_CMSMasterPage : System.Web.UI.MasterPage
{
    public string connString = "";
    public string userid = "";

    protected void Page_Load(object sender, EventArgs e)
    {
        connString = ConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(connString);
        db.Open();

        List<string> _Userinfo = new List<string>();
        _Userinfo = (List<string>)Session["Userinfo"];

        if (Session["Userinfo"] != null)
        {
            lblUserName.Text = _Userinfo[0].ToString();
            lblUserNameSM.Text = _Userinfo[0].ToString();
            userid = _Userinfo[1].ToString();

            getImageProfile(userid, db);
        }
        else
        {
            Response.Redirect(ResolveClientUrl("~"));
        }
    }

    protected void getImageProfile(string emailID, SqlConnection db)
    {
        SqlDataReader rdr = null;

        try
        {
            SqlCommand command = new SqlCommand("select * from WSE_HR.dbo.vWSE_EmployeeLeave where Email =" + "'" + emailID + "'", db);
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
                            ImagePro.ImageUrl = ResolveClientUrl("~/~/images/iconperson.png");
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
                                ImagePro.ImageUrl = "data:image/png;base64," + Convert.ToBase64String(byteImage);
                            }
                        }
                    }
                    catch
                    {
                        ImagePro.ImageUrl = ResolveClientUrl("~/~/images/iconperson.png");
                    }
                }
            }
        }
        catch (Exception ex)
        {
            Response.Write("<br>==ex Err : " + ex.Message + " | StackTrace : " + ex.StackTrace);
        }
    }
}
