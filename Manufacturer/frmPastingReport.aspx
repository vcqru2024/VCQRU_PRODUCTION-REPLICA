<%@ Page Title="Printed Labels For Pasting" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master"
    AutoEventWireup="true" CodeFile="frmPastingReport.aspx.cs" Inherits="frmPastingReport" %>

<%--<%@ Register Assembly="CrystalDecisions.Web, Version=10.5.3700.0, Culture=neutral, PublicKeyToken=692fbea5521e1304"
    Namespace="CrystalDecisions.Web" TagPrefix="cr" %>--%>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
    $(document).ready(function () {

        $(".accordion2 p").eq(24).addClass("active");
        $(".accordion2 div.open").eq(20).show();

        $(".accordion2 p").click(function () {
            $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
            $(this).toggleClass("active");
            $(this).siblings("p").removeClass("active");
        });

    });
    </script>

    <script>
function fileTypeCheckeng(mm) {
            PageMethods.checkFile(mm, onengcheck)
        }
        function onengcheck(Result) {
            if (Result == true) {
                document.getElementById("<%=lblfile.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";

            }
            else {
                document.getElementById("<%=lblfile.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
            }
            ChkRegProVal();
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
            <asp:UpdateProgress ID="UpdateProgress1"  runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
                        top: 0px; z-index: 100001;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>

     <div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
            <div class="card card-admin form-wizard profile box_card">
                <header class="card-header">
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Upload Label Pasting Report</h4>
                            </header>
                 
                <div class="card-body card-body-nopadding">
                  <div id="newMsg" runat="server" style="width: 91%;">
                <p>
                    <asp:Label ID="Label2" runat="server"></asp:Label>
                </p>
            </div>
                    <div class="form-row">
                        <div class="form-group col-lg-3">
                           <%-- <label>Dealer Name</label>--%>
                               <asp:DropDownList ID="ddlProduct" OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged"
                                    AutoPostBack="true" runat="server" CssClass="form-control form-control-sm">
                                </asp:DropDownList>
                         
                        </div>  
                        <div class="form-group col-lg-3">
                            <asp:DropDownList ID="ddlBatch" runat="server" CssClass="form-control form-control-sm">
                                </asp:DropDownList>
                                </div>
                        <div class="form-group col-lg-2">
                            <asp:TextBox ID="txtDateFrom" runat="server" Text="" CssClass="form-control form-control-sm" placeholder="Mfd Date From"></asp:TextBox>
                        </div>
                        <div class="form-group col-lg-2">
                            <asp:TextBox ID="txtDateTo" runat="server" Text="" CssClass="form-control form-control-sm" placeholder="Mfd Date To"></asp:TextBox>
                        </div>
                        <div class="form-group col-lg-2">
                            <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary mr-2" ImageUrl="~/Content/images/search_rec.png"
                                OnClick="ImgSearch_Click" ToolTip="Search" />
                            <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                ToolTip="Refresh" />
                        </div>
                        </div>
                  
                    <div class="form-row">
                        
                    </div>
                      <div class="form-row" style="float: right;">
                           <div class="form-group col-lg-12">
                                   <asp:Button ID="imgNew" ToolTip="Add Label Pasting" OnClick="imgNew_Click1"
                                            CausesValidation="false" runat="server" Text="Add Label Pasting" class="btn btn-primary float-right mb-0" Visible="false" />
                           </div>
                      </div>
                    <div class="card-admin form-wizard medias">
                     <div class="row pb-2 pt-2 background-section-form">
												<div class="col-lg-8">
													<h4 class="mb-0">Record's Found : <span> <asp:Label ID="lblcount" runat="server"></asp:Label></span></h4>
												</div>
                                                <div class="col-lg-2">
                                                     <asp:Label ID="lblToatalCashPoints" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label
                                    ID="lblToatalPoints" runat="server"></asp:Label>
                                                </div>
												<div class="col-lg-2">

													<%--<select class="form-control mb-0">
														<option>25 Rows</option>
														<option>20 Rows</option>
														<option>15 Rows</option>
													</select>--%>
                                                     <asp:DropDownList ID="ddlRowProductCnt" runat="server" AutoPostBack="true"
                                                         Visible="false" >
                                        <asp:ListItem Value="25">25 Rows</asp:ListItem>
                                        <asp:ListItem Value="50">50 Rows</asp:ListItem>
                                        <asp:ListItem Value="100">100 Rows</asp:ListItem>
                                        <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                        <asp:ListItem Value="1000">1000 Rows</asp:ListItem>
                                        <asp:ListItem Value="1001">All Rows</asp:ListItem>
                                    </asp:DropDownList>
												</div>
											</div>
        <div class="table-responsive">
           <asp:GridView ID="GrdPrintLabel" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered Frm_Scrap"
                    EmptyDataText="Record Not Found" BorderColor="transparent" >
                    <Columns>
                        <asp:TemplateField HeaderText="S.No.">
                            <ItemTemplate>
                                <%++i; %><%=i %>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="5%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Uploaded Date">
                            <ItemTemplate>
                                <asp:Label ID="lbluploaded" runat="server" Text='<%# Bind("Entry_Date","{0:yyyy dd,yyyy hh:mm:ss tt}") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="11%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product Name">
                            <ItemTemplate>
                                <asp:Label ID="lblprductname" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Batch Name">
                            <ItemTemplate>
                                <asp:Label ID="lblbatchname" runat="server" Text='<%# Bind("Batch_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <a href='<%# Eval("DocPath") %>' target="_blank" style="margin-top: 2px;">
                                    <img src="../Content/images/download.png" alt="dfgd" height="14px" width="14px" title="View / download report" />
                                </a>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                    </Columns>
                    <%--<PagerStyle HorizontalAlign="Right" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />--%>
                </asp:GridView>
            </div>
               </div>
                </div>

            </div>
           
                </div>
            </div>
         </div>
    </div>
            <div class="grid_container">
               <%-- <h4>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <img src="../Content/images/regis_pro.png" alt="products" />
                            </td>
                            <td class="bord_right">
                                Record(s) found<span class="small_font"> (<asp:Label ID="lblcount" runat="server"></asp:Label>)</span>
                            </td>
                            <td style="text-align: right; padding-right: 5px;">
                                <asp:ImageButton ID="ImgRpt" runat="server" OnClick="ImgRpt_Click" ImageUrl="~/Content/images/print.png"
                                    ToolTip="Print Labels For Pasting" />
                            </td>
                        </tr>
                    </table>
                </h4>--%>
                
                <%--<cr:CrystalReportViewer ID="CrystalReportViewer1" runat="server" AutoDataBind="true"
                    OnInit="CrystalReportViewer1_Init1" OnNavigate="CrystalReportViewer1_Navigate"
                    OnLoad="CrystalReportViewer1_Load" PrintMode="ActiveX"></cr:CrystalReportViewer>--%>
            </div>
            <!-- ******************* Popup Start *********************-->
            <asp:Panel ID="PanelLabelCreate" runat="server" Width="45%" style="display:none;">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="btnClosePop" CssClass="popupClose" runat="server" /></div>
                        <div class="service_head_p">
                            <p>
                                <span class="left"><strong>
                                    <asp:Label ID="lblheading" runat="server"></asp:Label></strong> </span><span class="right">
                                        <span class="astrics"><strong>*</strong></span> <em>indicates mandatory fields</em></span></p>
                        </div>
                        <asp:Panel ID="PnlCreateLavel" runat="server">
                            <div class="regis_popup">
                                <div id="Div1" runat="server" style="width: 90%;">
                                    <p>
                                        <asp:Label ID="ProductsLabelPrices" runat="server" Style="font-family: Arial; font-size: 12px;"></asp:Label></p>
                                </div>
                                <fieldset class="Newfield Newfield_width2">
                                    <legend>Upload Label Pasting Report Info</legend>
                                    <asp:Panel ID="Panel1" DefaultButton="ImgSearch" runat="server">
                                        <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                            <tr>
                                                <td width="30%">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red"
                                                        InitialValue="--Select Product--" ValidationGroup="UPRPT" ControlToValidate="ddlProduct1"></asp:RequiredFieldValidator>
                                                    <strong><span class="star_red">*</span>Product Name :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:DropDownList ID="ddlProduct1" OnSelectedIndexChanged="ddlProduct1_SelectedIndexChanged"
                                                        AutoPostBack="true" runat="server" CssClass="reg_txt">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td width="30%">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                                        InitialValue="--Select Batch--" ValidationGroup="UPRPT" ControlToValidate="ddlBatch1"></asp:RequiredFieldValidator>
                                                    <strong><span class="star_red">*</span>Batch Name :&nbsp;</strong>
                                                </td>
                                                <td a>
                                                    <asp:DropDownList ID="ddlBatch1" runat="server" CssClass="reg_txt">
                                                    </asp:DropDownList>
                                                </td>
                                            </tr>
                                        </table>
                                    </asp:Panel>
                                </fieldset>
                                <fieldset id="ftg" runat="server" class="Newfield Newfield_width2">
                                    <legend>Upload Label Pasting File (*.pdf)</legend>
                                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                        <tr id="MytrNew" runat="server">
                                            <td colspan="2" align="center">
                                                <asp:Label ID="lblallotmsg" runat="server" Style="font-family: Arial; font-size: 12px;"
                                                    ForeColor="Red"></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" style="width: 36%;">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                                    ValidationGroup="UPRPT" ControlToValidate="LabelFileupload"></asp:RequiredFieldValidator>
                                                <strong><span class="star_red">*</span>Upload File :&nbsp;</strong>
                                            </td>
                                            <td>
                                                <asp:FileUpload ID="LabelFileupload" runat="server" onchange="javascript:fileTypeCheckeng(this.value);" /><asp:Label
                                                    ID="lblfile" runat="server" CssClass="astrics" Text=""></asp:Label>
                                            </td>
                                        </tr>
                                    </table>
                                </fieldset>
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="right" colspan="2" style="padding-right: 5px;">
                                            <asp:Label ID="lblrowid" runat="server" Visible="false"></asp:Label>
                                            <asp:Label ID="lblentrydate" runat="server" Visible="false"></asp:Label>
                                            <asp:Button ID="btnSave" OnClick="btnSave_Click" ValidationGroup="UPRPT" CssClass="button_all"
                                                UseSubmitBehavior="false" runat="server" Text="Upload" />
                                            <asp:Button ID="btnReset" OnClick="btnReset_Click" CssClass="button_all" runat="server"
                                                Text="Reset" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </asp:Panel>
            <cc1:ModalPopupExtender ID="ModalPopupCreateLabel" runat="server" PopupControlID="PanelLabelCreate"
                BackgroundCssClass="NewmodalBackground" TargetControlID="LabelCreate" CancelControlID="btnClosePop">
            </cc1:ModalPopupExtender>
            <asp:Label ID="LabelCreate" runat="server"></asp:Label>
            <!-- ******************* Popup End *********************-->
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
