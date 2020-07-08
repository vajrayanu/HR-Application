<%@ Page Language="C#" AutoEventWireup="true" CodeFile="training.aspx.cs" Inherits="CMS_training" MasterPageFile="~/MasterPage/CMSMasterPage.Master" %>

<asp:Content ID="BodyConntent" ContentPlaceHolderID="cphBody" runat="server">
    <section>
        <div class="container py-5">
            <h3 class="text-uppercase mb-5 font-weight-bold text-lg-left text-md-left text-sm-left text-center block__head">training</h3>
            <div class="col-12 text-center">
                <div class="row cms__home">
                    <div class="col-lg-4 col-md-6 col-sm-6 col-6 p-2">
                        <a href="<%= ResolveClientUrl("~/CMS/Calendar") %>" class="">
                            <div class='favorite p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2 app-fav slide-to-bottom'>
                                <div class='row'>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <i class="fas fa-calendar-alt"></i>
                                    </div>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <h6 class=" text-uppercase">Calendar</h6>
                                        <p class='mb-0 d-lg-block d-md-block d-sm-block d-none'>Add Training</p>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-6 col-6 p-2">
                        <a href="<%= ResolveClientUrl("~/CMS/Video") %>" class="">
                            <div class='favorite p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2 app-fav slide-to-bottom'>
                                <div class='row'>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <i class="fas fa-video"></i>
                                    </div>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <h6 class=" text-uppercase">Video</h6>
                                        <p class='mb-0 d-lg-block d-md-block d-sm-block d-none'>Add Video about training</p>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content ID="FooterContent" ContentPlaceHolderID="cphFooter" runat="server">
    <script src="../Scripts/sweetalert.min.js"></script>
    <script src="<%=ResolveClientUrl("~/Scripts/_cms.js")%>"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#training').addClass("active");
        });
    </script>
</asp:Content>
