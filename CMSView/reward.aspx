<%@ Page Language="C#" AutoEventWireup="true" CodeFile="reward.aspx.cs" Inherits="CMSView_reward" MasterPageFile="~/MasterPage/CMSMasterPage.Master" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="cphHead" runat="server">
    <link href="<%= ResolveClientUrl("~/css/_point.css") %>" rel="stylesheet" />
</asp:Content>

<asp:Content ID="BodyConntent" ContentPlaceHolderID="cphBody" runat="server">
    <section>
        <div class="container py-5">
            <h3 class="text-uppercase mb-5 font-weight-bold text-lg-left text-md-left text-sm-left text-center block__head">Reward</h3>
            <div class="row">
                <div class="col-12 form-group">
                    <div class="row">
                        <div class="col-6">
                            <div class="btn-group btn-group-toggle" data-toggle="buttons">
                                <label class="btn btn-secondary active">
                                    <input type="radio" name="statusAll" id="statusAll">
                                    All
                                </label>
                                <label class="btn btn-secondary">
                                    <input type="radio" name="statusActive" id="statusActive" checked>
                                    Active
                                </label>
                                <label class="btn btn-secondary">
                                    <input type="radio" name="statusInactive" id="statusInactive">
                                    Inactive
                                </label>
                            </div>
                        </div>
                        <div class="col-6 text-right">
                            <button id="btnaddreward" type="button" class="btn btn-success"><i class="fas fa-plus pr-1"></i>Add</button>
                        </div>
                    </div>
                </div>
                <div class="col-12">
                    <table id="tblReward" class="table" cellpadding="0" cellspacing="0" border="1">
                        <thead class="thead-dark">
                            <tr>
                                <th>Reward Name</th>
                                <th>Store</th>
                                <th>Point</th>
                                <th>Picture</th>
                                <th>Status</th>
                                <th>Create Date</th>
                                <th>Expire Date</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody id="TableReward">
                            <asp:Repeater ID="RptReward" runat="server">
                                <ItemTemplate>
                                    <tr id="<%# "rwrow" + Eval("RW_ID") %>" class="<%# "t_" + Eval("Status") %>">
                                        <td id="<%# "rwname" + Eval("RW_ID") %>" ><%# Eval("RewardName") %></td>
                                        <td id="<%# "store" + Eval("RW_ID") %>" ><%# Eval("RewardStore") %></td>
                                        <td id="<%# "po" + Eval("RW_ID") %>" ><%# Eval("RewardPoint") %></td>
                                        <td id="<%# "pic" + Eval("RW_ID") %>" ><img id="<%# "img_" + Eval("RW_ID") %>" style="width:150px;" src="<%# ResolveClientUrl("~/images/Reward/" + Eval("RewardPicture")) %>" /></td>
                                        <td id="<%# "status" + Eval("RW_ID") %>" class="<%# Eval("Status").ToString() != "Active" ? "inactive" : "active" %>"><%# Eval("Status") %></td>
                                        <td id="<%# "create" + Eval("RW_ID") %>"><%# Convert.ToDateTime(Eval("CreatedDate")).ToString("yyyy-MM-dd HH:mm", new System.Globalization.CultureInfo("en-US")) %></td>
                                        <td id="<%# "expdate" + Eval("RW_ID") %>"><%# Eval("ExpiredDate").ToString() == "" ? "" : Convert.ToDateTime(Eval("ExpiredDate")).ToString("yyyy-MM-dd", new System.Globalization.CultureInfo("en-US")) %></td>
                                        <td id="<%# "edit" + Eval("RW_ID") %>" class="text-center" expdate='<%# Eval("ExpiredDate").ToString() == "" ? "" : Convert.ToDateTime(Eval("ExpiredDate")).ToString("dd/MM/yyyy", new System.Globalization.CultureInfo("en-US")) %>' rwid='<%# Eval("RW_ID") %>' rwname="<%# Eval("RewardName") %>" store="<%# Eval("RewardStore") %>" point="<%# Eval("RewardPoint") %>" pic="<%# Eval("RewardPicture") %>" status="<%# Eval("Status") %>"><i class="fas fa-pencil-alt mr-2 rwedit"></i></td>
                                    </tr>
                                </ItemTemplate>
                            </asp:Repeater>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <div class="modal fade" id="addreward" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel"><span id="TypeTitle"></span><span id="TypeTitle"></span>Reward</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="TxtTitle" class="txt__required">Title</label>
                                        <asp:TextBox ID="TxtTitle" runat="server" CssClass="form-control" MaxLength="150"></asp:TextBox>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="TxtStore" class="txt__required">Store</label>
                                        <asp:TextBox ID="TxtStore" runat="server" CssClass="form-control" MaxLength="150"></asp:TextBox>
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
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="TxtExpireDate" class="txt__required">Expire Date</label>
                                        <asp:TextBox ID="TxtExpireDate" runat="server" CssClass="form-control"></asp:TextBox>
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
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <label for="TxtPoint" class="txt__required">Picture</label>
                                        <div id="uploadfile" class="custom-file">
                                            <input type="file" class="custom-file-input" id="customFile">
                                            <label id="customfilelabel" class="custom-file-label" for="customFile">Choose file</label>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-12">
                            <div class="row">
                                <div class="col-sm-12">
                                    <div class="form-group">
                                        <img id="showimg" style="width:250px;" />
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
    <asp:HiddenField ID="HdnRWID" runat="server" />
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

        $("#<%=TxtExpireDate.ClientID%>").datepicker({
            changeMonth: true,
            changeYear: true,
            dateFormat: 'dd/mm/yy',
            showButtonPanel: false,
            buttonText: "Select date"
        }).attr('readOnly', 'true');

        $("#btnaddreward").click(function () {
            document.getElementById("btncreate").innerHTML = "Create ";
            document.getElementById("TypeTitle").innerHTML = "Add ";
            $("#<%=HdnRWID.ClientID%>").val("");

            document.getElementById('<%=TxtTitle.ClientID%>').value = "";
            document.getElementById('<%=TxtStore.ClientID%>').value = "";
            document.getElementById('<%=TxtPoint.ClientID%>').value = "";
            document.getElementById('<%=DdlStatus.ClientID%>').value = "1";
            document.getElementById('<%=TxtExpireDate.ClientID%>').value = "";

            $("#showimg").attr("src", "");

            document.getElementById("customfilelabel").innerHTML = "Choose file";
            $('#customFile').val('')
            $("#customfilelabel").removeClass("selected");

            $('#addreward').modal('toggle');
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

        $("#<%=btnsubmit.ClientID%>").click(function () {
            var rwid = document.getElementById('<%=HdnRWID.ClientID%>').value;
            var Title = document.getElementById('<%=TxtTitle.ClientID%>').value;
            var ExpireDate = document.getElementById('<%=TxtExpireDate.ClientID%>').value;
            var Store = document.getElementById('<%=TxtStore.ClientID%>').value;
            var Point = document.getElementById('<%=TxtPoint.ClientID%>').value;
            var Status = document.getElementById('<%=DdlStatus.ClientID%>').value;
            var fileupload = "";

            if (Title == "") {
                $("#<%=TxtTitle.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=TxtTitle.ClientID%>").removeClass("validate_error");
            }

            if (ExpireDate == "") {
                $("#<%=TxtExpireDate.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=TxtExpireDate.ClientID%>").removeClass("validate_error");
            }

            if (Store == "") {
                $("#<%=TxtStore.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=TxtStore.ClientID%>").removeClass("validate_error");
            }

            if (Point == "") {
                $("#<%=TxtPoint.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=TxtPoint.ClientID%>").removeClass("validate_error");
            }

            if (rwid != "") {
                if (document.getElementById("customFile").files.length == 0) {
                }
                else {
                    fileupload = "1";
                    $(".custom-file-label").removeClass("validate_error");

                    var itm = $("input[id$='customFile']");
                    var extension_Pic = itm.val().substring(itm.val().length - 4).toUpperCase();
                    if (extension_Pic != ".JPG" && extension_Pic != ".PNG" && extension_Pic != ".GIF") {
                        fileupload = "0";
                        $(".custom-file-label").addClass("validate_error");
                    }

                    try {
                        const fsize = $('#customFile')[0].files[0].size;
                        const file = parseInt(fsize, 10);
                        if (file > 204800) {
                            fileupload = "0";
                            $(".custom-file-label").addClass("validate_error");
                        }
                    } catch (err) { }
                }
            }
            else {
                if (document.getElementById("customFile").files.length == 0) {
                    fileupload = "0";
                    $(".custom-file-label").addClass("validate_error");
                }
                else {
                    fileupload = "1";
                    $(".custom-file-label").removeClass("validate_error");

                    var itm = $("input[id$='customFile']");
                    var extension_Pic = itm.val().substring(itm.val().length - 4).toUpperCase();
                    if (extension_Pic != ".JPG" && extension_Pic != ".PNG" && extension_Pic != ".GIF") {
                        fileupload = "0";
                        $(".custom-file-label").addClass("validate_error");
                    }

                    try {
                        const fsize = $('#customFile')[0].files[0].size;
                        const file = parseInt(fsize, 10);
                        if (file > 204800) {
                            fileupload = "0";
                            $(".custom-file-label").addClass("validate_error");
                        }
                    } catch (err) { }
                }
            }

            if (rwid != "") {
                if (document.getElementById("customFile").files.length == 0) {
                    sweetwarning(Title, Store, Point, Status, ExpireDate);
                }
                else {
                    if (Title != "" && ExpireDate != "" && Store != "" && Point != "" && Status != "" && fileupload == "1") {
                        sweetwarning(Title, Store, Point, Status, ExpireDate);
                    }
                }
            }
            else {
                if (Title != "" && ExpireDate != "" && Store != "" && Point != "" && Status != "" && fileupload == "1") {
                    sweetwarning(Title, Store, Point, Status, ExpireDate);
                }
            }
        });

        $(".rwedit").click(function () {
            OnEditClick(this);
        });

        function OnEditClick(sv) {
            document.getElementById("btncreate").innerHTML = "Edit ";

            var rwid = $(sv).closest("td").attr("rwid");
            var rwname = $(sv).closest("td").attr("rwname");
            var expdate = $(sv).closest("td").attr("expdate");
            var store = $(sv).closest("td").attr("store");
            var point = $(sv).closest("td").attr("point");
            var pic = $(sv).closest("td").attr("pic");
            var status = $(sv).closest("td").attr("status");

            document.getElementById('<%=TxtTitle.ClientID%>').value = rwname;
            document.getElementById('<%=TxtExpireDate.ClientID%>').value = expdate;
            document.getElementById('<%=TxtStore.ClientID%>').value = store;
            document.getElementById('<%=TxtPoint.ClientID%>').value = point;
             
            $("#showimg").attr("src", "../images/Reward/" + pic);

            if (status == "Active") {
                document.getElementById('<%=DdlStatus.ClientID%>').value = "1";
            }
            else {
                document.getElementById('<%=DdlStatus.ClientID%>').value = "0";
            }

            document.getElementById("TypeTitle").innerHTML = "Edit ";

            document.getElementById("customfilelabel").innerHTML = "Choose file";
            $('#customFile').val('')
            $("#customfilelabel").removeClass("selected");

            $("#<%=HdnRWID.ClientID%>").val(rwid);
            $('#addreward').modal('toggle');
        }

        function sweetwarning(Title, Store, Point, Status, ExpireDate) {
            var rwid = document.getElementById('<%=HdnRWID.ClientID%>').value;

            var type = "Edit";
            if (rwid == "") {
                type = "Add";
            }

            swal({
                title: "Confirm " + type + " Reward?",
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
                            url: '<%=ResolveUrl("reward.aspx/Onsubmit") %>',
                            data: "{ 'Title': '" + Title + "', 'Store': '" + Store + "', 'Point': '" + Point + "', 'Status': '" + Status + "', 'User': '" + User + "', 'rwid': '" + rwid + "', 'ExpireDate': '" + ExpireDate + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                $.unblockUI();

                                var obj = JSON.parse(data.d);
                                var _rwid = obj.rwid;
                                var _datetimenow = obj.DatetimeNow;

                                var message = obj.message;
                                if (message == "Insert") {
                                    var tr = document.createElement("tr");
                                    tr.setAttribute("id", "rwrow" + _rwid);

                                    var td = document.createElement("td");
                                    td.setAttribute("id", "rwname" + _rwid);
                                    var textnode = document.createTextNode(Title);
                                    td.appendChild(textnode);
                                    tr.appendChild(td);

                                    td = document.createElement("td");
                                    td.setAttribute("id", "store" + _rwid);
                                    var textnode = document.createTextNode(Store);
                                    td.appendChild(textnode);
                                    tr.appendChild(td);

                                    td = document.createElement("td");
                                    td.setAttribute("id", "po" + _rwid);
                                    var textnode = document.createTextNode(Point);
                                    td.appendChild(textnode);
                                    tr.appendChild(td);

                                    td = document.createElement("td");
                                    td.setAttribute("id", "pic" + _rwid);
                                    var textnode = document.createTextNode(Point);

                                    var _img = document.createElement("img");
                                    _img.setAttribute("style", "width:150px;");
                                    _img.setAttribute("id", "img_" + _rwid);
                                    td.appendChild(_img);
                                    tr.appendChild(td);

                                    td = document.createElement("td");
                                    td.setAttribute("id", "status" + _rwid);

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

                                    var res = ExpireDate.split("/");

                                    var _ExpireDate = res[2] + "-" + res[1] + "-" + res[0];

                                    td = document.createElement("td");
                                    td.setAttribute("id", "expdate" + _rwid);
                                    textnode = document.createTextNode(_ExpireDate);
                                    td.appendChild(textnode);
                                    tr.appendChild(td);

                                    td = document.createElement("td");
                                    td.setAttribute("id", "update" + _rwid);
                                    textnode = document.createTextNode(_datetimenow);
                                    td.appendChild(textnode);
                                    tr.appendChild(td);

                                    td = document.createElement("td");
                                    td.setAttribute("class", "text-center");
                                    td.setAttribute("rwid", _rwid);
                                    td.setAttribute("rwname", Title);
                                    td.setAttribute("store", Store);
                                    td.setAttribute("point", Point);
                                    td.setAttribute("expdate", ExpireDate);

                                    if (Status == "1") {
                                        td.setAttribute("status", "Active");
                                    }
                                    else {
                                        td.setAttribute("status", "In-Active");
                                    }

                                    var _i = document.createElement("i");
                                    _i.setAttribute("onclick", "OnEditClick(this)");
                                    _i.setAttribute("class", "fas fa-pencil-alt mr-2 rwedit");
                                    td.appendChild(_i);
                                    tr.appendChild(td);

                                    document.getElementById("TableReward").appendChild(tr);
                                    uploadimage(_rwid);

                                    swal({
                                        title: "Success!",
                                        text: "",
                                        type: "success"
                                    }, function () {
                                        $('#addreward').modal('toggle');
                                    });
                                }
                                else if (message == "Edit") {
                                    $("#edit" + _rwid).attr("rwname", Title);
                                    $("#edit" + _rwid).attr("store", Store);
                                    $("#edit" + _rwid).attr("point", Point);
                                    $("#edit" + _rwid).attr("expdate", ExpireDate);

                                    document.getElementById("rwname" + _rwid).innerHTML = Title;
                                    document.getElementById("store" + _rwid).innerHTML = Store;
                                    document.getElementById("po" + _rwid).innerHTML = Point;

                                    var res = ExpireDate.split("/");

                                    var _ExpireDate = res[2] + "-" + res[1] + "-" + res[0];
                                    document.getElementById("expdate" + _rwid).innerHTML = _ExpireDate;

                                    if (Status == "1") {
                                        $("#edit" + _rwid).attr("status", "Active");
                                        document.getElementById("status" + _rwid).innerHTML = "Active";
                                        $("#status" + _rwid).addClass("active");
                                        $("#status" + _rwid).removeClass("inactive");

                                        $("#rwrow" + _rwid).addClass("t_Active");
                                        $("#rwrow" + _rwid).removeClass("t_In-Active");
                                    }
                                    else {
                                        $("#edit" + _rwid).attr("status", "In-Active");
                                        document.getElementById("status" + _rwid).innerHTML = "In-Active";
                                        $("#status" + _rwid).addClass("inactive");
                                        $("#status" + _rwid).removeClass("active");

                                        $("#rwarow" + _rwid).removeClass("t_Active");
                                        $("#rwrow" + _rwid).addClass("t_In-Active");
                                    }

                                    uploadimage(_rwid);

                                    swal({
                                        title: "Success!",
                                        text: "",
                                        type: "success"
                                    }, function () {
                                        $('#addreward').modal('toggle');
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

        function uploadimage(rwid) {
            if (document.getElementById("customFile").files.length == 0) {
            }
            else {
                var formData = new FormData();
                formData.append('rwid', rwid);
                // Attach file
                formData.append('image', $('#customFile')[0].files[0]);

                $.ajax({
                    url: '<%=ResolveClientUrl("~/CMSView/uploadpicture.ashx")%>',  //Server script to process data
                    type: 'POST',
                    data: formData,
                    cache: false,
                    contentType: false,
                    processData: false,
                    success: function (result) {
                        if (result.includes("success_")) {
                            $("#edit" + rwid).attr("pic", result.replace("success_", ""));
                            $("#img_" + rwid).attr("src", "../images/Reward/" + result.replace("success_", ""));
                        }
                    }
                });
            }
        }

        $("#<%=TxtTitle.ClientID%>").keyup(function () {
            var Title = document.getElementById('<%=TxtTitle.ClientID%>').value;

            if (Title == "") {
                $("#<%=TxtTitle.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=TxtTitle.ClientID%>").removeClass("validate_error");
            }
        });

        $("#<%=TxtExpireDate.ClientID%>").change(function () {
            var ExpireDate = document.getElementById('<%=TxtExpireDate.ClientID%>').value;

            if (ExpireDate == "") {
                $("#<%=TxtExpireDate.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=TxtExpireDate.ClientID%>").removeClass("validate_error");
            }
        });

        $("#<%=TxtStore.ClientID%>").keyup(function () {
            var Store = document.getElementById('<%=TxtStore.ClientID%>').value;

            if (Store == "") {
                $("#<%=TxtStore.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=TxtStore.ClientID%>").removeClass("validate_error");
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

        $("#customFile").change(function () {
            if (document.getElementById("customFile").files.length == 0) {
                $(".custom-file-label").addClass("validate_error");
            }
            else {
                $(".custom-file-label").removeClass("validate_error");

                var itm = $("input[id$='customFile']");
                var extension_Pic = itm.val().substring(itm.val().length - 4).toUpperCase();
                if (extension_Pic != ".JPG" && extension_Pic != ".PNG" && extension_Pic != ".GIF") {
                    swal("Picture is .JPG .PNG .GIF only !", "", "error");
                }

                try {
                    const fsize = $('#customFile')[0].files[0].size;
                    const file = parseInt(fsize, 10);
                    if (file > 204800) {
                        swal("file size 200 KB.", "", "error");
                    }
                } catch (err) { }
            }
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

        $(".custom-file-input").on("change", function () {
            var fileName = $(this).val().split("\\").pop();
            $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
        });
    </script>

    <style>
        .validate_error {
            background-color: #f8dbdd !important;
            border: 1px solid #f4acad !important;
        }
    </style>
</asp:Content>
