<%@ Page Title="" Language="C#" MasterPageFile="~/Patanjali/pfl.master" AutoEventWireup="true" CodeFile="FrmGeneratedInvoice.aspx.cs" Inherits="Patanjali_FrmGeneratedInvoice" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(31).addClass("active");
            $(".accordion2 div.open").eq(30).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>
    
    <script type="text/javascript">
        function postbackFromJS(sender, e) {
            var postBack = new Sys.WebForms.PostBackAction();
            postBack.set_target(sender);
            postBack.set_eventArgument(e);
            postBack.performAction();
        }
        function divexpandcollapse(divname) {
            var div = document.getElementById(divname);
            var img = document.getElementById('img' + divname);
            if (div.style.display == "none") {
                div.style.display = "inline";
                img.src = "../Content/images/minus.gif";
            } else {
                div.style.display = "none";
                img.src = "../Content/images/plus.gif";
            }
        }

    </script>

    <script type="text/javascript" language="javascript">

        function openpopup12(x) {
            var winpops = window.open(x, "_blank", "status=no,toolbar=no,location=no,menu=no,width=750,height=250,scrollbars=yes,screenX=0,screenY=0")
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

    <a style="display: block"></a>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

             <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                   
                </ProgressTemplate>
            </asp:UpdateProgress>

              <div class="home-section">
            <div class="app-breadcrumb">
                <div class="row">
                    <div class="col">
                        <h5>Generated Invoice <asp:Label ID="lblmsg" runat="server" CssClass="small_font"></asp:Label></h5>
                    </div>
                    <div class="col">
                        <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                              <li class="breadcrumb-item"><a href="../Patanjali/dashboard.aspx">Dashboard</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Generated Invoice</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>

                   <div id="newMsg" runat="server">
                <p>
                    <asp:Label ID="lblmsgHeader" runat="server"></asp:Label><asp:HiddenField ID="hdCompanyNm"   runat="server" />
                </p>
            </div>

            <!-- table view -->
            <div class="user-role-card">
                <div class="card">
                    <div class="card-body">
                        

                        <div id="NewMsgpop" runat="server">
                    <p>
                        <asp:Label ID="Label2" runat="server"></asp:Label>
                    </p>
                </div>
                        <div class="row">

                             <div class="col">
                                <label for="Product Name" class="form-label">Select Product<span>*</span></label>

                                 <asp:DropDownList ID="ddlproname" runat="server" CssClass="form-select" required ></asp:DropDownList>
                                 
                                <div class="invalid-feedback">Enter valid Product Name.</div>
                            </div>
                            <div class="col">
                                <label for="Product Description" class="form-label">Invoice Number</label>
                                <asp:TextBox ID="txtinvoice" runat="server" CssClass="form-control" MaxLength="10" ></asp:TextBox>
                                

                                <div class="invalid-feedback">Enter valid Invoice Number.</div>
                            </div>
                            <div class="col">
                                <label for="Dispatch Location" class="form-label">Date From</label>
                                <asp:TextBox ID="txtDateFrom" placeholder="Date From" runat="server" Text="" CssClass="form-control"></asp:TextBox>
                                <cc1:CalendarExtender ID="CalendarExtender1dtfrom" TargetControlID="txtDateFrom"
                                        runat="server" Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtenderdtfrom1" runat="server" TargetControlID="txtDateFrom"
                                        MaskType="Date" Mask="99/99/9999">
                                    </cc1:MaskedEditExtender>
                                <div class="invalid-feedback">Enter valid name.</div>
                            </div>
                            <div class="col">
                                <label for="Batch Size" class="form-label">Date To</label>
                                <asp:TextBox ID="txtDateTo" placeholder="Date To" runat="server" Text="" CssClass="form-control"></asp:TextBox>
                                   

                                 <cc1:CalendarExtender ID="CalendarExtender2dtto" TargetControlID="txtDateTo" runat="server"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtendttoder2" runat="server" TargetControlID="txtDateTo"
                                        MaskType="Date" Mask="99/99/9999">
                                    </cc1:MaskedEditExtender>
                                <div class="invalid-feedback">Enter valid name.</div>
                            </div>

                            <div class="col">
                                <label class="form-label text-white">*</label>
                                <br>
                                 <asp:Button ID="btnSearch" OnClick="btnSearch_Click" ValidationGroup="chk94" class="btn btn-primary"
                                    runat="server" Text="Search" />
                            
                                <asp:Button ID="btnRefresh" OnClick="btnRefresh_Click" class="btn btn-success" runat="server" type="reset"
                                    CausesValidation="false" Text="Reset" />
                            </div>

                        </div>
                      <div class="row">
                          <div class="col-lg-6">
													<h4 class="mb-0">Record's Found<span> <asp:Label ID="lblcount" runat="server"></asp:Label>
                                                        <asp:Label ID="lblC" Text="0" runat="server" Visible="false"></asp:Label>
													                                </span></h4>
												</div>
                                                <div class="col-lg-4">
                                                      <asp:Label ID="lbltotalLicence" runat="server"></asp:Label>
                                                </div>
                      </div>

                             <div class="app-table mt-2">
                            
                               <div class="table-responsive">
                                 
                                  <asp:HiddenField ID="docflag" runat="server" />
                 <asp:GridView ID="GrdCodeAllote" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered"
                    ShowFooter="true" EmptyDataText="Record Not Found" OnRowCommand="GrdCodeAllote_RowCommand" BorderColor="transparent" >
                    <Columns>
                        <asp:TemplateField HeaderText="Date">
                            <ItemTemplate>
                                <asp:Label ID="lblInvoiceDate" runat="server" Text='<%# Bind("Invoice_Date","{0:MMM dd, yyyy hh:mm:ss tt}") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="11%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Invoice_No">
                            <ItemTemplate>
                                <asp:Label ID="lblnvoiceID" runat="server" Text='<%# Bind("Invoice_ID") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="8%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Head" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblnvoiceHeadName" runat="server" Text='<%# Bind("Head_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="true" />
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="5%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Company Name">
                            <ItemTemplate>
                                <asp:Label ID="lblInvoiceCompNm" runat="server" Text='<%# Bind("Comp_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="profooterpladueAmt" runat="server" Text="Total"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="true" />
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="20%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="G_Amount">
                            <ItemTemplate>
                                <asp:Label ID="lblnoCodes56" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                    Text='<%# Bind("G_Amount") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="P1" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="true" />
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Right" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Service Tax">
                            <ItemTemplate>
                                <asp:Label ID="lblnoCodes444" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                    Text='<%# Bind("Service_Tax") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="P2" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="true" />
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Right" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="VAT">
                            <ItemTemplate>
                                <asp:Label ID="lblInvoicevat4" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                    Text='<%# Bind("VAT") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="P22" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="true" />
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Right" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="N_Amount">
                            <ItemTemplate>
                                <asp:Label ID="lblInvoiceAmount" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                    Text='<%# Bind("N_Amount") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="P3" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="true" />
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Right" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Adjustment" Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblInvoiceBalance" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                    Text='<%# Bind("Balance") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="P4" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                    Visible="false"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="true" />
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Right" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Pay Amt." Visible="false">
                            <ItemTemplate>
                                <asp:Label ID="lblgInvoicepay" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                    Text='<%# Bind("Net_Pay") %>'></asp:Label>
                            </ItemTemplate>
                            <FooterTemplate>
                                <asp:Label ID="P5" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                    Visible="false"></asp:Label>
                            </FooterTemplate>
                            <FooterStyle HorizontalAlign="Right" Font-Bold="true" />
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Right" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:ImageButton ID="ImgSendMail" runat="server" CausesValidation="false" CommandArgument='<%# Eval("Invoice_ID") + "*" + string.Format("{0:dd-MM-yyyy}", Eval("Invoice_Date")) + "*" +  Eval("Comp_Email") %>'
                                    CommandName="SendMail" Width="12px" Height="13px" ImageUrl="../Content/images/mail.png"
                                    ToolTip="Send Bill Report" />
                                
                                 <a href='<%# ProjectSession.absoluteSiteBrowseUrl+"/Admin/Bill/Invoice/"+ string.Format("{0:dd-MM-yyyy}", Eval("Invoice_Date")) + "/" + Eval("Invoice_ID") + ".pdf" %>' target="_blank">
                                    <img src="../Content/images/vwnm.png" title="Show Report" alt="n" />
                                </a>
                            </ItemTemplate>
                           
                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                        </asp:TemplateField>
                    </Columns>
                  
                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
                
        </div>

            </ContentTemplate>
        <Triggers>
        </Triggers>
    </asp:UpdatePanel>
      
    <script type="text/javascript">
        function performSearch(searchText) {
            $('#ctl00_ContentPlaceHolder1_GrdVwLabelRequest tbody tr').each(function () {
                var row = $(this);
                var found = false;
                row.find('td').each(function () {
                    var cellText = $(this).text().toLowerCase();
                    if (cellText.includes(searchText.toLowerCase())) {
                        found = true;
                        return false; // Exit the loop if found
                    }
                });

                if (found) {
                    row.show();
                } else {
                    row.hide();
                }
            });
        }



    </script>
</asp:Content>

