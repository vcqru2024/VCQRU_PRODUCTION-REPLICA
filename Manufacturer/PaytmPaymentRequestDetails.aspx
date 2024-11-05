<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="PaytmPaymentRequestDetails.aspx.cs" Inherits="Manufacturer_PaytmPaymentRequestDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

            $(".accordion2 p").eq(36).addClass("active");
            $(".accordion2 div.open").eq(30).show();

            $(".accordion2 p").click(function () {
                $(this).next("div.open").slideToggle("slow")
                    .siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });


        });

        $(function () {
            debugger;

            $('[id*=chkselected]').on('change', function () {

                debugger;
                var value = 0;
                $('[id*=chkselected]:checked').each(function () {
                    var row = $(this).closest('tr');
                    value = value + parseInt(row.find('[id*=lblTotalPoints]').html());
                });

                /*$('[id*=lblpoint]').html(value);*/
                debugger;

                // document.getElementById("hftotal").value = value;

                // $("input[id=hftotal]").val(value)
                //  $('[id*=hftotal]').val(value);
            });
        });

        var txtamount = 0;
        function Confirm() {
            debugger;
            //Calculation();
            var confirm_value = document.createElement("INPUT");
            confirm_value.type = "hidden";
            confirm_value.name = "confirm_value";
            var value = 0;
            $('[id*=chkselected]:checked').each(function () {
                var row = $(this).closest('tr');
                value = value + parseInt(row.find('[id*=lblTotalPoints]').html());
           
            });

            var grid = document.getElementById("<%= GridView1.ClientID%>");
            for (var i = 0; i < grid.rows.length - 1; i++) {
                txtamount = $("input[id*=txtTotalPoints]")
                if (txtamount[i].value != '') {
                    /*alert(txtamount[i].value);*/
                    break
                }
            }

            /*$('[id*=lblpoint]').html(value);*/
            /*var hft = $('#hftotal').val();*/
            <%--var label = document.getElementById("#<%=lblpoint.ClientID %>").innerHTML;--%>
            <%--var label = document.getElementById("<%=lblpoint.ClientID %>").value();--%>
            debugger;
            if (confirm("Are you sure you want to proceed this payment for Rs. " + txtamount[i].value + " ?")) {
                confirm_value.value = "Yes";
            } else {
                confirm_value.value = "No";
            }
            document.forms[0].appendChild(confirm_value);
        }

      <%-- function Calculation() {
            debugger;
            var grid = document.getElementById("<%= GridView1.ClientID%>");
            for (var i = 0; i < grid.rows.length - 1; i++) {
                txtamount = $("input[id*=ctl00_ContentPlaceHolder1_GridView1_ctl06_txtTotalPoints]")
                if (txtamount[i].value != '') {
                    alert(txtamount[i].value);
                    break
                }
            }
        }--%>

      
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Paytm Payment Request</h4>
                        </header>


                        <%--<asp:HiddenField ID="hftotal" runat="server" />--%>
                        <div class="card-body card-body-nopadding">

                            <%--  <asp:UpdatePanel ID="UpdatePanel1" class="noSizesUpdatePanel" runat="server">
                                <ContentTemplate>
                                    <script type="text/javascript">
                                        alert('<%=message%>');
                                    </script>
                                </ContentTemplate>
                            </asp:UpdatePanel>--%>

                            <div class="form-row">

                                <div class="form-group col-lg-2">
                                    <asp:TextBox ID="txtbalance" CssClass="form-control" runat="server" TextMode="Number" placeholder="Amount" MaxLength="5"></asp:TextBox>
                                </div>
                                <div class="form-group col-lg-3">
                                    <asp:ImageButton ID="btnSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png"
                                        OnClick="btnSearch_Click" ToolTip="Search(Amount)" />
                                </div>


                                <div class="form-group col-lg-3">
                                    <asp:TextBox ID="txtmobile" CssClass="form-control" runat="server" TextMode="Number" placeholder="Mobile no." MaxLength="10"></asp:TextBox>
                                </div>
                                <div class="form-group col-lg-2">
                                    <asp:ImageButton ID="btnSearchmobile" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png"
                                        OnClick="btnSearchmobile_Click" ToolTip="Search(Mobile Number)" />
                                </div>
                                <div class="form-group col-lg-2">
                                    <asp:Button ID="btn_download" runat="server" Text="Download" OnClick="btn_download_Click" CssClass="btn btn-primary" />
                                </div>
                                
                             

                            </div>
                            <div class="form-row" style="text-align: center;">
                                <p>Products eligibile for paytm payout: SERIES 5, SERIES 6, SERIES 7, SERIES 8</p>
                            </div>
                            <br />
                            <hr />


                            <asp:UpdatePanel ID="up1" runat="server">
                                <ContentTemplate>

                                    <div class="row">
                                        <div class="col-md-12">
                                            <%--<asp:Label ID="lblpoint" runat="server"></asp:Label>--%>

                                            <asp:GridView ID="GridView1" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false" runat="server" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand" OnRowEditing="GridView1_RowEditing" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDataBound="GridView1_RowDataBound" CssClass="table table-bordered table-hover table-condenced">
                                                <HeaderStyle CssClass="tab-header" />
                                                <Columns>

                                                    <asp:TemplateField HeaderText="S.No.">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Mobile No">
                                                        <ItemTemplate>
                                                            <asp:HiddenField ID="hfM_Consumerid" runat="server" Value='<%# Bind("M_Consumerid")%>'></asp:HiddenField>
                                                            <asp:Label ID="lblMobileNo" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                                                        </ItemTemplate>

                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Consumer Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblConsumerName" runat="server" Text='<%# Bind("ConsumerName") %>'></asp:Label>
                                                        </ItemTemplate>

                                                    </asp:TemplateField>

                                                     <asp:TemplateField HeaderText="Total Points">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTPoints" CssClass="lblTotalPoints" runat="server" Text='<%# Bind("TotalPoints") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Pay Points">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblTotalPoints" CssClass="lblTotalPoints" runat="server" Text='<%# Bind("TotalPoints") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:HiddenField ID="hftotalpoint" runat="server" Value='<%# Bind("TotalPoints")%>'></asp:HiddenField>
                                                            <asp:TextBox ID="txtTotalPoints" runat="server" onblur="Calculation(this.value)"  Text='<%#Eval("TotalPoints") %>'></asp:TextBox>
                                                        </EditItemTemplate>

                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Date & time">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblReqDate" runat="server" Text='<%# Bind("ReqDate") %>'></asp:Label>
                                                        </ItemTemplate>

                                                    </asp:TemplateField>
                                                    <%--<asp:TemplateField HeaderText="Action">

                                                        <HeaderTemplate>

                                                            <asp:CheckBox ID="chkSelectAll" AutoPostBack="true" OnClientClick="Payind()" OnCheckedChanged="chkSelectAll_CheckedChanged"
                                                                class="chkSelectAll" runat="server" />


                                                            All
                                                        <asp:HiddenField ID="gmobileno" runat="server" Value='<%#Eval("TotalPoints") %>' />
                                                        </HeaderTemplate>
                                                        <ItemTemplate>
                                                            <asp:CheckBox ID="chkselected" runat="server"></asp:CheckBox>
                                                        </ItemTemplate>

                                                    </asp:TemplateField>--%>
                                                    <asp:TemplateField HeaderText="Pay">
                                                       <%-- <HeaderTemplate>

                                                            <asp:Button ID="btnpayall" Text="Pay All" CssClass="btn btn-success" OnClientClick="Confirm()" OnClick="btnpayall_Click" runat="server" />
                                                        </HeaderTemplate>--%>
                                                        <ItemTemplate>
                                                            <asp:Button ID="btnedit" runat="server" Text="Edit" CommandArgument='<%#Eval("M_Consumerid")%>' CssClass="btn-outline-warning" CommandName="Edit" />

                                                        </ItemTemplate>
                                                        <EditItemTemplate>
                                                            <asp:Button ID="btnpay" OnClientClick="Confirm()" Text="Pay" CommandArgument="<%# Container.DataItemIndex %>" CommandName="PayIndivisual" CssClass="btn btn-danger" runat="server" />&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                            <asp:Button ID="btncancel" runat="server" Text="Cancel" CssClass="btn btn-default" CommandName="Cancel" />
                                                        </EditItemTemplate>
                                                    </asp:TemplateField>

                                                </Columns>

                                            </asp:GridView>
                                        </div>

                                    </div>


                                    </div>


                                    

                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</asp:Content>

