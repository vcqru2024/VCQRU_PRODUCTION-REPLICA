<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="SearchCodeDetails.aspx.cs" Inherits="Manufacturer_SearchCodeDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
 <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(28).addClass("active");
            $(".accordion2 div.open").eq(26).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		       .siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <script type="text/javascript" >
        function checkAll(frm, mode) {
            var i = 0;
            for (; i < frm.elements.length; i++)
                if (frm.elements[i].type == "checkbox")
                frm.elements[i].checked = mode;
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
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Assign New Batch</h4>
                            </header>
                
          
          <div class="card-body card-body-nopadding">
                  <div id="newMsg" runat="server">
                    <p>
                        <asp:Label ID="Label2" runat="server"></asp:Label>
                    </p>
                </div>
                    <div class="form-row">
                       <%-- <div class="form-group col-lg-3">
                            <label>Product Name</label>
                            <asp:DropDownList ID="ddlProduct" CssClass="form-control form-control-sm" runat="server" AutoPostBack="true"
                                    OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged">
                                </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="ddlProduct" ErrorMessage="*"
                                    InitialValue="--Select--" ValidationGroup="abc" runat="server"></asp:RequiredFieldValidator>
                        </div>--%>
                        <div class="col">
                                <label for="Product Description" class="form-label">13-Digit Code</label>

                                <asp:TextBox ID="txtcode" OnTextChanged="txtcode_TextChanged" AutoPostBack="true" MaxLength="13" CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ValidationGroup="abc"
                                    ControlToValidate="txtcode" ErrorMessage="ex: 1234567890123" Display="None" 
                                    ViewStateMode="Enabled" ValidationExpression="[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]"></asp:RegularExpressionValidator>

                            </div>
                        <div class="form-group col-lg-3">
                                <label>From Series</label>
                             <asp:TextBox ID="txtscrapfrom" onchange="upperMe()" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationGroup="abc"
                                    ControlToValidate="txtscrapfrom" ErrorMessage="ex: AA06-01-001" Display="None" 
                                    ViewStateMode="Enabled" ValidationExpression="[A-Z][A-Z][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]"></asp:RegularExpressionValidator>
                        </div>
                             <div class="form-group col-lg-3">
                                 <label>To Series</label>
                                  <asp:TextBox ID="txtscrapto" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="abc"
                                    ControlToValidate="txtscrapto" ErrorMessage="ex: AA06-01-001" Display="None"
                                    ViewStateMode="Enabled" ValidationExpression="[A-Z][A-Z][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]"></asp:RegularExpressionValidator>
                             </div>

                        <div class="form-group col-lg-3 mt-4">
                                 <asp:Button ID="btnSearch" OnClick="btnSearch_Click" ValidationGroup="chk94" class="btn btn-primary"
                                    runat="server" Text="Search" />

                             <asp:ImageButton ID="ImgSearch" ValidationGroup="abc" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png"
                                        ToolTip="Search" OnClick="ImgSearch_Click" />
                                    <%--<asp:ImageButton ID="ImgRefresh" ToolTip="Refresh" CssClass="btn btn-success refreses_field" runat="server" ImageUrl="~/Content/images/reset.png"
                                        OnClick="ImgRefresh_Click" />--%>
                        </div>
                        </div>
                      
                      
                    <%--  <div class="form-row" style="float: right;">
                           <div class="form-group col-lg-12">
                                   <asp:Button ID="imgNew" ToolTip="Add Dealer" OnClick="imgNew_Click1"
                                            CausesValidation="false" runat="server" Text="Add Dealer" class="btn btn-primary float-right mb-0" />
                           </div>
                      </div>--%>
              <div class="col-lg-12 card-admin form-wizard medias">
                     <div class="row pb-2 pt-2 background-section-form">
												<div class="col-lg-6">
													<h4 class="mb-0">Record's found: <span> (<asp:Label ID="lblcount" runat="server"></asp:Label>)
                                                        <asp:Label ID="lblC" Text="0" runat="server" Visible="false"></asp:Label>
													                                </span></h4>
												</div>
                                                <div class="col-lg-4">
                                                     <asp:Label ID="LblMsg" CssClass="small_font" runat="server"></asp:Label>
                                                </div>
												<div class="col-lg-2">
                                                      <div class="col-lg-2">
                                <asp:Button ID="btnSave"  OnClick="btnSave_Click" ValidationGroup="chk94" class="btn btn-primary btn-sm"
                                    runat="server" Text="Request To Assign Batch No." />
                            </div>

                                                   <%--  <asp:ImageButton ID="btnSave" OnClick="btnSave_Click" ImageUrl="~/Content/images/SaveNew.png"
                                    CausesValidation="false" runat="server" />--%>
                                                    
                                                    <%--ToolTip="Save" --%>
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
                 <div class="row pb-2 pt-2">
                     <%--<div class="col-lg-3">
                         <asp:button id="btnAvailable" runat="server" style="background-color: #c7efc8; width: 15px; height: 15px; border: 1px solid #bdb5b5; margin-right: 10px;" onclick="btnAvailable_Click" tooltip="Click For Filter" />Labels Available
                     </div>--%>
                   <%--   <div class="col-lg-3"><asp:Button ID="btnUsed" runat="server" Style="background-color: Yellow; width: 15px;  height: 15px; border: 1px solid #bdb5b5; margin-right: 10px;" OnClick="btnUsed_Click" ToolTip="Click For Filter" />Pasted Labels</div>
                     --%>
                    <%-- <div class="col-lg-3"> <asp:Button ID="btnCourierRescrap" runat="server" Style="background-color: #FFFFFF;
                                                width: 15px; height: 15px; border: 1px solid #bdb5b5; margin-right: 10px;" OnClick="btnCourierRescrap_Click" ToolTip="Click For Filter" />Scrap Durung Courier Receipt
                     </div>--%>
                    <%-- <div class="col-lg-3">
                         <asp:Button ID="btnScrap" runat="server" Style="background-color: #fbe3e4; width: 15px; height: 15px; border: 1px solid #bdb5b5; margin-right: 10px;" OnClick="btnScrap_Click" ToolTip="Click For Filter" />Scrap at Pasting Time 
                     </div>--%>
                 </div>
            <div class="table-responsive table_large">
           <asp:GridView ID="Grdscrap" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover"
                            DataKeyNames="SerialCode" EmptyDataText="Record Not Found">
                            <Columns>
                                <asp:TemplateField HeaderText="S. No">
                                <ItemTemplate>
                                    <%=++sr%>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" Width="1%" />
                            </asp:TemplateField>
                              
                                <asp:TemplateField HeaderText="Product Name">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1SeNew4" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                                    </ItemTemplate>
                                   
                                    <ItemStyle HorizontalAlign="Center" Width="6%" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Complete Code">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1Completedcode" runat="server" Text='<%# Bind("Completedcode") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="6%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Serial Code">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1SerialCode" runat="server" Text='<%# Bind("SerialCode") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="6%" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Batch No.">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1Batch_No" runat="server" Text='<%# Bind("Batch_No") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="6%" />
                                </asp:TemplateField>

                                  <asp:TemplateField HeaderText="Subs. Date">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1DateFrom" runat="server" Text='<%# Bind("DateFrom") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Center" Width="6%" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Exp. Date">
                                    <ItemTemplate>
                                        <asp:Label ID="Label1DateTo" runat="server" Text='<%# Bind("DateTo") %>'></asp:Label>
                                    </ItemTemplate>
                                   
                                    <ItemStyle HorizontalAlign="Center" Width="6%" />
                                </asp:TemplateField>
                                <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                                    <HeaderTemplate>
                                        <input id="chkselecth" name="chkselecth" type="checkbox" onchange="checkAll(this.form,this.checked)" />
                                    </HeaderTemplate>
                                    <ItemTemplate>
                                        
                                       
                                        <input id="chkselect" name="chkselect" type="checkbox" value='<%# Eval("SerialCode") %>' />
                                       
                                    </ItemTemplate>
                                   
                                    <ItemStyle HorizontalAlign="Center" Width="1%" />
                                </asp:TemplateField>
                            </Columns>
                          
                        </asp:GridView>
                    <asp:HiddenField ID="hidden1" runat="server" />
                    <asp:Label ID="Labeldispath" runat="server"></asp:Label>
            </div>
                </div>
                </div>
</div>
                
                </div>
            </div>
         </div>
            <div class="grid_container">
            </div>    
                <div class="printed_pro">
                  <%--  <table width="100%" cellspacing="0" cellpadding="0" style="font-weight: bold;">
                        <tr>
                            <td align="left">
                                <asp:Label ID="lblcode" Visible="false" runat="server"></asp:Label>
                                <asp:Label ID="lblfullcode" Visible="false" runat="server"></asp:Label>
                                <table cellpadding="2px" cellspacing="2px" style="font-size: 9pt;">
                                    <tr>
                                        <td>
                                            <asp:Button ID="btnAvailable" runat="server" Style="background-color: #c7efc8; width: 15px;
                                                height: 15px;" OnClick="btnAvailable_Click" ToolTip="Click For Filter" />
                                        </td>
                                        <td>
                                            Labels Available &nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <asp:Button ID="btnUsed" runat="server" Style="background-color: Yellow; width: 15px;
                                                height: 15px;" OnClick="btnUsed_Click" ToolTip="Click For Filter" />
                                        </td>
                                        <td>
                                            Pasted Labels &nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <asp:Button ID="btnCourierRescrap" runat="server" Style="background-color: #FFFFFF;
                                                width: 15px; height: 15px;" OnClick="btnCourierRescrap_Click" ToolTip="Click For Filter" />
                                        </td>
                                        <td>
                                            Scrap Durung Courier Receipt &nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <asp:Button ID="btnScrap" runat="server" Style="background-color: #fbe3e4; width: 15px;
                                                height: 15px;" OnClick="btnScrap_Click" ToolTip="Click For Filter" />
                                        </td>
                                        <td>
                                            Scrap at Pasting Time &nbsp;&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </td>
                        </tr>
                        <tr style="display:none;">
                        <td class="bord_right" width="34%" style="font-size: 12px; font-weight: bold;">
                                Dispath Label(s) pending found<span class="small_font"> (<asp:Label ID="Labeldispath"
                                    Text="0" runat="server"></asp:Label>)</span>
                        </tr>
                    </table>--%>
                </div>
                <div>

                </div>
                <asp:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" WarningIconImageUrl="~/Content/images/WARNING.png"
                    TargetControlID="RegularExpressionValidator1" runat="server">
                </asp:ValidatorCalloutExtender>
                <asp:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" WarningIconImageUrl="~/Content/images/WARNING.png"
                    TargetControlID="RegularExpressionValidator2" runat="server">
                </asp:ValidatorCalloutExtender>
                <!--PopUp Starts-->
                <!--PopUp Close-->
            </div>
            <!--===============================PopUp Alert Starts===============================-->
            <asp:Panel ID="PanelForScrap" runat="server" Width="30%" style="display:none;background-color:white;border:1px solid grey;padding:1rem;">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="btnCloseScrap" Text="Close" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                        <!--<fieldset class="service_field" >-->
                        <div class="service_head_p">
                            <p>
                                <span class="left">
                                    <asp:Label ID="LabelAlertNewHeader" runat="server" Text=""></asp:Label>
                                </span><span class="right" style="visibility: hidden;"><span class="astrics"><strong>
                                </strong></span></span>
                            </p>
                        </div>
                        <div class="regis_popup">
                            <div class="row" style="gap:1rem;">
                                <div class="col-12">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red"
                                            ValidationGroup="CHKSCR" InitialValue="--Select--" ControlToValidate="ddlProduct"></asp:RequiredFieldValidator>
                                        <label class="form-label">Select Product</label>
                                      <asp:DropDownList ID="ddlProduct" OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged1" AutoPostBack="true" class="form-select" runat="server">
                                        </asp:DropDownList>
                                </div>
                                <div class="col-12">
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                            ValidationGroup="CHKSCR" InitialValue="--Select--" ControlToValidate="ddlbachno"></asp:RequiredFieldValidator>
                                        <label class="form-label">Select Batch</label>
                                      <asp:DropDownList ID="ddlbachno" OnSelectedIndexChanged="ddlbachno_SelectedIndexChanged" AutoPostBack="true" class="form-select" runat="server">
                                        </asp:DropDownList>
                                    <div>

                                       <p style="text-align:right; font-size:x-small;"><b> <asp:Label ID="lblseriesdetails" runat="server"></asp:Label></b></p> 
                                     
                                    </div>
                                </div>
                                <div class="col-12">
                                    <asp:Button ID="btnYesScrap" runat="server" Text="Submit" CssClass="button_all btn btn-primary w-100" OnClick="btnYesScrap_Click"
                                ValidationGroup="CHKSCR" />
                                </div>
                            </div>
                    <%--        <table style="width: 100%;">
                                <tr>
                                    <td align="right" width="25%">
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red"
                                            ValidationGroup="CHKSCR" InitialValue="--Select--" ControlToValidate="ddlreason"></asp:RequiredFieldValidator>
                                        <strong><span class="star_red">*</span> Reason :&nbsp;</strong>
                                    </td>
                                    <td align="left">
                                        <asp:DropDownList ID="ddlreason" CssClass="drp form-control" runat="server" Style="text-transform: capitalize;
                                            width: 45%;">
                                        </asp:DropDownList>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" width="25%">
                                        <strong>Remarks :&nbsp;</strong>
                                    </td>
                                    <td align="left">
                                        <asp:TextBox ID="txtreasonremarks" TextMode="MultiLine" CssClass="textarea_pop form-control" runat="server"
                                            Style="text-transform: capitalize; width: 87%; height: 70px;">
                                        </asp:TextBox>
                                    </td>
                                </tr>
                            </table>--%>
                            <%--<asp:Label ID="LabelAlertNewText" runat="server" Text="" Font-Size="11px"></asp:Label><br />--%>
                            <%--&nbsp;&nbsp;<asp:Button ID="btnNoScrap" runat="server"
                                    Text="No" CssClass="button_all" OnClick="btnNoScrap_Click" CausesValidation="false" />--%>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <!--===============================Popup Close================================-->
            <asp:Label ID="LabelControlID" runat="server"></asp:Label><asp:Label ID="LabelModel"
                runat="server" Text="Yes" Visible="false"></asp:Label>
            <cc1:ModalPopupExtender ID="ModalPopupExtenderScrap" runat="server" BackgroundCssClass="NewmodalBackground"
                CancelControlID="btnCloseScrap" PopupControlID="PanelForScrap" TargetControlID="LabelControlID">
            </cc1:ModalPopupExtender>
     <%--   </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
            <asp:PostBackTrigger ControlID="imgNew" />
        </Triggers>
    </asp:UpdatePanel>--%>
</asp:Content>

