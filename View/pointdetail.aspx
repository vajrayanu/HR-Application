<%@ Page Language="C#" AutoEventWireup="true" CodeFile="pointdetail.aspx.cs" Inherits="pointdetail" MasterPageFile="~/masterpage/MasterPage.master" %>

<asp:Content ID="BodyConntent" ContentPlaceHolderID="MainContent" runat="server">
    <script src="<%= ResolveClientUrl("~/Scripts/sweetalert.min.js") %>"></script>
    <script src="<%= ResolveClientUrl("~/Scripts/jquery.blockUI.js") %>"></script>
    <link href="<%=ResolveClientUrl("~/css/sweetalert.css")%>" rel="stylesheet" />
    <div class="container">
        <section>
            <div class="row bg-red py-3">
                <div class="col-2">
                    <a href="<%= ResolveUrl("~/Point") %>" class="text-decoration-none back-link d-block">
                        <i class="fas fa-chevron-left text-center font-size-20"></i>
                    </a>
                </div>
                <div class="col-8 text-center">
                    <i class="fas fa-gift text-white pr-2 font-size-20"></i>
                    <h2 class="d-inline font-size-20 text-uppercase">Reward</h2>
                </div>
                <div class="col-2"></div>
            </div>
        </section>
        <section>
            <div class="row mt-5">
                <div class="col-12">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-12 col-12 p-3">
                            <div class="block__point">
                                <div class="col-12 border rounded px-0 picture_reward-detail">
                                    <asp:Image ID="ImgReward" runat="server" CssClass="img-point setpicture" />
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12 col-12 p-3">
                            <h3 class="font-weight-bold"><asp:Literal ID="LitTitle" runat="server"></asp:Literal></h3>
                            <h6 class="color-grey font-weight-normal"><asp:Literal ID="LitStore" runat="server"></asp:Literal></h6>
                            <div class="col-12 px-0 py-4 text-right">
                                <h2 class="color-red m-0 d-inline-block font-weight-bold">
                                <asp:Literal ID="LitPoint" runat="server"></asp:Literal>
                                </h2>
                                <p class="color-red m-0 pl-1 d-inline-block">Point</p>
                                <p class="font__weight-900 font-size-11">
                                    Current Point: 
                                    <span id="currentpoint">
                                        <asp:Literal ID="LitCurrentPoint" runat="server"></asp:Literal>
                                    </span>
                                </p>
                            </div>
                            
                            <p class="color-grey font-size-11 mb-1">Expire: <b>02/02/2020</b></p>
                            <button type="button" id="btncart" class="btn btn-warning col-12 font-size-13 text-uppercase font__weight-900 py-2" runat="server">Redeem</button>&nbsp;
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <asp:HiddenField ID="HdnUser" runat="server" />
        <asp:HiddenField ID="HdnEmail" runat="server" />
        <asp:HiddenField ID="HdnRWID" runat="server" />
    </div>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#home').addClass("active");
        });

        $("#<%=btncart.ClientID%>").click(function () {
            swal({
                title: "Confirm Redeem?",
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

                        var RWID = document.getElementById('<%=HdnRWID.ClientID%>').value;
                        var User = document.getElementById('<%=HdnUser.ClientID%>').value;
                        var Email = document.getElementById('<%=HdnEmail.ClientID%>').value;

                        $.ajax({
                            url: '<%=ResolveUrl("pointdetail.aspx/redeem") %>',
                            data: "{ 'RWID': '" + RWID + "', 'User': '" + User + "', 'Email': '" + Email + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                $.unblockUI();

                                var obj = JSON.parse(data.d);

                                var message = obj.message;
                                var Point_bl = obj.Point_bl;

                                if (message == "Insert") {
                                    document.getElementById("currentpoint").innerHTML = Point_bl;

                                    swal({
                                        title: "Success!",
                                        text: "",
                                        type: "success"
                                    }, function () {
                                    });
                                }
                                else if (message == "point")
                                {
                                    swal({
                                        title: "Error!",
                                        text: "You do not have enough points.",
                                        type: "error"
                                    });
                                }
                                else {
                                    swal({
                                        title: "Alert!",
                                        text: message
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
        });

        function doWaitng() {
            $.blockUI({
                message: '<img src=\"../images/ajax-loader.gif\" alt=\"Loading...\"/><br /><h2>Loading...</h2>'
                , css: {
                    border: '1px solid #cccccc'
                    , color: '#8B8B8B'
                }
            });
        }
    </script>
</asp:Content>
