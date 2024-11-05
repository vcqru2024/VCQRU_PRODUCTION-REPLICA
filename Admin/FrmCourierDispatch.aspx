<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true"
    Title="Courier Dispatch" CodeFile="FrmCourierDispatch.aspx.cs" Inherits="FrmCourierDispatch" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(37).addClass("active");
            $(".accordion2 div.open").eq(34).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });
        });
        function showpdf() {
            <%-- debugger;
            alert('<%=Prop_PrintRecp%>');--%>
           // alert('<%=Prop_PrintRecp%>');
           // window.open('<%=Prop_PrintRecp%>', '_blank');
        }
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
        .pad
        {
            text-align: left;
            padding: 0px 4px 0 4px;
        }
    </style>

    <script language="javascript" type="text/javascript">
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
        function CalculateQty(val, id) {

            var val1 = document.getElementById("<%=txtSeriesFrom.ClientID %>").value;
          //  alert(val1);
            if (parseFloat(val) >= parseFloat(val1)) {
                if (val1 != '') {
                    if (parseFloat(val1) == 0)
                        document.getElementById("<%=LblCountQty.ClientID %>").value = parseFloat(parseFloat(val) + 1);
                    else
                        document.getElementById("<%=LblCountQty.ClientID %>").value = parseFloat(parseFloat(parseFloat(val) - parseFloat(val1)) + 1);
                    if (val.length == 1)
                        document.getElementById(id).value = "000" + val;
                    else if (val.length == 2)
                        document.getElementById(id).value = "00" + val;
                    else if (val.length == 3)
                        document.getElementById(id).value = "0" + val;
                    else
                        document.getElementById(id).value = val;
                }
                else {
                    document.getElementById("<%=txtSeriesFrom.ClientID %>").value = "";
                    document.getElementById("<%=txtSeriesFrom.ClientID %>").focus();
                }
            }
            else {
                document.getElementById("<%=txtSeriesFrom.ClientID %>").value = "";
                document.getElementById("<%=txtSeriesTo.ClientID %>").value = "";
                document.getElementById("<%=txtSeriesFrom.ClientID %>").focus();
            }
        }
        function ChkInitial(val, id) {//lblProDetailsMsg
            var val1 = document.getElementById("<%=ddlProduct.ClientID %>").value;
            var Arr = val.toString().split('-');
            if (Arr[0] == val1) {
                document.getElementById("<%=lblProDetailsMsg.ClientID %>").innerHTML = "";
                document.getElementById(txtSeriesFrom).focus();
            }
            else {
                document.getElementById(id).value = "";
                document.getElementById("<%=lblProDetailsMsg.ClientID %>").innerHTML = "Please enter valid series Initial !";
                document.getElementById(id).focus();
            }
        }
        function FormatVal(val, id) {
            if (val.length == 1)
                document.getElementById(id).value = "000" + val;
            else if (val.length == 2)
                document.getElementById(id).value = "00" + val;
            else if (val.length == 3)
                document.getElementById(id).value = "0" + val;
            else
                document.getElementById(id).value = val;
            document.getElementById("<%=txtSeriesTo.ClientID %>").value = "";
            document.getElementById("<%=txtSeriesTo.ClientID %>").focus();
        }

        function ChkDate(dt) {
            if ((parseInt(dt.substring(3, 5)) > 12) || (dt.substring(0, 2) > 31)) {
                document.getElementById("<%=Label1.ClientID %>").innerHTML = "Invalid date";
                document.getElementById("<%=txtDispatchDate.ClientID %>").value = "";
                document.getElementById("<%=Div1.ClientID %>").className = "alert_boxes_pink big_msg";
                document.getElementById("<%=btnCourierSubmit.ClientID %>").disabled = true;
                document.getElementById("<%=btnCourierSubmit.ClientID %>").className = "button_all_Sec";
                return;
            }
            var selectedDate = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)) - 1, dt.substring(0, 2));
            var today = new Date();
            today.setHours(0, 0, 0, 0);
            if (selectedDate < today) {
                document.getElementById("<%=Label1.ClientID %>").innerHTML = "Select today or a date bigger than that!";
                document.getElementById("<%=txtDispatchDate.ClientID %>").value = "";
                document.getElementById("<%=Div1.ClientID %>").className = "alert_boxes_pink big_msg";
                document.getElementById("<%=btnCourierSubmit.ClientID %>").disabled = true;
                document.getElementById("<%=btnCourierSubmit.ClientID %>").className = "button_all_Sec";
            }
            else {
                document.getElementById("<%=Label1.ClientID %>").innerHTML = "";
                document.getElementById("<%=Div1.ClientID %>").className = "";
                document.getElementById("<%=btnCourierSubmit.ClientID %>").disabled = false;
                document.getElementById("<%=btnCourierSubmit.ClientID %>").className = "button_all";
            }
        }       
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 1507px; width: 100%;
                        z-index: 100001; top: 0px;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="head_cont">
                <h2 class="add_dispatch">
                    <table width="99%">
                        <tr>
                            <td width="20%">
                               <%--<asp:LinkButton  Text="Print Receipt" ID="btnYesActivation1" runat="server"  class="button_all" style="text-decoration: none;" OnClientClick="showpdf();" />--%> <%--OnClick="btnYesActivation1_Click"--%>
                                &nbsp;Courier Dispatch
                            </td>
                            <td width="65%">
                                <asp:Label ID="lblmsg" runat="server" CssClass="small_font"></asp:Label>
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" ToolTip="Add New Courier Dispatch" OnClick="imgNew_Click"
                                    ImageUrl="~/Content/images/add_new.png" runat="server" CausesValidation="false" />
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <div id="newMsg" runat="server">
                <p>  
                    <asp:Label ID="lblmsgHeader" runat="server"></asp:Label>
                </p>
            </div>
            <asp:Panel ID="PnlDefault" runat="server" DefaultButton="BtnSearch">
                <fieldset class="field_profile">
                    <legend>
                        <asp:Label ID="Label3" runat="server" Text="Search"></asp:Label></legend>
                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                        <tr>
                            <td align="justify" style="width: 9%;">
                                <asp:TextBox ID="txtSerCompName" runat="server" CssClass="reg_txt" placeholder="Company Name"></asp:TextBox>
                            </td>
                            <td align="justify" style="width: 9%;">
                                <asp:TextBox ID="txtSearchName" runat="server" CssClass="reg_txt" placeholder="Courier Name"></asp:TextBox>
                            </td>
                            <td align="left" width="12%">
                                <div class="merg_btn">
                                    <asp:ImageButton ID="BtnSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                        OnClick="BtnSearch_Click" ToolTip="Search" />
                                    <asp:ImageButton ID="BtnRefesh" runat="server" ImageUrl="~/Content/images/reset.png"
                                        OnClick="BtnRefesh_Click" ToolTip="Refresh" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </asp:Panel>
            <asp:Panel ID="DemoPanel" runat="server">
                <div class="grid_container">
                    <h4>
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="6%" align="center">
                                    <img src="../Content/images/regis_pro.png" alt="products" />
                                </td>
                                <td class="bord_right">
                                    <asp:Label ID="lblGridHeaderText" runat="server" Text="Record(s) found"></asp:Label>
                                    <span class="small_font">(<asp:Label ID="lblcount" runat="server"></asp:Label>)</span>
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
                                <td width="13%" align="right">
                                    <div class="mainselection">
                                        <asp:DropDownList ID="ddlRows" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRows_SelectedIndexChanged">
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
                        </table>
                    </h4>
                    <asp:GridView ID="GrdCourierDispatch" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="VirLabel" CssClass="grid" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                        EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                        BorderColor="transparent" AllowPaging="True" PageSize="15" OnPageIndexChanging="GrdCourierDispatch_PageIndexChanging"
                        OnRowCommand="GrdCourierDispatch_RowCommand">
                        <Columns>
                            <asp:TemplateField ItemStyle-Width="20px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                HeaderStyle-CssClass="tr_haed" ItemStyle-CssClass="pad">
                                <ItemTemplate>
                                    <a href="JavaScript:divexpandcollapse('div<%# Eval("Courier_Disp_ID") %>');">
                                        <img id="imgdiv<%# Eval("Courier_Disp_ID") %>" width="9px" border="0" src="../Content/images/plus.gif"
                                            alt="" title="View Products" />
                                </ItemTemplate>
                                <ItemStyle Width="1%" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Company">
                                <ItemTemplate>
                                    <asp:Label ID="lblCourierName" runat="server" Text='<%# Bind("Comp_Name") %>'></asp:Label>
                                    <asp:Label ID="lblCDispID" runat="server" Visible="false" Text='<%# Bind("Courier_Disp_ID") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="170px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Courier Company">
                                <ItemTemplate>
                                    <asp:Label ID="lblCourierEmail" runat="server" Text='<%# Convert.ToInt32(Eval("VirLabel")) == 0 ? Eval("Courier_Name") : "-- --" %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="120px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tracking No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblContact" runat="server" Text='<%# Convert.ToInt32(Eval("VirLabel")) == 0 ? Eval("Tracking_No") : "-- --"  %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="100px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Dispatch Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblAddressCode" runat="server" Text='<%# Bind("Dispatch_Date","{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="80px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Dispatch Location">
                                <ItemTemplate>
                                    <asp:Label ID="lblAddressLocation" runat="server" Text='<%# Bind("Dispatch_Location") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="150px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Quantity">
                                <ItemTemplate>
                                    <asp:Label ID="lblAddressQty" runat="server" Text='<%# Bind("Qty") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="50px" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:ImageButton ID="ImgbtnEditCourier" runat="server" ImageUrl="~/Content/images/edit.png"
                                        CommandName="CourierEdit" CommandArgument='<%# Bind("Courier_Disp_ID") %>' ToolTip="Edit Courier Dispatch info"
                                        CausesValidation="false" Visible="false" />
                                    <asp:ImageButton ID="ImgbtnDeleteCourier" runat="server" ImageUrl="~/Content/images/delete.png"
                                        CommandName="CourierDelete" CommandArgument='<%# Bind("Courier_Disp_ID") %>'
                                        ToolTip="Delete Courier Dispatch info" CausesValidation="false" />&nbsp;
                                    <%
                                        try
                                        {
                                            VarL = Convert.ToInt32(GrdCourierDispatch.DataKeys[index].Values["VirLabel"].ToString());
                                        }
                                        catch
                                        {
                                        } if (VarL == 1)
                                        {
                                    %>
                                    <asp:ImageButton ID="ImgbtnDownloadExcel" runat="server" ImageUrl="~/Content/images/download.png"
                                        CommandName="DownloadExcel" CommandArgument='<%# Bind("Courier_Disp_ID") %>'
                                        ToolTip="Download Excel" CausesValidation="false" />
                                    <%} %>
                                    <%index++;%>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="5%" />
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
            </asp:Panel>
            <asp:Panel ID="PanelNewCourier" runat="server" Width="40%" Style="display: none;">
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
                        <asp:Panel ID="Panel1" runat="server">
                            <div class="regis_popup">
                                <div id="Div1" runat="server" style="width: 86% !important;">
                                    <p>
                                        <asp:Label ID="Label1" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <div id="DivNewMsg" runat="server" style="width: 86% !important;">
                                    <p>
                                        <asp:Label ID="lblpopmsg" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <fieldset id="Fieldset2" runat="server" class="Newfield Newfield_width2">
                                    <legend>Courier Dispatch Info</legend>
                                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                        <tr>
                                            <td align="right" width="35%">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="DDLCompany" InitialValue="--Select--">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Company :</strong>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="DDLCompany" runat="server" CssClass="drp" AutoPostBack="true"
                                                    OnSelectedIndexChanged="DDLCompany_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ForeColor="Red"
                                                    ErrorMessage="*" ValidationGroup="PR1" ControlToValidate="ddlProduct" InitialValue="--Select--">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Product</strong>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlProduct" runat="server" CssClass="drp" OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged"
                                                    AutoPostBack="true">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="DDLCourierCompany" InitialValue="--Select--">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Courier Company :</strong>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="DDLCourierCompany" runat="server" CssClass="drp">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="txtTrackingNo">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Tracking No. :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtTrackingNo" onchange="javascript:upperMe()" runat="server" CssClass="textbox_pop" style="width:67% !important;"
                                                    Text="" MaxLength="50"></asp:TextBox>&nbsp;<asp:CheckBox ID="chkchange" runat="server" Text="&nbsp;Is Change" AutoPostBack="true" OnCheckedChanged="chkchange_CheckedChanged" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="txtDispatchDate">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Dispatch Date :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDispatchDate" runat="server" CssClass="textbox_pop" onchange="ChkDate(this.value)"
                                                    onkeydown="return checkShortcut();"></asp:TextBox><%-- ReadOnly="true" --%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="PRO"
                                                    ForeColor="Red" ControlToCompare="txtDispatchDate" ControlToValidate="txtExpectedDate"
                                                    Operator="GreaterThanEqual" Type="Date" Text="Invalid date!"></asp:CompareValidator>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="txtExpectedDate">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Expected Date :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtExpectedDate" runat="server" CssClass="textbox_pop" onkeydown="return checkShortcut();"></asp:TextBox>
                                                <asp:Label id="lblTestSession" runat="server" ></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="2">
                                                <fieldset id="Fieldset1" runat="server" class="Newfield Newfield_width2">
                                                    <legend>Courier Dispatch Printed Label Info  </legend>
                                                    <table width="100%">
                                                        <tr style="background-color: #E6E6E6;display:none;" >
                                                            <td style="width: 20%; text-align: left;">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ForeColor="Red"
                                                                    ErrorMessage="*" ValidationGroup="NewAdd" ControlToValidate="ddlLabel" InitialValue="--Select--">
                                                                </asp:RequiredFieldValidator>
                                                                <strong><span class="astrics">*</span>Label Name</strong>
                                                            </td>
                                                            <td align="left" style="width: 15%;">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ForeColor="Red"
                                                                    ValidationGroup="NewAdd" ControlToValidate="txtSeries_Initial" ErrorMessage="*">
                                                                </asp:RequiredFieldValidator>
                                                                <cc1:ValidatorCalloutExtender runat="Server" ID="ValidatorCalloutExtender1" TargetControlID="RegularExpressionValidator2" />
                                                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationGroup="NewAdd"
                                                                    ControlToValidate="txtSeries_Initial" ErrorMessage="ex: AA06-0001" Display="None"
                                                                    ViewStateMode="Enabled" ValidationExpression="[A-Z][A-Z][0-9][0-9]-[0-9][0-9][0-9][0-9]"></asp:RegularExpressionValidator>
                                                                <strong><span class="astrics">*</span>Series Initial</strong>
                                                            </td>
                                                            <td style="width: 5%; text-align: left;">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ForeColor="Red"
                                                                    ValidationGroup="NewAdd" ControlToValidate="txtSeriesFrom" ErrorMessage="*">
                                                                </asp:RequiredFieldValidator>
                                                                <strong><span class="astrics">*</span>From</strong>
                                                            </td>
                                                            <td style="width: 5%; text-align: left;">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ForeColor="Red"
                                                                    ValidationGroup="NewAdd" ControlToValidate="txtSeriesTo" ErrorMessage="*">
                                                                </asp:RequiredFieldValidator>
                                                                <strong><span class="astrics">*</span>To</strong>
                                                            </td>
                                                            <td style="width: 3%; text-align: center;">
                                                                <strong>Qty</strong>
                                                            </td>
                                                            <td style="width: 8%;">
                                                                <asp:HiddenField ID="hdnFieldUpdate" Value="Save" runat="server" />
                                                                &nbsp;
                                                            </td>
                                                        </tr>
                                                        <tr style="display:none">
                                                            <td>
                                                                <asp:DropDownList ID="ddlLabel" runat="server" CssClass="textbox_pop" AutoPostBack="true"
                                                                    OnSelectedIndexChanged="ddlLabel_SelectedIndexChanged" Width="100%">
                                                                </asp:DropDownList>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtSeries_Initial" Width="75px" runat="server" CssClass="textbox_pop"
                                                                    onchange="ChkInitial(this.value,this.id);" MaxLength="9" Text=""></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtSeriesFrom" Width="35px" runat="server" CssClass="textbox_pop"
                                                                    onchange="FormatVal(this.value,this.id);" MaxLength="4" OnKeyPress="return isNumberKey(this, event);"
                                                                    Text=""></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtSeriesTo" Width="25px" runat="server" CssClass="textbox_pop"
                                                                    MaxLength="4" onchange="CalculateQty(this.value,this.id)" OnKeyPress="return isNumberKey(this, event);"
                                                                    Text=""></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="LblCountQty" CssClass="textbox_pop" runat="server" Width="50px"
                                                                    Text="" Enabled="false" Style="text-align: center;"></asp:TextBox>
                                                            </td>
                                                            <td>
                                                                <asp:ImageButton ID="btnAddPro" ImageUrl="~/Content/images/add_new.png" runat="server"
                                                                    ValidationGroup="NewAdd" OnClick="btnAddPro_Click" />&nbsp;<asp:ImageButton ID="btnResetPro"
                                                                        ImageUrl="~/Content/images/reset.png" runat="server" CausesValidation="false"
                                                                        OnClick="btnResetPro_Click" />
                                                            </td>
                                                        </tr>
                                                        
                                                        <tr>
                                                            <td colspan="7" align="center">
                                                                <asp:Label ID="lblProDetailsMsg" runat="server" Text="" ForeColor="Red"></asp:Label><asp:Label
                                                                    ID="lblUpFlTblId" runat="server" Text="" Visible="false"></asp:Label><asp:Label ID="lblC"
                                                                        runat="server" Text="" Visible="false"></asp:Label>
                                                                <div align="center" style="overflow: auto; height: 150px;">
                                                                    <asp:GridView ID="GrdProductPrintLablelDet" runat="server" AutoGenerateColumns="False"
                                                                        CssClass="grid" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                                                                        EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                                                                        BorderColor="transparent" OnRowCommand="GrdProductPrintLablelDet_RowCommand">
                                                                        <Columns>
                                                                            <asp:TemplateField HeaderText="Product Name">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblLablProNm" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Label Name">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblLabelNm" runat="server" Text='<%# Bind("Label_Name") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Series From">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblseriesfrom" runat="server" Text='<%# Bind("Series_From") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Series To">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblseriesto" runat="server" Text='<%# Bind("Series_To") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="23%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Qty.">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblCountQty" runat="server" Text='<%# Bind("Qty") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Action">
                                                                                <ItemTemplate>
                                                                                    <asp:ImageButton ID="Imgeditprodetails" runat="server" CommandName="EditProDetails"
                                                                                        ImageUrl="~/Content/images/edit.png" CommandArgument='<%#Container.DataItemIndex %>' Visible="false" />
                                                                                    &nbsp;<asp:ImageButton ID="ImageButtondelete" runat="server" CommandName="DeleteProDetails"
                                                                                        ImageUrl="~/Content/images/delete.png" CommandArgument='<%#Container.DataItemIndex %>'
                                                                                        OnClientClick="return confirm('Are you sure to delete ?')" />
                                                                                </ItemTemplate>
                                                                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                        <EmptyDataRowStyle HorizontalAlign="Center" />
                                                                        <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                                        <RowStyle CssClass="tr_line1" />
                                                                        <AlternatingRowStyle CssClass="tr_line2" />
                                                                    </asp:GridView>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </fieldset>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="txtDispLocation">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Dispatch Location :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDispLocation" ReadOnly="true" runat="server" TextMode="MultiLine"
                                                    Style="width: 88%;" Height="35px" Text="" BackColor="#E6E6E6" />
                                            </td>
                                        </tr>
                                    </table>
                                    <cc1:CalendarExtender ID="CalendarExtender1" TargetControlID="txtDispatchDate" runat="server"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <%-- <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtDispatchDate"
                                        MaskType="Date" Mask="99/99/9999">
                                    </cc1:MaskedEditExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtExpectedDate"
                                        MaskType="Date" Mask="99/99/9999">
                                    </cc1:MaskedEditExtender>--%>
                                    <cc1:CalendarExtender ID="CalendarExtender2" TargetControlID="txtExpectedDate" runat="server"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                </fieldset>
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="left" style="padding-left: 8px;">
                                            <asp:Button ID="btnScrapEntry" PostBackUrl="FrmScrapEntryM.aspx" CssClass="button_all"
                                                runat="server" Text="Go To Scrap" />
                                        </td>
                                        <td align="right" style="padding-right: 8px;">
                                            &nbsp;&nbsp;<asp:Button ID="btnCourierSubmit" OnClick="btnCourierSubmit_Click" ValidationGroup="PR1"
                                                CssClass="button_all" runat="server" Text="Save" />&nbsp;&nbsp;<asp:Button ID="btnCourierReset"
                                                    OnClick="btnCourierReset_Click" CausesValidation="false" CssClass="button_all"
                                                    runat="server" Text="Reset" />
                                        </td>
                                    </tr>
                                </table>
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="right">
                                            <asp:Label ID="lblnote" Style="font-family: Arial; font-size: 12px; color: Red;"
                                                runat="server" Text="Note :- Please add product series detail first, then Click the save button "></asp:Label>
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
                            <%--<a id="btnYesActivation1" runat="server" class="button_all" style="text-decoration: none;" target="_blank" onclick="showpdf();" >Print Receipt12345</a>--%>
                            <asp:LinkButton  Text="Print Receipt" ID="btnYesActivation1" runat="server"  class="button_all" style="text-decoration: none;" OnClientClick="showpdf();" />
                            <asp:Button ID="btnYesActivation" Visible="false" runat="server" Text="Yes" CssClass="button_all"
                                OnClick="btnYesActivation_Click" />&nbsp;&nbsp;<asp:Button ID="btnNoActivation" runat="server"
                                    Text="No" CssClass="button_all" OnClick="btnNoActivation_Click" />
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
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="GrdCourierDispatch" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>

