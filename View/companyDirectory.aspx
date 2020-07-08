<%@ Page Language="C#" AutoEventWireup="true" CodeFile="companyDirectory.aspx.cs" Inherits="companyDirectory" MasterPageFile="~/masterpage/MasterPage.master" %>

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
                    <a id="btnmore" ><span class="btn-link slide-to-top">MORE</span></a>
                </asp:Panel>
                <%--<div class="col-12 text-center pt-4">
                    <a href="#" target="_blank"><span class="btn-link slide-to-top">read MORE</span></a>
                </div>--%>
            </div>
        </section>
        <section>
            <div class="row mt-5">
                <div class="col-12 mb-2">
                    <h4>Organization Chart <i class="fas fa-sitemap"></i></h4>
                </div>
            </div>
        </section>
    </div>
    <div class="container-xl">
        <section>
            <div class="row">
                <div class="col-12 img__organization">
                    <a data-toggle="modal" data-target="#docModal" data-modal-name="org" data-modal-title="Organization Chart" data-file-name="ORG-chartV2.png">
                        <img src="<%=ResolveClientUrl("~/images/ORG-chartV2.png")%>" />
                    </a>
                </div>
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

    <div class="modal fade bd-example-modal-xl" id="ContentModel" tabindex="-1" role="dialog" aria-labelledby="ContentModelLabel" aria-hidden="true">
        <div class="modal-dialog modal-xl" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="ContentModelLabel">New message</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body" id="resultDetail">
                    <div id="rpicture">
                        <img id="imgpic" style="width:100%; text-align:center;" />
                    </div>
                    <div id="rdetail"></div>
                    <div id="rDoc" >
                        <div class="row">
                            <object class="col-6 col-lg-1">
                                <a id="rDocView" data-toggle="modal" data-target="#docModal" style="float:left; margin-right:20px;" >
                                    <i class="fas fa-link fa-3x"></i>
                                    <h6 class="m-0">View</h6>
                                </a>
                            </object>
                            <object class="col-6 col-lg-1">
                                <a id="rDocDownload" style="float:left;"  >
                                    <i class="fas fa-cloud-download-alt fa-3x"></i>
                                    <h6 class="m-0">Download</h6>
                                </a>
                            </object>
                        </div>
                    </div>
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
            var name = button.data('modal-name')
            var title = button.data('modal-title')
            var fileName = button.data('file-name')
            var anid = button.data('anid')
            var filePath = name == 'org' ? "images/" : "images/Announcement/" + anid + "/document/";

            document.getElementById('resultModal').innerHTML = "";

            modal.find('.modal-title').text(title)
            document.getElementById('resultModal').innerHTML = `<embed src='${filePath}${fileName}' frameborder='0' width='100%' height='650px'/>`;
        });

        $('#ContentModel').on('show.bs.modal', function (event) {
            var modal = $(this)
            var button = $(event.relatedTarget)
            var name = button.data('modal-name')
            var title = button.data('modal-title')
            var fileName = button.data('file-name')
            var anid = button.data('anid')
            var filePath = name == 'org' ? "images/" : "images/Announcement/" + anid + "/document/";

            var filePathImg = name == 'org' ? "images/" : "images/Announcement/" + anid + "/images/";

            $.ajax({
                url: '<%=ResolveUrl("companyDirectory.aspx/GetDetailAnnouncement") %>',
                data: "{ 'anid': '" + anid + "' }",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var obj = JSON.parse(data.d);

                    var Message = obj.Message;
                    var Detail = obj.Detail;
                    var UploadDoc = obj.UploadDoc;
                    var UploadImage = obj.UploadImage;

                    if (Message == "200") {
                        document.getElementById('rdetail').innerHTML = "";

                        modal.find('.modal-title').text(title)
                        document.getElementById('rdetail').innerHTML = Detail;

                        if (UploadDoc != "") {
                            $("#rDoc").removeClass("d-none");

                            var res = UploadDoc.split(".");
                            var extension = res[1].toUpperCase();

                            if (extension == "DOC" || extension == "DOCX") {
                                $("#rDocView").addClass("d-none");
                            }
                            else {
                                $("#rDocView").attr("data-modal-title", title);
                                $("#rDocView").attr("data-anid", anid);
                                $("#rDocView").attr("data-file-name", UploadDoc);
                            }

                            $("#rDocDownload").attr("download", filePath + UploadDoc);
                            $("#rDocDownload").attr("href", filePath + UploadDoc);
                        }
                        else {
                            $("#rDoc").addClass("d-none");
                        }

                        if (UploadImage != "") {
                            $("#rpicture").removeClass("d-none");

                            $("#imgpic").attr("src", filePathImg + UploadImage)
                        }
                        else {
                            $("#rpicture").addClass("d-none");
                        }
                    } else {
                        swal("Please contact IT!!!!!!", "", "error");
                    }
                },
                error: function (response) {
                },
                failure: function (response) {
                }
            });
        });

        $("#btnmore").click(function () {
            var page = document.getElementById('<%=HdnPage.ClientID%>').value;
            var group = document.getElementById('<%=HdnGroup.ClientID%>').value;

            $.ajax({
                url: '<%=ResolveUrl("companyDirectory.aspx/GetAnnouncement") %>',
                data: "{ 'page': '" + page + "', 'group': '" + group + "' }",
                dataType: "json",
                type: "POST",
                contentType: "application/json; charset=utf-8",
                success: function (data) {
                    var obj = JSON.parse(data.d);

                    var Page = obj.Page;
                    var loadmore = obj.loadmore;
                    var Announcement = obj.Announcement;
                    $.map(Announcement, function (product) {
                        var Title = product.Title;
                        var Detail = product.Detail;
                        var AnnouncementType = product.AnnouncementType;
                        var ANID = product.ANID;
                        var Doc = product.Doc;
                        var Image = product.Image;
                        var StartDate = product.StartDate;

                        var div = document.createElement("div");
                        div.setAttribute("class", "col-lg-3 col-md-6 col-sm-6 col-6 p-2");

                        var a = document.createElement("a");
                        a.setAttribute("data-toggle", "modal");

                        if (AnnouncementType == "1") {
                            a.setAttribute("data-target", "#ContentModel");
                            a.setAttribute("data-file-name", Image);
                        }
                        else {
                            a.setAttribute("data-target", "#docModal");
                            a.setAttribute("data-file-name", Doc);
                        }

                        a.setAttribute("data-modal-name", "Announcement");
                        a.setAttribute("data-anid", ANID);
                        a.setAttribute("data-modal-title", Title);
                        
                        var divblock = document.createElement("div");
                        divblock.setAttribute("class", "favorite p-lg-4 p-md-4 py-sm-4 py-4 px-sm-2 px-2 app-fav slide-to-bottom");

                        var divbody = document.createElement("div");
                        divbody.setAttribute("class", "row");

                        var divbody2 = document.createElement("div");
                        divbody2.setAttribute("class", "col-lg-12 col-md-12 col-sm-12 col-12 text-center i-app-fav pb-2");

                        var h6 = document.createElement("h6");
                        h6.setAttribute("class", "font-weight-bold");
                        var textnode = document.createTextNode(Title);
                        h6.appendChild(textnode);

                        var d = new Date(StartDate);
                        d.setDate(d.getDate() + 7);
                        var dnow = new Date();

                        if (dnow < d) {
                            var span = document.createElement("span");
                            span.setAttribute("class", "new-app font-weight-normal");
                            textnode = document.createTextNode("(New)");
                            span.appendChild(textnode);
                            h6.appendChild(span);
                        }

                        divbody2.appendChild(h6);
                        divbody.appendChild(divbody2);

                        var divbody2 = document.createElement("div");
                        divbody2.setAttribute("class", "col-lg-12 col-md-12 col-sm-12 col-12 text-center pt-2");

                        if (AnnouncementType == "1") {
                            textnode = document.createTextNode("Content Detail ");
                            divbody2.appendChild(textnode);

                            var span = document.createElement("span");
                            span.setAttribute("class", "detailclick");
                            textnode = document.createTextNode("Click");
                            span.appendChild(textnode);
                            divbody2.appendChild(span);
                        }
                        else {
                            if (Detail.length > 100) {
                                var res = Detail.substring(0, 100) + "...";

                                textnode = document.createTextNode(res);
                                divbody2.appendChild(textnode);
                            }
                            else {
                                textnode = document.createTextNode(Detail);
                                divbody2.appendChild(textnode);
                            }
                        }

                        divbody.appendChild(divbody2);

                        divblock.appendChild(divbody);

                        a.appendChild(divblock);

                        div.appendChild(a);

                        document.getElementById("bodyAnnouncement").appendChild(div);

                        $("#<%=HdnPage.ClientID%>").val(Page);
                    });

                    if (loadmore == "1") {
                        $("#MainContent_PnMore").addClass("d-none");
                    }
                },
                error: function (response) {
                },
                failure: function (response) {
                }
            });
        });
    </script>

    <style>
        .detailclick{
            text-decoration:underline;
        }

        #docModal{
            z-index:10000 !important;
        }

        #btnmore{
            cursor:pointer;
        }
    </style>
</asp:Content>

