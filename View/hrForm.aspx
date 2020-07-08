<%@ Page Language="C#" AutoEventWireup="true" CodeFile="hrForm.aspx.cs" Inherits="hrForm" MasterPageFile="~/masterpage/MasterPage.master"%>

<asp:Content ID="BodyConntent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <section>
            <div class="row mt-5">
                <div class="col-12 page__title">
                    <i class="fas fa-file-alt color-red pr-2"></i><h2 class="d-inline">HR Form</h2>
                </div>
            </div>
        </section>
         <section>
            <div class="row mt-5">
                <div class="col-12">
                    <div class="row">
                        <asp:Repeater ID="RptHRForm" runat="server">
                            <ItemTemplate>
                                <div class="col-lg-3 col-md-6 col-sm-6 col-6 p-2">
                                    <a href="#" class="cursor__default">
                                        <div class='favorite p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2 app-fav slide-to-bottom'>
                                            <div class='row'>
                                                <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-center i-app-fav pb-2'>
                                                    <h6 class="font-weight-bold text-left"> <%# Eval("DIR_Title") %>
                                                        <%--<span class='new-app font-weight-normal'>(New)</span>--%>
                                                    </h6>
                                                </div>
                                                <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-center pt-2'>
                                                    <%--<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.</p>--%>
                                                    <div class="row m-0 p-0">
                                                        <object class="col-6">
                                                            <a data-toggle="modal" data-target="#docModal" data-modal-title="<%# Eval("DIR_Title") %>" data-an-id="<%# Eval("DIR_ID") %>" data-file-name="<%# Eval("DIR_UploadDoc") %>">
                                                                <i class="fas fa-link fa-3x"></i>
                                                                <h6 class="m-0">View</h6>
                                                            </a>
                                                        </object>
                                                        <object class="col-6">
                                                            <a download="<%#  ResolveClientUrl("~/images/Announcement/") + Eval("DIR_ID") + "/document/" + Eval("DIR_UploadDoc") %>" href="<%#  ResolveClientUrl("~/images/Announcement/") + Eval("DIR_ID") + "/document/" + Eval("DIR_UploadDoc") %>" >
                                                                <i class="fas fa-cloud-download-alt fa-3x"></i>
                                                                <h6 class="m-0">Download</h6>
                                                            </a>
                                                        </object>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <%--<div class="col-12 text-center pt-4">
                    <a href="#" target="_blank"><span class="btn-link slide-to-top">read MORE</span></a>
                </div>--%>
            </div>
        </section>
    </div>

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
           $('#hr-form').addClass("active");
       });

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

    </script>
</asp:Content>
