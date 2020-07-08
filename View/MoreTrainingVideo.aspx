<%@ Page Title="" Language="C#" MasterPageFile="~/masterpage/MasterPage.master" AutoEventWireup="true" CodeFile="MoreTrainingVideo.aspx.cs" Inherits="MoreTrainingVideo" %>

<asp:Content ID="MoreTrainingVideo" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container">
        <section>
            <div class="row mt-5">
                <div class="col-lg-6 col-md-6 col-sm-12 col-12 page__title">
                    <i class="fab fa-leanpub color-red pr-2"></i>
                    <h2 class="d-inline"><a href="<%= ResolveClientUrl("~/Training/") %>" class="header__link">Training/</a><a href="<%= ResolveClientUrl("~/Training/Video") %>" class="header__link"> Video/</a> <asp:Label ID="DeptID" runat="server"></asp:Label></h2>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-12 col-12">
                    <div class="form-group has-search float-right m-0">
                        <span class="fa fa-search form-control-feedback"></span>
                        <input type="text" class="form-control" placeholder="Search">
                    </div>
                </div>
            </div>
        </section>

        <section>
            <div class="row mt-5">
                <div class="col-lg-6 col-md-6 col-sm-12 col-12 mb-3 cursor-point">
                    <asp:Repeater ID="RptHVDO" runat="server">
                        <ItemTemplate>
                            <div class="col-12 p-0 rounded border block__video-main">
                                <a data-id="<%#Eval("File_ID") %>" data-toggle="modal" data-target="#docModal" data-modal-title="<%#Eval("File_Title") %>" data-file-name="<%#Eval("File_Name") %>">
                                    <i class="fab fa-youtube color-red content-center font-size-25"></i>
                                </a>
                                <iframe width="100%" height="300" src="<%#Eval("File_Name") %>" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-12 col-12 mb-3">
                    <asp:Repeater ID="RptMoreVDO" runat="server">
                        <ItemTemplate>
                            <div class=" line-dashed pb-2 mb-2 cursor-point">
                                <a class="row" data-id="<%#Eval("File_ID") %>" data-toggle="modal" data-target="#docModal" data-modal-title="<%#Eval("File_Title") %>" data-file-name="<%#Eval("File_Name") %>">
                                    <div class="col-3 pr-0">
                                        <div class="col-12 p-0 rounded border block__video-small">
                                            <i class="fab fa-youtube color-red content-center font-size-25"></i>
                                            <iframe width="100%" height="85" src="<%#Eval("File_Name") %>" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                                        </div>
                                    </div>
                                    <div class="col-9">
                                        <h6 class="text-uppercase"><%#Eval("File_Title") %></h6>
                                        <p class="card-text">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                                    </div>
                                </a>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>
                </div>
            </div>
        </section>
    </div>
    <section class="sec-traning mt-5">
        <div class="container py-5">
            <div class="row ">
                <asp:Repeater ID="RptVDOBottom" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-3 col-md-6 col-sm-6 col-6 px-2 py-lg-0 py-md-2 py-sm-2 py-2 mb-3 block__traning cursor-point">
                            <a data-id="<%#Eval("File_ID") %>" data-toggle="modal" data-target="#docModal" data-modal-title="<%#Eval("File_Title") %>" data-file-name="<%#Eval("File_Name") %>">
                                <div class="p-4 col-12 slide-to-bottom height-full">
                                    <div class="row">
                                        <div class="col-lg-12 col-md-12 col-sm-12 col-12 text-center">
                                            <h6 class="text-uppercase"><%#Eval("File_Title") %></h6>
                                            <p class="mb-0">This is a longer card with supporting text below as a natural lead-in to additional content. This content is a little bit longer.</p>
                                        </div>
                                    </div>
                                </div>
                            </a>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
            <div class="col-12 text-center pt-4">
                <a href="#"><span class="btn-link-gray slide-to-top">MORE</span></a>
            </div>
        </div>
    </section>

    <asp:HiddenField ID="HdnStaffName" runat="server" />

    <div class="modal fade bd-example-modal-xl" id="docModal" tabindex="-1" role="dialog" aria-labelledby="docModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="docModalLabel">Video Training</h5>
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

    <script type="text/javascript">
        $(document).ready(function () {
            $('#home').addClass("active");
        });

        $('#docModal').on('show.bs.modal', function (event) {
            var modal = $(this)
            var button = $(event.relatedTarget)
            var title = button.data('modal-title')
            var fileName = button.data('file-name')
            //var filePath = "https://www.youtube.com/embed/"
            var fileID = button.data('id')
            var User = document.getElementById('<%=HdnStaffName.ClientID%>').value;
                    $("#resultModal").empty();

                    modal.find('.modal-title').text(title)
                    document.getElementById('resultModal').innerHTML = `<iframe width="100%" height='600px' src="${fileName}?autoplay=1" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>`;

                    $.ajax({
                        type: "POST",
                        url: '<%= ResolveUrl("TrainingVideo.aspx/cntVideo") %>',
                        data: "{ 'FileID': '" + fileID + "', 'User': '" + User + "'}",
                        dataType: "json",
                        type: "POST",
                        contentType: "application/json; charset=utf-8",
                        success: function (data) {
                            //alert(response['response']);
                            console.log(data);
                        },
                        error: function () {
                        }
                    });
        });

        $('#docModal').on('hide.bs.modal', function () {
            $("#resultModal").empty();
        });
    </script>
</asp:Content>
