<%@ Page Title="" Language="C#" MasterPageFile="~/Patanjali/pfl.master" AutoEventWireup="true"
    CodeFile="RegisteredProduct.aspx.cs" Inherits="Partner_RegisteredProduct" %>

    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
        <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">


            <script type="text/javascript">
                $(document).ready(function () {

                    $(".accordion2 p").eq(5).addClass("active");
                    $(".accordion2 div.open").eq(4).show();

                    $(".accordion2 p").click(function () {
                        $(this).next("div.open").slideToggle("slow")
                            .siblings("div.open:visible").slideUp("slow");
                        $(this).toggleClass("active");
                        $(this).siblings("p").removeClass("active");
                    });

                });
            </script>


        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


            <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center"
                        style="position: absolute; left: 0; height: 1230px; width: 100%; z-index: 100001; top: 0px;"
                        class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>

            <div class="home-section">
                <div class="app-breadcrumb">
                    <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1 g-3">
                        <div class="col">
                            <h5>Register Products</h5>
                        </div>
                        <div class="col">
                            <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="../Patanjali/dashboard.aspx">Dashboard</a></li>
                                    <%-- <li class="breadcrumb-item"><a href="#">Product Particulars</a></li>--%>
                                        <li class="breadcrumb-item active" aria-current="page">Register Products</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>


                <div class="user-role-card">
                    <div class="card">
                        <div class="card-body">

                            <asp:HiddenField ID="hhdnCompID" runat="server" />
                            <asp:HiddenField ID="currindex" runat="server" />
                            <asp:HiddenField ID="lblproid" runat="server" />


                            <div class="row">
                                <div class="col col-md-4 mb-3">
                                    <div class="global-search">
                                        <div class="form-group ">
                                            <input type="search" class="form-control"
                                                onkeyup="performSearch(this.value)" placeholder="Search">
                                            <span><i class="fa fa-search"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col mb-3">
                                    <ul class="action-button-global">

                                        <li>
                                            <a href="AddProduct.aspx" class="btn btn-sm btn-primary"><i
                                                    class='bx bx-plus'></i>add
                                                Product</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <asp:Label ID="Label3" runat="server"
                                Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
                            <p id="NewMsgpop" runat="server" class="mb-0">
                                <asp:Label ID="Label2" runat="server"></asp:Label>
                            </p>

                            <div id="newmsg" runat="server">
                                <asp:Label ID="lblmsgHeader" runat="server"></asp:Label>
                            </div>
                            <h4 class="mb-0">Total Products<span> (<asp:Label ID="lblcount" runat="server">
                                    </asp:Label>)</span></h4>
                            <div class="app-table">
                                <div class="table-responsive">
                                    <asp:GridView ID="GrdProductMaster" runat="server" AutoGenerateColumns="False"
                                        CssClass="table table-striped table-hover"
                                        DataKeyNames="Comp_type,CntDays,Loyalty" BorderColor="transparent"
                                        OnRowCommand="GrdProductMaster_RowCommand"
                                        OnPageIndexChanging="GrdProductMaster_PageIndexChanging1">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S.No">
                                                <ItemTemplate>
                                                    <%=++c %>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed" />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Product Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblactudate" runat="server"
                                                        Text='<%# Bind("Pro_Name") %>'></asp:Label>
                                                </ItemTemplate>
                                                <%--<HeaderStyle />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Label Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbllblnamesize" runat="server"
                                                        Text='<%# Bind("Label_Name") %>'></asp:Label>
                                                </ItemTemplate>
                                                <%--<HeaderStyle />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Price/Label">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblproprice" runat="server"
                                                        Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                        Text='<%# Bind("Rate_Per_Label") %>'></asp:Label>+(Applicable
                                                    Tax)
                                                </ItemTemplate>
                                                <%--<HeaderStyle />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Description">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbldiscrip" runat="server"
                                                        Text='<%# Bind("Pro_Desc") %>'></asp:Label>
                                                </ItemTemplate>
                                                <%--<HeaderStyle />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <%--<asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblStatus" runat="server"
                                                        Text='<%# Bind("Status") %>'></asp:Label>
                                                </ItemTemplate>
                                                <ItemStyle />
                                                </asp:TemplateField>--%>
                                                <%--<asp:TemplateField HeaderText="AMC">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblproamc" runat="server"
                                                            Text='<%# Bind("Plan_Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle />
                                                    <ItemStyle />
                                                    </asp:TemplateField>--%>
                                                    <asp:TemplateField HeaderText="Sound File">
                                                        <ItemTemplate>
                                                            <audio class="audio-element" src='<%# Eval("SoundPath") %>'
                                                                onended="resetPlayIcon()"></audio>
                                                            <button type="button"
                                                                class="play-button btn btn-sm p-0 border-0"
                                                                onclick="togglePlay(this)">
                                                                <i class='bx bx-play-circle fs-5'></i>
                                                            </button>
                                                            <!-- <a href='<%# Eval("SoundPath") %>'><i class='bx bx-play-circle fs-5'></i></a> -->
                                                        </ItemTemplate>

                                                        <ItemStyle />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Action">
                                                        <ItemTemplate>
                                                            <asp:ImageButton ID="imgBtnEdit" runat="server"
                                                                CausesValidation="false"
                                                                CommandArgument='<%#Bind("Pro_ID") %>'
                                                                CommandName="EditRow"
                                                                ImageUrl="../Content/images/edit.png" ToolTip="Edit" />
                                                            <asp:ImageButton ID="ImgBtnLoyalty" runat="server"
                                                                CausesValidation="false"
                                                                CommandArgument='<%#Bind("Pro_ID") %>'
                                                                CommandName="Loyalty"
                                                                ImageUrl="../Content/images/loyalty.png"
                                                                ToolTip="Add / Update Loyalty" Visible="false" />
                                                            <% try {
                                                                Comptype=Convert.ToString(GrdProductMaster.DataKeys[index].Values["Comp_type"].ToString());
                                                                CntDays=Convert.ToInt32(GrdProductMaster.DataKeys[index].Values["CntDays"].ToString());
                                                                Loyalty=Convert.ToInt32(GrdProductMaster.DataKeys[index].Values["Loyalty"].ToString());
                                                                } catch { } if (Comptype=="L" ) { %>
                                                                &nbsp;
                                                                <asp:ImageButton ID="imgBtnSecDelete" runat="server"
                                                                    CausesValidation="false" Visible="false"
                                                                    CommandArgument='<%#Bind("Pro_ID") %>'
                                                                    CommandName="DeleteRow"
                                                                    ImageUrl="../Content/images/delete.png"
                                                                    ToolTip="Delete" />
                                                                <% } %>
                                                                    <asp:ImageButton ID="ImgAmcRenewal" runat="server"
                                                                        CausesValidation="false"
                                                                        ImageUrl="../Content/images/upg.png"
                                                                        ToolTip="View/Renewal your Amc"
                                                                        CommandName="AmcRenewal"
                                                                        CommandArgument='<%#Bind("Pro_ID") %>'
                                                                        Height="12px" Width="12px" Visible="false" />
                                                                    <asp:ImageButton ID="ImgOfferRenewal" runat="server"
                                                                        CausesValidation="false"
                                                                        ImageUrl="../Content/images/upgrade.png"
                                                                        ToolTip="View/Renewal your Offer"
                                                                        CommandName="OfferRenewal"
                                                                        CommandArgument='<%#Bind("Pro_ID") %>'
                                                                        Height="12px" Width="12px" Visible="false" />
                                                                    <a href='<%# Eval("DocPath") %>' target="_blank">
                                                                        <img src="../Content/images/search.png"
                                                                            alt="dfgd" height="14px" width="14px"
                                                                            title="View product's legal document" />
                                                                    </a>
                                                                    <%if (Loyalty==1) {%>
                                                                        <img src="../Content/images/payment-24.png"
                                                                            alt="dfgd" height="14px" width="14px"
                                                                            title="Alredy brand loyalty subscribe"
                                                                            style="display: none;" />
                                                                        <%} else {%>
                                                                            <a href="ServiceSubscription.aspx"
                                                                                target="_blank" style="display: none;">
                                                                                <img src="../Content/images/plus-24.png"
                                                                                    alt="dfgd" height="14px"
                                                                                    width="14px"
                                                                                    title="Add brand loyalty"
                                                                                    style="display: none;" />
                                                                            </a>
                                                                            <%} %>
                                                                                <%index++;%>
                                                        </ItemTemplate>
                                                        <%--<HeaderStyle CssClass="tr_haed bord_left" />--%>
                                                        <ItemStyle />
                                                    </asp:TemplateField>
                                        </Columns>
                                        <%-- <PagerStyle CssClass="pagination" />
                                        <RowStyle CssClass="tr_line1" />
                                        <AlternatingRowStyle CssClass="tr_line2" />--%>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="NewmodalBackground"
                    PopupControlID="PanelProduct" TargetControlID="Label1" CancelControlID="Button1">
                </cc1:ModalPopupExtender>
                <asp:Label ID="Label1" runat="server"></asp:Label>
                <!-- Pop Alert -->
                <asp:HiddenField ID="hdnoldAmcId" runat="server" />
                <asp:Label ID="lblproiddel" runat="server" ForeColor="White"></asp:Label>
                <asp:HiddenField ID="HiddenField1" runat="server" />
                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                    <ContentTemplate>
                        <asp:Panel ID="PanelAlert" runat="server" Width="25%" Style="display: none;">
                            <div class="popupContent" style="width: 100%;">
                                <div class="pop_log_bg">
                                    <div>
                                        <asp:Button ID="btnclosealert" CssClass="popupClose" runat="server" />
                                    </div>
                                    <div class="service_head_p">
                                        <p>
                                            <span class="left">
                                                <asp:Label ID="LabelAlert" runat="server" Font-Bold="true" Text="Alert">
                                                </asp:Label>
                                            </span>
                                        </p>
                                    </div>
                                    <div class="regis_popup">
                                        <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                            <tr>
                                                <td>
                                                    <asp:Label ID="lblalert" runat="server" Font-Bold="true"
                                                        Font-Size="10pt"></asp:Label>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td style="height: 7px;"></td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <asp:Button ID="btnYesAlert" runat="server"
                                                        OnClick="btnYesAlert_Click" CssClass="button_all"
                                                        CausesValidation="false" Text="Yes" />&nbsp;&nbsp;
                                                    <asp:Button ID="btnNoAlert" runat="server"
                                                        OnClick="btnNoAlert_Click" CssClass="button_all" Text="No" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <cc1:ModalPopupExtender ID="ModalPopupExtenderAlert" runat="server"
                            BackgroundCssClass="NewmodalBackground" PopupControlID="PanelAlert"
                            TargetControlID="LabelAlertT" CancelControlID="btnclosealert">
                        </cc1:ModalPopupExtender>
                        <asp:Label ID="LabelAlertT" runat="server"></asp:Label>
                        <asp:HiddenField ID="HdLabelCode" runat="server" />
                        <asp:HiddenField ID="HdLabelCodeRequest" runat="server" />
                        <asp:HiddenField ID="HdPro_ID" runat="server" />
                        <asp:HiddenField ID="HdPromoId" runat="server" />
                        <asp:Panel ID="PanelAmcRenewal" runat="server" Style="width: 60%; display: none;">
                            <div class="popupContent" style="width: 100%;">
                                <div class="pop_log_bg">
                                    <div>
                                        <asp:Button ID="btnAmcRenewalpopClose" CssClass="popupClose" runat="server" />
                                    </div>
                                    <div class="service_head_p">
                                        <p>
                                            <span class="left">
                                                <asp:Label ID="LblAmcRenewalHeader" runat="server" Font-Bold="true"
                                                    Text="Amc Renewal"></asp:Label>
                                            </span>
                                        </p>
                                    </div>
                                    <div class="regis_popup">
                                        <div id="Div2" runat="server" style="width: 89%;">
                                            <p>
                                                <asp:Label ID="Label8" runat="server"></asp:Label>
                                            </p>
                                        </div>
                                        <div id="DivNewMsg1" runat="server" style="width: 89%;">
                                            <p>
                                                <asp:Label ID="LabelAmcRenewalmsg" runat="server"></asp:Label>
                                            </p>
                                            <asp:HiddenField ID="HiddenField2" runat="server" />
                                        </div>
                                        <div id="MyAmcOfferDetails" runat="server">
                                            <asp:HiddenField ID="HdnUpdatePlanTime" runat="server" />
                                            <asp:HiddenField ID="HdnUpdatePlanStatus" runat="server" />
                                            <asp:HiddenField ID="HdnUpdatePlanID" runat="server" />
                                            <asp:HiddenField ID="HdnUpdatePlanType" runat="server" />
                                            <asp:HiddenField ID="HdnUpdatePlanTransID" runat="server" />
                                            <asp:HiddenField ID="HdnUpdatePlanAmount" runat="server" />
                                            <asp:HiddenField ID="hdnAmcDateFrom" runat="server" />
                                            <asp:HiddenField ID="hdnAmcDateTo" runat="server" />
                                            <asp:GridView ID="GrdProductsAmc" runat="server" AutoGenerateColumns="False"
                                                CssClass="grid" DataKeyNames="Trans_Type,IsCancel"
                                                EmptyDataText="Record Not Found" EmptyDataRowStyle
                                                EnableModelValidation="True" Width="100%" BorderStyle="None"
                                                BorderWidth="0" OnRowCommand="GrdProductsAmc_RowCommand">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Amc Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="proAmcType" runat="server"
                                                                Text='<%# Bind("Plan_Name") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle />
                                                        <ItemStyle />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Plan Amount">
                                                        <ItemTemplate>
                                                            <asp:Label ID="proplanAmt" Style="padding-left: 10px;"
                                                                CssClass="txt_rupees rupees" runat="server"
                                                                Text='<%# Bind("Plan_Amount") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle />
                                                        <ItemStyle HorizontalAlign="Left" CssClass="grd_pad"
                                                            Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Status">
                                                        <ItemTemplate>
                                                            <asp:Label ID="proplanvrstatus" runat="server"
                                                                Text='<%# Bind("Status") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle />
                                                        <ItemStyle HorizontalAlign="Left" Width="12%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Start Date">
                                                        <ItemTemplate>
                                                            <asp:Label ID="proplanstdate" runat="server"
                                                                Text='<%# Bind("Date_From") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle />
                                                        <ItemStyle HorizontalAlign="Left" Width="12%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="End Date">
                                                        <ItemTemplate>
                                                            <asp:Label ID="proplanenddate" runat="server"
                                                                Text='<%# Bind("Date_To") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle />
                                                        <ItemStyle HorizontalAlign="Left" Width="12%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Discount">
                                                        <ItemTemplate>
                                                            <asp:Label ID="LblAmcdisprices" Style="padding-left: 10px;"
                                                                CssClass="txt_rupees rupees" runat="server"
                                                                Text='<%# Bind("Plan_Discount") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle />
                                                        <ItemStyle Width="10%" />
                                                    </asp:TemplateField>
                                                    <%-- <asp:TemplateField HeaderText="Requested">
                                                        <ItemTemplate>
                                                            <asp:Label ID="proplandueAmt" Style="padding-left: 10px;"
                                                                CssClass="txt_rupees rupees" runat="server"
                                                                Text='<%# Bind("Pending_Balance") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle />
                                                        <ItemStyle />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Due Amount">
                                                            <ItemTemplate>
                                                                <asp:Label ID="proplandueAmtM"
                                                                    Style="padding-left: 10px;"
                                                                    CssClass="txt_rupees rupees" runat="server"
                                                                    Text='<%# Bind("Manu_Balance") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle />
                                                            <ItemStyle />
                                                        </asp:TemplateField>--%>
                                                        <asp:TemplateField HeaderText="Action">
                                                            <ItemTemplate>
                                                                <%try {
                                                                    IsCancel=Convert.ToInt32(GrdProductsAmc.DataKeys[upplanindex].Values["IsCancel"].ToString());
                                                                    } catch { } if (IsCancel==1) {%>
                                                                    <asp:ImageButton CausesValidation="false"
                                                                        runat="server" ID="imgupdateplan"
                                                                        CommandArgument='<%# Bind("Trans_ID") %>'
                                                                        CommandName="UpgradePlan"
                                                                        ImageUrl="~/images/edit.png" />&nbsp;
                                                                    <asp:ImageButton CausesValidation="false"
                                                                        runat="server" ID="imgupdateplancan"
                                                                        CommandArgument='<%# Bind("Trans_ID") %>'
                                                                        CommandName="CancelPlan"
                                                                        ImageUrl="~/images/delete.png"
                                                                        ToolTip="Cancel" />
                                                                    <%} else { %>
                                                                        <asp:Label ID="lblccplancan" runat="server"
                                                                            Text="Cancelled"></asp:Label>
                                                                        <%} %>
                                                                            <%upplanindex++; %>
                                                            </ItemTemplate>
                                                            <HeaderStyle />
                                                            <ItemStyle />
                                                        </asp:TemplateField>
                                                </Columns>
                                                <PagerStyle />
                                                <RowStyle />
                                                <AlternatingRowStyle />
                                            </asp:GridView>
                                        </div>
                                        <hr />
                                        <table id="MyAmcOfferGrdVw" runat="server" width="100%">
                                            <tr>
                                                <td style="width: 25%; vertical-align: top;">
                                                    <asp:HiddenField ID="HdValAMC1" runat="server" />
                                                    <asp:HiddenField ID="HdDateTo1" runat="server" />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator5"
                                                        ValidationGroup="AMC" runat="server"
                                                        ControlToValidate="txtdtfromamc1"></asp:RequiredFieldValidator>
                                                    <strong><span class="astrics">*</span>Date From : -</strong><br />
                                                    <asp:TextBox ID="txtdtfromamc1"
                                                        onchange="FindNextDate12(this.value);" runat="server"
                                                        onkeydown="return checkShortcut();" CssClass="reg_txt">
                                                    </asp:TextBox><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator6"
                                                        runat="server" ControlToValidate="txtdttoamc1">
                                                    </asp:RequiredFieldValidator>
                                                    <strong><span class="astrics">*</span>Date To : -</strong><br />
                                                    <asp:TextBox ID="txtdttoamc1" Enabled="false" runat="server"
                                                        CssClass="reg_txt"></asp:TextBox><br />
                                                    <br />
                                                    <asp:Label ID="lblAmcText" runat="server" Style="font-size: 14px;">
                                                        Old Amc End Date :</asp:Label>
                                                    <br />
                                                    <asp:Label ID="lblAmcenddate" runat="server" Font-Bold="true"
                                                        Font-Size="12px" CssClass="astrics" Text=""></asp:Label>
                                                </td>
                                                <td style="width: 74%; vertical-align: top;">
                                                    <asp:GridView ID="GrdVwAmcRenewal" runat="server"
                                                        AutoGenerateColumns="False" DataKeyNames="Plan_ID,Disp"
                                                        CssClass="grid" EmptyDataText="Record Not Found"
                                                        EnableModelValidation="True" PageSize="5" Width="100%"
                                                        BorderStyle="None" BorderWidth="0px" BorderColor="Transparent">
                                                        <Columns>
                                                            <asp:TemplateField>
                                                                <ItemTemplate>
                                                                    <%try {
                                                                        PlanID=GrdVwAmcRenewal.DataKeys[upplanindex].Values["Plan_ID"].ToString();//LabelFlag
                                                                        Disp=Convert.ToInt32(GrdVwAmcRenewal.DataKeys[upplanindex].Values["Disp"].ToString());
                                                                        } catch { } if
                                                                        (Session["Plan_ID"].ToString()==PlanID) { if
                                                                        (Disp==0) { %>
                                                                        <input type="radio" id="Radio4" name="rdamcrew"
                                                                            checked="checked"
                                                                            value='<%# Eval("PlanInfo") %>'
                                                                            onclick="javascript: SelectSingleRadiobuttonNew12(this.id)" />
                                                                        <%} else { %>
                                                                            <input type="radio" id="Radio5"
                                                                                name="rdamcrew" checked="checked"
                                                                                disabled="disabled"
                                                                                value='<%# Eval("PlanInfo") %>'
                                                                                onclick="javascript: SelectSingleRadiobuttonNew12(this.id)" />
                                                                            <% } } else { if (Disp==0) {%>
                                                                                <input type="radio" id="rdamcrenewal123"
                                                                                    name="rdamcrew"
                                                                                    value='<%# Eval("PlanInfo") %>'
                                                                                    onclick="javascript: SelectSingleRadiobuttonNew12(this.id)" />
                                                                                <% } else {%>
                                                                                    <input type="radio" id="Radio6"
                                                                                        name="rdamcrew"
                                                                                        disabled="disabled"
                                                                                        value='<%# Eval("PlanInfo") %>'
                                                                                        onclick="javascript: SelectSingleRadiobuttonNew12(this.id)" />
                                                                                    <%} }%>
                                                                                        <%upplanindex++; %>
                                                                                            <asp:Label
                                                                                                ID="lblrenewalPlanID"
                                                                                                runat="server"
                                                                                                Text='<%# Bind("Plan_ID") %>'
                                                                                                Visible="false">
                                                                                            </asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle CssClass="tr_haed" />
                                                                <ItemStyle Width="5%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Plan Name">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblplanmanewithrenewal"
                                                                        runat="server" Text='<%# Bind("Plan_Name") %>'>
                                                                    </asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle />
                                                                <ItemStyle />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Amount">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblplanpricerenewal"
                                                                        Style="padding-left: 10px;"
                                                                        CssClass="txt_rupees rupees" runat="server"
                                                                        Text='<%# Bind("Plan_Amount") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle CssClass="tr_haed" Font-Size="12px" />
                                                                <ItemStyle HorizontalAlign="Right" Width="10%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Service Tax">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblplanrserprice"
                                                                        Style="padding-left: 10px;"
                                                                        CssClass="txt_rupees rupees" runat="server"
                                                                        Text='<%# Bind("STAX") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle CssClass="tr_haed" Font-Size="12px" />
                                                                <ItemStyle HorizontalAlign="Right" Width="15%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="VAT">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblplanrvatprice"
                                                                        Style="padding-left: 10px;"
                                                                        CssClass="txt_rupees rupees" runat="server"
                                                                        Text='<%# Bind("VTAX") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle CssClass="tr_haed" Font-Size="12px" />
                                                                <ItemStyle HorizontalAlign="Right" Width="15%" />
                                                            </asp:TemplateField>
                                                            <asp:TemplateField HeaderText="Net Amount">
                                                                <ItemTemplate>
                                                                    <asp:Label ID="lblplanrnetprice"
                                                                        Style="padding-left: 10px;"
                                                                        CssClass="txt_rupees rupees" runat="server"
                                                                        Text='<%# Bind("Plan_AmountN") %>'></asp:Label>
                                                                </ItemTemplate>
                                                                <HeaderStyle CssClass="tr_haed" Font-Size="12px" />
                                                                <ItemStyle HorizontalAlign="Right" Width="20%" />
                                                            </asp:TemplateField>
                                                        </Columns>
                                                        <EmptyDataRowStyle />
                                                        <PagerStyle CssClass="pagination" />
                                                        <RowStyle CssClass="tr_line1" />
                                                        <AlternatingRowStyle CssClass="tr_line2" />
                                                    </asp:GridView>
                                                    <cc1:CalendarExtender ID="CalendarerExtender3" runat="server"
                                                        TargetControlID="txtdtfromamc1" Format="dd/MM/yyyy">
                                                    </cc1:CalendarExtender>
                                                    <cc1:TextBoxWatermarkExtender ID="TextewrwBoxWatermarkExtender3"
                                                        runat="server" TargetControlID="txtdtfromamc1"
                                                        WatermarkText="From..">
                                                    </cc1:TextBoxWatermarkExtender>
                                                    <cc1:CalendarExtender ID="CalendarExerwtender4" runat="server"
                                                        TargetControlID="txtdttoamc1" Format="dd/MM/yyyy">
                                                    </cc1:CalendarExtender>
                                                    <cc1:MaskedEditExtender ID="MaskedEditwerweExtender4" runat="server"
                                                        TargetControlID="txtdttoamc1" Mask="99/99/9999" MaskType="Date">
                                                    </cc1:MaskedEditExtender>
                                                    <cc1:TextBoxWatermarkExtender ID="TextBowerxWatermarkExtender4"
                                                        runat="server" TargetControlID="txtdttoamc1"
                                                        WatermarkText="To..">
                                                    </cc1:TextBoxWatermarkExtender>
                                                </td>
                                            </tr>
                                        </table>
                                        <table width="100%" id="MyOfferGrdVw" runat="server">
                                            <tr>
                                                <td style="width: 25%; vertical-align: top;">
                                                    <asp:HiddenField ID="lblproidamc" runat="server" />
                                                    <asp:HiddenField ID="HdValAMC3" runat="server" />
                                                    <asp:HiddenField ID="HdDateTo3" runat="server" />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator3"
                                                        ValidationGroup="promo" runat="server"
                                                        ControlToValidate="txtdtfromamc3"></asp:RequiredFieldValidator>
                                                    <strong><span class="astrics">*</span>Date From : -</strong><br />
                                                    <asp:TextBox ID="txtdtfromamc3"
                                                        onchange="FindNextDatePromotionalNew(this.value);"
                                                        onkeydown="return checkShortcut();" runat="server"
                                                        CssClass="reg_txt"></asp:TextBox><br />
                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator9"
                                                        runat="server" ControlToValidate="txtdttoamc3">
                                                    </asp:RequiredFieldValidator>
                                                    <strong><span class="astrics">*</span>Date To : -</strong><br />
                                                    <asp:TextBox ID="txtdttoamc3" Enabled="false" runat="server"
                                                        CssClass="reg_txt"></asp:TextBox><br />
                                                    <span style="color: Red; font-size: 11px;">Please select Offer
                                                        period within AMC period
                                                        only. First finalize AMC Period.</span>
                                                    <br />
                                                    AMC Start Date :
                                                    <asp:Label ID="lblCurrAmcStartDate" runat="server"
                                                        Style="color: Blue; font-size: 12px;" />
                                                    <br />
                                                    AMC End Date :
                                                    <asp:Label ID="lblCurrAmcEndDate" runat="server"
                                                        Style="color: Blue; font-size: 12px;" />
                                                </td>
                                                <td>
                                                    <div style="overflow: auto; height: 150px;">
                                                        <asp:GridView ID="GrdVwOfferDetails" runat="server"
                                                            AutoGenerateColumns="False" DataKeyNames="Promo_ID,Disp"
                                                            CssClass="grid" EmptyDataText="Record Not Found"
                                                            EnableModelValidation="True" PageSize="5" Width="100%"
                                                            BorderStyle="None" BorderWidth="0px"
                                                            BorderColor="Transparent">
                                                            <Columns>
                                                                <asp:TemplateField>
                                                                    <ItemTemplate>
                                                                        <%try {
                                                                            PromoID=GrdVwOfferDetails.DataKeys[promoind].Values["Promo_ID"].ToString();
                                                                            Disp=Convert.ToInt32(GrdVwOfferDetails.DataKeys[promoind].Values["Disp"].ToString());
                                                                            } catch { } if
                                                                            (Session["PromoId"].ToString()==PromoID) {
                                                                            if (Disp==0) { %>
                                                                            <input type="radio" id="rdPromo"
                                                                                name="rdPromo" checked="checked"
                                                                                title='<%# Eval("Time_Days") %>'
                                                                                value='<%# Eval("Promo_ID") %>'
                                                                                onclick="javascript: SelectSinglePromotionalNew(this.id, this.title)" />
                                                                            <% } else {%>
                                                                                <input type="radio" id="rdPromon1"
                                                                                    name="rdPromo" disabled="disabled"
                                                                                    checked="checked"
                                                                                    title='<%# Eval("Time_Days") %>'
                                                                                    value='<%# Eval("Promo_ID") %>'
                                                                                    onclick="javascript: SelectSinglePromotionalNew(this.id, this.title)" />
                                                                                <%} } else { if (Disp==0) { %>
                                                                                    <input type="radio" id="rdPromo2"
                                                                                        name="rdPromo"
                                                                                        title='<%# Eval("Time_Days") %>'
                                                                                        value='<%# Eval("Promo_ID") %>'
                                                                                        onclick="javascript: SelectSinglePromotionalNew(this.id, this.title)" />
                                                                                    <% } else { %>
                                                                                        <input type="radio"
                                                                                            id="rdPromon2"
                                                                                            name="rdPromo"
                                                                                            title='<%# Eval("Time_Days") %>'
                                                                                            disabled="disabled"
                                                                                            value='<%# Eval("Promo_ID") %>'
                                                                                            onclick="javascript: SelectSinglePromotionalNew(this.id, this.title)" />
                                                                                        <% } } %>
                                                                                            <%promoind++; %>
                                                                                                <asp:Label
                                                                                                    ID="lblPromoPlanID"
                                                                                                    runat="server"
                                                                                                    Text='<%# Bind("Promo_ID") %>'
                                                                                                    Visible="false">
                                                                                                </asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" />
                                                                    <ItemStyle Width="5%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Promotional Plan Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblPromoplnNm" runat="server"
                                                                            Text='<%# Bind("Promo_Name") %>'>
                                                                        </asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle />
                                                                    <ItemStyle />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Time(In Days)">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblPromoplnNm" runat="server"
                                                                            Text='<%# Bind("Time_Days") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle />
                                                                    <ItemStyle />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Amount">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblPromoAmt"
                                                                            Style="padding-left: 10px;"
                                                                            CssClass="txt_rupees rupees" runat="server"
                                                                            Text='<%# Bind("Amount") %>'></asp:Label>
                                                                        +(Applicable Tax)
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" Font-Size="12px" />
                                                                    <ItemStyle Width="25%" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <EmptyDataRowStyle />
                                                            <PagerStyle CssClass="pagination" />
                                                            <RowStyle CssClass="tr_line1" />
                                                            <AlternatingRowStyle CssClass="tr_line2" />
                                                        </asp:GridView>
                                                        <cc1:CalendarExtender ID="CalendarExtender5" runat="server"
                                                            TargetControlID="txtdtfromamc3" Format="dd/MM/yyyy">
                                                        </cc1:CalendarExtender>
                                                        <%-- <cc1:MaskedEditExtender ID="MaskedEditExtender5"
                                                            runat="server" TargetControlID="txtdtfromamc3"
                                                            Mask="99/99/9999" MaskType="Date">
                                                            </cc1:MaskedEditExtender>--%>
                                                            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender5"
                                                                runat="server" TargetControlID="txtdtfromamc3"
                                                                WatermarkText="From..">
                                                            </cc1:TextBoxWatermarkExtender>
                                                            <cc1:CalendarExtender ID="CalendarExtender6" runat="server"
                                                                TargetControlID="txtdttoamc3" Format="dd/MM/yyyy">
                                                            </cc1:CalendarExtender>
                                                            <cc1:MaskedEditExtender ID="MaskedEditExtender6"
                                                                runat="server" TargetControlID="txtdttoamc3"
                                                                Mask="99/99/9999" MaskType="Date">
                                                            </cc1:MaskedEditExtender>
                                                            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender6"
                                                                runat="server" TargetControlID="txtdttoamc3"
                                                                WatermarkText="To..">
                                                            </cc1:TextBoxWatermarkExtender>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <fieldset class="Newfield">
                                                        <legend>Message</legend>
                                                        <table width="100%">
                                                            <tr>
                                                                <td align="right" style="width: 25%;">
                                                                    <asp:RequiredFieldValidator
                                                                        ID="RequiredFieldValidator12" runat="server"
                                                                        ForeColor="Red" ValidationGroup="promo"
                                                                        ControlToValidate="txtComment">
                                                                    </asp:RequiredFieldValidator>
                                                                    <asp:CheckBox ID="chkComments" runat="server"
                                                                        Text="  Use Old"
                                                                        onchange="javascript:chkuseoldcomments();" />
                                                                    <strong><span class="astrics">*</span> Message
                                                                        :</strong>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtComment" MaxLength="100"
                                                                        TextMode="MultiLine" Width="95%" Height="30px"
                                                                        CssClass="textbox_pop"
                                                                        onkeyDown="return checkTextAreaMaxLength(this,event,'25');"
                                                                        runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td></td>
                                                                <td class="astrics">Comment should be in 25 character
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <fieldset class="Newfield">
                                                        <legend>Message Audio Files(*.wav)</legend>
                                                        <table width="98%" cellpadding="0" cellspacing="2">
                                                            <tr>
                                                                <td></td>
                                                                <td></td>
                                                                <td></td>
                                                                <td></td>
                                                                <td></td>
                                                                <td>
                                                                    <asp:Label ID="Label13" runat="server"
                                                                        Style="color: Red; font-family: Arial; font-size: 12px;">
                                                                    </asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr style="display: none;">
                                                                <td colspan="3" align="left">
                                                                    <asp:CheckBox ID="CheckBox1" runat="server"
                                                                        Text="  Use Old"
                                                                        onchange="chkuseoldsoundh();" />
                                                                </td>
                                                                <td colspan="3" align="left">
                                                                    <asp:CheckBox ID="CheckBox2" Text="   Use Old"
                                                                        runat="server" onchange="chkuseoldsounde();" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right" style="width: 8%">
                                                                    <asp:RequiredFieldValidator
                                                                        ID="RequiredFieldValidator10" runat="server"
                                                                        ForeColor="Red" ValidationGroup="promo"
                                                                        ControlToValidate="flSoundPH">
                                                                    </asp:RequiredFieldValidator>
                                                                    <strong><span class="astrics">*</span> Hindi
                                                                        :</strong>
                                                                </td>
                                                                <td style="width: 35%">
                                                                    <asp:FileUpload ID="flSoundPH"
                                                                        onchange="fileTypeCheckengH(this.value);"
                                                                        runat="server" Style="width: 88%;" />
                                                                </td>
                                                                <td align="right" style="width: 5%">
                                                                    <ul class="graphic">
                                                                        <li><a id="A1" runat="server" class="sm2_link"
                                                                                target="_blank" title="Hindi File play"
                                                                                style="cursor: pointer; display: none;"></a>
                                                                        </li>
                                                                    </ul>
                                                                </td>
                                                                <td align="right" style="width: 10%">
                                                                    <asp:RequiredFieldValidator
                                                                        ID="RequiredFieldValidator11" runat="server"
                                                                        ForeColor="Red" ValidationGroup="promo"
                                                                        ControlToValidate="flSoundPE">
                                                                    </asp:RequiredFieldValidator>
                                                                    <strong><span class="astrics">*</span> English
                                                                        :</strong>
                                                                </td>
                                                                <td style="width: 35%">
                                                                    <asp:FileUpload ID="flSoundPE"
                                                                        onchange="fileTypeCheckengE(this.value);"
                                                                        runat="server" Style="width: 88%;" />
                                                                </td>
                                                                <td>
                                                                    <ul class="graphic">
                                                                        <li><a id="A2" runat="server" target="_blank"
                                                                                class="sm2_link"
                                                                                title="English File play"
                                                                                style="cursor: pointer; display: none;"></a>
                                                                        </li>
                                                                    </ul>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td></td>
                                                                <td>
                                                                    <asp:Label ID="Label16" runat="server"
                                                                        Style="color: Red; font-family: Arial; font-size: 12px;">
                                                                    </asp:Label>
                                                                </td>
                                                                <td></td>
                                                                <td>
                                                                    <asp:Label ID="Label17" runat="server"
                                                                        Style="color: Red; font-family: Arial; font-size: 12px;">
                                                                    </asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td colspan="2" style="height: 10px;"></td>
                                            </tr>
                                            <tr>
                                                <td colspan="2">
                                                    <asp:Label ID="Label18"
                                                        Style="font-family: Arial; font-size: 12px; color: red;"
                                                        runat="server"
                                                        Text="Note:- Audio file to be uploaded on the website should be in the prescribed format as below">
                                                    </asp:Label>
                                                    <br />
                                                    <asp:Label ID="Label19"
                                                        Style="font-family: Arial; font-size: 12px; color: red;"
                                                        runat="server" Text="File Type ---- .wav"></asp:Label>
                                                    <br />
                                                    <asp:Label ID="Label20"
                                                        Style="font-family: Arial; font-size: 12px; color: red;"
                                                        runat="server" Text="Format ---- 8KHz, 16bit mono"></asp:Label>
                                                    <br />
                                                    <asp:Label ID="Label21"
                                                        Style="font-family: Arial; font-size: 12px; color: red;"
                                                        runat="server" Text="Bit Rate ---- 128 kbps"></asp:Label>
                                                    <br />
                                                    <asp:Label ID="Label22"
                                                        Style="font-family: Arial; font-size: 12px; color: Blue;"
                                                        runat="server"
                                                        Text="For record the audio file, Please click the link ">
                                                    </asp:Label>&nbsp;
                                                    <a href="http://wavepad.en.softonic.com/"
                                                        style="font-family: Arial; font-size: 12px; color: Blue;"
                                                        target="_blank">Click</a>
                                                </td>
                                            </tr>
                                        </table>
                                        <table style="text-align: right !important; width: 100%;">
                                            <tr>
                                                <td style="text-align: right !important;">
                                                    <asp:Button ID="btnAmcRenewal" ValidationGroup="AMC" runat="server"
                                                        OnClick="btnAmcRenewal_Click" CssClass="button_all"
                                                        Text="Save" />
                                                    <asp:Button ID="btnOfferRenewal" runat="server"
                                                        OnClick="btnOfferRenewal_Click" CssClass="button_all"
                                                        Text="Save" ValidationGroup="promo" Visible="false" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <cc1:ModalPopupExtender ID="ModalPopupAmcRenewal" runat="server"
                            BackgroundCssClass="NewmodalBackground" PopupControlID="PanelAmcRenewal"
                            TargetControlID="LabelAmcRenewalT" CancelControlID="btnAmcRenewalpopClose">
                        </cc1:ModalPopupExtender>
                        <asp:Label ID="LabelAmcRenewalT" runat="server"></asp:Label>
                        <asp:Panel ID="PanelPopupCancelRequest" runat="server" Width="25%" Style="display: none;">
                            <div class="popupContent" style="width: 100%;">
                                <div class="pop_log_bg">
                                    <div>
                                        <asp:Button ID="BtnClosePopupRequest" CssClass="popupClose" runat="server" />
                                    </div>
                                    <div class="service_head_p">
                                        <p>
                                            <span class="left">
                                                <asp:Label ID="Label5" runat="server" Font-Bold="true"
                                                    Text="Confirmmation"></asp:Label>
                                            </span>
                                        </p>
                                    </div>
                                    <div class="regis_popup">
                                        <table>
                                            <tr>
                                                <td style="width: 25%; vertical-align: top;">
                                                    <asp:Label ID="lblTextAlert" runat="server"></asp:Label>
                                                    <br />
                                                </td>
                                            </tr>
                                            <tr>
                                                <td align="center">
                                                    <asp:Button ID="btnYesConfirm" runat="server" CssClass="button_all"
                                                        OnClick="btnYesConfirm_Click" CausesValidation="false"
                                                        Text="Yes" />&nbsp;&nbsp;&nbsp;
                                                    <asp:Button CssClass="button_all" ID="btnNoConfirm" runat="server"
                                                        Text="No" CausesValidation="false" />
                                                </td>
                                            </tr>
                                        </table>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <cc1:ModalPopupExtender ID="ModalPopupCancelRequest" runat="server"
                            BackgroundCssClass="NewmodalBackground" BehaviorID="CancelPendingRequest"
                            PopupControlID="PanelPopupCancelRequest" TargetControlID="Label12Request"
                            CancelControlID="BtnClosePopupRequest" OkControlID="btnNoConfirm">
                        </cc1:ModalPopupExtender>
                        <asp:Label ID="Label12Request" runat="server"></asp:Label>
                        <!---**************Start popup fot Offer Cancel**************** -->
                        <asp:Panel ID="PanelPopupCancelOffer" runat="server" Width="25%" Style="display: none;">
                            <div class="popupContent" style="width: 100%;">
                                <div class="pop_log_bg">
                                    <div>
                                        <asp:Button ID="BtnClosePopupOffer" CssClass="popupClose" runat="server" />
                                    </div>
                                    <div class="service_head_p">
                                        <p>
                                            <span class="left">
                                                <asp:Label ID="lblBeyondOffer" runat="server" Font-Bold="true"
                                                    Text="Confirmmation"></asp:Label>
                                            </span>
                                        </p>
                                    </div>
                                    <div class="regis_popup">
                                        <asp:GridView ID="GrdVwBeyondOffer" runat="server" AutoGenerateColumns="False"
                                            CssClass="grid" DataKeyNames="Trans_Type" EmptyDataText="Record Not Found"
                                            EmptyDataRowStyle EnableModelValidation="True" Width="100%"
                                            BorderStyle="None" BorderWidth="0" BorderColor="transparent"
                                            OnRowCommand="GrdProductsAmc_RowCommand">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Amc Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="proAmcType" runat="server"
                                                            Text='<%# Bind("Plan_Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle />
                                                    <ItemStyle HorizontalAlign="Left" CssClass="grd_pad" Width="15%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Plan Amount">
                                                    <ItemTemplate>
                                                        <asp:Label ID="proplanAmt" Style="padding-left: 10px;"
                                                            CssClass="txt_rupees rupees" runat="server"
                                                            Text='<%# Bind("Plan_Amount") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle />
                                                    <ItemStyle HorizontalAlign="Left" CssClass="grd_pad" Width="15%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Status">
                                                    <ItemTemplate>
                                                        <asp:Label ID="proplanvrstatus" runat="server"
                                                            Text='<%# Bind("Status") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle />
                                                    <ItemStyle HorizontalAlign="Left" Width="12%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Start Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="proplanstdate" runat="server"
                                                            Text='<%# Bind("Date_From") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle />
                                                    <ItemStyle HorizontalAlign="Left" Width="12%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="End Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="proplanenddate" runat="server"
                                                            Text='<%# Bind("Date_To") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle />
                                                    <ItemStyle HorizontalAlign="Left" Width="12%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Discount">
                                                    <ItemTemplate>
                                                        <asp:Label ID="LblAmcdisprices" Style="padding-left: 10px;"
                                                            CssClass="txt_rupees rupees" runat="server"
                                                            Text='<%# Bind("Plan_Discount") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <HeaderStyle CssClass="tr_haed" />
                                                    <ItemStyle Width="10%" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <PagerStyle CssClass="pagination" />
                                            <RowStyle CssClass="tr_line1" />
                                            <AlternatingRowStyle CssClass="tr_line2" />
                                        </asp:GridView>
                                        <div>
                                            <asp:Button ID="btnbeyondoffer" runat="server" CssClass="button_all"
                                                OnClick="btnbeyondoffer_Click" CausesValidation="false"
                                                Text="Cancelled All Offer" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <cc1:ModalPopupExtender ID="ModalPopupCancelOffer" runat="server"
                            BackgroundCssClass="NewmodalBackground" BehaviorID="CancelBeyondOffer"
                            PopupControlID="PanelPopupCancelOffer" TargetControlID="Label12CancelOffer"
                            CancelControlID="BtnClosePopupOffer" OkControlID="BtnClosePopupOffer">
                        </cc1:ModalPopupExtender>
                        <asp:Label ID="Label12CancelOffer" runat="server"></asp:Label>
                        <!---**************End popup fot Offer Cancel**************** -->
                    </ContentTemplate>
                </asp:UpdatePanel>
                <!--PopUp Close-->
                <!-------------------Start Popup--------------->
                <asp:Panel ID="GivenGracePanel" runat="server" Width="25%" Style="display: none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnpopplancan" CssClass="popupClose" runat="server" />
                            </div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="GPHeadLabel" runat="server" Font-Bold="true"></asp:Label>
                                    </span>
                                </p>
                            </div>
                            <div class="regis_popup">
                                <table id="details" runat="server">
                                    <tr>
                                        <td style="width: 30%; text-align: right;">
                                            <strong>Start Date : </strong>
                                        </td>
                                        <td style="width: 25%; vertical-align: top;">
                                            <asp:Label ID="lblstdate" runat="server"></asp:Label>
                                            <br />
                                        </td>
                                        <td style="width: 30%; text-align: right;">
                                            <strong>End Date : </strong>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblenddate" runat="server"></asp:Label>&nbsp;
                                        </td>
                                    </tr>
                                </table>
                                <table style="width: 100%;" id="Table1" runat="server">
                                    <tr>
                                        <td colspan="4" align="center">
                                            <asp:Label ID="lblMsgAlert" runat="server" />
                                        </td>
                                    </tr>
                                    <tr id="remarks" runat="server">
                                        <td style="width: 30%; vertical-align: top; text-align: right;">
                                            <strong>Remarks : </strong>
                                        </td>
                                        <td colspan="3">
                                            <asp:TextBox ID="txtremarks" TextMode="MultiLine" Width="98%" runat="server"
                                                onkeyDown="return checkTextAreaMaxLength(this,event,'150');">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                </table>
                                <table style="width: 100%;">
                                    <tr>
                                        <td align="center" colspan="4">
                                            <asp:Button ID="btnYes" runat="server" CssClass="button_all"
                                                OnClick="btnYes_Click" CausesValidation="false" Text="OK" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupForGp" runat="server" BackgroundCssClass="NewmodalBackground"
                    PopupControlID="GivenGracePanel" TargetControlID="Label15" CancelControlID="btnpopplancan">
                </cc1:ModalPopupExtender>
                <asp:Label ID="Label15" runat="server"></asp:Label>
                <asp:Label ID="LabelExectute" runat="server" Visible="false"></asp:Label>
                <!-------------------End Popup--------------->
                <!-------------------Start Loyalty Popup--------------->
                <asp:Panel ID="AddLoyaltyPanel" runat="server" Width="30%" Style="display: none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btncloseloyalty" CssClass="popupClose" runat="server" />
                            </div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="Lblloyaltyhead" runat="server" Font-Bold="true"></asp:Label>
                                    </span>
                                </p>
                            </div>
                            <div class="regis_popup">
                                <table cellpadding="0px" cellspacing="10px" width="100%" class="grid"
                                    style="line-height: 25px; padding: 10px;">
                                    <tr style="display: none;">
                                        <td style="width: 30%; text-align: right;">
                                            <strong>Loyalty : </strong><span class="astrics">*</span>
                                        </td>
                                        <td style="vertical-align: top;">
                                            <asp:CheckBox runat="server" ValidationGroup="LOY" ID="chkloyalty"
                                                Text="    Loyalty Required" Checked="true" />
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%; text-align: right;">
                                            <strong>Points : </strong><span class="astrics">*</span>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtloyaltypoints" Width="75px" CssClass="reg_txt"
                                                runat="server"
                                                onkeyDown="return checkTextAreaMaxLength(this,event,'5');">
                                            </asp:TextBox>
                                            &nbsp;&nbsp;
                                            <asp:CheckBox runat="server" ValidationGroup="LOY" ID="chkconvert"
                                                Text="     Convert to Cash" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="text-align: right;">
                                            <strong>Date From : </strong>
                                            <%--<span class="astrics">*</span>--%>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtloyaltydtfrom" Width="120px" CssClass="reg_txt"
                                                runat="server"
                                                onkeyDown="return checkTextAreaMaxLength(this,event,'5');">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%; text-align: right;">
                                            <strong>Date To : </strong>
                                            <%--<span class="astrics">*</span>--%>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtloyaltydtto" Width="120px" CssClass="reg_txt"
                                                runat="server"
                                                onkeyDown="return checkTextAreaMaxLength(this,event,'5');">
                                            </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="width: 30%; text-align: right;">
                                            <strong>Status : </strong>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <asp:CheckBox ID="chkIsActive" runat="server" Text="  IsActive" />
                                            &nbsp;&nbsp;&nbsp;&nbsp;
                                            <asp:CheckBox ID="chkIsDelete" runat="server" Text="  IsDelete" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="2">
                                            <asp:Button ID="btnloyaltysaveupdate" runat="server" CssClass="button_all"
                                                OnClick="btnLoyalty_Click" CausesValidation="false" Text="OK" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <cc1:CalendarExtender ID="CalendarExtender7" runat="server"
                                                TargetControlID="txtloyaltydtfrom" Format="dd/MM/yyyy">
                                            </cc1:CalendarExtender>
                                            <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server"
                                                TargetControlID="txtloyaltydtfrom" Mask="99/99/9999" MaskType="Date">
                                            </cc1:MaskedEditExtender>
                                            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender7" runat="server"
                                                TargetControlID="txtloyaltydtfrom" WatermarkText="Date From..">
                                            </cc1:TextBoxWatermarkExtender>
                                            <cc1:CalendarExtender ID="CalendarExtender8" runat="server"
                                                TargetControlID="txtloyaltydtto" Format="dd/MM/yyyy">
                                            </cc1:CalendarExtender>
                                            <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server"
                                                TargetControlID="txtloyaltydtto" Mask="99/99/9999" MaskType="Date">
                                            </cc1:MaskedEditExtender>
                                            <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender8" runat="server"
                                                TargetControlID="txtloyaltydtto" WatermarkText="Date To..">
                                            </cc1:TextBoxWatermarkExtender>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupLoyalty" runat="server" BackgroundCssClass="NewmodalBackground"
                    PopupControlID="AddLoyaltyPanel" TargetControlID="LblTargetLoyalty"
                    CancelControlID="btncloseloyalty">
                </cc1:ModalPopupExtender>
                <asp:Label ID="LblTargetLoyalty" runat="server"></asp:Label>
                <asp:HiddenField ID="hdnloyalty" runat="server" />
            </div>

            <script type="text/javascript">
                function performSearch(searchText) {
                    $('#ctl00_ContentPlaceHolder1_GrdProductMaster tbody tr').each(function () {
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
            <script>
                // Get all audio elements
                var audioElements = document.querySelectorAll('.audio-element');

                // Add event listeners to each play button and each audio element
                var playButtons = document.querySelectorAll('.play-button');
                playButtons.forEach(function (button, index) {
                    button.addEventListener('click', function () {
                        togglePlay(index);
                    });
                });

                audioElements.forEach(function (audio, index) {
                    audio.addEventListener('ended', function () {
                        resetIcon(index);
                    });
                    audio.addEventListener('click', function () {
                        togglePlay(index);
                    });
                });

                // Function to toggle play/pause for a specific audio element
                function togglePlay(index) {
                    var audio = audioElements[index];
                    var icon = playButtons[index].querySelector('i');

                    // Pause all other audio elements
                    audioElements.forEach(function (element, i) {
                        if (i !== index && !element.paused) {
                            element.pause();
                            resetIcon(i);
                        }
                    });

                    // Toggle play/pause for the clicked audio element
                    if (audio.paused) {
                        audio.play();
                        icon.classList.remove('bx-play-circle');
                        icon.classList.add('bx-pause-circle');
                    } else {
                        audio.pause();
                        resetIcon(index);
                    }
                }

                // Function to reset icon to play icon when audio ends or is paused
                function resetIcon(index) {
                    var icon = playButtons[index].querySelector('i');
                    icon.classList.remove('bx-pause-circle');
                    icon.classList.add('bx-play-circle');
                }
            </script>




        </asp:Content>