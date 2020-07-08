<%@ Page Language="C#" AutoEventWireup="true" CodeFile="RedeemHistory.aspx.cs" Inherits="RedeemHistory" MasterPageFile="~/masterpage/MasterPage.master" %>

<asp:Content ID="BodyConntent" ContentPlaceHolderID="MainContent" runat="server">
    <style>
        .setpicture {
            margin: auto;
            max-height: 251px;
            max-width: 100%;
            vertical-align: middle;
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
        }

        .picture_reward {
            height: 251px;
            position: relative;
        }

        .point-detail {
            height: 50px;
        }

        .none {
            display: none;
        }

        #btnmore {
            cursor: pointer;
        }
    </style>

    <div class="container">
        <section>
            <div class="row mt-5">
                <div class="col-12 page__title">
                    <i class="fas fa-medal color-red pr-2"></i>
                    <h2 class="d-inline">Redeem History</h2>
                </div>
            </div>
        </section>
        <section>
            <div class="row mt-5">
                <div class="col-12">
                    <div id="bodyreward" class="row">
                        <table id="tblReward" class="table" cellpadding="0" cellspacing="0" border="1">
                            <thead class="thead-dark">
                                <tr>
                                    <th>Reward Name</th>
                                    <th>Quantity</th>
                                    <th>Point</th>
                                    <th>Picture</th>
                                    <th>Status</th>
                                    <th>Request Date</th>
                                </tr>
                            </thead>
                            <tbody id="TableRedeem">
                                <asp:Repeater ID="RptRedeem" runat="server">
                                    <ItemTemplate>
                                        <tr>
                                            <td><%# Eval("RewardName") %></td>
                                            <td><%# Eval("Quantity") %></td>
                                            <td><%# String.Format("{0:N0}", Convert.ToDouble(Eval("Point"))) %></td>
                                            <td><img style="width:150px;" src="<%# ResolveClientUrl("~/images/Reward/" + Eval("RewardPicture")) %>" /></td>
                                            <td><%# Eval("Status").ToString() == "W" ? "Waitng" : Eval("Status").ToString() == "A" ? "Completed" : "Reject" %></td>
                                            <td><%# Convert.ToDateTime(Eval("CreatedDate")).ToString("yyyy-MM-dd HH:mm", new System.Globalization.CultureInfo("en-US")) %></td>
                                        </tr>
                                    </ItemTemplate>
                                </asp:Repeater>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </section>
    </div>
   <script type="text/javascript">
    </script>
</asp:Content>
