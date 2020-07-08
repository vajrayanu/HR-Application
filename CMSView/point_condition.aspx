<%@ Page Language="C#" AutoEventWireup="true" CodeFile="point_condition.aspx.cs" Inherits="CMSView_point_condition" MasterPageFile="~/MasterPage/CMSMasterPage.Master" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="cphHead" runat="server">
    <link href="<%= ResolveClientUrl("~/css/_point.css") %>" rel="stylesheet" />
</asp:Content>

<asp:Content ID="BodyConntent" ContentPlaceHolderID="cphBody" runat="server">
    <section>
        <div class="container py-5">
            <h3 class="text-uppercase mb-5 font-weight-bold text-lg-left text-md-left text-sm-left text-center block__head">Point Condition</h3>
            <div class="row">
                <div class="col-12 form-group">
                    <div class="row">
                        <div class="col-6">
                            <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                <label class="btn btn-secondary active">
                                    <input type="radio" name="statusAll" id="statusAll" checked>
                                    All
                                </label>
                                <label class="btn btn-secondary">
                                    <input type="radio" name="statusActive" id="statusActive">
                                    Active
                                </label>
                                <label class="btn btn-secondary">
                                    <input type="radio" name="statusInactive" id="statusInactive">
                                    Inactive
                                </label>
                            </div>
                        </div>
                        <div class="col-6 text-right">
                            <button id="btnaddpointcondition" type="button" class="btn btn-success"><i class="fas fa-plus pr-1"></i>Add</button>
                        </div>
                    </div>
                </div>
                <div class="col-12" id="condition">
                    <asp:Literal ID="tablebody" runat="server" ></asp:Literal>
                </div>
            </div>
        </div>

        <div class="modal fade" id="addpointcondition" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel"><span id="TypeTitle"></span><span id="TypeTitle"></span>Point Condition</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="DdlPointActivity" class="txt__required">Point Activity</label>
                                        <asp:DropDownList ID="DdlPointActivity" runat="server" CssClass="form-control" DataTextField="PA_Name" DataValueField="PA_ID">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="TxtPointName" class="txt__required">Point Name</label>
                                        <asp:TextBox ID="TxtPointName" runat="server" CssClass="form-control" MaxLength="150"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="TxtPoint" class="txt__required">Point</label>
                                        <asp:TextBox ID="TxtPoint" runat="server" CssClass="form-control" onkeypress="return onlyNumbersWithNotDot(event);"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <asp:Panel ID="PnTarget" runat="server" CssClass="none">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="TxtTarget" class="txt__required">Start Target</label>
                                            <asp:TextBox ID="TxtTarget" runat="server" CssClass="form-control" onkeypress="return onlyNumbersWithNotDot(event);"></asp:TextBox>
                                        </div>
                                    </div>
                                    <div class="col-sm-6">
                                        <div class="form-group">
                                            <label for="TxtEndTarget" >End Target</label>
                                            <asp:TextBox ID="TxtEndTarget" runat="server" CssClass="form-control" onkeypress="return onlyNumbersWithNotDot(event);"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="TxtStartDate" class="txt__required">Start Date</label>
                                        <asp:TextBox ID="TxtStartDate" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="TxtEndDate" >End Date</label>
                                        <asp:TextBox ID="TxtEndDate" runat="server" CssClass="form-control"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="DdlStatus" class="txt__required">Status</label>
                                        <asp:DropDownList ID="DdlStatus" runat="server" CssClass="form-control" >
                                            <asp:ListItem Text="Active" Value="1"></asp:ListItem>
                                            <asp:ListItem Text="In-Active" Value="0"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="modal-footer">
                        <asp:LinkButton ID="btnsubmit" runat="server" CssClass="btn btn-success" OnClientClick="return false;"><i class="far fa-save pr-1" ></i><span id="btncreate">Create</span></asp:LinkButton>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <asp:HiddenField ID="HdnUser" runat="server" />
    <asp:HiddenField ID="HdnPCID" runat="server" />
</asp:Content>

<asp:Content ID="FooterContent" ContentPlaceHolderID="cphFooter" runat="server">
    <script src="<%= ResolveClientUrl("~/Scripts/sweetalert.min.js") %>"></script>
    <script src="<%= ResolveClientUrl("~/Scripts/jquery.blockUI.js") %>"></script>
    <script src="<%=ResolveClientUrl("~/Scripts/_cms.js")%>"></script>
    <script src="<%=ResolveClientUrl("~/Scripts/jquery-ui-1.12.1.custom/jquery-ui.min.js")%>"></script>
    <link href="<%=ResolveClientUrl("~/Scripts/jquery-ui-1.12.1.custom/jquery-ui.min.css")%>" rel="stylesheet" />
    <script src="<%=ResolveClientUrl("~/Scripts/bootstrap/bootstrap.min.js")%>"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#point').addClass("active");
        });

        $("#<%=DdlPointActivity.ClientID%>").change(function () {
            var PointActivity = document.getElementById('<%=DdlPointActivity.ClientID%>').value;

            checkopenanddisable(PointActivity);
        });

        $("#<%=btnsubmit.ClientID%>").click(function () {
            var PointActivity = document.getElementById('<%=DdlPointActivity.ClientID%>').value;
            var PointName = document.getElementById('<%=TxtPointName.ClientID%>').value;
            var Point = document.getElementById('<%=TxtPoint.ClientID%>').value;
            var Target = document.getElementById('<%=TxtTarget.ClientID%>').value;
            var EndTarget = document.getElementById('<%=TxtEndTarget.ClientID%>').value;
            var StartDate = document.getElementById('<%=TxtStartDate.ClientID%>').value;
            var EndDate = document.getElementById('<%=TxtEndDate.ClientID%>').value;
            var Status = document.getElementById('<%=DdlStatus.ClientID%>').value;

            if (PointActivity == "") {
                $("#<%=DdlPointActivity.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=DdlPointActivity.ClientID%>").removeClass("validate_error");
            }

            if (PointName == "") {
                $("#<%=TxtPointName.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=TxtPointName.ClientID%>").removeClass("validate_error");
            }

            if (Point == "") {
                $("#<%=TxtPoint.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=TxtPoint.ClientID%>").removeClass("validate_error");
            }

            if (Target == "") {
                $("#<%=TxtTarget.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=TxtTarget.ClientID%>").removeClass("validate_error");
            }

            if (StartDate == "") {
                $("#<%=TxtStartDate.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=TxtStartDate.ClientID%>").removeClass("validate_error");
            }

            if (PointActivity != "" && PointName != "" && Point != "" && StartDate != "" && Status != "") {
                if (PointActivity == "2") {
                    if (Target != "") {
                        sweetwarning(PointActivity, PointName, Point, Target, EndTarget, StartDate, EndDate, Status);
                    }
                }
                else {
                    sweetwarning(PointActivity, PointName, Point, Target, EndTarget, StartDate, EndDate, Status);
                }
            }
        });

        $("#<%=DdlPointActivity.ClientID%>").change(function () {
            var PointActivity = document.getElementById('<%=DdlPointActivity.ClientID%>').value;

            if (PointActivity == "") {
                $("#<%=DdlPointActivity.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=DdlPointActivity.ClientID%>").removeClass("validate_error");
            }
        });

        $("#<%=TxtPointName.ClientID%>").keyup(function () {
            var PointName = document.getElementById('<%=TxtPointName.ClientID%>').value;

            if (PointName == "") {
                $("#<%=TxtPointName.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=TxtPointName.ClientID%>").removeClass("validate_error");
            }
        });

        $("#<%=TxtPoint.ClientID%>").keyup(function () {
            var Point = document.getElementById('<%=TxtPoint.ClientID%>').value;

            if (Point == "") {
                $("#<%=TxtPoint.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=TxtPoint.ClientID%>").removeClass("validate_error");
            }
        });

        $("#<%=TxtTarget.ClientID%>").keyup(function () {
            var Target = document.getElementById('<%=TxtTarget.ClientID%>').value;

            if (Target == "") {
                $("#<%=TxtTarget.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=TxtTarget.ClientID%>").removeClass("validate_error");
            }
        });

        $("#<%=TxtStartDate.ClientID%>").change(function () {
            var StartDate = document.getElementById('<%=TxtStartDate.ClientID%>').value;

            if (StartDate == "") {
                $("#<%=TxtStartDate.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=TxtStartDate.ClientID%>").removeClass("validate_error");
            }
        });

        $(".pcedit").click(function () {
            OnEditClick(this);
        });

        function onlyNumbersWithNotDot(e) {
            var charCode;
            if (e.keyCode > 0) {
                charCode = e.which || e.keyCode;
            }
            else if (typeof (e.charCode) != "undefined") {
                charCode = e.which || e.keyCode;
            }

            if (charCode > 31 && (charCode < 48 || charCode > 57))
                return false;
            return true;
        }

        function checkopenanddisable(paid) {
            if (paid == "2") {
                $("#<%=PnTarget.ClientID%>").removeClass("none");
            } else {
                $("#<%=PnTarget.ClientID%>").addClass("none");
            }
        }

        function OnEditClick(sv) {
            document.getElementById("<%=DdlPointActivity.ClientID%>").disabled = true;
            document.getElementById("btncreate").innerHTML = "Edit ";

            var pcid = $(sv).closest("td").attr("pcid");
            var paid = $(sv).closest("td").attr("paid");
            var pcname = $(sv).closest("td").attr("pcname");
            var status = $(sv).closest("td").attr("status");
            var point = $(sv).closest("td").attr("point");
            var startdate = $(sv).closest("td").attr("startdate");
            var enddate = $(sv).closest("td").attr("enddate");
            var target = $(sv).closest("td").attr("target");
            var endtarget = $(sv).closest("td").attr("endtarget");

            checkopenanddisable(paid);

            document.getElementById('<%=DdlPointActivity.ClientID%>').value = paid;
            document.getElementById('<%=TxtPointName.ClientID%>').value = pcname;
            document.getElementById('<%=TxtPoint.ClientID%>').value = point;
            document.getElementById('<%=TxtStartDate.ClientID%>').value = startdate;
            document.getElementById('<%=TxtEndDate.ClientID%>').value = enddate;
            document.getElementById('<%=TxtTarget.ClientID%>').value = target;
            document.getElementById('<%=TxtEndTarget.ClientID%>').value = endtarget;

            if (status == "Active") {
                document.getElementById('<%=DdlStatus.ClientID%>').value = "1";
            }
            else {
                document.getElementById('<%=DdlStatus.ClientID%>').value = "0";
            }

            document.getElementById("TypeTitle").innerHTML = "Edit ";

            $("#<%=HdnPCID.ClientID%>").val(pcid);
            $('#addpointcondition').modal('toggle');
        }

        $("#statusAll").click(function () {
            $(".t_Active").removeClass("none");
            $(".t_In-Active").removeClass("none");
        });

        $("#statusActive").click(function () {
            $(".t_In-Active").addClass("none");
            $(".t_Active").removeClass("none");
        });

        $("#statusInactive").click(function () {
            $(".t_Active").addClass("none");
            $(".t_In-Active").removeClass("none");
        });

        function sweetwarning(PointActivity, PointName, Point, Target, EndTarget, StartDate, EndDate, Status) {
            var pcid = document.getElementById('<%=HdnPCID.ClientID%>').value;

            var type = "Edit";
            if (pcid == "") {
                type = "Add";
            }

            swal({
                title: "Confirm " + type + " Point Condition?",
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

                        $.ajax({
                            url: '<%=ResolveUrl("point_condition.aspx/Onsubmit") %>',
                            data: "{ 'PointActivity': '" + PointActivity + "', 'PointName': '" + PointName + "', 'Point': '" + Point + "', 'Target': '" + Target + "', 'EndTarget': '" + EndTarget + "', 'StartDate': '" + StartDate + "', 'EndDate': '" + EndDate + "', 'PCID': '" + pcid + "', 'Status': '" + Status + "', 'User': '" + User + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                $.unblockUI();

                                var obj = JSON.parse(data.d);

                                var message = obj.message;
                                var _pcid = obj.pcid;
                                var _paname = obj.paname;
                                var _datetimenow = obj.DatetimeNow;

                                if (message == "Insert") {
                                    var tr = document.createElement("tr");
                                    tr.setAttribute("id", "pcrow" + _pcid);

                                    var td = document.createElement("td");
                                    td.setAttribute("id", "pcname" + _pcid);
                                    var textnode = document.createTextNode(PointName);
                                    td.appendChild(textnode);
                                    tr.appendChild(td);

                                    var td = document.createElement("td");
                                    td.setAttribute("id", "po" + _pcid);
                                    var textnode = document.createTextNode(Point);
                                    td.appendChild(textnode);
                                    tr.appendChild(td);

                                    if (PointActivity == "2") {
                                        var td = document.createElement("td");
                                        td.setAttribute("id", "target" + _pcid);
                                        var textnode = document.createTextNode(Target);
                                        td.appendChild(textnode);
                                        tr.appendChild(td);

                                        td = document.createElement("td");
                                        td.setAttribute("id", "endtarget" + _pcid);
                                        textnode = document.createTextNode(EndTarget);
                                        td.appendChild(textnode);
                                        tr.appendChild(td);
                                    }

                                    var res = StartDate.split("/");

                                    var _StartDate = res[2] + "-" + res[1] + "-" + res[0];

                                    var td = document.createElement("td");
                                    td.setAttribute("id", "startdate" + _pcid);
                                    var textnode = document.createTextNode(_StartDate);
                                    td.appendChild(textnode);
                                    tr.appendChild(td);

                                    var _EndDate = "";

                                    if (EndDate != "") {
                                        var endres = EndDate.split("/");

                                        _EndDate = endres[2] + "-" + endres[1] + "-" + endres[0];
                                    }

                                    var td = document.createElement("td");
                                    td.setAttribute("id", "enddate" + _pcid);
                                    var textnode = document.createTextNode(_EndDate);
                                    td.appendChild(textnode);
                                    tr.appendChild(td);

                                    td = document.createElement("td");
                                    td.setAttribute("id", "status" + _pcid);

                                    if (Status == "1") {
                                        td.setAttribute("class", "active");
                                        textnode = document.createTextNode("Active");
                                    }
                                    else {
                                        td.setAttribute("class", "inactive");
                                        textnode = document.createTextNode("In-Active");
                                    }

                                    td.appendChild(textnode);
                                    tr.appendChild(td);

                                    td = document.createElement("td");
                                    td.setAttribute("class", "text-center");
                                    td.setAttribute("pcid", _pcid);
                                    td.setAttribute("paid", PointActivity);
                                    td.setAttribute("pcname", PointName);

                                    if (Status == "1") {
                                        td.setAttribute("status", "Active");
                                    }
                                    else {
                                        td.setAttribute("status", "In-Active");
                                    }

                                    td.setAttribute("target", Target);
                                    td.setAttribute("endtarget", EndTarget);
                                    td.setAttribute("point", Point);
                                    td.setAttribute("startdate", StartDate);
                                    td.setAttribute("enddate", EndDate);

                                    var _i = document.createElement("i");
                                    _i.setAttribute("onclick", "OnEditClick(this)");
                                    _i.setAttribute("class", "fas fa-pencil-alt mr-2 pcedit");
                                    td.appendChild(_i);
                                    tr.appendChild(td);

                                    let box = document.querySelectorAll(".tblPointCondition" + PointActivity);

                                    if (box.length > 0) {
                                        document.getElementById("tblPointCondition" + PointActivity).appendChild(tr);
                                    }
                                    else {
                                        var div = document.createElement("div");
                                        div.setAttribute("class", "head_point");

                                        var text = document.createTextNode(_paname);
                                        div.appendChild(text);

                                        document.getElementById("condition").appendChild(div);

                                        var tbl = document.createElement("table");
                                        tbl.setAttribute("id", "tblPointCondition" + _pcid);
                                        tbl.setAttribute("class", "table");
                                        tbl.setAttribute("cellpadding", "0");
                                        tbl.setAttribute("cellspacing", "0");
                                        tbl.setAttribute("border", "1");

                                        var thead = document.createElement("thead");
                                        thead.setAttribute("class", "thead-dark");

                                        var trhead = document.createElement("tr");

                                        var th = document.createElement("th");
                                        var thtext = document.createTextNode("Point Name");
                                        th.appendChild(thtext);
                                        trhead.appendChild(th);

                                        th = document.createElement("th");
                                        var thtext = document.createTextNode("Point");
                                        th.appendChild(thtext);
                                        trhead.appendChild(th);

                                        if (PointActivity == "2") {
                                            th = document.createElement("th");
                                            var thtext = document.createTextNode("Target");
                                            th.appendChild(thtext);
                                            trhead.appendChild(th);

                                            th = document.createElement("th");
                                            var thtext = document.createTextNode("End Target");
                                            th.appendChild(thtext);
                                            trhead.appendChild(th);
                                        }

                                        th = document.createElement("th");
                                        var thtext = document.createTextNode("Start Date");
                                        th.appendChild(thtext);
                                        trhead.appendChild(th);

                                        th = document.createElement("th");
                                        var thtext = document.createTextNode("End Date");
                                        th.appendChild(thtext);
                                        trhead.appendChild(th);

                                        th = document.createElement("th");
                                        var thtext = document.createTextNode("Status");
                                        th.appendChild(thtext);
                                        trhead.appendChild(th);

                                        th = document.createElement("th");
                                        var thtext = document.createTextNode("");
                                        th.appendChild(thtext);
                                        trhead.appendChild(th);

                                        thead.appendChild(trhead);

                                        tbl.appendChild(thead);

                                        var tbody = document.createElement("tbody");
                                        tbody.appendChild(tr);

                                        tbl.appendChild(tbody);

                                        document.getElementById("condition").appendChild(tbl);
                                    }

                                    swal({
                                        title: "Success!",
                                        text: "",
                                        type: "success"
                                    }, function () {
                                        $('#addpointcondition').modal('toggle');
                                    });
                                }
                                else if (message == "Edit") {
                                    $("#edit" + _pcid).attr("pcname", PointName);
                                    $("#edit" + _pcid).attr("paid", PointActivity);
                                    $("#edit" + _pcid).attr("target", Target);
                                    $("#edit" + _pcid).attr("endtarget", EndTarget);
                                    $("#edit" + _pcid).attr("point", Point);
                                    $("#edit" + _pcid).attr("startdate", StartDate);
                                    $("#edit" + _pcid).attr("enddate", EndDate);

                                    document.getElementById("pcname" + _pcid).innerHTML = PointName;
                                    document.getElementById("po" + _pcid).innerHTML = Point;

                                    if (PointActivity == "2") {
                                        document.getElementById("target" + _pcid).innerHTML = Target;
                                        document.getElementById("endtarget" + _pcid).innerHTML = EndTarget;
                                    }

                                    var res = StartDate.split("/");

                                    var _StartDate = res[2] + "-" + res[1] + "-" + res[0];

                                    var _EndDate = "";

                                    if (EndDate != "") {
                                        var endres = EndDate.split("/");

                                        _EndDate = endres[2] + "-" + endres[1] + "-" + endres[0];
                                    }

                                    document.getElementById("startdate" + _pcid).innerHTML = _StartDate;
                                    document.getElementById("enddate" + _pcid).innerHTML = _EndDate;

                                    if (Status == "1") {
                                        $("#edit" + _pcid).attr("status", "Active");
                                        document.getElementById("status" + _pcid).innerHTML = "Active";
                                        $("#status" + _pcid).addClass("active");
                                        $("#status" + _pcid).removeClass("inactive");

                                        $("#pcrow" + _pcid).addClass("t_Active");
                                        $("#pcrow" + _pcid).removeClass("t_In-Active");
                                    }
                                    else {
                                        $("#edit" + _pcid).attr("status", "In-Active");
                                        document.getElementById("status" + _pcid).innerHTML = "In-Active";
                                        $("#status" + _pcid).addClass("inactive");
                                        $("#status" + _pcid).removeClass("active");

                                        $("#pcrow" + _pcid).removeClass("t_Active");
                                        $("#pcrow" + _pcid).addClass("t_In-Active");
                                    }

                                    swal({
                                        title: "Success!",
                                        text: "",
                                        type: "success"
                                    }, function () {
                                        $('#addpointcondition').modal('toggle');
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

        function doWaitng() {
            $.blockUI({
                message: '<img src=\"../images/ajax-loader.gif\" alt=\"Loading...\"/><br /><h2>Loading...</h2>'
                , css: {
                    border: '1px solid #cccccc'
                    , color: '#8B8B8B'
                }
            });
        }

        $("#<%=TxtStartDate.ClientID%>").datepicker({
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd/mm/yy',
            showButtonPanel: false,
            buttonText: "Select date",
            onClose: function (selectedDate) {
                $("#<%=TxtEndDate.ClientID%>").datepicker("option", "minDate", selectedDate);
            }
        }).attr('readOnly', 'true');

        $("#<%=TxtEndDate.ClientID%>").datepicker({
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd/mm/yy',
        });

        $("#btnaddpointcondition").click(function () {
            document.getElementById("btncreate").innerHTML = "Create ";
            document.getElementById("TypeTitle").innerHTML = "Add ";

            document.getElementById('<%=DdlPointActivity.ClientID%>').value = "1";
            document.getElementById('<%=TxtPointName.ClientID%>').value = "";
            document.getElementById('<%=TxtPoint.ClientID%>').value = "";
            document.getElementById('<%=TxtStartDate.ClientID%>').value = "";
            document.getElementById('<%=TxtEndDate.ClientID%>').value = "";
            document.getElementById('<%=TxtTarget.ClientID%>').value = "";
            document.getElementById('<%=TxtEndTarget.ClientID%>').value = "";
            document.getElementById('<%=DdlStatus.ClientID%>').value = "1";

            var PointActivity = document.getElementById('<%=DdlPointActivity.ClientID%>').value;

            checkopenanddisable(PointActivity);

            document.getElementById("<%=DdlPointActivity.ClientID%>").disabled = false;

            $('#addpointcondition').modal('toggle');
        });
    </script>

    <style>
        .validate_error {
            background-color: #f8dbdd !important;
            border: 1px solid #f4acad !important;
        }
    </style>
</asp:Content>
