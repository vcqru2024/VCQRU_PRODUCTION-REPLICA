<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="couponstatus.aspx.cs" Inherits="SagarPetro_couponstatus" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid xyz">
        <div class="row">
            <div class="col-lg-12">
                <div class="card card-admin form-wizard profile box_card">
                    <header class="card-header">
                        <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Code Status</h4>
                    </header>

                    <div class="card-body card-body-nopadding">
                        <div class="row">
                            <div class="col-lg-4">
                                <asp:Label ID="LblMsg" Style="display: none;" CssClass="small_font" runat="server"></asp:Label>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-lg-2">
                                <asp:TextBox class="form-control form-control-sm" runat="server" placeholder="Code1" required="" value="" data-msg-required="Please enter Code 1" MaxLength="5" ID="textcodeone" />
                            </div>
                            <div class="col-lg-2">
                                <asp:TextBox class="form-control form-control-sm" runat="server" placeholder="Code2" required="" value="" data-msg-required="Please enter Code 2" MaxLength="8" ID="textcodeTwo" />
                            </div>
                            <div class="col-lg-2">
                                <asp:TextBox class="form-control form-control-sm" runat="server" placeholder="Series" required="" onkeyup="formatSeries(this)" value="" data-msg-required="Please Series" MaxLength="14" ID="txtseries" />
                            </div>
                            <div class="col-lg-2">
                                <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png" ToolTip="Search" OnClick="ImgSearch_Click" />
                                <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" ToolTip="Reset" OnClick="ImgRefresh_Click" />
                            </div>

                        </div>
                        <div class="row mt-3">
                            <div class="col-lg-3">
                                <label class="fw-bold">Product Name : <span id="psnproductname" runat="server"></span></label>
                            </div>
                             <div class="col-lg-3">
                                <label class="fw-bold">Point : <span id="spnpoint" runat="server"></span></label>
                            </div>
                              <div class="col-lg-3">
                                <label class="fw-bold">Cash : <span id="spncash" runat="server"></span></label>
                            </div>
                              <div class="col-lg-3">
                                <label class="fw-bold">Code Status : <span id="spnstatus" runat="server"></span></label>
                            </div>
                        </div>
                        <div class="row" style="margin-top: 2%;">
                            <div class="col-lg-12">
                                <div class="table-responsive table_large">
                                    <asp:GridView ID="GrdCodeEnquiry" runat="server" CssClass="table table-striped tblSorting table-bordered"
                                        EmptyDataText="Record Not Found" BorderColor="transparent">
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

            </div>
        </div>
    </div>

    <script>
        function formatSeries(input) {
            let value = input.value.replace(/[^a-zA-Z0-9]/g, '').toUpperCase();
            let formattedValue = value.match(/.{1,4}/g)?.join('-');
            input.value = formattedValue || value;
        }
</script>

</asp:Content>

