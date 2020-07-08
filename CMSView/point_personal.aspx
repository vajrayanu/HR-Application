<%@ Page Language="C#" AutoEventWireup="true" CodeFile="point_personal.aspx.cs" Inherits="CMSView_point_personal" MasterPageFile="~/MasterPage/CMSMasterPage.Master"%>

<asp:Content ID="HeadContent" ContentPlaceHolderID="cphHead" runat="server">
</asp:Content>

<asp:Content ID="BodyConntent" ContentPlaceHolderID="cphBody" runat="server">
    <section>
        <div class="container py-5">
            <h3 class="text-uppercase mb-5 font-weight-bold text-lg-left text-md-left text-sm-left text-center block__head">Point personal</h3>
            <div class="row">
                <div class="col-12">
                    <div class="row ">
                        <div class="col-lg-6 col-md-6 col-sm-12 col-12">
                            <label for="ddl_month">Month</label>
                            <div class="input-group mb-3">
                                <select class="custom-select" id="ddl_month">
                                    <option selected>Choose...</option>
                                    <option value="1">January</option>
                                    <option value="2">February</option>
                                    <option value="3">March</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12 col-12">
                            <label for="ddl_year">Year</label>
                            <div class="input-group mb-3">
                                <select class="custom-select" id="ddl_year">
                                    <option selected>Choose...</option>
                                    <option value="1">2019</option>
                                    <option value="2">2020</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12 col-12">
                            <label for="ddl_center">Center</label>
                            <div class="input-group mb-3">
                                <select class="custom-select" id="ddl_center">
                                    <option selected>Choose...</option>
                                    <option value="1">January</option>
                                    <option value="2">February</option>
                                    <option value="3">March</option>
                                </select>
                            </div>
                        </div>
                        <div class="col-lg-6 col-md-6 col-sm-12 col-12">
                            <label for="ddl_sale">Sale/ EC</label>
                            <div class="input-group mb-3">
                                <select class="custom-select" id="ddl_sale">
                                    <option selected>Choose...</option>
                                    <option value="1">2019</option>
                                    <option value="2">2020</option>
                                </select>
                            </div>
                        </div>
                            <div class="col-lg-6 col-md-6 col-sm-12 col-12">
                                <label for="ddl_point">Point</label>
                            <div class="input-group">
                                <select class="custom-select" id="ddl_point">
                                    <option selected>Choose...</option>
                                    <option value="1">2019</option>
                                    <option value="2">2020</option>
                                </select>
                            </div>
                        </div>
                    </div>
                    <div class="col-12 text-center my-5">
                        <button type="button" class="btn btn-light mx-1" onclick="hideForm();"><i class="fas fa-ban pr-1"></i>Cancel</button>
                        <asp:LinkButton ID="submitTarget" runat="server" CssClass="btn btn-success mx-1"><i class="far fa-save pr-1"></i>Save</asp:LinkButton>
                    </div>
                    <hr />
                </div>
                <div class="col-12 form-group text-right">
                        <button type="button" class="btn btn-success" onclick="openForm();"><i class="fas fa-plus pr-1"></i>Add</button>
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
            $('#point').addClass("active");
        });
    </script>
</asp:Content>