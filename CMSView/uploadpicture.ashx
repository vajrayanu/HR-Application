<%@ WebHandler Language="C#" Class="uploadpicture" %>

using System;
using System.Web;
using System.IO;
using System.Web.Configuration;
using System.Data.SqlClient;
using System.Text;

public class uploadpicture : IHttpHandler {

    public void ProcessRequest(HttpContext context)
    {
        string SrtConnString = WebConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(SrtConnString);

        try
        {
            db.Open();

            var rwid = HttpContext.Current.Request.Params["rwid"];

            //Fetch the Uploaded File.
            HttpPostedFile postedFile = context.Request.Files[0];

            //Set the Folder Path.
            string folderPath = context.Server.MapPath("~/images/Reward/");

            //Set the File Name.
            string fileName = rwid + "_" + Path.GetFileName(postedFile.FileName);

            //Save the File in Folder.
            postedFile.SaveAs(folderPath + fileName);

            //Send File details in a JSON Response.

            StringBuilder sb = new StringBuilder();
            sb.AppendLine(" UPDATE HR_Rewards ");
            sb.AppendLine(" SET ");
            sb.AppendLine(" RewardPicture = @RewardPicture ");
            sb.AppendLine(" WHERE 1=1 ");
            sb.AppendLine(" and RW_ID = @rwid ");

            SqlCommand sql = new SqlCommand(sb.ToString(), db);
            sql.Parameters.AddWithValue("rwid", rwid);
            sql.Parameters.AddWithValue("RewardPicture", fileName);

            sql.ExecuteNonQuery();

            HttpContext.Current.Response.Write("success_" + fileName);
        }
        catch (Exception ex)
        {
            HttpContext.Current.Response.Write(ex.Message + "<br/>" + ex.StackTrace);
        }
        finally
        {
            db.Close();
        }
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}