<%@ Page Language="C#" AutoEventWireup="true" CodeFile="calendar.aspx.cs" Inherits="CMSView_calendar" MasterPageFile="~/MasterPage/CMSMasterPage.Master" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="cphHead" runat="server">
    <script src="<%= ResolveClientUrl("~/Scripts/jquery-ui-1.12.1.custom/jquery-ui.min.js") %>"></script>
    <link href="<%= ResolveClientUrl("~/Scripts/jquery-ui-1.12.1.custom/jquery-ui.min.css") %>" rel="stylesheet" />
    <link href="<%= ResolveClientUrl("~/Content/fullcalendar.css") %>" rel="stylesheet" />
    <script src="<%= ResolveClientUrl("~/Scripts/moment.min.js") %>"></script>
    <script src="<%= ResolveClientUrl("~/Scripts/fullcalendar.min.js") %>"></script>
    <link href="<%= ResolveClientUrl("~/css/_calendar.css") %>" rel="stylesheet" />
    <link href="<%=ResolveClientUrl("~/css/bootstrap.min.css")%>" rel="stylesheet">
    <script src="<%=ResolveClientUrl("~/Scripts/bootstrap/bootstrap.min.js")%>"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            resize();

            $("#<%=TxtStartDate.ClientID%>").datepicker({
                changeMonth: true,
                changeYear: true,
                dateFormat: 'dd/mm/yy',
            }).datepicker("setDate", "<%=DefaultDateStartDate %>").attr('readOnly', 'true');
        });

        function createcalendar(ev) {
            $('#calendar').fullCalendar({
                buttonText: {
                    today: 'Today',
                    month: 'Month',
                    listDay: 'List Day',
                    listWeek: 'List Week',
                    listMonth: 'List Month'
                },
                header: {
                    left: 'prev,next today',
                    center: 'title',
                    right: 'month,listMonth,listWeek,listDay'
                },
                editable: false,
                theme: true,
                firstDay: 1,
                minTime: "10:00:00",
                eventLimit: true,
                views: {
                    month: {
                        eventLimit: 7
                    }
                },
                droppable: false,
                drop: function () {
                    if ($('#drop-remove').is(':checked')) {
                        $(this).remove();
                    }
                },
                timeFormat: 'hh:mm A',
                events: function (start, end, timezone, callback) {
                    var room = document.getElementById('<%=DdlRoom.ClientID%>').value;

                    var start = new Date(start);
                    var startmonth = start.setMonth(start.getMonth() + 1);

                    var end = new Date(end);
                    var enddate = end.setDate(end.getDate() - 1);
                    var endmonth = end.setMonth(end.getMonth() + 1);

                    var sMonth = "";
                    var sYear = "";
                    if (start.getMonth() == "0") {
                        sMonth = "12";
                        sYear = start.getFullYear() - 1;
                    }
                    else {
                        sMonth = start.getMonth();
                        sYear = start.getFullYear();
                    }

                    var eMonth = "";
                    var eYear = "";
                    if (end.getMonth() == "0") {
                        eMonth = "12";
                        eYear = end.getFullYear() - 1;
                    }
                    else {
                        eMonth = end.getMonth();
                        eYear = end.getFullYear();
                    }

                    $.ajax({
                        type: 'POST',
                        url: '<%= ResolveUrl("calendar.aspx/LoadCalendar") %>',
                        contentType: 'application/json; charset=utf-8',
                        dataType: 'json',
                        data: "{ 'from': '" + sYear + "-" + sMonth + "-" + start.getDate() + "', 'to':'" + eYear + "-" + eMonth + "-" + end.getDate() + "', 'room': '" + room + "'}",
                        error: function (XMLHttpRequest, textStatus, errorThrown) {
                            alert("Request: " + JSON.stringify(XMLHttpRequest).toString() + "\n\nStatus: " + textStatus + "\n\nError: " + errorThrown);
                        },
                        success: function (results) {
                            var events = [];
                            $.each(results.d, function (key, value) {
                                events.push({
                                    id: value.id,
                                    cid: value.cid,
                                    title: value.title,
                                    start: value.start,
                                    end: value.end,
                                    timestart: value.timestart,
                                    timeend: value.timeend,
                                    backgroundColor: value.backgroundColor,
                                    borderColor: value.border_color,
                                    creator: value.creator,
                                    room: value.Room,
                                    HRCalendar: value.HRCalendar,
                                });
                            });
                            callback(events);
                        }
                    });
                },
                eventMouseover: function (event, jsEvent) {
                },
                eventRender: function (event, element, view) {
                    element.find('.fc-content').each(function () {
                        $(this).children('span:nth-child(2)').insertBefore($(this).children('span:nth-child(2)').prev('.fc-time'));
                        element.find(".fc-title").append("<br/>");

                        $(this).children('span:nth-child(2)').closest("div").addClass("fc-content text-dark");

                        element.find(".fc-title").prepend("<div class='circlewhite'></div>");

                        element.find(".fc-time").text("");

                        var time = "All Day";
                        if (event.timestart != "00:00") {
                            time = event.timestart;
                        }

                        if (event.timeend != "00:00 AM") {
                            time += " - " + event.timeend;
                        }

                        element.find(".fc-time").append(time);

                        var s = element.find(".fc-time").text();
                        if (s == "") {
                            element.find(".fc-content").append("<span class='fc-time'>" + time + "</span>");
                            $(this).children('span:nth-child(2)').closest("div").addClass("fc-content text-dark");
                        }

                        element.find(".fc-content").append("<p class='fc-room'><b>Room: </b>" + event.room + "</p>");
                    });

                    if (event.title) {
                        element.find(".fc-list-item-title").text("");
                        element.find(".fc-list-item-title").append("<b>" + event.title + "</b>");
                    }

                    if (event.room) {
                        element.find(".fc-list-item-title").append("<p class='fc-room'><b>Room: </b>" + event.room + "</p>");
                    }
                },
                eventClick: function (calEvent, jsEvent, view) {
                    $("#<%=HdnCID.ClientID%>").val(calEvent.cid);

                    $("#btnaddattendee").removeClass("d-none");
                    $("#<%=PnAddAttendee.ClientID%>").addClass("d-none");

                    GetData(calEvent.cid, "");
                },
                windowResize: function (view) {
                    var h = $(".fc-day-grid").outerHeight();

                    var minh = "800";

                    if (h === undefined) {
                        h = $(".fc-list-table").outerHeight();

                        if (h < minh) {
                            h = minh;
                        }

                        if (h === undefined) {
                            h = minh;
                        }

                        $(".fc-scroller").attr("style", "height: " + h + "px;");
                    }
                    else {
                        $(".fc-scroller").attr("style", "height: " + h + "px;");
                        $(".fc-row.ui-widget-header").attr("style", "");
                    }
                }
            });
        }

        function GetData(cid, t) {
            $.ajax({
                url: '<%=ResolveUrl("calendar.aspx/GetData") %>',
                data: "{ 'ID': '" + cid + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var obj = JSON.parse(data.d);

                    document.getElementById('<%=LitSubject.ClientID%>').innerText = obj.title;
                    document.getElementById('<%=LitRoom.ClientID%>').innerText = obj.Room;
                    document.getElementById('<%=LitStartDate.ClientID%>').innerText = obj.start;
                    document.getElementById('<%=LitEndDate.ClientID%>').innerText = obj.end;
                    document.getElementById('<%=LitCreator.ClientID%>').innerText = obj.creator;

                    var HR = obj.HRCalendar;
                    if (HR === "True") {
                        $("#btnaddattendee").removeClass("d-none");
                        $("#btndelete").removeClass("d-none");
                    }
                    else {
                        $("#btnaddattendee").addClass("d-none");
                        $("#btndelete").addClass("d-none");
                    }
                    
                    document.getElementById("attendeetable").innerHTML = "";
                    $('#attendeetable').append(obj.attendee);

                    if (t == "") {
                        $('#detailcalendar').modal('toggle');
                    }
                },
                error: function (response) {
                },
                failure: function (response) {
                }
            });
        }
    </script>

    <style>
        .validate_error {
            background-color: #f8dbdd !important;
            border: 1px solid #f4acad !important;
        }
    </style>
</asp:Content>

<asp:Content ID="BodyConntent" ContentPlaceHolderID="cphBody" runat="server">
    <section>
        <div class="container py-5">
            <h3 class="text-uppercase mb-5 font-weight-bold text-lg-left text-md-left text-sm-left text-center block__head">calendar</h3>
            <div class="row">
                <div class="col-12">
                    <div class="row">
                        <div class="col-lg-6 col-md-6 col-sm-12 col-12">
                            <label for="DdlRoom">Room</label>
                            <div class="input-group mb-3">
                                <asp:DropDownList ID="DdlRoom" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="==== ALL ====" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Creation" Value="Creation"></asp:ListItem>
                                    <asp:ListItem Text="Inspiration" Value="Inspiration"></asp:ListItem>
                                    <asp:ListItem Text="Motivation" Value="Motivation"></asp:ListItem>
                                    <asp:ListItem Text="Imagination" Value="Imagination"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12 col-12 mt-lg-2 mt-md-2 mt-sm-0 mt-0 pt-lg-4 pt-md-4 pt-sm-0 pt-0 text-lg-left text-md-left text-sm-right text-right">
                            <button id="btnSearch" type="button" class="btn btn-secondary">Submit</button>
                        </div>
                    </div>
                    <hr />
                </div>

                <div class="col-12 form-group text-right">
                    <button id="BtnCreateClass" type="button" class="btn btn-success" data-toggle="modal" data-target="#createcalendar">
                        <i class="fas fa-plus pr-1"></i>Create
                    </button>
                </div>

                <div class="col-12">
                    <div id="ibox">
                        <div id="calendar"></div>
                    </div>
                </div>
            </div>
        </div>

        <!-- Modal -->
        <div class="modal fade" id="createcalendar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel"><span id="TypeTitle"></span>Create Calendar</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="DdlClassType" class="txt__required">Room</label>
                                        <asp:DropDownList ID="DdlRoomCreate" runat="server" CssClass="form-control">
                                            <asp:ListItem Text="==== Please Select ====" Value=""></asp:ListItem>
                                            <asp:ListItem Text="Creation" Value="Creation"></asp:ListItem>
                                            <asp:ListItem Text="Inspiration" Value="Inspiration"></asp:ListItem>
                                            <asp:ListItem Text="Motivation" Value="Motivation"></asp:ListItem>
                                            <asp:ListItem Text="Imagination" Value="Imagination"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="DdlClassType" class="txt__required">Subject</label>
                                        <asp:TextBox ID="TxtSubject" runat="server" CssClass="form-control" MaxLength="50"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-lg-4 col-md-4 col-sm-12 col-12">
                                    <div class="form-group">
                                        <label for="TxtStartDate" class="txt__required">Start Date</label>
                                        <asp:TextBox ID="TxtStartDate" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-6 col-12">
                                    <div class="form-group">
                                        <label for="TxtEndDate" class="txt__required">Start Date</label>
                                        <asp:DropDownList ID="DdlStartTime" runat="server" CssClass="form-control" DataValueField="Time_slot" DataTextField="Time_slot">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                                <div class="col-lg-4 col-md-4 col-sm-6 col-12">
                                    <div class="form-group">
                                        <label for="DdlEndTime" class="txt__required">End Time</label>
                                        <asp:DropDownList ID="DdlEndTime" runat="server" CssClass="form-control" DataValueField="Time_slot" DataTextField="Time_slot">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:LinkButton ID="btnsubmitc" runat="server" CssClass="btn btn-success"  OnClientClick="return false;"><i class="far fa-save pr-1" ></i>Create</asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal fade" id="detailcalendar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="DetailModalLabel"><span id="DetailTitle"></span>Class</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="col-sm-12">
                            <asp:HiddenField ID="HdnCID" runat="server" />
                            <div class="row">
                                <div class="col-12">
                                    <h6 class="d-inline-block mr-2 font-weight-bold">Subject:</h6>
                                    <h6 class="d-inline-block mr-2"><asp:Label ID="LitSubject" runat="server"></asp:Label></h6>
                                </div>
                                 <div class="col-12">
                                    <h6 class="d-inline-block mr-2 font-weight-bold">Room:</h6>
                                    <h6 class="d-inline-block mr-2"><asp:Label ID="LitRoom" runat="server"></asp:Label></h6>
                                </div>
                                 <div class="col-12">
                                    <h6 class="d-inline-block mr-2 font-weight-bold">Start:</h6>
                                    <h6 class="d-inline-block mr-2"><asp:Label ID="LitStartDate" runat="server"></asp:Label></h6>
                                </div>
                                 <div class="col-12">
                                    <h6 class="d-inline-block mr-2 font-weight-bold">End:</h6>
                                    <h6 class="d-inline-block mr-2"><asp:Label ID="LitEndDate" runat="server"></asp:Label></h6>
                                </div>
                                <div class="col-12">
                                    <h6 class="d-inline-block mr-2 font-weight-bold">Creator:</h6>
                                    <h6 class="d-inline-block mr-2"><asp:Label ID="LitCreator" runat="server"></asp:Label></h6>
                                </div>

                                <asp:HiddenField ID="HdnHR" runat="server" />

                                <div id="attendeetable" class="col-md-12 mt-2">
                                </div>

                                <asp:Panel ID="addattendee" runat="server" CssClass="col-md-12 text-right my-2 pr-0">
                                    <button id="btnaddattendee" type="button" class="btn btn-success"><i class="fas fa-plus pr-1" ></i>Add Attendee</button>
                                </asp:Panel>

                                <asp:Panel ID="PnAddAttendee" runat="server" CssClass="col-sm-12">
                                    <div class="row mt-1">
                                        <div class="col-sm-12">
                                            <h5 class="border-bottom">Add Attendee</h5>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12">
                                            <div class="form-group">
                                                <label for="Email">Email:</label>
                                                <br />
                                                <asp:TextBox ID="TxtEmail" runat="server" style="width:100%;" placeholder="Enter email addresses"></asp:TextBox>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="row">
                                        <div class="col-sm-12" style="text-align: center;">
                                            <asp:LinkButton ID="btnbook" runat="server" CssClass="btn btn-success" OnClientClick="return false;"><i class="fas fa-paper-plane pr-1"></i>Invite</asp:LinkButton>

                                        </div>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <button id="btndelete" type="button" class="btn btn-danger mr-auto"><i class="fas fa-trash-alt pr-1" ></i>Delete Meeting</button>
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
        <asp:HiddenField ID="HdnStaffName" runat="server" />
        <asp:HiddenField ID="HdnEmail" runat="server" />
    </section>
</asp:Content>

<asp:Content ID="FooterContent" ContentPlaceHolderID="cphFooter" runat="server">
    <script src="<%= ResolveClientUrl("~/Scripts/sweetalert.min.js") %>"></script>
    <script src="<%= ResolveClientUrl("~/Scripts/jquery.blockUI.js") %>"></script>
    <script src="<%=ResolveClientUrl("~/Scripts/_cms.js")%>"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#training').addClass("active");
        });

        $("#btnSearch").click(function () {
            document.getElementById("ibox").innerHTML = "";

            var div = document.getElementById('ibox');

            div.innerHTML = "<div id='calendar'></div>";

            createcalendar(1);
            resize();
        });

        $("#BtnCreateClass").click(function () {
            document.getElementById('<%=DdlRoomCreate.ClientID%>').value = "";
            document.getElementById('<%=TxtSubject.ClientID%>').value = "";
            document.getElementById('<%=DdlStartTime.ClientID%>').value = "";
            document.getElementById('<%=DdlEndTime.ClientID%>').value = "";
        });

        $("#<%=btnsubmitc.ClientID%>").click(function () {
            var Room = document.getElementById('<%=DdlRoomCreate.ClientID%>').value;
            var Subject = document.getElementById('<%=TxtSubject.ClientID%>').value;

            var StartDate = document.getElementById('<%=TxtStartDate.ClientID%>').value;

            var StartTime = document.getElementById('<%=DdlStartTime.ClientID%>').value;
            var EndTime = document.getElementById('<%=DdlEndTime.ClientID%>').value;

            if (Room == "") {
                $("#<%=DdlRoomCreate.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=DdlRoomCreate.ClientID%>").removeClass("validate_error");
            }

            if (Subject == "") {
                $("#<%=TxtSubject.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=TxtSubject.ClientID%>").removeClass("validate_error");
            }

            if (StartTime == "") {
                $("#<%=DdlStartTime.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=DdlStartTime.ClientID%>").removeClass("validate_error");
            }

            if (EndTime == "") {
                $("#<%=DdlEndTime.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=DdlEndTime.ClientID%>").removeClass("validate_error");
            }

            if (Room != "" && Subject != "" && StartTime != "" && EndTime != "" && StartDate != "") {
                sweetwarning(Room, Subject, StartTime, EndTime, StartDate);
            }
        });

        $("#<%=DdlRoomCreate.ClientID%>").change(function () {
            checkcalendar();

            var Room = document.getElementById('<%=DdlRoomCreate.ClientID%>').value;

            if (Room == "") {
                $("#<%=DdlRoomCreate.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=DdlRoomCreate.ClientID%>").removeClass("validate_error");
            }
        });

        $("#<%=TxtSubject.ClientID%>").keyup(function () {
            var Subject = document.getElementById('<%=TxtSubject.ClientID%>').value;

            if (Subject == "") {
                $("#<%=TxtSubject.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=TxtSubject.ClientID%>").removeClass("validate_error");
            }
        });

        $("#<%=TxtStartDate.ClientID%>").change(function () {
            checkcalendar();
        });

        $("#<%=DdlStartTime.ClientID%>").change(function () {
            checkcalendar();

            var StartTime = document.getElementById('<%=DdlStartTime.ClientID%>').value;

            if (StartTime == "") {
                $("#<%=DdlStartTime.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=DdlStartTime.ClientID%>").removeClass("validate_error");
            }
        });

        $("#<%=DdlEndTime.ClientID%>").change(function () {
            checkcalendar();

            var EndTime = document.getElementById('<%=DdlEndTime.ClientID%>').value;

            if (EndTime == "") {
                $("#<%=DdlEndTime.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=DdlEndTime.ClientID%>").removeClass("validate_error");
            }
        });

        $("#<%=TxtEmail.ClientID%>").keyup(function () {
            var em = document.getElementById('<%= TxtEmail.ClientID %>').value;

            if (em == "") {
                $("#TxtEmail").addClass("validate_error");
            }
            else {
                $("#TxtEmail").removeClass("validate_error");
            }

            var filter = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            var useremail = document.getElementById('<%= TxtEmail.ClientID %>').value;
            if (!filter.test(useremail)) {
                check_email = "";
                $("#<%= TxtEmail.ClientID %>").addClass("validate_error");
            }
            else {
                check_email = "1";
                $("#<%= TxtEmail.ClientID %>").removeClass("validate_error");
            }
        });

        $("#<%=btnbook.ClientID%>").click(function () {
            var CID = document.getElementById('<%= HdnCID.ClientID %>').value;
            var em = document.getElementById('<%= TxtEmail.ClientID %>').value;

            if (em == "") {
                $("#TxtEmail").addClass("validate_error");
            }
            else {
                $("#TxtEmail").removeClass("validate_error");
            }

            var filter = /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/;
            var useremail = document.getElementById('<%= TxtEmail.ClientID %>').value;
            if (!filter.test(useremail)) {
                check_email = "";
                $("#<%= TxtEmail.ClientID %>").addClass("validate_error");
            }
            else {
                check_email = "1";
                $("#<%= TxtEmail.ClientID %>").removeClass("validate_error");
            }

            if (em == "" || check_email == "") {
                return false;
            }
            else {
                AddAttendee(em, CID);
            }
        });

        function AddAttendee(Email, CID) {
            swal({
                title: "Confirm Add Attendee?",
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

                        $.ajax({
                            url: '<%=ResolveUrl("calendar.aspx/AddAttendee") %>',
                            data: "{ 'Email': '" + Email + "', 'CID': '" + CID + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                $.unblockUI();

                                if (data.d == "true") {
                                    swal({
                                        title: "Success!",
                                        text: "",
                                        type: "success"
                                    }, function () {
                                            document.getElementById('<%=TxtEmail.ClientID%>').value = "";
                                            GetData(CID, "1")
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

                                //alert(response.responseText);
                            },
                            failure: function (response) {
                                //alert(response.responseText);
                            }
                        });
                    }
                    else {
                        swal("Cancelled", "", "error");
                    }
                });
        }

        $("#btnaddattendee").click(function () {
            $("#btnaddattendee").addClass("d-none");
            $("#<%=PnAddAttendee.ClientID%>").removeClass("d-none");
        });

        $("#btndelete").click(function () {
            var CID = document.getElementById('<%= HdnCID.ClientID %>').value;

            swal({
                title: "Confirm Delete?",
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
                            url: '<%=ResolveUrl("calendar.aspx/DeleteCalendar") %>',
                            data: "{ 'CID': '" + CID + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                $.unblockUI();

                                if (data.d == "true") {
                                    swal({
                                        title: "Success!",
                                        text: "",
                                        type: "success"
                                    }, function () {
                                        $('#detailcalendar').modal('toggle');

                                        document.getElementById("ibox").innerHTML = "";

                                        var div = document.getElementById('ibox');

                                        div.innerHTML = "<div id='calendar'></div>";
                                            createcalendar(1);
                                            resize();
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

                                //alert(response.responseText);
                            },
                            failure: function (response) {
                                //alert(response.responseText);
                            }
                        });
                    }
                    else {
                        swal("Cancelled", "", "error");
                    }
                });
        });

        function checkcalendar() {
            var Room = document.getElementById('<%=DdlRoomCreate.ClientID%>').value;

            var StartDate = document.getElementById('<%=TxtStartDate.ClientID%>').value;

            var StartTime = document.getElementById('<%=DdlStartTime.ClientID%>').value;
            var EndTime = document.getElementById('<%=DdlEndTime.ClientID%>').value;

            if (Room != "" && StartTime != "" && EndTime != "" && StartDate != "") {
                $.ajax({
                    url: '<%=ResolveUrl("calendar.aspx/CheckCalendar") %>',
                    data: "{ 'Room': '" + Room + "', 'StartDate': '" + StartDate + "', 'StartTime': '" + StartTime + "', 'EndTime': '" + EndTime + "'}",
                    dataType: "json",
                    type: "POST",
                    contentType: "application/json; charset=utf-8",
                    success: function (data) {
                        if (data.d == "true") {

                        }
                        else {
                            swal({
                                title: "Alert!",
                                text: data.d
                            });
                        }
                    },
                    error: function (response) {

                        //alert(response.responseText);
                    },
                    failure: function (response) {
                        //alert(response.responseText);
                    }
                });
            }
        }

        function sweetwarning(Room, Subject, StartTime, EndTime, StartDate) {
            swal({
                title: "Confirm Create?",
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

                        var email = document.getElementById('<%=HdnEmail.ClientID%>').value;
                        var staffname = document.getElementById('<%=HdnStaffName.ClientID%>').value;

                        $.ajax({
                            url: '<%=ResolveUrl("calendar.aspx/CreateCalendar") %>',
                            data: "{ 'Room': '" + Room + "', 'Subject': '" + Subject + "', 'StartDate': '" + StartDate + "', 'StartTime': '" + StartTime + "', 'EndTime': '" + EndTime + "', 'Email': '" + email + "', 'StaffName': '" + staffname + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                $.unblockUI();
                                if (data.d == "true") {
                                    document.getElementById("ibox").innerHTML = "";

                                    var div = document.getElementById('ibox');

                                    div.innerHTML = "<div id='calendar'></div>";
                                    createcalendar(1);
                                    resize();

                                    swal({
                                        title: "Success!",
                                        text: "",
                                        type: "success"
                                    }, function () {
                                        $('#createcalendar').modal('toggle');
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

                                //alert(response.responseText);
                            },
                            failure: function (response) {
                                //alert(response.responseText);
                            }
                        });
                    }
                    else {
                        swal("Cancelled", "", "error");
                    }
                });
        }

        function d(caid) {
            swal({
                title: "Confirm Remove?",
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

                        $.ajax({
                            url: '<%=ResolveUrl("calendar.aspx/OnDeleted") %>',
                            data: "{ 'CAID': '" + caid + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                $.unblockUI();
                                if (data.d == "true") {
                                    $("#attendee" + caid).remove();
                                    swal({
                                        title: "Success!",
                                        text: "",
                                        type: "success"
                                    }, function () {
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

                                //alert(response.responseText);
                            },
                            failure: function (response) {
                                //alert(response.responseText);
                            }
                        });

                    } else {
                        swal("Cancelled", "", "error");
                    }
                });
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

        function resize() {
            var width = window.innerWidth;

            if (width < 768) {
                $('#calendar').fullCalendar('changeView', 'listMonth');
            }
            else {
                $('#calendar').fullCalendar('changeView', 'month');
            }
        }

        window.onresize = function (event) {
            resize();
        };
    </script>
</asp:Content>
