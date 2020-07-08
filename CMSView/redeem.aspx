<%@ Page Language="C#" AutoEventWireup="true" CodeFile="redeem.aspx.cs" Inherits="CMSView_redeem" MasterPageFile="~/MasterPage/CMSMasterPage.Master" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="cphHead" runat="server">
    <link href="<%= ResolveClientUrl("~/css/_point.css") %>" rel="stylesheet" />
</asp:Content>

<asp:Content ID="BodyConntent" ContentPlaceHolderID="cphBody" runat="server">
    <section>
        <div class="container py-5">
            <h3 class="text-uppercase mb-5 font-weight-bold text-lg-left text-md-left text-sm-left text-center block__head">Redeem</h3>
            <div class="row">
                <div class="col-12 form-group">
                    <div class="row">
                        <div class="col-2">
                            <div class="form-group">
                                <label for="DdlStatus">Status</label>
                                <asp:DropDownList ID="DdlStatus" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="ALL" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Pending" Value="W"></asp:ListItem>
                                    <asp:ListItem Text="Completed" Value="A"></asp:ListItem>
                                    <asp:ListItem Text="Reject" Value="R"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-2">
                            <div class="form-group">
                                <label for="TxtRequestBy">Request By</label>
                                <asp:TextBox ID="TxtRequestBy" runat="server" CssClass="form-control"></asp:TextBox>
                            </div>
                        </div>
                        <div class="col-2">
                            <asp:Button ID="BtnSearch" runat="server" Text="Submit" CssClass="btn btn-primary" style="margin-top:30px;" OnClientClick="return false;" />
                        </div>
                    </div>
                </div>
                <div class="col-12">
                    <div class="row">
                        <div class="col-12">
                            <div class="pagination">
                                <asp:Literal ID="LitPage" runat="server"></asp:Literal>
                            </div>
                        </div>
                        <div class="col-12">
                            <table id="tblRedeem" class="table" cellpadding="0" cellspacing="0" border="1">
                                <thead class="thead-dark">
                                    <tr>
                                        <%--<th>#</th>--%>
                                        <th>Date</th>
                                        <th>Rewards</th>
                                        <th>Quantity</th>
                                        <th>Request By</th>
                                        <th>Status</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="RptRedeem" runat="server">
                                        <ItemTemplate>
                                            <tr>
                                                <td><%# String.Format("{0:dd MMM yyyy HH:mm}", Convert.ToDateTime(Eval("CreatedDate"))) %></td>
                                                <td><%# Eval("RewardName") %></td>
                                                <td><%# Eval("Quantity") %></td>
                                                <td><%# Eval("EmpName") %></td>
                                                <td id="<%# "status" + Eval("RD_ID") %>" class="<%# Eval("Status").ToString() == "Completed" ? "fontgreen" : Eval("Status").ToString() == "Reject" ? "fontred" : "" %>"><%# Eval("Status") %></td>
                                                <td id="<%# "edit" + Eval("RD_ID") %>" rdid="<%# Eval("RD_ID") %>"><i class="fas fa-pencil-alt mr-2 rdedit"></i></td>
                                            </tr>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </tbody>
                            </table>
                        </div>
                        <div class="col-12">
                            <div class="pagination">
                                <asp:Literal ID="LitPageButton" runat="server"></asp:Literal>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="redeemdetail" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Redeem Detail</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12 col-md-8">
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <label class="txt__required">Name:</label>
                                                </div>
                                                <div class="col-sm-8">
                                                    <label id="lbName"></label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <label class="txt__required">Center:</label>
                                                </div>
                                                <div class="col-sm-8">
                                                    <label id="lbCenter"></label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <label class="txt__required">Email:</label>
                                                </div>
                                                <div class="col-sm-8">
                                                    <label id="lbEmail"></label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <label class="txt__required">Reward Name:</label>
                                                </div>
                                                <div class="col-sm-8">
                                                    <label id="lbRewardName"></label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <label class="txt__required">Quantity:</label>
                                                </div>
                                                <div class="col-sm-8">
                                                    <label id="lbQuantity"></label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <label class="txt__required">Point/Item:</label>
                                                </div>
                                                <div class="col-sm-8">
                                                    <label id="lbPoint"></label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <label class="txt__required">Status:</label>
                                                </div>
                                                <div class="col-sm-8">
                                                    <label id="lbStatus"></label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <label class="txt__required">Update By:</label>
                                                </div>
                                                <div class="col-sm-8">
                                                    <label id="lbUpdatedBy"></label>
                                                </div>
                                            </div>
                                            <div class="row">
                                                <div class="col-sm-4">
                                                    <label class="txt__required">Update Date:</label>
                                                </div>
                                                <div class="col-sm-8">
                                                    <label id="lbUpdatedDate"></label>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-sm-12 col-md-4">
                                    <img id="imgReward" style="width:100%;" />
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:LinkButton ID="btnapprove" runat="server" CssClass="btn btn-success" OnClientClick="return false;"><span id="btnapprove_">Approve</span></asp:LinkButton>
                        <asp:LinkButton ID="btnreject" runat="server" CssClass="btn btn-danger" OnClientClick="return false;"><span id="btnreject_">Reject</span></asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <asp:HiddenField ID="HdnUser" runat="server" />
    <asp:HiddenField ID="HdnEmail" runat="server" />
    <asp:HiddenField ID="HdnRDID" runat="server" />
    <asp:HiddenField ID="HdnPage" runat="server" />
</asp:Content>

<asp:Content ID="FooterContent" ContentPlaceHolderID="cphFooter" runat="server">
    <script src="<%= ResolveClientUrl("~/Scripts/sweetalert.min.js") %>"></script>
    <script src="<%= ResolveClientUrl("~/Scripts/jquery.blockUI.js") %>"></script>
    <script src="<%=ResolveClientUrl("~/Scripts/_cms.js")%>"></script>
    <script src="<%=ResolveClientUrl("~/Scripts/jquery-ui-1.12.1.custom/jquery-ui.min.js")%>"></script>
    <link href="<%=ResolveClientUrl("~/Scripts/jquery-ui-1.12.1.custom/jquery-ui.min.css")%>" rel="stylesheet" />
    <script src="<%=ResolveClientUrl("~/Scripts/bootstrap/bootstrap.min.js")%>"></script>

    <style>
        .validate_error {
            background-color: #f8dbdd !important;
            border: 1px solid #f4acad !important;
        }

        .pagination {
            display: inline-block;
        }

            .pagination span {
                color: black;
                float: left;
                padding: 8px 16px;
                text-decoration: none;
                background-color: #eee;
                margin-right: 10px;
                cursor: pointer;
            }

        .page_active {
            background-color: #ffbd4494 !important;
            cursor: default !important;
        }

        .pagination ul {
            display: none;
        }

        .fontgreen{
            color:green;
        }

        .fontred{
            color:red;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#point').addClass("active");
        });

        $(".rdedit").click(function () {
            OnEditClick(this);
        });

        $("#<%=btnapprove.ClientID%>").click(function () {
            sweetwarning("A");
        });

        $("#<%=btnreject.ClientID%>").click(function () {
            sweetwarning("R");
        });

        $('.page_inactive').click(function () {
            var page = $(this).attr("page");

            $('input[id$="HdnPage"]').val(page);

            doSubmitPaging();
            return false;
        });

        function doSubmitPaging() {
            doWaitng();
            //$('input[id$="hdAction"]').val("SUBMITED");
            document.forms[0].submit();
            return false;
        }

        function doWaitng() {
            $.blockUI({
                message: '<img src=\"/images/ajax-loader.gif\" alt=\"Loading...\"/><br /><h2>Loading...</h2>'
                , css: {
                    border: '1px solid #cccccc'
                    , color: '#8B8B8B'
                }
            });
        }

        function sweetwarning(type) {
            var rdid = document.getElementById('<%=HdnRDID.ClientID%>').value;

            var _type = "";
            var _typeshow = "";

            if (type == "R") {
                _type = "Reject";
                _typeshow = "Reject";
            } else {
                _type = "Approve";
                _typeshow = "Completed";
            }

            swal({
                title: "Confirm " + _type + " Redeem?",
                text: "",
                type: "warning",
                showCancelButton: true,
                confirmButtonColor: "#DD6B55",
                confirmButtonText: "Yes",
                cancelButtonText: "No",
                closeOnConfirm: false,
                closeOnCancel: false
            },
                function (isConfirm) {
                    if (isConfirm) {
                        doWaitng();

                        var User = document.getElementById('<%=HdnUser.ClientID%>').value;
                        var Email = document.getElementById('<%=HdnEmail.ClientID%>').value;

                        $.ajax({
                            url: '<%=ResolveUrl("redeem.aspx/Onsubmit") %>',
                            data: "{ 'rdid': '" + rdid + "', 'type': '" + type + "', 'User': '" + User + "', 'Email': '" + Email + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                $.unblockUI();

                                $("#<%=btnapprove.ClientID%>").addClass("none");

                                document.getElementById("status" + rdid).innerHTML = _typeshow;

                                var obj = JSON.parse(data.d);

                                var message = obj.message;

                                if (message == "success") {
                                    swal({
                                        title: "Success!",
                                        text: "",
                                        type: "success"
                                    }, function () {
                                        $('#redeemdetail').modal('toggle');
                                    });
                                }
                                else {
                                    swal({
                                        title: "Alert!",
                                        text: data.d
                                    });
                                }
                            },
                            error: function (response) {
                            },
                            failure: function (response) {
                            }
                        });
                    }
                    else {
                        swal("Cancelled", "", "error");
                    }
                });
        }

        $("#<%=BtnSearch.ClientID%>").click(function () {
            $('input[id$="HdnPage"]').val("1");
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
                message: '<img src=\"../images/ajax-loader.gif\" alt=\"Loading...\"/><br /><h2>Loading...</h2>'
                , css: {
                    border: '1px solid #cccccc'
                    , color: '#8B8B8B'
                }
            });
        }

        function OnEditClick(sv) {
            var rdid = $(sv).closest("td").attr("rdid");

            $("#<%=HdnRDID.ClientID%>").val(rdid);
            
            $.ajax({
                url: '<%=ResolveUrl("redeem.aspx/getredeem") %>',
                data: "{ 'rdid': '" + rdid + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var obj = JSON.parse(data.d);

                    var message = obj.message;
                    var EmpName = obj.EmpName;
                    var Center = obj.Center;
                    var Email = obj.Email;
                    var RewardName = obj.RewardName;
                    var Quantity = obj.Quantity;
                    var Point = obj.Point;
                    var Status = obj.Status;
                    var Picture = obj.Picture;
                    var UpdatedBy = obj.UpdatedBy;
                    var UpdatedDate = obj.UpdatedDate;

                    if (message == "success") {
                        $('#redeemdetail').modal('toggle');

                        document.getElementById("lbName").innerHTML = EmpName;
                        document.getElementById("lbCenter").innerHTML = Center;
                        document.getElementById("lbEmail").innerHTML = Email;
                        document.getElementById("lbRewardName").innerHTML = RewardName;
                        document.getElementById("lbQuantity").innerHTML = Quantity;
                        document.getElementById("lbPoint").innerHTML = Point;
                        document.getElementById("lbUpdatedBy").innerHTML = UpdatedBy;
                        document.getElementById("lbUpdatedDate").innerHTML = UpdatedDate;

                        if (Status == "W") {
                            document.getElementById("lbStatus").innerHTML = "Pending";
                            $("#<%=btnapprove.ClientID%>").removeClass("none");
                        } else if (Status == "A") {
                            document.getElementById("lbStatus").innerHTML = "Completed";
                            $("#<%=btnapprove.ClientID%>").addClass("none");
                        } else {
                            document.getElementById("lbStatus").innerHTML = "Reject";
                            $("#<%=btnapprove.ClientID%>").addClass("none");
                        }

                        $("#imgReward").attr("src", Picture);
                    }
                    else {
                        swal({
                            title: "Alert!",
                            text: data.d
                        });
                    }
                },
                error: function (response) {
                },
                failure: function (response) {
                }
            });
        }
    </script>
</asp:Content>
