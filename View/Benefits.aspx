<%@ Page Title="" Language="C#" MasterPageFile="~/masterpage/MasterPage.master" AutoEventWireup="true" CodeFile="Benefits.aspx.cs" Inherits="Benefits" %>

<asp:Content ID="benefits" ContentPlaceHolderID="MainContent" runat="server">
    <script src="<%=ResolveClientUrl("~/LoginStyle/vendor/select2/select2.js")%>"></script>
    <script src="<%=ResolveClientUrl("~/LoginStyle/vendor/select2/select2.min.js")%>"></script>
    <link href="<%=ResolveClientUrl("~/LoginStyle/vendor/select2/select2.min.css")%>" rel="stylesheet" />
    <link href="<%=ResolveClientUrl("~/LoginStyle/vendor/select2/select2.css")%>" rel="stylesheet" />
    <script src="<%=ResolveClientUrl("~/LoginStyle/vendor/select2/select2.js")%>"></script>
    <div class="container">
        <section>
            <div class="row mt-5">
                <div class="col-12 page__title">
                    <i class="fa fa-heartbeat color-red pr-2"></i>
                    <h2 class="d-inline">Benefits</h2>
                </div>
            </div>
        </section>

        <section>
            <div class="row mt-5 block__benefits">
                <div class="col-lg-6 col-md-6 col-sm-6 col-12 text-center">
                    <span class="icon-highlight rounded-circle"><i class="fas fa-user-injured content-center"></i></span>
                    <div class="col-12 p-3 block__highlight-title font-weight-bold">
                        <p class="m-0 text-right">
                            Insurance Plan 
                        </p>
                    </div>
                    <div class="col-12 p-0 rounded-bottom border border-top-0">
                        <div class="row">
                            <div class="col-6 py-4 border-right cursor__pointer">
                                <a data-toggle="modal" data-target="#docModal" data-modal-name="Insurance" data-modal-title="Insurance Plan" data-file-name="WallStreet-BenefitSchedule2020-Plan1(TH).pdf">
                                    <div class="card-body">
                                        <i class="fas fa-cloud-download-alt fa-3x"></i>
                                        <h6>THAI</h6>
                                    </div>
                                </a>
                            </div>
                            <div class="col-6 py-4 cursor__pointer">
                                <a data-toggle="modal" data-target="#docModal" data-modal-name="Insurance" data-modal-title="Insurance Plan" data-file-name="WallStreet-BenefitSchedule2020-Plan1(ENG).pdf">
                                    <div class="card-body">
                                        <i class="fas fa-cloud-download-alt fa-3x"></i>
                                        <h6>ENG</h6>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-6 col-md-6 col-sm-6 col-12 p-l mt-lg-0 mt-md-0 mt-sm-0 mt-3 text-center">
                    <span class="icon-highlight rounded-circle"><i class="fas fa-file-contract content-center"></i></span>
                    <div class="col-12 p-3 block__highlight-title font-weight-bold">
                        <p class="m-0 text-right">
                            Policy 
                        </p>
                    </div>
                    <div class="col-12 p-0 rounded-bottom border border-top-0">
                        <div class="row">
                            <div class="col-6 py-4 border-right cursor__pointer">
                                <a data-toggle="modal" data-target="#docModal" data-modal-name="Policy" data-modal-title="Policy" data-file-name="ITTraining_ITPolicyRev2.pdf">
                                    <div class="card-body">
                                        <i class="fas fa-cloud-download-alt fa-3x"></i>
                                        <h6>THAI</h6>
                                    </div>
                                </a>
                            </div>
                            <div class="col-6 py-4 cursor__pointer">
                                <a data-toggle="modal" data-target="#docModal" data-modal-name="Policy" data-modal-title="Policy" data-file-name="ITTraining_ITPolicyRev2.pdf">
                                    <div class="card-body">
                                        <i class="fas fa-cloud-download-alt fa-3x"></i>
                                        <h6>ENG</h6>
                                    </div>
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section>
            <div class="row mt-4">
                <div class="col-12">
                    <h4>Traveling rate <i class="fas fa-route"></i></h4>
                </div>
            </div>
            <div class="m-2">
                <button type="button" id="btnadd" class="btn btn-success" data-toggle="modal" data-target="#myModals"><i class="fas fa-calculator pr-1"></i>Calculate</button>
            </div>
            <asp:GridView ID="GridView1" CssClass="table table-bordered" runat="server" ShowFooter="false" AutoGenerateColumns="false">
                <Columns>
                    <asp:BoundField DataField="start" HeaderText="Start" ReadOnly="true" />
                    <asp:BoundField DataField="end" HeaderText="Destination" ReadOnly="true" />
                    <asp:BoundField DataField="rate" HeaderText="Traveling Rate (Baht)" ReadOnly="true" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:LinkButton CssClass="btn btn-danger" Text="Delete" runat="server" OnClick="OnDelete" CausesValidation="false"></asp:LinkButton>
                        </ItemTemplate>
                    </asp:TemplateField>
                </Columns>
                <EditRowStyle BackColor="#2461BF" />
                <FooterStyle BackColor="#507CD1" Font-Bold="True" ForeColor="White" />
                <HeaderStyle BackColor="#F12C3E" Font-Bold="True" ForeColor="#153359" HorizontalAlign="Left" />
                <PagerStyle BackColor="#B8C9EA" ForeColor="White" HorizontalAlign="Center" />
                <RowStyle BackColor="#EFF3FB" />
                <SelectedRowStyle BackColor="#D1DDF1" Font-Bold="True" ForeColor="#333333" />
            </asp:GridView>

            <div class="row ml-2">
                <h6 class="d-inline mb-0 text__total-line">Total traveling rate: </h6>
                <h2 class="d-inline mb-0 px-3">
                    <u>
                        <asp:Label ID="total" runat="server" CssClass="color-green font-weight-bold text-decoration d-inline" Text="0"></asp:Label>
                    </u>
                </h2>
                <h6 class="d-inline mb-0 text__total-line">THB</h6>
            </div>
        </section>

        <section>
            <div class="row mt-4">
                <div class="col-12">
                    <div class="col-12  border rounded p-4 block__leave-his">
                        <h6 class="font-900">Traveling Scheme</h6>
                        <div class="img-full mt-3">
                            <a data-toggle="modal" data-target="#docModal" data-modal-name="Traveling" data-modal-title="Traveling Scheme" data-file-name="Travelling-Scheme-CHW.png" class="cursor__pointer">
                                <img src="<%=ResolveClientUrl("~/images/Travelling-Scheme-CHW.png")%>" />
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </div>

    <div class="modal fade bd-example-modal-xl" id="docModal" tabindex="-1" role="dialog" aria-labelledby="docModalLabel" aria-hidden="true">
      <div class="modal-dialog modal-xl modal-dialog-centered" role="document">
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

    <div id="myModals" class="modal fade" role="dialog">
        <div class="modal-dialog modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title">Calculate Traveling Rate</h4>
                </div>
                <div class="modal-body">
                    <div class="col-12">
                        <h6>Start</h6>
                        <asp:DropDownList ID="DDLstart" runat="server" CssClass="form-control"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="req" ControlToValidate="DDLstart" ErrorMessage="Please select start" runat="server"></asp:RequiredFieldValidator>
                        <h6>Destination</h6>
                        <asp:DropDownList ID="DDLDest" runat="server" CssClass="form-control"></asp:DropDownList>
                        <asp:RequiredFieldValidator ID="req2" ControlToValidate="DDLDest" ErrorMessage="Please select destination" runat="server"></asp:RequiredFieldValidator>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <asp:LinkButton ID="btn1" runat="server" CssClass="btn btn-success"  OnClick="btnInsert_Click" onServerClick="btnInsert_Click"><i class="fas fa-calculator pr-1" ></i>Calculate</asp:LinkButton>
                </div>
            </div>
        </div>
    </div>

    <script type="text/javascript">
        $('.form-control').select2({
            placeholder: 'Select',
            width: '100%'
        });

        $(document).ready(function () {
            $('#home').addClass("active");
        });

        $('#docModal').on('show.bs.modal', function (event) {
            var modal = $(this)
            var button = $(event.relatedTarget)
            var name = button.data('modal-name')
            var title = button.data('modal-title')
            var fileName = button.data('file-name')
            var filePath = name == 'Traveling' ? "images/" : "images/pdf/"
            var height = name == 'Traveling' ? "" : "height = '650px'"

            document.getElementById('resultModal').innerHTML = "";

            modal.find('.modal-title').text(title)
            document.getElementById('resultModal').innerHTML = `<embed src='${filePath}${fileName}' frameborder='0' width='100%' ${height}/>`;
        });
    </script>

    <style type="text/css">
        input {
            max-width: unset !important; 
        }
    </style>
</asp:Content>
