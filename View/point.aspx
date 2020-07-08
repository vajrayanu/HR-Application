<%@ Page Language="C#" AutoEventWireup="true" CodeFile="point.aspx.cs" Inherits="point" MasterPageFile="~/masterpage/MasterPage.master" %>

<asp:Content ID="BodyConntent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <section>
            <div class="row mt-5">
                <div class="col-12 page__title">
                    <i class="fas fa-medal color-red pr-2"></i>
                    <h2 class="d-inline">Point</h2>
                </div>
            </div>
        </section>
        <section>
            <div class="row mt-5">
                <div class="col-12 mb-2"><h4>Reward <i class="fas fa-gift"></i></h4></div>
                <div class="col-12">
                    <asp:HiddenField ID="HdnPage" runat="server" Value="1" />
                    <div id="bodyreward" class="row">
                        <asp:Repeater ID="RptReward" runat="server">
                            <ItemTemplate>
                                <div class="col-lg-3 col-md-6 col-sm-6 col-12 p-3">
                                    <a href="<%# "PointDetail/" + Eval("RW_ID") %>">
                                        <div class="block__point">
                                            <div class="col-12 border border-bottom-0 rounded-top px-0 picture_reward">
                                                <img src="<%#  ResolveClientUrl("~/images/Reward/" + Eval("RewardPicture"))%>" class="img-point" />
                                            </div>
                                            <div class="col-12 border rounded-bottom py-3">
                                                <div class="row">
                                                    <div class="col-12 block__point-detail">
                                                        <p class="font-weight-bold mb-2 point-detail"><%# Eval("RewardName") %></p>
                                                    </div>
                                                    <div class="col-12">
                                                        <p class="color-grey my-2"><%# Eval("RewardStore") %></p>
                                                    </div>
                                                    <div class="col-12 text-right">
                                                        <h2 class="color-red m-0 point-reward d-inline-block font-weight-bold">
                                                            <%# String.Format("{0:N0}", Convert.ToDouble(Eval("RewardPoint"))) %>
                                                        </h2>
                                                        <p class="color-red m-0 pl-1 d-inline-block">Point</p>
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
                <asp:Panel ID="PnMore" runat="server" CssClass="col-12 text-center pt-4">
                    <a id="btnmore" ><span class="btn-link slide-to-top">MORE</span></a>
                </asp:Panel>
            </div>
        </section>
    </div>

    <section class="sec-learn">
        <div class="container">
            <div class="row mt-5">
                <div class="col-lg-6 col-md-12 col-sm-12 col-12 py-5">
                    <div class="col-12 mb-2"><h4>Top <i class="fas fa-trophy color-yellow"></i></h4></div>
                    <div class="blogLifestyle">
                        <asp:Repeater ID="RptTop" runat="server">
                            <ItemTemplate>
                                <div class="col-12 block__life py-3 line-dashed">
                                    <div class="row mb-2">
                                        <div class="col-lg-3 col-md-3 col-sm-6 col-12">
                                            <div class='blog-icon content-center'>
                                                <img src='<%# Eval("Img") %>' />
                                            </div>
                                        </div>
                                        <div class="col-lg-6 col-md-6 col-sm-6 col-12 text-lg-left text-md-left text-sm-left text-center pt-3 pl-0">
                                            <h6 class="text-uppercase font__weight-900"><%# Eval("Fname") + " " + Eval("Lname") %></h6>
                                            <p class="mb-0 color-grey font-size-11"><%# Eval("Department") %></p>
                                            <p class="mb-0 color-grey font-size-11"><%# Eval("Position") %></p>
                                        </div>
                                        <div class="col-lg-3 col-md-3 col-sm-12 col-12 text-lg-right text-md-right text-sm-right text-center pt-3 pl-0">
                                            <h2 class="color-green font__weight-900 m-0 letter-spacing-unset d-lg-block d-md-block d-sm-inline-block d-inline-block"><%# String.Format("{0:N0}", Convert.ToDouble(Eval("Point_Balance"))) %></h2><p class="m-0 pl-2 d-lg-block d-md-block d-sm-inline-block d-inline-block">Point</p>
                                        </div>
                                    </div>
                                </div>
                            </ItemTemplate>
                        </asp:Repeater>
                    </div>
                </div>
                 <div class="col-lg-6 col-md-12 col-sm-12 col-12 tab__get-point py-5">
                     <div class="col-12 mb-2">
                         <h4>How to get point 
                            <i class="fas fa-star color-yellow font-size-18"></i>
                             <i class="fas fa-star-half-alt color-yellow font-size-18"></i>
                             <i class="far fa-star color-yellow font-size-18"></i>
                         </h4></div>
                     <nav class="pt-3 ">
                        <div class="nav nav-tabs" id="nav-tab" role="tablist">
                        <a class="nav-item nav-link active" id="nav-home-tab" data-toggle="tab" href="#nav-home" role="tab" aria-controls="nav-home" aria-selected="true">All</a>
                        <%--<a class="nav-item nav-link" id="nav-profile-tab" data-toggle="tab" href="#nav-profile" role="tab" aria-controls="nav-profile" aria-selected="false">EC</a>
                        <a class="nav-item nav-link" id="nav-contact-tab" data-toggle="tab" href="#nav-contact" role="tab" aria-controls="nav-contact" aria-selected="false">HR</a>--%>
                        </div>
                    </nav>
                    <div class="tab-content" id="nav-tabContent">
                        <div class="tab-pane fade show active p-5 border border-top-0 rounded-bottom bg-red text-light" id="nav-home" role="tabpanel" aria-labelledby="nav-home-tab">
                            Check in on first page get 5 points per day.
                        </div>
                        <%--<div class="tab-pane fade p-5 border border-top-0 rounded-bottom bg-red text-light" id="nav-profile" role="tabpanel" aria-labelledby="nav-profile-tab">Nulla est ullamco ut irure incididunt nulla Lorem Lorem minim irure officia enim reprehenderit. Magna duis labore cillum sint adipisicing exercitation ipsum. Nostrud ut anim non exercitation velit laboris fugiat cupidatat. Commodo esse dolore fugiat sint velit ullamco magna consequat voluptate minim amet aliquip ipsum aute laboris nisi. Labore labore veniam irure irure ipsum pariatur mollit magna in cupidatat dolore magna irure esse tempor ad mollit. Dolore commodo nulla minim amet ipsum officia consectetur amet ullamco voluptate nisi commodo ea sit eu.</div>
                        <div class="tab-pane fade p-5 border border-top-0 rounded-bottom bg-red text-light" id="nav-contact" role="tabpanel" aria-labelledby="nav-contact-tab">Sint sit mollit irure quis est nostrud cillum consequat Lorem esse do quis dolor esse fugiat sunt do. Eu ex commodo veniam Lorem aliquip laborum occaecat qui Lorem esse mollit dolore anim cupidatat. Deserunt officia id Lorem nostrud aute id commodo elit eiusmod enim irure amet eiusmod qui reprehenderit nostrud tempor. Fugiat ipsum excepteur in aliqua non et quis aliquip ad irure in labore cillum elit enim. Consequat aliquip incididunt ipsum et minim laborum laborum laborum et cillum labore. Deserunt adipisicing cillum id nulla minim nostrud labore eiusmod et amet. Laboris consequat consequat commodo non ut non aliquip reprehenderit nulla anim occaecat. Sunt sit ullamco reprehenderit irure ea ullamco Lorem aute nostrud magna.</div>--%>
                    </div>
                </div>
            </div>
        </div>
    </section>
   <script type="text/javascript">
       $(document).ready(function () {
           $('#home').addClass("active");
       });

       $("#btnmore").click(function () {
           var page = document.getElementById('<%=HdnPage.ClientID%>').value;

           $.ajax({
               url: '<%=ResolveUrl("point.aspx/GetReward") %>',
               data: "{ 'page': '" + page + "' }",
               dataType: "json",
               type: "POST",
               contentType: "application/json; charset=utf-8",
               success: function (data) {
                   var obj = JSON.parse(data.d);

                   var Page = obj.Page;
                   var loadmore = obj.loadmore;
                   var Reward = obj.Reward;
                   $.map(Reward, function (product) {
                       var rwid = product.rwid;
                       var Title = product.Title;
                       var Store = product.Store;
                       var Point = product.Point;
                       var Picture = product.Picture;

                       var div = document.createElement("div");
                       div.setAttribute("class", "col-lg-3 col-md-6 col-sm-12 col-12 p-3");

                       var a = document.createElement("a");
                       a.setAttribute("href", "PointDetail/" + rwid);

                       var divblock = document.createElement("div");
                       divblock.setAttribute("class", "block__point");

                       var divbody = document.createElement("div");
                       divbody.setAttribute("class", "col-12 border border-bottom-0 rounded-top px-0 picture_reward");

                       var img = document.createElement("img");
                       img.setAttribute("src", Picture);
                       img.setAttribute("class", "img-point");

                       divbody.appendChild(img);

                       divblock.appendChild(divbody);

                       divbody = document.createElement("div");
                       divbody.setAttribute("class", "col-12 border rounded-bottom py-3");

                       var divsubbody = document.createElement("div");
                       divsubbody.setAttribute("class", "row");

                       var divsubbody2 = document.createElement("div");
                       divsubbody2.setAttribute("class", "col-12");

                       var p = document.createElement("p");
                       p.setAttribute("class", "font-weight-bold mb-1 point-detail");
                       var textnode = document.createTextNode(Title);
                       p.appendChild(textnode);
                       divsubbody2.appendChild(p);
                       divsubbody.appendChild(divsubbody2);

                       divsubbody2 = document.createElement("div");
                       divsubbody2.setAttribute("class", "col-7");

                       p = document.createElement("p");
                       p.setAttribute("class", "color-grey m-0");
                       var textnode = document.createTextNode(Store);
                       p.appendChild(textnode);
                       divsubbody2.appendChild(p);
                       divsubbody.appendChild(divsubbody2);

                       divsubbody2 = document.createElement("div");
                       divsubbody2.setAttribute("class", "col-5 text-right");

                       var h2 = document.createElement("h2");
                       h2.setAttribute("class", "color-red m-0");
                       textnode = document.createTextNode(Point);
                       h2.appendChild(textnode);
                       divsubbody2.appendChild(h2);

                       p = document.createElement("p");
                       p.setAttribute("class", "color-red m-0");
                       var textnode = document.createTextNode("Point");
                       p.appendChild(textnode);
                       divsubbody2.appendChild(p);

                       divsubbody.appendChild(divsubbody2);
                       divbody.appendChild(divsubbody);

                       divblock.appendChild(divbody);

                       a.appendChild(divblock);

                       div.appendChild(a);

                       document.getElementById("bodyreward").appendChild(div);

                       $("#<%=HdnPage.ClientID%>").val(Page);

                       if (loadmore == "1") {
                           $("#MainContent_PnMore").addClass("none");
                       }
                   });
               },
               error: function (response) {
               },
               failure: function (response) {
               }
           });
       });
    </script>
</asp:Content>
