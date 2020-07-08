<%@ Page Title="" Language="C#" MasterPageFile="~/masterpage/MasterPage.master" AutoEventWireup="true" CodeFile="TrainingVideo.aspx.cs" Inherits="TrainingVideo" %>

<asp:Content ID="TrainingVideo" ContentPlaceHolderID="MainContent" runat="Server">
    <div class="container">
        <section>
            <div class="row mt-5">
                <div class="col-lg-6 col-md-6 col-sm-12 col-12 page__title">
                    <i class="fab fa-leanpub color-red pr-2"></i>
                    <h2 class="d-inline"><a href="<%= ResolveClientUrl("~/Training") %>" class="header__link">Training/</a> Video</h2>
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
                <asp:Repeater ID="RptVDO" runat="server">
                    <ItemTemplate>
                        <div class="col-lg-4 col-md-6 col-sm-6 col-12 mb-3">
                            <div class="col-12 p-3 block__highlight-title font-weight-bold rounded-top border border-bottom-0">
                                <div class="row">
                                    <div class="col-8">
                                        <h6 class="m-0 text-uppercase font-weight-bold"><%#Eval("File_Dept") %></h6>
                                    </div>
                                    <div class="col-4">
                                        <p class="m-0 text-right">
                                            <a href="<%# ResolveClientUrl("~/Training/Video/More?Dept=") + Eval("File_Dept") %>" class="vacation-popup text-light">More 
                                        <i class="far fa-play-circle pl-1"></i>
                                            </a>
                                        </p>
                                    </div>
                                </div>
                            </div>
                            <div class="col-12 p-0 rounded-bottom border border-top-0 block__video">
                                <a data-id="<%#Eval("File_ID") %>" data-toggle="modal" data-target="#docModal" data-modal-title="<%#Eval("File_Dept") %>" data-file-name="<%#Eval("File_Name") %>">
                                    <i class="fab fa-youtube color-red content-center font-size-50"></i>
                                    <iframe id="IF<%#Eval("File_Dept") %>" width="100%" height="195" src="<%#Eval("File_Name") %>" frameborder="0" allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                                </a>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </section>
    </div>

    <asp:HiddenField ID="HdnStaffName" runat="server" />

    <div class="modal fade bd-example-modal-xl" id="docModal" tabindex="-1" role="dialog" aria-labelledby="docModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl" role="document">
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
