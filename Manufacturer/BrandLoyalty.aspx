<%@ Page Language="C#" MasterPageFile="~/Manufacturer/MasterPage.master" AutoEventWireup="true"
    CodeFile="BrandLoyalty.aspx.cs" Inherits="BrandLoyalty" Title="Brand Loyalty" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(21).addClass("active");
            $(".accordion2 div.open").eq(21).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        }); 
    </script>

    <script type="text/javascript" language="javascript">
        function fileTypeCheckengH(mm) {
            PageMethods.checkFile(mm, onengcheckH)
        }
        function onengcheckH(Result) {
            if (Result == true) {
                document.getElementById("<%=lblfileH.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";

            }
            else {
                document.getElementById("<%=lblfileH.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
            }
            ChkRegProVal();
        }

        function fileTypeCheckengE(mm) {
            PageMethods.checkFile(mm, onengcheckE)
        }
        function onengcheckE(Result) {
            if (Result == true) {
                document.getElementById("<%=lblfileE.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";

            }
            else {
                document.getElementById("<%=lblfileE.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
            }
            ChkRegProVal();
        }
        function CheckZero(val) {
            if (parseFloat(val) == 0)
                document.getElementById("<%=txtfrequency.ClientID %>").value = "";
        }
        function CheckDate(val) {        
            //alert(val);
            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth() + 1; //January is 0!
            var yyyy = today.getFullYear();

            if (dd < 10) {
                dd = '0' + dd
            }

            if (mm < 10) {
                mm = '0' + mm
            }

            today = dd + '/' + mm + '/' + yyyy;
            //alert(today);
            var diff = daydiff(parseDate(val), parseDate(today));
            //alert(diff);
            //alert(daydiff(parseDate(val), parseDate(today)));
            if (parseFloat(diff) > 0)
                document.getElementById("<%=txtloyaltydtfrom.ClientID %>").value = "";
        }
        function parseDate(str) {
            //alert(str);
            var mdy = str.split('/'); //alert(mdy[0]);alert(mdy[1]); alert(mdy[2]); alert(mdy[2] + '/' + mdy[1] + '/' + mdy[0]);
            return new Date(mdy[2], mdy[1], mdy[0]);
        }

        function daydiff(first, second) {
            //alert(first); alert(second);
            return Math.round((second - first) / (1000 * 60 * 60 * 24));
        }

        
    </script>

    <style>
        #ctl00_ContentPlaceHolder1_chkconvert
        {
            margin-top: 10px !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 1230px; width: 100%;
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
                <h2 class="brand_loyalty">
                    <table width="99%">
                        <tr>
                            <td width="85%">
                                Brand Loyalty Products
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" ToolTip="Add New Brand Loyalty Product" OnClick="imgNew_Click"
                                    ImageUrl="~/Content/images/add_new.png" CausesValidation="false" runat="server" />
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <div style="width: 100%; text-align: center;">
            </div>
            <div style="width: 100%; text-align: center;">
                <asp:Label ID="Label3" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
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
                            </td>
                            <td width="18%">
                                <asp:TextBox ID="txtProductName" placeholder="Product Name" runat="server" Text=""
                                    CssClass="reg_txt"></asp:TextBox>
                            </td>
                            <td>
                                <div class="merg_btn">
                                    <asp:ImageButton ID="ImgSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                        CausesValidation="false" ToolTip="Search" OnClick="ImgSearch_Click" />
                                    <asp:ImageButton ID="ImgRefresh" runat="server" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                        CausesValidation="false" ToolTip="Reset" />
                                </div>
                            </td>
                            <td align="right" width="10%" style="visibility: hidden;">
                                <strong>MFG Date:</strong>
                            </td>
                            <td width="18%" style="visibility: hidden;">
                                <asp:TextBox ID="txtDateFrom" runat="server" Text="" CssClass="reg_txt"></asp:TextBox>
                            </td>
                            <td align="right" width="10%" style="visibility: hidden;">
                                <strong>EXP Date:</strong>
                            </td>
                            <td width="18%" style="visibility: hidden;">
                                <asp:TextBox ID="txtDateTo" runat="server" Text="" CssClass="reg_txt"></asp:TextBox>
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </fieldset>
            <div id="allhidden">
                <asp:HiddenField ID="ActionText" runat="server" />
                <asp:HiddenField ID="IsAct" runat="server" />
                <asp:Label ID="lblproiddel" runat="server" Visible="false"></asp:Label>
                <asp:HiddenField ID="currindex" runat="server" />
                <asp:HiddenField ID="lblproidamc" runat="server" />
                <asp:HiddenField ID="hhdnCompID" runat="server" />
            </div>
            <fieldset class="Newfield" style="width: 98%">
                <legend>Icon Meaning</legend>
                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                    <tr>
                        <td colspan="12" style="width: 100%;">
                            <table style="width: 100%;">
                                <tr>
                                    <td style="width: 2%;">
                                        <img alt="" src="../Content/images/edit.png" />
                                    </td>
                                    <td style="width: 17%;">
                                        Update Brand Loyalty
                                    </td>
                                    <td style="width: 2%;">
                                        <img alt="" src="../Content/images/check_act.png" style="height: 12px; width: 12px;" />
                                    </td>
                                    <td style="width: 15%;">
                                        Acive (Click for In-Active)
                                    </td>
                                    <td width="2%">
                                        <img alt="" src="../Content/images/check_gr.png" style="height: 12px; width: 12px;" />
                                    </td>
                                    <td style="width: 16%;">
                                        In-Active (Click for Active)
                                    </td>
                                    <td width="2%">
                                        <img alt="" src="../Content/images/delete.png" />
                                    </td>
                                    <td width="13%">
                                        Delete Brand Loyalty
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
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
                <asp:HiddenField ID="docflag" runat="server" />
                <asp:HiddenField ID="HdFieldAmcId" runat="server" />
                <asp:HiddenField ID="HdFieldOfferId" runat="server" />
                <asp:HiddenField ID="hdnpointsval" runat="server" />
                <asp:GridView ID="GrdProductMaster" runat="server" AutoGenerateColumns="False" CssClass="grid"
                    DataKeyNames="Comp_type,IsActive" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                    EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                    BorderColor="transparent" AllowPaging="True" PageSize="15" OnRowCommand="GrdProductMaster_RowCommand"
                    OnPageIndexChanging="GrdProductMaster_PageIndexChanging1">
                    <Columns>
                        <asp:TemplateField HeaderText="S.No">
                            <ItemTemplate>
                                <%=++c %>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="4%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product Name">
                            <ItemTemplate>
                                <asp:Label ID="lblproname" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="17%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Points">
                            <ItemTemplate>
                                <asp:Label ID="lblptgains" runat="server" Text='<%# Bind("Points") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="7%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Point To Cash">
                            <ItemTemplate>
                                <asp:Label ID="lbliScASHcONVERT" runat="server" Text='<%# Bind("IsCashConvert") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Frequency">
                            <ItemTemplate>
                                <asp:Label ID="lblfrequency" runat="server" Text='<%# Bind("Frequency") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="9%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Comments">
                            <ItemTemplate>
                                <asp:Label ID="lblComments" runat="server" Text='<%# Bind("Comments") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="25%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Hindi">
                            <ItemTemplate>
                                <ul class="graphic">
                                    <li><a href='<%# Eval("SoundPath") %>' class="sm2_link"></a></li>
                                </ul>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed bord_left" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="7%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="English">
                            <ItemTemplate>
                                <ul class="graphic">
                                    <li><a href='<%# Eval("SoundPath1") %>' class="sm2_link"></a></li>
                                </ul>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed bord_left" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="7%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <%
                                    try
                                    {
                                        Comptype = Convert.ToString(GrdProductMaster.DataKeys[index].Values["Comp_type"].ToString());
                                        IsActive = Convert.ToInt32(GrdProductMaster.DataKeys[index].Values["IsActive"].ToString()); //CntDays = Convert.ToInt32(GrdProductMaster.DataKeys[index].Values["CntDays"].ToString());
                                    }
                                    catch
                                    {
                                    }
                                %>
                                <asp:ImageButton ID="ImgBtnLoyalty" runat="server" CausesValidation="false" CommandArgument='<%#Bind("Pro_ID") %>'
                                    CommandName="Loyalty" ImageUrl="~/Content/images/edit.png" ToolTip="Add / Update Loyalty" />&nbsp;
                                <%if (IsActive == 0)
                                  {%>
                                <asp:ImageButton ID="ImgIsActiveDelete" runat="server" CausesValidation="false" CommandArgument='<%#Bind("Pro_ID") %>'
                                    CommandName="IsActive" ImageUrl="~/Content/images/check_act.png" ToolTip="Add / Update Loyalty"
                                    OnClientClick="return confirm('Are you sure to In-Active.')" />
                                <%}
                                  else
                                  { %>
                                <asp:ImageButton ID="ImgIsActiveDeletes" runat="server" CausesValidation="false"
                                    CommandArgument='<%#Bind("Pro_ID") %>' CommandName="IsActive" ImageUrl="~/Content/images/check_gr.png"
                                    ToolTip="Add / Update Loyalty" OnClientClick="return confirm('Are you sure to Active.')" />
                                <%} %>
                                <%
                                    
                                    if (Comptype == "L")
                                    {
                                %>
                                &nbsp;<asp:ImageButton ID="imgBtnSecDelete" runat="server" CommandArgument='<%#Bind("Pro_ID") %>'
                                    CommandName="DeleteRow" ImageUrl="~/Content/images/delete.png" ToolTip="Delete" OnClientClick="return confirm('Are you sure to delete.')" />
                                <% } %>
                                <%index++;%>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed bord_left" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="8%" />
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />
                </asp:GridView>
                <!-------------------Start Loyalty Popup--------------->
                <asp:Panel ID="AddLoyaltyPanel" runat="server" Width="40%" Style="display: none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btncloseloyalty" CssClass="popupClose" runat="server" /></div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="Lblloyaltyhead" runat="server" Font-Bold="true"></asp:Label>
                                    </span>
                                </p>
                            </div>
                            <div class="regis_popup">
                                <table cellpadding="0px" cellspacing="10px" width="100%" class="grid" style="line-height: 25px;">
                                    <tr>
                                        <td>
                                            <div id="DivMsg" runat="server">
                                                <p>
                                                    <asp:Label ID="LblMsgBody" runat="server"></asp:Label></p>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <fieldset class="Newfield">
                                                <legend>Brand Loyalty Information</legend>
                                                <table width="100%">
                                                    <tr style="display: none;">
                                                        <td style="width: 30%; text-align: right;"><strong>Loyalty : </strong><span class="astrics">*</span>&nbsp;&nbsp; </td>
                                                        <td style="vertical-align: top;">
                                                            <asp:CheckBox ID="chkloyalty" runat="server" Checked="true" Text="    Loyalty Required" ValidationGroup="LOY" />
                                                            <br />
                                                        </td>
                                                        <td colspan="2"></td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 30%; text-align: right;"><strong>Product : </strong><span class="astrics">*</span>&nbsp;&nbsp; </td>
                                                        <td colspan="3">
                                                            <asp:DropDownList ID="ddlProduct" runat="server" CssClass="drp" Width="65%">
                                                            </asp:DropDownList>
                                                            &nbsp;<a href="RegisteredProduct.aspx?Parm=New" title="Add New Brand Loyalty Product"><img
                                                                    alt="" src="../Content/images/add_new.png" style="height: 17px; width: 17px;" /></a>
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="ddlProduct" ForeColor="Red" InitialValue="--Select--" ValidationGroup="LOY">
                                                                </asp:RequiredFieldValidator>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 30%; text-align: right;"><strong>Points : </strong><span class="astrics">*</span>&nbsp;&nbsp;
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="txtloyaltypoints" ForeColor="Red" ValidationGroup="LOY">
                                                                </asp:RequiredFieldValidator>
                                                        </td>
                                                        <td><%--AutoPostBack="true" OnTextChanged="CheckforUpdate"--%>
                                                            <asp:TextBox ID="txtloyaltypoints" runat="server" CssClass="reg_txt" onkeyDown="return checkTextAreaMaxLength(this,event,'5');" Width="120px"></asp:TextBox>
                                                        </td>
                                                        <td style="width: 30%; text-align: right; vertical-align: top;"><strong>Frequency : </strong><%--<span class="astrics">*</span>--%>&nbsp;&nbsp; <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                                                    ValidationGroup="LOY" ControlToValidate="txtfrequency">
                                                                </asp:RequiredFieldValidator>--%></td>
                                                        <td>
                                                            <asp:TextBox ID="txtfrequency" runat="server" CssClass="reg_txt" onchange="javascript:CheckZero(this.value);" onkeyDown="return checkTextAreaMaxLength(this,event,'2');" ToolTip="Enter Frequency to win alternet rewards points" Width="120px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 30%; text-align: right;"><strong>Date From : </strong><%--<span class="astrics">*</span>--%>&nbsp;&nbsp; </td>
                                                        <td>
                                                            <asp:TextBox ID="txtloyaltydtfrom" runat="server" CssClass="reg_txt" onchange="javascript:CheckDate(this.value);" Width="120px"></asp:TextBox>
                                                        </td>
                                                        <td style="width: 30%; text-align: right;"><strong>Date To : </strong><%--<span class="astrics">*</span>--%>&nbsp;&nbsp; </td>
                                                        <td>
                                                            <asp:TextBox ID="txtloyaltydtto" runat="server" CssClass="reg_txt" Width="120px"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 30%; text-align: right;"><strong>Is Cash : </strong>&nbsp;&nbsp; </td>
                                                        <td colspan="3">
                                                            <asp:CheckBox ID="chkconvert" runat="server" ValidationGroup="LOY" />
                                                            <span id="lbliscash">Convert to Cash</span> &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:CompareValidator ID="CompareValidator1" runat="server" ControlToCompare="txtloyaltydtfrom" ControlToValidate="txtloyaltydtto" ForeColor="Red" Operator="GreaterThan" Text="Date To is Less Than Date From" Type="Date" ValidationGroup="LOY"></asp:CompareValidator>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset> </td>
                                        <tr>
                                            <td colspan="4">
                                                <fieldset class="Newfield">
                                                    <legend>Message</legend>
                                                    <table width="100%">
                                                        <tr>
                                                            <td align="right" style="width: 27%;">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator15Msg" runat="server" ForeColor="Red"
                                                                    ValidationGroup="LOY" ControlToValidate="txtCommentsTxt"></asp:RequiredFieldValidator>
                                                                <strong><span class="astrics">*</span> Message :</strong>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtCommentsTxt" MaxLength="100" TextMode="MultiLine" Width="95%"
                                                                    Height="30px" CssClass="textbox_pop" onkeyDown="return checkTextAreaMaxLength(this,event,'25');"
                                                                    runat="server"></asp:TextBox>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td>
                                                            </td>
                                                            <td class="astrics">
                                                                Message should be in 25 character
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </fieldset>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <fieldset class="Newfield">
                                                    <legend>Message Audio Files(*.wav)</legend>
                                                    <table width="98%" cellpadding="0" cellspacing="2">
                                                        <%--<tr>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                </td>
                                                <td>
                                                    <asp:Label ID="Label10" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
                                                </td>
                                            </tr>--%>
                                                        <tr>
                                                            <td style="width: 23%; text-align: right;">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidatorHindi" runat="server" ForeColor="Red"
                                                                    ValidationGroup="LOY" ControlToValidate="flSoundH"></asp:RequiredFieldValidator>
                                                                <strong>
                                                                    <asp:Label ID="L2" runat="server" CssClass="astrics" Text="*"></asp:Label>
                                                                    Hindi : </strong>
                                                            </td>
                                                            <td style="width: 40%">
                                                                <asp:FileUpload ID="flSoundH" onchange="fileTypeCheckengH(this.value);" runat="server"
                                                                    Style="width: 88%;" />
                                                            </td>
                                                            <td style="width: 15%;">
                                                                <div style="width: 25px; float: right; padding-right: 15px;">
                                                                    <ul class="graphic">
                                                                        <li><a id="FileDownHindi" runat="server" title="Play" class="sm2_link"></a></li>
                                                                    </ul>
                                                                </div>
                                                                <asp:Label ID="lblfileH" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" style="width: 10%">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator6English" runat="server" ForeColor="Red"
                                                                    ValidationGroup="LOY" ControlToValidate="flSoundE"></asp:RequiredFieldValidator>
                                                                <strong>
                                                                    <asp:Label ID="L1" runat="server" CssClass="astrics" Text="*"></asp:Label>
                                                                    English : </strong>
                                                            </td>
                                                            <td>
                                                                <asp:FileUpload ID="flSoundE" onchange="fileTypeCheckengE(this.value);" runat="server"
                                                                    Style="width: 88%;" />
                                                            </td>
                                                            <td>
                                                                <div style="width: 25px; float: right; padding-right: 15px;">
                                                                    <ul class="graphic">
                                                                        <li><a id="FileDownEnglish" runat="server" title="Play" class="sm2_link"></a></li>
                                                                    </ul>
                                                                </div>
                                                                <asp:Label ID="lblfileE" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </fieldset>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4" style="height: 10px;">
                                            </td>
                                        </tr>
                                        <tr style="display: none;">
                                            <td style="width: 30%; text-align: right;">
                                                <strong>Status : </strong>&nbsp;&nbsp;
                                            </td>
                                            <td>
                                                <asp:CheckBox ID="chkIsActive" runat="server" Text="  IsActive" Checked="true" />&nbsp;&nbsp;&nbsp;&nbsp;<asp:CheckBox
                                                    ID="chkIsDelete" runat="server" Text="  IsDelete" />
                                            </td>
                                            <td colspan="2">
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <asp:Label ID="lblnoteSound" Style="font-family: Arial; font-size: 12px; color: red;"
                                                    runat="server" Text="Note:- Audio file to be uploaded on the website should be in the prescribed format as below"></asp:Label>
                                                <br />
                                                <asp:Label ID="Label11" Style="font-family: Arial; font-size: 12px; color: red;"
                                                    runat="server" Text="File Type ---- .wav"></asp:Label>
                                                <br />
                                                <asp:Label ID="lblfileformat" Style="font-family: Arial; font-size: 12px; color: red;"
                                                    runat="server" Text="Format ---- 8KHz, 16bit mono"></asp:Label>
                                                <br />
                                                <asp:Label ID="lblBitRate" Style="font-family: Arial; font-size: 12px; color: red;"
                                                    runat="server" Text="Bit Rate ---- 128 kbps"></asp:Label>
                                                <br />
                                                <asp:Label ID="Label12" Style="font-family: Arial; font-size: 12px; color: Blue;"
                                                    runat="server" Text="For record the audio file, Please click the link "></asp:Label>&nbsp;
                                                <a href="http://wavepad.en.softonic.com/" style="font-family: Arial; font-size: 12px;
                                                    color: Blue;" target="_blank">Click</a>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="center" colspan="4">
                                                <asp:Button ID="btnSave" runat="server" CssClass="button_all" OnClick="btnLoyalty_Click"
                                                    ValidationGroup="LOY" Text="OK" />
                                            </td>
                                        </tr>
                                        <tr>
                                            <td colspan="4">
                                                <cc1:CalendarExtender ID="CalendarExtender7" runat="server" TargetControlID="txtloyaltydtfrom"
                                                    Format="dd/MM/yyyy">
                                                </cc1:CalendarExtender>
                                                <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtloyaltydtfrom"
                                                    Mask="99/99/9999" MaskType="Date">
                                                </cc1:MaskedEditExtender>
                                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender7" runat="server" TargetControlID="txtloyaltydtfrom"
                                                    WatermarkText="Date From..">
                                                </cc1:TextBoxWatermarkExtender>
                                                <cc1:CalendarExtender ID="CalendarExtender8" runat="server" TargetControlID="txtloyaltydtto"
                                                    Format="dd/MM/yyyy">
                                                </cc1:CalendarExtender>
                                                <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="txtloyaltydtto"
                                                    Mask="99/99/9999" MaskType="Date">
                                                </cc1:MaskedEditExtender>
                                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender8" runat="server" TargetControlID="txtloyaltydtto"
                                                    WatermarkText="Date To..">
                                                </cc1:TextBoxWatermarkExtender>
                                            </td>
                                        </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupLoyalty" runat="server" BackgroundCssClass="NewmodalBackground"
                    PopupControlID="AddLoyaltyPanel" TargetControlID="LblTargetLoyalty" CancelControlID="btncloseloyalty">
                </cc1:ModalPopupExtender>
                <asp:Label ID="LblTargetLoyalty" runat="server"></asp:Label>
                <asp:HiddenField ID="hdnloyalty" runat="server" />
                <!-------------------End Loyalty Popup--------------->
                <!-------------------Start Alert Popup--------------->
                <asp:Panel ID="PanelAlert" runat="server" Width="25%">
                    <
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnclosealerttest" CssClass="popupClose" runat="server" /></div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="LabelAlertHead" runat="server" Font-Bold="true" Text="Alert"></asp:Label>
                                    </span>
                                </p>
                            </div>
                            <div class="regis_popup">
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="center">
                                            <asp:Label ID="lblalert" runat="server" Font-Bold="true" Font-Size="10pt"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 7px;">
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td>
                                            <asp:Button ID="btnYesAlert" runat="server" OnClick="btnYesAlert_Click" CssClass="button_all"
                                                CausesValidation="false" Text="Yes" />&nbsp;&nbsp;
                                            <asp:Button ID="btnNoAlert" runat="server" OnClick="btnNoAlert_Click" CssClass="button_all"
                                                Text="No" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupExtenderAlert" runat="server" BackgroundCssClass="NewmodalBackground"
                    PopupControlID="PanelAlert" TargetControlID="lbltestcontrol" CancelControlID="btnclosealerttest">
                </cc1:ModalPopupExtender>
                <asp:Label ID="lbltestcontrol" runat="server"></asp:Label>
                <!-------------------End Alert Popup--------------->
            </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
        </Triggers>
    </asp:UpdatePanel>
</asp:Content>
