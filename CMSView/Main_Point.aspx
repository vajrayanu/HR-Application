<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Main_Point.aspx.cs" Inherits="CMS_Main_Point" MasterPageFile="~/MasterPage/CMSMasterPage.Master" %>

<asp:Content ID="BodyConntent" ContentPlaceHolderID="cphBody" runat="server">
    <section>
        <div class="container py-5">
            <h3 class="text-uppercase mb-5 font-weight-bold text-lg-left text-md-left text-sm-left text-center block__head">Point</h3>
            <div class="col-12 text-center">
                <div class="row cms__home">
                    <div class="col-lg-4 col-md-6 col-sm-6 col-6 p-2">
                        <a href="<%= ResolveClientUrl("~/CMS/PointActivity") %>" class="">
                            <div class='favorite p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2 app-fav slide-to-bottom'>
                                <div class='row'>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <i class="fas fa-calendar-alt"></i>
                                    </div>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <h6 class=" text-uppercase">Point Activity</h6>
                                        <p class='mb-0 d-lg-block d-md-block d-sm-block d-none'>Add and Edit Point Activity</p>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-6 col-6 p-2">
                        <a href="<%= ResolveClientUrl("~/CMS/PointCondition") %>" class="">
                            <div class='favorite p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2 app-fav slide-to-bottom'>
                                <div class='row'>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <i class="fas fa-medal"></i>
                                    </div>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <h6 class=" text-uppercase">Point Condition</h6>
                                        <p class='mb-0 d-lg-block d-md-block d-sm-block d-none'>Add and Edit Point Condition</p>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-6 col-6 p-2">
                        <a href="<%= ResolveClientUrl("~/CMS/Reward") %>" class="">
                            <div class='favorite p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2 app-fav slide-to-bottom'>
                                <div class='row'>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <i class="fas fa-gift"></i>
                                    </div>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <h6 class=" text-uppercase">Reward</h6>
                                        <p class='mb-0 d-lg-block d-md-block d-sm-block d-none'>Add and Edit Reward</p>
                                    </div>
                                </div>
                            </div>
                        </a>
                    </div>
                    <div class="col-lg-4 col-md-6 col-sm-6 col-6 p-2">
                        <a href="<%= ResolveClientUrl("~/CMS/Redeem") %>" class="">
                            <div class='favorite p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2 app-fav slide-to-bottom'>
                                <div class='row'>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <i class="fas fa-trophy"></i>
                                    </div>
                                    <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-lg-left text-md-left text-sm-center text-center'>
                                        <h6 class=" text-uppercase">Redeem</h6>
                                        <p class='mb-0 d-lg-block d-md-block d-sm-block d-none'>Approve and Reject Redeem Reward</p>
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
            $('#point').addClass("active");
        });
    </script>
</asp:Content>
