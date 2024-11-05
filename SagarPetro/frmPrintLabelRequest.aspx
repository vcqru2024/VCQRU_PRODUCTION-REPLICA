<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="frmPrintLabelRequest.aspx.cs" Inherits="Patanjali_frmPrintLabelRequest" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(21).addClass("active");
            $(".accordion2 div.open").eq(20).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <script type="text/javascript" language="javascript">
        function precise_round(num, decimals) {
            return Math.round(num * Math.pow(10, decimals)) / Math.pow(10, decimals);
        }
        function FindAllGrandT(vl) {

            var lblCode = document.getElementById("<%=HdLabelCodeRequest.ClientID %>").value;
            var ProID = document.getElementById("<%=ddlprotype.ClientID %>").value;
            if (lblCode == "") {
                document.getElementById("<%=Label1.ClientID %>").innerHTML = "Please select Product !";
                document.getElementById("<%=Div1.ClientID %>").className = "alert_boxes_pink big_msg";
                document.getElementById("<%=btnRequestSend.ClientID %>").disabled = true;
                document.getElementById("<%=btnRequestSend.ClientID %>").className = "button_all_Sec";
                document.getElementById("<%=txtNoofLabel.ClientID %>").value = "";
                document.getElementById("<%=lblGrandTotal.ClientID %>").innerHTML = "";
                return;
            }
                        
            var code = document.getElementById("<%=txtNoofLabel.ClientID %>").value;
            if (code != "") {
                if (parseInt(code) > 100000)
                {
                    document.getElementById("<%=Label1.ClientID %>").innerHTML = "Please enter No. of Requested Label not exceeding 1000000 (1 lakh)";
                    document.getElementById("<%=Div1.ClientID %>").className = "alert_boxes_pink big_msg";
                    document.getElementById("<%=btnRequestSend.ClientID %>").disabled = true;
                    document.getElementById("<%=btnRequestSend.ClientID %>").className = "button_all_Sec";
                    document.getElementById("<%=txtNoofLabel.ClientID %>").value = "";
                    document.getElementById("<%=lblGrandTotal.ClientID %>").innerHTML = "";                 
                    return;
                }
            }

            var val = lblCode + "-" + vl + "-" + ProID;
            PageMethods.FindAllAmount(val, onCompleteGrandT)
        }
        function onCompleteGrandT(Result) {
            var Arr = Result.toString().split('-'); 
            if (Arr[1].toString() == "True") {
                if (Arr[0].toString() == "0") {                    
                    document.getElementById("<%=Label1.ClientID %>").innerHTML = "Please enter requested  No. of print Labels !";
                    document.getElementById("<%=Div1.ClientID %>").className = "alert_boxes_pink big_msg";
                    document.getElementById("<%=btnRequestSend.ClientID %>").disabled = true;
                    document.getElementById("<%=btnRequestSend.ClientID %>").className = "button_all_Sec";
                    document.getElementById("<%=txtNoofLabel.ClientID %>").value = "";
                    document.getElementById("<%=lblGrandTotal.ClientID %>").innerHTML = "";
                }
                else {
                    document.getElementById("<%=Label1.ClientID %>").innerHTML = "";
                    document.getElementById("<%=Div1.ClientID %>").className = "";
                    document.getElementById("<%=btnRequestSend.ClientID %>").disabled = false;
                    document.getElementById("<%=btnRequestSend.ClientID %>").className = "button_all";
                    document.getElementById("<%=lblGrandTotal.ClientID %>").innerHTML = precise_round(Arr[0], 2);
                }                
            }
            else {
                document.getElementById("<%=lblGrandTotal.ClientID %>").innerHTML = "";
                document.getElementById("<%=Label1.ClientID %>").innerHTML = "Please enter requested  No. of print Labels !";
                document.getElementById("<%=Div1.ClientID %>").className = "alert_boxes_pink big_msg";
                document.getElementById("<%=btnRequestSend.ClientID %>").disabled = true;
                document.getElementById("<%=btnRequestSend.ClientID %>").className = "button_all_Sec";
                document.getElementById("<%=txtNoofLabel.ClientID %>").value = "";
            }
        }
        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <a style="display: block"></a>
    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>

             <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <!-- <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
                        top: 0px; z-index: 100001;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div> -->
                </ProgressTemplate>
            </asp:UpdateProgress>

              <div class="home-section">
            <div class="app-breadcrumb">
                <div class="row">
                    <div class="col">
                        <h5>Request for print Labels</h5>
                    </div>
                    <div class="col">
                        <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                              <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Request for print Labels</li>
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
                                         <input type="search" class="form-control" onkeyup="performSearch(this.value)" placeholder="Search">
                                        <span><i class="fa fa-search"></i></span>
                                    </div>
                                </div>
                            </div>
                            <div class="col mb-3">
                                <ul class="action-button-global">
                                    
                                    <li>
                                        <a href="AddLabelRequest.aspx" class="btn btn-sm btn-primary"><i class='bx bx-plus'></i>Add/Edit Label Request</a>
                                    </li>
                                </ul>
                            </div>
                        </div>

                        <div id="NewMsgpop" runat="server">
                    <p>
                        <asp:Label ID="Label2" runat="server"></asp:Label>
                    </p>
                </div>
                        <div class="row">

                             <div class="col">
                                <label for="Product Name" class="form-label">Tracking No.<span>*</span></label>
                                 <asp:TextBox ID="txttrachingno" placeholder="Tracking No." runat="server" CssClass="form-control" required></asp:TextBox>
                                <div class="invalid-feedback">Enter valid tracking no.</div>
                            </div>
                            <div class="col">
                                <label for="Product Description" class="form-label">Select Product</label>

                                <asp:DropDownList ID="ddlProSearch" runat="server" CssClass="form-select"></asp:DropDownList>

                                <div class="invalid-feedback">Enter valid name.</div>
                            </div>
                            <div class="col">
                                <label for="Dispatch Location" class="form-label">Date From</label>
                                <asp:TextBox ID="txtDateFrom" placeholder="Date From" runat="server" Text="" CssClass="form-control"></asp:TextBox>
                                <cc1:CalendarExtender ID="CalendarExtender1dtfrom" TargetControlID="txtDateFrom"
                                        runat="server" Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtenderdtfrom1" runat="server" TargetControlID="txtDateFrom"
                                        MaskType="Date" Mask="99/99/9999">
                                    </cc1:MaskedEditExtender>
                                <div class="invalid-feedback">Enter valid name.</div>
                            </div>
                            <div class="col">
                                <label for="Batch Size" class="form-label">Date To</label>
                                <asp:TextBox ID="txtDateTo" placeholder="Date To" runat="server" Text="" CssClass="form-control"></asp:TextBox>
                                   

                                 <cc1:CalendarExtender ID="CalendarExtender2dtto" TargetControlID="txtDateTo" runat="server"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtendttoder2" runat="server" TargetControlID="txtDateTo"
                                        MaskType="Date" Mask="99/99/9999">
                                    </cc1:MaskedEditExtender>
                                <div class="invalid-feedback">Enter valid name.</div>
                            </div>

                            <div class="col">
                                <label class="form-label text-white">*</label>
                                <br>
                                 <asp:Button ID="btnSearch" OnClick="btnSearch_Click" ValidationGroup="chk94" class="btn btn-primary"
                                    runat="server" Text="Search" />
                            
                                <asp:Button ID="btnRefresh" OnClick="btnRefresh_Click" class="btn btn-light border" runat="server" type="reset"
                                    CausesValidation="false" Text="Reset" />
                            </div>

                        </div>
                      
                             <div class="app-table mt-2">
                            
                               <div class="table-responsive">
                                 
                                  <asp:HiddenField ID="docflag" runat="server" />
                <asp:GridView ID="GrdVwLabelRequest" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-hover mb-0"
                    DataKeyNames="Flag" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                    EnableModelValidation="True" AllowPaging="True" PageSize="15" OnRowCommand="GrdVwLabelRequest_RowCommand"
                    OnPageIndexChanging="GrdVwLabelRequest_PageIndexChanging">
                    <Columns>
                        <asp:TemplateField HeaderText="Tracking No.">
                            <ItemTemplate>
                                <asp:Label runat="server" ID="lblTracking" Text='<%# Bind("Tracking_No") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle/>
                            <ItemStyle/>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Request Date">
                            <ItemTemplate>
                                <asp:Label ID="lblreqdate" runat="server" Text='<%# Bind("RequestDate") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle/>
                            <ItemStyle />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product Name">
                            <ItemTemplate>
                                <asp:Label ID="lblactudate" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle />
                            <ItemStyle />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Label Type">
                            <ItemTemplate>
                                <asp:Label ID="lbllblnamesize" runat="server" Text='<%# Bind("LabelType") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle/>
                            <ItemStyle />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Size">
                            <ItemTemplate>
                                <asp:Label ID="lbllabelsiZe" runat="server" Text='<%# Bind("Label_Size") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle/>
                            <ItemStyle />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Price/Label">
                            <ItemTemplate>
                                <asp:Label ID="lblproprice" runat="server" Text='<%# Bind("Label_Prise") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle/>
                            <ItemStyle/>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Req. Label(s)">
                            <ItemTemplate>
                                <asp:Label ID="lbldiscrip" runat="server" Text='<%# Bind("RequestedLabels") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle/>
                            <ItemStyle />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="lblrequeststatusdiscrip" runat="server" Text='<%# Bind("RequestStatusFlag") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle/>
                            <ItemStyle/>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <%try
                                  {
                                      pflag = Convert.ToInt32(GrdVwLabelRequest.DataKeys[index].Values["Flag"].ToString());
                                  }
                                  catch { }
                                  if (pflag == 0)
                                  {  
                                %>
                                <asp:ImageButton ID="Imgprintcancellabel" runat="server" ImageUrl="~/Content/images/Erase.png"
                                    Height="12px" CausesValidation="false" Width="12px" CommandName="RequestCancel"
                                    CommandArgument='<%# Bind("Row_ID") %>' ToolTip="Request Cancel" />
                                <%} %>
                                <%index++; %>
                            </ItemTemplate>
                            <HeaderStyle />
                            <ItemStyle />
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle />
                    <AlternatingRowStyle />
                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
                   <!--PopUp Starts-->
                <!-- Pop Alert -->
                <asp:Label ID="lblproiddel" runat="server" Visible="false"></asp:Label>
                <asp:Panel ID="PanelPrintRequest" runat="server" Width="30%" style="display:none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnRequestpopClose" CssClass="popupClose" runat="server" /></div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="LblRequestPrintHeader" runat="server" Font-Bold="true" Text="Request for print label"></asp:Label>
                                    </span>
                                </p>
                            </div>
                            <div class="regis_popup">
                                <div id="Div1" runat="server" style="width: 86% !important;">
                                    <p>
                                        <asp:Label ID="Label1" runat="server"></asp:Label></p>
                                </div>
                                <div id="DivNewMsg" runat="server" style="width: 85%;">
                                    <p>
                                        <asp:Label ID="LabelRequestmsg" runat="server"></asp:Label></p>
                                </div>
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="right">
                                            <asp:RequiredFieldValidator ID="RequiredFieldproductListValidator1" runat="server"
                                                InitialValue="--Select--" ForeColor="Red" ValidationGroup="reqlbl" ControlToValidate="ddlprotype"></asp:RequiredFieldValidator>
                                            <strong><span class="astrics">*</span>Product Name :</strong>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlprotype" runat="server" CssClass="drp" Width="95%" Style="text-transform: capitalize;"
                                                OnSelectedIndexChanged="ddlprotype_SelectedIndexChanged" AutoPostBack="true">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:RequiredFieldValidator ID="RequiddvvredFieldValidator2" runat="server" InitialValue="--Select--"
                                                ForeColor="Red" ValidationGroup="reqlbl" ControlToValidate="ddlLabelType"></asp:RequiredFieldValidator>
                                            <strong><span class="astrics">*</span>Label Type :</strong>
                                        </td>
                                        <td>
                                            <asp:Label ID="lblTypeNew1" runat="server"></asp:Label>
                                            <asp:DropDownList ID="ddlLabelType" runat="server" CssClass="drp" Width="95%" Style="text-transform: capitalize;"
                                                Visible="false">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <asp:RequiredFieldValidator ID="RequiredFdfvgieldValidator3" runat="server" ValidationGroup="reqlbl"
                                                ControlToValidate="txtNoofLabel"></asp:RequiredFieldValidator>
                                            <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" TargetControlID="txtNoofLabel"
                                                runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-.,/',./';<>?:abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ">
                                            </cc1:FilteredTextBoxExtender>
                                            <strong><span class="astrics">*</span>No. of Requested Label :</strong>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtNoofLabel" MaxLength="10" runat="server" CssClass="text_box_small"
                                                onchange="FindAllGrandT(this.value)"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="right">
                                            <strong><span class="astrics">*</span>Net Amount (GST) :</strong>
                                        </td>
                                        <td style=" text-align:left; padding-left:5px;">
                                            (<asp:Label ID="lblGrandTotal" runat="server" />)
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 10px;">
                                            <asp:HiddenField ID="HdLabelCodeRequest" runat="server" />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="text-align: right;">
                                            <asp:Button ID="btnRequestSend" runat="server" OnClick="btnRequestSend_Click" CssClass="button_all"
                                                Text="Send Request" ValidationGroup="reqlbl" />&nbsp;&nbsp;
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupExtenderRequest" runat="server" BackgroundCssClass="NewmodalBackground"
                    PopupControlID="PanelPrintRequest" TargetControlID="LabelRequestC" CancelControlID="btnRequestpopClose">
                </cc1:ModalPopupExtender>
                <asp:Label ID="LabelRequestC" runat="server"></asp:Label>
                <!--PopUp Close-->
                <!--===============================PopUp Alert Starts===============================-->
                <asp:Panel ID="PanelAlert" runat="server" Width="20%" CssClass="card p-3 shadow">
                    <div class="popupContent">
                        <div class="pop_log_bg">
                            <div class="position-absolute top-0 start-100 translate-middle">
                                <asp:Button ID="btnAlertPnlClose" Text="&#x2715;" CssClass="btn btn-danger btn-sm" runat="server" CausesValidation="false" /></div>
                            <!--<fieldset class="service_field" >-->
                            <!-- <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="LabelAlertheader" runat="server" Text="Password"></asp:Label>
                                    </span><span class="right" style="visibility: hidden;"><span class="astrics"><strong>
                                    </strong></span></span>
                                </p>
                            </div> -->
                            <div class="regis_popup mt-2 text-center">
                               
                                <asp:Label ID="LabelAlertText" runat="server" Text=""></asp:Label>
                               
                                <asp:Button ID="btnYes" runat="server" Text="Yes" class="btn btn-primary btn-sm w-100 mt-2" OnClick="btnYes_Click" />
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <asp:Label ID="Label12" runat="server"></asp:Label><asp:Label ID="LabelCalText" runat="server"
                    Visible="false"></asp:Label>
                <cc1:ModalPopupExtender ID="ModalPopupExtenderAlert" runat="server" BackgroundCssClass="NewmodalBackground"
                    CancelControlID="btnAlertPnlClose" PopupControlID="PanelAlert" TargetControlID="Label12">
                </cc1:ModalPopupExtender>
                <!--===============================Popup Close================================-->
                <div>
                    <asp:Label ID="lblRequestLabelID" runat="server" Visible="false"></asp:Label>
                    <asp:HiddenField ID="hdNoofCodes" runat="server" />
                    <asp:HiddenField ID="HiddenFieldProNm" runat="server" />
                    <asp:HiddenField ID="HiddenFieldLabelType" runat="server" />
                </div>
        </div>

            </ContentTemplate>
        <Triggers>
        </Triggers>
    </asp:UpdatePanel>
      
    <script type="text/javascript">
        function performSearch(searchText) {
            $('#ctl00_ContentPlaceHolder1_GrdVwLabelRequest tbody tr').each(function () {
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

