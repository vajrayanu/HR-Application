<%@ Page Language="C#" AutoEventWireup="true" CodeFile="companyDirectory.aspx.cs" Inherits="CMSView_companyDirectory" MasterPageFile="~/MasterPage/CMSMasterPage.Master" ValidateRequest="false" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="cphHead" runat="server">
    <link href="<%= ResolveClientUrl("~/css/_point.css") %>" rel="stylesheet" />
    <script src="<%= ResolveClientUrl("~/Scripts/sweetalert.min.js") %>"></script>

    <script>
        function sweetsuccess() {
            swal({
                title: "Success!",
                text: "",
                type: "success"
            }, function () {
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
            <h3 class="text-uppercase mb-5 font-weight-bold text-lg-left text-md-left text-sm-left text-center block__head">Company Directory</h3>
            <div class="row">
                <div id="form_announce" class="col-12 collapse">
                    <div class="form-group">
                        <label class="control-label" for="ddlType">Type </label>
                        <div class="col-lg-6 col-md-12 col-sm-12 col-12 px-0 input-group mb-3">
                            <asp:DropDownList ID="ddlType" name="ddlType" CssClass="custom-select" runat="server" Enabled="true" DataTextField="AN_TypeName" DataValueField="AN_AnnouncementTypeID">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="ddlGroup">Group </label>
                        <div class="col-lg-6 col-md-12 col-sm-12 col-12 px-0 input-group mb-3">
                            <asp:DropDownList ID="ddlGroup" name="ddlGroup" CssClass="custom-select" runat="server" Enabled="true" DataTextField="GP_DisplayName" DataValueField="GP_ID">
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label txt__required" for="txt_title">Title</label>
                        <div class="input-group mb-3">
                            <asp:TextBox runat="server" ID="txtTitle" name="txtTitle" CssClass="form-control" aria-label="Title" aria-describedby="txtTitle" MaxLength="75"></asp:TextBox>
                            <div class="input-group-append">
                                <span class="input-group-text" id="txt_title">Max 75</span>
                            </div>
                        </div>

                    </div>
                    <div class="form-group" id="blockdetail">
                        <label class="control-label" for="txtDetail">Detail</label>
                        <div class="input-group mb-3">
                            <asp:TextBox runat="server" ID="txtDetail" name="txtDetail" CssClass="form-control" aria-label="Detail" aria-describedby="txtDetail" TextMode="MultiLine" Rows="5"></asp:TextBox>
                            <div class="invalid-feedback">
                                Please enter a message in the textarea.
                            </div>
                        </div>
                    </div>
                    <div class="form-group" id="blockeditor">
                        <label class="control-label" for="txtDetail">Detail</label>
                        <div class="input-group mb-3">
                            <%--<asp:TextBox ID="editorDetailEN" runat="server" CssClass="form-control" Rows="20"></asp:TextBox>--%>
                            <textarea id="editorDetailEN" name="editorDetailEN" runat="server" class="form-control" rows="20"></textarea>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-lg-6 col-md-6 col-sm-12 col-12">
                            <label class="control-label txt__required" for="startDate">Start Date</label>
                            <asp:TextBox runat="server" ID="txtStartDate" name="txtStartDate" CssClass="form-control mb-3" aria-label="Start Date" aria-describedby="txtStartDate" placeholder="DD/MM/YYYY" MaxLength="75"></asp:TextBox>
                        </div>
                        <div class="form-group col-lg-6 col-md-6 col-sm-12 col-12">
                            <label class="control-label" for="endDate">End Date</label>
                            <asp:TextBox runat="server" ID="txtEndDate" name="txtEndDate" CssClass="form-control mb-3" aria-label="End Date" aria-describedby="txtEndDate" placeholder="DD/MM/YYYY" MaxLength="75"></asp:TextBox>
                        </div>
                    </div>

                    <div class="form-group d-none" id="blockUploadFile">
                        <label id="blockUploadFile_required" class="control-label txt__required" for="postedFile">Upload Document</label>
                        <div class="input-group mb-3">
                            <div class="custom-file">
                                <asp:FileUpload ID="postedFile" runat="server" CssClass="custom-file-input cursor__pointer" aria-describedby="postedFile" accept=".doc,.docx,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,.pdf" />
                                <label id="lbpostedFile" class="custom-file-label" for="postedFile" aria-describedby="postedFileAddon">Choose file</label>
                            </div>
                        </div>
                    </div>
                    <div class="form-group d-none" id="blockShowUploadFile">
                        <div class="row m-0 p-0">
                            <object class="col-6 col-lg-1">
                                <a id="ShowViewFile" data-toggle="modal" data-target="#docModal">
                                    <i class="fas fa-link fa-3x"></i>
                                    <h6 class="m-0">View</h6>
                                </a>
                            </object>
                            <object class="col-6 col-lg-1">
                                <a id="ShowDownloadFile">
                                    <i class="fas fa-cloud-download-alt fa-3x"></i>
                                    <h6 class="m-0">Download</h6>
                                </a>
                            </object>
                        </div>
                    </div>

                    <div class="form-group d-none" id="blockUploadCoverImg">
                        <label class="control-label txt__required" for="postedImageFile">Upload <span class="text_img-upload">Cover image</span></label>
                        <div class="input-group mb-3">
                            <div class="custom-file">
                                <asp:FileUpload ID="postedImageFile" runat="server" CssClass="custom-file-input cursor__pointer" aria-describedby="postedImageFile" accept=".png,.jpg,.gif" />
                                <label id="lbpostedImageFile" class="custom-file-label" for="postedImageFile" aria-describedby="postedImageFileAddon">Choose <span class="text_img-upload">Cover image</span></label>
                            </div>
                            <div class="input-group-append">
                                <span class="input-group-text" id="postedImageFileAddon">1425 × 630 px</span>
                            </div>
                        </div>
                    </div>

                    <div class="form-group d-none" id="blockShowUploadCoverImg">
                        <img id="showimg" style="width: 250px;" />
                    </div>

                    <div class="form-group">
                        <label class="control-label" for="TxtOrderBy">Order By </label>
                        <div class="col-lg-6 col-md-12 col-sm-12 col-12 px-0 input-group mb-3">
                            <asp:TextBox ID="TxtOrderBy" runat="server" CssClass="form-control" onkeypress="return onlyNumbersWithNotDot(event);" MaxLength="10"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-group" id="blockCheckHighlight">
                        <div class="form-check">
                            <asp:CheckBox ID="gridCheck" runat="server" CssClass="form-check-input" />
                            <label class="form-check-label" for="gridCheck">
                                Highlight (Show on index page)
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="control-label" for="DdlStatus">Status </label>
                        <div class="col-lg-6 col-md-12 col-sm-12 col-12 px-0 input-group mb-3">
                            <asp:DropDownList ID="DdlStatus" runat="server" CssClass="form-control">
                                <asp:ListItem Text="Active" Value="1"></asp:ListItem>
                                <asp:ListItem Text="In-Active" Value="0"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div class="col-12 text-center my-5">
                        <button id="btnformannounce" type="reset" class="btn btn-light mx-1" data-toggle="collapse" data-target="#form_announce" aria-expanded="ture" aria-controls="form_announce"><i class="fas fa-ban pr-1"></i>Cancel</button>
                        <button id="btnconfirm" type="button" class="btn btn-success mx-1"><i class="far fa-save pr-1"></i>Save</button>
                    </div>
                    <hr />
                </div>

                <div class="col-12 form-group">
                    <div class="row">
                        <div class="col-2">
                            <div class="form-group">
                                <label for="DdlStatus_">Status</label>
                                <asp:DropDownList ID="DdlStatus_" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="ALL" Value=""></asp:ListItem>
                                    <asp:ListItem Text="Active" Value="1" Selected="True"></asp:ListItem>
                                    <asp:ListItem Text="In-Active" Value="0"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-2">
                            <div class="form-group">
                                <label for="DdlType_">Type</label>
                                <asp:DropDownList ID="DdlType_" runat="server" CssClass="form-control" DataValueField="AN_AnnouncementTypeID" DataTextField="AN_TypeName">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-2">
                            <div class="form-group">
                                <label for="DdlGroup_">Group</label>
                                <asp:DropDownList ID="DdlGroup_" runat="server" CssClass="form-control" DataValueField="GP_ID" DataTextField="GP_DisplayName">
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-2">
                            <asp:Button ID="BtnSearch" runat="server" Text="Submit" CssClass="btn btn-primary mt-4" OnClientClick="return false;" />
                        </div>
                        <div class="col-4 text-right">
                            <button id="btnadd" type="button" class="btn btn-success mt-4"><i class="fas fa-plus pr-1"></i>Add</button>
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
                            <table id="tblLocations" class="table" cellpadding="0" cellspacing="0" border="1">
                                <thead class="thead-dark">
                                    <tr>
                                        <th>Type</th>
                                        <th>Group</th>
                                        <th>Image</th>
                                        <th>Document</th>
                                        <th>Title</th>
                                        <th>Status</th>
                                        <th></th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <asp:Repeater ID="RptAnnouncement" runat="server">
                                        <ItemTemplate>
                                            <tr id="<%# "anrow" + Eval("DIR_ID") %>">
                                                <td anid="<%# Eval("DIR_ID") %>"><%# Eval("AN_TypeName") %></td>
                                                <td><%# Eval("GP_DisplayName") %></td>
                                                <td><%# Eval("DIR_UploadImage").ToString() == "" ? "" : "<img id=\"img_" + Eval("DIR_ID") + "\" style=\"width:150px;\" src=\"" + ResolveClientUrl("~/images/Announcement/" + Eval("DIR_ID") + "/images/" + Eval("DIR_UploadImage")) + " \" />" %></td>
                                                <td><%# Eval("DIR_UploadDoc").ToString() == "" ? "" : Eval("DIR_UploadDoc").ToString().ToLower().Contains(".doc") || Eval("DIR_UploadDoc").ToString().ToLower().Contains(".docx") ? "<div class=\"row m-0 p-0\"><object class=\"col-6\"><a download=\"" + Eval("DIR_UploadDoc") + "\" href=\"" + ResolveClientUrl("~/images/Announcement/" + Eval("DIR_ID") + "/document/" + Eval("DIR_UploadDoc")) + "\"><i class=\"fas fa-cloud-download-alt fa-2x\"></i><h6 style=\"font-size:12px !important;\" class=\"m-0\">Download</h6></a></object></div>" : "<div class=\"row m-0 p-0\"><object class=\"col-6\"><a data-toggle=\"modal\" data-target=\"#docModal\" data-modal-title=\"Expense Reimbursement Form\" data-an-id=\"" + Eval("DIR_ID") + "\" data-file-name=\"" + Eval("DIR_UploadDoc") + "\"><i class=\"fas fa-link fa-2x\"></i><h6 style=\"font-size:12px !important;\" class=\"m-0\">View</h6></a></object><object class=\"col-6\"><a download=\"" + Eval("DIR_UploadDoc") + "\" href=\"" + ResolveClientUrl("~/images/Announcement/" + Eval("DIR_ID") + "/document/" + Eval("DIR_UploadDoc")) + "\"><i class=\"fas fa-cloud-download-alt fa-2x\"></i><h6 style=\"font-size:12px !important;\" class=\"m-0\">Download</h6></a></object></div>" %></td>
                                                <td><%# Eval("DIR_Title") %></td>
                                                <td class="<%# Eval("Status").ToString() != "Active" ? "inactive" : "active" %>"><%# Eval("Status") %></td>
                                                <td class="text-center"><i class="fas fa-pencil-alt mr-2 anedit"></i>|<i class="fas fa-trash-alt ml-2 andelete"></i></td>
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
        <div class="modal fade bd-example-modal-lg " id="modalImg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
                <div class="modal-content modal-body-Img" id="resultImg"></div>
            </div>
        </div>
        <asp:HiddenField ID="HdnAnID" runat="server" />
        <asp:HiddenField ID="HdnAction" runat="server" />
        <asp:HiddenField ID="HdnPage" runat="server" />
        <div class="modal fade bd-example-modal-xl" id="docModal" tabindex="-1" role="dialog" aria-labelledby="docModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="docModalLabel">New message</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body" id="resultModal">
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content ID="FooterContent" ContentPlaceHolderID="cphFooter" runat="server">

    <script src="<%= ResolveClientUrl("~/Scripts/jquery.blockUI.js") %>"></script>
    <script src="<%=ResolveClientUrl("~/Scripts/_cms.js")%>"></script>
    <script src="<%=ResolveClientUrl("~/Scripts/jquery-ui-1.12.1.custom/jquery-ui.min.js")%>"></script>
    <link href="<%=ResolveClientUrl("~/Scripts/jquery-ui-1.12.1.custom/jquery-ui.min.css")%>" rel="stylesheet" />

    <script src="<%=ResolveClientUrl("~/Scripts/ckeditor/ckeditor.js") %>" type="text/javascript"></script>
    <script src="<%=ResolveClientUrl("~/Scripts/ckeditor/_samples/sample.js") %>" type="text/javascript"></script>
    <link href="<%=ResolveClientUrl("~/Scripts/ckeditor/_samples/sample.css") %>" rel="stylesheet" type="text/css" />

    <script src="<%=ResolveClientUrl("~/Scripts/bootstrap/bootstrap.min.js")%>"></script>

    <script>
        var editor_idEN = "cphBody_editorDetailEN";
        var ed_toolbar = [
            ['Bold', 'Italic', 'Underline', '-'],
            ['NumberedList', 'BulletedList', '-'],
            ['JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock'],
            ['TextColor', 'BGColor'], ['Undo', 'Redo'],
        ];

        var ed_config = {
            skin: 'kama',
            language: 'en',
            width: "100%",
            height: "300",
            toolbar: ed_toolbar
        };

        var editorEN = CKEDITOR.replace(editor_idEN, ed_config);
        CKEDITOR.on('dialogDefinition', function (ev) {
            var dialogName = ev.data.name;
            var dialogDefinition = ev.data.definition;
            if (dialogName == 'image') {
                dialogDefinition.removeContents('Link');
            }
        });

        $("#<%=BtnSearch.ClientID%>").click(function () {
            $('input[id$="HdnAction"]').val("");

            doSubmitPage2();
            return false;
        });

        $(".anedit").click(function () {
            OnEditClick(this);
        });

        function OnEditClick(sv) {
            var anid = $(sv).closest('tr').children('td:nth-child(1)').attr("anid");

            $("#<%=HdnAnID.ClientID%>").val(anid);

            $.ajax({
                url: '<%=ResolveUrl("companyDirectory.aspx/getAnnouncement") %>',
                data: "{ 'anid': '" + anid + "'}",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    $('body,html').animate({
                        scrollTop: 0
                    }, 300);

                    $("#form_announce").collapse("show");

                    var obj = JSON.parse(data.d);

                    var message = obj.message;
                    var Type = obj.Type;
                    var Group = obj.Group;
                    var Title = obj.Title;
                    var Detail = obj.Detail;
                    var StartDate = obj.StartDate;
                    var EndDate = obj.EndDate;
                    var Document = obj.Document;
                    var Images = obj.Images;
                    var OrderBy = obj.OrderBy;
                    var Status = obj.Status;
                    var Hilight = obj.Hilight;

                    if (message == "success") {
                        document.getElementById('<%=ddlType.ClientID%>').value = Type;
                        document.getElementById('<%=ddlGroup.ClientID%>').value = Group;
                        document.getElementById('<%=txtTitle.ClientID%>').value = Title;

                        if (Type != "1") {
                            document.getElementById('<%=txtDetail.ClientID%>').value = Detail;
                        }
                        else {
                            CKEDITOR.instances[editor_idEN].setData(Detail);
                        }

                        document.getElementById('<%=txtStartDate.ClientID%>').value = StartDate;
                        document.getElementById('<%=txtEndDate.ClientID%>').value = EndDate;

                        if (Document != "") {
                            $("#blockShowUploadFile").removeClass("d-none");

                            $("#ShowViewFile").attr("data-modal-title", Title);
                            $("#ShowViewFile").attr("data-file-name", Document);
                            $("#ShowViewFile").attr("data-an-id", anid);

                            $("#ShowDownloadFile").attr("download", '<%=ResolveUrl("~/images/Announcement/") %>' + anid + '/document/' + Document);
                            $("#ShowDownloadFile").attr("href", '<%=ResolveUrl("~/images/Announcement/") %>' + anid + '/document/' + Document);
                        }
                        else {
                            $("#blockShowUploadFile").addClass("d-none");
                        }

                        if (Images != "") {
                            $("#blockShowUploadCoverImg").removeClass("d-none");

                            $("#showimg").attr("src", '<%=ResolveUrl("~/images/Announcement/") %>' + anid + '/images/' + Images);
                        }
                        else {
                            $("#blockShowUploadCoverImg").addClass("d-none");
                        }

                        document.getElementById('<%=TxtOrderBy.ClientID%>').value = OrderBy;
                        document.getElementById('<%=DdlStatus.ClientID%>').value = Status;

                        if (Type == "2") {
                            $('#blockCheckHighlight').removeClass('d-none');
                        }
                        else {
                            $('#blockCheckHighlight').addClass('d-none');
                        }

                        if (Hilight == "1") {
                            document.getElementById('<%=gridCheck.ClientID%>').checked = true;
                        }
                        else {
                            document.getElementById('<%=gridCheck.ClientID%>').checked = false;
                        }
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

        function doSubmitPage2() {
            doWaitng();
            document.forms[0].submit();
            return false;
        }

        $(".andelete").click(function () {
            var anid = $(this).closest('tr').children('td:nth-child(1)').attr("anid");

            AnnouncementDelete(anid);
        });

        function AnnouncementDelete(anid) {
            swal({
                title: "Confirm delete Announcement?",
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
                            url: '<%=ResolveUrl("companyDirectory.aspx/Deleted") %>',
                            data: "{ 'anid': '" + anid + "'}",
                            dataType: "json",
                            type: "POST",
                            contentType: "application/json; charset=utf-8",
                            success: function (data) {
                                if (data.d == "success") {
                                    swal({
                                        title: "Deleted Announcement Success!",
                                        text: "",
                                        type: "success"
                                    }, function () {
                                        var el = document.getElementById("anrow" + anid);
                                        el.remove();

                                        //$('#ModalTeacher').modal('toggle');
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
                    } else {
                        swal("Cancelled", "", "error");
                    }
                });
        }

        $('#docModal').on('show.bs.modal', function (event) {
            var modal = $(this)
            var button = $(event.relatedTarget)
            var title = button.data('modal-title')
            var fileName = button.data('file-name')
            var anid = button.data('an-id')

            document.getElementById('resultModal').innerHTML = "";

            modal.find('.modal-title').text(title)
            document.getElementById('resultModal').innerHTML = `<embed src='<%=ResolveClientUrl("~/images/Announcement/") %>${anid}/document/${fileName}' frameborder='0' width='100%' height='650px'/>`;
        });

        $("#<%=txtTitle.ClientID%>").keyup(function () {
            var Title = document.getElementById('<%=txtTitle.ClientID%>').value;

            if (Title == "") {
                $("#<%=txtTitle.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=txtTitle.ClientID%>").removeClass("validate_error");
            }
        });

        $("#<%=txtStartDate.ClientID%>").keyup(function () {
            var StartDate = document.getElementById('<%=txtStartDate.ClientID%>').value;

            if (StartDate == "") {
                $("#<%=txtStartDate.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=txtStartDate.ClientID%>").removeClass("validate_error");
            }
        });

        $("#<%=postedImageFile.ClientID%>").change(function () {
            var type = document.getElementById("<%= ddlType.ClientID %>").value;

            if (type == "1" || type == "2") {
                if (document.getElementById("<%=postedImageFile.ClientID%>").files.length == 0) {
                    $("#lbpostedImageFile").addClass("validate_error");
                }
                else {
                    $("#lbpostedImageFile").removeClass("validate_error");

                    var itm = $("input[id$='postedImageFile']");
                    var extension_Pic = itm.val().substring(itm.val().length - 4).toUpperCase();
                    if (extension_Pic != ".JPG" && extension_Pic != ".PNG" && extension_Pic != ".GIF") {
                        $("#lbpostedImageFile").addClass("validate_error");
                    }
                }
            }
        });

        $("#<%=postedFile.ClientID%>").change(function () {
            var type = document.getElementById("<%= ddlType.ClientID %>").value;

            if (type == "3" || type == "4" || type == "1") {
                if (document.getElementById("<%=postedFile.ClientID%>").files.length == 0) {
                    if (type == "3" || type == "4") {
                        $("#lbpostedFile").addClass("validate_error");
                    }
                }
                else {
                    $("#lbpostedFile").removeClass("validate_error");

                    var itm = $("input[id$='postedFile']");

                    var res = itm.val().split(".");
                    var extension = res[1].toUpperCase();

                    //var extension_Pic = itm.val().substring(itm.val().length - 4).toUpperCase();
                    if (extension != "DOC" && extension != "DOCX" && extension != "PDF") {
                        fileuploaddocument = "0";
                        $("#lbpostedFile").addClass("validate_error");
                    }
                }
            }
        });

        $(document).ready(function () {
            $('#announcement').addClass("active");
            $('#blockCheckHighlight').addClass('d-none');
            $('#blockUploadFile').removeClass('d-none');
            $('#blockUploadCoverImg').removeClass('d-none');
            $('#blockdetail').addClass('d-none');
            $('#blockUploadFile_required').removeClass('txt__required');
            $('#blockdetail').addClass('d-none');
            $('#blockeditor').removeClass('d-none');

            var date = new Date();
            var today = new Date(date.getFullYear(), date.getMonth(), date.getDate());

            $("#<%=txtStartDate.ClientID%>").datepicker({
                autoclose: true,
                todayHighlight: true,
                startDate: today,
                dateFormat: 'dd/mm/yy',
                "setDate": new Date()
            }).on('changeDate', function (selected) {
                var minDate = new Date(selected.date.valueOf());
                jQuery('#<%=txtEndDate.ClientID%>').datepicker('setStartDate', minDate);
            });

            $("#<%=txtEndDate.ClientID%>").datepicker({
                dateFormat: 'dd/mm/yy',
                autoclose: true
            }).on('changeDate', function (selected) {
                var minDate = new Date(selected.date.valueOf());
                jQuery('#<%=txtStartDate.ClientID%>').datepicker('setEndDate', minDate);
            });
        });

        $("#btnformannounce").click(function () {
            ClearBox();
        });

        $("#btnadd").click(function () {
            ClearBox();

            $('body,html').animate({
                scrollTop: 0
            }, 300);

            $("#form_announce").collapse("show");
        });

        function ClearBox() {
            document.getElementById('<%=ddlType.ClientID%>').value = "1";
            document.getElementById('<%=ddlGroup.ClientID%>').value = "0";
            document.getElementById('<%=txtTitle.ClientID%>').value = "";
            document.getElementById("txt_title").innerHTML = "Max 75";
            document.getElementById('<%=txtDetail.ClientID%>').value = "";
            document.getElementById('<%=txtStartDate.ClientID%>').value = "";
            document.getElementById('<%=txtEndDate.ClientID%>').value = "";
            document.getElementById('<%=TxtOrderBy.ClientID%>').value = "";

            document.getElementById('<%=HdnAnID.ClientID%>').value = "";
            $('#blockShowUploadFile').addClass('d-none');
            $('#blockShowUploadCoverImg').addClass('d-none');

            CKEDITOR.instances[editor_idEN].setData("");

            document.getElementById('<%=gridCheck.ClientID%>').checked = false;

            document.getElementById("<%=postedImageFile.ClientID%>").innerHTML = "Choose Slide image";
            $('#<%=postedImageFile.ClientID%>').val('')
            $("#lbpostedImageFile").removeClass("selected");

            document.getElementById("<%=postedFile.ClientID%>").innerHTML = "Choose file";
            $('#<%=postedFile.ClientID%>').val('')
            $("#lbpostedFile").removeClass("selected");
        }

        $("#<%=txtTitle.ClientID%>").keyup(function () {
            var Note = document.getElementById('<%=txtTitle.ClientID%>').value;

            var note_length = Note.length;

            var remain = 75 - note_length;

            if (remain == "75") {
                document.getElementById("txt_title").innerHTML = "Max " + remain;
            }
            else {
                document.getElementById("txt_title").innerHTML = remain;
            }
        });

        $("#<%=ddlType.ClientID%>").change(function () {
            var type = document.getElementById("<%=ddlType.ClientID%>").value;
            switch (type) {
                case "2":
                    $('#blockUploadCoverImg').removeClass('d-none');
                    $('#blockUploadFile').addClass('d-none');
                    $("span.text_img-upload").text("Slide image");
                    $('#blockCheckHighlight').removeClass('d-none');
                    $('#blockdetail').removeClass('d-none');
                    $('#blockeditor').addClass('d-none');
                    $('#blockUploadFile_required').addClass('txt__required');
                    break;
                case "3":
                    $('#blockUploadFile').removeClass('d-none');
                    $('#blockUploadCoverImg').addClass('d-none');
                    $('#blockCheckHighlight').addClass('d-none');
                    $('#blockdetail').removeClass('d-none');
                    $('#blockeditor').addClass('d-none');
                    $('#blockUploadFile_required').addClass('txt__required');
                    break;
                case "4":
                    $('#blockUploadFile').removeClass('d-none');
                    $('#blockUploadCoverImg').addClass('d-none');
                    $('#blockCheckHighlight').addClass('d-none');
                    $('#blockdetail').removeClass('d-none');
                    $('#blockeditor').addClass('d-none');
                    $('#blockUploadFile_required').addClass('txt__required');
                    break;
                default:
                    $('#blockUploadFile').removeClass('d-none');
                    $('#blockUploadCoverImg').removeClass('d-none');
                    $("span.text_img-upload").text("Cover image");
                    $('#blockCheckHighlight').addClass('d-none');
                    $('#blockdetail').addClass('d-none');
                    $('#blockeditor').removeClass('d-none');
                    $('#blockUploadFile_required').removeClass('txt__required');
            }
        });

        $(".custom-file-input").on("change", function () {
            var fileName = $(this).val().split("\\").pop();
            $(this).siblings(".custom-file-label").addClass("selected").html(fileName);
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

        $('.openImg').click(function () {
            var imagePath = this.dataset.bookId;

            document.getElementById('resultImg').innerHTML = "";
            $('.modal-body-Img').load("", function () {
                $('#modalImg').modal({ show: true });
                $('#modalImg').appendChild(`<img src="${imagePath}" />`);
            });
        });

        $("#btnconfirm").click(function () {
            var anid = document.getElementById('<%=HdnAnID.ClientID%>').value;
            var type = document.getElementById("<%= ddlType.ClientID %>").value;
            var group = document.getElementById("<%= ddlGroup.ClientID %>").value;
            var title = document.getElementById("<%= txtTitle.ClientID %>").value;
            var detail = "";

            if (type == "1") {
                detail = document.getElementById("<%= txtDetail.ClientID %>").value;
            } else {
                detail = document.getElementById("<%= editorDetailEN.ClientID %>").value;
            }

            var startdate = document.getElementById("<%= txtStartDate.ClientID %>").value;
            var enddate = document.getElementById("<%= txtEndDate.ClientID %>").value;
            var orderby = document.getElementById("<%= TxtOrderBy.ClientID %>").value;

            var fileuploadimage = "";
            var fileuploaddocument = "";

            if (title == "") {
                $("#<%=txtTitle.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=txtTitle.ClientID%>").removeClass("validate_error");
            }

            if (startdate == "") {
                $("#<%=txtStartDate.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=txtStartDate.ClientID%>").removeClass("validate_error");
            }

            if (type == "1" || type == "2") {
                if (document.getElementById("<%=postedImageFile.ClientID%>").files.length == 0) {
                    if (anid == "") {
                        fileuploadimage = "0";
                        $("#lbpostedImageFile").addClass("validate_error");
                    }
                    else {
                        fileuploadimage = "1";
                    }
                }
                else {
                    fileuploadimage = "1";
                    $("#lbpostedImageFile").removeClass("validate_error");

                    var itm = $("input[id$='postedImageFile']");
                    var extension_Pic = itm.val().substring(itm.val().length - 4).toUpperCase();
                    if (extension_Pic != ".JPG" && extension_Pic != ".PNG" && extension_Pic != ".GIF") {
                        fileuploadimage = "0";
                        $("#lbpostedImageFile").addClass("validate_error");
                    }
                }
            }
            else {
                $("#lbpostedImageFile").removeClass("validate_error");
            }

            if (type == "3" || type == "4" || type == "1") {
                if (document.getElementById("<%=postedFile.ClientID%>").files.length == 0) {
                    if (anid != "") {
                        fileuploaddocument = "1";
                    }
                    else {
                        if (type == "3" || type == "4") {
                            fileuploaddocument = "0";
                            $("#lbpostedFile").addClass("validate_error");
                        }
                    }
                }
                else {
                    fileuploaddocument = "1";
                    $("#lbpostedFile").removeClass("validate_error");

                    var itm = $("input[id$='postedFile']");

                    var res = itm.val().split(".");
                    var extension = res[1].toUpperCase();

                    //var extension_Pic = itm.val().substring(itm.val().length - 4).toUpperCase();
                    if (extension != "DOC" && extension != "DOCX" && extension != "PDF") {
                        fileuploaddocument = "0";
                        $("#lbpostedFile").addClass("validate_error");
                    }
                }
            }
            else {
                $("#lbpostedFile").removeClass("validate_error");
            }

            if (title != "" && startdate != "") {
                switch (type) {
                    case '2':
                        if (fileuploadimage == "1") {
                            doComfirm();
                        }
                        break;
                    case '3':
                    case '4':
                        if (fileuploaddocument == "1") {
                            doComfirm();
                        }
                        break;
                    default:
                        if (fileuploadimage == "1") {
                            doComfirm();
                        }
                }
            }

            return false;
        });

        function doComfirm() {
            var title = "Add";
            var anid = document.getElementById('<%=HdnAnID.ClientID%>').value;
            if (anid != "") {
                title = "Edit";
            }

            swal({
                title: "Confirm " + title + "?",
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

                        $('input[id$="HdnAction"]').val("confirm");

                        document.forms[0].submit();
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
</asp:Content>
