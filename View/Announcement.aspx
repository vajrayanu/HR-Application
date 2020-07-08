<%@ Page Language="C#" AutoEventWireup="true" CodeFile="announcement.aspx.cs" Inherits="announcement" MasterPageFile="~/masterpage/MasterPage.master" %>

<asp:Content ID="BodyConntent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <section>
            <div class="row mt-5">
                <div class="col-12 page__title">
                    <i class="fas fa-building color-red pr-2"></i>
                    <h2 class="d-inline">Company Directory</h2>
                </div>
            </div>
        </section>
    </div>

    <div class="container-fluid px-0">
        <section>
            <div class="container-xl text-center px-xl-3 px-0  mt-5 ">
                <div id="carouselExampleCaptions" class="carousel slide" data-ride="carousel">
                    <ol class="carousel-indicators">
                        <asp:Repeater ID="RptSlideNumber" runat="server">
                            <ItemTemplate>
                                <li data-target="#carouselExampleCaptions" data-slide-to="<%# Container.ItemIndex %>" class="<%# Container.ItemIndex == 0 ? "active" : "" %>"></li>
                            </ItemTemplate>
                        </asp:Repeater>
                    </ol>
                    <div class="carousel-inner">
                        <asp:Repeater ID="RptSlide" runat="server">
                            <ItemTemplate>
                                <div class="carousel-item <%# Container.ItemIndex == 0 ? "active" : "" %>">
                                    <img src="<%# ResolveClientUrl("~/images/Announcement/") + Eval("DIR_ID") + "/images/" + Eval("DIR_UploadImage") %>" class="d-block w-100" />
                                    <div class="carousel-caption d-none d-md-block">
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                    <a class="carousel-control-prev" href="#carouselExampleCaptions" role="button" data-slide="prev">
                        <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                        <span class="sr-only">Previous</span>
                    </a>
                    <a class="carousel-control-next" href="#carouselExampleCaptions" role="button" data-slide="next">
                        <span class="carousel-control-next-icon" aria-hidden="true"></span>
                        <span class="sr-only">Next</span>
                    </a>
                </div>
            </div>
        </section>
    </div>
    <div class="container">
        <section>
            <div class="row mt-5">
                <div class="col-12 mb-2">
                    <h4>Announcement <i class="fas fa-bullhorn"></i></h4>
                </div>
                <div class="col-12">
                    <div id="bodyAnnouncement" class="row">
                        <asp:Repeater ID="RptAnnouncement" runat="server">
                            <ItemTemplate>
                                <div class="col-lg-3 col-md-6 col-sm-6 col-6 p-2">
                                    <a <%# Eval("DIR_UploadDoc").ToString().ToLower().Contains(".doc") || Eval("DIR_UploadDoc").ToString().ToLower().Contains(".docx") ? Eval("DIR_Type").ToString() == "1" ? "data-toggle='modal'" : "download='images/Announcement/" + Eval("DIR_ID") + "/document/" + Eval("DIR_UploadDoc") + "' href='images/Announcement/" + Eval("DIR_ID") + "/document/" + Eval("DIR_UploadDoc") + "'" : "data-toggle='modal'" %> data-target="#<%# Eval("DIR_Type").ToString() == "1" ? "ContentModel" : "docModal" %>" data-modal-name="Announcement" data-anid="<%# Eval("DIR_ID") %>" data-modal-title="<%# Eval("DIR_Title") %>" data-file-name="<%# Eval("DIR_Type").ToString() == "1" ? Eval("DIR_UploadImage") : Eval("DIR_UploadDoc") %>">
                                        <div class='favorite p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2 app-fav slide-to-bottom'>
                                            <div class='row'>
                                                <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-center i-app-fav pb-2'>
                                                    <h6 class="font-weight-bold"><%# Eval("DIR_Title") %>
                                                        <%# DateTime.Now < Convert.ToDateTime(Eval("DIR_StartDate")).AddDays(7) ? "<span class='new-app font-weight-normal'>(New)</span>" : "" %>
                                                    </h6>
                                                </div>
                                                <div class='col-lg-12 col-md-12 col-sm-12 col-12 text-center pt-2'>
                                                    <%# Eval("DIR_Type").ToString() == "1" ? "Content Detail <span class='detailclick'>Click</span>" : Eval("DIR_UploadDoc").ToString().ToLower().Contains(".doc") || Eval("DIR_UploadDoc").ToString().ToLower().Contains(".docx") ? "Download <span class='detailclick'>Click</span>" : Eval("DIR_Detail").ToString().Length > 100 ? Eval("DIR_Detail").ToString().Substring(0, 100) + "..." : Eval("DIR_Detail") %>
                                                </div>
                                            </div>
                                        </div>
                                    </a>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                <asp:HiddenField ID="HdnPage" runat="server" Value="1" />
                <asp:HiddenField ID="HdnGroup" runat="server" Value="" />
                <asp:Panel ID="PnMore" runat="server" CssClass="col-12 text-center pt-4">
                    <a id="btnmore"><span class="btn-link slide-to-top">MORE</span></a>
                </asp:Panel>
            </div>
        </section>
    </div>

</asp:Content>
