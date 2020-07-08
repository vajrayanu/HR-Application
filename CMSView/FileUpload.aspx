<%@ Page Language="C#" AutoEventWireup="true" CodeFile="FileUpload.aspx.cs" Inherits="CMSView_FileUpload" MasterPageFile="~/masterpage/CMSMasterPage.master" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="BodyConntent" ContentPlaceHolderID="cphBody" runat="server">
    <div class="container py-5">
        <h3 class="text-uppercase mb-5 font-weight-bold text-lg-left text-md-left text-sm-left text-center block__head">TRAINING VIDEO UPLOAD</h3>
        <div id="hiddentab" class="collapse">
            <nav>
                <div class="nav nav-tabs" id="nav-tab" role="tablist">
                    <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">File Upload</a>
                    <a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">Iframe Upload</a>
                </div>
            </nav>
            <div class="tab-content" id="nav-tabContent">
                <div class="tab-pane fade show active" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                    <input id="Button1" class="btn btn-success" type="button" value="Add" onclick="AddFileUpload()" />
                    <br />
                    <br />
                    <div id="FileUploadContainer">
                        <!--FileUpload Controls will be added here -->
                    </div>
                    <br />
                    <div id="main">
                    </div>
                    <asp:Button ID="btnUpload" CssClass="btn btn-primary invisible" runat="server" Text="Upload" OnClick="btnup" />
                </div>
                <div class="tab-pane fade" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">
                    <input id="addvdo" class="btn btn-success" type="button" value="Add" onclick="AddFileUpload1()" />
                    <br />
                    <br />
                    <div id="FileUploadContainer1">
                        <!--FileUpload Controls will be added here -->
                    </div>
                    <br />
                    <asp:Button ID="upvdo" CssClass="btn btn-primary invisible" runat="server" Text="Upload" OnClick="btnup1" />
                </div>
            </div>
            <div class="col-12 text-center my-5">
                <button type="reset" id="cancelAdd" class="btn btn-light mx-1" data-toggle="collapse" data-target="#hiddentab" aria-expanded="true" aria-controls="hiddentab"><i class="fas fa-ban pr-1"></i>Cancel</button>
            </div>
            <hr />
        </div>
        <div class="row">
            <div class="col-12 form-group">
                <div class="row">
                    <div class="col-2">
                        <div class="form-group">
                            <label for="DdlStatus" class="txt__required">Status</label>
                            <asp:DropDownList ID="DdlStatus" runat="server" CssClass="form-control">
                                <asp:ListItem Text="All" Value=""></asp:ListItem>
                                <asp:ListItem Text="Active" Value="1"></asp:ListItem>
                                <asp:ListItem Text="Inactive" Value="0"></asp:ListItem>
                                <asp:ListItem Text="Hilight" Value="H"></asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                    <div class="col-2">
                        <asp:Button ID="BtnSearch" runat="server" Text="Submit" CssClass="btn btn-primary" Style="margin-top: 30px;" OnClientClick="return false;" />
                    </div>
                    <div class="col-8 text-right">
                        <button type="button" class="btn btn-success" data-toggle="collapse" data-target="#hiddentab" aria-expanded="false" aria-controls="hiddentab"><i class="fas fa-plus pr-1"></i>Add</button>
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
                        <table id="tblReward" class="table" cellpadding="0" cellspacing="0" border="1">
                            <thead class="thead-dark">
                                <tr>
                                    <th>Row</th>
                                    <th>Type</th>
                                    <th>Title</th>
                                    <th>Department</th>
                                    <th>Highlight</th>
                                    <th>Status</th>
                                    <th></th>
                                </tr>
                            </thead>
                            <tbody id="TableReward">
                                <asp:Repeater ID="RptVdo" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%# Eval("row")%></td>
                                            <td><%# Eval("File_Type")%></td>
                                            <td><%# Eval("File_Title") %></td>
                                            <td><%# Eval("File_Dept") %></td>
                                            <td><%# Eval("File_Highlight_ID") %></td>
                                            <td><%# Eval("File_Status_ID") %></td>
                                            <td class="text-center" fid='<%# Eval("File_ID") %>' ftid='<%# Eval("File_Type_ID") %>' fname='<%# Eval("File_Name") %>' fstatus='<%# Eval("File_Status") %>' ftitle='<%# Eval("File_Title") %>' fdept='<%# Eval("File_Dept") %>' fhigh='<%# Eval("File_Highlight") %>'><i class="fas fa-pencil-alt mr-2 vdoedit"></i>| <i class="fas fa-trash-alt mr-2 vdodel"></i></td>
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

            <div class="modal fade" id="addpointactivity" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel"><span id="TypeTitle"></span>Video Training</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label for="DdlClassType" class="txt__required">File Name</label>
                                            <asp:TextBox ID="FileName" runat="server" CssClass="form-control" MaxLength="250"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label for="DdlClassType" class="txt__required">Title</label>
                                            <asp:TextBox ID="Title" runat="server" CssClass="form-control" MaxLength="150"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label for="DdlClassType" class="txt__required">Department</label>
                                            <asp:DropDownList ID="DdlDept" runat="server" CssClass="form-control">
                                                <asp:ListItem Text="HR" Value="HR"></asp:ListItem>
                                                <asp:ListItem Text="IT" Value="IT"></asp:ListItem>
                                                <asp:ListItem Text="Sale" Value="Sale"></asp:ListItem>
                                                <asp:ListItem Text="Service" Value="Service"></asp:ListItem>
                                            </asp:DropDownList>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label for="DdlClassType" class="txt__required">Highlight</label>
                                            <div class="checkbox">
                                                <asp:CheckBox ID="checkbox" runat="server" />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label for="DdlClassType" class="txt__required">Active</label>
                                            <div class="checkbox">
                                                <asp:CheckBox ID="checkbox1" runat="server" />
                                            </div>
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

            <div class="modal fade" id="deletevdo" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel-del" aria-hidden="true">
                <div class="modal-dialog modal-dialog-centered" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <h5 class="modal-title" id="exampleModalLabel-del"><span id="TypeTitle-del"></span>Video Training</h5>
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                                <span aria-hidden="true">&times;</span>
                            </button>
                        </div>
                        <div class="modal-body">
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label for="DdlClassType" class="txt__required">Title</label>
                                            <asp:TextBox ID="ftitle" runat="server" CssClass="form-control" MaxLength="150" Enabled="false"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="col-sm-12">
                                <div class="row">
                                    <div class="col-sm-12">
                                        <div class="form-group">
                                            <label for="DdlClassType" class="txt__required">Department</label>
                                            <asp:TextBox ID="fdept" runat="server" CssClass="form-control" MaxLength="150" Enabled="false"></asp:TextBox>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="modal-footer">
                            <asp:LinkButton ID="deletevdobtn" runat="server" CssClass="btn btn-danger" OnClientClick="return false;"><i class="fas fa-trash pr-1" ></i><span id="btndelete">Delete</span></asp:LinkButton>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <asp:HiddenField ID="cnt" runat="server" />
    <asp:HiddenField ID="mcnt" runat="server" />
    <asp:HiddenField ID="HdnStaffName" runat="server" />
    <asp:HiddenField ID="HdnPage" runat="server" />
    <asp:HiddenField ID="FileID" runat="server" />


</asp:Content>

<asp:Content ID="FooterContent" ContentPlaceHolderID="cphFooter" runat="server">
    <script src="<%= ResolveClientUrl("~/Scripts/sweetalert.min.js") %>"></script>
    <script src="<%=ResolveClientUrl("~/Scripts/jquery.blockUI.js")%>"></script>
    <link href="<%=ResolveClientUrl("~/Content/jquery-ui.min.css")%>" rel="stylesheet" />
    <script src="<%=ResolveClientUrl("~/Scripts/jquery-ui.min.js")%>"></script>

    <script type="text/javascript">
        var counter = 0;
        function AddFileUpload() {
            var isMobileVersion = document.getElementsByClassName('p-3');
            if (isMobileVersion.length === 0) {
                var element = document.getElementById("cphBody_btnUpload");
                element.classList.remove("invisible");
            }
            var div = document.createElement('DIV');
            div.innerHTML = '<div class="col-md-3"><h6>File: </h6><input id="file' + counter + '" name = "file' + counter + '" type="file" class="form-control" accept="video/*" required/></div> <div class="col-md-2"><h6>Department: </h6><select id="txtFile' + counter + '" name="txtFile' + counter + '" class="form-control" required><option value=""> </option><option value="Sale">Sale</option> <option value="IT">IT</option> <option value="HR">HR</option> <option value="Service">Service</option></select></div> <input id="Button' + counter + '" type="button" class="btn btn-danger mt-4" value="Remove" onclick = "RemoveFileUpload(this)" />';
            div.setAttribute('class', 'row jumbotron p-3');
            document.getElementById("FileUploadContainer").appendChild(div);
            counter++;
        }
        function RemoveFileUpload(div) {
            document.getElementById("FileUploadContainer").removeChild(div.parentNode);
            var isMobileVersion = document.getElementsByClassName('p-3');
            if (isMobileVersion.length === 0) {
                var element = document.getElementById("cphBody_btnUpload");
                element.classList.add("invisible");
            }
        }
    </script>

    <script type="text/javascript">
        var counter = 0;
        var mcnt = 0;
        document.getElementById("<%=mcnt.ClientID%>").value = mcnt;
        function AddFileUpload1() {
            var isMobileVersion = document.getElementsByClassName('p-2');
            if (isMobileVersion.length === 0) {
                var element = document.getElementById("cphBody_upvdo");
                element.classList.remove("invisible");
            }
            var div = document.createElement('DIV');
            div.innerHTML = '<div class="col-md-3"><h6>Iframe: </h6><textarea id="txtarea" name="txtarea' + counter + '" rows="3" cols="50" class="form-control" required/></textarea></div> <div class="col-md-2"><h6>Department: </h6><select id="ddl" name="ddl' + counter + '" class="form-control" required><option value=""> </option><option value="Sale">Sale</option> <option value="IT">IT</option> <option value="HR">HR</option> <option value="Service">Service</option></select></div> <div class="col-md-3"><h6>Title: </h6><input type="text" maxlength="100" id="txtFile' + counter + '" class="form-control" name="txtFile' + counter + '" required/></div><div class="col-md-2"><h6>Hilight: </h6><input type="checkbox" id="checkbox' + counter + '" class="form-control" name="checkbox' + counter + '" value="1"></div><input id="Button' + counter + '" type="button" class="btn btn-danger mt-4" value="Remove" onclick = "RemoveFileUpload1(this)" />';
            div.setAttribute('class', 'row jumbotron p-2');
            document.getElementById("FileUploadContainer1").appendChild(div);
            counter++;
            document.getElementById("<%=cnt.ClientID%>").value = counter;
        }
        function RemoveFileUpload1(div) {
            document.getElementById("FileUploadContainer1").removeChild(div.parentNode);
            mcnt++;
            document.getElementById("<%=mcnt.ClientID%>").value = mcnt;
            var isMobileVersion = document.getElementsByClassName('p-2');
            if (isMobileVersion.length === 0) {
                var element = document.getElementById("cphBody_upvdo");
                element.classList.add("invisible");
            }
        }
    </script>

    <script>
        $("#<%=btnsubmit.ClientID%>").click(function () {
            var fileID = document.getElementById('<%=FileID.ClientID%>').value;
            var filename = document.getElementById('<%=FileName.ClientID%>').value;
            var filetitle = document.getElementById('<%=Title.ClientID%>').value;
                var filedept = document.getElementById('<%=DdlDept.ClientID%>').value;
                var filehigh = document.getElementById('<%=checkbox.ClientID%>').checked;
            var filestat = document.getElementById('<%=checkbox1.ClientID%>').checked;

            var Highlight;
            var FStatus;

            if (filehigh == true) {
                Highlight = "1";
            } else if (filehigh == false) {
                Highlight = "0";
            }

            if (filestat == true) {
                FStatus = "1";
            } else if (filestat == false) {
                FStatus = "0";
            }


            if (filename == "") {
                $("#<%=FileName.ClientID%>").addClass("validate_error");
                } else {
                    $("#<%=FileName.ClientID%>").removeClass("validate_error");
                }

                if (filetitle == "") {
                    $("#<%=Title.ClientID%>").addClass("validate_error");
            } else {
                $("#<%=Title.ClientID%>").removeClass("validate_error");
                }

                if (filename != "" && filetitle != "") {
                    sweetwarning(fileID, filename, filetitle, filedept, Highlight, FStatus);
                }
        });

        $("#<%=deletevdobtn.ClientID%>").click(function () {
            var fileID = document.getElementById('<%=FileID.ClientID%>').value;
            sweetwarningdel(fileID);
        });

        $(".vdodel").click(function () {
            OnDeleteClick(this);
        });

        $(".vdoedit").click(function () {
            OnEditClick(this);
        });

        function OnDeleteClick(sv) {
            document.getElementById("btndelete").innerHTML = "Delete ";
            document.getElementById("TypeTitle-del").innerHTML = "Delete ";
            var fid = $(sv).closest("td").attr("fid");
            var ftitle = $(sv).closest("td").attr("ftitle");
            var fdept = $(sv).closest("td").attr("fdept");

            document.getElementById('<%=ftitle.ClientID%>').value = ftitle;
                document.getElementById('<%=fdept.ClientID%>').value = fdept;
                document.getElementById('<%=FileID.ClientID%>').value = fid;

            $('#deletevdo').modal('toggle');
            }

            function OnEditClick(sv) {
                document.getElementById("btncreate").innerHTML = "Edit ";
                document.getElementById("TypeTitle").innerHTML = "Edit ";
                var fid = $(sv).closest("td").attr("fid");
                var fname = $(sv).closest("td").attr("fname");
                var ftitle = $(sv).closest("td").attr("ftitle");
                var fdept = $(sv).closest("td").attr("fdept");
                var status = $(sv).closest("td").attr("fstatus");
                var hilight = $(sv).closest("td").attr("fhigh");

                document.getElementById('<%=FileName.ClientID%>').value = fname;
            document.getElementById('<%=Title.ClientID%>').value = ftitle;
            document.getElementById('<%=DdlDept.ClientID%>').value = fdept;
                document.getElementById('<%=FileID.ClientID%>').value = fid;
                if (hilight == "True") {
                    document.getElementById('<%=checkbox.ClientID%>').checked = true;
                }
                else if (hilight == "False" || hilight == "") {
                    document.getElementById('<%=checkbox.ClientID%>').checked = false;
                }
                if (status == "1") {
                    document.getElementById('<%=checkbox1.ClientID%>').checked = true;
                }
                else {
                    document.getElementById('<%=checkbox1.ClientID%>').checked = false;
                }
                $('#addpointactivity').modal('toggle');
            }

            function sweetwarning(fileID, filename, filetitle, filedept, Highlight, FStatus) {
                swal({
                    title: "Confirm Edit?",
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

                            var User = document.getElementById('<%=HdnStaffName.ClientID%>').value;
                        $.ajax({
                            url: '<%=ResolveUrl("FileUpload.aspx/Onsubmit") %>',
                                data: "{ 'FileID': '" + fileID + "','FileName': '" + filename + "', 'FileTitle': '" + filetitle + "', 'User': '" + User + "', 'FileDepartment': '" + filedept + "', 'FileHighlight': '" + Highlight + "', 'FileStatus': '" + FStatus + "'}",
                                dataType: "json",
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                success: function (data) {
                                    //$.unblockUI();
                                    if (data.d === 'true') {
                                        window.location = "<%= ResolveUrl("~/CMSView/FileUpload.aspx") %>";
                                    } else if (data.d === 'false') {
                                        swal("Error message!", "Incomplete data record")
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


        function sweetwarningdel(fileID) {
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
                        doWaitng();

                        var User = document.getElementById('<%=HdnStaffName.ClientID%>').value;
                            $.ajax({
                                url: '<%=ResolveUrl("FileUpload.aspx/OnDelete") %>',
                                data: "{ 'FileID': '" + fileID + "', 'User': '" + User + "'}",
                                dataType: "json",
                                type: "POST",
                                contentType: "application/json; charset=utf-8",
                                success: function (data) {
                                    //$.unblockUI();
                                    if (data.d === 'true') {
                                        window.location = "<%= ResolveUrl("~/CMSView/FileUpload.aspx") %>";
                                    } else if (data.d === 'false') {
                                        swal("Error message!", "Incomplete data record")
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

    <script>
            $("#cancelAdd").click(function () {
                const myNode = document.getElementById("FileUploadContainer1");
                myNode.innerHTML = '';
                var element = document.getElementById("cphBody_upvdo");
                element.classList.add("invisible");
                const myNode1 = document.getElementById("FileUploadContainer");
                myNode1.innerHTML = '';
                var element1 = document.getElementById("cphBody_btnUpload");
                element1.classList.add("invisible");
            });
    </script>

    <script>
            $("#nav-home-tab").click(function () {
                const myNode = document.getElementById("FileUploadContainer1");
                myNode.innerHTML = '';
                var element = document.getElementById("cphBody_upvdo");
                element.classList.add("invisible");
            });
    </script>

    <script>
            $("#nav-profile-tab").click(function () {
                const myNode = document.getElementById("FileUploadContainer");
                myNode.innerHTML = '';
                var element1 = document.getElementById("cphBody_btnUpload");
                element1.classList.add("invisible");
            });
    </script>

    <script>
            $("#<%=BtnSearch.ClientID%>").click(function () {
                document.getElementById("<%=HdnPage.ClientID%>").value = "1";
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
    </script>

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

        .fontgreen {
            color: green;
        }

        .fontred {
            color: red;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {
            $('#training').addClass("active");
        });
    </script>
</asp:Content>
