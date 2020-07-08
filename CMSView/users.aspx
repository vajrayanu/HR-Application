<%@ Page Language="C#" AutoEventWireup="true" CodeFile="users.aspx.cs" Inherits="CMSView_users" MasterPageFile="~/MasterPage/CMSMasterPage.Master" %>

<asp:Content ID="HeadContent" ContentPlaceHolderID="cphHead" runat="server">
    <link rel="stylesheet" href="<%=ResolveClientUrl("~/css/bootstrap-select.css")%>">
    <script src="<%=ResolveClientUrl("~/Scripts/bootstrap/bootstrap.bundle.min.js")%>" type="text/javascript"></script>
    <script src="<%=ResolveClientUrl("~/Scripts/bootstrap/bootstrap-select.min.js")%>" type="text/javascript"></script>
</asp:Content>

<asp:Content ID="BodyConntent" ContentPlaceHolderID="cphBody" runat="server">
    <section>
        <div class="container py-5">
            <h3 class="text-uppercase mb-5 font-weight-bold text-lg-left text-md-left text-sm-left text-center block__head">User Settings</h3>
            <div class="row">
                <div class="col-12 collapse" id="form_userSetting">
                    <div class="row ">
                        <div class="col-12">
                            <label class="control-label" for="ddlGroup">Group </label>
                            <div class="col-lg-6 col-md-12 col-sm-12 col-12 pl-0 input-group mb-3">
                                <asp:DropDownList ID="ddlGroup" name="ddlGroup" CssClass="custom-select" runat="server" Enabled ="true" >
                                    <asp:ListItem Text="All" Value="All"></asp:ListItem>
                                    <asp:ListItem Text="ACC" Value="ACC"></asp:ListItem>
                                    <asp:ListItem Text="CDs-ALL" Value="CDs-ALL"></asp:ListItem>
                                    <asp:ListItem Text="CCOs-ALL" Value="CCOs-ALL"></asp:ListItem>
                                    <asp:ListItem Text="CECs-ALL" Value="CECs-ALL"></asp:ListItem>
                                    <asp:ListItem Text="COACHs-ALL" Value="COACHs-ALL"></asp:ListItem>
                                    <asp:ListItem Text="Corporate" Value="Corporate"></asp:ListItem>
                                    <asp:ListItem Text="ECs-ALL" Value="ECs-ALL"></asp:ListItem>
                                    <asp:ListItem Text="HR" Value="HR"></asp:ListItem>
                                    <asp:ListItem Text="Management" Value="Management"></asp:ListItem>
                                    <asp:ListItem Text="MKT" Value="MKT"></asp:ListItem>
                                    <asp:ListItem Text="Promoter" Value="Promoter"></asp:ListItem>
                                    <asp:ListItem Text="SMs-ALL" Value="SMs-ALL"></asp:ListItem>
                                    <asp:ListItem Text="Tele-MKT-Inbound" Value="Tele-MKT-Inbound"></asp:ListItem>
                                    <asp:ListItem Text="Tele-MKT-M" Value="Tele-MKT-M"></asp:ListItem>
                                    <asp:ListItem Text="Tele-MKT" Value="Tele-MKT"></asp:ListItem>
                                    <asp:ListItem Text="IT" Value="IT"></asp:ListItem>
                                    <asp:ListItem Text="TEACHERs-ALL" Value="TEACHERs-ALL"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12 col-12">
                            <label for="ddlUserName">Name</label>
                            <div class="input-group mb-3">
                                <select id="ddl_center" class="custom-select selectpicker multiselect-list" multiple data-live-search="true" >
                                    <option value="1">January</option>
                                    <option value="2">February</option>
                                    <option value="3">March</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12 col-12">
                            <label for="ddl_sale">Permission</label>
                            <div class="input-group mb-3">
                                <select id="ddlPermission" class="custom-select selectpicker multiselect-list" multiple data-live-search="true" >
                                    <option value="Admin">Admin</option>
                                    <option value="2">Company Directory</option>
                                    <option value="2">Training</option>
                                    <option value="2">Point</option>
                                    <option value="2">HR Form</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12 col-12">
                            <label for="ddl_sale">Status</label>
                            <div class="input-group mb-3">
                                <select id="ddlStatus" class="custom-select">
                                    <option value="live">Live</option>
                                    <option value="pending">Pending</option>
                                    <option value="Leave">Leave</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 text-center my-5">
                        <button type="button" class="btn btn-light mx-1" data-toggle="collapse" data-target="#form_userSetting" aria-expanded="ture" aria-controls="form_userSetting"><i class="fas fa-ban pr-1"></i>Cancel</button>
                        <asp:LinkButton ID="submitTarget" runat="server" CssClass="btn btn-success mx-1"><i class="far fa-save pr-1"></i>Save</asp:LinkButton>
                    </div>
                    <hr />
                </div>
                <div class="col-12 form-group text-right">
                        <button type="button" class="btn btn-success"  data-toggle="collapse" data-target="#form_userSetting" aria-expanded="false" aria-controls="form_userSetting"><i class="fas fa-plus pr-1"></i>Add</button>
                    </div>
                <div class="col-12">
                    <table id="tblLocations" class="table" cellpadding="0" cellspacing="0" border="1">
                        <thead class="thead-dark">
                            <tr>
                                <th>#</th>
                                <th>Image</th>
                                <th>Titel</th>
                                <th>Status</th>
                                <th></th>
                            </tr>
                        </thead>
                        <tbody>
                            <tr>
                                <td>1</td>
                                <td>Goa</td>
                                <td>1</td>
                                <td>Goa</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>2</td>
                                <td>Mahabaleshwar</td>
                                <td>2</td>
                                <td>Goa</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>3</td>
                                <td>Kerala</td>
                                <td>3</td>
                                <td>Goa</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>4</td>
                                <td>Kashmir</td>
                                <td>4</td>
                                <td>Goa</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>5</td>
                                <td>Ooty</td>
                                <td>5</td>
                                <td>Goa</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>6</td>
                                <td>Simla</td>
                                <td>6</td>
                                <td>Goa</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>7</td>
                                <td>Manali</td>
                                <td>7</td>
                                <td>Goa</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>8</td>
                                <td>Darjeeling</td>
                                <td>8</td>
                                <td>Goa</td>
                                <td>1</td>
                            </tr>
                            <tr>
                                <td>9</td>
                                <td>Nanital</td>
                                <td>9</td>
                                <td>Goa</td>
                                <td>1</td>
                            </tr>
                        </tbody>
                    </table>
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
            $('#users').addClass("active");
        });


        $('.multiselect-list').selectpicker('toggle');
    </script>
</asp:Content>