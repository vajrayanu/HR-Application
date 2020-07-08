<%@ WebHandler Language="C#" Class="announcement" %>

using System;
using System.Web;
using System.IO;

public class announcement : IHttpHandler {

    public void ProcessRequest (HttpContext context) {
       var title = HttpContext.Current.Request.Params["title"];

        //Fetch the Uploaded File.
        HttpPostedFile postedFile = context.Request.Files[0];

        //Set the Folder Path.
        string currentYear = DateTime.Now.Year.ToString();
        string path = "~/assets/slide/" + currentYear + "/";
        string folderPath = context.Server.MapPath(path);
        //Set the File Name.
        string fileName = "0_" + title + "_" + Path.GetFileName(postedFile.FileName);
            //Set the File Name.

        bool folderExists = Directory.Exists(HttpContext.Current.Server.MapPath(path));
        if (!folderExists)
        {
            Directory.CreateDirectory(HttpContext.Current.Server.MapPath(path));
        }

        //Save the File in Folder.
        postedFile.SaveAs(folderPath + fileName);
    }

    public bool IsReusable {
        get {
            return false;
        }
    }

}