<%@ Page Language="C#" AutoEventWireup="true" CodeFile="point_activity.aspx.cs" Inherits="CMSView_point_activity" MasterPageFile="~/MasterPage/CMSMasterPage.Master" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="cphHead" runat="server">
    <link href="<%= ResolveClientUrl("~/css/_point.css") %>" rel="stylesheet" />
</asp:Content>

<asp:Content ID="BodyConntent" ContentPlaceHolderID="cphBody" runat="server">
    <section>
        <div class="container py-5">
            <h3 class="text-uppercase mb-5 font-weight-bold text-lg-left text-md-left text-sm-left text-center block__head">Point Activity</h3>
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
                            <button id="btnaddpointactivity" type="button" class="btn btn-success"><i class="fas fa-plus pr-1"></i>Add</button>
                        </div>
                    </div>
                </div>
                <div class="col-12">
                    <table id="tblPointActivity" class="table" cellpadding="0" cellspacing="0" border="1">
                        <thead class="thead-dark">
                            <tr>
                                <%--<th>#</th>--%>
                                <th>Type Name</th>
                                <th>Name</th>
                                <th>Status</th>
                                <th>Updated Date</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody id="TablePointActivity">
                            <asp:Repeater ID="RptPointActivity" runat="server">
                                <ItemTemplate>
                                    <tr id="<%# "parow" + Eval("PA_ID") %>" class="<%# "t_" + Eval("Status") %>">
                                        <%--<td><%# Container.ItemIndex + 1 %></td>--%>
                                        <td id="<%# "pfname" + Eval("PA_ID") %>" ><%# Eval("PF_Name") %></td>
                                        <td id="<%# "paname" + Eval("PA_ID") %>" ><%# Eval("PA_Name") %></td>
                                        <td id="<%# "status" + Eval("PA_ID") %>" class="<%# Eval("Status").ToString() != "Active" ? "inactive" : "active" %>"><%# Eval("Status") %></td>
                                        <td id="<%# "update" + Eval("PA_ID") %>"><%# Convert.ToDateTime(Eval("UpdatedDate")).ToString("yyyy-MM-dd HH:mm", new System.Globalization.CultureInfo("en-US")) %></td>
                                        <td id="<%# "edit" + Eval("PA_ID") %>" class="text-center" paid='<%# Eval("PA_ID") %>' pfid="<%# Eval("PF_ID") %>" paname="<%# Eval("PA_Name") %>" status="<%# Eval("Status") %>"><i class="fas fa-pencil-alt mr-2 paedit"></i></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="modal fade" id="addpointactivity" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel"><span id="TypeTitle"></span><span id="TypeTitle"></span> Point Activity</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="DdlCategory" class="txt__required">Category</label>
                                        <asp:DropDownList ID="DdlCategory" runat="server" CssClass="form-control" DataTextField="PF_Name" DataValueField="PF_ID">
                                        </asp:DropDownList>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="DdlClassType" class="txt__required">Name</label>
                                        <asp:TextBox ID="TxtName" runat="server" CssClass="form-control" MaxLength="150"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="DdlClassType" class="txt__required">Status</label>
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
    <asp:HiddenField ID="HdnPAID" runat="server" />
</asp:Content>

<asp:Content ID="FooterContent" ContentPlaceHolderID="cphFooter" runat="server">
    <script src="<%= ResolveClientUrl("~/Scripts/sweetalert.min.js") %>"></script>
    <script src="<%= ResolveClientUrl("~/Scripts/jquery.blockUI.js") %>"></script>
    <script src="<%=ResolveClientUrl("~/Scripts/_cms.js")%>"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#point').addClass("active");
        });

        $("#<%=btnsubmit.ClientID%>").click(function () {
            var Category = document.getElementById('<%=DdlCategory.ClientID%>').value;
            var Name = document.getElementById('<%=TxtName.ClientID%>').value;
            var Status = document.getElementById('<%=DdlStatus.ClientID%>').value;

            if (Category == "") {
                $("#<%=DdlCategory.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=DdlCategory.ClientID%>").removeClass("validate_error");
            }

            if (Name == "") {
                $("#<%=TxtName.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=TxtName.ClientID%>").removeClass("validate_error");
            }

            if (Category != "" && Name != "" && Status != "") {
                sweetwarning(Category, Name, Status);
            }
        });

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

        $("#btnaddpointactivity").click(function () {
            document.getElementById("btncreate").innerHTML = "Create ";
            document.getElementById("TypeTitle").innerHTML = "Add ";
            $("#<%=HdnPAID.ClientID%>").val("");
            document.getElementById('<%=TxtName.ClientID%>').value = "";
            document.getElementById('<%=DdlCategory.ClientID%>').value = "";
            document.getElementById('<%=DdlStatus.ClientID%>').value = "1";

            $('#addpointactivity').modal('toggle');
        });

        $(".paedit").click(function () {
            OnEditClick(this);
        });

        function OnEditClick(sv) {
            document.getElementById("btncreate").innerHTML = "Edit ";

            var pfid = $(sv).closest("td").attr("pfid");
            var paname = $(sv).closest("td").attr("paname");
            var status = $(sv).closest("td").attr("status");
            var paid = $(sv).closest("td").attr("paid");

            document.getElementById('<%=DdlCategory.ClientID%>').value = pfid;
            document.getElementById('<%=TxtName.ClientID%>').value = paname;

            if (status == "Active") {
                document.getElementById('<%=DdlStatus.ClientID%>').value = "1";
            }
            else {
                document.getElementById('<%=DdlStatus.ClientID%>').value = "0";
            }

            document.getElementById("TypeTitle").innerHTML = "Edit ";

            $("#<%=HdnPAID.ClientID%>").val(paid);
            $('#addpointactivity').modal('toggle');
        }

        function sweetwarning(Category, Name, Status) {
            var paid = document.getElementById('<%=HdnPAID.ClientID%>').value;

            var type = "Edit";
            if (paid == "") {
                type = "Add";
            }

            swal({
                title: "Confirm " + type + " Point Activity?",
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
                            url: '<%=ResolveUrl("point_activity.aspx/Onsubmit") %>',
                            data: "{ 'Category': '" + Category + "', 'Name': '" + Name + "', 'User': '" + User + "', 'Status': '" + Status + "', 'PAID': '" + paid + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                $.unblockUI();

                                var obj = JSON.parse(data.d);

                                var message = obj.message;
                                var _paid = obj.paid;
                                var _pfname = obj.PF_Name;
                                var _datetimenow = obj.DatetimeNow;

                                if (message == "Insert") {
                                    var tr = document.createElement("tr");
                                    tr.setAttribute("id", "parow" + _paid);

                                    var td = document.createElement("td");
                                    td.setAttribute("id", "pfname" + _paid);
                                    var textnode = document.createTextNode(_pfname);
                                    td.appendChild(textnode);
                                    tr.appendChild(td);

                                    td = document.createElement("td");
                                    td.setAttribute("id", "paname" + _paid);
                                    textnode = document.createTextNode(Name);
                                    td.appendChild(textnode);
                                    tr.appendChild(td);

                                    td = document.createElement("td");
                                    td.setAttribute("id", "status" + _paid);
                                    
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
                                    td.setAttribute("id", "update" + _paid);
                                    textnode = document.createTextNode(_datetimenow);
                                    td.appendChild(textnode);
                                    tr.appendChild(td);

                                    td = document.createElement("td");
                                    td.setAttribute("class", "text-center");
                                    td.setAttribute("paid", _paid);
                                    td.setAttribute("pfid", Category);
                                    td.setAttribute("paname", Name);

                                    if (Status == "1") {
                                        td.setAttribute("status", "Active");
                                    }
                                    else {
                                        td.setAttribute("status", "In-Active");
                                    }

                                    var _i = document.createElement("i");
                                    _i.setAttribute("onclick", "OnEditClick(this)");
                                    _i.setAttribute("class", "fas fa-pencil-alt mr-2 paedit");
                                    td.appendChild(_i);
                                    tr.appendChild(td);

                                    //textnode = document.createTextNode('|');
                                    //td.appendChild(textnode);

                                    //_i = document.createElement("i");
                                    //_i.setAttribute("onclick", "OnDeleteClick(this)");
                                    //_i.setAttribute("class", "fas fa-trash-alt ml-2 padelete");
                                    //td.appendChild(_i);
                                    //tr.appendChild(td);

                                    document.getElementById("TablePointActivity").appendChild(tr);

                                    swal({
                                        title: "Success!",
                                        text: "",
                                        type: "success"
                                    }, function () {
                                        $('#addpointactivity').modal('toggle');
                                    });
                                }
                                else if (message == "Edit") {
                                    $("#edit" + _paid).attr("paname", Name);
                                    
                                    document.getElementById("pfname" + _paid).innerHTML = _pfname;
                                    document.getElementById("paname" + _paid).innerHTML = Name;

                                    if (Status == "1") {
                                        $("#edit" + _paid).attr("status", "Active");
                                        document.getElementById("status" + _paid).innerHTML = "Active";
                                        $("#status" + _paid).addClass("active");
                                        $("#status" + _paid).removeClass("inactive");

                                        $("#parow" + _paid).addClass("t_Active");
                                        $("#parow" + _paid).removeClass("t_In-Active");
                                    }
                                    else {
                                        $("#edit" + _paid).attr("status", "In-Active");
                                        document.getElementById("status" + _paid).innerHTML = "In-Active";
                                        $("#status" + _paid).addClass("inactive");
                                        $("#status" + _paid).removeClass("active");

                                        $("#parow" + _paid).removeClass("t_Active");
                                        $("#parow" + _paid).addClass("t_In-Active");
                                    }

                                    document.getElementById("update" + _paid).innerHTML = _datetimenow;

                                    $("#edit" + _paid).attr("pfid", Category);

                                    swal({
                                        title: "Success!",
                                        text: "",
                                        type: "success"
                                    }, function () {
                                        $('#addpointactivity').modal('toggle');
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
    </script>

    <style>
        .validate_error {
            background-color: #f8dbdd !important;
            border: 1px solid #f4acad !important;
        }
    </style>
</asp:Content>
