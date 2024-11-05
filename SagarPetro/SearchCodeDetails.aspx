<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="SearchCodeDetails.aspx.cs" Inherits="Patanjali_SearchCodeDetails" %>

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
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

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

   <asp:UpdatePanel ID="upd1" runat="server">
        <ContentTemplate>
        <div class="home-section">
            <div class="app-breadcrumb">
                <div class="row">
                    <div class="col">
                        <h5>Code Details</h5>
                    </div>
                    <div class="col">
                        <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Code Details</li>
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
                            <div class="col col-md-4 mb-3">
                                <div class="global-search">
                                    <div class="form-group ">
                                       <%-- <input type="search" class="form-control" placeholder="Search">
                                        <span><i class="fa fa-search"></i></span>--%>
                                    </div>
                                </div>
                            </div>
                            <div class="col mb-3">
                                <ul class="action-button-global">
                                    
                                    <li>
                                        <a href="NewBatchAssignedDetails.aspx" class="btn btn-sm btn-primary"><i class='bx bx-plus'></i>View Reports</a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                            <div class="row">

                             <div class="col">
                                <label for="Product Description" class="form-label">13-Digit Code</label>

                                <asp:TextBox ID="txtcode" OnTextChanged="txtcode_TextChanged" AutoPostBack="true" MaxLength="13" CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator3" runat="server" ValidationGroup="abc"
                                    ControlToValidate="txtcode" ErrorMessage="ex: 1234567890123" Display="None" 
                                    ViewStateMode="Enabled" ValidationExpression="[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]"></asp:RegularExpressionValidator>

                            </div>
                            <div class="col">
                                <label for="Product Description" class="form-label">From Series</label>

                                <asp:TextBox ID="txtscrapfrom" OnTextChanged="txtscrapfrom_TextChanged" AutoPostBack="true" CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server" ValidationGroup="abc"
                                    ControlToValidate="txtscrapfrom" ErrorMessage="ex: AA06-01-001" Display="None" 
                                    ViewStateMode="Enabled" ValidationExpression="[A-Z][A-Z][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]"></asp:RegularExpressionValidator>

                            </div>

                            <div class="col">
                                <label for="Dispatch Location" class="form-label">To Series</label>
                                 <asp:TextBox ID="txtscrapto" OnTextChanged="txtscrapto_TextChanged" AutoPostBack="true" CssClass="form-control" runat="server"></asp:TextBox>
                                <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server" ValidationGroup="abc"
                                    ControlToValidate="txtscrapto" ErrorMessage="ex: AA06-01-001" Display="None"
                                    ViewStateMode="Enabled" ValidationExpression="[A-Z][A-Z][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]"></asp:RegularExpressionValidator>
                            </div>
                           

                            <div class="col">
                                <label class="form-label text-white">*</label><br />
                                 <asp:Button ID="btnSearch" OnClick="btnSearch_Click" ValidationGroup="chk94" class="btn btn-primary"
                                    runat="server" Text="Search" />
                            
                                <asp:Button ID="btnRefresh" OnClick="btnRefresh_Click" class="btn btn-success" runat="server"
                                    CausesValidation="false" Text="Reset" />
                            </div>

                        </div>
                        <!--  -->
                        <asp:Label ID="LblMsg" CssClass="small_font" runat="server"></asp:Label>
                        <!--  -->
                        <h5 class="mt-3">Record's Found :<span> <asp:Label ID="lblcount" runat="server"></asp:Label>
                                                        <asp:Label ID="lblC" Text="0" runat="server" Visible="false"></asp:Label>
													                                </span></h5>
                           
                                                <asp:Label ID="Label1" CssClass="small_font" runat="server"></asp:Label>

                        <div class="row g-0">
                                 
                            <div class="col-lg-2">
                                <asp:Button ID="btnSave"  OnClick="btnSave_Click" ValidationGroup="chk94" class="btn btn-primary btn-sm"
                                    runat="server" Text="Request To Assign Batch No." />
                            </div>
                                </div>

                        <div class="app-table mt-2">
                            <div class="table-responsive">
                               
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
            <!-- Modal -->




              <asp:ValidatorCalloutExtender ID="ValidatorCalloutExtender1" WarningIconImageUrl="~/Content/images/WARNING.png"
                    TargetControlID="RegularExpressionValidator1" runat="server">
                </asp:ValidatorCalloutExtender>
                <asp:ValidatorCalloutExtender ID="ValidatorCalloutExtender2" WarningIconImageUrl="~/Content/images/WARNING.png"
                    TargetControlID="RegularExpressionValidator2" runat="server">
                </asp:ValidatorCalloutExtender>
        </div>
   
      <!--===============================PopUp Alert Starts===============================-->

    
            <asp:Panel ID="PanelForScrap" CssClass="shadow rounded-3 border border-2" runat="server" Width="30%" style="display:none;background-color:white;border:1px solid grey;padding:1rem;">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div class="text-end">
                            <asp:Button ID="btnCloseScrap" Text="Close" CssClass="popupClose btn btn-danger btn-sm" runat="server" CausesValidation="false" />  </div>
                               
                            
                          <%--     <div class="modal-header">
                            <h1 class="modal-title fs-5">Scrap</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
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
                                    <asp:Button ID="btnYesScrap" runat="server" Text="SUBMIT" class="btn btn-primary w-100" OnClick="btnYesScrap_Click"
                                ValidationGroup="CHKSCR" />
                                </div>
                            </div>
                   
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

        </ContentTemplate>

    </asp:UpdatePanel>
            

</asp:Content>

