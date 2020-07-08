<%@ Page Language="C#" AutoEventWireup="true" CodeFile="requestTimeOff.aspx.cs" Inherits="requestTimeOff" MasterPageFile="~/masterpage/MasterPage.master" %>

<asp:Content ID="BodyConntent" ContentPlaceHolderID="MainContent" runat="server">
    <div class="container">
        <section>
            <div class="row mt-5">
                <div class="col-8 page__title">
                    <i class="fas fa-clock color-red pr-2"></i><h2 class="d-inline">Request Time Off</h2>
                </div>
                <div class="col-4">
                    <a class="external__link" href="http://ihr.wallstreetenglish.in.th/webtime/default1.aspx" target="_blank">
                        <span class="btn__link-app float-right rounded-circle text-center" data-toggle="tooltip" title="i-Hr" data-placement="left"><i class="fas fa-external-link-alt"></i></span>
                    </a>
                </div>
            </div>
        </section>
        <section>
            <div class="row mt-5">
                <div class="col-lg-3 col-md-6 col-sm-6 col-12 text-center">
                    <span class="icon-highlight rounded-circle"><i class="fas fa-umbrella-beach content-center"></i></span>
                    <div class="col-12 p-3 block__highlight-title font-weight-bold">
                        <p class="m-0 text-right">Annual leave
                            <a href="#" class="vacation-popup" title="Vacation/ Annual leave" data-toggle="popover" data-placement="bottom">
                                <i class="fas fa-ellipsis-v pl-2"></i>
                            </a>
                        </p>
                    </div>
                    <div class="col-12 p-5 rounded-bottom border border-top-0">
                        <h1 class="d-inline text-highlight text-weight-bold"><%= annualLeave %></h1>
                        <p class="d-inline">/<%= totalAnnualLeave %><span class="ml-2">days</span></p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-12 p-l mt-lg-0 mt-md-0 mt-sm-0 mt-3 text-center">
                    <span class="icon-highlight rounded-circle"><i class="fas fa-thermometer-three-quarters content-center"></i></span>
                    <div class="col-12 p-3 block__highlight-title font-weight-bold">
                        <p class="m-0 text-right">Sick leave 
                            <a href="#" class="sickLeave-popup" title="Sick leave" data-toggle="popover" data-placement="bottom">
                                <i class="fas fa-ellipsis-v pl-2"></i>
                            </a>
                        </p>
                    </div>
                    <div class="col-12 p-5 rounded-bottom border border-top-0">
                        <h1 class="d-inline text-highlight text-weight-bold"><%= sickLeave %></h1><p class="d-inline ">/<%= totalSickLeave %><span class="ml-2">days</span></p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-12 p-l mt-lg-0 mt-md-3 mt-sm-3 mt-3 text-center">
                    <span class="icon-highlight rounded-circle"><i class="fab fa-creative-commons-nc content-center"></i></span>
                    <div class="col-12 p-3 block__highlight-title font-weight-bold">
                        <p class="m-0 text-right">Leave without pay
                            <a href="#" class="withOutPayLeave-popup" title="Leave without pay" data-toggle="popover" data-placement="bottom">
                                <i class="fas fa-ellipsis-v pl-2"></i>
                            </a>
                        </p>
                    </div>
                    <div class="col-12 p-5 rounded-bottom border border-top-0">
                        <h1 class="d-inline text-highlight text-weight-bold"><%= withOutPayLeave %></h1><p class="d-inline "><span class="ml-2">days</span></p>
                    </div>
                </div>
                <div class="col-lg-3 col-md-6 col-sm-6 col-12 p-l mt-lg-0 mt-md-3 mt-sm-3 mt-3 text-center">
                    <span class="icon-highlight rounded-circle"><i class="fas fa-info content-center"></i></span>
                    <div class="col-12 p-3 block__highlight-title font-weight-bold">
                        <p class="m-0 text-right">Other Leave
                            <a href="#" class="otherLeave-popup" title="Other Leave" data-toggle="popover" data-placement="bottom">
                                <i class="fas fa-ellipsis-v pl-2"></i>
                            </a>
                        </p>
                    </div>
                    <div class="col-12 p-5 rounded-bottom border border-top-0">
                        <h1 class="d-inline text-highlight text-weight-bold"><%= otherLeave %></h1><p class="d-inline "><span class="ml-2">days</span></p>
                    </div>
                </div>
            </div>
        </section>
        <section>
            <div class="row mt-4">
                <div class="col-12">
                    <div class="col-12  border rounded p-4 block__leave-his">
                        <h6 class="font-900">Leave history</h6>
                        <table class="col-12 tb-leaveHis" runat="server" id="tbLeaveHis">
                            <thead>
                                <tr>
                                    <th></th>
                                    <th>Start</th>
                                    <th>End</th>
                                    <th>Total leave</th>
                                    <th>Type of leave</th>
                                    <th>Count</th>
                                    <th>Status</th>
                                    <th>Approver</th>
                                </tr>
                            </thead>
                        </table>
                    </div>
                    <div class="col-6 p-2">
                        <span class="color-green"><i class="fas fa-check-circle"></i> Approve</span>
                        <span class="ml-3 "><i class="fas fa-hourglass-half"></i> Pending</span>
                        <span class="ml-3 color-red"><i class="fas fa-times-circle"></i> Reject</span>
                    </div>
                </div>
            </div>
        </section>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {
            $('#home').addClass("active");

            $('.vacation-popup').popover({
                html: true,
                content: "<ol class='pl-3'><%=lastVacation %></ol>"
            }).click(function () {
                setTimeout(function () {
                    $('.vacation-popup').popover('hide');
                }, 3000);
            });

            $('.sickLeave-popup').popover({
                html: true,
                content: "<ol class='pl-3'><%=lastSickLeave %></ol>"
            }).click(function () {
                setTimeout(function () {
                    $('.sickLeave-popup').popover('hide');
                }, 3000);
            });

            $('.withOutPayLeave-popup').popover({
                html: true,
                content: "<ol class='pl-3'><%=lastWithOutPay %></ol>"
            }).click(function () {
                setTimeout(function () {
                    $('.withOutPayLeave-popup').popover('hide');
                }, 3000);
            });

            $('.otherLeave-popup').popover({
                html: true,
                content: "<ol class='pl-3'><%=lastOtherLeave %></ol>"
            }).click(function () {
                setTimeout(function () {
                    $('.otherLeave-popup').popover('hide');
                }, 3000);
            });
        });
    </script>
</asp:Content>