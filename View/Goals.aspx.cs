using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Goals : System.Web.UI.Page
{
    public string UserID = "";
    protected void Page_Load(object sender, EventArgs e)
    {
        var ddl = ddlBranch.SelectedValue;
        var ddlecuser = ddlKPI.SelectedValue;
        List<string> _Userinfo = new List<string>();
        _Userinfo = (List<string>)Session["Userinfo"];

        if (Session["Userinfo"] != null)
        {
            UserID = _Userinfo[1].ToString();
        }
        if (!Page.IsPostBack)
        {
            getddlBranch();
            getddlUser();
        }
        getData(ddl);
        getBig4(ddlecuser);
    }

    protected void getddlBranch()
    {
        string connString = ConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(connString);
        SqlDataReader rdr = null;

        try
        {
            db.Open();
            SqlCommand command = new SqlCommand("SELECT [wsec_name] ,[wsec_TerritoryID] FROM[CRM].[dbo].[WSECenter]   where 1=1 and WSEC_Deleted is null and wsec_disable = 'enable' ORDER BY [CRM].[dbo].[WSECenter].[wsec_name]", db);
            command.CommandType = CommandType.Text;
            rdr = command.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(rdr);

            ddlBranch.DataSource = dt;
            ddlBranch.DataTextField = dt.Columns["wsec_name"].ToString();
            ddlBranch.DataValueField = dt.Columns["wsec_TerritoryID"].ToString();
            ddlBranch.DataBind();
            ddlBranch.Items.Insert(0, new ListItem("-- Select --", " "));

        }
        catch (Exception ex)
        {
            Response.Write("<br>==ex Err : " + ex.Message + " | StackTrace : " + ex.StackTrace);
        }
    }

    protected void getddlUser()
    {
        string connString = ConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
        SqlConnection db = new SqlConnection(connString);
        SqlDataReader rdr = null;

        try
        {
            db.Open();
            SqlCommand command = new SqlCommand("select User_UserId, User_FirstName , User_Logon , user_employeeID from CRM.dbo.Users as us where 1 = 1 and us.User_FirstName is not null and us.User_UserId not in (2422, 2420, 1459, 2458, 550, 30, 2876) and us.User_TerritoryProfile = 11 and us.User_Deleted is null and us.User_Disabled is null", db);
            command.CommandType = CommandType.Text;
            rdr = command.ExecuteReader();
            DataTable dt = new DataTable();
            dt.Load(rdr);

            ddlKPI.DataSource = dt;
            ddlKPI.DataTextField = dt.Columns["User_FirstName"].ToString();
            ddlKPI.DataValueField = dt.Columns["user_employeeID"].ToString();
            ddlKPI.DataBind();
            ddlKPI.Items.Insert(0, new ListItem("-- Select --", " "));

        }
        catch (Exception ex)
        {
            Response.Write("<br>==ex Err : " + ex.Message + " | StackTrace : " + ex.StackTrace);
        }
    }

    protected void getData(string ddl)
    {
        try
        {

            string connString = ConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
            SqlConnection db = new SqlConnection(connString);
            //SqlDataReader rdr = null;

            StringBuilder query = new StringBuilder();

            query.AppendLine("declare @StartDate date , @EndDate date	, @Center int	, @m int , @y int");
            query.AppendLine("set @y = YEAR(getdate())");
            query.AppendLine("set @m = MONTH(getdate())");
            query.AppendLine("set @startDate = DATEADD(mm, DATEDIFF(mm, 0, GETDATE()), 0)");
            query.AppendLine("set @EndDate =  DATEADD (dd, -1, DATEADD(mm, DATEDIFF(mm, 0, GETDATE()) + 1, 0))");
            query.AppendLine("select");
            query.AppendLine("case when fpu.Orde_Secterr IS null then ce.wsec_TerritoryID else fpu.Orde_Secterr end as WSEC_TerritoryID");
            query.AppendLine(", case when fpu.wsec_centerorder IS null then ce.wsec_centerorder else fpu.wsec_centerorder end as wsec_centerorder");
            query.AppendLine(", case when fpu.wsec_name IS null then ce.centername else fpu.wsec_name end as centername");
            query.AppendLine(", case when fpu.user_userid IS null then ce.ec else fpu.user_userid end as ec");
            query.AppendLine(", case when fpu.User_FirstName IS null then ce.User_FirstName else fpu.User_FirstName end as ECName");
            query.AppendLine(", user_employeeID");
            query.AppendLine(", isnull(ta.TargetAmount,0) as ECTarget");
            query.AppendLine(", isnull(FPAMT,0) + isnull(ADIAMT,0) + isnull(DEPAMT,0) + isnull(INSAMT,0) as TOTALAMT");
            query.AppendLine(", isnull(((isnull(FPAMT,0) + isnull(ADIAMT,0) + isnull(DEPAMT,0) + isnull(INSAMT,0)) * 100.0)/nullif(ta.TargetAmount,0),0) as PercentTarget");
            query.AppendLine("from");
            query.AppendLine("(");
            query.AppendLine("select Orde_Secterr");
            query.AppendLine(", wsec_centerorder");
            query.AppendLine(", wsec_name");
            query.AppendLine(", user_userid");
            query.AppendLine(", User_FirstName");
            query.AppendLine(", isnull(sum(FPAMT),0) as FPAMT");
            query.AppendLine(", isnull(sum(FPQTY),0) as FPQTY");
            query.AppendLine(", isnull(sum(ADIAMT),0) as ADIAMT");
            query.AppendLine(", isnull(sum(ADIQTY),0) as ADIQTY");
            query.AppendLine(", isnull(sum(DEPQTY),0) as DEPQTY");
            query.AppendLine(", isnull(sum(DEPAMT),0) as DEPAMT");
            query.AppendLine(", isnull(sum(INSQTY),0) as INSQTY");
            query.AppendLine(", isnull(sum(INSAMT),0) as INSAMT");
            query.AppendLine("from");
            query.AppendLine("(");
            //Regular
            query.AppendLine("SELECT Orde_Secterr");
            query.AppendLine(", wsec_centerorder");
            query.AppendLine(", wsec_name");
            query.AppendLine(", user_userid");
            query.AppendLine(", User_FirstName");
            query.AppendLine(", isnull(sum(ReceiptNetAmount), 0) as FPAMT");
            query.AppendLine(", isnull(count(*), 0) as FPQTY");
            query.AppendLine(", SUM(case when orde_type = 'Retail' and uom_month <= 3 and Product_Name not like '%VIP%' then 1 else 0 end) * 0.5 as FPShortUNIT");
            query.AppendLine(", 0 as FPNEWUNIT");
            query.AppendLine(", 0 as FPRENUNIT");
            query.AppendLine(", 0 as FPRENUNITUp");
            query.AppendLine(", sum(Case when orde_type = 'RetailRenewal' and orde_renewaltype = 'rewup' then 1 else 0 end ) as FPRENUNITUpc");
            query.AppendLine(", sum(Case when orde_type = 'Retail' and Product_Name like '%VIP%' then 1 else 0 end) * 1.5 as FPVIPNEWUNIT");
            query.AppendLine(", sum(Case when orde_type = 'RetailRenewal'  and orde_renewaltype = 'rrew' and Product_Name like '%VIP%' then 1 else 0 end) * 1.0 as FPVIPRENUNIT");
            query.AppendLine(", 0 as ADIAMT , 0 as ADIUNIT , 0 as ADIQTY");
            query.AppendLine(", 0 as DEPQTY , 0 DEPUNIT , 0 as DEPAMT , 0 as INSQTY , 0 as INSAMT");
            query.AppendLine("FROM CRM.dbo.vWSE_ContractDetails_Shorter as fp with(nolock) left join");
            query.AppendLine("CRM.dbo.WSECenter as ce with(nolock) on ce.wsec_TerritoryID = fp.Orde_Secterr");
            query.AppendLine("WHERE 1 = 1 and convert(date, MaxDate) between @StartDate and @EndDate");
            query.AppendLine("and orde_status = 'Completed' and orde_type in ('Retail', 'RetailRenewal')");
            query.AppendLine("AND orde_wseloanapproved IS NULL");
            query.AppendLine("GROUP BY Orde_Secterr");
            query.AppendLine(", wsec_centerorder");
            query.AppendLine(", wsec_name");
            query.AppendLine(", user_userid");
            query.AppendLine(", User_FirstName");
            query.AppendLine("UNION ALL");
            //Additional
            query.AppendLine("SELECT Orde_Secterr");
            query.AppendLine(", wsec_centerorder");
            query.AppendLine(", wsec_name");
            query.AppendLine(", user_userid");
            query.AppendLine(", User_FirstName");
            query.AppendLine(", 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0 , 0");
            query.AppendLine(", isnull(SUM(ReceiptNetAmount),0) AS ADIAMT");
            query.AppendLine(", 0");
            query.AppendLine(", isnull(count(*),0) as ADIQTY");
            query.AppendLine(", 0 , 0 , 0 , 0 , 0");
            query.AppendLine("FROM CRM.dbo.vWSE_ContractDetails_Shorter  with (nolock) left join");
            query.AppendLine("CRM.dbo.WSECenter as ce with (nolock) on ce.wsec_TerritoryID = Orde_Secterr");
            query.AppendLine("WHERE 1=1");
            query.AppendLine("and orde_wseloanapproved is null");
            query.AppendLine("and prod_productfamilyid in (18,42,44,16,39,29,55 )");
            query.AppendLine("and orde_status = 'Completed' and orde_type = 'Additional'");
            query.AppendLine("and convert(date,MaxDate) between @StartDate and @EndDate");
            query.AppendLine("GROUP BY Orde_Secterr");
            query.AppendLine(", wsec_centerorder");
            query.AppendLine(", wsec_name");
            query.AppendLine(", user_userid");
            query.AppendLine(", User_FirstName");
            query.AppendLine("UNION ALL");
            //Installment
            query.AppendLine("select Orde_Secterr");
            query.AppendLine(", wsec_centerorder");
            query.AppendLine(", wsec_name");
            query.AppendLine(", Orde_CreatedBy");
            query.AppendLine(", User_FirstName");
            query.AppendLine(", 0 , 0 , 0 , 0 , 0 , 0 ,0");
            query.AppendLine(", 0 , 0 , 0	, 0 , 0");
            query.AppendLine(", isnull(sum(QTYDEPOSIT),0) as DEPQTY");
            query.AppendLine(", isnull(sum(NUMDEPOSIT),0) as DEPUNIT");
            query.AppendLine(", isnull(SUM(SUMDEPOSIT),0) as DEPAMT");
            query.AppendLine(", isnull(SUM(NUMINSTALLMENT),0) as INSQTY");
            query.AppendLine(", isnull(SUM(SUMINSTALLMENT),0) as INSAMT");
            query.AppendLine("from");
            query.AppendLine("(");
            query.AppendLine("SELECT Orde_Secterr, Orde_CreatedBy, WEP_Deposit.NUMDEPOSIT, WEP_Deposit.SUMDEPOSIT, WEP_Deposit.QTYDEPOSIT,");
            query.AppendLine("WEP_Installment.NUMINSTALLMENT, WEP_Installment.SUMINSTALLMENT");
            query.AppendLine("FROM CRM.dbo.Orders");
            query.AppendLine("LEFT JOIN (");
            query.AppendLine("SELECT Orde_OrderQuoteID as wsir_orderid, ISNULL(count(*),0) *0.25 AS NUMDEPOSIT");
            query.AppendLine(", ISNULL(SUM(depositamt),0) - ISNULL(SUM(depositfee),0) AS SUMDEPOSIT");
            query.AppendLine(", ISNULL(count(*),0) as QTYDEPOSIT");
            query.AppendLine("FROM CRM.dbo.vWSE_ContractDetailFPAll with (nolock) left join");
            query.AppendLine("CRM.dbo.wse_unit as un with (nolock) on un.wseu_unitID = prod_unitID");
            query.AppendLine("WHERE 1=1");
            query.AppendLine("and convert(date,WSIL_CreatedDate) between @StartDate and @EndDate");
            query.AppendLine("and orde_status <> 'Cancelled'");
            query.AppendLine("GROUP BY Orde_OrderQuoteID) AS WEP_Deposit ON Orde_OrderQuoteID = WEP_Deposit.WSIR_OrderId");
            query.AppendLine("LEFT JOIN");
            query.AppendLine("(");
            query.AppendLine("SELECT wsir_orderid, COUNT(distinct wsir_orderid) AS NUMINSTALLMENT");
            query.AppendLine(", ISNULL(SUM(wsir_ReceiptAmount), 0) - ISNULL(SUM(wsir_bankfeeamount), 0) AS SUMINSTALLMENT");
            query.AppendLine("FROM CRM.dbo.receipt with (nolock)");
            query.AppendLine("Left join CRM.dbo.orders on wsir_orderid = Orde_OrderQuoteID");
            query.AppendLine("WHERE convert(date,wsir_date) between @StartDate and @EndDate");
            query.AppendLine("AND orde_wseloanapproved = 'Y'");
            query.AppendLine("and orde_status <> 'Cancelled'");
            query.AppendLine("and wsir_reciepttype = 'installment'");
            query.AppendLine("GROUP BY wsir_orderid");
            query.AppendLine(") AS WEP_Installment ON Orde_OrderQuoteID = WEP_Installment.WSIR_OrderId");
            query.AppendLine(") as ins	left join");
            query.AppendLine("CRM.dbo.Users as us with (nolock) on us.User_UserId = ins.Orde_CreatedBy left join");
            query.AppendLine("CRM.dbo.WSECenter as ce with (nolock) on ce.wsec_TerritoryID = ins.Orde_Secterr");
            query.AppendLine("where 1=1");
            query.AppendLine("and (QTYDEPOSIT is not null or SUMDEPOSIT is not null or NUMINSTALLMENT is not null or SUMINSTALLMENT is not null)");
            query.AppendLine("group by Orde_Secterr");
            query.AppendLine(", wsec_centerorder");
            query.AppendLine(", wsec_name");
            query.AppendLine(", Orde_CreatedBy");
            query.AppendLine(", User_FirstName");
            query.AppendLine("UNION ALL");
            query.AppendLine("select");
            query.AppendLine("wsec_TerritoryID");
            query.AppendLine(", wsec_centerorder");
            query.AppendLine(", centername");
            query.AppendLine(", ec");
            query.AppendLine(", User_FirstName");
            query.AppendLine(", 0 , 0 , 0 , 0 , 0 , 0 , 0");
            query.AppendLine(", 0 , 0 , 0 , 0 , 0");
            query.AppendLine(", 0 , 0 , 0 , 0 , 0");
            query.AppendLine("from");
            query.AppendLine("(");
            query.AppendLine("select User_UserId as ec, User_FirstName, User_TerritoryProfile");
            query.AppendLine(", wsec_TerritoryID, wsec_name as centername, wsec_centerorder");
            query.AppendLine("from CRM.dbo.Users with (nolock) inner");
            query.AppendLine("join");
            query.AppendLine("CRM.dbo.WSECenter on User_PrimaryTerritory = wsec_TerritoryID and wsec_disable = 'enable'");
            query.AppendLine("where 1 = 1");
            query.AppendLine("and User_UserId not in (2420,2422,1459,1665)");
            query.AppendLine("and User_Deleted is null");
            query.AppendLine("and DATEADD(month, DATEDIFF(month, 0, user_Startdate), 0) <= DATEADD(month, DATEDIFF(month, 0, @startDate), 0)");
            query.AppendLine("and (DATEADD(MONTH, DATEDIFF(month, -1, @startDate), -1) <= DATEADD(MONTH, DATEDIFF(month, -1, user_enddate), -1) or user_enddate is null)");
            query.AppendLine("and User_TerritoryProfile in (11,15)");
            query.AppendLine(")");
            query.AppendLine("as ce");
            query.AppendLine(") as fp");
            query.AppendLine("where 1=1");
            query.AppendLine("group by Orde_Secterr");
            query.AppendLine(", wsec_centerorder");
            query.AppendLine(", wsec_name");
            query.AppendLine(", user_userid");
            query.AppendLine(", User_FirstName");
            query.AppendLine(") as FPU LEFT JOIN");
            //Target Amount
            query.AppendLine("(");
            query.AppendLine("select WSEUT_TerritoryID, TargetAmount");
            query.AppendLine("from");
            query.AppendLine("(");
            query.AppendLine("SELECT wsec_TerritoryID as WSEUT_TerritoryID, isnull(sum(sp.spta_amount), 0) as TargetAmount");
            query.AppendLine("FROM CRM.dbo.SalesPlanTargetWeeklyAmount as sp");
            query.AppendLine("LEFT JOIN CRM.dbo.WSECenter as ce on sp.spta_CenterID = ce.CenterID");
            query.AppendLine("and spta_CenterID <> ''");
            query.AppendLine("and spta_year between DATEPART(year, @StartDate) and DATEPART(year, @EndDate)");
            query.AppendLine("and convert(int, spta_month) between DATEPART(month, @StartDate) and DATEPART(month, @EndDate)");
            query.AppendLine("WHERE 1 = 1");
            query.AppendLine("and wsec_TerritoryID is not null");
            query.AppendLine("and wsec_disable = 'enable'");
            query.AppendLine("group by wsec_TerritoryID");
            query.AppendLine(") as tc");
            query.AppendLine(") AS targetAmount ON fpu.Orde_Secterr = targetAmount.WSEUT_TerritoryID left join");
            //Center
            query.AppendLine("(");
            query.AppendLine("select User_UserId as ec, User_FirstName, User_TerritoryProfile");
            query.AppendLine(", wsec_TerritoryID, wsec_name as centername, wsec_centerorder,user_employeeID as em2");
            query.AppendLine("from CRM.dbo.Users with (nolock) inner");
            query.AppendLine("join");
            query.AppendLine("CRM.dbo.WSECenter on User_PrimaryTerritory = wsec_TerritoryID and wsec_disable = 'enable'");
            query.AppendLine("where 1 = 1");
            query.AppendLine("and User_UserId not in (2420,2422,1459,1665)");
            query.AppendLine("and User_Deleted is null");
            query.AppendLine("and DATEADD(month, DATEDIFF(month, 0, user_Startdate), 0) <= DATEADD(month, DATEDIFF(month, 0, @startDate), 0)");
            query.AppendLine("and (DATEADD(MONTH, DATEDIFF(month, -1, @startDate), -1) <= DATEADD(MONTH, DATEDIFF(month, -1, user_enddate), -1) or user_enddate is null)");
            query.AppendLine(")");
            query.AppendLine("as ce on ce.wsec_TerritoryID = fpu.Orde_Secterr and fpu.User_UserId = ce.ec");
            query.AppendLine("left join CRM.dbo.Users as us on us.User_UserId = fpu.User_UserId");
            query.AppendLine("left join CRM.dbo.WSE_ECTarget as ta on ta.EC = us.User_UserId and ta.Month = @m and ta.Year = @y");
            query.AppendLine("WHERE 1=1");
            query.AppendLine("and ce.wsec_TerritoryID =" + ddl);
            query.AppendLine("order by wsec_centerorder");

            db.Open();
            SqlCommand command = new SqlCommand(query.ToString(), db);
            DataTable table = new DataTable();
            table.Load(command.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                RptEc.DataSource = table;
                RptEc.DataBind();
            }
        }
        catch (Exception ex)
        {
            string text = ex.Message;//Response.Write("SalePlan:ajax_perform_loaddetail:GetLeadIn Err : " + ex.Message + " | StackTrace : " + ex.StackTrace);
        }
    }

    protected void getBig4(string ddlecuser)
    {
        try
        {
            string connString = ConfigurationManager.ConnectionStrings["SageConnnetionString"].ConnectionString;
            SqlConnection db = new SqlConnection(connString);
            StringBuilder groupApps = new StringBuilder();

            groupApps.AppendLine(" declare @date date , @reqFilterUser int , @EC varchar(100), @emid varchar(50) ");
            groupApps.AppendLine(" set @date = GETDATE() ");
            groupApps.AppendLine(" set @reqFilterUser = 30 ");
            groupApps.AppendLine(" set @emid =" + "'"+ ddlecuser + "'");

            groupApps.AppendLine(" select ce.wsec_name ");
            groupApps.AppendLine(" , ce.wsec_TerritoryID ");
            groupApps.AppendLine(" , u.User_UserId ");
            groupApps.AppendLine(" , u.User_FirstName ");
            groupApps.AppendLine(" , CAST(isnull(ca.call,0) as decimal(10)) AS [Call] ");
            groupApps.AppendLine(" , CAST(isnull(ap.ap,0) as decimal(10)) as [AP] ");
            groupApps.AppendLine(" , CAST(isnull(show.total,0) as decimal(10)) as TotalShow ");
            groupApps.AppendLine(" , CAST(isnull(fp.FP,0) as decimal(10)) as FP ");
            groupApps.AppendLine(" , CAST(isnull(fp.AMT,0) as decimal(10,2)) as [AMT] ");
            groupApps.AppendLine(" , CAST(isnull(le.lead ,0) as decimal(10)) as Lead ");
            groupApps.AppendLine(" from CRM.dbo.users as u inner join ");
            groupApps.AppendLine(" CRM.dbo.WSECenter as ce on ce.wsec_TerritoryID = u.User_PrimaryTerritory left join ");
            groupApps.AppendLine(" ( ");
            groupApps.AppendLine(" select wsec_name , us.User_UserId , COUNT(*) as call ");
            groupApps.AppendLine(" from CRM.dbo.communication as cm with (nolock) inner join ");
            groupApps.AppendLine(" CRM.dbo.Comm_Link as cl on cl.CmLi_Comm_CommunicationId = cm.Comm_CommunicationId inner join ");
            groupApps.AppendLine(" CRM.dbo.Users as us with (nolock) on us.User_UserId = cm.Comm_CreatedBy inner join ");
            groupApps.AppendLine(" CRM.dbo.WSECenter as ce with (nolock) on ce.wsec_TerritoryID = us.User_PrimaryTerritory ");
            groupApps.AppendLine(" where 1=1 ");
            groupApps.AppendLine(" and (us.User_TerritoryProfile in (11, 15) or us.user_secondaryprofile in (11,15)) ");
            groupApps.AppendLine(" and Comm_Deleted is null ");
            groupApps.AppendLine(" and CmLi_Deleted is null ");
            groupApps.AppendLine(" and cm.comm_action in ('phoneout','studentCall') ");
            groupApps.AppendLine(" and CONVERT(date, Comm_CreatedDate) between convert(date,DATEADD(mm, DATEDIFF(mm,0,@date), 0)) and CONVERT(date,@date) ");
            groupApps.AppendLine(" group by wsec_name, us.User_UserId ");
            groupApps.AppendLine(" ) as ca on ca.wsec_name = ce.wsec_name and u.User_UserId = ca.User_UserId left join ");

            groupApps.AppendLine(" ( ");
            groupApps.AppendLine(" select wsec_name, us.User_UserId, COUNT(*) as ap ");
            groupApps.AppendLine(" from CRM.dbo.communication as cm with(nolock)  inner join ");
            groupApps.AppendLine(" CRM.dbo.Comm_Link as cl with(nolock) on cl.CmLi_Comm_CommunicationId = cm.Comm_CommunicationId inner join ");
            groupApps.AppendLine(" CRM.dbo.Users as us with(nolock) on us.User_UserId = cm.Comm_CreatedBy inner join ");
            groupApps.AppendLine(" CRM.dbo.WSECenter as ce with(nolock) on ce.wsec_TerritoryID = us.User_PrimaryTerritory and (us.User_TerritoryProfile in (11, 15) or us.user_secondaryprofile in (11,15)) left join ");
            groupApps.AppendLine(" CRM.dbo.Person as ps with(nolock) on ps.Pers_PersonId = cl.CmLi_Comm_PersonId ");
            groupApps.AppendLine(" where 1 = 1 ");
            groupApps.AppendLine(" and cm.comm_deleted is null ");
            groupApps.AppendLine(" and cl.cmli_deleted is null ");
            groupApps.AppendLine(" and ps.pers_personid is not null ");
            groupApps.AppendLine(" and ( cm.comm_action = 'meeting' or (cm.Comm_Action = 'cfp' and cm.comm_reference = '6145')  ) ");
            groupApps.AppendLine(" and ");
            groupApps.AppendLine(" ( ");
            groupApps.AppendLine(" cm.Comm_CreatedDate <> cm.comm_completedtime ");
            groupApps.AppendLine(" or cm.comm_completedtime is null ");
            groupApps.AppendLine(" ) ");
            groupApps.AppendLine(" and CONVERT(date, Comm_CreatedDate)  between convert(date,DATEADD(mm, DATEDIFF(mm,0,@date), 0)) and CONVERT(date,@date) ");
            groupApps.AppendLine(" group by wsec_name	, us.User_UserId ");
            groupApps.AppendLine(" ) as ap on ap.wsec_name = ce.wsec_name and ap.User_UserId = u.User_UserId left join ");

            groupApps.AppendLine(" ( ");
            groupApps.AppendLine(" select wsec_name ");
            groupApps.AppendLine(" , user_userid ");
            groupApps.AppendLine(" , SUM(show) + SUM(REN) as total ");
            groupApps.AppendLine(" , SUM(REF) as REF ");
            groupApps.AppendLine(" , SUM(REN) as REN ");
            groupApps.AppendLine(" from ");
            groupApps.AppendLine(" ( ");
            groupApps.AppendLine(" select wsec_name ");
            groupApps.AppendLine(" , us.User_UserId ");
            groupApps.AppendLine(" , COUNT(*) as Show ");
            groupApps.AppendLine(" , sum(Case when comm_source IN ('REF','Prospect-REF') then 1 else 0 end) as REF ");
            groupApps.AppendLine(" , 0 as REN ");
            groupApps.AppendLine(" from ");
            groupApps.AppendLine(" CRM.dbo.WSECenter as ce WITH(NOLOCK) inner join ");
            groupApps.AppendLine(" CRM.dbo.Users as us with (nolock) on ce.wsec_TerritoryID = us.User_PrimaryTerritory left join ");
            groupApps.AppendLine(" CRM.dbo.Comm_Link as cl WITH(NOLOCK) on us.User_UserId = cl.CmLi_Comm_UserId and (us.User_TerritoryProfile in (11, 15) or us.user_secondaryprofile in (11,15)) inner join ");
            groupApps.AppendLine(" CRM.dbo.Communication as cm WITH(NOLOCK) on cm.Comm_CommunicationId = cl.CmLi_Comm_CommunicationId inner join ");
            groupApps.AppendLine(" ( ");
            groupApps.AppendLine(" select CmLi_Comm_PersonId, min(comm_showndatetime) as first, COUNT(*) as qty ");
            groupApps.AppendLine(" from CRM.dbo.Communication as cm WITH(NOLOCK) inner join ");
            groupApps.AppendLine(" CRM.dbo.Comm_Link as cl WITH(NOLOCK) on cm.Comm_CommunicationId = cl.CmLi_Comm_CommunicationId ");
            groupApps.AppendLine(" where 1 = 1 ");
            groupApps.AppendLine(" and Comm_Action = 'meeting' ");
            groupApps.AppendLine(" and Comm_Deleted is null ");
            groupApps.AppendLine(" and CmLi_Deleted is null ");
            groupApps.AppendLine(" and comm_showed = 'y' ");
            groupApps.AppendLine(" and year(cm.comm_showndatetime) = year(@date) ");
            groupApps.AppendLine(" and month(cm.comm_showndatetime) = month(@date) ");
            groupApps.AppendLine(" group by CmLi_Comm_PersonId ");

            groupApps.AppendLine(" having COUNT(*) = 1 ");

            groupApps.AppendLine(" ) as fi on fi.CmLi_Comm_PersonId = cl.CmLi_Comm_PersonId and fi.first = comm_showndatetime");
            groupApps.AppendLine(" where 1 = 1 ");
            groupApps.AppendLine(" and (Comm_rscode not in (6077,6171) or  Comm_rscode is null) ");
            groupApps.AppendLine(" and Comm_Action = 'meeting' ");
            groupApps.AppendLine(" and cm.Comm_Deleted is null ");
            groupApps.AppendLine(" and cl.CmLi_Deleted is null ");
            groupApps.AppendLine(" group by wsec_name	, us.User_UserId ");
            groupApps.AppendLine(" UNION ALL ");
            groupApps.AppendLine(" select wsec_name ");
            groupApps.AppendLine(" , us.User_UserId ");
            groupApps.AppendLine(" , 0 as Show ");
            groupApps.AppendLine(" , 0 as REF ");
            groupApps.AppendLine(" , COUNT(*) as REN ");
            groupApps.AppendLine(" from ");
            groupApps.AppendLine(" CRM.dbo.WSECenter as ce WITH(NOLOCK) inner join ");
            groupApps.AppendLine(" CRM.dbo.Users as us with (nolock) on ce.wsec_TerritoryID = us.User_PrimaryTerritory and (us.User_TerritoryProfile in (11, 15) or us.user_secondaryprofile in (11,15)) left join ");
            groupApps.AppendLine(" CRM.dbo.Comm_Link as cl WITH(NOLOCK) on us.User_UserId = cl.CmLi_Comm_UserId inner join ");
            groupApps.AppendLine(" CRM.dbo.Communication as cm WITH(NOLOCK) on cm.Comm_CommunicationId = cl.CmLi_Comm_CommunicationId inner join ");
            groupApps.AppendLine(" ( ");
            groupApps.AppendLine(" select CmLi_Comm_PersonId, min(comm_showndatetime) as first, COUNT(*) as qty ");
            groupApps.AppendLine(" from CRM.dbo.Communication as cm WITH(NOLOCK) inner join ");
            groupApps.AppendLine(" CRM.dbo.Comm_Link as cl WITH(NOLOCK) on cm.Comm_CommunicationId = cl.CmLi_Comm_CommunicationId ");
            groupApps.AppendLine(" where 1 = 1 ");
            groupApps.AppendLine(" and Comm_Action = 'CFP' ");
            groupApps.AppendLine(" and comm_reference = 6145 ");
            groupApps.AppendLine(" and Comm_Deleted is null ");
            groupApps.AppendLine(" and CmLi_Deleted is null ");
            groupApps.AppendLine(" and comm_showed = 'y' ");
            groupApps.AppendLine(" and year(cm.comm_showndatetime) = year(@date) ");
            groupApps.AppendLine(" and month(cm.comm_showndatetime) = month(@date) ");
            groupApps.AppendLine(" group by CmLi_Comm_PersonId ");
            groupApps.AppendLine(" having COUNT(*) = 1 ");
            groupApps.AppendLine(" ) as fi on fi.CmLi_Comm_PersonId = cl.CmLi_Comm_PersonId and fi.first = comm_showndatetime ");
            groupApps.AppendLine(" where 1 = 1 ");
            groupApps.AppendLine(" and Comm_Action = 'CFP' ");
            groupApps.AppendLine(" and comm_reference = 6145 ");
            groupApps.AppendLine(" and cm.Comm_Deleted is null ");
            groupApps.AppendLine(" and cl.CmLi_Deleted is null ");
            groupApps.AppendLine(" group by wsec_name, us.User_UserId ");
            groupApps.AppendLine(" ) as show ");
            groupApps.AppendLine(" where 1=1 ");
            groupApps.AppendLine(" group by wsec_name	, user_userid ");
            groupApps.AppendLine(" ) as show on show.wsec_name = ce.wsec_name and show.User_UserId = u.User_UserId  left join ");

            groupApps.AppendLine(" ( ");
            groupApps.AppendLine(" select ce.wsec_name ");
            groupApps.AppendLine(" , us.User_UserId ");
            groupApps.AppendLine(" , COUNT(*) as AP2 ");
            groupApps.AppendLine(" from CRM.dbo.WSECenter as ce WITH(NOLOCK) inner join ");
            groupApps.AppendLine(" CRM.dbo.Users as us with (nolock) on ce.wsec_TerritoryID = us.User_PrimaryTerritory and (us.User_TerritoryProfile in (11, 15) or us.user_secondaryprofile in (11,15)) left join ");
            groupApps.AppendLine(" CRM.dbo.Comm_Link as cl WITH(NOLOCK) on us.User_UserId = cl.CmLi_Comm_UserId inner join ");
            groupApps.AppendLine(" CRM.dbo.Communication as cm WITH(NOLOCK) on cm.Comm_CommunicationId = cl.CmLi_Comm_CommunicationId inner join ");
            groupApps.AppendLine(" ( ");
            groupApps.AppendLine(" select cl.CmLi_Comm_PersonId ,MAX(comm_createddate) as lastapp ");
            groupApps.AppendLine(" from CRM.dbo.Communication as cm with (nolock) inner join ");
            groupApps.AppendLine(" CRM.dbo.Comm_Link as cl with (nolock) on cl.CmLi_Comm_CommunicationId = cm.Comm_CommunicationId inner join ");
            groupApps.AppendLine(" CRM.dbo.Users as us on us.User_UserId = cm.Comm_CreatedBy and (us.User_TerritoryProfile in (11, 15) or us.user_secondaryprofile in (11,15))  left join ");
            groupApps.AppendLine(" CRM.dbo.person as ps on ps.pers_personid = cl.cmli_comm_personid and ps.pers_deleted is null ");
            groupApps.AppendLine(" where 1=1 ");
            groupApps.AppendLine(" and ");
            groupApps.AppendLine(" ( ");
            groupApps.AppendLine(" datediff(day,pers_showdatetime, @date) <= 90 ");
            groupApps.AppendLine(" ) ");
            groupApps.AppendLine(" and ps.pers_showdatetime is not null ");
            groupApps.AppendLine(" and cm.Comm_Action = 'meeting' and year(cm.comm_datetime) >= 2017 ");
            groupApps.AppendLine(" and year(cm.Comm_CreatedDate) = year(@date) ");
            groupApps.AppendLine(" and month(cm.Comm_CreatedDate) = month(@date) ");
            groupApps.AppendLine(" and cm.Comm_CreatedBy is not null ");
            groupApps.AppendLine(" group by cl.CmLi_Comm_PersonId ");
            groupApps.AppendLine(" ) las on las.CmLi_Comm_PersonId = cl.CmLi_Comm_PersonId and las.lastapp = cm.Comm_CreatedDate ");
            groupApps.AppendLine(" where 1=1 ");
            groupApps.AppendLine(" and comm_showndatetime is not null ");
            groupApps.AppendLine(" group by ce.wsec_name	, us.User_UserId ");
            groupApps.AppendLine(" ) as ap2 on ap2.wsec_name = ce.wsec_name and ap2.User_UserId = u.User_UserId left join ");
            groupApps.AppendLine(" ( ");

            groupApps.AppendLine(" select  ce.wsec_name, us.User_UserId ");
            groupApps.AppendLine(" , ISNULL(SIGQTY, 0) as SIG ");
            groupApps.AppendLine(" , isnull(FPQTY, 0) as FP ");
            groupApps.AppendLine(" , isnull(AMT, 0) + ISNULL(DEPUNIT, 0) as AMT ");
            groupApps.AppendLine(" , isnull(AMTR, 0) + ISNULL(DEPUNITR,0)  as AMTR ");
            groupApps.AppendLine(" from CRM.dbo.WSECenter as ce inner join ");
            groupApps.AppendLine(" CRM.dbo.Users as us on us.User_PrimaryTerritory = ce.wsec_TerritoryID and us.User_Deleted is null LEFT JOIN ");
            groupApps.AppendLine(" ( ");
            groupApps.AppendLine(" SELECT Orde_Secterr	, fp.User_UserId ");
            groupApps.AppendLine(" , sum(Case when MaxDate IS NOT null and CONVERT(date, orde_opened) between convert(date, DATEADD(mm, DATEDIFF(mm, 0, @date), 0)) and CONVERT(date, @date)  then 1 else 0 end) as SIGQTY ");
            groupApps.AppendLine(" , sum(Case when orde_status = 'Completed' AND orde_wseloanapproved IS NULL and CONVERT(date, maxdate) between convert(date, DATEADD(mm, DATEDIFF(mm, 0, @date), 0)) and CONVERT(date, @date) then 1 else 0 end) as FPQTY ");
            groupApps.AppendLine(" , SUM(case when orde_wseloanapproved IS NULL and orde_status = 'Completed' and CONVERT(date, maxdate) between convert(date, DATEADD(mm, DATEDIFF(mm, 0, @date), 0)) and CONVERT(date, @date) then ReceiptNetAmount else 0 end) as AMT ");
            groupApps.AppendLine(" , sum(Case when orde_source in ('REF','Prospect-REF') and orde_status = 'Completed' AND orde_wseloanapproved IS NULL and CONVERT(date, maxdate) between convert(date,DATEADD(mm, DATEDIFF(mm,0,@date), 0)) and CONVERT(date,@date) then ReceiptNetAmount else 0 end)  as AMTR ");
            groupApps.AppendLine(" FROM CRM.dbo.vWSE_ContractDetails_Shorter  as fp with(nolock) left join ");
            groupApps.AppendLine(" CRM.dbo.WSE_UnitPromotion as up on up.WSEUP_ProductID = fp.orit_productid ");
            groupApps.AppendLine(" and up.wseup_uom_month = fp.uom_month ");
            groupApps.AppendLine(" and up.wseup_type = fp.orde_type ");
            groupApps.AppendLine(" and fp.MaxDate between up.wseup_startdate and up.wseup_enddate ");
            groupApps.AppendLine(" WHERE 1=1 ");
            groupApps.AppendLine(" and ((orde_type in ('Retail', 'RetailRenewal') or (orde_type = 'additional' and prod_productfamilyid in (18,42,44,16,39,29,55 )))) ");
            groupApps.AppendLine(" GROUP BY Orde_Secterr, fp.User_UserId ");
            groupApps.AppendLine(" ) AS FP ON wsec_TerritoryID = FP.Orde_Secterr and fp.User_UserId = us.User_UserId left join ");

            groupApps.AppendLine(" ( ");
            groupApps.AppendLine(" select Orde_Secterr ");
            groupApps.AppendLine(" , user_userid ");
            groupApps.AppendLine(" , isnull(sum(InsAMT),0) as DEPUNIT ");
            groupApps.AppendLine(" , isnull(sum(InsAMTR),0) as DEPUNITR ");
            groupApps.AppendLine(" from ");
            groupApps.AppendLine(" ( ");
            groupApps.AppendLine(" SELECT Orde_Secterr ");
            groupApps.AppendLine(" , Orde_CreatedBy as user_userid ");
            groupApps.AppendLine(" , WEP_Deposit.NUMDEPOSIT ");
            groupApps.AppendLine(" , isnull(SUMDEPOSIT,0) + isnull(SUMINSTALLMENT,0) as InsAMT ");
            groupApps.AppendLine(" , case when orde_source IN ('REF','Prospect-REF') then isnull(SUMDEPOSIT,0) + isnull(SUMINSTALLMENT,0) else 0 end as InsAMTR ");
            groupApps.AppendLine(" , case when orde_source IN ('REF','Prospect-REF') then WEP_Deposit.NUMDEPOSIT else 0 end as NUMDEPOSITR	 ");
            groupApps.AppendLine(" FROM CRM.dbo.Orders ");
            groupApps.AppendLine(" LEFT JOIN ( ");
            groupApps.AppendLine(" SELECT Orde_OrderQuoteID as wsir_orderid, ISNULL(count(*),0) *0.25 AS NUMDEPOSIT ");
            groupApps.AppendLine(" , ISNULL(count(*),0) as QTYDEPOSIT ");
            groupApps.AppendLine(" , ISNULL(SUM(depositamt), 0) - ISNULL(SUM(depositfee), 0) AS SUMDEPOSIT ");
            groupApps.AppendLine(" FROM CRM.dbo.vWSE_ContractDetailFPAll with (nolock) ");
            groupApps.AppendLine(" WHERE 1=1 ");
            groupApps.AppendLine(" and year(WSIL_CreatedDate) = year(@date) ");
            groupApps.AppendLine(" and month(WSIL_CreatedDate) = month(@date) ");
            groupApps.AppendLine(" and orde_status <> 'Cancelled' ");
            groupApps.AppendLine(" GROUP BY Orde_OrderQuoteID) AS WEP_Deposit ON Orde_OrderQuoteID = WEP_Deposit.WSIR_OrderId LEFT JOIN ");
            groupApps.AppendLine(" ( ");
            groupApps.AppendLine(" SELECT wsir_orderid, COUNT(distinct wsir_orderid) AS NUMINSTALLMENT, ISNULL(SUM(wsir_ReceiptAmount), 0) - ISNULL(SUM(wsir_bankfeeamount), 0) AS SUMINSTALLMENT ");
            groupApps.AppendLine(" FROM CRM.dbo.receipt with(nolock) ");
            groupApps.AppendLine(" Left join CRM.dbo.orders on wsir_orderid = Orde_OrderQuoteID ");
            groupApps.AppendLine(" WHERE 1 = 1 ");
            groupApps.AppendLine(" and year(wsir_date) = year(@date) ");
            groupApps.AppendLine(" and month(wsir_date) = month(@date) ");
            groupApps.AppendLine(" AND orde_wseloanapproved = 'Y' and orde_status <> 'Cancelled'  and wsir_reciepttype = 'installment' ");
            groupApps.AppendLine(" GROUP BY wsir_orderid ");
            groupApps.AppendLine(" ) AS INS ON Orde_OrderQuoteID = INS.WSIR_OrderId ");
            groupApps.AppendLine(" where 1 = 1 ");
            groupApps.AppendLine(" and  (NUMDEPOSIT is not null or NUMINSTALLMENT is not null) ");
            groupApps.AppendLine(" ) as insm ");
            groupApps.AppendLine(" where 1=1 ");
            groupApps.AppendLine(" group by Orde_Secterr	, user_userid ");
            groupApps.AppendLine(" ) ");
            groupApps.AppendLine(" AS ReceiptSummaryM ON ce.wsec_TerritoryID = ReceiptSummaryM.Orde_Secterr and  us.User_UserId = ReceiptSummaryM.user_userid ");
            groupApps.AppendLine(" WHERE 1=1 ");
            groupApps.AppendLine(" and ce.wsec_disable = 'enable' ");
            groupApps.AppendLine(" ) as fp on fp.wsec_name = ce.wsec_name and fp.User_UserId = u.User_UserId left join ");
            groupApps.AppendLine(" ( ");
            groupApps.AppendLine(" select ce.wsec_name ");
            groupApps.AppendLine(" , le.Lead_CreatedBy as user_userid ");
            groupApps.AppendLine(" , COUNT(*) as lead ");
            groupApps.AppendLine(" from CRM.dbo.WSECenter as ce with (nolock) left join ");
            groupApps.AppendLine(" CRM.dbo.Lead as le with (nolock) on le.Lead_SecTerr = ce.wsec_TerritoryID ");
            groupApps.AppendLine(" where 1=1 ");
            groupApps.AppendLine(" and le.lead_personsource in ('REF','Prospect-REF') ");
            groupApps.AppendLine(" and Lead_Deleted is null ");
            groupApps.AppendLine(" and convert(date,le.Lead_CreatedDate) between convert(date,DATEADD(mm, DATEDIFF(mm,0,@date), 0)) and CONVERT(date,@date) ");
            groupApps.AppendLine(" group by ce.wsec_name, le.Lead_CreatedBy ");
            groupApps.AppendLine(" ) as le on le.wsec_name = ce.wsec_name and le.User_UserId = u.User_UserId ");
            groupApps.AppendLine(" left join CRM.dbo.vWSE_HR_EmployeeData as em on em.PersonCode = u.user_employeeID ");
            groupApps.AppendLine(" where 1=1 ");
            groupApps.AppendLine(" and ce.wsec_disable = 'enable' ");
            groupApps.AppendLine(" and u.User_Disabled is null ");
            groupApps.AppendLine(" and u.User_Deleted is null ");
            groupApps.AppendLine(" and u.user_employeeID = @emid ");
            db.Open();
            SqlCommand command = new SqlCommand(groupApps.ToString(), db);
            DataTable table = new DataTable();
            table.Load(command.ExecuteReader());

            if (table.Rows.Count > 0)
            {
                RptBigFour.DataSource = table;
                RptBigFour.DataBind();
            }
        }
        catch (Exception ex)
        {
            string text = ex.Message;
        }
    }
}