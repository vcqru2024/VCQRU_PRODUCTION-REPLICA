<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true"
    CodeFile="ProductDetails.aspx.cs" Inherits="Patanjali_ProductDetails" %>


    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

        <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

            <script type="text/javascript">
                $(document).ready(function () {

                    $(".accordion2 p").eq(6).addClass("active");
                    $(".accordion2 div.open").eq(4).show();

                    $(".accordion2 p").click(function () {
                        $(this).next("div.open").slideToggle("slow")
                            .siblings("div.open:visible").slideUp("slow");
                        $(this).toggleClass("active");
                        $(this).siblings("p").removeClass("active");
                    });

                });
            </script>

            <script language="javascript" type="text/javascript">
                function fileTypeCheckeng(mm) {
                    PageMethods.checkFile(mm, onengcheck)
                }


                function fileTypeCheckengE(mm) {
                    PageMethods.checkFile(mm, onengcheckE)
                }


                function checkproduct(vl) {
                    PageMethods.checkNewProduct(vl, onCompleteProduct)
                }



            </script>

        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

            <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0px; height: 1507px; width: 100%;
                        top: -70px; z-index: 100001;" class="NewmodalBackground">
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
                            <h5>Product Details</h5>
                        </div>
                        <div class="col">
                            <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                   <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a></li>

                                    <li class="breadcrumb-item active" aria-current="page">Product Details</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
                <div class="user-role-card">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col col-md-4 mb-3">
                                    <div class="global-search">
                                        <div class="form-group ">
                                   <input type="search" class="form-control" onkeyup="performSearch(this.value)" placeholder="Search">
                                            <span><i class="fa fa-search"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col mb-3">
                                    <ul class="action-button-global">

                                        <li>
                                            <a href="AddProductDetails.aspx" class="btn btn-sm btn-primary"><i
                                                    class='bx bx-plus'></i>Add Product Details</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <div class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-3"
                                id="BigpopMsg" runat="server">
                                <p>
                                    <asp:Label ID="Label2" runat="server"></asp:Label>
                                </p>
                            </div>
                            <div class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-3">
                                <asp:Label ID="Label3" runat="server"
                                    Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>

                            </div>
                            <div class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-3"
                                id="NewMsgpop" runat="server">
                                <p>

                                </p>
                            </div>

                            <div class="row">

                                <div class="col">
                                    <label for="Product Name" class="form-label">Product Name</label>
                                    <asp:TextBox ID="txtProductName" runat="server" Text="" CssClass="form-control"
                                        placeholder="Product Name"></asp:TextBox>
                                </div>
                                <div class="col">
                                    <label for="Product Description" class="form-label">Mfd Date From</label>

                                    <asp:TextBox ID="txtDateFrom" runat="server" CssClass="form-control"
                                        placeholder="Mfd Date From"></asp:TextBox>

                                </div>
                                <div class="col">
                                    <label for="Dispatch Location" class="form-label">Mfd Date To</label>
                                    <asp:TextBox ID="txtDateTo" runat="server" CssClass="form-control"
                                        placeholder="Mfd Date To"></asp:TextBox>
                                </div>



                                <div class="col">
                                    <asp:Button ID="btnSearch" style="margin-top:10%;" OnClick="btnSearch_Click"
                                        ValidationGroup="chk94" class="btn btn-primary" runat="server" Text="Search" />

                                    <asp:Button ID="btnRefresh" style="margin-top:10%;" OnClick="btnRefresh_Click"
                                        class="btn btn-success" runat="server" CausesValidation="false" Text="Reset" />
                                </div>

                            </div>

                            <div class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-3"
                                id="newmsg" runat="server">
                                <p>
                                    <asp:Label ID="lblmsgHeader" runat="server"></asp:Label>
                                </p>
                            </div>

                            <div class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-3">
                                <asp:HiddenField ID="HDF" runat="server"></asp:HiddenField>

                                <div class="col-lg-8">
                                    <h5 class="mb-0">Record(s) found<span> (<asp:Label ID="lblcount" runat="server">
                                            </asp:Label>)</span></h5>
                                </div>
                                <div class="col-lg-2">
                                    <asp:Label ID="lblToatalCashPoints" runat="server"></asp:Label>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblToatalPoints" runat="server">
                                    </asp:Label>
                                </div>
                                <div class="col-lg-2">
                                    <asp:DropDownList ID="ddlRowProductCnt" runat="server" CssClass="form-control"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlRowsShow_SelectedIndexChanged">
                                        <asp:ListItem Value="25">25 Rows</asp:ListItem>
                                        <asp:ListItem Value="50">50 Rows</asp:ListItem>
                                        <asp:ListItem Value="100">100 Rows</asp:ListItem>
                                        <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                        <asp:ListItem Value="1000">1000 Rows</asp:ListItem>
                                        <asp:ListItem Value="1001">All Rows</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="app-table mt-3">
                                <div class="table-responsive">
                                    <asp:GridView ID="GrdProductMaster" runat="server" AutoGenerateColumns="False"
                                        CssClass="table table-bordered table-hover mb-0" EmptyDataText="Record Not Found"
                                        OnRowCommand="GrdProductMaster_RowCommand"
                                        OnPageIndexChanging="GrdProductMaster_PageIndexChanging">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Product Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblactudate12" runat="server"
                                                        Text='<%# Bind("Pro_Name") %>'></asp:Label>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Batch No">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblactudate123nEW" runat="server"
                                                        Text='<%# Bind("Batch_No") %>'></asp:Label>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="No of Codes">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblactudate1234" runat="server"
                                                        Text='<%# Bind("NoofCodes") %>'></asp:Label>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="MRP">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblactudate21" runat="server"
                                                        Text='<%# Bind("MRP") %>'></asp:Label>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Mfd Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblactudate22" runat="server"
                                                        Text='<%# Bind("Mfd_Date","{0:dd/MM/yyyy}") %>'></asp:Label>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Exp_Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblactudate234" runat="server"
                                                        Text='<%# Bind("Exp_Date","{0:dd/MM/yyyy}") %>'></asp:Label>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                <ItemStyle/>
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Pasted Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblpastede234" runat="server"
                                                        Text='<%# Bind("Entry_Date","{0:dd/MM/yyyy}") %>'></asp:Label>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Audio">
                                                 <ItemTemplate>
                                                            <audio class="audio-element" src='<%# Eval("SoundPath_H") %>'
                                                                onended="resetPlayIcon()"></audio>
                                                            <button type="button"
                                                                class="play-button btn btn-sm p-0 border-0"
                                                                onclick="togglePlay(this)">
                                                                <i class='bx bx-play-circle fs-5'></i>
                                                            </button>
                                                            
                                                        </ItemTemplate>
                                                <%--<ItemTemplate>
                                                    <a href='<%# Eval("SoundPath_H") %>'>play</a>
                                                </ItemTemplate>--%>
                                                <%--<HeaderStyle CssClass="tr_haed bord_left"
                                                    HorizontalAlign="Center" />--%>
                                                <ItemStyle/>
                                            </asp:TemplateField>

                                            <%--<asp:TemplateField HeaderText="English">
                                                <ItemTemplate>
                                                    <a href='<%# Eval("SoundPath_E") %>'></a>
                                                </ItemTemplate>
                                               
                                                <ItemStyle />
                                            </asp:TemplateField>--%>

                                            <asp:TemplateField HeaderText="Action">
                                                <%--Excel--%>
                                                    <ItemTemplate>
                                                        <asp:ImageButton ID="btnChangeBatchInfo" runat="server"
                                                            CausesValidation="false"
                                                            CommandArgument='<%#Bind("Row_ID") %>'
                                                            CommandName="ChangeBatchInfo"
                                                            ImageUrl="~/Content/images/edit.png" ToolTip="Edit" />
                                                        <asp:ImageButton ID="imgdwnExcel" runat="server"
                                                            CausesValidation="false"
                                                            CommandArgument='<%#Bind("Row_ID") %>'
                                                            CommandName="DownLodExcel"
                                                            ImageUrl="~/Content/images/download.png"
                                                            ToolTip="Download Excel File" />
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed bord_left"
                                                        HorizontalAlign="Center" />--%>
                                                    <ItemStyle/>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                        <!--PopUp Starts-->
                        <asp:Panel ID="PanelProductDetails" runat="server" Width="36%" Style="display: none;">
                            <div class="popupContent" style="width: 100%;">
                                <div class="pop_log_bg">
                                    <div>
                                        <asp:Button ID="Button1" CssClass="popupClose" runat="server" />
                                    </div>
                                    <!--<fieldset class="service_field" >-->
                                    <div class="service_head_p">
                                        <p>
                                            <span class="left">
                                                <asp:Label ID="lblheading" Font-Bold="true" runat="server"></asp:Label>
                                                <asp:Label ID="lblSame" runat="server" Visible="false"></asp:Label>
                                                &nbsp;&nbsp;
                                            </span><span class="right"><span
                                                    class="astrics"><strong>*</strong></span><em>
                                                    indicates
                                                    mandatory fields</em></span>
                                        </p>
                                    </div>
                                    <div class="regis_popup">
                                        <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                            <tr id="trtr">
                                                <td>
                                                    <div id="DivNewMsg" runat="server">
                                                        <p>
                                                            <asp:Label ID="LblMsg" runat="server"></asp:Label>
                                                        </p>
                                                    </div>
                                                    <div id="Div1" runat="server">
                                                        <p>
                                                            <asp:Label ID="Label4" runat="server"></asp:Label>
                                                        </p>
                                                    </div>
                                                    <div id="Div2" runat="server" style="width: 86% !important;">
                                                        <p>
                                                            <asp:Label ID="lblpopmsg" runat="server"></asp:Label>
                                                        </p>
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <fieldset class="Newfield">
                                                        <legend><span id="Label782">General Info</span></legend>
                                                        <table width="98%" cellpadding="0" cellspacing="2">
                                                            <tr>
                                                                <td align="right">
                                                                    <asp:RequiredFieldValidator
                                                                        ID="RequiredFieldValidator2" runat="server"
                                                                        InitialValue="--Select--" ForeColor="Red"
                                                                        ValidationGroup="PRO"
                                                                        ControlToValidate="ddlProduct">
                                                                    </asp:RequiredFieldValidator>
                                                                    <strong><span class="astrics">*</span> Product Name
                                                                        :</strong>
                                                                </td>
                                                                <td>
                                                                    <asp:DropDownList ID="ddlProduct" runat="server"
                                                                        CssClass="drp" Width="95%"
                                                                        Style="text-transform: capitalize;"
                                                                        AutoPostBack="true"
                                                                        OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged">
                                                                        <%-- onchange="WriteProID(this.value)"
                                                                            OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged"
                                                                            AutoPostBack="true" --%>
                                                                    </asp:DropDownList>
                                                                    <%--<cc1:ListSearchExtender
                                                                        ID="ListSearchExtendertrade1"
                                                                        PromptCssClass="drp"
                                                                        TargetControlID="ddlProduct" runat="server"
                                                                        PromptPosition="Top">
                                                                        </cc1:ListSearchExtender>--%>
                                                                </td>
                                                                <td align="right">
                                                                    <asp:RequiredFieldValidator
                                                                        ID="RequiredFieldValidatorNew3" runat="server"
                                                                        ForeColor="Red" ValidationGroup="PRO"
                                                                        ControlToValidate="LblAvlCodes">
                                                                    </asp:RequiredFieldValidator>
                                                                    <strong><span class="astrics">*</span> No. Of
                                                                        Available
                                                                        Codes :</strong>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="LblAvlCodes" MaxLength="50"
                                                                        Width="91%" Enabled="false" ForeColor="Red"
                                                                        CssClass="textbox_pop" Height="17px"
                                                                        runat="server">
                                                                    </asp:TextBox>
                                                                    <asp:HiddenField ID="HdnAvlCodes" runat="server" />
                                                                    <asp:HiddenField ID="HdnSeriesIni" runat="server" />
                                                                    <asp:HiddenField ID="HdnBatchSize" runat="server" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right">
                                                                    <asp:RequiredFieldValidator
                                                                        ID="RequiredFieldValidator3" runat="server"
                                                                        ForeColor="Red" ValidationGroup="PRO"
                                                                        ControlToValidate="txtBatchNo">
                                                                    </asp:RequiredFieldValidator>
                                                                    <strong><span id="btn" runat="server"
                                                                            class="astrics">*</span> Batch No :</strong>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtBatchNo" MaxLength="10"
                                                                        Width="91%" CssClass="textbox_pop"
                                                                        runat="server"
                                                                        onchange="CheckBatch_NoVal(this.value)">
                                                                    </asp:TextBox>
                                                                </td>
                                                                <td align="right">
                                                                    <asp:RequiredFieldValidator
                                                                        ID="RequiredFieldValidator4" runat="server"
                                                                        ForeColor="Red" ValidationGroup="PRO"
                                                                        ControlToValidate="txtMRP">
                                                                    </asp:RequiredFieldValidator>
                                                                    <strong><span id="mrp" runat="server"
                                                                            class="astrics">*</span> MRP :</strong>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtMRP" Width="91%"
                                                                        CssClass="textbox_pop" runat="server"
                                                                        MaxLength="7"
                                                                        OnKeyPress="return isNumberKey(this, event);"
                                                                        onchange="mathRoundForTaxes(this.id);">
                                                                    </asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right">
                                                                    <asp:RequiredFieldValidator
                                                                        ID="RequiredFieldValidator1" runat="server"
                                                                        ForeColor="Red" ValidationGroup="PRO"
                                                                        ControlToValidate="txtMfd_Date">
                                                                    </asp:RequiredFieldValidator>
                                                                    <strong><span id="mfd" runat="server"
                                                                            class="astrics">*</span> Mfd_Date :</strong>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtMfd_Date" MaxLength="50"
                                                                        Width="91%" CssClass="textbox_pop"
                                                                        runat="server"></asp:TextBox>
                                                                </td>
                                                                <td align="right">
                                                                    <%--<asp:RequiredFieldValidator
                                                                        ID="RequiredFieldValidator5" runat="server"
                                                                        ForeColor="Red" ValidationGroup="PRO"
                                                                        ControlToValidate="txtExp_Date">
                                                                        </asp:RequiredFieldValidator>
                                                                        <strong style="color: Red;">*</strong>--%>
                                                                        <strong>Exp_Date :</strong>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtExp_Date" MaxLength="50"
                                                                        Width="91%" onchange="checkproduct(this.value);"
                                                                        CssClass="textbox_pop" runat="server">
                                                                    </asp:TextBox>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                </td>
                                                                <td>
                                                                </td>
                                                                <td align="right" colspan="2">
                                                                    <asp:CompareValidator ID="CompareValidator2"
                                                                        runat="server" ValidationGroup="PRO"
                                                                        ControlToCompare="txtMfd_Date"
                                                                        ControlToValidate="txtExp_Date" ForeColor="Red"
                                                                        Type="Date" Operator="GreaterThan"
                                                                        Text="Exp. Date is greater than Mfd. Date.">
                                                                    </asp:CompareValidator>
                                                                </td>
                                                            </tr>
                                                            <tr style="display: none;">
                                                                <td align="right">
                                                                    <%--<asp:RequiredFieldValidator
                                                                        ID="RequiredFieldValidator6" runat="server"
                                                                        ForeColor="Red" ValidationGroup="PRO"
                                                                        ControlToValidate="txtNoOfCodes">
                                                                        </asp:RequiredFieldValidator>--%>
                                                                        <strong><span class="astrics">*</span> No. Of
                                                                            Codes
                                                                            :</strong>
                                                                        <asp:HiddenField ID="hdneditrowid"
                                                                            runat="server" />
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtNoOfCodes" MaxLength="6"
                                                                        Width="91%"
                                                                        onchange="CheckAvilableCodes(this.value);"
                                                                        CssClass="textbox_pop" runat="server"
                                                                        ReadOnly="true"></asp:TextBox>
                                                                </td>
                                                                <td colspan="2" align="center">
                                                                    <asp:CompareValidator ID="CompareValidator1"
                                                                        runat="server" ValidationGroup="PRO"
                                                                        ForeColor="Red" ControlToCompare="txtMfd_Date"
                                                                        ControlToValidate="txtExp_Date"
                                                                        Operator="GreaterThanEqual" Type="Date"
                                                                        Text="Exp date must be Greater..">
                                                                    </asp:CompareValidator>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right">
                                                                    <strong><span id="Span1" runat="server"
                                                                            class="astrics">*</span> Your Batch Size
                                                                        :</strong>
                                                                </td>
                                                                <td colspan="3">
                                                                    &nbsp;[<asp:Label ID="lblbatchsize" runat="server"
                                                                        ForeColor="Red" Font-Size="11px"
                                                                        Font-Bold="true">
                                                                    </asp:Label>]
                                                                </td>
                                                            </tr>
                                                            <tr style="display: none;">
                                                                <td align="right">
                                                                    <asp:CheckBox ID="chkComments" runat="server"
                                                                        AutoPostBack="true" Text="  Use Old"
                                                                        OnCheckedChanged="chkComments_CheckedChanged" />
                                                                    <strong><span class="astrics">&nbsp;</span> Comment
                                                                        :</strong>
                                                                </td>
                                                                <td colspan="3">
                                                                    <asp:TextBox ID="txtComment" MaxLength="100"
                                                                        TextMode="MultiLine" Width="95%" Height="30px"
                                                                        CssClass="textbox_pop"
                                                                        onkeyDown="return checkTextAreaMaxLength(this,event,'100');"
                                                                        runat="server"></asp:TextBox>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr style="display: none;">
                                                <td>
                                                    <fieldset class="Newfield">
                                                        <legend>Comment Files(*.wav)</legend>
                                                        <table width="98%" cellpadding="0" cellspacing="2">
                                                            <tr>
                                                                <td>
                                                                </td>
                                                                <td>
                                                                </td>
                                                                <td>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblname" runat="server"
                                                                        Style="color: Red; font-family: Arial; font-size: 12px;">
                                                                    </asp:Label>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="2" align="left">
                                                                    <asp:CheckBox ID="chkHindi" Enabled="false"
                                                                        runat="server" AutoPostBack="true"
                                                                        Text="  Use Old"
                                                                        OnCheckedChanged="chkHindi_CheckedChanged" />
                                                                </td>
                                                                <td colspan="2" align="left">
                                                                    <asp:CheckBox ID="chkEnglish" Enabled="false"
                                                                        Text="   Use Old" runat="server"
                                                                        OnCheckedChanged="chkHindi_CheckedChanged"
                                                                        AutoPostBack="true" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td align="right" style="width: 8%">
                                                                    <%-- <asp:RequiredFieldValidator
                                                                        ID="RequiredFieldValidator522" runat="server"
                                                                        ForeColor="Red" ValidationGroup="PRO"
                                                                        ControlToValidate="flSound">
                                                                        </asp:RequiredFieldValidator>--%>
                                                                        <strong>
                                                                            <asp:Label ID="L2" runat="server"
                                                                                CssClass="astrics" Text="*"></asp:Label>
                                                                            Hindi :
                                                                        </strong>
                                                                </td>
                                                                <td style="width: 40%">
                                                                    <asp:FileUpload ID="flSound" Enabled="false"
                                                                        onchange="fileTypeCheckeng(this.value);"
                                                                        runat="server" Style="width: 88%;" />
                                                                    <a id="SFileE" runat="server" target="_blank"
                                                                        title="Hindi File play"
                                                                        style="cursor: pointer;">
                                                                        <img alt="" src="Content/images/play.png" /></a>
                                                                </td>
                                                                <td align="right" style="width: 10%">
                                                                    <%-- <asp:RequiredFieldValidator
                                                                        ID="RequiredFieldValidator6English"
                                                                        runat="server" ForeColor="Red"
                                                                        ValidationGroup="PRO"
                                                                        ControlToValidate="flSoundE">
                                                                        </asp:RequiredFieldValidator>--%>
                                                                        <strong>
                                                                            <asp:Label ID="L1" runat="server"
                                                                                CssClass="astrics" Text="*"></asp:Label>
                                                                            English :
                                                                        </strong>
                                                                </td>
                                                                <td>
                                                                    <asp:FileUpload ID="flSoundE" Enabled="false"
                                                                        onchange="fileTypeCheckengE(this.value);"
                                                                        runat="server" Style="width: 88%;" />
                                                                    <a id="SFileH" runat="server" target="_blank"
                                                                        title="English File play"
                                                                        style="cursor: pointer;">
                                                                        <img alt="" src="Content/images/play.png" /></a>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblfile" runat="server"
                                                                        Style="color: Red; font-family: Arial; font-size: 12px;">
                                                                    </asp:Label>
                                                                </td>
                                                                <td>
                                                                </td>
                                                                <td>
                                                                    <asp:Label ID="lblfileE" runat="server"
                                                                        Style="color: Red; font-family: Arial; font-size: 12px;">
                                                                    </asp:Label>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </fieldset>
                                                </td>
                                            </tr>
                                            <tr>
                                                <td>
                                                    <fieldset id="Fieldset1" runat="server"
                                                        class="Newfield Newfield_width2" style="width: 97%;">
                                                        <legend>Pasted Label Info</legend>
                                                        <table width="100%" style="text-align: center;">
                                                            <tr style="background-color: #E6E6E6;">
                                                                <td align="center" style="width: 35%;">
                                                                    <asp:RequiredFieldValidator
                                                                        ID="RequiredFieldValidator6" runat="server"
                                                                        ForeColor="Red" ValidationGroup="APL"
                                                                        ControlToValidate="txtSeries_Initial">
                                                                    </asp:RequiredFieldValidator><strong><span
                                                                            class="astrics">*</span> Series Initial
                                                                    </strong>
                                                                </td>
                                                                <td style="width: 15%; text-align: center;">
                                                                    <asp:RequiredFieldValidator
                                                                        ID="RequiredFieldValidator5" runat="server"
                                                                        ForeColor="Red" ValidationGroup="APL"
                                                                        ControlToValidate="txtSeriesFrom">
                                                                    </asp:RequiredFieldValidator>
                                                                    <strong><span class="astrics">*</span>From</strong>
                                                                </td>
                                                                <td style="width: 15%; text-align: center;">
                                                                    <asp:RequiredFieldValidator
                                                                        ID="RequiredFieldValidator7" runat="server"
                                                                        ForeColor="Red" ValidationGroup="APL"
                                                                        ControlToValidate="txtSeriesTo">
                                                                    </asp:RequiredFieldValidator>
                                                                    <strong><span class="astrics">*</span>To</strong>
                                                                </td>
                                                                <td style="width: 20%; text-align: center;">
                                                                    <strong>Qty</strong>
                                                                </td>
                                                                <td style="width: 15%;">
                                                                    <asp:HiddenField ID="hdnFieldUpdate" Value="Save"
                                                                        runat="server" />
                                                                    &nbsp;<asp:DropDownList ID="ddlLabel" runat="server"
                                                                        Visible="false">
                                                                    </asp:DropDownList>
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td>
                                                                    <asp:TextBox ID="txtSeries_Initial1" Width="50px"
                                                                        runat="server" CssClass="textbox_pop"
                                                                        ReadOnly="true"
                                                                        onchange="ChkInitial(this.value,this.id);"
                                                                        MaxLength="10" Text=""></asp:TextBox><b>-</b>
                                                                    <asp:TextBox ID="txtSeries_Initial" Width="50px"
                                                                        runat="server" CssClass="textbox_pop"
                                                                        onchange="InitialSeries(this.value,this.id);"
                                                                        MaxLength="4"
                                                                        OnKeyPress="return isNumberKey(this, event);"
                                                                        Text=""></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtSeriesFrom" Width="50px"
                                                                        runat="server" CssClass="textbox_pop"
                                                                        onchange="FormatVal(this.value,this.id);"
                                                                        MaxLength="4"
                                                                        OnKeyPress="return isNumberKey(this, event);"
                                                                        Text=""></asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="txtSeriesTo" Width="50px"
                                                                        runat="server" CssClass="textbox_pop"
                                                                        MaxLength="4"
                                                                        onchange="ToatVal(this.value,this.id)"
                                                                        OnKeyPress="return isNumberKey(this, event);"
                                                                        Text=""></asp:TextBox>
                                                                    <asp:HiddenField ID="hdnSerialOrder"
                                                                        runat="server" />
                                                                    <asp:HiddenField ID="hdnSeriesFrom"
                                                                        runat="server" />
                                                                    <asp:HiddenField ID="hdnSeriesTo" runat="server" />
                                                                </td>
                                                                <td>
                                                                    <asp:TextBox ID="LblCountQty" CssClass="textbox_pop"
                                                                        runat="server" Width="100px" Text=""
                                                                        Enabled="false" Style="text-align: center;">
                                                                    </asp:TextBox>
                                                                </td>
                                                                <td>
                                                                    <asp:ImageButton ID="btnAddPro"
                                                                        ImageUrl="~/Content/images/add_new.png"
                                                                        runat="server" ValidationGroup="APL"
                                                                        OnClick="btnAddPro_Click" />&nbsp;
                                                                    <asp:ImageButton ID="btnResetPro"
                                                                        ImageUrl="~/Content/images/reset.png"
                                                                        runat="server" CausesValidation="false"
                                                                        OnClick="btnResetPro_Click" />
                                                                </td>
                                                            </tr>
                                                            <tr>
                                                                <td colspan="7" align="center">
                                                                    <asp:Label ID="lblProDetailsMsg" runat="server"
                                                                        Text="" ForeColor="Red"></asp:Label>
                                                                    <asp:Label ID="lblUpFlTblId" runat="server" Text=""
                                                                        Visible="false"></asp:Label>
                                                                    <asp:Label ID="lblC" runat="server" Text=""
                                                                        Visible="false"></asp:Label>
                                                                    <div align="center"
                                                                        style="overflow: auto; height: 150px;">
                                                                        <asp:GridView ID="GrdProductPrintLablelDet"
                                                                            runat="server" AutoGenerateColumns="False"
                                                                            CssClass="grid"
                                                                            EmptyDataText="Record Not Found"
                                                                            EmptyDataRowStyle-HorizontalAlign="Center"
                                                                            EnableModelValidation="True" Width="100%"
                                                                            BorderStyle="None" BorderWidth="0"
                                                                            BorderColor="transparent"
                                                                            OnRowCommand="GrdProductPrintLablelDet_RowCommand">
                                                                            <Columns>
                                                                                <%--<asp:TemplateField
                                                                                    HeaderText="Product Name">
                                                                                    <ItemTemplate>
                                                                                        <asp:Label ID="lblLablProNm"
                                                                                            runat="server"
                                                                                            Text='<%# Bind("Pro_Name") %>'>
                                                                                        </asp:Label>
                                                                                    </ItemTemplate>
                                                                                    <HeaderStyle CssClass="tr_haed"
                                                                                        HorizontalAlign="Center" />
                                                                                    <ItemStyle HorizontalAlign="Center"
                                                                                        Width="20%" />
                                                                                    </asp:TemplateField>--%>
                                                                                    <asp:TemplateField
                                                                                        HeaderText="Series Initial">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lvlpronm"
                                                                                                runat="server"
                                                                                                Text='<%# Bind("Pro_ID") %>'>
                                                                                            </asp:Label><b>-</b>
                                                                                            <asp:Label ID="lblLabelNm"
                                                                                                runat="server"
                                                                                                Text='<%# Bind("Series_Initial") %>'>
                                                                                            </asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle CssClass="tr_haed"
                                                                                            HorizontalAlign="Center" />
                                                                                        <ItemStyle
                                                                                            HorizontalAlign="Center"
                                                                                            Width="20%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField
                                                                                        HeaderText="Series From">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label
                                                                                                ID="lblseriesfrom"
                                                                                                runat="server"
                                                                                                Text='<%# Bind("Series_From") %>'>
                                                                                            </asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle CssClass="tr_haed"
                                                                                            HorizontalAlign="Center" />
                                                                                        <ItemStyle
                                                                                            HorizontalAlign="Center"
                                                                                            Width="20%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField
                                                                                        HeaderText="Series To">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblseriesto"
                                                                                                runat="server"
                                                                                                Text='<%# Bind("Series_To") %>'>
                                                                                            </asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle CssClass="tr_haed"
                                                                                            HorizontalAlign="Center" />
                                                                                        <ItemStyle
                                                                                            HorizontalAlign="Center"
                                                                                            Width="23%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField
                                                                                        HeaderText="Qty.">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblCountQty"
                                                                                                runat="server"
                                                                                                Text='<%# Bind("Qty") %>'>
                                                                                            </asp:Label>
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle CssClass="tr_haed"
                                                                                            HorizontalAlign="Center" />
                                                                                        <ItemStyle
                                                                                            HorizontalAlign="Center"
                                                                                            Width="10%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField
                                                                                        HeaderText="Action">
                                                                                        <ItemTemplate>
                                                                                            <asp:ImageButton
                                                                                                ID="Imgeditprodetails"
                                                                                                runat="server"
                                                                                                CommandName="EditProDetails"
                                                                                                ImageUrl="~/Content/images/edit.png"
                                                                                                CommandArgument='<%#Container.DataItemIndex %>' />
                                                                                            &nbsp;
                                                                                            <asp:ImageButton
                                                                                                ID="ImageButtondelete"
                                                                                                runat="server"
                                                                                                CommandName="DeleteProDetails"
                                                                                                ImageUrl="~/Content/images/delete.png"
                                                                                                CommandArgument='<%#Container.DataItemIndex %>'
                                                                                                OnClientClick="return confirm('Are you sure to delete ?')" />
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle CssClass="tr_haed"
                                                                                            HorizontalAlign="Center" />
                                                                                        <ItemStyle
                                                                                            HorizontalAlign="Center"
                                                                                            Width="10%" />
                                                                                    </asp:TemplateField>
                                                                            </Columns>
                                                                            <EmptyDataRowStyle
                                                                                HorizontalAlign="Center" />
                                                                            <PagerStyle HorizontalAlign="Center"
                                                                                CssClass="pagination" />
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
                                                <td align="right" style="padding-right: 10px;">
                                                    <div
                                                        style="float: left; width: 70%; text-align: left; padding-left: 18px;">
                                                        <span style="color: Red;">Please paste Labels batch wise at a
                                                            time
                                                            in sequence of series
                                                            no.</span>
                                                    </div>
                                                    <div style="float: right; width: 26%;">
                                                        <asp:Label ID="lblproid" runat="server" Visible="false">
                                                        </asp:Label>
                                                        <asp:Label ID="lblnoofcodes" runat="server" Visible="false">
                                                        </asp:Label>
                                                        <asp:Button ID="btnSave" OnClick="btnSave_Click"
                                                            ValidationGroup="PRO" CssClass="button_all" runat="server"
                                                            Text="Save" />
                                                        <asp:Button ID="btnReset" OnClick="btnReset_Click"
                                                            CssClass="button_all" runat="server" Text="Reset" />
                                                    </div>
                                                </td>
                                            </tr>
                                            <tr style="display: none;">
                                                <td colspan="2">
                                                    <asp:Label ID="lblnoteSound"
                                                        Style="font-family: Arial; font-size: 12px; color: red;"
                                                        runat="server"
                                                        Text="Note:- Audio file to be uploaded on the website should be in the prescribed format as below">
                                                    </asp:Label>
                                                    <br />
                                                    <asp:Label ID="lblfiletype"
                                                        Style="font-family: Arial; font-size: 12px; color: red;"
                                                        runat="server" Text="File Type ---- .wav"></asp:Label>
                                                    <br />
                                                    <asp:Label ID="lblfileformat"
                                                        Style="font-family: Arial; font-size: 12px; color: red;"
                                                        runat="server" Text="Format ---- 8KHz, 16bit mono"></asp:Label>
                                                    <br />
                                                    <asp:Label ID="lblBitRate"
                                                        Style="font-family: Arial; font-size: 12px; color: red;"
                                                        runat="server" Text="Bit Rate ---- 128 kbps"></asp:Label>
                                                    <br />
                                                    <asp:Label ID="lblrecord"
                                                        Style="font-family: Arial; font-size: 12px; color: Blue;"
                                                        runat="server"
                                                        Text="For record the audio file, Please click the link ">
                                                    </asp:Label>&nbsp;
                                                    <a href="http://wavepad.en.softonic.com/" style="font-family: Arial; font-size: 12px;
                                                color: Blue;" target="_blank">Click</a>
                                                </td>
                                            </tr>
                                        </table>
                                        </fieldset>
                                    </div>
                                    <!--</fieldset>-->
                                    <!-- END List Wrap -->
                                </div>
                            </div>
                        </asp:Panel>
                        <cc1:ModalPopupExtender ID="ProductDetailsPopUp" runat="server"
                            PopupControlID="PanelProductDetails" TargetControlID="Label1"
                            BackgroundCssClass="NewmodalBackground" CancelControlID="Button1">
                        </cc1:ModalPopupExtender>
                        <asp:Label ID="Label1" runat="server"></asp:Label>
                        <cc1:CalendarExtender ID="CalendarExtender1" TargetControlID="txtMfd_Date" runat="server"
                            Format="dd/MM/yyyy">
                        </cc1:CalendarExtender>
                        <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtMfd_Date"
                            MaskType="Date" Mask="99/99/9999">
                        </cc1:MaskedEditExtender>
                        <cc1:CalendarExtender ID="CalendarExtender2" TargetControlID="txtExp_Date" runat="server"
                            Format="dd/MM/yyyy">
                        </cc1:CalendarExtender>
                        <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtExp_Date"
                            MaskType="Date" Mask="99/99/9999">
                        </cc1:MaskedEditExtender>
                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtendertxtMRP" runat="server"
                            FilterMode="ValidChars" ValidChars="1234567890." TargetControlID="txtMRP">
                        </cc1:FilteredTextBoxExtender>
                        <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtendertxtnoofCodes" runat="server"
                            FilterMode="ValidChars" ValidChars="1234567890" TargetControlID="txtNoOfCodes">
                        </cc1:FilteredTextBoxExtender>
                        <cc1:CalendarExtender ID="CalendarExtender1dtfrom" TargetControlID="txtDateFrom" runat="server"
                            Format="dd/MM/yyyy">
                        </cc1:CalendarExtender>
                        <cc1:MaskedEditExtender ID="MaskedEditExtenderdtfrom1" runat="server"
                            TargetControlID="txtDateFrom" MaskType="Date" Mask="99/99/9999">
                        </cc1:MaskedEditExtender>
                        <cc1:CalendarExtender ID="CalendarExtender2dtto" TargetControlID="txtDateTo" runat="server"
                            Format="dd/MM/yyyy">
                        </cc1:CalendarExtender>
                        <cc1:MaskedEditExtender ID="MaskedEditExtendttoder2" runat="server" TargetControlID="txtDateTo"
                            MaskType="Date" Mask="99/99/9999">
                        </cc1:MaskedEditExtender>
                        <!--PopUp Close-->
                        <!--===============================PopUp Password Starts===============================-->
                        <asp:Panel ID="PanelShowPassword" runat="server" Width="20%" Style="display: none;">
                            <div class="popupContent" style="width: 100%;">
                                <div class="pop_log_bg">
                                    <div>
                                        <asp:Button ID="btnPasswordPnlClose" CssClass="popupClose" runat="server"
                                            CausesValidation="false" />
                                    </div>
                                    <!--<fieldset class="service_field" >-->
                                    <div class="service_head_p">
                                        <p>
                                            <span class="left">
                                                <asp:Label ID="lblPassPnlHead" runat="server" Text="Password"
                                                    Font-Size="12px"></asp:Label>
                                            </span><span class="right" style="visibility: hidden;"><span
                                                    class="astrics"><strong>
                                                    </strong></span></span>
                                        </p>
                                    </div>
                                    <div class="regis_popup" style="text-align: center;">
                                        <br />
                                        <asp:Label ID="lblCompPassText" runat="server" Text="" Font-Size="12px"
                                            ForeColor="Red"></asp:Label><br />
                                        <br />
                                        <div id="infobtn" runat="server" visible="true">
                                            <asp:Button ID="btnYesActivation" runat="server" Text="Ok"
                                                CssClass="button_all" OnClick="btnYesActivation_Click" />&nbsp;&nbsp;
                                            <asp:Button ID="btnNoActivation" runat="server" Text="No"
                                                CssClass="button_all" OnClick="btnNoActivation_Click" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <!--===============================Popup Close================================-->
                        <asp:Label ID="LabelControl" runat="server"></asp:Label>
                        <cc1:ModalPopupExtender ID="ModalPopupExtenderAlert" runat="server"
                            BackgroundCssClass="NewmodalBackground" CancelControlID="btnPasswordPnlClose"
                            PopupControlID="PanelShowPassword" OkControlID="btnYesActivation"
                            TargetControlID="LabelControl">
                        </cc1:ModalPopupExtender>
                    </div>


                </div>

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
        </asp:Content>