using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Security.Cryptography;
using System.Text;
using System.Web;
using System.Collections;

/// <summary>
/// Summary description for Class1
/// </summary>
public class includefunction
{
    public DataTable Getcenter(SqlConnection db)
    {
        StringBuilder sb = new StringBuilder();
        sb.AppendLine(" SELECT wsec_name,  ");
        sb.AppendLine(" wsec_llmscenterid, ");
        sb.AppendLine(" wsec_avaya, ");
        sb.AppendLine(" wsec_TerritoryID, ");
        sb.AppendLine(" WSEC_CenterID ");
        sb.AppendLine(" FROM [wsi-cluster].CRM.dbo.WSECenter as ce ");
        sb.AppendLine(" WHERE 1=1  ");
        sb.AppendLine(" and ce.wsec_disable = 'enable' ");

        SqlCommand sqlcenter = new SqlCommand(sb.ToString(), db);

        DataTable tablecenter = new DataTable();
        tablecenter.Load(sqlcenter.ExecuteReader());

        return tablecenter;
    }

    public DataTable GetTimeSlot(SqlConnection db, string timetype)
    {
        StringBuilder sb = new StringBuilder();
        sb.AppendLine(" SELECT ts.Time_slot, ");
        sb.AppendLine(" ts.slotId ");
        sb.AppendLine(" FROM Time_slot as ts ");
        sb.AppendLine(" WHERE 1=1 ");

        if (timetype.Equals("start"))
        {
            sb.AppendLine(" and Time_slot between '09' and '19' ");
        }
        else
        {
            sb.AppendLine(" and Time_slot between '11' and '20' ");
        }

        SqlCommand sql = new SqlCommand(sb.ToString(), db);

        DataTable table = new DataTable();
        table.Load(sql.ExecuteReader());

        return table;
    }

    public bool CheckTeacherNxt(string SelectCenterID, string SelectTime, string ClassTime, string ClassCenter)
    {
        bool result = false;

        if (SelectCenterID.Equals(ClassCenter))
        {
            DateTime SelectTime_ = Convert.ToDateTime("2020-01-27 " + SelectTime).AddHours(1);
            DateTime ClassTime_ = Convert.ToDateTime("2020-01-27 " + ClassTime);

            if (SelectTime_ <= ClassTime_)
            {
                result = true;
            }
        }
        else
        {
            DateTime SelectTime_ = Convert.ToDateTime("2020-01-27 " + SelectTime).AddHours(2);
            DateTime ClassTime_ = Convert.ToDateTime("2020-01-27 " + ClassTime);

            if (SelectTime_ <= ClassTime_)
            {
                result = true;
            }
        }

        return result;
    }

    public bool CheckTeacherPrv(string SelectCenterID, string SelectTime, string ClassTime, string ClassCenter)
    {
        bool result = false;

        if (SelectCenterID.Equals(ClassCenter))
        {
            DateTime SelectTime_ = Convert.ToDateTime("2020-01-27 " + SelectTime);
            DateTime ClassTime_ = Convert.ToDateTime("2020-01-27 " + ClassTime).AddHours(1);

            if (SelectTime_ >= ClassTime_)
            {
                result = true;
            }
        }
        else
        {
            DateTime SelectTime_ = Convert.ToDateTime("2020-01-27 " + SelectTime);
            DateTime ClassTime_ = Convert.ToDateTime("2020-01-27 " + ClassTime).AddHours(2);

            if (SelectTime_ >= ClassTime_)
            {
                result = true;
            }
        }

        return result;
    }

    public string EncryptData(string KeyPassword, string Data)
    {
        string original, password;
        TripleDESCryptoServiceProvider des;
        MD5CryptoServiceProvider hashmd5;
        byte[] pwdhash, buff;

        password = KeyPassword;
        original = Data;
        hashmd5 = new MD5CryptoServiceProvider();
        pwdhash = hashmd5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(password));
        hashmd5 = null;
        des = new TripleDESCryptoServiceProvider();
        des.Key = pwdhash;
        des.Mode = CipherMode.ECB;

        buff = ASCIIEncoding.ASCII.GetBytes(original);
        return Convert.ToBase64String(des.CreateEncryptor().TransformFinalBlock(buff, 0, buff.Length));
    }

    public string DecryptData(string strKeyPassword, string Data)
    {
        try
        {
            if (Data.Trim().Length > 0)
            {
                string original, password;
                TripleDESCryptoServiceProvider des;
                MD5CryptoServiceProvider hashmd5;
                byte[] pwdhash, buff;

                password = strKeyPassword;

                original = Data;
                original = original.Replace(" ", "+");

                int mod4 = original.Length % 4;
                if (mod4 > 0)
                {
                    original += new string('=', 4 - mod4);
                }

                hashmd5 = new MD5CryptoServiceProvider();
                pwdhash = hashmd5.ComputeHash(ASCIIEncoding.ASCII.GetBytes(password));
                hashmd5 = null;

                des = new TripleDESCryptoServiceProvider();
                des.Key = pwdhash;
                des.Mode = CipherMode.ECB;
                //----- decrypt an encrypted string ------------
                //whenever you decrypt a string, you must do everything you
                //did to encrypt the string, but in reverse order. To encrypt,
                //first a normal string was des3 encrypted into a byte array
                //and then base64 encoded for reliable transmission. So, to 
                //decrypt this string, first the base64 encoded string must be 
                //decoded so that just the encrypted byte array remains.
                buff = Convert.FromBase64String(original);

                //decrypt DES 3 encrypted byte buffer and return ASCII string
                return ASCIIEncoding.ASCII.GetString(des.CreateDecryptor().TransformFinalBlock(buff, 0, buff.Length));
            }
            else
            {
                return "";
            }
        }
        catch (Exception decryption)
        {
            return "";
        }
    }

    public string GetEmailByCookieOrSession()
    {
        HttpContext context = HttpContext.Current;

        string Email = "";
        try
        {
            List<string> _Userinfo = new List<string>();
            _Userinfo = (List<string>)context.Session["Userinfo"];

            if (context.Session["Userinfo"] != null)
            {
                Email = _Userinfo[1].ToString();
            }
            else
            {
            }
        }
        catch (Exception ex)
        {
        }

        return Email;
    }
}