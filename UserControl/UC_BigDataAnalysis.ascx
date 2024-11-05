<%@ Control Language="C#" AutoEventWireup="true" CodeFile="UC_BigDataAnalysis.ascx.cs" Inherits="UserControl_UC_BigDataAnalysis" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<style>
   
   
      .ajax__calendar_today{
         padding:0px 0px 0px 0px;
    }
      .ajax__calendar_dayname{
         padding:0px 0px 0px 0px;
    }
</style>
    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(19).addClass("active");
            $(".accordion2 div.open").eq(11).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });

         
    </script>
<script>
   
    function showImgBtn123() {
         document.getElementById("<%=btnExceldwn.ClientID%>").click();
    }
       
 
</script>
    <style type="text/css">
        #popupAlert
        {
            position: absolute;
            background: url(../Content/images/alert_bg_login.png) repeat;
            z-index: 10001;
            padding: 6px;
            width: auto;
            font-size: 13px;
            display: inline-block;
            left: 30%;
        }
        #popupAlert div.content_area_alert
        {
            font-family: Tahoma, Geneva, sans-serif;
            font-size: 11px;
            position: relative;
            border: solid 1px #ffffff;
            display: inline-block;
            min-width: 300px;
        }
        #popupAlert div.content_area_alert div.alert_f_header
        {
            background: #e74b4b;
            display: block;
            width: 100%;
        }
        #popupAlert div.content_area_alert div.alert_f_header div.alert_here
        {
            font-family: oswald;
            font-size: 20px;
            font-weight: 300;
            color: #ffffff;
            padding: 15px;
            padding-right: 50px;
        }
        .popclosebtn
        {
            font-size: 14px;
            line-height: 14px;
            right: 11px;
            top: 10px;
            position: absolute;
            color: #6fa5fd;
            font-weight: 700;
            display: block;
        }
    </style>

    <script type="text/javascript" language="javascript">
        function fileTypeCheck(mm) {
            PageMethods.checkFile(mm, onengcheck)
        }
        function onengcheck(Result) {
            var size = document.getElementById("<%=FileUpload1.ClientID%>").files[0].size;
            if (Result == true) {
                if (size > 1024000)
                    document.getElementById("<%=lblImg.ClientID %>").innerHTML = "FileSize should not exceed 1MB";
                else
                    document.getElementById("<%=lblImg.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnsave.ClientID %>").disabled = true;
                document.getElementById("<%=btnsave.ClientID %>").className = "button_all_Sec";

            }
            else {
                if (size > 1024000) {
                    document.getElementById("<%=lblImg.ClientID %>").innerHTML = "FileSize should not exceed 1MB";
                    document.getElementById("<%=btnsave.ClientID %>").disabled = true;
                    document.getElementById("<%=btnsave.ClientID %>").className = "button_all_Sec";
                }
                else {
                    document.getElementById("<%=lblImg.ClientID %>").innerHTML = "";
                    document.getElementById("<%=btnsave.ClientID %>").disabled = false;
                    document.getElementById("<%=btnsave.ClientID %>").className = "button_all";
                }
            }
            ChkRegProVal();
        }
        function onengcheck(Result) {
            var size = document.getElementById("<%=FileUpload2.ClientID%>").files[0].size;
            if (Result == true) {
                if (size > 1024000)
                    document.getElementById("<%=lblImg1.ClientID %>").innerHTML = "FileSize should not exceed 1MB";
                else
                    document.getElementById("<%=lblImg1.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnsave.ClientID %>").disabled = true;
                document.getElementById("<%=btnsave.ClientID %>").className = "button_all_Sec";

            }
            else {
                if (size > 1024000) {
                    document.getElementById("<%=lblImg1.ClientID %>").innerHTML = "FileSize should not exceed 1MB";
                    document.getElementById("<%=btnsave.ClientID %>").disabled = true;
                    document.getElementById("<%=btnsave.ClientID %>").className = "button_all_Sec";
                }
                else {
                    document.getElementById("<%=lblImg1.ClientID %>").innerHTML = "";
                    document.getElementById("<%=btnsave.ClientID %>").disabled = false;
                    document.getElementById("<%=btnsave.ClientID %>").className = "button_all";
                }
            }
            ChkRegProVal();
        }
        function ChkRegProVal() {
            if ((document.getElementById("<%=lblImg.ClientID %>").innerHTML == "") && (document.getElementById("<%=lblImg1.ClientID %>").innerHTML == "")) {
                document.getElementById("<%=btnsave.ClientID %>").disabled = false;
                document.getElementById("<%=btnsave.ClientID %>").className = "button_all";
            }
            else {
                document.getElementById("<%=btnsave.ClientID %>").disabled = true;
                document.getElementById("<%=btnsave.ClientID %>").className = "button_all_Sec";
            }
        }
    </script>


<asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
                        top: 0px;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/icons/ajax-loader.gif" /><br />
                            <span style="color: White">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="head_cont">
                <h2 class="reg_pro">
                    <table width="99%">
                        <tr>
                            <td width="85%">
                                Client Data Request
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" ToolTip="Add New Data Request" OnClick="imgNew_Click"
                                    ImageUrl="~/Content/images/add_new.png" CausesValidation="false" runat="server" />
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <div style="width: 100%; text-align: center;">
            </div>
            <div style="width: 100%; text-align: center;">
                <asp:Label ID="Label1" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
            </div>
            
            <div id="NewMsgpop" runat="server">
                <p>
                    <asp:Label ID="Label2" runat="server"></asp:Label></p>
                
            </div>
            <fieldset class="field_profile">
                <legend>Search</legend>
                <asp:Panel ID="DefaultButton" runat="server" DefaultButton="ImgSearch">
                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                         
                        <tr>
                            <td align="right">
                                <asp:DropDownList ID="ddlCompany" runat="server" CssClass="reg_txt" AutoPostBack="false"
                                        OnSelectedIndexChanged="ddlCompany_SelectedIndexChanged" Visible="true" >
                                    </asp:DropDownList>
                            </td>
                            <td width="18%">
                                <asp:TextBox ID="txtDateFrom" runat="server" Text="" placeholder="Date From ..."
                                    CssClass="reg_txt"></asp:TextBox>
                            </td>
                            <td width="18%">
                                <asp:TextBox ID="txtDateTo" runat="server" Text="" placeholder="Date From ..." CssClass="reg_txt"></asp:TextBox>
                            </td>
                            <td>
                                <div class="merg_btn">
                                    <asp:ImageButton ID="ImgSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                         ToolTip="Search" OnClick="ImgSearch_Click" />
                                    <asp:ImageButton ID="ImgRefresh" runat="server" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                         ToolTip="Reset" />
                                </div>
                                <cc1:CalendarExtender ID="CalendarExtender1dtfrom" TargetControlID="txtDateFrom"
                                    runat="server" Format="dd/MM/yyyy">
                                </cc1:CalendarExtender>
                                <cc1:MaskedEditExtender ID="MaskedEditExtenderdtfrom1" runat="server" TargetControlID="txtDateFrom"
                                    MaskType="Date" Mask="99/99/9999">
                                </cc1:MaskedEditExtender>
                                <cc1:CalendarExtender ID="CalendarExtender2dtto" TargetControlID="txtDateTo" runat="server"
                                    Format="dd/MM/yyyy">
                                </cc1:CalendarExtender>
                                <cc1:MaskedEditExtender ID="MaskedEditExtendttoder2" runat="server" TargetControlID="txtDateTo"
                                    MaskType="Date" Mask="99/99/9999">
                                </cc1:MaskedEditExtender>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </fieldset>
            <div class="grid_container">
                <h4>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <img src="../Content/images/regis_pro.png" alt="products" />
                            </td>
                            <td class="bord_right">
                                Record(s) found <span class="small_font">(<asp:Label ID="lblcount" runat="server"></asp:Label>)</span>
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
                    </table>
                </h4>
               
                
                <asp:GridView ID="GrdVwTestimonial" runat="server" AutoGenerateColumns="False" CssClass="grid" DataKeyNames="DataStatus"
                    EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                    EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0" OnPageIndexChanging="GrdVwTestimonial_PageIndexChanging"
                    BorderColor="transparent" AllowPaging="True" PageSize="25" OnRowCommand="GrdVwTestimonial_RowCommand">
                    <Columns>
                        <asp:TemplateField HeaderText="S.No">
                            <ItemTemplate>
                                <%=++sno %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="4%" />
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Data Requested From Company">
                            <ItemTemplate>
                                <asp:Label ID="lblEntryDate123" runat="server" Text='<%#Bind("comp_Name") %>' />
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                         <asp:TemplateField HeaderText="Date">
                            <ItemTemplate>
                                <asp:Label ID="lblEntryDate" runat="server" Text='<%#Bind("CreatedDate","{0:dd-MMM-yyyy}") %>' />
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Quantity">
                            <ItemTemplate>
                                <asp:Label ID="lblTestimoniall" runat="server" Text='<%#Bind("DataQty") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" />
                            <ItemStyle HorizontalAlign="Left" CssClass="grd_pad" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Price (Rs)">
                            <ItemTemplate>
                                <asp:Label ID="lblTestimonialllp" runat="server" Text='<%#Bind("Price") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" />
                            <ItemStyle HorizontalAlign="Left" CssClass="grd_pad" Width="15%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Consumer Date">
                            <ItemTemplate>
                                <%--<div style="float: left">--%>
                                  <%if (GrdVwTestimonial.DataKeys[index]["DataStatus"].ToString() == "1")
                                      { %>
                                 <%--   <asp:HyperLink ID="HyperLink1" runat="server"  Target="_blank" NavigateUrl='<%#Bind("Test_Image1") %>' ToolTip="View Consumer List">Consumer LIst</asp:HyperLink>--%>
                                <asp:ImageButton ToolTip="Edit" ID="ImageButton1" runat="server"  OnClick="ImageButton1_Click" AlternateText='<%#  Eval("BigDataId") + "*" + Eval("comp_idTo") + "*" + Eval("comp_Name") %>'
                                    ImageUrl="~/Content/images/excel.png" CommandArgument='<%#  Eval("BigDataId") + "*" + Eval("comp_idTo") + "*" + Eval("comp_Name") %>'
                                    CommandName="DownloadConsumer" />
                                <%}%>
                                   <% else
                                    { %>
                                <asp:Label Text="Pending" runat="server" />
                                   <% } %>
                                <%--</div>--%>
                             <%--   <div style="float: right">
                                    <asp:HyperLink ID="HyperLink2" Target="_blank" NavigateUrl='<%#Bind("Test_Image2") %>' ToolTip="View / Download Image Second"
                                        runat="server">Image Second</asp:HyperLink></div>--%>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" />
                            <ItemStyle HorizontalAlign="Center" Width="15%" />
                        </asp:TemplateField>                                              
                       <%-- <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                            <asp:Label ID="teststatus" runat="server" Text='<%#Bind("Status") %>' ></asp:Label>
                               
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" />
                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                        </asp:TemplateField>--%>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <%if (GrdVwTestimonial.DataKeys[index]["DataStatus"].ToString() == "0")
                                    { %>
                                <asp:ImageButton ToolTip="Edit" ID="ImageButton2" runat="server" 
                                    ImageUrl="~/Content/images/Button/019.png" CommandArgument='<%# Eval("BigDataId") + "*" + Eval("comp_idTo") + "*" + Eval("comp_Name") %>'
                                    CommandName="EditRow" />
                                <%--<asp:ImageButton ToolTip="Confirm" ID="imgbtnedit" runat="server" CausesValidation="false" OnClientClick="return confirm('Are You Sure ?')"
                                    ImageUrl="~/images/acc_status.png" Height="20px" Width="20px" CommandArgument='<%# Bind("Testimonial_ID") %>'
                                    CommandName="Confirm" />--%>
                                <asp:ImageButton ID="ImageButton1Clo" runat="server" CommandArgument='<%# Bind("BigDataId") %>' 
                                    CommandName="Reject" ImageUrl="~/Content/images/delete.png" ToolTip="Cancel" OnClientClick="return confirm('Are You Sure ?')" />
                                <%} %>
                                <%--<%else %>
                                <%{ %>
                                        <asp:ImageButton ToolTip="Edit" ID="ImageButton2" runat="server" CausesValidation="false" OnClientClick="return alert('This Data request is approved by admin.You cannot edit!')" 
                                    ImageUrl="~/Content/images/Button/019.png" CommandArgument='<%# Bind("BigDataId") %>'
                                    />
                               
                                <asp:ImageButton ID="ImageButton3" runat="server" CommandArgument='<%# Bind("BigDataId") %>' CausesValidation="false"
                                     ImageUrl="~/Content/images/delete.png" ToolTip="Cancel" OnClientClick="return alert('This Data request is already approved by admin.You cannot delete!')" />
                                <%} %>--%>
                                <%index++;%>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed bord_left" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="7%" />
                        </asp:TemplateField>                        
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />
                </asp:GridView>
                <asp:Label ID="lblid" runat="server" Visible="false"></asp:Label>
                <asp:Panel ID="PanelTestimonial" runat="server" Width="35%" style="display:block;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnClose" CssClass="popupClose" runat="server" /></div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="lblheading" runat="server" Font-Bold="true"></asp:Label>
                                    </span><span class="right"><span class="astrics"><strong>*</strong></span> <em>indicates
                                        mandatory fields</em></span></p>
                            </div>
                            <div class="regis_popup">
                                <div id="newmsg" runat="server">
                                    <p>
                                        <asp:Label ID="lblmsgHeader" runat="server"></asp:Label></p>
                                </div>
                                <div>
                                    <table cellspacing="2" cellpadding="0" class="register_form">
                                        <tr>
                                            <td colspan="2">
                                                <div id="DivMshLac" runat="server" visible="false">
                                                    <p>
                                                        <asp:Label Text="" ID="lblMshLac" ForeColor="Red" runat="server" />
                                                    </p>

                                                </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" width="15%" valign="top">
                                                <strong><span class="astrics">*</span>Data Quantity :</strong>
                                            </td>
                                            <td class="align1" width="30%">
                                                <%--<asp:TextBox ID="txtTestimonial" CssClass="textbox" runat="server" 
                                                    onkeypress="return isNumberKey(this, event);"></asp:TextBox>--%>
                                                <asp:DropDownList ID="ddlQty" runat="server" CssClass="drp" AutoPostBack="true" OnSelectedIndexChanged="ddlQty_SelectedIndexChanged">
                                                </asp:DropDownList>
                                                <%--<asp:RequiredFieldValidator ValidationGroup="FTset" ControlToValidate="txtTestimonial"
                                                    ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ForeColor="Red"
                                                    ErrorMessage="*" ValidationGroup="FTset" ControlToValidate="ddlQty" InitialValue="0">
                                                </asp:RequiredFieldValidator>
                                                <%--  <br />
                                                <span class="astrics">Testimonial Comments should be 500 charecter.</span>--%>
                                            </td>
                                        </tr>
                                         <tr>
                                            <td align="right" width="15%" valign="top">
                                                <strong><span class="astrics">*</span>Data Price (Rs) :</strong>
                                            </td>
                                            <td class="align1" width="30%">
                                                <asp:TextBox ID="txtPrice" CssClass="textbox" runat="server" ReadOnly="true"
                                                   ></asp:TextBox><%-- onkeypress="return isNumberKey(this, event);"--%>
                                                <%--<asp:Label Text="" ID="txtPrice" runat="server" />--%>
                                                <asp:DropDownList ID="ddlPrice" runat="server" CssClass="drp" Enabled="false" Visible="false">
                                                </asp:DropDownList>
                                                <%--<asp:RequiredFieldValidator ValidationGroup="FTset" ControlToValidate="txtTestimonial"
                                                    ID="RequiredFieldValidator3" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                                    ErrorMessage="*" ValidationGroup="FTset" ControlToValidate="ddlPrice" InitialValue="0">
                                                </asp:RequiredFieldValidator>--%>
                                                <%--  <br />
                                                <span class="astrics">Testimonial Comments should be 500 charecter.</span>--%>
                                            </td>
                                        </tr>
                                        <tr id="trexcel" runat="server" visible="false"> <td align="right" width="15%" valign="top">
                                                <strong><span class="astrics"></span>View Consumer/End user :</strong>
                                            </td>
                                            <td class="align1" width="30%">
                                                <asp:ImageButton ID="btnExceldwn" runat="server"  Width="25px" Height="25px" Visible="true" ImageUrl="~/Content/images/excel.png" ToolTip="Download Excel" OnClick="btnExceldwn_Click1" />
                                            </td></tr>
                                        
                                        <tr>

                                            <td align="right" width="15%">

                                                <%--<asp:RequiredFieldValidator ValidationGroup="FTset" ControlToValidate="FileUpload1"
                                                    ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                                <asp:Label ID="lblImg" runat="server" ForeColor="Red" Font-Size="10px"></asp:Label><strong>
                                                    <span class="astrics"><%--*--%></span><%--Image 1 :--%></strong>
                                            </td>
                                            <td class="align1" width="30%">
                                                <asp:FileUpload ID="FileUpload1" Width="200px" runat="server" onchange="fileTypeCheck(this.value);" visible="false" />
                                                <a id="Doc1"  visible="false"  target="_blank" title="View Photo First" runat="server">View</a>&nbsp;&nbsp;
                                                <span class="astrics"><%--File size should be 1MB.--%></span>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right" width="15%">
                                                <%--<asp:RequiredFieldValidator ValidationGroup="FTset" ControlToValidate="FileUpload2"
                                                    ID="RequiredFieldValidator2" runat="server" ErrorMessage="*" ForeColor="Red"></asp:RequiredFieldValidator>--%>
                                                <asp:Label ID="lblImg1" runat="server" ForeColor="Red" Font-Size="10px"></asp:Label><strong><span
                                                    class="astrics"><%--*--%></span><%--Image 2 :--%></strong>
                                            </td>
                                            <td class="align1" width="30%">
                                                <asp:FileUpload ID="FileUpload2" Width="200px"  runat="server" onchange="fileTypeCheck1(this.value);" visible="false" />
                                                <a id="Doc2" target="_blank" title="View Photo Second" runat="server" visible="false">View</a>&nbsp;&nbsp;<span
                                                    class="astrics"><%--File size should be 1MB.--%></span></td>
                                        </tr>
                                        <tr>
                                            <td style="text-align: right; padding-right: 7px;" colspan="4">
                                                <br />
                                                <asp:CheckBox Text="Send Mail To Company" runat="server" ID="chkSendMail" Visible="False" />
                                                <asp:Button ID="btnsave" runat="server" CssClass="button_all" OnClick="btnsave_Click"
                                                    ValidationGroup="FTset" Text="Save" />
                                                &nbsp;
                                                <asp:Button ID="btnreset" runat="server" CausesValidation="false" CssClass="button_all"
                                                    OnClick="btnreset_Click" Text="Reset" />
                                            </td>
                                        </tr>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <asp:Label ID="Label4" runat="server"></asp:Label>
                <cc1:ModalPopupExtender ID="ModalPopupTestimonial" BackgroundCssClass="NewmodalBackground"
                    runat="server" TargetControlID="Label4" PopupControlID="PanelTestimonial" CancelControlID="btnClose">
                </cc1:ModalPopupExtender>
            </div>
            <asp:Panel ID="Panel2" runat="server" style="display:none;">
                <div id="popupAlert">
                    <div class="content_area_alert">
                        <div class="alert_f_header">
                            <div class="alert_here">
                                <asp:Label ID="lblmsgHeading" runat="server"></asp:Label>
                                <asp:Label ID="lblloginName" runat="server"></asp:Label>
                            </div>
                        </div>
                        <a href="#" id="popupContactClose_login12" class="popclosebtn">                           
                            <asp:ImageButton ID="Button2" ImageUrl="~/Content/images/q_close.png" runat="server" Style="top: -27;right: -30" />
                        </a>
                    </div>
                </div>
            </asp:Panel>
            <asp:Label ID="Label3" runat="server"></asp:Label>
            <cc1:ModalPopupExtender ID="ModalPopupMessage" BackgroundCssClass="NewmodalBackground"
                runat="server" TargetControlID="Label3" PopupControlID="Panel2" CancelControlID="Button2">
            </cc1:ModalPopupExtender>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnsave" />
             <asp:PostBackTrigger ControlID="btnExceldwn" />         
            <asp:PostBackTrigger ControlID="GrdVwTestimonial"   />   
            
           <%-- <asp:PostBackTrigger ControlID="ImageButton1" />   --%>     
        </Triggers>
    </asp:UpdatePanel>