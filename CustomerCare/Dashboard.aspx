<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Dashboard"
    Title="Dashboard" EnableEventValidation="true" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
    <title>VCQRU | No Char Sau Beesi</title>
    <meta name="google-site-verification" content="txvxtnQjnR5uLkfNgi1iX4cTC1AB3282Lqud_kCGEDA" />
    <!--Analytics Code-->

    <script type="text/javascript">
        (function(i, s, o, g, r, a, m) {
            i['GoogleAnalyticsObject'] = r; i[r] = i[r] || function() {
                (i[r].q = i[r].q || []).push(arguments)
            }, i[r].l = 1 * new Date(); a = s.createElement(o),
  m = s.getElementsByTagName(o)[0]; a.async = 1; a.src = g; m.parentNode.insertBefore(a, m)
        })(window, document, 'script', '//www.google-analytics.com/analytics.js', 'ga');

        ga('create', 'UA-56329391-1', 'auto');
        ga('send', 'pageview');

    </script>

    <script language="javascript" type="text/javascript">
        function SetScrollEvent() {
            window.scrollTo(0, 0);
        }
    </script>

    <link href="Content/images/logoico.ico" rel="shortcut icon" type="Content/images/x-icon" />
    <!--<link href='http://fonts.googleapis.com/css?family="Myriad Pro"' rel='stylesheet' type='text/css'/>-->
    <link href="Content/styles/admin_styles.css" rel="stylesheet" type="text/css" />
    <link href="Content/styles/admin_menu.css" rel="stylesheet" type="text/css" />
    <!--provider Slider-->
    <!--popup--->
    <link rel="stylesheet" href="Content/jquery/popup/popup.css" type="text/css" />

    <script type="text/javascript" src="Content/jquery/collasp/jquery.js"></script>

    <script type="text/javascript" language="javascript" src="Content/js/scripts/JScript.js"></script>

    <!------------Mp3 Player----------------->
    <link rel="stylesheet" type="text/css" href="Content/jquery/mp_player/inlineplayer.css">
    <link rel="stylesheet" type="text/css" href="Content/jquery/mp_player/flashblock.css">

    <script type="text/javascript" src="Content/jquery/mp_player/soundmanager2.js"></script>

    <script type="text/javascript" src="Content/jquery/mp_player/inlineplayer.js"></script>

    <!------------Mp3 Player Close----------------->
    <!--Left Menu accordian close--->

    <script type="text/javascript" src="Content/js/jquery-1.7.2.min.js" language="javascript"></script>

    <script language="javascript" type="text/javascript">
        function divexpandcollapse(divname) {
            var div = document.getElementById(divname);
            var img = document.getElementById('img' + divname);
            if (div.style.display == "none") {
                div.style.display = "inline";
                img.src = "Images/minus.gif";
            } else {
                div.style.display = "none";
                img.src = "Images/plus.gif";
            }
        }        
    </script>

    <script type="text/javascript" language="javascript">
        function mathRoundForTaxesv(source) {
            var txtBox = document.getElementById(source);
            var txt = txtBox.value;
            if (!isNaN(txt) && isFinite(txt) && txt.length != 0) {
                var rounded = Math.round(txt * 100) / 100;
                txtBox.value = rounded.toFixed(2);
                var rowscount = $("#<%=GrdVwAmcOffer.ClientID %> tr").length;
                var objGridView = document.getElementById('<%=GrdVwAmcOffer.ClientID%>');
                for (var i = 1; i < rowscount; i++) {
                    if (objGridView.rows[i].cells[3].children[0].value != "") {
                        cellValuePayment = objGridView.rows[i].cells[3].children[0].value;
                        cellValueDue = objGridView.rows[i].cells[1].children[0].innerHTML;
                        if ((parseFloat(cellValuePayment)) > (parseFloat(cellValueDue))) {
                            document.getElementById("<%=Div2.ClientID %>").style.display = "block";
                            document.getElementById("<%=Div2.ClientID %>").className = "alert_boxes_pink big_msg";
                            document.getElementById("<%=LabelMsg.ClientID %>").innerHTML = "Please enter valid pay amount less than requested amount :  " + parseFloat(cellValueDue).toFixed(2);
                            document.getElementById("<%=btnVerifyPayment.ClientID %>").disabled = true;
                            document.getElementById("<%=btnVerifyPayment.ClientID %>").className = "button_all_Sec";

                        }
                        else {
                            document.getElementById("<%=Div2.ClientID %>").style.display = "none";
                            document.getElementById("<%=Div2.ClientID %>").className = "";
                            document.getElementById("<%=LabelMsg.ClientID %>").innerHTML = "";
                            document.getElementById("<%=btnVerifyPayment.ClientID %>").disabled = false;
                            document.getElementById("<%=btnVerifyPayment.ClientID %>").className = "button_all";
                            return;
                        }
                    }
                }
            }
        }        
    </script>

</head>
<body>
    <form id="form1" runat="server">
    <cc1:ToolkitScriptManager runat="Server" AsyncPostBackTimeout="90000" EnablePartialRendering="true"
        EnablePageMethods="true" ID="ScriptManager1" />
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress9" AssociatedUpdatePanelID="UpdatePanel2" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div style="position: absolute; height: 1450px; width: 100%; z-index: 10002; text-align: center;"
                        class="NewmodalBackground">
                        <div style="margin-top: 470px; text-align: center; margin-left: 100px;">
                            <img alt="" src="Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <!--top header-->
            <div id="top_head_p">
                <div id="top_head">
                    <div class="right_part_main right">
                        <div class="h_menu">
                            <div class="username">
                                <a href="#">Welcome,&nbsp;
                                    <asp:Label ID="lblloginName" runat="server"></asp:Label>
                                </a>
                            </div>
                            <div class="admin_role">
                                <ul>
                                    <li class="alert"><a href="Dashboard.aspx" class="sms_no">
                                        <asp:Label ID="lblallertcount" runat="server" Text="0"></asp:Label></a></li>
                                    <%--<li class="sms"><a href="#" class="sms_no">22</a></li>--%>
                                    <li>
                                        <asp:ImageButton ID="imglogout" OnClick="imglogout_Click" ToolTip="Logout" ImageUrl="~/Content/images/logout.png"
                                            runat="server" />
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            <!--top header close-->
            <div id="header_p">
                <div id="header">
                    <div class="logoarrange">
                        <a href="#">
                            <img src="Content/images/logo.png" alt="logo" /></a>
                    </div>
                </div>
            </div>
            <%--<div id="menu_p">
                <div id="menu">
                    <div class="menu_mid">
                        <div class="btn_part left">
                            <ul>
                                <li class="left_radius active"><a href="Dashboard.aspx">Dashboard</a></li>
                            </ul>
                        </div>
                    </div>
                </div>
            </div>--%>
            <!--container starts-->
            <div id="container">
                <div id="content">
                    <div class="detail_right right" style="float: left; width: 100%;">
                        <div class="detail_container" style="width: 100%;">
                            <div class="grid_container" style="width: 100%;">
                                <table cellspacing="2" cellpadding="0" class="MyDashMenu" width="100%">
                                    <% if (Session["User_Type"] != null)
                                       {
                                           if (Session["User_Type"].ToString() == "Admin")
                                           { %>
                                    <tr>
                                        <td align="center">
                                            <a href="CodeGeneration.aspx">
                                                <img src="Content/images/generate_code_.png" alt="Project" /></a><br />
                                            <a href="CodeGeneration.aspx">Code Bank</a>
                                        </td>
                                        <td align="center">
                                            <a href="ProFileAuthentiCation.aspx">
                                                <img src="Content/images/registered_companies.png" alt="Site" /></a>
                                            <br />
                                            <a href="ProFileAuthentiCation.aspx">Company</a>
                                        </td>
                                        <td align="center">
                                            <a href="FrmGeneratedInvoices.aspx?ID=Label">
                                                <img src="Content/images/generated_bill.png" alt="Bills" /></a>
                                            <br />
                                            <a href="FrmGeneratedInvoices.aspx?ID=Label">Bills</a>
                                        </td>
                                        <td align="center">
                                            <a href="frmPayment.aspx">
                                                <img src="Content/images/payment_h.png" alt="Department" /></a>
                                            <br />
                                            <a href="frmPayment.aspx">Payment</a>
                                        </td>
                                        <td align="center">
                                            <a href="FrmSendMailaspx.aspx">
                                                <img src="Content/images/Send_Mail.png" alt="Designation" /></a>
                                            <br />
                                            <a href="FrmSendMailaspx.aspx">Send Mail</a>
                                        </td>
                                        <td align="center">
                                            <a href="FrmCourierMaster.aspx">
                                                <img src="Content/images/24x24.png" alt="User" /></a>
                                            <br />
                                            <a href="FrmCourierMaster.aspx">Courier</a>
                                        </td>
                                        <td align="center">
                                            <a href="FrmBankAccount.aspx">
                                                <img src="Content/images/prices_h.png" alt="Bank Account" /></a>
                                            <br />
                                            <a href="FrmBankAccount.aspx">Bank Account</a>
                                        </td>
                                        <td align="center">
                                            <a href="CodeLabelPrint.aspx">
                                                <img src="Content/images/print.png" alt="Search" /></a>
                                            <br />
                                            <a href="CodeLabelPrint.aspx">Print</a>
                                        </td>
                                        <td align="center">
                                            <a href="frmProductEnquiry.aspx">
                                                <img src="Content/images/product_enquiry.png" alt="General Document" /></a>
                                            <br />
                                            <a href="frmProductEnquiry.aspx">Enquiry</a>
                                        </td>
                                        <td align="center">
                                            <a href="FrmGracePeriod.aspx">
                                                <img src="Content/images/generated_bill.png" alt="Grace Period" /></a>
                                            <br />
                                            <a href="FrmGracePeriod.aspx">Grace Period</a>
                                        </td>
                                        <td align="center">
                                            <a href="Customer_Care.aspx">
                                                <img src="Content/images/phone_.png" alt="Customer Care" /></a>
                                            <br />
                                            <a href="Customer_Care.aspx">Customer Care</a>
                                        </td>
                                    </tr>
                                    <%}
                                           else if (Session["User_Type"].ToString() == "Customer Care")
                                           {
                                    %>
                                    <tr>
                                        <td align="left">
                                            <a href="Customer_Care.aspx" style="margin: 35px;">
                                                <img src="Content/images/generate_code_.png" alt="Project" /></a><br />
                                            <a href="Customer_Care.aspx" style="margin: 10px;">Customer Care</a>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                           else
                                           {
                                    %>
                                    <tr>
                                        <td align="center">
                                            <a href="UpDateCompanyProfile.aspx">
                                                <img src="Content/images/update_com_h.png" alt="Department" /></a>
                                            <br />
                                            <a href="UpDateCompanyProfile.aspx">Update Profile</a>
                                        </td>
                                        <td align="center">
                                            <a href="RegisteredProduct.aspx">
                                                <img src="Content/images/reg_pro.png" alt="Project" /></a><br />
                                            <a href="RegisteredProduct.aspx">Registered Product</a>
                                        </td>
                                        <td align="center">
                                            <a href="ProductDetails.aspx">
                                                <img src="Content/images/add_pro_h.png" alt="Site" /></a>
                                            <br />
                                            <a href="ProductDetails.aspx">Product Details</a>
                                        </td>
                                        <td align="center">
                                            <a href="frmPrintLabel.aspx">
                                                <img src="Content/images/print_h.png" alt="Vendor" /></a>
                                            <br />
                                            <a href="frmPrintLabel.aspx">Printed Labels</a>
                                        </td>
                                        <td align="center">
                                            <a href="frmManufactureBill.aspx">
                                                <img src="Content/images/generated_bill.png" alt="Designation" /></a>
                                            <br />
                                            <a href="frmManufactureBill.aspx">Bills</a>
                                        </td>
                                        <td align="center">
                                            <a href="frmManfEnquiry.aspx">
                                                <img src="Content/images/acco_rep_h.png" alt="User" /></a>
                                            <br />
                                            <a href="frmManfEnquiry.aspx">Enquiry Detail</a>
                                        </td>
                                        <td align="center">
                                            <a href="frmPayments.aspx">
                                                <img src="Content/images/payment_h.png" alt="Document" /></a>
                                            <br />
                                            <a href="frmPayments.aspx">Payment</a>
                                        </td>
                                        <td align="center">
                                            <a href="frmProductSeries.aspx">
                                                <img src="Content/images/feedback_h.png" alt="Search" /></a>
                                            <br />
                                            <a href="frmProductSeries.aspx">Product Series Detail</a>
                                        </td>
                                        <td align="center">
                                            <a href="Frm_Scrap.aspx">
                                                <img src="Content/images/scrap.png" alt="General Document" /></a>
                                            <br />
                                            <a href="Frm_Scrap.aspx">Scrap Summary</a>
                                        </td>
                                        <td align="center">
                                            <a href="FrmScrapLabelM.aspx">
                                                <img src="Content/images/scrap.png" alt="Change Password" /></a>
                                            <br />
                                            <a href="FrmScrapEntry.aspx">Scrap Entry</a>
                                        </td>
                                        <td align="center">
                                            <a href="FrmLabelDispatch.aspx">
                                                <img src="Content/images/dispatch.png" alt="Change Password" /></a>
                                            <br />
                                            <a href="FrmLabelDispatch.aspx">Label Receive</a>
                                        </td>
                                    </tr>
                                    <%
                                        }
                                       }%>
                                </table>
                                <div id="DivDemoPanal" runat="server">
                                    <div class="user_panel">
                                        <div class="detail_right right" style="width: 99%;">
                                            <%--right--%>
                                            <div class="detail_container">
                                                <div class="head_cont">
                                                    <h2 class="msg_infodemo">
                                                        <table width="99%">
                                                            <tr>
                                                                <td width="85%">
                                                                    Dashboard
                                                                </td>
                                                                <td align="right">
                                                                    <!--<a href="#" class="button"><img src="Content/images/add_new.png" alt="add new" /></a>-->
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </h2>
                                                </div>
                                                <div id="NewMsgpop" runat="server">
                                                    <p>
                                                        <asp:Label ID="lbldemoMsg" runat="server"></asp:Label></p>
                                                </div>
                                                <div class="demmoUser" style="min-height: 460px;">
                                                    <p>
                                                        <span>You are registered as demo user.</span></p>
                                                    <p>
                                                        Do you want to upgrade your account as a licence user?</p>
                                                    <p>
                                                        <asp:Button ID="btnUpgradeAcc" runat="server" OnClientClick="return confirm('Are you sure?')"
                                                            CssClass="button_all" Text="Upgrade" OnClick="btnUpgradeAcc_Click" />
                                                        <%--<button type="submit" value="" name="yes" class="button_all">Yes</button> ~/MasterPage.master --%>
                                                    </p>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div id="Div1" runat="server">
                                    <div id="NewMsg" runat="server" style="width: 94%;">
                                        <p>
                                            <asp:Label ID="LblDashBoardmsg" runat="server" Style="font-family: Arial; font-size: 12px;"></asp:Label></p>
                                    </div>
                                    <table width="100%" cellspacing="1" style="margin: 0 auto;">
                                        <tr>
                                            <td width="48%">
                                                <div class="dashgrid">
                                                    <h4 style="width: 98.6%; line-height: 25px; height: 25px;">
                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td width="5%" align="center">
                                                                        <img src="Content/images/regis_pro.png" alt="products">
                                                                    </td>
                                                                    <td class="bord_right">
                                                                        Payment Request Record(s) found <span class="small_font">(<asp:Label ID="Label1"
                                                                            runat="server" Text="0" />)</span>
                                                                    </td>
                                                                    <td width="25%" align="center">
                                                                        <asp:Label ID="lblrecpayment" Style="font-family: Verdana; font-size: 12px; color: Black;"
                                                                            Text="Payment Requested: " CssClass="small_font" runat="server"></asp:Label>
                                                                        &nbsp;
                                                                        <asp:Label ID="lbltotalpay" Style="font-family: Verdana; font-size: 12px; color: Red;"
                                                                            CssClass="small_font" runat="server"></asp:Label>
                                                                    </td>
                                                                    <td width="8%" align="center">
                                                                        <div class="right_refresh">
                                                                            <asp:ImageButton ID="RefreshPayment" ToolTip="Refresh" runat="server" ImageUrl="~/images/vw_refresh.png"
                                                                                OnClick="RefreshPayment_Click" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </h4>
                                                    <div style="overflow: auto; height: 150px;">
                                                        <asp:GridView ID="GrdRequestAmount" runat="server" AutoGenerateColumns="False" CssClass="grid"
                                                            DataKeyNames="Flag,PMT" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                                                            EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                                                            BorderColor="transparent" OnRowCommand="GrdRequestAmount_RowCommand">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Date">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblReqdate" runat="server" Text='<%# Bind("Req_Date","{0:MMM dd, yyyy}") %>'></asp:Label>
                                                                        <asp:Label ID="lblreqesttransno" runat="server" Text='<%# Bind("Request_No") %>'
                                                                            Visible="false"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="9%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Company Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblReqPayCompNm" runat="server" Text='<%# Bind("Comp_Name") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                    <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="20%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Bank Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblReqbankNm" runat="server" Text='<%# Bind("Bank_Name") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                    <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="20%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Payment">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblReqpaymentfor" runat="server" Text='<%# Bind("PMT") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="6.5%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Pay Mode">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblReqPayMode" runat="server" Text='<%# Bind("PayMode") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="7.5%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Details">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblReqDetails" runat="server" Text='<%# Bind("Details") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                    <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="15%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Req. Amount">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblReqAoumtNo" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                                            Text='<%# Bind("Req_Amount") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Left" CssClass="grd_pad" Width="10%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Rec. Amount">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblRecAoumtNo" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                                            Text='<%# Bind("Rec_Amount") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Left" CssClass="grd_pad" Width="10%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Remarks">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblReqRemarks" runat="server" Text='<%# Bind("Remark") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                    <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="20%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Action">
                                                                    <ItemTemplate>
                                                                        <%try
                                                                          {
                                                                              payflag = Convert.ToInt32(GrdRequestAmount.DataKeys[pindex].Values["Flag"].ToString());
                                                                          }
                                                                          catch { }
                                                                          if (payflag != 0)
                                                                          {
                                                                        %>
                                                                        <asp:Label ID="lblstatuspayment" runat="server" Text='<%# Bind("ReqSt") %>' />
                                                                        <%}
                                                                          else
                                                                          {
                                                                              if (Session["User_Type"].ToString() == "Admin")
                                                                              { %>
                                                                        <asp:ImageButton ID="ImgVerifyReqPay" runat="server" ImageUrl="~/images/check_gr_red.png"
                                                                            CommandName="VerifyReqPay" Height="12px" Width="12px" CommandArgument='<%# Bind("MyID") %>'
                                                                            ToolTip="Click for Verify" />
                                                                        <%} %>
                                                                        &nbsp;&nbsp;<asp:ImageButton ID="ImgCanceledRequestPay" runat="server" ImageUrl="~/images/Erase.png"
                                                                            CommandName="CanceledRequest" Height="12px" Width="12px" CommandArgument='<%# Bind("MyID") %>'
                                                                            CausesValidation="false" ToolTip="Click for Cancelled Request" />
                                                                        <%} %>
                                                                        <% pindex++;%>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="10%" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <EmptyDataRowStyle HorizontalAlign="Center" />
                                                            <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                            <RowStyle CssClass="tr_line1" />
                                                            <AlternatingRowStyle CssClass="tr_line2" />
                                                        </asp:GridView>
                                                    </div>
                                                    <asp:Label ID="Label2" runat="server" Visible="false"></asp:Label>
                                                    <asp:Label ID="Label3" runat="server" Visible="false"></asp:Label>
                                                    <asp:HiddenField ID="HiddenField4" runat="server" />
                                                    <asp:HiddenField ID="HiddenField5" runat="server" />
                                                    <asp:HiddenField ID="HiddenField6" runat="server" />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <% if (Session["User_Type"] != null)
                                       {
                                           if (Session["User_Type"].ToString() == "Admin")
                                           { %>
                                    <hr />
                                    <table width="100%" cellspacing="1" style="margin: 0 auto;">
                                        <tr>
                                            <td width="48%">
                                                <div class="dashgrid">
                                                    <h4 style="width: 98.6%; line-height: 25px; height: 25px;">
                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td width="5%" align="center">
                                                                        <img src="Content/images/regis_pro.png" alt="products">
                                                                    </td>
                                                                    <td class="bord_right">
                                                                        Interested For Demo Record(s) found <span class="small_font">(<asp:Label ID="lblInterested"
                                                                            runat="server" Text="0" />)</span>
                                                                    </td>
                                                                    <td width="8%" align="center">
                                                                        <div class="right_refresh">
                                                                            <asp:ImageButton ID="RefreshInterested" ToolTip="Refresh" runat="server" ImageUrl="~/images/vw_refresh.png"
                                                                                OnClick="RefreshInterested_Click" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </h4>
                                                    <div style="overflow: auto; height: 150px;">
                                                        <asp:GridView ID="GrdVwInterested" runat="server" AutoGenerateColumns="False" DataKeyNames="Status"
                                                            CssClass="grid" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                                                            EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                                                            BorderColor="transparent" OnRowCommand="GrdVwInterested_RowCommand">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Request Date">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="IntlblEntryDate" runat="server" Text='<%# Bind("Reg_Date","{0:MMM dd, yyyy}") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="9%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Company Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="IntlblCompName" runat="server" Text='<%# Bind("Comp_Name") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                    <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Contact Person">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="IntlblContactNm" runat="server" Text='<%# Bind("Contact_Person") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Mobile No.">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="IntlblEM1" runat="server" Text='<%# Bind("Mobile_No") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                    <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="E-mail">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="IntlblEmail" runat="server" Text='<%# Bind("Comp_Email") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                    <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Status">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="Intlblrequeststatus" runat="server" Text='<%# Bind("ReqStFlag") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="15%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Action">
                                                                    <ItemTemplate>
                                                                        <%try
                                                                          {
                                                                              IntStatus = Convert.ToInt32(GrdVwInterested.DataKeys[IntIndex].Values["Status"].ToString());
                                                                          }
                                                                          catch { }
                                                                          if (IntStatus == 0)
                                                                          {
                                                                        %>
                                                                        <asp:ImageButton ID="ImgYesContact" runat="server" ImageUrl="~/images/check_act.png"
                                                                            Height="12px" CausesValidation="false" Width="12px" CommandName="IntReqAccept"
                                                                            OnClientClick="return confirm('Are you sure to contact this person and verify?')"
                                                                            CommandArgument='<%# Bind("Row_ID") %>' ToolTip="Interested Request Accepted" />
                                                                        <asp:ImageButton ID="Imgprintcamcellabel" runat="server" ImageUrl="~/images/Erase.png"
                                                                            Height="12px" CausesValidation="false" Width="12px" CommandName="IntReqCancel"
                                                                            OnClientClick="return confirm('Are you sure to cancel this request?')" CommandArgument='<%# Bind("Row_ID") %>'
                                                                            ToolTip="Interested Request Cancel" />
                                                                        <%} %>
                                                                        <%IntIndex++; %>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="5%" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <EmptyDataRowStyle HorizontalAlign="Center" />
                                                            <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                            <RowStyle CssClass="tr_line1" />
                                                            <AlternatingRowStyle CssClass="tr_line2" />
                                                        </asp:GridView>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="100%" cellspacing="1" style="margin: 0 auto;">
                                        <tr>
                                            <td width="48%">
                                                <div class="dashgrid">
                                                    <h4 style="width: 98.6%; line-height: 25px; height: 25px;">
                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td width="5%" align="center">
                                                                        <img src="Content/images/regis_pro.png" alt="products">
                                                                    </td>
                                                                    <td class="bord_right">
                                                                        New Registered Companies Record(s) found <span class="small_font">(<asp:Label ID="Label5"
                                                                            runat="server" Text="0" />)</span>
                                                                    </td>
                                                                    <td width="25%" align="center">
                                                                    </td>
                                                                    <td width="8%" align="center">
                                                                        <div class="right_refresh">
                                                                            <asp:ImageButton ID="RefreshNewReg" ToolTip="Refresh" runat="server" ImageUrl="~/images/vw_refresh.png"
                                                                                OnClick="RefreshNewReg_Click" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </h4>
                                                    <div style="overflow: auto; height: 150px;">
                                                        <asp:GridView ID="GrdProductMaster" runat="server" AutoGenerateColumns="False" DataKeyNames="Status,Email_Vari_flag,Doc_Flag,D,Comp_ID"
                                                            CssClass="grid" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                                                            EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                                                            ShowFooter="true" BorderColor="transparent">
                                                            <PagerSettings Mode="Numeric" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Status">
                                                                    <ItemTemplate>
                                                                        <%try
                                                                          {
                                                                              dflag = Convert.ToString(GrdProductMaster.DataKeys[docindex].Values["D"].ToString());
                                                                              ver_email = Convert.ToInt32(GrdProductMaster.DataKeys[docindex].Values["Email_Vari_flag"]);
                                                                              st_flag = Convert.ToInt32(GrdProductMaster.DataKeys[docindex].Values["Status"]);
                                                                              FPath = Server.MapPath("../Data/Sound");
                                                                              CurrCompID = GrdProductMaster.DataKeys[docindex].Values["Comp_ID"].ToString();
                                                                              FPath = FPath + "\\" + CurrCompID.ToString().Substring(5, 4) + "\\" + CurrCompID.ToString().Substring(5, 4) + ".wav";
                                                                              if (System.IO.File.Exists(FPath))
                                                                                  FSound = "Y";
                                                                              else
                                                                                  FSound = "N";
                                                                          }
                                                                          catch { }
                                                                          if (ver_email == 1)
                                                                          {
                                                                              if (dflag == "ENo")
                                                                              {
                                                                                  if (st_flag == 0)
                                                                                  {                                                                           
                                                                        %>
                                                                        <asp:Label ID="lbluup" runat="server" ForeColor="Green" Text='Account de-activate'></asp:Label>
                                                                        <% 
                                                                            }
                                                                              }
                                                                              else if (dflag == "EYes")
                                                                              {
                                                                        %>
                                                                        <asp:Label ID="Labellbluup" runat="server" ForeColor="Maroon" Text='Documents not-verified'></asp:Label>
                                                                        <%
                                                                            }
                                                                              else
                                                                              {
                                                                        %>
                                                                        <asp:Label ID="lbllopo" runat="server" ForeColor="Red" Text='Profile Not Update or Documents Not-Uploaded'></asp:Label>
                                                                        <%
                                                                            }
                                                                          }
                                                                          else
                                                                          {
                                                                        %>
                                                                        <asp:Label ID="lbllopoLabel6" runat="server" ForeColor="Red" Text='E-mail verification pending'></asp:Label>
                                                                        <%
                                                                            }                                                                      
                                                                        %>
                                                                        <%docindex++; %>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Left" Width="13%" CssClass="tr_padleft" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Reg. Date" SortExpression="Reg_Date">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblactudateVer" runat="server" Text='<%# Bind("Reg_Date","{0:MMM dd, yyyy}") %>'></asp:Label>
                                                                        <asp:Label ID="Label1234567" runat="server" Text='<%# Bind("Comp_ID") %>' Visible="false"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="8%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Company Name" SortExpression="Comp_Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblactudateNew" runat="server" Text='<%# Bind("Comp_Name") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="left" />
                                                                    <ItemStyle HorizontalAlign="left" CssClass="grd_pad" Width="20%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Email">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblactudateOld" runat="server" Text='<%# Bind("Comp_Email") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                    <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Contact Person">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblactudateBrother" runat="server" Text='<%# Bind("Contact_Person") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                    <ItemStyle HorizontalAlign="left" CssClass="grd_pad" Width="15%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Mobile No.">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblactudateBig" runat="server" Text='<%# Bind("Mobile_No") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="8%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Type" SortExpression="TypeCmp">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblcomphgj875658type" runat="server" Text='<%# Bind("TypeCmp") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="4%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Sound">
                                                                    <ItemTemplate>
                                                                        <% if (FSound == "Y")
                                                                           { %>
                                                                        <ul class="graphic">
                                                                            <li><a href='<%# Eval("SoundPath") %>' class="sm2_link"></a></li>
                                                                        </ul>
                                                                        <%}
                                                                           else
                                                                           { %>
                                                                        <img alt="" src="Content/images/VolumeN.png" height="14px" width="14px" title="Sound not uploaded" />
                                                                        <%} %>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed bord_left" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                            <RowStyle CssClass="tr_line1" />
                                                            <AlternatingRowStyle CssClass="tr_line2" />
                                                        </asp:GridView>
                                                    </div>
                                                    <asp:Label ID="Label8" runat="server" Visible="false"></asp:Label>
                                                    <asp:Label ID="Label9" runat="server" Visible="false"></asp:Label>
                                                    <asp:HiddenField ID="HiddenField7" runat="server" />
                                                    <asp:HiddenField ID="HiddenField8" runat="server" />
                                                    <asp:HiddenField ID="HiddenField9" runat="server" />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <hr />
                                    <table width="100%" cellspacing="1" style="margin: 0 auto;">
                                        <tr>
                                            <td width="48%">
                                                <div class="dashgrid">
                                                    <h4 style="width: 98.6%; line-height: 25px; height: 25px;">
                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td width="5%" align="center">
                                                                        <img src="Content/images/regis_pro.png" alt="products">
                                                                    </td>
                                                                    <td class="bord_right">
                                                                        Working Status Companys Record(s) found <span class="small_font">(<asp:Label ID="LblworkCount"
                                                                            runat="server" Text="0" />)</span>
                                                                    </td>
                                                                    <td width="25%" align="center">
                                                                    </td>
                                                                    <td width="8%" align="center">
                                                                        <div class="right_refresh">
                                                                            <asp:ImageButton ID="RefreshWorkStatus" ToolTip="Refresh" runat="server" ImageUrl="~/images/vw_refresh.png"
                                                                                OnClick="RefreshWorkStatus_Click" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </h4>
                                                    <div style="overflow: auto; height: 150px;">
                                                        <asp:GridView ID="GrdVwCompWork" runat="server" AutoGenerateColumns="False" DataKeyNames="P,Doc_Flag,Sound_Flag,R"
                                                            CssClass="grid" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                                                            EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                                                            ShowFooter="true" BorderColor="transparent">
                                                            <PagerSettings Mode="Numeric" />
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Working Status">
                                                                    <ItemTemplate>
                                                                        <%try
                                                                          {
                                                                              pro = Convert.ToInt32(GrdVwCompWork.DataKeys[windex].Values["P"]);
                                                                              docflag = Convert.ToInt32(GrdVwCompWork.DataKeys[windex].Values["Doc_Flag"]);
                                                                              sflag = Convert.ToInt32(GrdVwCompWork.DataKeys[windex].Values["Sound_Flag"]);
                                                                              rflag = Convert.ToInt32(GrdVwCompWork.DataKeys[windex].Values["R"]);
                                                                          }
                                                                          catch { }
                                                                          if (pro > 0)
                                                                          {
                                                                              if ((sflag == 1) && (docflag == 1))
                                                                              {
                                                                                  if (rflag == 2)
                                                                                  {                                                                           
                                                                        %>
                                                                        <asp:Label ID="lblworkrequest" runat="server" ForeColor="Green" Text='Request Pending'></asp:Label>
                                                                        <% 
                                                                            }
                                                                                  else if (rflag == 3)
                                                                                  {
                                                                        %>
                                                                        <asp:Label ID="lblworkrequestno" runat="server" ForeColor="Green" Text='Request canceled by admin'></asp:Label>
                                                                        <%
                                                                            }
                                                                                  else if (rflag == 4)
                                                                                  {
                                                                        %>
                                                                        <asp:Label ID="lblworkrequestnosend" runat="server" ForeColor="Green" Text='Label print request not send'></asp:Label>
                                                                        <%
                                                                            }
                                                                              }
                                                                              else if ((sflag == 1) && (docflag == 0))
                                                                              {
                                                                        %>
                                                                        <asp:Label ID="Lblworkdocsoundst" runat="server" ForeColor="Maroon" Text='Sound file verified & document not-verified'></asp:Label>
                                                                        <%
                                                                            }
                                                                              else if ((sflag == 1) && (docflag == -1))
                                                                              {
                                                                        %>
                                                                        <asp:Label ID="Lblworkdocsoundstdff" runat="server" ForeColor="Maroon" Text='Sound file verified & document cenceled'></asp:Label>
                                                                        <%
                                                                            }
                                                                              else if ((sflag == 0) && (docflag == -1))
                                                                              {
                                                                        %>
                                                                        <asp:Label ID="Lblworkdocsoundsttghgh" runat="server" ForeColor="Maroon" Text='Sound file not-verified & document cenceled'></asp:Label>
                                                                        <%
                                                                            }
                                                                              else if ((sflag == 0) && (docflag == 1))
                                                                              {
                                                                        %>
                                                                        <asp:Label ID="Lblworkdfdocsoundst" runat="server" ForeColor="Maroon" Text='Sound file not-verified & document verified'></asp:Label>
                                                                        <%
                                                                            }
                                                                              else if ((sflag == 0) && (docflag == 0))
                                                                              {
                                                                        %>
                                                                        <asp:Label ID="Lblworkdocioisoundst" runat="server" ForeColor="Maroon" Text='Sound & document file verification pending'></asp:Label>
                                                                        <%
                                                                            }
                                                                              else if ((sflag == -1) && (docflag == 0))
                                                                              {
                                                                        %>
                                                                        <asp:Label ID="LabelLblworkdocioisoundst" runat="server" ForeColor="Maroon" Text='Sound file canceled & document verification pending'></asp:Label>
                                                                        <%
                                                                            }
                                                                              else if ((sflag == -1) && (docflag == 1))
                                                                              {
                                                                        %>
                                                                        <asp:Label ID="LabLblworkdocioisoundstel13" runat="server" ForeColor="Maroon" Text='Sound file canceled & document verified'></asp:Label>
                                                                        <%
                                                                            }
                                                                              else
                                                                              {
                                                                        %>
                                                                        <asp:Label ID="Label1Lblworkdocioisoundst4" runat="server" ForeColor="Maroon" Text='Sound & document upload again'></asp:Label>
                                                                        <%
                                                                            }
                                                                          }
                                                                          else
                                                                          {
                                                                        %>
                                                                        <asp:Label ID="lblprLblworkdocioisoundstostatus" runat="server" ForeColor="Red" Text='Product not-registered'></asp:Label>
                                                                        <%
                                                                            }                                                                      
                                                                        %>
                                                                        <%windex++; %>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Left" Width="20%" CssClass="tr_padleft" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Reg. Date" SortExpression="Reg_Date">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblworkactudateVerwork" runat="server" Text='<%# Bind("Reg_Date","{0:MMM dd, yyyy}") %>'></asp:Label>
                                                                        <asp:Label ID="Label123work4567work" runat="server" Text='<%# Bind("Comp_ID") %>'
                                                                            Visible="false"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="8%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Company Name" SortExpression="Comp_Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblactuworkdateNewwork" runat="server" Text='<%# Bind("Comp_Name") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="left" />
                                                                    <ItemStyle HorizontalAlign="left" CssClass="grd_pad" Width="20%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Email">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblactuworkdateOldwork" runat="server" Text='<%# Bind("Comp_Email") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                    <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Contact Person">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblactudatworkeBrotherwork" runat="server" Text='<%# Bind("Contact_Person") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                    <ItemStyle HorizontalAlign="left" CssClass="grd_pad" Width="15%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Mobile No.">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblactudatworkeBigwork" runat="server" Text='<%# Bind("Mobile_No") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="8%" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                            <RowStyle CssClass="tr_line1" />
                                                            <AlternatingRowStyle CssClass="tr_line2" />
                                                        </asp:GridView>
                                                    </div>
                                                    <asp:Label ID="Label10" runat="server" Visible="false"></asp:Label>
                                                    <asp:Label ID="Label11" runat="server" Visible="false"></asp:Label>
                                                    <asp:HiddenField ID="HiddenField12" runat="server" />
                                                    <asp:HiddenField ID="HiddenField13" runat="server" />
                                                    <asp:HiddenField ID="HiddenField14" runat="server" />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <hr />
                                    <%}
                                       } %>
                                    <hr />
                                    <table width="100%" cellspacing="1" style="margin: 0 auto;">
                                        <tr>
                                            <td width="48%">
                                                <div class="dashgrid">
                                                    <h4 style="width: 98.6%; line-height: 25px; height: 25px;">
                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td width="5%" align="center">
                                                                        <img src="Content/images/regis_pro.png" alt="products">
                                                                    </td>
                                                                    <td class="bord_right">
                                                                        Product wise legal document and Sound File Record(s)<span class="small_font"> (<asp:Label
                                                                            ID="LabelProdoc" runat="server" Text="0" />)</span>
                                                                    </td>
                                                                    <td width="8%" align="center">
                                                                        <div class="right_refresh">
                                                                            <asp:ImageButton ID="RefreshSoundDoc" ToolTip="Refresh" runat="server" ImageUrl="~/images/vw_refresh.png"
                                                                                OnClick="RefreshSoundDoc_Click" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </h4>
                                                    <div style="overflow: auto; height: 150px;">
                                                        <asp:GridView ID="GrdViewProDoc" runat="server" AutoGenerateColumns="False" DataKeyNames="Sound_Flag,Doc_Flag"
                                                            CssClass="grid" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                                                            EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                                                            BorderColor="transparent" OnRowCommand="GrdViewProDoc_RowCommand">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Request Date">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="legallblEntryDate" runat="server" Text='<%# Bind("Entry_Date","{0:MMM dd, yyyy}") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="9%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Company Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="legallblBankName" runat="server" Text='<%# Bind("Comp_Name") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                    <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Product Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="legallblAccHolderNm" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Sound File">
                                                                    <ItemTemplate>
                                                                        <ul class="graphic">
                                                                            <li><a href='<%# Eval("SoundPath") %>' class="sm2_link"></a></li>
                                                                        </ul>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed bord_left" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="9%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Documents">
                                                                    <ItemTemplate>
                                                                        <a href='<%# Eval("DocPath") %>' target="_blank" title="View Documents" class="sm2_link">
                                                                            View</a>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed bord_left" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="9%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Sound Status">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblSoundFilestatus" runat="server" Text='<%# Bind("WAVFILE_ST") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                    <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Documents Status">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblDocFilestatus" runat="server" Text='<%# Bind("DOCST") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="12%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Action">
                                                                    <ItemTemplate>
                                                                        <%try
                                                                          {
                                                                              SoundFlag = Convert.ToInt32(GrdViewProDoc.DataKeys[sindex].Values["Sound_Flag"].ToString());
                                                                              DocFlag = Convert.ToInt32(GrdViewProDoc.DataKeys[sindex].Values["Doc_Flag"].ToString());
                                                                          }
                                                                          catch { }
                                                                          if (SoundFlag == 1)
                                                                          {
                                                                        %>
                                                                        <asp:ImageButton ID="legalImgbtnEditAcc" runat="server" ImageUrl="~/images/Verify.png"
                                                                            Enabled="false" CommandName="VerifySound" Height="14px" Width="14px" CommandArgument='<%# Bind("Pro_ID") %>'
                                                                            ToolTip="Verified Sound" />
                                                                        <%}
                                                                          else if (SoundFlag == -1)
                                                                          {
                                                                        %>
                                                                        <asp:ImageButton ID="legalImargeButton4" runat="server" ImageUrl="~/images/UnVerify.png"
                                                                            Enabled="false" CommandName="VerifySound" Height="14px" Width="14px" CommandArgument='<%# Bind("Pro_ID") %>'
                                                                            ToolTip="Sound file Cancel by admin" />
                                                                        <%
                                                                            }
                                                                          else
                                                                          { %>
                                                                        <asp:ImageButton ID="legalImageButton2" runat="server" ImageUrl="~/images/UnVerify_.png"
                                                                            CommandName="VerifySound" Height="14px" Width="14px" CommandArgument='<%# Bind("Pro_ID") %>'
                                                                            ToolTip="Click for Verify Sound" />
                                                                        <%} if (DocFlag == 1)
                                                                          { %>
                                                                        <asp:ImageButton ID="legalImageButton1" runat="server" ImageUrl="~/images/generated_bill.png"
                                                                            Height="16px" Enabled="false" Width="16px" CommandName="VerifyDocuments" CommandArgument='<%# Bind("Pro_ID") %>'
                                                                            ToolTip="Verified Documents" />
                                                                        <%}
                                                                          else if (DocFlag == -1)
                                                                          {%>
                                                                        <asp:ImageButton ID="legalImageButton4" runat="server" ImageUrl="~/images/generated_billC.png"
                                                                            Height="16px" Enabled="false" Width="16px" CommandName="VerifyDocuments" CommandArgument='<%# Bind("Pro_ID") %>'
                                                                            ToolTip="Document Cancel by admin" />
                                                                        <%
                                                                            }
                                                                          else
                                                                          {%>
                                                                        <asp:ImageButton ID="legalImageButton3" runat="server" ImageUrl="~/images/not_verified.png"
                                                                            Height="16px" Width="16px" CommandName="VerifyDocuments" CommandArgument='<%# Bind("Pro_ID") %>'
                                                                            ToolTip="Click for Verify Documents" />
                                                                        <%} %>
                                                                        <%sindex++; %>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="5%" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <EmptyDataRowStyle HorizontalAlign="Center" />
                                                            <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                            <RowStyle CssClass="tr_line1" />
                                                            <AlternatingRowStyle CssClass="tr_line2" />
                                                        </asp:GridView>
                                                    </div>
                                                    <asp:Label ID="LabelProUpId" runat="server" Visible="false"></asp:Label>
                                                    <asp:HiddenField ID="HiddenField1" runat="server" />
                                                    <asp:HiddenField ID="HiddenField2" runat="server" />
                                                    <asp:HiddenField ID="HiddenField3" runat="server" />
                                                    <asp:HiddenField ID="HiddenField10" runat="server" />
                                                    <asp:HiddenField ID="HiddenField11" runat="server" />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <hr />
                                    <table width="100%" cellspacing="1" style="margin: 0 auto;">
                                        <tr>
                                            <td width="48%">
                                                <div class="dashgrid">
                                                    <h4 style="width: 98.6%; line-height: 25px; height: 25px;">
                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td width="5%" align="center">
                                                                        <img src="Content/images/regis_pro.png" alt="products">
                                                                    </td>
                                                                    <td class="bord_right">
                                                                        Labels Request Record(s) found <span class="small_font">(<asp:Label ID="lblLabelsC"
                                                                            runat="server" Text="0" />)</span>
                                                                    </td>
                                                                    <td width="8%" align="center">
                                                                        <div class="right_refresh">
                                                                            <asp:ImageButton ID="RefreshLabelRequest" ToolTip="Refresh" runat="server" ImageUrl="~/images/vw_refresh.png"
                                                                                OnClick="RefreshLabelRequest_Click" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </h4>
                                                    <div style="overflow: auto; height: 150px;">
                                                        <asp:GridView ID="GrdRequestedLabels" runat="server" AutoGenerateColumns="False"
                                                            CssClass="grid" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                                                            EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                                                            BorderColor="transparent" OnRowCommand="GrdRequestedLabels_RowCommand">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Tracking No.">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="printlblTrackingno" runat="server" Text='<%# Bind("Tracking_No") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="9%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Request Date">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="printlblEntryDate" runat="server" Text='<%# Bind("Entry_Date","{0:MMM dd, yyyy}") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" Width="9%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Company Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="printlblBankName" runat="server" Text='<%# Bind("Comp_Name") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                    <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Product Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="printlblAccHolderNm" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Labels Info.">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="printlblAccountNo" runat="server" Text='<%# Bind("Label_Name") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                    <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="No. of Labels">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="printlblBranch" runat="server" Text='<%# Bind("Labels") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="10%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Status">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblrequeststatus" runat="server" Text='<%# Bind("RequestStatusFlag") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="10%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Action">
                                                                    <ItemTemplate>
                                                                        <asp:ImageButton ID="Imgprintcamcellabelyes" runat="server" ImageUrl="~/images/PrintN.png"
                                                                            CausesValidation="false" CommandName="PrintLabels" Height="14px" Width="14px"
                                                                            CommandArgument='<%# Bind("Row_ID") %>' ToolTip="Print Labels" />
                                                                        <asp:ImageButton ID="Imgprintcamcellabel" runat="server" ImageUrl="~/images/Erase.png"
                                                                            Height="12px" CausesValidation="false" Width="12px" CommandName="RequestCancel"
                                                                            CommandArgument='<%# Bind("Row_ID") %>' ToolTip="Request Cancel" />
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                    <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="5%" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <EmptyDataRowStyle HorizontalAlign="Center" />
                                                            <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                            <RowStyle CssClass="tr_line1" />
                                                            <AlternatingRowStyle CssClass="tr_line2" />
                                                        </asp:GridView>
                                                    </div>
                                                    <asp:Label ID="lblRequestLabelID" runat="server" Visible="false"></asp:Label>
                                                    <asp:HiddenField ID="hdProductID" runat="server" />
                                                    <asp:HiddenField ID="hdCompID" runat="server" />
                                                    <asp:HiddenField ID="hdNoofCodes" runat="server" />
                                                    <asp:HiddenField ID="HiddenFieldCompNm" runat="server" />
                                                    <asp:HiddenField ID="HiddenFieldProNm" runat="server" />
                                                    <asp:HiddenField ID="HiddenFieldLabelType" runat="server" />
                                                    <asp:HiddenField ID="HdLabelPrice" runat="server" />
                                                    <asp:HiddenField ID="HiddenTrackingNo" runat="server" />
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                    <hr />
                                    <table width="100%" cellspacing="1" style="margin: 0 auto;">
                                        <tr>
                                            <td width="48%">
                                                <div class="dashgrid">
                                                    <h4 style="width: 98.6%; line-height: 25px; height: 25px;">
                                                        <table width="100%" cellpadding="0" cellspacing="0">
                                                            <tbody>
                                                                <tr>
                                                                    <td width="5%" align="center">
                                                                        <img src="Content/images/regis_pro.png" alt="products">
                                                                    </td>
                                                                    <td class="bord_right">
                                                                        Dispatch Labels Record(s) found <span class="small_font">(<asp:Label ID="LblCountDisp"
                                                                            runat="server" Text="0" />)</span>
                                                                    </td>
                                                                    <td width="8%" align="center">
                                                                        <div class="right_refresh">
                                                                            <asp:ImageButton ID="RefreshLabelDispatch" ToolTip="Refresh" runat="server" ImageUrl="~/images/vw_refresh.png"
                                                                                OnClick="RefreshLabelDispatch_Click" />
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                            </tbody>
                                                        </table>
                                                    </h4>
                                                    <div class="grid_container">
                                                        <div style="overflow: auto; height: 150px;">
                                                            <asp:GridView ID="GrdCourierDispatch" runat="server" AutoGenerateColumns="False"
                                                                DataKeyNames="Flag" CssClass="grid" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                                                                EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                                                                BorderColor="transparent" OnRowCommand="GrdCourierDispatch_RowCommand">
                                                                <Columns>
                                                                    <asp:TemplateField HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                                                        HeaderStyle-CssClass="tr_haed" ItemStyle-CssClass="pad">
                                                                        <ItemTemplate>
                                                                            <a href="JavaScript:divexpandcollapse('div<%# Eval("Courier_Disp_ID") %>');">
                                                                                <img id="imgdiv<%# Eval("Courier_Disp_ID") %>" width="9px" border="0" src="Content/images/plus.gif"
                                                                                    alt="" title="View Products" />
                                                                        </ItemTemplate>
                                                                        <ItemStyle Width="2%" HorizontalAlign="Center" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Company Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblCourierName" runat="server" Text='<%# Bind("Comp_Name") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                        <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="20%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Courier Name">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblCourierEmail" runat="server" Text='<%# Bind("Courier_Name") %>'></asp:Label>
                                                                            <asp:Label ID="lblCDispID" runat="server" Visible="false" Text='<%# Bind("Courier_Disp_ID") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                        <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="20%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Tracking No.">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblLTrackingNo" runat="server" Text='<%# Bind("Tracking_No") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                        <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="8%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Disp. Date">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblLDispDate" runat="server" Text='<%# Bind("Dispatch_Date","{0:MMM dd,yyyy}") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                        <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Exp. Date">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblLExpectedDate" runat="server" Text='<%# Bind("Expected_Date","{0:MMM dd,yyyy}") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                        <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Location">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblLDispLocation" runat="server" Text='<%# Bind("Dispatch_Location") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                        <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Quantity">
                                                                        <ItemTemplate>
                                                                            <asp:Label ID="lblAddressQty" runat="server" Text='<%# Bind("Qty") %>'></asp:Label>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                        <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="5%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField HeaderText="Status">
                                                                        <ItemTemplate>
                                                                            <%try
                                                                              {
                                                                                  Flag = Convert.ToInt32(GrdCourierDispatch.DataKeys[index].Values["Flag"].ToString());
                                                                              }
                                                                              catch
                                                                              {
                                                                              }
                                                                              if (Flag == 0)
                                                                              {%>
                                                                            <asp:Label ID="lblDispatchStatus" runat="server" Text='<%# Bind("Status") %>' ForeColor="Blue"></asp:Label>
                                                                            <%}
                                                                              else if (Flag == 1)
                                                                              {
                                                                            %>
                                                                            <asp:Label ID="lblDispatchStatusLabel1" runat="server" Text='<%# Bind("Status") %>'
                                                                                ForeColor="Green"></asp:Label>
                                                                            <%
                                                                                }
                                                                              else if (Flag == 2)
                                                                              {
                                                                            %>
                                                                            <asp:LinkButton ID="LnkScrapDetails" runat="server" Text='<%# Bind("Status") %>'
                                                                                ToolTip="Click for scrap details" CommandArgument='<%# Bind("Courier_Disp_ID") %>'
                                                                                CommandName="ShowDetails"></asp:LinkButton>
                                                                            <%--<asp:Label ID="lblDispatchStatusLabel2" runat="server" Text='<%# Bind("Status") %>'
                                                                                ForeColor="Maroon"></asp:Label>--%>
                                                                            <%
                                                                                }
                                                                              else if (Flag == -1)
                                                                              {
                                                                            %>
                                                                            <asp:Label ID="lblDispatchStatusLabel3" runat="server" Text='<%# Bind("Status") %>'
                                                                                ForeColor="Red"></asp:Label>
                                                                            <%
                                                                                }%>
                                                                            <%index++; %>
                                                                        </ItemTemplate>
                                                                        <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                        <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="17%" />
                                                                    </asp:TemplateField>
                                                                    <asp:TemplateField>
                                                                        <ItemTemplate>
                                                                            <tr>
                                                                                <td colspan="90%" style="background-color: White">
                                                                                    <div id="div<%# Eval("Courier_Disp_ID") %>" style="display: none; position: relative;
                                                                                        overflow: auto; width: 98%">
                                                                                        <fieldset class="Newfield Newfield_width2">
                                                                                            <legend>Product Wise Label information</legend>
                                                                                            <div style="padding-left: 5px; width: 98.5%;">
                                                                                                <asp:GridView ID="GrdLablelDet" runat="server" AutoGenerateColumns="False" CssClass="grid"
                                                                                                    EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center" EnableModelValidation="True"
                                                                                                    Width="100%" BorderStyle="None" BorderWidth="0" BorderColor="transparent">
                                                                                                    <Columns>
                                                                                                        <asp:TemplateField HeaderText="Product Name">
                                                                                                            <ItemTemplate>
                                                                                                                <asp:Label ID="lblLProNm" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                                                                                                            </ItemTemplate>
                                                                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                                                            <ItemStyle HorizontalAlign="Center" Width="20%" />
                                                                                                        </asp:TemplateField>
                                                                                                        <asp:TemplateField HeaderText="Label Name">
                                                                                                            <ItemTemplate>
                                                                                                                <asp:Label ID="lblLLabelNm" runat="server" Text='<%# Bind("Label_Name") %>'></asp:Label>
                                                                                                            </ItemTemplate>
                                                                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                                                            <ItemStyle HorizontalAlign="Center" Width="20%" />
                                                                                                        </asp:TemplateField>
                                                                                                        <asp:TemplateField HeaderText="Series From">
                                                                                                            <ItemTemplate>
                                                                                                                <asp:Label ID="lblLSeriesFrom" runat="server" Text='<%# Bind("Series_From") %>'></asp:Label>
                                                                                                            </ItemTemplate>
                                                                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                                                            <ItemStyle HorizontalAlign="Center" Width="20%" />
                                                                                                        </asp:TemplateField>
                                                                                                        <asp:TemplateField HeaderText="Series To">
                                                                                                            <ItemTemplate>
                                                                                                                <asp:Label ID="lblLSeriesTo" runat="server" Text='<%# Bind("Series_To") %>'></asp:Label>
                                                                                                            </ItemTemplate>
                                                                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                                                            <ItemStyle HorizontalAlign="Center" Width="23%" />
                                                                                                        </asp:TemplateField>
                                                                                                        <asp:TemplateField HeaderText="Quantity">
                                                                                                            <ItemTemplate>
                                                                                                                <asp:Label ID="lblLCountQty" runat="server" Text='<%# Bind("Qty") %>'></asp:Label>
                                                                                                            </ItemTemplate>
                                                                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                                                            <ItemStyle HorizontalAlign="Center" Width="23%" />
                                                                                                        </asp:TemplateField>
                                                                                                    </Columns>
                                                                                                    <EmptyDataRowStyle HorizontalAlign="Center" />
                                                                                                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                                                                    <RowStyle CssClass="tr_line1" />
                                                                                                    <AlternatingRowStyle CssClass="tr_line2" />
                                                                                                </asp:GridView>
                                                                                            </div>
                                                                                        </fieldset>
                                                                                    </div>
                                                                                </td>
                                                                            </tr>
                                                                        </ItemTemplate>
                                                                    </asp:TemplateField>
                                                                </Columns>
                                                                <EmptyDataRowStyle HorizontalAlign="Center" />
                                                                <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                                <RowStyle CssClass="tr_line1" />
                                                                <AlternatingRowStyle CssClass="tr_line2" />
                                                            </asp:GridView>
                                                            <asp:Label ID="lblCourierId" runat="server" Text="" Visible="false"></asp:Label>
                                                        </div>
                                                    </div>
                                                </div>
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!--===============================PopUp Alert Starts===============================-->
                    <asp:Panel ID="PanelAlert" runat="server" Width="20%" Style="display: none;">
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
                                    <%--<asp:Button ID="testbutton" runat="server" Text="test" CssClass="button_all" OnClick="testbutton" CausesValidation="false" />--%>
                                    <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="button_all" OnClick="btnYes_Click" CausesValidation="false" />&nbsp;&nbsp;<asp:Button
                                        Visible="false" ID="btnCancel" runat="server" Text="Reject" CssClass="button_all"
                                        OnClick="btnCancel_Click" />&nbsp;&nbsp;<asp:Button ID="btnNo" runat="server" Text="No"
                                            Visible="false" CssClass="button_all" OnClick="btnNo_Click" />
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
                    <!--===============================PopUp Alert Starts===============================-->
                    <asp:Panel ID="PanelConfrim" runat="server" Width="20%" Style="display: none;">
                        <div class="popupContent" style="width: 100%;">
                            <div class="pop_log_bg">
                                <div>
                                    <asp:Button ID="BbtConfrimpopclose" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                                <!--<fieldset class="service_field" >-->
                                <div class="service_head_p">
                                    <p>
                                        <span class="left">
                                            <asp:Label ID="LabelConfrimHeader" runat="server" Text="Password" Font-Size="12px"></asp:Label>
                                        </span><span class="right" style="visibility: hidden;"><span class="astrics"><strong>
                                        </strong></span></span>
                                    </p>
                                </div>
                                <div class="regis_popup" style="text-align: center;">
                                    <br />
                                    <asp:Label ID="LabelConfrimText" runat="server" Text="" Font-Size="11px"></asp:Label><br />
                                    <br />
                                    <asp:Button ID="BtnConfrimOK" runat="server" Text="OK" CssClass="button_all" OnClick="btnConfrimOK_Click"
                                        Visible="false" /><%--&nbsp;&nbsp;<asp:Button
                                ID="Button3" runat="server" Text="No" CssClass="button_all" OnClick="btnNo_Click" />--%>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <!--===============================Popup Close================================-->
                    <asp:Label ID="LabelConfirm" runat="server"></asp:Label><asp:Label ID="Label4" runat="server"
                        Visible="false"></asp:Label>
                    <cc1:ModalPopupExtender ID="ModalPopupExtenderConfrim" runat="server" BackgroundCssClass="NewmodalBackground"
                        CancelControlID="BbtConfrimpopclose" PopupControlID="PanelConfrim" TargetControlID="LabelConfirm">
                    </cc1:ModalPopupExtender>
                    <!--===============================PopUp Alert Starts===============================-->
                    <asp:Panel ID="PanelOnlyConfirm" runat="server" Width="20%" Style="display: none;">
                        <div class="popupContent" style="width: 100%;">
                            <div class="pop_log_bg">
                                <div>
                                    <asp:Button ID="ButtonReasonClose" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                                <!--<fieldset class="service_field" >-->
                                <div class="service_head_p">
                                    <p>
                                        <span class="left">
                                            <asp:Label ID="Label6" runat="server" Text="Reason" Font-Size="12px"></asp:Label>
                                        </span><span class="right" style="visibility: hidden;"><span class="astrics"><strong>
                                        </strong></span></span>
                                    </p>
                                </div>
                                <div class="regis_popup" style="text-align: center;">
                                    <br />
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                        ValidationGroup="MRR" ControlToValidate="txtCancelRemarks"></asp:RequiredFieldValidator>
                                    <%--Reason :<span class="astrics">*</span>--%>
                                    <asp:TextBox ID="txtCancelRemarks" TextMode="MultiLine" CssClass="textarea_pop" runat="server"
                                        Text="" Font-Size="11px" /><br />
                                    <br />
                                    <asp:Button ID="btnOkReason" runat="server" Text="OK" ValidationGroup="MRR" CssClass="button_all"
                                        OnClick="btnOkReason_Click" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <!--===============================Popup Close================================-->
                    <asp:Label ID="LabelReasonControl" runat="server"></asp:Label>
                    <cc1:ModalPopupExtender ID="ModalPopupExtenderReason" runat="server" BackgroundCssClass="NewmodalBackground"
                        CancelControlID="ButtonReasonClose" PopupControlID="PanelOnlyConfirm" TargetControlID="LabelReasonControl">
                    </cc1:ModalPopupExtender>
                    <!--===============================PopUp Alert Starts===============================-->
                    <asp:Panel ID="PanelScrapDetails" runat="server" Width="20%" Style="display: none;">
                        <div class="popupContent" style="width: 100%;">
                            <div class="pop_log_bg">
                                <div>
                                    <asp:Button ID="ButtonScrapDetails" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                                <!--<fieldset class="service_field" >-->
                                <div class="service_head_p">
                                    <p>
                                        <span class="left">
                                            <asp:Label ID="LabelScrapDetailsHead" runat="server" Text="Details Information" Font-Size="12px"></asp:Label>
                                        </span>
                                    </p>
                                </div>
                                <div class="regis_popup" style="text-align: center;">
                                    <div style="height: 250px; overflow: auto;">
                                        <asp:GridView ID="GrdVwCourierScrapOpen" runat="server" AutoGenerateColumns="false"
                                            CssClass="grid" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                                            EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                                            BorderColor="transparent">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Sr.No.">
                                                    <ItemTemplate>
                                                        <%=++scrapindex %>
                                                    </ItemTemplate>
                                                    <ItemStyle Width="10%" HorizontalAlign="Center" />
                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Series">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblVwCourierScrap" runat="server" Text='<%# Bind("SeriesNm") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" />
                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <EmptyDataRowStyle HorizontalAlign="Center" />
                                            <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                            <RowStyle CssClass="tr_line1" />
                                            <AlternatingRowStyle CssClass="tr_line2" />
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <!--===============================Popup Close================================-->
                    <asp:Label ID="LabelScrapDetails" runat="server"></asp:Label>
                    <cc1:ModalPopupExtender ID="ModalPopupScrapDetails" runat="server" BackgroundCssClass="NewmodalBackground"
                        CancelControlID="ButtonScrapDetails" PopupControlID="PanelScrapDetails" TargetControlID="LabelScrapDetails">
                    </cc1:ModalPopupExtender>
                    <asp:Panel ID="PanelVerifyPayment" runat="server" Width="45%" Style="display: none;">
                        <div class="popupContent" style="width: 100%;">
                            <div class="pop_log_bg">
                                <div>
                                    <asp:Button ID="btnVerifyPaymentPopclose" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                                <!--<fieldset class="service_field" >-->
                                <div class="service_head_p">
                                    <p>
                                        <span class="left">
                                            <asp:Label ID="LabelVerifyPaymentHead" runat="server" Text="Details Information"
                                                Font-Size="12px"></asp:Label>
                                        </span>
                                    </p>
                                </div>
                                <div class="regis_popup" style="text-align: center;">
                                    <div id="Div2" runat="server" style="text-align: left;">
                                        <p>
                                            <asp:Label ID="LabelMsg" runat="server"></asp:Label>
                                        </p>
                                    </div>
                                    <div id="MyAmcOfferGrdVw" runat="server">
                                        <asp:HiddenField ID="hdnRequestNo" runat="server" />
                                        <asp:HiddenField ID="hdnManuRequestAmount" runat="server" />
                                        <asp:GridView ID="GrdVwAmcOffer" runat="server" AutoGenerateColumns="False" CssClass="grid"
                                            EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center" EnableModelValidation="True"
                                            Width="100%" BorderStyle="None" BorderWidth="0" BorderColor="transparent">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Product Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblsername" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                                                        <asp:Label ID="LblAmcreqAmt" runat="server" Text='<%# Bind("Req_Amount") %>' Visible="false"></asp:Label>
                                                        <asp:Label ID="LblRowIDUnique" runat="server" Text='<%# Bind("Row_ID") %>' Visible="false"></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                    <ItemStyle HorizontalAlign="Justify" Width="25%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Requested Amount">
                                                    <ItemTemplate>
                                                        <asp:Label ID="LblAmcdisprices" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                            runat="server" Text='<%# Bind("Req_Amount") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" Width="15%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Remark">
                                                    <ItemTemplate>
                                                        <asp:Label ID="proplandueAmt" runat="server" Text='<%# Bind("Manu_Remark") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                    <ItemStyle HorizontalAlign="Center" Width="25%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Pay Amount">
                                                    <ItemTemplate>
                                                        <asp:TextBox ID="txtprices" runat="server" MaxLength="10" Style="text-align: left;
                                                            font-weight: normal !important; font-size: 12px; padding-left: 15px;" Width="70px"
                                                            OnKeyPress="return isNumberKey(this, event);" onchange="mathRoundForTaxesv(this.id);"
                                                            CssClass="t_box_rupees rupees" />
                                                    </ItemTemplate>
                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>
                                                <%--<asp:TemplateField HeaderText="Service">
                                                    <ItemTemplate>
                                                        <asp:DropDownList ID="ddlpay" runat="server">
                                                            <asp:ListItem Value="Block">Block</asp:ListItem>
                                                            <asp:ListItem Value="Continue">Continue</asp:ListItem>
                                                        </asp:DropDownList>
                                                    </ItemTemplate>
                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>--%>
                                            </Columns>
                                            <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                            <RowStyle CssClass="tr_line1" />
                                            <AlternatingRowStyle CssClass="tr_line2" />
                                        </asp:GridView>
                                    </div>
                                    <div style="text-align: right; padding-top: 10px; padding-right: 15px;">
                                        <asp:Button ID="btnVerifyPayment" OnClick="btnVerifyPayment_Click" CausesValidation="false"
                                            CssClass="button_all" runat="server" Text="Save" /></div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Label ID="LblVerifyPayment" runat="server"></asp:Label>
                    <cc1:ModalPopupExtender ID="ModalPopupVerifyPayment" runat="server" BackgroundCssClass="NewmodalBackground"
                        CancelControlID="btnVerifyPaymentPopclose" PopupControlID="PanelVerifyPayment"
                        TargetControlID="LblVerifyPayment">
                    </cc1:ModalPopupExtender>
                    <asp:Panel ID="Panel1" runat="server" Width="20%" Style="display: none;">
                        <div class="popupContent" style="width: 100%;">
                            <div class="pop_log_bg">
                                <div>
                                    <asp:Button ID="ButtonPaymentpopclose" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                                <div class="service_head_p">
                                    <p>
                                        <span class="left">
                                            <asp:Label ID="Label7" runat="server" Text="Reason Information" Font-Size="12px"></asp:Label>
                                        </span>
                                    </p>
                                </div>
                                <div class="regis_popup" style="text-align: center;">
                                    <div style="height: 145px; overflow: auto;">
                                        <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                            <tr>
                                                <td align="center">
                                                    <asp:Label ID="lblreaseonMessage" runat="server"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center">
                                                    <asp:TextBox ID="LabelReasonText" runat="server" Width="90%" Height="30px" TextMode="MultiLine"
                                                        onkeyDown="return checkTextAreaMaxLength(this,event,'150');" placeholder="Remark..."></asp:TextBox>
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ErrorMessage="*"
                                                        ControlToValidate="LabelReasonText" ValidationGroup="REM"></asp:RequiredFieldValidator>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="padding-right: 15px; text-align: right;">
                                                    <asp:Button ID="BtnCancelRemark1" OnClick="BtnCancelRemark1_Click" ValidationGroup="REM"
                                                        CssClass="button_all" runat="server" Text="Reject" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </asp:Panel>
                    <asp:Label ID="Label13" runat="server"></asp:Label>
                    <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="NewmodalBackground"
                        CancelControlID="ButtonPaymentpopclose" PopupControlID="Panel1" TargetControlID="Label13">
                    </cc1:ModalPopupExtender>
                    <!-- ******************* Popup Tax Setting Master Start *********************-->
                    <asp:Panel ID="PnlTaxMasterSetting" runat="server" Width="32%" Style="display: none;">
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
                                <asp:Panel ID="PnlTaxMasterSetting_" runat="server">
                                    <div class="regis_popup">
                                        <div id="Div3" runat="server">
                                            <p>
                                                <asp:Label ID="ProductsLabelPrices" runat="server" Style="font-family: Arial; font-size: 12px;"></asp:Label></p>
                                        </div>
                                        <fieldset id="ftg" runat="server" class="Newfield Newfield_width2">
                                            <legend>(<asp:Label ID="lblpronametax" runat="server" ForeColor="Blue"></asp:Label>)Tax
                                                Setting Info</legend>
                                            <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                                <tr id="MytrNew" runat="server">
                                                    <td colspan="3" align="center">
                                                        <asp:Label ID="lblallotmsg" runat="server" Style="font-family: Arial; font-size: 12px;"
                                                            ForeColor="Red"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" style="width: 36%;">
                                                        <strong><span class="star_red">*</span>Company Name :&nbsp;</strong>
                                                    </td>
                                                    <td colspan="2">
                                                        <asp:Label ID="ddlcompidfortax" CssClass="textbox_pop" runat="server" />
                                                        <asp:HiddenField ID="hdntaxcompid" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" style="width: 36%;">
                                                        <strong>Category Name :&nbsp;</strong>
                                                    </td>
                                                    <td colspan="2">
                                                        <asp:Label ID="lblcompcat" CssClass="textbox_pop" Enabled="false" runat="server" />
                                                    </td>
                                                    <td>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" style="width: 36%; vertical-align: top;">
                                                        <strong>Address :&nbsp;</strong>
                                                    </td>
                                                    <td colspan="2">
                                                        <asp:Label ID="lblAddress" CssClass="textbox_pop" Enabled="false" runat="server" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" style="width: 36%;">
                                                    </td>
                                                    <td>
                                                        <strong>Service Tax :&nbsp;</strong>
                                                    </td>
                                                    <td>
                                                        <strong>VAT :&nbsp;</strong>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" style="width: 36%;">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ForeColor="Red"
                                                            ValidationGroup="TM" ControlToValidate="txtLabelServiceTax"></asp:RequiredFieldValidator>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red"
                                                            ValidationGroup="TM" ControlToValidate="txtLabelVAT"></asp:RequiredFieldValidator>
                                                        <strong><span class="star_red">*</span>Label :&nbsp;</strong>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtLabelServiceTax" CssClass="textbox_pop" OnKeyPress="return isNumberKey(this, event);"
                                                            MaxLength="5" onchange="mathRoundForTaxes(this.id);" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtLabelVAT" CssClass="textbox_pop" OnKeyPress="return isNumberKey(this, event);"
                                                            onchange="mathRoundForTaxes(this.id);" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" style="width: 36%;">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                                            ValidationGroup="TM" ControlToValidate="txtAmcServiceTax"></asp:RequiredFieldValidator>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red"
                                                            ValidationGroup="TM" ControlToValidate="txtAMCServiceTax"></asp:RequiredFieldValidator>
                                                        <strong><span class="star_red">*</span>AMC :&nbsp;</strong>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtAmcServiceTax" CssClass="textbox_pop" OnKeyPress="return isNumberKey(this, event);"
                                                            onchange="mathRoundForTaxes(this.id);" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtAMCVATx" CssClass="textbox_pop" OnKeyPress="return isNumberKey(this, event);"
                                                            onchange="mathRoundForTaxes(this.id);" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td align="right" style="width: 36%;">
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ForeColor="Red"
                                                            ValidationGroup="TM" ControlToValidate="txtOfferServiceTax"></asp:RequiredFieldValidator>
                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ForeColor="Red"
                                                            ValidationGroup="TM" ControlToValidate="txtOfferServiceTax"></asp:RequiredFieldValidator>
                                                        <strong><span class="star_red">*</span>Offer :&nbsp;</strong>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtOfferServiceTax" CssClass="textbox_pop" OnKeyPress="return isNumberKey(this, event);"
                                                            onchange="mathRoundForTaxes(this.id);" runat="server"></asp:TextBox>
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtOfferVAT" CssClass="textbox_pop" OnKeyPress="return isNumberKey(this, event);"
                                                            onchange="mathRoundForTaxes(this.id);" runat="server"></asp:TextBox>
                                                    </td>
                                                </tr>
                                            </table>
                                        </fieldset>
                                        <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                            <tr>
                                                <td align="right" colspan="2" style="padding-right: 5px;">
                                                    <asp:Label ID="lblrowid" runat="server" Visible="false"></asp:Label>
                                                    <asp:Label ID="lblentrydate" runat="server" Visible="false"></asp:Label>
                                                    <asp:Button ID="btnTaxSetting" OnClick="btnTaxSetting_Click" ValidationGroup="TM"
                                                        CssClass="button_all" UseSubmitBehavior="false" runat="server" Text="Save" />
                                                    <asp:Button ID="btnResetTax" OnClick="btnResetTax_Click" CssClass="button_all" runat="server"
                                                        Text="Reset" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </asp:Panel>
                    <cc1:ModalPopupExtender ID="ModalTaxMaster" runat="server" PopupControlID="PnlTaxMasterSetting"
                        BackgroundCssClass="NewmodalBackground" TargetControlID="LabelTaxSetting" CancelControlID="btnClosePop">
                    </cc1:ModalPopupExtender>
                    <asp:Label ID="LabelTaxSetting" runat="server"></asp:Label>
                    <!-- ******************* Popup Tax Setting Master End *********************-->
                    <!-- ******************* Popup Tax Setting Master Start *********************-->
                    <asp:Panel ID="PanelAmcSelect" runat="server" Width="32%" Style="display: none;">
                        <div class="popupContent" style="width: 100%;">
                            <div class="pop_log_bg">
                                <div>
                                    <asp:Button ID="btnAmcSelect" CssClass="popupClose" runat="server" /></div>
                                <div class="service_head_p">
                                    <p>
                                        <span class="left"><strong>
                                            <asp:Label ID="LblAmcSelectHead" runat="server"></asp:Label></strong> </span>
                                        <%--<span class="right">
                                                <span class="astrics"><strong>*</strong></span> <em>indicates mandatory fields</em></span>--%></p>
                                </div>
                                <asp:Panel ID="Panel3" runat="server">
                                    <div class="regis_popup">
                                        <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                            <tr>
                                                <td align="center">
                                                    <asp:Label ID="Lblmsgp" runat="server" Style="font-family: Arial; font-size: 12px;"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center" colspan="2" style="padding-right: 5px;">
                                                    <asp:Button ID="btnyesAmcSelect" CssClass="button_all" runat="server" Text="OK" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </asp:Panel>
                            </div>
                        </div>
                    </asp:Panel>
                    <cc1:ModalPopupExtender ID="AmcSelectModalPopup" runat="server" PopupControlID="PanelAmcSelect"
                        OkControlID="btnyesAmcSelect" BackgroundCssClass="NewmodalBackground" TargetControlID="TargetPanelAmcSelect"
                        CancelControlID="btnAmcSelect">
                    </cc1:ModalPopupExtender>
                    <asp:Label ID="TargetPanelAmcSelect" runat="server"></asp:Label>
                    <!-- ******************* Popup Tax Setting Master End *********************-->
                </div>

                <script type="text/javascript">
                    //ddtreemenu.createTree(treeid, enablepersist, opt_persist_in_days (default is 1))
                    ddtreemenu.createTree("treemenu1", true)
                    ddtreemenu.createTree("treemenu2", false)
                </script>

            </div>
            <!--container close-->
            <!--footer starts-->
            <div id="footer_p">
                <div id="footer">
                    <div class="f_menu left_drag">
                        <p>
                            © Copyright 2012, VCQRU.com. All right reserved.</p>
                    </div>
                </div>
            </div>
            <!--footer close-->
        </ContentTemplate>
    </asp:UpdatePanel>
    </form>
    <%-- <script type="text/javascript">
        function refreshMe() {

            window.location.reload();
        }
        function testt() {
            setTimeout("refreshMe()", 60000);

        }
        testt();
    </script>--%>
</body>
</html>
