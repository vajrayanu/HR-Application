<%@ Page Title="" Language="C#" MasterPageFile="~/masterpage/MasterPage.master" AutoEventWireup="true" CodeFile="Home.aspx.cs" Inherits="View_Home" %>

<asp:Content ID="Home" ContentPlaceHolderID="MainContent" runat="Server">
    <script src="<%=ResolveClientUrl("~/Scripts/sweetalert.min.js")%>"></script>
    <link href="<%=ResolveClientUrl("~/css/sweetalert.css")%>" rel="stylesheet" />

    <div class="container">
        <section>
            <div class="row mt-5">
                <div class="col-lg-4 col-md-12 col-sm-12 col-12">
                    <div class="col-12 border rounded block__profile pb-5 mb-3">
                        <div class="col-12 block__life py-3 line-dashed">
                            <div class="row mb-2">
                                <div class="col-lg-5 col-md-5 col-sm-12 col-12 p-0">
                                    <div class='blog-icon content-left'>
                                        <asp:Image ID="ImageProfile" CssClass="rounded-circle" runat="server"></asp:Image>
                                    </div>
                                </div>
                                <div class="col-lg-7 col-md-7 col-sm-12 col-12 text-left px-0 t-life">
                                    <h6 class="text-uppercase font__weight-900">
                                        <asp:Label ID="txtUserName" runat="server"></asp:Label>
                                    </h6>
                                    <p class="mb-0 color-grey">
                                        <asp:Label ID="Dept" runat="server"></asp:Label>
                                        <asp:Label ID="Position" runat="server"></asp:Label>
                                    </p>
                                    <hr />
                                    <p class="mb-0">
                                        <span class="font__weight-900">Emp ID:</span> <span class=" color-grey">
                                            <asp:Label ID="EmpID" runat="server"></asp:Label></span>
                                    </p>
                                </div>
                                <div class="col-12 p-0">
                                    <div class="collapse mt-2" id="collapseProfile">
                                        <div class="card card-body p-2">
                                            <a class="external__link" href="#" data-toggle="modal" data-target="#sendemailhr" id="sendmail">
                                                <span class="btn__link-app-sm2 float-right rounded-circle text-center" data-toggle="tooltip" title="Request to change invalid information" data-placement="right"><i class="fas fa-envelope"></i></span>
                                            </a>

                                            <a class="external__link" href="#" data-toggle="modal" data-target="#editEmp" id="empEdit">
                                                <span class="btn__link-app-sm float-right rounded-circle text-center" data-toggle="tooltip" title="Edit profile" data-placement="right"><i class="fas fa-pencil-alt"></i></span>
                                            </a>

                                            <p class="mb-0">
                                                <span class='font__weight-900'>Start working:</span> <span class=" color-grey">
                                                    <asp:Label ID="empStartWorking" runat="server"></asp:Label></span>
                                            </p>
                                            <p class="mb-0">
                                                <span class="font__weight-900">Employee type:</span> <span class=" color-grey">
                                                    <asp:Label ID="empType" runat="server"></asp:Label></span>
                                            </p>
                                            <p class="mb-0">
                                                <span class='font__weight-900'>Workplace:</span> <span class=" color-grey">
                                                    <asp:Label ID="empWorkPlace" runat="server"></asp:Label></span>
                                            </p>
                                            <p class="mb-0">
                                                <span class="font__weight-900">Nickname:</span> <span class=" color-grey">
                                                    <asp:Label ID="empNickName" runat="server"></asp:Label></span>
                                            </p>
                                            <p class="mb-0">
                                                <span class="font__weight-900">Birthday:</span> <span class=" color-grey">
                                                    <asp:Label ID="empBirthday" runat="server"></asp:Label></span>
                                            </p>
                                            <p class="mb-0">
                                                <span class="font__weight-900">Age:</span> <span class=" color-grey">
                                                    <asp:Label ID="EmpAge" runat="server"></asp:Label></span>
                                            </p>
                                            <p class="mb-0">
                                                <span class="font__weight-900">Phone/Mobile:</span> <span class=" color-grey">
                                                    <asp:Label ID="empPhone" runat="server"></asp:Label></span>
                                            </p>
                                            <p class="mb-0">
                                                <span class="font__weight-900">LineID:</span> <span class=" color-grey">
                                                    <asp:Label ID="empLine" runat="server"></asp:Label></span>
                                            </p>
                                            <p class="mb-0">
                                                <span class="font__weight-900">Facebook:</span> <span class=" color-grey">
                                                    <asp:Label ID="empFacebook" runat="server"></asp:Label></span>
                                            </p>
                                        </div>
                                    </div>
                                </div>

                                <div class="col-12 text-center mt-2">
                                    <a data-toggle="collapse" href="#collapseProfile" role="button" aria-expanded="false" aria-controls="collapseProfile">
                                        <span class="btn-link slide-to-top toggleBlock">MORE</span>
                                    </a>
                                </div>                                
                            </div>
                        </div>
                        <div class="col-12 mt-3 pb-3 line-dashed">
                            <div class="row">
                                <div class="col-12 text-center">
                                    <asp:PlaceHolder ID="PhNotCheckin" runat="server" Visible="false">
                                        <div id="PNotCheckin">
                                            <button id="btncheckin" type="button" class="btn btn-warning col-12 p-2"><i class="fas fa-calendar-alt"></i> <span class=" font-size-13">Check-in</span></button>
                                        </div>
                                    </asp:PlaceHolder>

                                    <asp:PlaceHolder ID="PhCheckin" runat="server" Visible="false">
                                        <button type="button" class="btn btn-success col-12 p-2 text-weight-bold" disabled><i class="fas fa-calendar-check"></i> <span class=" font-size-13">Today Already Check-in</span></button>
                                    </asp:PlaceHolder>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 mt-3 pb-3 line-dashed">
                            <div class="row">
                                <div class="col-6 border-right text-center pl-0">
                                    <p class="text-uppercase font__weight-900"><i class="fas fa-umbrella-beach fa-3x pr-3"></i>Vacation</p>
                                    <h1 class="d-inline text-highlight text-weight-bold color-green ">
                                        <asp:Label ID="AnnualLeave" runat="server"></asp:Label></h1>
                                    <p class="d-inline font-size-11">/<asp:Label ID="TotalAnnualLeave" runat="server"></asp:Label><span class="ml-1">days</span></p>
                                </div>
                                <div class="col-6 text-center pr-0">
                                    <p class="text-uppercase font__weight-900"><i class="fas fa-thermometer-three-quarters fa-3x pr-3"></i>Sick Leave</p>
                                    <h1 class="d-inline text-highlight text-weight-bold color-green">
                                        <asp:Label ID="SickLeave" runat="server"></asp:Label></h1>
                                    <p class="d-inline font-size-11">/<asp:Label ID="TotalSickLeave" runat="server"></asp:Label><span class="ml-1">days</span></p>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 mt-3 pb-3 line-dashed">
                            <div class="row">
                                <div class="col-12 p-0">
                                    <p class="text-uppercase font__weight-900"><span class="color-red">New Employee</span><i class="font-size-18 fas fa-user-plus pl-2"></i></p>
                                    <asp:Repeater ID="ImgNewEmp" runat="server">
                                        <ItemTemplate>
                                            <img src='<%#Eval("ImgPath") %>' class="rounded-circle p-1 img__people-emp" data-html="true" data-toggle='tooltip' title='<%#Eval("FirstName") %> <%#Eval("LastName") %> <br/> ( <%#Eval("Position") %> : <%#Eval("Center") %> )'>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                        <div class="col-12 mt-3 pb-3">
                            <div class="row">
                                <div class="col-12 p-0">
                                    <p class="text-uppercase font__weight-900"><span class="color-red">Birthday</span><i class="font-size-18 fa fa-birthday-cake pl-2"></i></p>
                                    <asp:Repeater ID="ImgBirthDay" runat="server">
                                        <ItemTemplate>
                                            <img src='<%#Eval("ImgPath") %>' class="rounded-circle p-1 img__people-emp" data-toggle='tooltip' title='<%#Eval("FirstName") %> <%#Eval("LastName") %> <%#Eval("BirthDate","{0:dd/MM/yyyy}") %>' />
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="col-lg-8 col-md-12 col-sm-12 col-12">
                    <div class="mt-0 mb-5 border block__announcement p-0 rounded overflow-hidden">
                        <%--<h1>All HQ Staff</h1>
                        <p>Please find the announcement from Maleenont Tower as 1st attached for your information.</p>
                        <p>Please note there is nothing serious and all is the same on what we have the policy on hygiene matter.</p>
                        <div class="float-right">
                            <a class="btn btn-primary" href="#"><i class="fas fa-link"></i></a>
                            <a class="btn btn-success" href="#"><i class="fas fa-cloud-download-alt"></i></a>
                        </div>--%>
                        <asp:Image ID="ImgHilight" runat="server" style="width:100%; cursor:pointer;" />
                    </div>

                    <div class="col-12">
                        <div class="row">
                            <div class='col-lg-4 col-md-4 col-sm-4 col-4 p-0 block__apps'>
                                <a href="<%=ResolveUrl("~/RequestTimeOff") %>">
                                    <div class='p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2'>
                                        <div class='row'>
                                            <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-left text-center icon-apps mb-2'>
                                                <i class="fas fa-clock fa-2x"></i>
                                            </div>
                                            <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-left text-center'>
                                                <h6 class="font__weight-900">Request Time Off</h6>
                                                <p class='mb-0 d-lg-block d-md-block d-sm-block d-none'>Request time off and check your balances.</p>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class='col-lg-4 col-md-4 col-sm-4 col-4 p-0 block__apps'>
                                <a href="<%=ResolveUrl("~/CompanyDirectory") %>">
                                    <div class='p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2'>
                                        <div class='row'>
                                            <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-left text-center icon-apps mb-2'>
                                                <i class="fas fa-building fa-2x"></i>
                                            </div>
                                            <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-left text-center'>
                                                <h6 class="font__weight-900">Company Directory</h6>
                                                <p class='mb-0 d-lg-block d-md-block d-sm-block d-none'>Communication, Announcement, Organizational Chart and Circular, PH.</p>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class='col-lg-4 col-md-4 col-sm-4 col-4 p-0 block__apps'>
                                <a href="<%=ResolveUrl("~/Benefits") %>">
                                    <div class='p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2'>
                                        <div class='row'>
                                            <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-left text-center icon-apps mb-2'>
                                                <i class="fa fa-heartbeat  fa-2x"></i>
                                            </div>
                                            <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-left text-center'>
                                                <h6 class="font__weight-900">Benefits</h6>
                                                <p class='mb-0 d-lg-block d-md-block d-sm-block d-none'>Insurance Plan, Benefits Policy, Transportation Chart and Payslip Online.</p>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class='col-lg-4 col-md-4 col-sm-4 col-4 p-0 block__apps'>
                                <a href="<%=ResolveUrl("~/Training") %>">
                                    <div class='p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2'>
                                        <div class='row'>
                                            <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-left text-center icon-apps mb-2'>
                                                <i class="fab fa-leanpub fa-2x"></i>
                                            </div>
                                            <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-left text-center'>
                                                <h6 class="font__weight-900">Training</h6>
                                                <p class='mb-0 d-lg-block d-md-block d-sm-block d-none'>Training Calendar, Training Plan/Register and Percent of Training.</p>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class='col-lg-4 col-md-4 col-sm-4 col-4 p-0 block__apps'>
                                <a href="<%=ResolveUrl("~/Goals") %>">
                                    <div class='p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2'>
                                        <div class='row'>
                                            <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-left text-center icon-apps mb-2'>
                                                <i class="fa fa-flag-checkered fa-2x"></i>
                                            </div>
                                            <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-left text-center'>
                                                <h6 class="font__weight-900">Goals</h6>
                                                <p class='mb-0 d-lg-block d-md-block d-sm-block d-none'>Target and KPI.</p>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                            <div class='col-lg-4 col-md-4 col-sm-4 col-4 p-0 block__apps'>
                                <a href="<%=ResolveUrl("~/Point") %>">
                                    <div class='p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2'>
                                        <div class='row'>
                                            <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-left text-center icon-apps mb-2'>
                                                <i class="fas fa-medal fa-2x"></i>
                                            </div>
                                            <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-left text-center'>
                                                <h6 class="font__weight-900">Point</h6>
                                                <p class='mb-0 d-lg-block d-md-block d-sm-block d-none'>Recognition Program.</p>
                                            </div>
                                        </div>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <div class="modal fade bd-example-modal-lg" id="sendemailhr" tabindex="-1" role="dialog" aria-labelledby="sendemailhr" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h5 class="modal-title">Send Request to change invalid information</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <!-- Modal Body -->
                <div class="modal-body">
                    <label for="name">Message<span class="text-secondary px-1 font-size-11">(Max 500)</span>:</label>
                    <div class="input-group">
                        <textarea id="txtDetail" Rows="8" class="form-control" aria-label="With textarea" maxlength="500"></textarea>
                        <div class="input-group-prepend">
                        <span class="input-group-text rounded-right">Max 500</span>
                        </div>
                    </div>

                </div>

                <!-- Modal Footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        Close
                    </button>
                    <button type="button" class="btn btn-primary" id="submitmail">
                        <i class="fas fa-paper-plane pr-1"></i>Send
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal modal-wide fade" id="editEmp" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <!-- Modal Header -->
                <div class="modal-header">
                    <h5 class="modal-title">Employee Details</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>

                <!-- Modal Body -->
                <div class="modal-body">
                    <div class="form-group row">
                        <label for="NickName" class="col-sm-2 col-form-label">NickName</label>
                        <div class="col-sm-10">
                            <input type="text" name="NickName" id="NickName" class="form-control" value="">
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="Phone" class="col-sm-2 col-form-label">Phone</label>
                        <div class="col-sm-10">
                            <input type="text" name="Phone" id="Phone" class="form-control" value="">
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="LineID" class="col-sm-2 col-form-label">LineID</label>
                        <div class="col-sm-10">
                            <input type="text" name="LineID" id="LineID" class="form-control" value="">
                        </div>
                    </div>

                    <div class="form-group row">
                        <label for="FacebookID" class="col-sm-2 col-form-label">Facebook</label>
                        <div class="col-sm-10">
                            <input type="text" name="FacebookID" id="FacebookID" class="form-control" value="">
                        </div>
                    </div>
                </div>

                <!-- Modal Footer -->
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">
                        Close
                    </button>
                    <button type="button" class="btn btn-primary" data-dismiss="modal" id="submit">
                        <i class="far fa-save pr-1"></i>Save changes
                    </button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade bd-example-modal-xl" id="ContentModel" tabindex="-1" role="dialog" aria-labelledby="ContentModelLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ContentModelLabel"><span id="LitTitle"></span></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="resultDetail">
                    <div id="rpicture" class="img__organization">
                        <img id="imgpic" />
                    </div><br />
                    <div id="rdetail" class="fonthilightdetail"></div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <section class=" mt-5">
        <div class="container py-5 position-relative">
            <img id="imgMascot" src="<%=ResolveClientUrl("~/images/mascot/woman-stand-up.png")%>" class="mascot__woman-home d-lg-block d-md-block d-sm-none d-none" data-container="body" data-toggle="popover" data-placement="left" data-content="Check in today get 5 points!."/>
            <h2 class=" text-uppercase font-weight-bold mb-5 block__head">wse applications</h2>
            <div class="row">
                <asp:Repeater ID="RptWseApps" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-3 col-md-6 col-sm-6 col-6 p-2">
                            <a href="<%#Eval("App_ApplicationLink") %>" target="_blank">
                                <div class="p-4 col-12 favorite app-fav slide-to-bottom">
                                    <div class="row">
                                        <div class="col-lg-12 col-md-12 col-sm-12 col-12 text-center">
                                            <i class="<%#Eval("App_icon") %> font-size-18"></i>
                                            <h6 class="text-uppercase mt-3"><%#Eval("App_ApplicationName") %></h6>
                                            <p class="mb-0"><%#Eval("app_Detail") %></p>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>

        <asp:HiddenField ID="HdnUsername" runat="server" />
    </section>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#home').addClass("active");
            setTimeout(function () {
                $('#imgMascot').popover({
                    offset: '-100px -20px'
                }).popover('show')
            }, 2000);

            setTimeout(function () {
                $('#imgMascot').popover('hide');
            }, 10000);
        });

        $('#collapseProfile').on('hide.bs.collapse', function () {
            $('span.toggleBlock').html("more");
        });

        $('#collapseProfile').on('show.bs.collapse', function () {
            $('span.toggleBlock').html("less");
        });

        $('#empEdit').click(function () {
            var NickName = document.getElementById('<%=empNickName.ClientID%>').innerHTML;
            var Phone = document.getElementById('<%=empPhone.ClientID%>').innerHTML;
            var LineID = document.getElementById('<%=empLine.ClientID%>').innerHTML;
            var FacebookID = document.getElementById('<%=empFacebook.ClientID%>').innerHTML;
            document.getElementById('NickName').value = NickName.toString();
            document.getElementById('Phone').value = Phone.toString();
            document.getElementById('LineID').value = LineID.toString();
            document.getElementById('FacebookID').value = FacebookID.toString();
        });

        $('#submitmail').click(function () {
            var Username = document.getElementById("<%=HdnUsername.ClientID%>").value;
            var detail = document.getElementById("txtDetail").value;
            var EmployeeID = document.getElementById('<%=EmpID.ClientID%>').innerHTML;

            swal({
                title: "Confirm Send E-Mail?",
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
                        $.ajax({
                            type: "POST",
                            url: '<%= ResolveUrl("Home.aspx/SendEMailHR") %>',
                            data: "{ 'Detail': '" + detail + "', 'EmployeeID': '" + EmployeeID + "', 'Username': '" + Username + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                var message = data.d;

                                if (message == "success") {
                                    swal({
                                        title: "Send E-Mail to HR Success.",
                                        text: "",
                                        type: "success"
                                    }, function () {
                                            document.getElementById("txtDetail").value = "";

                                            $('#sendemailhr').modal('toggle');
                                    });
                                }
                                else if (message == "already checkin") {
                                    swal("Today already check-in", "", "error");
                                }
                                else {
                                    swal({
                                        title: "Alert!",
                                        text: data.d
                                    });
                                }
                            },
                            error: function () {
                                swal("Please contact IT!!!!!", "", "error");
                            }
                        });
                    }
                    else {
                        swal("Cancelled", "", "error");
                    }
                });
        });

        $("#txtDetail").keyup(function () {
            var Note = document.getElementById('txtDetail').value;

            var note_length = Note.length;

            var remain = 500 - note_length;

            if (remain == "500") {
                document.getElementById("txt_count").innerHTML = "Max " + remain;
            }
            else {
                document.getElementById("txt_count").innerHTML = remain;
            }
        });

        $('#<%= ImgHilight.ClientID %>').click(function () {
            var src = $(this).attr("src");
            var title = $(this).attr("title");
            var detail = $(this).attr("detail");

            if (!src.includes("nohilight.png")) {
                $("#imgpic").attr("src", src);
                document.getElementById("LitTitle").innerHTML = title;
                document.getElementById("rdetail").innerHTML = detail;

                $('#ContentModel').modal('toggle');
            }
        });

        $('#submit').click(function () {
            var NickName = $('input[name="NickName"]').val();
            var Phone = $('input[name="Phone"]').val();
            var LineID = $('input[name="LineID"]').val();
            var FacebookID = $('input[name="FacebookID"]').val();
            var EmployeeID = document.getElementById('<%=EmpID.ClientID%>').innerHTML;
            $.ajax({
                type: "POST",
                url: '<%= ResolveUrl("Home.aspx/editEmployeeDatials") %>',
                data: "{ 'NickName': '" + NickName + "', 'Phone': '" + Phone + "', 'LineID': '" + LineID + "', 'FacebookID': '" + FacebookID + "', 'EmployeeID': '" + EmployeeID + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    //alert(response['response']);
                    $('.modal').each(function () {
                        $(this).modal('hide');
                    });
                    if (data.d === 'true') {
                        window.location = "<%= ResolveUrl("~/Home") %>";
                    } else if (data.d === 'false') {
                        swal("Error message!", "Incomplete data record")
                    }
                    console.log(data);
                },
                error: function () {
                    alert('Error');
                }
            });
            return false;
        });

        function setInputFilter(textbox, inputFilter) {
            ["input", "keydown", "keyup", "mousedown", "mouseup", "select", "contextmenu", "drop"].forEach(function (event) {
                textbox.addEventListener(event, function () {
                    if (inputFilter(this.value)) {
                        this.oldValue = this.value;
                        this.oldSelectionStart = this.selectionStart;
                        this.oldSelectionEnd = this.selectionEnd;
                    } else if (this.hasOwnProperty("oldValue")) {
                        this.value = this.oldValue;
                        this.setSelectionRange(this.oldSelectionStart, this.oldSelectionEnd);
                    } else {
                        this.value = "";
                    }
                });
            });
        }
        setInputFilter(document.getElementById("Phone"), function (value) {
            return /^-?\d*$/.test(value);
        });

        $("#btncheckin").click(function () {
            $.ajax({
                url: '<%=ResolveUrl("Home.aspx/Checkin") %>',
                data: "{ }",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var message = data.d;

                    if (message == "success") {
                        document.getElementById("PNotCheckin").innerHTML = "";

                        var btn = document.createElement("button");
                        btn.setAttribute("class", "checkin btn btn-success col-12 p-2 text-weight-bold");
                        btn.setAttribute("type", "button");
                        btn.setAttribute("disabled", "disabled");
                        btn.innerHTML = '<i class="fas fa-calendar-check"></i> <span class=" font-size-13">Today Already Check-in</span>';

                        document.getElementById("PNotCheckin").appendChild(btn);

                        swal({
                            title: "Success!",
                            text: "",
                            type: "success"
                        }, function () {
                        });
                    }
                    else if (message == "already checkin") {
                        swal("Today already check-in", "", "error");
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
        });

        function CountChar(text, long) {
            var itm = $("textarea[id$='" + text + "']");
            var maxlength = parseInt(long, 10); // Change number to your max length.

            if (parseInt($(itm).val().length, 10) > maxlength) {
                $(itm).val($(itm).val().substring(0, maxlength));
                alert(" Only " + long + " chars");
                itm.focus();
                return false;
            }
            return true;
        }
    </script>
</asp:Content>
