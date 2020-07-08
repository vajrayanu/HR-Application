<%@ Page Language="C#" AutoEventWireup="true" CodeFile="home.aspx.cs" Inherits="CMSView_home" MasterPageFile="~/MasterPage/CMSMasterPage.Master" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="BodyConntent" ContentPlaceHolderID="cphBody" runat="server">
    <section>
        <div class="container py-5">
            <%--<h3 class="text-uppercase mb-5 font-weight-bold text-lg-left text-md-left text-sm-left text-center block__head">content</h3>--%>
            <div class="col-12 text-center">
                <div class="row cms__home">
                    <div class="col-lg-4 col-md-6 col-sm-6 col-6 p-2">
                        <a href="<%=ResolveClientUrl("~/CMS/CompanyDirectory")%>" class="">
                            <div class='favorite p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2 app-fav slide-to-bottom'>
                                <div class='row'>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <i class="fas fa-building"></i>
                                    </div>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <h6 class=" text-uppercase">Company Directory</h6>
                                        <p class='mb-0 d-lg-block d-md-block d-sm-block d-none'>About Announcement/ Slide or Content</p>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-6 col-6 p-2">
                       <a href="<%= ResolveClientUrl("~/CMS/Training") %>" class="">
                            <div class='favorite p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2 app-fav slide-to-bottom'>
                                <div class='row'>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <i class="fab fa-leanpub"></i>
                                    </div>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <h6 class=" text-uppercase">Training</h6>
                                        <p class='mb-0 d-lg-block d-md-block d-sm-block d-none'>Add Calendar and Video for training</p>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>

                    <div class="col-lg-4 col-md-6 col-sm-6 col-6 p-2">
                        <a href="<%= ResolveClientUrl("~/CMS/Point") %>" class="">
                            <div class='favorite p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2 app-fav slide-to-bottom'>
                                <div class='row'>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <i class="fas fa-medal"></i>
                                    </div>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <h6 class=" text-uppercase">Point</h6>
                                        <p class='mb-0 d-lg-block d-md-block d-sm-block d-none'>Set Point</p>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                    <%--<div class="col-lg-4 col-md-6 col-sm-6 col-6 p-2">
                        <a href="<%= ResolveClientUrl("~/CMS/hrForm") %>" class="">
                            <div class='favorite p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2 app-fav slide-to-bottom'>
                                <div class='row'>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <i class="fas fa-file-alt"></i>
                                    </div>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <h6 class=" text-uppercase">HR Form</h6>
                                        <p class='mb-0 d-lg-block d-md-block d-sm-block d-none'>Add form</p>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>--%>
<%--                    <div class="col-lg-4 col-md-6 col-sm-6 col-6 p-2">
                        <a href="<%=ResolveClientUrl("~/CMS/Users")%>" class="">
                            <div class='favorite p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2 app-fav slide-to-bottom'>
                                <div class='row'>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <i class="fas fa-user-cog"></i>
                                    </div>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <h6 class=" text-uppercase">users</h6>
                                        <p class='mb-0 d-lg-block d-md-block d-sm-block d-none'>Manage user role</p>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>--%>

                </div>
            </div>
        </div>
    </section>
</asp:Content>

<asp:Content ID="FooterContent" ContentPlaceHolderID="cphFooter" runat="server">
    <script src="<%=ResolveClientUrl("~/Scripts/sweetalert.min.js")%>"></script>
    <script src="<%=ResolveClientUrl("~/Scripts/_cms.js")%>"></script>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#home').addClass("active");
        });
    </script>
</asp:Content>
