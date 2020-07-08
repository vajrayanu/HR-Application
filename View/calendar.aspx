<%@ Page Language="C#" AutoEventWireup="true" CodeFile="calendar.aspx.cs" Inherits="calendar" MasterPageFile="../masterpage/MasterPage.Master" %>

<asp:Content ID="ContentHead" ContentPlaceHolderID="head" runat="Server">
    <script src="<%= ResolveClientUrl("~/Scripts/jquery-ui-1.12.1.custom/jquery-ui.min.js") %>"></script>
    <link href="<%= ResolveClientUrl("~/Scripts/jquery-ui-1.12.1.custom/jquery-ui.min.css") %>" rel="stylesheet" />
    <link href="<%= ResolveClientUrl("~/Content/fullcalendar.css") %>" rel="stylesheet" />
    <script src="<%= ResolveClientUrl("~/Scripts/moment.min.js") %>"></script>
    <script src="<%= ResolveClientUrl("~/Scripts/fullcalendar.min.js") %>"></script>
    <link href="<%= ResolveClientUrl("~/css/_calendar.css") %>" rel="stylesheet" />

    <link href="<%=ResolveClientUrl("~/css/bootstrap.min.css")%>" rel="stylesheet">
    <script src="<%=ResolveClientUrl("~/Scripts/bootstrap/bootstrap.min.js")%>"></script>

    <script type="text/javascript">
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
                        data: "{ 'from': '" + sYear + "-" + sMonth + "-" + start.getDate() + "', 'to':'" + eYear + "-" + eMonth + "-" + end.getDate() + "'}",
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

                        element.find(".fc-title").prepend("<div class='circlewhite'>&nbsp;</div>");

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

                        element.find(".fc-content").append("<br/><span class='fc-room'><b>Room: </b>" + event.room + "</span>");
                        
                    });

                    if (event.title) {
                        element.find(".fc-list-item-title").text("");
                        element.find(".fc-list-item-title").append("<b>" + event.title + "</b>");
                    }

                    if (event.room) {
                        element.find(".fc-list-item-title").append("<br/><span class='fc-room'><b>Room: </b>" + event.room + "</span>");
                    }
                },
                eventClick: function (calEvent, jsEvent, view) {
                    $("#<%=HdnCID.ClientID%>").val(calEvent.cid);

                    $("#btnaddattendee").removeClass("d-none");

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
            var EmailStaff = document.getElementById('<%= HdnEmail.ClientID %>').value;

            $.ajax({
                url: '<%=ResolveUrl("calendar.aspx/GetData") %>',
                data: "{ 'ID': '" + cid + "', 'EmailStaff': '" + EmailStaff + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var obj = JSON.parse(data.d);

                    document.getElementById('<%=LitSubject.ClientID%>').innerText = obj.title;
                    document.getElementById('<%=LitRoom.ClientID%>').innerText = obj.Room;
                    document.getElementById('<%=LitStartDate.ClientID%>').innerText = obj.start;
                    document.getElementById('<%=LitEndDate.ClientID%>').innerText = obj.end;

                    var attendee = obj.attendee;

                    if (attendee === "1") {
                        $("#btnaddattendee").addClass("d-none");
                        $("#already").removeClass("d-none");
                        $("#btncancel").removeClass("d-none");
                    }
                    else {
                        $("#btnaddattendee").removeClass("d-none");
                        $("#already").addClass("d-none");
                        $("#btncancel").addClass("d-none");
                    }

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
</asp:Content>

<asp:Content ID="BodyContent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <section>
            <div class="row mt-5">
                <div class="col-8 page__title">
                    <i class="fab fa-leanpub color-red pr-2"></i><h2 class="d-inline">Training</h2>
                </div>
                <div class="col-4">
                    <a class="external__link" href="<%= ResolveClientUrl("~/Training/Video") %>">
                        <span class="btn__link-app float-right rounded-circle text-center" data-toggle="tooltip" title="Video Training" data-placement="left"><i class="far fa-play-circle font-size-25"></i></span>
                    </a>
                </div>
            </div>
        </section>
        <section>
            <div class="row mt-5">
                <div class="col-12 mb-2">
                    <h4>Calendar <i class="fas fa-calendar-alt"></i></h4>
                </div>
                <div id="calendar" class="col-12 mb-2"></div>
            </div>
        </section>

        <section>
            <div class="row mt-5">
                <div class="col-12 mb-2">
                    <h4>Video Training <i class="fas fa-video"></i></h4>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-12 col-12 img-video">
                    <a href="<%= ResolveClientUrl("~/Training/Video") %>">
                        <span class="link-video">
                            <span class="content-center hover-play">
                                <i class="fas fa-play"></i>
                            </span>
                            <span class="content-center main-play">
                                <i class="fas fa-play "></i>
                            </span>
                        </span>
                    </a>
                    <img src="<%=ResolveClientUrl("~/images/mascot/mascot-video.png")%>" />
                </div>
            </div>
        </section>

    </div>

    <!-- Modal -->
    <div class="modal fade" id="detailcalendar" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="DetailModalLabel"><span id="DetailTitle"></span>Class</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body px-0">
                    <div class="col-12">
                        <div class="col-12">
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
                            </div>
                        </div>
                    </div>
                    
                    <div class="col-12 p-0">
                        <asp:Panel ID="addattendee" runat="server" CssClass="col-md-12 text-center p-0">
                            <button id="btnaddattendee" type="button" class="btn btn-success mt-4"><i class="fas fa-user-plus pr-1"></i>Request to attend class</button>
                            <H1 id="already" class=" font-weight-bold text-success text-center bg-light py-3 my-4 ">You are already request to attend class!</H1>
                            <button id="btncancel" type="button" class="btn btn-danger">Cancel class</button>
                        </asp:Panel>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="HdnStaffName" runat="server" />
    <asp:HiddenField ID="HdnEmail" runat="server" />
</asp:Content>

<asp:Content ContentPlaceHolderID="ScriptContent" runat="Server">
    <script src="<%= ResolveClientUrl("~/Scripts/sweetalert.min.js") %>"></script>
    <link href="<%= ResolveClientUrl("~/css/sweetalert.css") %>" rel="stylesheet" />

    <script type="text/javascript">
        $(document).ready(function () {
            resize();
            $('#home').addClass("active");
            $('[data-toggle="tooltip"]').tooltip();
        });

        $("#btnaddattendee").click(function () {
            swal({
                title: "Confirm Request to attend class?",
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
                        var CID = document.getElementById('<%= HdnCID.ClientID %>').value;
                        var em = document.getElementById('<%= HdnEmail.ClientID %>').value;

                        $.ajax({
                            url: '<%=ResolveUrl("calendar.aspx/Register") %>',
                            data: "{ 'Email': '" + em + "', 'CID': '" + CID + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                if (data.d == "true") {
                                    swal({
                                        title: "Success!",
                                        text: "",
                                        type: "success"
                                    }, function () {
                                            $("#btnaddattendee").addClass("d-none");
                                            $("#already").removeClass("d-none");
                                            $("#btncancel").removeClass("d-none");
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

        $("#btncancel").click(function () {
            swal({
                title: "Confirm Cancel?",
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
                        var CID = document.getElementById('<%= HdnCID.ClientID %>').value;
                        var em = document.getElementById('<%= HdnEmail.ClientID %>').value;

                        $.ajax({
                            url: '<%=ResolveUrl("calendar.aspx/Cancel") %>',
                            data: "{ 'Email': '" + em + "', 'CID': '" + CID + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                if (data.d == "true") {
                                    swal({
                                        title: "Success!",
                                        text: "",
                                        type: "success"
                                    }, function () {
                                            $("#btnaddattendee").removeClass("d-none");
                                            $("#already").addClass("d-none");
                                            $("#btncancel").addClass("d-none");
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
