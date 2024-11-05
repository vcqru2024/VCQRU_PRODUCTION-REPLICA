<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true"
    Title="Dealer Master" CodeFile="FrmDealerMaster.aspx.cs" Inherits="FrmDealerMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(16).addClass("active");
            $(".accordion2 div.open").eq(11).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <%--<script type="text/javascript" src="js/jquery-1.7.2.min.js" language="javascript">
    </script>--%>

    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
            ShowImagePreview();
        });
        // Configuration of the x and y offsets
        function ShowImagePreview() {
            xOffset = -20;
            yOffset = 40;

            $("a.preview").hover(function(e) {
                this.t = this.title;
                this.title = "";
                var c = (this.t != "") ? "<br/>" + this.t : "";
                $("body").append("<p id='preview'><img src='" + this.href + "' alt='Image preview' />" + c + "</p>");
                $("#preview")
            .css("top", (e.pageY - xOffset) + "px")
            .css("left", (e.pageX + yOffset) + "px")
            .fadeIn("slow");
            },

    function() {
        this.title = this.t;
        $("#preview").remove();
    });

            $("a.preview").mousemove(function(e) {
                $("#preview")
            .css("top", (e.pageY - xOffset) + "px")
            .css("left", (e.pageX + yOffset) + "px");
            });
        };

    </script>

    <style type="text/css">
        #preview
        {
            position: absolute;
            border: 3px solid #ccc;
            background: #333;
            padding: 5px;
            display: none;
            color: #fff;
            box-shadow: 4px 4px 3px rgba(103, 115, 130, 1);
        }
    </style>

    <script language="javascript" type="text/javascript">
        function checkmobileno(vl) {
            vl = vl + "*" + document.getElementById("<%=hdncmphdn.ClientID %>").value;
            PageMethods.checkMobileNo(vl, onCompletePlanNew)
        }            
        function checkplan(vl) {
            vl = vl + "*" + document.getElementById("<%=hdncmphdn.ClientID %>").value;
            PageMethods.checkNewPlan(vl, onCompletePlan)
        }
        function onCompletePlan(Result) {
            if (Result == true) {
                document.getElementById("<%=lblLabelChk.ClientID %>").innerHTML = "Email ID Already exist.";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";
            }
            else {
                document.getElementById("<%=lblLabelChk.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
            }
            MyCheck();
        }   
        function onCompletePlanNew(Result) {
            if (Result == true) {
                document.getElementById("<%=lblLblChkMo.ClientID %>").innerHTML = "Mobile No. Already exist.";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";
            }
            else {
                document.getElementById("<%=lblLblChkMo.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
            }
            MyCheck();
        }
        function MyCheck() {
            var em = document.getElementById("<%=lblLabelChk.ClientID %>").innerHTML;
            var mb = document.getElementById("<%=lblLblChkMo.ClientID %>").innerHTML;
            if ((em == "") && (mb == "")) {
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
            }
            else {
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";
            }
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
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Dealer Master<asp:HiddenField ID="hdncmphdn" runat="server" /></h4>
                            </header>
                
                <div class="card-body card-body-nopadding">
                  <div id="newMsg" runat="server" style="width: 91%;">
                    <p>
                        <asp:Label ID="Label2" runat="server"></asp:Label>
                    </p>
                </div>
                    <div class="form-row">
                        <div class="form-group col-lg-6">
                           <%-- <label>Dealer Name</label>--%>
                            <asp:TextBox ID="txtsearchlblname" runat="server" CssClass="form-control form-control-sm" placeholder="Dealer Name"></asp:TextBox>
                        </div>
                        <div class="form-group col-lg-6">
                            <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png"
                                OnClick="ImgSearch_Click" ToolTip="Search" />
                            <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                ToolTip="Reset" />
                        </div>
                    </div>
                      <div class="form-row" style="float: right;">
                           <div class="form-group col-lg-12">
                                   <asp:Button ID="imgNew" ToolTip="Add Dealer" OnClick="imgNew_Click1"
                                            CausesValidation="false" runat="server" Text="Add Dealer" class="btn btn-primary float-right mb-0" />
                           </div>
                      </div>
                     <div class="card-admin form-wizard medias">
                     <div class="row pb-2 pt-2 background-section-form">
												<div class="col-lg-8">
													<h4 class="mb-0">Record's Found :<span> <asp:Label ID="lblcount" runat="server"></asp:Label></span></h4>
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
            <asp:GridView ID="GrdCustomer" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered"
                    DataKeyNames="Status" EmptyDataText="Record Not Found" 
                    OnRowCommand="GrdCustomer_RowCommand" BorderColor="transparent" >
                    <Columns>
                        <asp:TemplateField HeaderText="S.No.">
                            <ItemTemplate>
                                <%=++str %>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="7%" />
                        </asp:TemplateField>
                        <%--<asp:TemplateField HeaderText=" Dealer ID">
                            <ItemTemplate>
                                <asp:Label ID="lbluserid" runat="server" Text='<%# Bind("Dealer_ID") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" />
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText=" Dealer Name">
                            <ItemTemplate>
                                <asp:Label ID="lblname" runat="server" Text='<%# Bind("Dealer_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                            <ItemStyle HorizontalAlign="Justify" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" Contact Person">
                            <ItemTemplate>
                                <asp:Label ID="lblcontactname" runat="server" Text='<%# Bind("Contact_Person") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                            <ItemStyle HorizontalAlign="Justify" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" E-mail">
                            <ItemTemplate>
                                <asp:Label ID="lblemail" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                            <ItemStyle HorizontalAlign="Justify" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" Mobile No">
                            <ItemTemplate>
                                <asp:Label ID="lblmobileno" runat="server" Text='<%# Bind("Mobile_No") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                            <ItemStyle HorizontalAlign="Justify" />
                        </asp:TemplateField>
                        <%--<asp:TemplateField HeaderText=" Password">
                            <ItemTemplate>
                                <asp:Label ID="lblpassword" runat="server" Text='<%# Bind("Password") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" />
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:ImageButton ID="ImgbtnEdit" runat="server" ImageUrl="~/Content/images/edit.png" CommandArgument='<%# Bind("Row_Id") %>'
                                    CommandName="EditCustomer" ToolTip="Edit Plan" />&nbsp;
                                <%
                                    try
                                    {
                                        lflag = Convert.ToInt32(GrdCustomer.DataKeys[index].Values["Status"].ToString());
                                    }
                                    catch { }
                                    if (lflag == 0)
                                    {  %>
                                <asp:ImageButton ID="imgshowlbl123" runat="server" ImageUrl="~/Content/images/showhide2.png" 
                                    ToolTip='<%# Bind("TooTipMsg") %>' CommandArgument='<%# Eval("Row_Id")  + "*" + Eval("TooTipMsg")  %>' CommandName="ShowHideCustomer"
                                    Height="16px" Width="16px" />&nbsp;
                                <%}
                                    else
                                    {%>
                                <asp:ImageButton ID="imgshowlbl" runat="server" ImageUrl="~/Content/images/showhide1.png"
                                    ToolTip='<%# Bind("TooTipMsg") %>' CommandArgument='<%# Eval("Row_Id")  + "*" + Eval("TooTipMsg") %>' CommandName="ShowHideCustomer"
                                    Height="16px" Width="16px" />
                                <%} %>
                                <asp:ImageButton ID="ImageButton2" runat="server" ImageUrl="~/Content/images/lence.png" ToolTip="View Update Price Details"
                                    CommandArgument='<%# Bind("Row_Id") %>' CommandName="ViewLabelDetails" Visible="false" />&nbsp;
                                <%index++; %>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                    </Columns>
                   <%-- <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />--%>
                </asp:GridView>
                <asp:Label ID="lbleditlabelid" runat="server" Text="" Visible="false"></asp:Label>
                    </div>
                    </div>
                </div>
               
            </div>
                
                </div>
            </div>
         </div>
    </div>
            <div class="grid_container">
                
                
                <!-- ******************* Popup Start *********************-->
                <asp:Panel ID="PanelLabelCreate" runat="server" Width="32%" Visible="false">
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
                                    <div id="Div1" runat="server">
                                        <p>
                                            <asp:Label ID="ProductsLabelPrices" runat="server" Style="font-family: Arial; font-size: 12px;"></asp:Label></p>
                                    </div>
                                    <fieldset id="ftg" runat="server" class="Newfield Newfield_width2">
                                        <legend>Dealer Information</legend>
                                        <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                            <tr id="MytrNew" runat="server">
                                                <td colspan="2" align="center">
                                                    <asp:Label ID="lblallotmsg" runat="server" Style="font-family: Arial; font-size: 12px;"
                                                        ForeColor="Red"></asp:Label>
                                                </td>
                                            </tr>                                                                                      
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1456" runat="server" ForeColor="Red"
                                                        ValidationGroup="CCC" ControlToValidate="txtplanname"></asp:RequiredFieldValidator>
                                                    <strong><span class="star_red">*</span>Dealer Name :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtplanname" CssClass="textbox_pop" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red"
                                                        ValidationGroup="CCC" ControlToValidate="txtcontactprson"></asp:RequiredFieldValidator>
                                                    <strong><span class="star_red">*</span>Contact Person :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtcontactprson" CssClass="textbox_pop" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>  
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblLabelChk" runat="server" CssClass="astrics" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator44534" ValidationGroup="CCC"
                                                        runat="server" ControlToValidate="txtEmail" Style="color: Red;" Display="Dynamic"
                                                        SetFocusOnError="true" ErrorMessage="Ex:a@a.com" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                                                    &nbsp;<asp:RequiredFieldValidator ID="RequiredFieldValidator2sdfsd" runat="server" ForeColor="Red"
                                                        ValidationGroup="CCC" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                                                    <strong><span class="star_red">*</span>Email :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtEmail" CssClass="textbox_pop" runat="server" onchange="checkplan(this.value);"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                </td>
                                                <td>
                                                    <asp:Label ID="lblLblChkMo" runat="server" CssClass="astrics" Text=""></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator266" runat="server" ForeColor="Red"
                                                        ValidationGroup="CCC" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                                                    <strong><span class="star_red">*</span>Mobile No :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtMobileNo" CssClass="textbox_pop" MaxLength="13" OnKeyPress="return isNumberKey(this, event);"
                                                     onchange="checkmobileno(this.value);"  runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                                        ValidationGroup="CCC" ControlToValidate="txtaddress"></asp:RequiredFieldValidator>
                                                    <strong><span class="star_red">*</span>Address :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="txtaddress" CssClass="textbox_pop" runat="server"></asp:TextBox>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="right" style="width: 36%;">
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                                        ValidationGroup="CCC" ControlToValidate="ddlUserType"></asp:RequiredFieldValidator>
                                                    <strong><span class="star_red">*</span>City :&nbsp;</strong>
                                                </td>
                                                <td>
                                                    <asp:TextBox ID="ddlUserType" runat="server" CssClass="textbox_pop" ></asp:TextBox>
                                                </td>
                                            </tr>                                            
                                        </table>
                                    </fieldset>
                                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                        <tr>
                                            <td align="right" colspan="2" style="padding-right: 5px;">
                                                <asp:Label ID="lblrowid" runat="server" Visible="false"></asp:Label>
                                                <asp:Label ID="lblentrydate" runat="server" Visible="false"></asp:Label>
                                                <asp:Button ID="btnSave" OnClick="btnSave_Click" ValidationGroup="CCC" CssClass="button_all"
                                                    runat="server" Text="Save" />
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
              <%--  <cc1:ModalPopupExtender ID="ModalPopupCreateLabel" runat="server" PopupControlID="PanelLabelCreate"
                    BackgroundCssClass="NewmodalBackground" TargetControlID="LabelCreate" CancelControlID="btnClosePop">
                </cc1:ModalPopupExtender>--%>
                <asp:Label ID="LabelCreate" runat="server"></asp:Label>
                <!-- ******************* Popup End *********************-->
                <!--===============================PopUp Password Starts===============================-->
                <asp:Panel ID="PanelShowPassword" runat="server" Width="20%" Visible="false">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnPasswordPnlClose" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                            <!--<fieldset class="service_field" >-->
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="lblPassPnlHead" runat="server" Text="Password" Font-Size="14pt"></asp:Label>
                                    </span><span class="right" style="visibility: hidden;"><span class="astrics"><strong>
                                    </strong></span></span>
                                </p>
                            </div>
                            <div class="regis_popup" style="text-align: center;">
                                <br />
                                <asp:Label ID="lblPopMsgText" runat="server" Text="" Font-Size="12px"></asp:Label><br />
                                <br />
                                <div id="infobtn" runat="server">
                                    <asp:Button ID="btnYesActivation" runat="server" Text="Yes" CssClass="button_all"
                                        OnClick="btnYesActivation_Click" />&nbsp;&nbsp;<asp:Button ID="btnNoActivation" runat="server"
                                            Text="No" CssClass="button_all" OnClick="btnNoActivation_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <!--===============================Popup Close================================-->
                <asp:Label ID="Label5" runat="server"></asp:Label>
               <%-- <cc1:ModalPopupExtender ID="ModalPopupExtender3" runat="server" BackgroundCssClass="NewmodalBackground"
                    OkControlID="btnNoActivation" CancelControlID="btnPasswordPnlClose" PopupControlID="PanelShowPassword"
                    TargetControlID="Label3">
                </cc1:ModalPopupExtender>--%>
            </div>
      <%--  </ContentTemplate>
        <Triggers>
        </Triggers>
    </asp:UpdatePanel>--%>
</asp:Content>
