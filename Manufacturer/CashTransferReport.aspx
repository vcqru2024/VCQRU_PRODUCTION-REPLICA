<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="CashTransferReport.aspx.cs" Inherits="Manufacturer_CashTransferReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<style>
    .dnld {
    }
</style>
<script type="text/javascript">

    $(document).ready(function () {
        $(".accordion2 p").eq(13).addClass("active");
        $(".accordion2 div.open").eq(11).show();
        var company = '<%= Session["CompanyId"].ToString() %>';

        $(".accordion2 p").click(function () {
            $(this).next("div.open").slideToggle("slow")
                .siblings("div.open:visible").slideUp("slow");
            $(this).toggleClass("active");
            $(this).siblings("p").removeClass("active");
        });


        //


    

         });

        function ShowPopup() {
            $("#popModalImages").modal();
        };
    

</script>
<style>
    .hiddencol {
        display: none;
    }

    .ajax__calendar_today {
        padding: 0px 0px 0px 0px;
    }

    .ajax__calendar_dayname {
        padding: 0px 0px 0px 0px;
    }

    .text-wrap {
        word-wrap: break-word;
    
}
</style>
<script type="text/javascript">
    function checklabel(vl) {
        //  PageMethods.checkNewLabel(vl, onCompleteLaebl)
    }

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        <ContentTemplate>--%>
<div class="col-lg-12">

    <div class="sort-destination-loader sort-destination-loader-showing">
        <div class="row portfolio-list sort-destination" data-sort-id="portfolio">
            <div class="col-lg-12 card card-admin form-wizard profile">

                <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                    DisplayAfter="0">
                    <ProgressTemplate>
                        <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%; z-index: 100001; top: 0px;"
                            class="NewmodalBackground">
                            <div style="margin-top: 300px;" align="center">
                                <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                                <span style="color: White;">Please Wait.....<br />
                                </span>
                            </div>
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <header class="card-header">
                    <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Cash Transfer Report</h4>
                    <asp:Label ID="Label3" runat="server" CssClass="astrics"></asp:Label>
                </header>


                <div id="newMsg" runat="server" style="width: 91%;">
                    <p>
                        <asp:Label ID="Label2" runat="server"></asp:Label>
                    </p>
                </div>
                <div class="card-body card-body-nopadding" style="display: none;">
                    <h6>Search</h6>
                    <div class="form-row">
                        <div class="form-group col-lg-6">
                            <span class="req">*</span><label>Award Name</label>
                            <asp:TextBox ID="txtsearchlblname" runat="server" class="form-control form-control-sm" placeholder="Award Name"></asp:TextBox>
                        </div>

                        <div class="form-group col-lg-6">
                            <asp:ImageButton ID="ImgSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                OnClick="ImgSearch_Click" ToolTip="Search" />
                            <asp:ImageButton ID="ImgRefresh" runat="server" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                ToolTip="Reset" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 card card-admin form-wizard medias">
               <div class="form-row" style="margin-top: 10px;">
                            <div class="form-group col-lg-3">
                                <asp:Button ID="btnDownloadExcel" runat="server" Text="Download Report" CausesValidation="false" OnClick="btnDownloadExcel_Click" ValidationGroup="false" CssClass="btn btn-primary btn-block" />
                                </div>
                            </div>
                    <div class="row pb-2 pt-2 background-section-form">
                        <div class="col-lg-10">
                            <h4 class="mb-0">Record(s) found<span> (<asp:Label ID="lblcount" runat="server">kjhkjh</asp:Label>)</span></h4>
                        </div>
                        <div class="col-lg-2">
                            <asp:DropDownList ID="ddlRowProductCnt" runat="server"
                                class="form-control mb-0">
                                <asp:ListItem Value="5">25 Rows</asp:ListItem>
                                <asp:ListItem Value="6">50 Rows</asp:ListItem>
                                <asp:ListItem Value="100">100 Rows</asp:ListItem>
                                <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                <asp:ListItem Value="1000">1000 Rows</asp:ListItem>
                                <asp:ListItem Value="1001">All Rows</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div style="overflow: scroll;height:60vh;">
                        <asp:GridView ID="GrdAwards" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                            DataKeyNames="" EmptyDataText="Record Not Found"
                            BorderColor="transparent"
                            AllowPaging="false" PageSize="15" Font-Size="Smaller" OnRowDataBound="GrdAwards_RowDataBound">
                            <Columns>                      


                                <asp:TemplateField HeaderText="User Name">
                                    <ItemTemplate>
                                        <asp:Label ID="UserName" runat="server" Text='<%# Bind("ConsumerName") %>'></asp:Label>
                                    </ItemTemplate>                                    
                                    <ItemStyle HorizontalAlign="Justify" Width="10%" />
                                </asp:TemplateField>

                                    <asp:TemplateField HeaderText=" Mobile No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblmobile" runat="server" Text='<%# Bind("[Mobileno]") %>'></asp:Label>
                                    </ItemTemplate>                                    
                                    <ItemStyle HorizontalAlign="Justify" Width="10%" />
                                </asp:TemplateField>

								<asp:TemplateField HeaderText="Amount">
                                    <ItemTemplate>
                                        <asp:Label ID="lblpname" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
                                    </ItemTemplate>                                   
                                    <ItemStyle HorizontalAlign="Justify" Width="10%" />
                                </asp:TemplateField>

                                 <asp:TemplateField HeaderText="City">
                                    <ItemTemplate>
                                        <asp:Label ID="City" runat="server" Text='<%# Bind("City") %>'></asp:Label>
                                    </ItemTemplate>
                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                    <ItemStyle HorizontalAlign="Justify" Width="10%" />
                                </asp:TemplateField>

                                   

                                <asp:TemplateField HeaderText="UPI ID">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIFSC_Code" runat="server" Text='<%# Bind("[UPI ID]") %>'></asp:Label>
                                    </ItemTemplate>                                
                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                </asp:TemplateField>                                

                                <asp:TemplateField HeaderText="Payment Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPaymentStatus" runat="server" Text='<%# Bind("[PaymentStatus]") %>'></asp:Label>
                                    </ItemTemplate>                                
                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Transaction Id">
                                    <ItemTemplate>
                                        <asp:Label ID="lblBankRefID" runat="server" Text='<%# Bind("[Transaction_Id]") %>'></asp:Label>
                                    </ItemTemplate>                                
                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Transaction Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTransactionDate" runat="server" Text='<%# Bind("[Transaction_Date]") %>'></asp:Label>
                                    </ItemTemplate>                                
                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Action Date">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1" runat="server" Text='<%# Bind("[Action_Date]") %>'></asp:Label>
                                    </ItemTemplate>                                
                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Payment Remarks" runat="server" Visible="false">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPaymentRemarks" runat="server" Text='<%# Bind("[PaymentRemarks]") %>'></asp:Label>
                                    </ItemTemplate>                                
                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                </asp:TemplateField>

                            </Columns>
                        </asp:GridView>
                    </div>
                

            </div>
        </div>
    </div>
</div>
<div>
</div>


</asp:Content>

