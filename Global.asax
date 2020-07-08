<%@ Application Language="C#" %>
<%@ Import Namespace="System.Web.Routing" %>

<script runat="server">

    void Application_Start(object sender, EventArgs e)
    {
        // Code that runs on application startup
        RegisterRoutes(RouteTable.Routes);
    }

    public static void RegisterRoutes(RouteCollection routes)
    {

        routes.MapPageRoute(
                "Login",
                "Login",
                "~/View/login.aspx"
            );

        routes.MapPageRoute(
                "Home",
                "Home",
                "~/View/Home.aspx"
            );

        routes.MapPageRoute(
                "RequestTimeOff",
                "RequestTimeOff",
                "~/View/requestTimeOff.aspx"
            );

         routes.MapPageRoute(
                "CompanyDirectory",
                "CompanyDirectory",
                "~/View/companyDirectory.aspx"
            );

        routes.MapPageRoute(
            "CompanyDirectory/Announcement",
            "CompanyDirectory/Announcement",
            "~/View/announcement.aspx"
            );

        routes.MapPageRoute(
                "Point",
                "Point",
                "~/View/point.aspx"
            );

         routes.MapPageRoute(
                "Benefits",
                "Benefits",
                "~/View/Benefits.aspx"
            );

        routes.MapPageRoute(
                "Goals",
                "Goals",
                "~/View/Goals.aspx"
            );

         routes.MapPageRoute(
                "Training",
                "Training",
                "~/View/calendar.aspx"
            );

        routes.MapPageRoute(
                "Training/Video",
                "Training/Video",
                "~/View/TrainingVideo.aspx"
            );

        routes.MapPageRoute(
                "Training/Video/More",
                "Training/Video/More",
                "~/View/MoreTrainingVideo.aspx"
            );

        
         routes.MapPageRoute(
                "Logout",
                "Logout",
                "~/View/logout.aspx"
            );

         routes.MapPageRoute(
                "HRForm",
                "HRForm",
                "~/View/hrForm.aspx"
            );

        routes.MapPageRoute(
                "CMS",
                "CMS",
                "~/CMSView/home.aspx"
            );

        routes.MapPageRoute(
                "CMS/Training",
                "CMS/Training",
                "~/CMSView/Training.aspx"
            );

        routes.MapPageRoute(
                "CMS/Calendar",
                "CMS/Calendar",
                "~/CMSView/calendar.aspx"
            );

        routes.MapPageRoute(
                "CMS/Video",
                "CMS/Video",
                "~/CMSView/FileUpload.aspx"
        );

        routes.MapPageRoute(
                "CMS/Users",
                "CMS/Users",
                "~/CMSView/users.aspx"
            );

        routes.MapPageRoute(
                "CMS/CompanyDirectory",
                "CMS/CompanyDirectory",
                "~/CMSView/companyDirectory.aspx"
            );

        routes.MapPageRoute(
                "CMS/TargetEC",
                "CMS/TargetEC",
                "~/CMSView/target_ec.aspx"
            );

        routes.MapPageRoute(
                "CMS/Point",
                "CMS/Point",
                "~/CMSView/Main_Point.aspx"
            );
        routes.MapPageRoute(
                "CMS/hrForm",
                "CMS/hrForm",
                "~/CMSView/hrForm.aspx"
            );

        routes.MapPageRoute(
                "CMS/Reward",
                "CMS/Reward",
                "~/CMSView/reward.aspx"
            );

        routes.MapPageRoute(
                "CMS/PointActivity",
                "CMS/PointActivity",
                "~/CMSView/point_activity.aspx"
            );

        routes.MapPageRoute(
                "CMS/PointCondition",
                "CMS/PointCondition",
                "~/CMSView/point_condition.aspx"
            );

        routes.MapPageRoute(
                "PointDetail",
                "PointDetail/{rwid}",
                "~/View/pointdetail.aspx"
            );

        routes.MapPageRoute(
                "RedeemHistory",
                "RedeemHistory",
                "~/View/RedeemHistory.aspx"
            );

        routes.MapPageRoute(
                "CMS/Redeem",
                "CMS/Redeem",
                "~/CMSView/redeem.aspx"
            );
    }

    void Application_End(object sender, EventArgs e)
    {
        //  Code that runs on application shutdown

    }

    void Application_Error(object sender, EventArgs e)
    {
        // Code that runs when an unhandled error occurs

    }

    void Session_Start(object sender, EventArgs e)
    {
        // Code that runs when a new session is started

    }

    void Session_End(object sender, EventArgs e)
    {
        // Code that runs when a session ends. 
        // Note: The Session_End event is raised only when the sessionstate mode
        // is set to InProc in the Web.config file. If session mode is set to StateServer 
        // or SQLServer, the event is not raised.

    }

</script>
