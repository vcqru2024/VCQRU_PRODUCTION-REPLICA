<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="TransactionDetails.aspx.cs" Inherits="Manufacturer_TransactionDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
                <div class="card card-admin form-wizard profile box_card">
                    <header class="card-header">
                        <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Transaction Details</h4>
                        <asp:Label ID="Label3" runat="server" CssClass="astrics"></asp:Label>
                    </header>
                    <div class="card-admin form-wizard medias">
                    <div class="">
                        <div class="pb-2 pt-2 background-section-form">
                            <div class="col-lg-10">
                                <h4 class="mb-0" id="lblcount" runat="server"></h4>
                            </div>
                            <%--<div class="col-lg-2">
                                <asp:DropDownList ID="ddlRowProductCnt" runat="server" class="form-control mb-0">
                                    <asp:ListItem Value="5">25 Rows</asp:ListItem>
                                    <asp:ListItem Value="6">50 Rows</asp:ListItem>
                                    <asp:ListItem Value="100">100 Rows</asp:ListItem>
                                    <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                    <asp:ListItem Value="1000">1000 Rows</asp:ListItem>
                                    <asp:ListItem Value="1001">All Rows</asp:ListItem>
                                </asp:DropDownList>
                            </div>--%>
                            
                        </div>
                        <div class="pb-2 pt-2 background-section-form">
                            <div class="col-lg-10"></div>
                            <div class="col-lg-2">
                                <asp:Button ID="btnDownload" runat="server" Text="Download Excel" OnClick="btnDownload_Click" CssClass="btn btn-primary" CausesValidation="false" />
                            </div>
                            <div class="col-lg-12">
                                <div class="table-responsive">
                                <asp:HiddenField ID="hdnCompId" runat="server" />
                                <asp:GridView ID="gvTransactions" runat="server" AutoGenerateColumns="false" CssClass="grid table table-striped tableSetting table-bordered" EmptyDataText="No Record Found..."
                                    DataKeyNames="TransactionsId" EmptyDataRowStyle-HorizontalAlign="Center" ClientIDMode="Static"
                                    EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0" BorderColor="transparent" AllowPaging="True" PageSize="15">
                                    <Columns>
                                        <asp:TemplateField HeaderText="S.No">
                                            <ItemTemplate><%=++str %></ItemTemplate>
                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="4%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Transaction Process Date">
                                            <ItemTemplate>
                                                <asp:Label ID="TransactionProcessDate" runat="server" Text='<%# Bind("TransactionProcessDate") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="4%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Transaction Process Date">
                                            <ItemTemplate>
                                                <asp:Label ID="TransactionProcessDate" runat="server" Text='<%# Bind("TransactionProcessDate") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="4%" />
                                        </asp:TemplateField>
                                        <%--<asp:TemplateField HeaderText="Customer Name">
                                            <ItemTemplate>
                                                <asp:Label ID="CustomerName" runat="server" Text='<%# Bind("CustomerName") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" />
                                        </asp:TemplateField>--%>
                                        <asp:TemplateField HeaderText="Amount Transferred (Rs)">
                                            <ItemTemplate>
                                                <asp:Label ID="CustomerName" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Transaction Date">
                                            <ItemTemplate>
                                                <asp:Label ID="CustomerName" runat="server" Text='<%# Bind("TransactionDate") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" />
                                        </asp:TemplateField>                                       
                                        <asp:TemplateField HeaderText="Transction Number">
                                            <ItemTemplate>
                                                <asp:Label ID="CustomerName" runat="server" Text='<%# Bind("TransctionNumber") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Balance Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="CustomerName" runat="server" Text='<%# Bind("AccountNumber") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                                    </div>
                            </div>
                        </div>

                    </div>
                </div>
                </div>
                
            </div>
        </div>
             </div>
    </div>
</asp:Content>

