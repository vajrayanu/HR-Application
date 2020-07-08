using System;
using System.Collections.Generic;
using System.Text;
using System.Net.Mail;
using System.Net;
using System.Globalization;
using System.Configuration;
using System.IO;
using System.Collections;
using System.Web;
//using LogManager;

public class EmailPattern
{
    public static bool SendMail(string Subject, string reqMailTo, string reqMailCC, string MailBody)
    {
        try
        {
            string mail_to = "", mail_cc = "", mail_from = "", mail_subject = "", mail_body = "";
            if (reqMailTo != null && !reqMailTo.Equals(""))
            {
                mail_to = reqMailTo;
            }
            else
            {
                mail_to = "";
            }

            if (reqMailCC != null && !reqMailCC.Equals(""))
            {
                mail_cc = reqMailCC;
            }
            else
            {
                mail_cc = "";
            }

            //AppLog.Log("mail_to : " + mail_to);
            //AppLog.Log("mail_cc : " + mail_cc);

            mail_from = ConfigurationManager.AppSettings["mail_from"].ToString();

            mail_subject = Subject;
            mail_body = MailBody;

            if (!mail_to.Equals(""))
            {
                int sentMailStatus = DoSendEmail(mail_from, mail_cc, mail_to, mail_subject, mail_body);
                //AppLog.Log("do send mail : " + sentMailStatus);
            }
            return true;
        }
        catch (Exception ex)
        {
            return false;
        }
    }

    public static int DoSendEmail(string mail_from, string mail_cc, string mail_to, string mail_subject, string mail_body)
    {
        try
        {
            bool result = EmailSender.SendMail(mail_from, mail_cc, mail_to, mail_subject, mail_body, true);
            if (result)
            {
                return 1;
            }
            else
            {
                return 0;
            }
        }
        catch (System.Exception Err)
        {
            //AppLog.Log("EmailPattern: DoSendEmail:" + Err.StackTrace + "-->" + Err.Message);
            return -1;
        }
    }
}

public class EmailSender
{
    public static bool SendMail(string mail_from, string mail_cc, string mail_to, string mail_subject, string mail_body, bool isBodyHtml)
    {
        try
        {
            using (MailMessage mailMessage = new MailMessage())
            {
                string mailServer = ConfigurationManager.AppSettings["mailServer"].ToString();
                int mailServerPort = Convert.ToInt32(ConfigurationManager.AppSettings["mailServerPort"]);
                string mailUser = ConfigurationManager.AppSettings["mailUser"].ToString();
                string mailPassword = ConfigurationManager.AppSettings["mailPassword"].ToString();
                string mail_ssl = ConfigurationManager.AppSettings["mail_ssl"].ToString();
                //MailAddress addressBCC = new MailAddress("it.dev@wallstreetenglish.in.th , ssds@wallstreetenglish.in.th ");

                //string SentMailTo = SendTo + " jruriders@gmail.com ";

                mailMessage.From = new MailAddress(mail_from);

                //mailMessage.Bcc.Add(addressBCC);
                if (!mail_cc.Equals(""))
                {
                    mailMessage.CC.Add(mail_cc);
                }

                mailMessage.Subject = mail_subject;

                mailMessage.Body = mail_body;

                mailMessage.IsBodyHtml = true;

                //mailMessage.To.Add(new MailAddress(SendTo));
                mailMessage.To.Add(mail_to);


                SmtpClient mailClient = new SmtpClient(mailServer, mailServerPort);

                //mailClient.Host = ConfigurationManager.AppSettings["Host"];
                mailClient.Credentials = new NetworkCredential(mailUser, mailPassword);

                if (mail_ssl.ToLower().Equals("true"))
                {
                    mailClient.EnableSsl = true;
                }
                else
                {
                    mailClient.EnableSsl = false;
                }


                mailClient.Send(mailMessage);
                return true;
            }
        }
        catch (Exception ex)
        {
            //AppLog.Log("EmailSender:SendMail Err:" + ex.StackTrace + "-->" + ex.Message);
            return false;
        }
    }

}