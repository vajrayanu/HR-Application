<%@ Page Language="C#" AutoEventWireup="true" CodeFile="hrForm.aspx.cs" Inherits="CMSView_hrForm" MasterPageFile="~/MasterPage/CMSMasterPage.Master" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="cphHead" runat="server">
    <script src="<%=ResolveClientUrl("~/Scripts/jquery/1.8.3.jquery.min.js")%>" type="text/javascript"></script>
    <link href="<%=ResolveClientUrl("~/css/1.8.24.jquery-ui.css")%>" rel="stylesheet" />
    <script src="<%=ResolveClientUrl("~/Scripts/jquery-ui.min.js")%>" type="text/javascript"></script>
    <script src="<%=ResolveClientUrl("~/Scripts/sweetalert.min.js")%>"></script>

    <script type="text/javascript">
        $.noConflict();
        jQuery(document).ready(function ($) {
            $("tbody").sortable({
                items: 'tr',
                cursor: 'pointer',
                axis: 'y',
                dropOnEmpty: false,
                start: function (e, ui) {
                    ui.item.addClass("selected");
                },
                stop: function (e, ui) {
                    ui.item.removeClass("selected");
                    $(this).find("tr").each(function (index) {
                        $(this).find("td").eq(0).html(index + 1);
                    });
                }
            });
        });
    </script>
</asp:Content>

<asp:Content ID="BodyConntent" ContentPlaceHolderID="cphBody" runat="server">
    <section>            
        <div class="container py-5">
            <h3 class="text-uppercase mb-5 font-weight-bold text-lg-left text-md-left text-sm-left text-center block__head">HR Form</h3>
            <div class="row">
                <div id="form_Announce" class="col-12 collapse">
                    <div class="row">
                        <div class="col-12">
                            <label class="control-label" for="ddlGroup">Group </label>
                            <div class="col-lg-6 col-md-12 col-sm-12 col-12 px-0 input-group mb-3">
                                <asp:DropDownList ID="ddlGroup" name="ddlGroup" CssClass="custom-select" runat="server" Enabled ="true" >
                                    <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="ACC" Value="ACC"></asp:ListItem>
                                    <asp:ListItem Text="CDs-ALL" Value="CDs-ALL"></asp:ListItem>
                                    <asp:ListItem Text="CCOs-ALL" Value="CCOs-ALL"></asp:ListItem>
                                    <asp:ListItem Text="CECs-ALL" Value="CECs-ALL"></asp:ListItem>
                                    <asp:ListItem Text="COACHs-ALL" Value="COACHs-ALL"></asp:ListItem>
                                    <asp:ListItem Text="Corporate" Value="Corporate"></asp:ListItem>
                                    <asp:ListItem Text="ECs-ALL" Value="ECs-ALL"></asp:ListItem>
                                    <asp:ListItem Text="HR" Value="HR"></asp:ListItem>
                                    <asp:ListItem Text="Management" Value="Management"></asp:ListItem>
                                    <asp:ListItem Text="MKT" Value="MKT"></asp:ListItem>
                                    <asp:ListItem Text="Promoter" Value="Promoter"></asp:ListItem>
                                    <asp:ListItem Text="SMs-ALL" Value="SMs-ALL"></asp:ListItem>
                                    <asp:ListItem Text="Tele-MKT-Inbound" Value="Tele-MKT-Inbound"></asp:ListItem>
                                    <asp:ListItem Text="Tele-MKT-M" Value="Tele-MKT-M"></asp:ListItem>
                                    <asp:ListItem Text="Tele-MKT" Value="Tele-MKT"></asp:ListItem>
                                    <asp:ListItem Text="IT" Value="IT"></asp:ListItem>
                                    <asp:ListItem Text="TEACHERs-ALL" Value="TEACHERs-ALL"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-12">
                            <label class="control-label" for="txt_title">Title</label>
                            <div class="input-group mb-3">
                                <asp:TextBox runat="server" ID="txtTitle" name="txtTitle" CssClass="form-control" aria-label="Title" aria-describedby="txtTitle" maxlength="75"></asp:TextBox>
                                <div class="input-group-append">
                                    <span class="input-group-text" id="txt_title">Max 75</span>
                                </div>
                            </div>

                        </div>
                        <div class="col-12">
                            <label class="control-label" for="txtDetail">Detail</label>
                            <div class="input-group mb-3">
                                <asp:TextBox runat="server" ID="txtDetail" name="txtDetail" CssClass="form-control" aria-label="Detail" aria-describedby="txtDetail" TextMode="MultiLine" rows="5"></asp:TextBox>
                                 <div class="invalid-feedback">
                                    Please enter a message in the textarea.
                                </div>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12 col-12">
                            <label class="control-label txt__required" for="startDate">Start Date</label>
                            <asp:TextBox runat="server" ID="txtStartDate" name="txtStartDate" CssClass="form-control mb-3" aria-label="Start Date" aria-describedby="txtStartDate" placeholder="MM/DD/YYYY" maxlength="75"></asp:TextBox>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12 col-12">
                            <label class="control-label" for="endDate">End Date</label>
                            <asp:TextBox runat="server" ID="txtEndDate" name="txtEndDate" CssClass="form-control mb-3" aria-label="End Date" aria-describedby="txtEndDate" placeholder="MM/DD/YYYY" maxlength="75"></asp:TextBox>
                        </div>
                        <div class="col-12" id="blockUploadFile">
                            <label class="control-label txt__required" for="postedFile">Upload Document</label>
                            <div class="input-group mb-3">
                                <div class="custom-file">
                                    <input type="file" class="custom-file-input" Name="postedFile" id="postedFile" aria-describedby="postedFile" accept=".doc,.docx,application/msword,application/vnd.openxmlformats-officedocument.wordprocessingml.document,.pdf,image/*">
                                    <label class="custom-file-label" for="postedFile" aria-describedby="postedFileAddon">Choose file</label>
                                </div>
                                
                            </div>
                        </div>
                    </div>
                    <div class="col-12 text-center my-5">
                        <button type="reset" class="btn btn-light mx-1" data-toggle="collapse" data-target="#form_Announce" aria-expanded="ture" aria-controls="form_Announce"><i class="fas fa-ban pr-1"></i>Cancel</button>
                        <asp:LinkButton ID="submitAnnounce" runat="server" CssClass="btn btn-success mx-1" OnClientClick="submitBtn(); return false;"><i class="far fa-save pr-1" ></i>Save</asp:LinkButton>
                        <asp:Button ID="btnHDConfirm" runat="server" OnClick="BtnSubmit_Click" Text="Confirm" Style="display: none;" />
                    </div>
                    <hr />
                </div>
                <div class="col-12 form-group">
                    <div class="row">
                        <div class="col-lg-9 col-md-9 col-sm-12 col-12">
                            <div class="btn-group btn-group-toggle bg-gradient-light" data-toggle="buttons" aria-label="Type">
                                <label class="btn btn-secondary active">
                                    <input type="radio" name="contentAll" id="contentAll" checked>
                                    All
                                </label>
                                <label class="btn btn-secondary">
                                    <input type="radio" name="typeContent" id="typeContent">
                                    Content
                                </label>
                                <label class="btn btn-secondary">
                                    <input type="radio" name="typeSlide" id="typeSlide">
                                    Slide
                                </label>
                                <label class="btn btn-secondary">
                                    <input type="radio" name="typeDocument" id="typeDocument">
                                    Document
                                </label>
                            </div>
                            <div class="btn-group btn-group-toggle" data-toggle="buttons" aria-label="Status">
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
                                <label class="btn btn-secondary">
                                    <input type="radio" name="statusPanding" id="statusPanding">
                                    Panding
                                </label>
                            </div>
                        </div>
                        <div class="col-lg-3 col-md-3 col-sm-12 col-12 text-right">
                            <button type="button" class="btn btn-success" data-toggle="collapse" data-target="#form_Announce" aria-expanded="false" aria-controls="form_Announce"><i class="fas fa-plus pr-1"></i>Add</button>
                        </div>
                    </div>
                </div>
                                                
                <div class="col-12">
                    <table id="tblLocations" class="table" cellpadding="0" cellspacing="0" border="1">
                        <thead class="thead-dark">
                            <tr>
                                <th>#</th>
                                <th>Image</th>
                                <th>Title</th>
                                <th>Status</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td><a href='#' class='openImg' data-book-id='../assets/slide/2020/hr2.jpg'>
                                        <img src="<%=ResolveClientUrl("~/assets/slide/2020/hr2.jpg")%>" />
                                    </a>
                                </td>
                                <td>1</td>
                                <td>Goa</td>
                                <td class="text-center"><i class="fas fa-pencil-alt mr-2"></i>|<i class="fas fa-trash-alt ml-2"></i></td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Mahabaleshwar</td>
                                <td>2</td>
                                <td>Goa</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Kerala</td>
                                <td>3</td>
                                <td>Goa</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td>Kashmir</td>
                                <td>4</td>
                                <td>Goa</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>5</td>
                                <td>Ooty</td>
                                <td>5</td>
                                <td>Goa</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>6</td>
                                <td>Simla</td>
                                <td>6</td>
                                <td>Goa</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>7</td>
                                <td>Manali</td>
                                <td>7</td>
                                <td>Goa</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>8</td>
                                <td>Darjeeling</td>
                                <td>8</td>
                                <td>Goa</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>9</td>
                                <td>Nanital</td>
                                <td>9</td>
                                <td>Goa</td>
                                <td>1</td>
                            </tr>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
        <div class="modal fade bd-example-modal-lg " id="modalImg" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true">
            <div class="modal-dialog modal-lg modal-dialog-centered" role="document">
            <div class="modal-content modal-body-Img" id="resultImg">
            </div>
            </div>
        </div>
        <asp:HiddenField ID="hdAnnID" runat="server" />
    </section>
</asp:Content>

<asp:Content ID="FooterContent" ContentPlaceHolderID="cphFooter" runat="server">
    <script src="<%=ResolveClientUrl("~/Scripts/_cms.js")%>"></script>

    <!--  jQuery -->
    <script type="text/javascript" src="<%=ResolveClientUrl("~/Scripts/jquery/jquery-1.11.3.min.js")%>" ></script>

    <!-- Isolated Version of Bootstrap, not needed if your site already uses Bootstrap -->
    <link rel="stylesheet" href="<%=ResolveClientUrl("~/css/bootstrap-iso.css")%>"/>

    <!-- Bootstrap Date-Picker Plugin -->
    <script type="text/javascript" src="<%=ResolveClientUrl("~/Scripts/jquery/bootstrap-datepicker.min.js")%>" ></script>
    <link rel="stylesheet" href="<%=ResolveClientUrl("~/css/bootstrap-datepicker3.css")%>" />

    <script type="text/javascript">
        $(document).ready(function () {
            //$("#form_Announce").hide();
            $('#hrForm').addClass("active");

            $.noConflict();
            var date = new Date();
            var today = new Date(date.getFullYear(), date.getMonth(), date.getDate());

            jQuery("#<%=txtStartDate.ClientID%>").datepicker({
                autoclose: true,
                todayHighlight: true,
                startDate: today,
                "setDate": new Date()
            }).on('changeDate', function (selected) {
                var minDate = new Date(selected.date.valueOf());
                jQuery('#<%=txtEndDate.ClientID%>').datepicker('setStartDate', minDate);
            });

            jQuery("#<%=txtEndDate.ClientID%>").datepicker({
                autoclose: true
            }).on('changeDate', function (selected) {
                var minDate = new Date(selected.date.valueOf());
                jQuery('#<%=txtStartDate.ClientID%>').datepicker('setEndDate', minDate);
            });
        });

        $('.custom-file-input').on('change', function () {
            //get the file name
            var fileName = $(this)[0].files[0].name;
            var fileType = $(this)[0].files[0].type;
            var formatFile = /.(pdf|doc|docx|jpg|jpeg|png|gif)$/i;


            if (!fileType.match(formatFile)) {
                swal("Cannot upload!", "Upload image file only!", "error");
                document.getElementById('postedFile').value = "";
                fileName = "Choose file";
            }

            //replace the "Choose a file" label
            $(this).next('.custom-file-label').html(fileName);
        });

        function submitBtn() {
            var confirmValue = document.createElement("INPUT");
            confirmValue.type = "hidden";
            confirmValue.name = "confirmValue";

            var postedFile = document.getElementById('postedFile').files[0];
            var startDate = document.getElementById('<%= txtStartDate.ClientID %>').value;
            var annID = document.getElementById('<%= hdAnnID.ClientID %>').value;
            var jobType = annID != "" ? "update" : "add";

            if (postedFile && startDate) {
                swal({
                    title: "Are you sure?",
                    text: `You will ${jobType} Announcement!`,
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: `Yes, ${jobType}!`,
                    closeOnConfirm: false
                }, function (isConfirm) {
                    swal.close();
                    if (isConfirm) {
                        confirmValue.value = "Yes";
                    } else {
                        confirmValue.value = "No";
                    }
                    document.forms[0].appendChild(confirmValue);
                    document.getElementById("<%= btnHDConfirm.ClientID %>").click();
                });
            } else {
                swal(`Cannot ${jobType}!`, "Image Slide or Start Date is empty!", "error");
            }
        }


        $('.openImg').click(function () {
            var imagePath = this.dataset.bookId;

            document.getElementById('resultImg').innerHTML = "";
            $('.modal-body-Img').load("", function () {
                $('#modalImg').modal({ show: true });
                $('#modalImg').appendChild(`<img src="${imagePath}" />`);
            });
        });
</script>
</asp:Content>

