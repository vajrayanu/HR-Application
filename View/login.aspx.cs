using System;
using System.Collections.Generic;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Web.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Text.RegularExpressions;
using System.Configuration;
using System.Text;
using System.Security.Cryptography;
using System.DirectoryServices;
using System.Collections;
using System.Threading;
using System.Linq;

public partial class login :  System.Web.UI.Page
{

    public string connString = "";
    bool isLoginSuccess = false;
    Boolean isUserSpecial = false;
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            if (Request.Cookies["UserSettings"] != null)
            {
                string _username = Request.Cookies["UserSettings"]["UserName"].ToString();
                string _password = Request.Cookies["UserSettings"]["Password"].ToString();
                ChkLoginFunction(_username, _password);
            }
        }
        else
        {
            clearSession();
        }
    }

    protected void BtnSubmit_Click(object sender, EventArgs e)
    {
        ChkLoginFunction("", "");
    }

    protected void ChkLoginFunction(string username, string password)
    {
        try
        {
            string _username = "";
            string _password = "";

            if (hdfstat.Value.ToString() == "checked")
            {
                Response.Cookies["UserSettings"].Expires = DateTime.Now.AddDays(30);
                Response.Cookies["UserSettings"].Expires = DateTime.Now.AddDays(30);
            }
            else
            {
                Response.Cookies["UserSettings"].Expires = DateTime.Now.AddDays(-1);
                Response.Cookies["UserSettings"].Expires = DateTime.Now.AddDays(-1);
            }

            if (username != string.Empty && password != string.Empty)
            {
                _username = username.ToString();
                _password = password.ToString();
            }
            else
            {
                _username = txtUsername.Value.ToString();
                _password = txtPassword.Value.ToString();

                Response.Cookies["UserSettings"]["UserName"] = _username.ToString().Trim();
                Response.Cookies["UserSettings"]["Password"] = _password.ToString().Trim();
            }

            string specialCharacters = @"%!#$%^&*()?/>.<,:;'\|}]{[~`+=-" + "\"";
            char[] specialCharactersArray = specialCharacters.ToCharArray();

            isLoginSuccess = LoginLDAP(_username, _password);

            if (isLoginSuccess == true)
            {
                Response.Redirect("Home", true);
            }
            else
            {
                Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "wrongUser()", true);

                //return;
            }
        }
        catch (Exception ex)
        {
            // Response.Write("<br>==ex ChkLoginFunction Err : " + ex.Message + " | StackTrace : " + ex.StackTrace);
        }
    }

    protected bool LoginLDAP(String username, String password)
    {
        try
        {
            //return true;
            String ldapPath = "LDAP://wsi-dc.wse.in.th:389/DC=wse,DC=in,DC=th";
            String domainAndUsername = "WSE" + @"\" + username;
            DirectoryEntry entry = new DirectoryEntry(ldapPath, domainAndUsername, password);
            Object obj = entry.NativeObject;
            DirectorySearcher search = new DirectorySearcher(entry);
            search.Filter = "(SAMAccountName=" + username + ")";
            search.PropertiesToLoad.Add("cn");
            search.PropertiesToLoad.Add("mail");
            search.PropertiesToLoad.Add("memberOf");
            SearchResult results = search.FindOne();

            if (null == results)
            {
                return isLoginSuccess;
            }
            else
            {
                ldapPath = results.Path;
                string _StaffName = string.Empty;
                string _StaffMail = string.Empty;
                string _StaffGroup = string.Empty;
                string _StaffGroupTarget = string.Empty;
                string[] _StaffGroupArray = { };
                List<string> StaffAllGroup = new List<string>();

                _StaffName = results.Properties["cn"][0].ToString();
                _StaffMail = (String)results.Properties["mail"][0];

                string stringToCheck = ConfigurationManager.AppSettings["Admin_User"].ToString().Trim();

                for (int i = 0; i < results.Properties["memberOf"].Count; i++)
                {
                    string memberOf = results.Properties["memberOf"][i].ToString();

                    string[] words = memberOf.Split(',');

                    if (_StaffGroupTarget != string.Empty)
                    {
                        break;
                    }
                    else
                    {
                        string result = words[0].Substring(3); //Select CN= ONLY
                        if (stringToCheck.Contains("," + result + ","))
                        {
                            _StaffGroupTarget = result.ToString();
                        }
                    }
                }

                if (_StaffGroupTarget == string.Empty)
                {
                    Page.ClientScript.RegisterStartupScript(this.GetType(), "CallMyFunction", "permissionOut()", true);
                }
                else
                {
                    List<string> UserProfile = new List<string>();

                    UserProfile.Add(_StaffName);
                    UserProfile.Add(_StaffMail);
                    UserProfile.Add(_StaffGroupTarget);
                    UserProfile.Add(username);

                    Session["UserInfo"] = UserProfile;

                    isLoginSuccess = true;
                    return isLoginSuccess;
                }
            }
        }
        catch (Exception ex)
        {
            //Response.Write(ex.Message + ex + " StackTrace : " + ex.StackTrace);
        }

        return isLoginSuccess;

    }

    protected void clearSession()
    {
        Session["UserInfo"] = null;
        Session.Clear();
    }
}