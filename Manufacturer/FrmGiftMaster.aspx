<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" Title="Gift Master"
    CodeFile="FrmGiftMaster.aspx.cs" Inherits="FrmGiftMaster" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function () {

            $(".accordion2 p").eq(17).addClass("active");
            $(".accordion2 div.open").eq(11).show();

            $(".accordion2 p").click(function () {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <style type="text/css">
        .myrd input
        {
            position: relative;
            padding: 5px;
            margin-left: 5px;
            margin-top: 9px;
        }
        .myrd label
        {
            position: relative;
            padding: 5px;
            font-weight: bold;
        }
    </style>

    <script language="javascript" type="text/javascript">
        <%--function checkCourior(vl) {
             var val = vl + "*" + document.getElementById("<%=hdnCompID.ClientID %>").value;
             PageMethods.checkNewLabel(val, onCompleteLaebl)
         }
        function onCompleteLaebl(Result) {
            if (Result == true) {
                document.getElementById("<%=lblCouriorChk.ClientID %>").innerHTML = "Coupon Provider Name Already exist.";
                document.getElementById("<%=btnSubmit.ClientID %>").disabled = true;
                document.getElementById("<%=btnSubmit.ClientID %>").className = "button_all_Sec";
            }
            else {
                document.getElementById("<%=lblCouriorChk.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSubmit.ClientID %>").disabled = false;
                document.getElementById("<%=btnSubmit.ClientID %>").className = "button_all";
            }
        }--%>
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>  --%>          
            <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
                        top: 0px;" class="NewmodalBackground">
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
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Gift Master</h4>
                            </header>
                <div id="newMsg" runat="server">
                    <p>
                        <asp:Label ID="lblmsgHeader" runat="server"></asp:Label>
                        <asp:HiddenField ID="hdnCompID" runat="server" />
                    </p>
                </div>


           <div class="card-body card-body-nopadding">
                  
                    <div class="form-row">
                        <div class="form-group col-lg-6">
                           <%-- <label>Dealer Name</label>--%>
                             <asp:TextBox ID="txtSearchName" runat="server" CssClass="form-control form-control-sm" placeholder="Gift Name"></asp:TextBox>
                          
                        </div>
                        <div class="form-group col-lg-6">
                           <asp:ImageButton ID="btnSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png"
                                    OnClick="btnSearch_Click" ToolTip="Search" />
                                <asp:ImageButton ID="btnRefesh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png"
                                    OnClick="btnRefesh_Click" ToolTip="Refresh" />
                        </div>
                    </div>
                      <div class="form-row" style="float: right;">
                           <div class="form-group col-lg-12">
                                   <asp:Button ID="imgNew" ToolTip="Add Gift" OnClick="imgNew_Click1"
                                            CausesValidation="false" runat="server" Text="Add Gift" class="btn btn-primary float-right mb-0" />
                           </div>
                      </div>
                <div class="card-admin form-wizard medias">
                     <div class="background-section-form">
												<div>
													<h4 class="mb-0">Record's Found :<span> <asp:Label ID="lblcount" runat="server"></asp:Label></span></h4>
												</div>
                                                <div>
                                                     <asp:Label ID="lblToatalCashPoints" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label
                                    ID="lblToatalPoints" runat="server"></asp:Label>
                                                </div>
												<div class="form-group">
                                             <asp:DropDownList ID="DropDownList1" runat="server" AutoPostBack="true"
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
                      <asp:GridView ID="GrdVw" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered" DataKeyNames="IsActive"
                        EmptyDataText="Record Not Found" BorderColor="transparent" OnRowCommand="GrdVw_RowCommand">
                        <Columns>
                            <asp:TemplateField HeaderText="Sr.No.">
                                <ItemTemplate>
                                    <%=sno++%>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="7%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Gift Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblCourierName" runat="server" Text='<%# Bind("GiftName") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" />
                            </asp:TemplateField>                                                      
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:ImageButton ID="ImgbtnEditCourier" runat="server" ImageUrl="~/Content/images/edit.png"
                                        CommandName="EditRow" CommandArgument='<%# Bind("Gift_ID") %>' ToolTip="Edit Gift"
                                        CausesValidation="false" />&nbsp;
                                        <%try {
                                              Flag = Convert.ToInt32(GrdVw.DataKeys[index].Values["IsActive"]);
                                          }
                                          catch { } if (Flag == 0)
                                          {%>
                                    <asp:ImageButton ID="ImgbtnAct" runat="server" ImageUrl="~/Content/images/check_act.png"  OnClientClick="return confirm('Are you sure you want to De-Activate Gift?');"  
                                        CommandName="ActivateRow" CommandArgument='<%# Bind("Gift_ID") %>' ToolTip="De-Activate Gift"
                                       />
                                        <%}
                                          else
                                          { %>
                                          <asp:ImageButton ID="ImgbtnActN" runat="server" ImageUrl="~/Content/images/check_gr.png" 
                                              OnClientClick="return confirm('Are you sure you want to Acivate Gift?');"  
                                        CommandName="ActivateRow" CommandArgument='<%# Bind("Gift_ID") %>' ToolTip="Acivate Gift"
                                        />
                                        <%} %>
                                        <asp:ImageButton ID="ImgbtnDel" runat="server" ImageUrl="~/Content/images/delete.png"
                                        CommandName="DeleteRow" CommandArgument='<%# Bind("Gift_ID") %>' ToolTip="Delete Gift"
                                        OnClientClick="return confirm('Are you sure you want to delete?');"  />
                                        <%index++; %>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="10%" />
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataRowStyle HorizontalAlign="Center" />
                       <%-- <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                        <RowStyle CssClass="tr_line1" />
                        <AlternatingRowStyle CssClass="tr_line2" />--%>
                    </asp:GridView>
                    <asp:Label ID="lblBankId" runat="server" Text="" Visible="false"></asp:Label>
                    <asp:HiddenField ID="dhnactiontype" runat="server" />
                      </div>
                      </div>
                </div>
                </div>
                 
                </div>
            </div>
        </div>
        </div>
            <asp:Panel ID="PnlDefault" runat="server" DefaultButton="btnSearch" >
           <%-- <fieldset class="field_profile">
                <legend>
                    <asp:Label ID="Label3" runat="server" Text="Search"></asp:Label></legend>
                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                    <tr>
                        <td align="justify" style="width: 9%;">
                           
                        </td>
                        <td align="left" width="12%">
                            <div class="merg_btn">
                               
                            </div>
                        </td>                       
                    </tr>
                </table>
            </fieldset>--%>
            </asp:Panel>
            <asp:Panel ID="DemoPanel" runat="server">
                <div class="grid_container">
                    <h4>
                        <%--<table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="6%" align="center">
                                    <img src="../Content/images/regis_pro.png" alt="products" />
                                </td>
                                <td class="bord_right">
                                    <asp:Label ID="lblGridHeaderText" runat="server" Text="Record(s) found"></asp:Label>
                                    <span class="small_font">(<asp:Label ID="" runat="server"></asp:Label>)</span>
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbltotal" CssClass="small_font" runat="server"></asp:Label>
                                </td>
                                <td align="right" style="padding-right: 20px; display: none;">
                                    <asp:Label ID="lblrecpayment" Style="font-family: Verdana; font-size: 12px; color: Black;"
                                        Text="Payment Received: " CssClass="small_font" runat="server"></asp:Label>
                                    &nbsp;
                                    <asp:Label ID="lbltotalpay" Style="font-family: Verdana; font-size: 12px; color: Red;"
                                        CssClass="small_font" runat="server"></asp:Label>
                                </td>
                                 <td width="13%" align="center">
                                <div class="mainselection">
                                    <asp:DropDownList ID="ddlRowProductCnt" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRowsShow_SelectedIndexChanged">
                                        <asp:ListItem Value="25">25 Rows</asp:ListItem>
                                        <asp:ListItem Value="50">50 Rows</asp:ListItem>
                                        <asp:ListItem Value="100">100 Rows</asp:ListItem>
                                        <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                        <asp:ListItem Value="1000">1000 Rows</asp:ListItem>
                                        <asp:ListItem Value="1001">All Rows</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </td>
                            </tr>
                        </table>--%>
                    </h4>
                    
                </div>
            </asp:Panel>
            <asp:Panel ID="PanelNewCourier" runat="server" Width="30%" style="display:none;">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="ButtonNewCourier" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                        <!--<fieldset class="service_field" >-->
                        <div class="service_head_p">
                            <p>
                                <span class="left"><strong>
                                    <asp:Label ID="lblAddCourierHeader" runat="server" Text=""></asp:Label></strong>
                                </span><span class="right"><span class="astrics"><strong>*</strong></span> <em>indicates
                                    mandatory fields</em></span></p>
                        </div>
                        <asp:Panel ID="Panel1" runat="server" > 
                            <div class="regis_popup">
                                <div id="DivNewMsg" runat="server" style="width: 88%;">
                                    <p>
                                        <asp:Label ID="lblpopmsg" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <asp:UpdateProgress ID="UpdateProgressForPay2New" 
                                    runat="server" DisplayAfter="0">
                                    <ProgressTemplate>
                                        <div style="position: absolute; left: -330px; height: 907px; width: 1024px; top: -170px;
                                            text-align: center;" class="NewmodalBackground">
                                            <div style="margin-top: 300px;" align="center">
                                                <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                                                <span style="color: White;">Please Wait.....<br />
                                                </span>
                                            </div>
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <fieldset id="Fieldset2" runat="server" class="Newfield Newfield_width2">
                                    <legend>Gift Info</legend>
                                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">                                        
                                        <tr>
                                            <td align="right" width="35%" valign="top">
                                               
                                                <strong><span class="astrics">*</span> :</strong>
                                            </td>
                                            <td>
                                               
                                                    <br /><span style="color:Red;">Gift Name should be in 20 char.</span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" width="35%">
                                            </td>
                                            <td>
                                               
                                            </td>
                                        </tr>                                                                                                                     
                                    </table>
                                </fieldset>
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="right">
                                            &nbsp;&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </asp:Panel>
            <cc1:ModalPopupExtender ID="ModalPopupExtenderNewDesign" runat="server" PopupControlID="PanelNewCourier"
                BackgroundCssClass="NewmodalBackground" TargetControlID="LabelNewDesign" CancelControlID="ButtonNewCourier">
            </cc1:ModalPopupExtender>
            <asp:Label ID="LabelNewDesign" runat="server"></asp:Label>
            <!--===============================PopUp Alert Starts===============================-->
            <asp:Panel ID="PanelAlert" runat="server" Width="20%" style="display:none;">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="btnAlertPnlClose" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                        <!--<fieldset class="service_field" >-->
                        <div class="service_head_p">
                            <p>
                                <span class="left">
                                    <asp:Label ID="LabelAlertheader" runat="server" Text="Password" Font-Size="12px"></asp:Label>
                                </span><span class="right" style="visibility: hidden;"><span class="astrics"><strong>
                                </strong></span></span>
                            </p>
                        </div>
                        <div class="regis_popup" style="text-align: center;">
                            <br />
                            <asp:Label ID="LabelAlertText" runat="server" Text="" Font-Size="11px"></asp:Label><br />
                            <br />
                            <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="button_all"
                                OnClick="btnYes_Click" />&nbsp;&nbsp;<asp:Button ID="btnNo" runat="server"
                                    Text="No" CssClass="button_all" OnClick="btnNo_Click" />
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <!--===============================Popup Close================================-->
            <asp:Label ID="Label12" runat="server"></asp:Label><asp:Label ID="LabelCalText" runat="server"
                Visible="false"></asp:Label>
            <cc1:ModalPopupExtender ID="ModalPopupExtenderAlert" runat="server" BackgroundCssClass="NewmodalBackground"
                CancelControlID="btnAlertPnlClose" PopupControlID="PanelAlert" TargetControlID="Label12">
            </cc1:ModalPopupExtender>
        <%--</ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>
