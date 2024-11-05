<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true"
    CodeFile="FrmScrapEntry.aspx.cs" Inherits="Patanjali_FrmScrapEntry" %>


    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>
        <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

            <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
                <script type="text/javascript">
                    $(document).ready(function () {

                        $(".accordion2 p").eq(28).addClass("active");
                        $(".accordion2 div.open").eq(26).show();

                        $(".accordion2 p").click(function () {
                            $(this).next("div.open").slideToggle("slow")
                                .siblings("div.open:visible").slideUp("slow");
                            $(this).toggleClass("active");
                            $(this).siblings("p").removeClass("active");
                        });

                    });
                </script>

                <script type="text/javascript">
                    function checkAll(frm, mode) {
                        var i = 0;
                        for (; i < frm.elements.length; i++)
                            if (frm.elements[i].type == "checkbox")
                                frm.elements[i].checked = mode;
                    }
                </script>

            </asp:Content>
            <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

                <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0">
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


                <div class="home-section">
                    <div class="app-breadcrumb">
                        <div class="row">
                            <div class="col">
                                <h5>Scrap Label Entry</h5>
                            </div>
                            <div class="col">
                                <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                                    <ol class="breadcrumb">
                                        <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a>
                                        </li>
                                        <li class="breadcrumb-item active" aria-current="page">Scrap Label Entry</li>
                                    </ol>
                                </nav>
                            </div>
                        </div>
                    </div>
                    <!-- table view -->
                    <div class="user-role-card">
                        <div class="card">
                            <div class="card-body">
                                <div class="row">

                                    <div class="col">
                                        <label for="Product Name" class="form-label">Product Name<span>*</span></label>
                                        <asp:DropDownList ID="ddlProduct" CssClass="form-select" runat="server"
                                            AutoPostBack="true"
                                            OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged">
                                        </asp:DropDownList>
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                            ControlToValidate="ddlProduct" ErrorMessage="*" InitialValue="--Select--"
                                            ValidationGroup="abc" runat="server"></asp:RequiredFieldValidator>
                                    </div>
                                    <div class="col">
                                        <label for="Product Description" class="form-label">Date From</label>

                                        <asp:TextBox ID="txtscrapfrom" onchange="upperMe()" CssClass="form-control"
                                            runat="server"></asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                            ValidationGroup="abc" ControlToValidate="txtscrapfrom"
                                            ErrorMessage="ex: AA06-01-001" Display="None" ViewStateMode="Enabled"
                                            ValidationExpression="[A-Z][A-Z][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]">
                                        </asp:RegularExpressionValidator>

                                    </div>
                                    <div class="col">
                                        <label for="Dispatch Location" class="form-label">Date To</label>
                                        <asp:TextBox ID="txtscrapto" CssClass="form-control" runat="server">
                                        </asp:TextBox>
                                        <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                            ValidationGroup="abc" ControlToValidate="txtscrapto"
                                            ErrorMessage="ex: AA06-01-001" Display="None" ViewStateMode="Enabled"
                                            ValidationExpression="[A-Z][A-Z][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]">
                                        </asp:RegularExpressionValidator>
                                    </div>


                                    <div class="col">
                                        <label class="form-label text-white">*</label><br />
                                        <asp:Button ID="btnSearch" OnClick="btnSearch_Click" ValidationGroup="chk94"
                                            class="btn btn-primary" runat="server" Text="Search" />

                                        <asp:Button ID="btnRefresh" OnClick="btnRefresh_Click" class="btn btn-success"
                                            runat="server" CausesValidation="false" Text="Reset" />
                                    </div>

                                </div>
                                <!--  -->
                                <div
                                    class="row row-cols-xxl-5 row-cols-xl-5 row-cols-lg-5 row-cols-md-2 row-cols-2 g-3">
                                    <%-- <div class="col">
                                        <span class="global-badge badge bg-label-success w-100">Labels Available</span>
                                </div>
                                <div class="col">
                                    <span class="global-badge badge bg-label-warning w-100">Pasted Labels</span>
                                </div>
                                <div class="col">
                                    <span class="global-badge badge bg-label-light w-100">Scrap Durung Courier
                                        Receipt</span>
                                </div>
                                <div class="col">
                                    <span class="global-badge badge bg-label-danger w-100">Scrap at Pasting Time</span>
                                </div>--%>
                            

                            </div>
                          
                            <!--  -->
                            <h4>Record's Found :<span>
                                    <asp:Label ID="lblcount" runat="server"></asp:Label>
                                    <asp:Label ID="lblC" Text="0" runat="server" Visible="false"></asp:Label>
                                </span></h4>

                            <asp:Label ID="Label1" runat="server"></asp:Label>

                            <div class="row g-0">
                                <div class="col-lg-2 d-flex align-items-center">
                                    <asp:Button ID="btnAvailable" runat="server"
                                        Style="background-color: #c7efc8; width: 15px; height: 15px; border: 1px solid #bdb5b5; margin-right: 10px;"
                                        OnClick="btnAvailable_Click" ToolTip="Click For Filter" /><label>Labels Available</label>
                                </div>
                                <div class="col-lg-2 d-flex align-items-center">
                                    <asp:Button ID="btnUsed" runat="server"
                                        Style="background-color: Yellow; width: 15px; height: 15px; border: 1px solid #bdb5b5; margin-right: 10px;"
                                        OnClick="btnUsed_Click" ToolTip="Click For Filter" />
                                        <label>Pasted Labels</label> 
                                </div>
                                <div class="col-lg-3 d-flex align-items-center">
                                    <asp:Button ID="btnCourierRescrap" runat="server"
                                        Style="background-color: #FFFFFF; width: 15px; height: 15px; border: 1px solid #bdb5b5; margin-right: 10px;"
                                        OnClick="btnCourierRescrap_Click" ToolTip="Click For Filter" />
                                        <label>Scrap Durung
                                            Courier Receipt</label> 
                                </div>
                                <div class="col-lg-3 d-flex align-items-center">
                                    <asp:Button ID="btnScrap" runat="server"
                                        Style="background-color: #fbe3e4; width: 15px; height: 15px; border: 1px solid #bdb5b5; margin-right: 10px;"
                                        OnClick="btnScrap_Click" ToolTip="Click For Filter" />
                                        <label>Scrap at Pasting Time</label>
                                </div>
                                <div class="col-lg-2">
                                    <asp:Button ID="btnSave" OnClick="btnSave_Click" ValidationGroup="chk94"
                                        class="btn btn-primary btn-sm" runat="server" Text="Make Scrap" />
                                </div>
                            </div>
                            <asp:Label ID="LblMsg" runat="server"></asp:Label>
                            <div class="app-table mt-2">
                                <div class="table-responsive">

                                    <asp:GridView ID="Grdscrap" runat="server" AutoGenerateColumns="False"
                                        CssClass="table table-bordered table-hover" DataKeyNames="ScrapeFlag,ff"
                                        EmptyDataText="Record Not Found">
                                        <Columns>
                                            <%--<asp:TemplateField HeaderText="Product Name">
                                                <ItemTemplate>
                                                    <%=++sr%>
                                                </ItemTemplate>
                                                <HeaderStyle />
                                                <ItemStyle />
                                                </asp:TemplateField>--%>
                                                <asp:TemplateField HeaderText="Serial Code">
                                                    <HeaderStyle />
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label1SeNew" runat="server"
                                                            Text='<%# Bind("SerialCode") %>'></asp:Label>
                                                        <asp:Label ID="lblactudate123nEW" CssClass="tr_line1"
                                                            runat="server" Width="5px" Visible="false"
                                                            Text='<%# Bind("Series_Order") %>'></asp:Label>
                                                        <asp:Label ID="Label1Se" runat="server"
                                                            Text='<%# Bind("Series_Serial") %>' Width="5px"
                                                            Visible="false"></asp:Label>
                                                    </ItemTemplate>

                                                    <%--<HeaderStyle />--%>
                                                    <ItemStyle />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Product Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label1SeNew4" runat="server"
                                                            Text='<%# Bind("Pro_Name") %>'></asp:Label>
                                                    </ItemTemplate>

                                                    <ItemStyle />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Status">
                                                    <ItemTemplate>
                                                        <asp:Label ID="Label1Status" runat="server"
                                                            Text='<%# Bind("ScrapeStatus") %>'></asp:Label>
                                                    </ItemTemplate>

                                                    <ItemStyle />
                                                </asp:TemplateField>
                                                <asp:TemplateField>
                                                    <HeaderTemplate>
                                                        <input id="chkselecth" name="chkselecth" type="checkbox"
                                                            onchange="checkAll(this.form,this.checked)" />
                                                    </HeaderTemplate>
                                                    <ItemTemplate>
                                                        <% try {
                                                            ScrapeFlag=Convert.ToInt32(Grdscrap.DataKeys[index].Values["ScrapeFlag"].ToString());
                                                            } catch { } if (ScrapeFlag==1) { %>
                                                            <input id="Checkbox1" name="chkselect" checked="checked"
                                                                type="checkbox" value='<%# Eval("SerialCode") %>' />
                                                            <% } else { %>
                                                                <input id="chkselect" name="chkselect" type="checkbox"
                                                                    value='<%# Eval("SerialCode") %>' />
                                                                <% } index++;%>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle />--%>
                                                    <ItemStyle />
                                                </asp:TemplateField>
                                        </Columns>
                                        <%-- <PagerStyle HorizontalAlign="Right" CssClass="pagination" />
                                        <RowStyle CssClass="tr_line1" />
                                        <AlternatingRowStyle CssClass="tr_line2" />--%>
                                    </asp:GridView>
                                    <asp:HiddenField ID="hidden1" runat="server" />
                                    <asp:Label ID="Labeldispath" runat="server"></asp:Label>

                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- Modal -->




                <asp:ValidatorCalloutExtender ID="ValidatorCalloutExtender1"
                    WarningIconImageUrl="~/Content/images/WARNING.png" TargetControlID="RegularExpressionValidator1"
                    runat="server">
                </asp:ValidatorCalloutExtender>
                <asp:ValidatorCalloutExtender ID="ValidatorCalloutExtender2"
                    WarningIconImageUrl="~/Content/images/WARNING.png" TargetControlID="RegularExpressionValidator2"
                    runat="server">
                </asp:ValidatorCalloutExtender>
                </div>

                <!--===============================PopUp Alert Starts===============================-->
                <asp:Panel ID="PanelForScrap" CssClass="shadow rounded-3 border border-2" runat="server" Width="30%"
                    style="display:none;background-color:white;border:1px solid grey;padding:1rem;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div class="text-end">
                                <asp:Button ID="btnCloseScrap" Text="Close" CssClass="popupClose btn btn-danger btn-sm"
                                    runat="server" CausesValidation="false" />
                            </div>


                            <%-- <div class="modal-header">
                                <h1 class="modal-title fs-5">Scrap</h1>
                                <button type="button" class="btn-close" data-bs-dismiss="modal"
                                    aria-label="Close"></button>
                        </div>--%>



                        <!--<fieldset class="service_field" >-->
                        <div class="service_head_p d-none">
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
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server"
                                        ForeColor="Red" ValidationGroup="CHKSCR" InitialValue="--Select--"
                                        ControlToValidate="ddlreason"></asp:RequiredFieldValidator>
                                    <label class="form-label">Select Reason</label>
                                    <asp:DropDownList ID="ddlreason" class="form-select" runat="server">
                                    </asp:DropDownList>
                                </div>
                                <div class="col-12">
                                    <label class="form-label">Remark</label>
                                    <asp:TextBox ID="txtreasonremarks" TextMode="MultiLine" class="form-control"
                                        runat="server">
                                    </asp:TextBox>
                                </div>
                                <div class="col-12">
                                    <asp:Button ID="btnYesScrap" runat="server" Text="SUBMIT"
                                        class="btn btn-primary w-100" OnClick="btnYesScrap_Click"
                                        ValidationGroup="CHKSCR" />
                                </div>
                            </div>

                        </div>
                    </div>
                    </div>
                </asp:Panel>
                <!--===============================Popup Close================================-->
                <asp:Label ID="LabelControlID" runat="server"></asp:Label>
                <asp:Label ID="LabelModel" runat="server" Text="Yes" Visible="false"></asp:Label>
                <cc1:ModalPopupExtender ID="ModalPopupExtenderScrap" runat="server"
                    BackgroundCssClass="NewmodalBackground" CancelControlID="btnCloseScrap"
                    PopupControlID="PanelForScrap" TargetControlID="LabelControlID">
                </cc1:ModalPopupExtender>

            </asp:Content>