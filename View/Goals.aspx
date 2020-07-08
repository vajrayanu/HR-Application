<%@ Page Title="" Language="C#" MasterPageFile="~/masterpage/MasterPage.master" AutoEventWireup="true" CodeFile="Goals.aspx.cs" Inherits="Goals" %>

<asp:Content ID="goals" ContentPlaceHolderID="MainContent" runat="Server">
    <script src="<%=ResolveClientUrl("~/Scripts/jquery.blockUI.js")%>"></script>
    <link href="<%=ResolveClientUrl("~/Content/jquery-ui.min.css")%>" rel="stylesheet" />
    <script src="<%=ResolveClientUrl("~/Scripts/jquery-ui.min.js")%>"></script>

     <script src="<%=ResolveClientUrl("~/LoginStyle/vendor/select2/select2.js")%>"></script>
    <script src="<%=ResolveClientUrl("~/LoginStyle/vendor/select2/select2.min.js")%>"></script>
    <link href="<%=ResolveClientUrl("~/LoginStyle/vendor/select2/select2.min.css")%>" rel="stylesheet" />
    <link href="<%=ResolveClientUrl("~/LoginStyle/vendor/select2/select2.css")%>" rel="stylesheet" />
    <script src="<%=ResolveClientUrl("~/LoginStyle/vendor/select2/select2.js")%>"></script>

    <div class="container">
        <section>
            <div class="row mt-5">
                <div class="col-12 page__title">
                    <i class="fa fa-flag-checkered color-red pr-2"></i>
                    <h2 class="d-inline">Goals</h2>
                </div>
            </div>
        </section>

        <section>
            <div class="row mt-5">
                <div class="col-12 mb-2">
                    <h4>EC Target <i class="fab fa-bitcoin"></i></h4>
                </div>

                <div class="col-3 mb-2">
                    <asp:DropDownList ID="ddlBranch" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>
                <div class="col-12 mb-2">
                    <table class="table table-bordered">
                        <thead>
                            <tr class="table-active">
                                <th>ECName</th>
                                <th>ECTarget</th>
                                <th>TotalAMT</th>
                                <th>Percentage</th>
                            </tr>
                        </thead>
                        <asp:Repeater ID="RptEc" runat="server">
                            <ItemTemplate>
                                <tbody>
                                    <tr>
                                        <td><%# Eval("ECName") %></td>
                                        <td><%# Eval("ECTarget").ToString() == "" ? "0" : String.Format("{0:N0}", Convert.ToDouble(Eval("ECTarget"))) %></td>
                                        <td><%# Eval("TOTALAMT", "{0:n0}") %></td>
                                        <td><%# Eval("PercentTarget", "{0:F2}"+'%') %></td>
                                    </tr>
                                </tbody>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </div>
            </div>
        </section>

        <section>
            <div class="row mt-3">
                <div class="col-12 mb-2">
                    <h4>KPI <i class="fas fa-chart-line"></i></h4>
                </div>

                <div class="col-3 mb-2">
                    <asp:DropDownList ID="ddlKPI" runat="server" CssClass="form-control"></asp:DropDownList>
                </div>
                <div class="col-12">
                    <table class="table table-bordered">
                        <thead>
                            <tr class="table-active">
                                <th>NAME</th>
                                <th>EC</th>
                                <th>Call</th>
                                <th>AP</th>
                                <th>FP</th>
                                <th>AMT</th>
                                <th>LEAD</th>
                            </tr>
                        </thead>
                        <asp:Repeater ID="RptBigFour" runat="server">
                            <ItemTemplate>
                                <tbody>
                                    <tr>
                                        <td><%# Eval("User_FirstName") %></td>
                                        <td><%# Eval("wsec_name") %></td>
                                        <td><%# Eval("Call") %></td>
                                        <td><%# Eval("AP") %></td>
                                        <td><%# Eval("FP") %></td>
                                        <td><%# Eval("AMT", "{0:n0}") %></td>
                                        <td><%# Eval("Lead") %></td>
                                    </tr>
                                </tbody>
                            </ItemTemplate>
                        </asp:Repeater>
                    </table>
                </div>
            </div>
        </section>
    </div>
    <script type="text/javascript">
        $('#<%=ddlBranch.ClientID %>').change(function () {
            doSubmitPage2();
            return false;
        });

        function doSubmitPage2() {
            doWaitng();
            document.forms[0].submit();
            return false;
        }

        function doWaitng() {
            $.blockUI({
                message: '<img src=\"<%=ResolveClientUrl("~/images/ajax-loader.gif")%>\" alt=\"Loading...\"/><br /><h2>Loading...</h2>'
                , css: {
                    border: '1px solid #cccccc'
                    , color: '#8B8B8B'
                }
            });
        }
    </script>

    <script type="text/javascript">
        $('#<%=ddlKPI.ClientID %>').change(function () {
            doSubmitPage2();
            return false;
        });

        function doSubmitPage2() {
            doWaitng();
            document.forms[0].submit();
            return false;
        }

        function doWaitng() {
            $.blockUI({
                message: '<img src=\"<%=ResolveClientUrl("~/images/ajax-loader.gif")%>\" alt=\"Loading...\"/><br /><h2>Loading...</h2>'
                , css: {
                    border: '1px solid #cccccc'
                    , color: '#8B8B8B'
                }
            });
        }
    </script>

    <script>
        $('.form-control').select2({
            placeholder: 'Select',
            width: '100%'
        });
    </script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#home').addClass("active");
        });
    </script>
</asp:Content>
