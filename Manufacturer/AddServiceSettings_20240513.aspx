<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="AddServiceSettings.aspx.cs"
     Inherits="Manufacturer_AddServiceSettings" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script>

        function isrange(evt) {
         
                       if (evt.keyCode >= 48 && evt.keyCode <= 57)
                return true;
            if (evt.keyCode == 8)
                return true;
            if (evt.keyCode == 45)
                return true;
            return false;
        }

        function FillAvailable(val) {
            var Arr = val.toString().split('*');
        
            if (Arr.length > 1) {
                if (parseFloat(Arr[2]) == 0) {
                    if (parseFloat(Arr[1]) == 0)
                        document.getElementById("<%=lbltotqty.ClientID %>").innerHTML = "Not Available";
                    else {
                        
                        document.getElementById("<%=lbltotqty.ClientID %>").innerHTML = Arr[1].toString();
                    }
                }
                else
                    document.getElementById("<%=lbltotqty.ClientID %>").innerHTML = "Mannual";
            }
            else
                document.getElementById("<%=lbltotqty.ClientID %>").innerHTML = "";

            var Arr2 = val.toString().split('*');
            if (Arr2.length == 4) {
                document.getElementById("<%=lblCouponRequest_ID.ClientID %>").innerHTML = Arr2[3].toString();
            }
            //alert("<=lblCouponRequest_ID.Text %>");
        }
        function CheckZero(val) {
            if (parseFloat(val) == 0)
                document.getElementById("<%=txtfrequency.ClientID %>").value = "";
        }

        function GetSubscription()
        {
          
            var flg = true;
            var vl = "*" + document.getElementById("<%=ddlService.ClientID %>").value;
            if (document.getElementById("<%=ddlProduct.ClientID %>").value != '--Select--')
                vl = document.getElementById("<%=ddlProduct.ClientID %>").value + "*" + document.getElementById("<%=ddlService.ClientID %>").value;
            if (document.getElementById("<%=ddlseriesstart.ClientID %>").value != '')
            {
                if (!(document.getElementById("<%=ddlseriesstart.ClientID %>").value.includes('-'))) {
                    flg = false;
                    alert("Please enter valid start series");
                }
                else {
                    var arr = document.getElementById("<%=ddlseriesstart.ClientID %>").value.split('-');
                    if (arr[0] != '' && arr[1] != '') {
                        vl = vl + "*" + document.getElementById("<%=ddlseriesstart.ClientID %>").value
                    }
                    else {
                        alert("Please enter valid start series");
                        flg = false;
                    }
                }
            }
            else {
                alert("Please enter start series");
                flg = false;
            }
            
            if (document.getElementById("<%=ddlseriesend.ClientID %>").value != '') {
                if (!(document.getElementById("<%=ddlseriesend.ClientID %>").value.includes('-'))) {
                    flg = false;
                    alert("Please enter valid end series");
                }
                else {
                    var arr = document.getElementById("<%=ddlseriesend.ClientID %>").value.split('-');
                    if (arr[0] != '' && arr[1] != '')
                        vl = vl + "," + document.getElementById("<%=ddlseriesend.ClientID %>").value
                    else
                        flg = false;
                }
            }
            else {
                alert("Please enter start series");
                flg = false;
            }
          
            if(flg)
            PageMethods.checkGetSubscription(vl, ValidateGetSubscription);
                
        }
        function ValidateGetSubscription(Result) {
            var Arr = Result.toString().split('*');
            if (Arr[0] == "true") {
                document.getElementById("<%=selsrvplanid.ClientID %>").value = Arr[2].toString();
                document.getElementById("<%=lblsrvdtfrndto.ClientID %>").innerHTML = Arr[1].toString();
                //document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                //document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";
            }
            else {
                document.getElementById("<%=lblsrvdtfrndto.ClientID %>").innerHTML = "Please subscribe service fisrt.";
                //document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                //document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";
            }
        }
        function CheckDateExist(val) {
            var vl = "*" + document.getElementById("<%=ddlService.ClientID %>").value + "*" + val;
            if (document.getElementById("<%=ddlProduct.ClientID %>").value != '--Select--')
                vl = document.getElementById("<%=ddlProduct.ClientID %>").value + "*" + document.getElementById("<%=ddlService.ClientID %>").value + "*" + val;
            PageMethods.checkGetDateIsExist(vl, IsDateFromExist)
        }
        function CheckDateExistNew(val) {
            var vl = "*" + document.getElementById("<%=ddlService.ClientID %>").value + "*" + val;
            if (document.getElementById("<%=ddlProduct.ClientID %>").value != '--Select--')
                vl = document.getElementById("<%=ddlProduct.ClientID %>").value + "*" + document.getElementById("<%=ddlService.ClientID %>").value + "*" + val;
            PageMethods.checkGetDateIsExistNew(vl, IsDateFromExist)
        }
        function IsDateFromExist(Result) {
            var Arr = Result.toString().split('*');
            if (Arr[0] == "true") {
                document.getElementById("<%=lblsrvdtrngmsg.ClientID %>").innerHTML = Arr[1].toString();
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";

            }
            else {
                document.getElementById("<%=lblsrvdtrngmsg.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <asp:Label ID="LblTargetLoyalty" runat="server"></asp:Label>
    <asp:Label Text="" ID="lblCouponRequest_ID" Visible="false" runat="server" />
                <asp:HiddenField ID="hdnloyalty" runat="server" />
     <asp:HiddenField ID="selsrvid" runat="server" />
                <asp:HiddenField ID="selsrvplanid" runat="server" />
     <asp:HiddenField ID="hhdnCompID" runat="server" />
      <asp:HiddenField ID="hdneditval" runat="server" />
                <asp:HiddenField ID="ActionText" runat="server" />
                <asp:HiddenField ID="IsAct" runat="server" />
                <asp:Label ID="lblproiddel" runat="server" Visible="false"></asp:Label>
                <asp:HiddenField ID="currindex" runat="server" />
                <asp:HiddenField ID="lblproidamc" runat="server" />
               <%-- <asp:HiddenField ID="HiddenField1" runat="server" />
                <asp:HiddenField ID="HiddenField2" runat="server" />
                <asp:HiddenField ID="HiddenField3" runat="server" />--%>

    <asp:HiddenField ID="hdnprizetransid" runat="server" />
                <asp:HiddenField ID="hdnsstid" runat="server" />
                <asp:HiddenField ID="hdnisaddi" runat="server" />
                <asp:HiddenField ID="docflag" runat="server" />
                <asp:HiddenField ID="HdFieldAmcId" runat="server" />
                <asp:HiddenField ID="HdFieldOfferId" runat="server" />
                <asp:HiddenField ID="hdnpointsval" runat="server" />
     <div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
                 <asp:label id="lbltestcontrol" runat="server"></asp:label>
          <asp:label id="lblctrlplgrw" runat="server"></asp:label>
                <div class="card card-admin form-wizard profile box_card">


                    <header class="card-header">
                        <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Add/Edit Service Settings</h4>
                    </header>

                     

                    <div  class="card-body card-body-nopadding">
                        <div id="DivMsg" runat="server">
                                    <p>
                                        <asp:Label ID="LblMsgBody" runat="server"></asp:Label></p>
                                </div>
                     <div id="NewMsgpop" runat="server">
                             <div id="cpn" runat="server"></div>
                                <p>
                                
                                    <asp:Label ID="Label2" runat="server"></asp:Label> 
                                </p>
                            </div>
                        <div class="form-row">
                            <div class="form-group col-lg-6">
                                <asp:Label ID="lblsrvdtrngmsg" runat="server" ForeColor="Red" Font-Bold="true" Font-Size="10pt"></asp:Label>
                                <asp:Label ID="lblsrvdtfrndto" runat="server" ForeColor="Green" Font-Bold="true"
                                    Font-Size="10pt"></asp:Label>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-lg-3">
                                <span class="req">*</span><label>Select Service</label>
                                  </div><div class="form-group col-lg-6">
                                <asp:DropDownList ID="ddlService" runat="server" class="form-control form-control-sm"
                                    AutoPostBack="true" OnSelectedIndexChanged="ddlService_SelectedIndexChanged">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage="*" ForeColor="Red"
                                    runat="server" ControlToValidate="ddlService"
                                    ValidationGroup="SRVS" InitialValue="0"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-lg-3">
                                <span class="req">*</span><label>Product</label>
                            </div>
                            <div class="form-group col-lg-6">
                                <asp:DropDownList ID="ddlProduct" runat="server" class="form-control form-control-sm" AutoPostBack="True" OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged">
                                </asp:DropDownList>
                            </div>
                            <div class="form-group col-lg-3">
                                <a href="RegisteredProduct.aspx?Parm=New" class="btn btn-success" title="Add New Product">
                                    <!--<img  alt="" src="../Content/images/add_new.png" />-->
                                    <i class="fa fa-plus"></i>
                                </a>
                                <asp:RequiredFieldValidator ID="RFVPro" runat="server" ForeColor="Red" ValidationGroup="SRVS" ErrorMessage="*"
                                    InitialValue="--Select--" ControlToValidate="ddlProduct">
                                </asp:RequiredFieldValidator>
                            </div>
 <div class="form-group col-lg-3" runat="server" id="serieslabel">
                                <span class="req">*</span><label>Series Range</label>
                            </div>
                             <div class="form-group col-lg-3" id="seriestart" runat="server">
                               <%-- <asp:DropDownList ID="ddlseriesstart" runat="server"  class="form-control form-control-sm">
                                </asp:DropDownList>--%>
                                 <asp:TextBox ID="ddlseriesstart" runat="server" placeholder="0-0"   class="form-control form-control-sm" onkeypress="return isrange(event)" ></asp:TextBox>
                            </div>
                            <div class="form-group col-lg-3" id="seriesend" runat="server">
                               <%-- <asp:DropDownList ID="ddlseriesend" runat="server" onchange="javascript:GetSubscription();" class="form-control form-control-sm">
                                </asp:DropDownList>--%>
                                 <asp:TextBox ID="ddlseriesend" runat="server" placeholder="0-0" class="form-control form-control-sm" onfocusout="javascript:GetSubscription();" onkeypress="return isrange(event)" ></asp:TextBox>
                            </div>
                        </div>
                        <div class="form-row">
                            <div class="form-group col-lg-3">
                                <span class="req">*</span><label>Date Range</label>
                            </div>
                            <div class="form-group col-lg-3">
                                <asp:TextBox ID="txtloyaltydtfrom" class="form-control form-control-sm" runat="server"
                                    placeholder="Date From.." onchange="javascript:CheckDateExist(this.value);"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RFVIsDateFrom" runat="server" ForeColor="Red" ValidationGroup="NN" ErrorMessage="*"
                                    ControlToValidate="txtloyaltydtfrom">
                                </asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group col-lg-3">
                                <asp:TextBox ID="txtloyaltydtto" class="form-control form-control-sm" runat="server"
                                    onchange="javascript:CheckDateExistNew(this.value);" placeholder="Date To.."></asp:TextBox>
                                <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="LOY"
                                    ControlToCompare="txtloyaltydtfrom" ControlToValidate="txtloyaltydtto" ForeColor="Red"
                                    Type="Date" Operator="GreaterThanEqual" ErrorMessage="Date To must be less than Date From"></asp:CompareValidator>


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

                            </div>
                        </div>

                         <div class="form-row" id="divWarranty" runat="server" visible="false" >
                              <div class="form-group col-lg-3">
                                     <span class="req">*</span><label>Warranty Peroid (months)</label>
                                  </div>
                                   <div class="form-group col-lg-3">
                                   <asp:TextBox ID="txtWarranty" runat="server" CssClass="form-control form-control-sm"   onkeypress="return isNumberKey(this, event);" MaxLength="2"  ></asp:TextBox>
                                         <%--  <span id="lbliscash"></span>--%>
                                   <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red" ValidationGroup="NN" ErrorMessage="*"
                                                ControlToValidate="txtWarranty">
                                            </asp:RequiredFieldValidator>
                                       </div>
                                        <div class="form-group col-lg-6"> &nbsp;&nbsp;&nbsp;&nbsp;
                                     
                                            
                              
                                  </div>
                              </div>

                         <div class="form-row" id="divPU" runat="server" visible="false">
                            <div class="form-group col-lg-12">
                                <span class="req">*</span><label> <b>Please select below channels as per reach to end customer</b> </label>
                            </div>
                             </div>
                        <div class="form-row" id="divPU2" runat="server" visible="false">
                            <div class="form-group col-lg-2">
                                <asp:CheckBox ID="CheckBox1" runat="server" Text="Production Unit" class="form-control form-control-sm"></asp:CheckBox>
                                <br />
                                <asp:DropDownList ID="ddlPUname" runat="server" class="form-control form-control-sm">
                                </asp:DropDownList>
                               
                            </div>
                            <div class="form-group col-lg-2">
                                <asp:CheckBox ID="CheckBox2" runat="server" Text="Warehouse" class="form-control form-control-sm"></asp:CheckBox>
                                <br />
                                <asp:DropDownList ID="ddlchnls" runat="server" class="form-control form-control-sm">
                                </asp:DropDownList>
                            </div>
                              <div class="form-group col-lg-2">
                                 <asp:CheckBox ID="CheckBox5" runat="server" Text="Manager" class="form-control form-control-sm"></asp:CheckBox>
                                <br />
                                <asp:DropDownList ID="ddlM" runat="server" class="form-control form-control-sm">
                                </asp:DropDownList>
                             <%--   <asp:CheckBoxList ID="chkTT" runat="server" RepeatDirection="Horizontal" RepeatColumns="1" class="form-control form-control-sm">
                                </asp:CheckBoxList>--%>
                            </div>
                            <div class="form-group col-lg-2">
                                 <asp:CheckBox ID="CheckBox3" runat="server" Text="Distributor" class="form-control form-control-sm"></asp:CheckBox>
                                <br />
                                <asp:DropDownList ID="ddlDis" runat="server" class="form-control form-control-sm">
                                </asp:DropDownList>                            
                            </div>
                               <div class="form-group col-lg-2">
                                   <asp:CheckBox ID="CheckBox4" runat="server" Text="Sub-Distributor" class="form-control form-control-sm"></asp:CheckBox>
                                <br />
                                <asp:DropDownList ID="ddlSDis" runat="server" class="form-control form-control-sm">
                                </asp:DropDownList>
                               </div>
                            <div class="form-group col-lg-2">
                                 <asp:CheckBox ID="CheckBox6" runat="server" Text="Retailer" class="form-control form-control-sm"></asp:CheckBox>
                                <br />
                                <asp:DropDownList ID="ddlret" runat="server" class="form-control form-control-sm">
                                </asp:DropDownList>  
                                 <br />
                                <asp:Button ID="btnGo" runat="server" Text="Go"  class="btn btn-primary float-left mt-10"
                                       OnClick="btnGo_Click" />                          
                            </div>
                           
                        </div>
                        <div class="form-row" id="divPU3" runat="server" visible="false">
                           <%-- <div class="form-group col-lg-2">
                            </div>--%>
                            <div class="form-group col-lg-12">
                                <div class="col-lg-12 card card-admin form-wizard medias">
                                  
                                    <asp:GridView ID="GrdVw" runat="server" AutoGenerateColumns="False" CssClass="tableSetting table-striped"
                                        EmptyDataText="Record Not Found" BorderColor="transparent" OnRowCommand="GrdVw_RowCommand" OnRowDataBound="GrdVw_RowDataBound">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Order">
                                                <ItemTemplate>
                                                    <asp:ImageButton id="imgbtnUp" CommandArgument='<%#Container.DataItemIndex%>'  CommandName="up" ImageUrl="~/images/arrow-up.png" Height="10px" runat="server" />
                                                    
                                                    <asp:ImageButton id="imgbtnDown" CommandArgument='<%#Container.DataItemIndex%>' CommandName="down" ImageUrl="~/images/arrow-down.png" runat="server" Height="10px" />
                                                </ItemTemplate> 
                                              
                                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="7%" />
                                            </asp:TemplateField>
                                             <asp:TemplateField HeaderText="Sequence" Visible="false">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblContLabel" runat="server" />                                                
                                                   
                                                </ItemTemplate>
                                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Channels">
                                                <ItemTemplate>
                                                    <asp:CheckBox ID="lblTypeName" Checked='<%#Eval("ischecked")%>'  runat="server" Text='<%# Bind("Type") %>'></asp:CheckBox>    
                                                    <asp:Label id="lblTTUserTypeid" Text='<%#Eval("TTUserTypeid")%>' Visible="false" runat="server" />    
                                                    <asp:Label id="lblTypevalue" Text='<%#Eval("Typevalue")%>' Visible="false" runat="server" />                                           
                                                </ItemTemplate>
                                               
                                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Channels Name/Channel User">
                                                <ItemTemplate>
                                                    <asp:DropDownList runat="server" ID="ddl1" class="form-control form-control-sm">
                                                    </asp:DropDownList>                                       
                                                </ItemTemplate>
                                               
                                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Action" Visible="false">
                                                <ItemTemplate>
                                                    <asp:ImageButton ID="ImgbtnEditCourier" runat="server" ImageUrl="~/Content/images/edit.png"
                                                        CommandName="EditRow" CommandArgument='<%# Bind("TTUserTypeid") %>' ToolTip="Edit Gift"
                                                        CausesValidation="false" />&nbsp;
                                    
                                        <asp:ImageButton ID="ImgbtnDel" runat="server" ImageUrl="~/Content/images/delete.png"
                                            CommandName="DeleteRow" CommandArgument='<%# Bind("TTUserTypeid") %>' ToolTip="Delete Gift"
                                            OnClientClick="return confirm('Are you sure you want to delete?');" />
                                                   
                                                </ItemTemplate>
                                              
                                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="10%" />
                                                  
                                            </asp:TemplateField>
                                            
                                        </Columns>
                                        <EmptyDataRowStyle HorizontalAlign="Center" />                                      
                                    </asp:GridView>
                                    <asp:Label ID="lblBankId" runat="server" Text="" Visible="false"></asp:Label>
                                    <asp:HiddenField ID="dhnactiontype" runat="server" />
                                </div>
                            </div>
                           <%-- <div class="form-group col-lg-2">
                            </div>--%>

                        </div>
                                  <div class="form-row" id="divisreferral" runat="server">
                            <div class="form-group col-lg-3">
                                <span class="req">*</span><label>Referral Gift Type</label>
                            </div>
                            <div class="form-group col-lg-6">
                                <asp:RadioButton ID="rdIsRefCash" runat="server" Text="&nbsp;Cash&nbsp;&nbsp;" GroupName="REF" class="form-control form-control-sm"
                                    AutoPostBack="false" OnCheckedChanged="rdReferral_CheckedChanged" Visible="false" />
                                <asp:RadioButton ID="rdIsRefPoints" runat="server" Text="&nbsp;Points&nbsp;&nbsp;" class="form-control form-control-sm"
                                    GroupName="REF" AutoPostBack="false" OnCheckedChanged="rdReferral_CheckedChanged" Visible="false" />
                                <asp:RadioButton ID="rdIsRefGift" runat="server" Text="&nbsp;Gift&nbsp;&nbsp;" GroupName="REF" class="form-control form-control-sm"
                                    AutoPostBack="false" OnCheckedChanged="rdReferral_CheckedChanged" Visible="false" />
                            </div>
                        </div>


                        <div class="form-row" id="divpoinscash" runat="server">
                            <div class="form-group col-lg-3">
                                <span class="req"></span>
                              
                                    <asp:Label ID="lblrefHead" runat="server" Text="Cash"></asp:Label>
                            </div>
                            <div class="form-group col-lg-3">
                                <asp:TextBox ID="txtreffrom" class="form-control form-control-sm" onkeypress="return isNumberKey(this, event);"
                                    placeholder="For Referral" runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'5');"
                                    ToolTip="Enter Frequency to win alternet rewards points" onchange="javascript:CheckZero(this.value);"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="Reqreffrom" runat="server" ForeColor="Red" ValidationGroup="NN"
                                    ControlToValidate="txtreffrom" ErrorMessage="*">
                                </asp:RequiredFieldValidator>
                                    </div>
                                 <div class="form-group col-lg-3">
                                <asp:TextBox ID="txtrefto" class="form-control form-control-sm"
                                    onkeypress="return isNumberKey(this, event);" runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'5');"
                                    ToolTip="Enter Frequency to win alternet rewards points" placeholder="For Users"
                                    onchange="javascript:CheckZero(this.value);"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="Reqrefto" runat="server" ForeColor="Red" ValidationGroup="NN" ControlToValidate="txtrefto" ErrorMessage="*">
                                </asp:RequiredFieldValidator>
                                      </div>
                                 <div class="form-group col-lg-3">
                                <asp:CheckBox ID="chkRefIsCash" runat="server" Text="&nbsp;&nbsp;Is Point to Cash" Visible="false" />
                            </div>
                        </div>

                        <div class="form-row" id="divrefGift" runat="server">
                            <div class="form-group col-lg-3">
                                <span class="req"></span>
                                <label>Gift</label>
                            </div>
                            <div class="form-group col-lg-3">
                                <asp:DropDownList ID="ddlrefGiftFrom" class="form-control form-control-sm" runat="server"
                                    ToolTip="Seelct Gift to win Referals" onchange="javascript:CheckZero(this.value);">
                                </asp:DropDownList>
                            </div>
                            <div class="form-group col-lg-3">
                                <asp:DropDownList ID="ddlrefGiftTo" class="form-control form-control-sm"
                                    runat="server" ToolTip="Seelct Gift to win Users">
                                </asp:DropDownList>
                            </div>
                        </div>

                        <div class="form-row" id="divtxtReferralLimit" runat="server">
                            <div class="form-group col-lg-3">
                                <span class="req"></span>
                                <label>Limit/User</label>
                            </div>
                            <div class="form-group col-lg-6">
                                <asp:TextBox ID="txtReferralLimit" class="form-control form-control-sm" onkeypress="return isNumberKey(this, event);"
                                    MaxLength="5"
                                    runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'2');" ToolTip="Enter can refer upto user (limit/user)"
                                    onchange="javascript:CheckZero(this.value);"></asp:TextBox>
                            </div>
                        </div>

                           <div class="form-row" id="divisfrequency" runat="server">
                              <div class="form-group col-lg-3">
                                     <span class="req"></span><label>Frequency</label>
                                  </div>
                                <div class="form-group col-lg-6">
                                   <asp:TextBox ID="txtfrequency" class="form-control form-control-sm" onkeypress="return isNumberKey(this, event);"
                                       runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'2');" ToolTip="Enter Frequency to win alternet rewards points"
                                       onchange="javascript:CheckZero(this.value);"></asp:TextBox>
                               </div>
                             </div>

                         <div class="form-row" id="amounttype" runat="server">
                            <div class="form-group col-lg-3">
                                <span class="req">*</span><label>Select Loyalty Type</label>
                                  </div><div class="form-group col-lg-6">
                                <asp:DropDownList ID="ddlamttype" runat="server" class="form-control form-control-sm"
                                    AutoPostBack="true" OnSelectedIndexChanged="ddlamttype_SelectedIndexChanged" >
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ErrorMessage="*" ForeColor="Red"
                                    runat="server" ControlToValidate="ddlamttype"
                                    ValidationGroup="SRVS" InitialValue="0"></asp:RequiredFieldValidator>
                            </div>
                        </div>
                        <div class="form-row" id="divispoints" runat="server" >
                              <div class="form-group col-lg-3">
                                     <span class="req">*</span><label>Points</label>
                                  </div>
                                   <div class="form-group col-lg-3">
                                   <asp:TextBox ID="txtloyaltypoints" class="form-control form-control-sm"  runat="server"
                                                onkeyDown="return checkTextAreaMaxLength(this,event,'5');"></asp:TextBox>
                                         <%--  <span id="lbliscash"></span>--%>
                                   <asp:RequiredFieldValidator ID="RFVIsPoints" runat="server" ForeColor="Red" ValidationGroup="NN" ErrorMessage="*"
                                                ControlToValidate="txtloyaltypoints">
                                            </asp:RequiredFieldValidator>
                                       </div>
                                        <div class="form-group col-lg-6"> &nbsp;&nbsp;&nbsp;&nbsp;
                                       <asp:CheckBox Text="&nbsp;&nbsp;Convert to Cash"
                                                    runat="server" ID="chkconvert"   class="form-check-input"/>
                                            
                              
                                  </div>
                              </div>
                           <div class="form-row" id="diviscash" runat="server">
                              <div class="form-group col-lg-3">
                                     <span class="req"></span><label>Cash</label>
                                  </div>
                              <div class="form-group col-lg-6">
                                  <asp:TextBox ID="txtcashamt" class="form-control form-control-sm" onkeypress="return isNumberKey(this, event);"
                                                runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'4');" 
                                      ToolTip="Enter Frequency to win alternet rewards points"
                                                onchange="javascript:CheckZero(this.value);"></asp:TextBox>
                                    <asp:RequiredFieldValidator ID="RFVIsCash" runat="server" ForeColor="Red" ValidationGroup="NN" ErrorMessage="*"
                                                ControlToValidate="txtcashamt">
                                            </asp:RequiredFieldValidator>
                              </div>
                             </div>

                        <div class="form-row" id="divrange" runat="server">
                              <div class="form-group col-lg-3">
                                     <span class="req"></span><label>Max Loyalty</label>
                                  </div>
                             <div class="form-group col-lg-6">
                                  <asp:TextBox ID="txttotalamount" class="form-control form-control-sm" onkeypress="return isrange(event)"
                                                runat="server"
                                      ToolTip="Enter Total Amount"
                                                onchange="javascript:CheckZero(this.value);" ></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="reqamount" runat="server" ForeColor="Red" ValidationGroup="NN" ErrorMessage="*"
                                                ControlToValidate="txttotalamount">
                                            </asp:RequiredFieldValidator>
                                    
                              </div>
                            </div>
                        <div class="form-row" id="divrange1" runat="server">
                            <div class="form-group col-lg-3">
                                     <span class="req"></span><label>Loyalty Range</label>
                                  </div>
                              <div class="form-group col-lg-6">
                                  <asp:TextBox ID="txtrangeval" class="form-control form-control-sm" 
                                                runat="server" 
                                      ToolTip="Enter  Range Value"
                                                onchange="javascript:CheckZero(this.value);" onkeypress="return isrange(event)"></asp:TextBox>
                                   <asp:RequiredFieldValidator ID="reqrange" runat="server" ForeColor="Red" ValidationGroup="NN" ErrorMessage="Enter a valid Range"
                                                ControlToValidate="txtrangeval">
                                            </asp:RequiredFieldValidator>
                           
                                   </div>
                            </div>
                          <div class="form-row" id="stepvalue" runat="server">
                              <div class="form-group col-lg-3">
                                     <span class="req"></span><label>Step Value</label>
                                  </div>
                            <div class="form-group col-lg-6">
                                         <asp:TextBox ID="txtmultiple" class="form-control form-control-sm" 
                                                runat="server" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" 
                                      ToolTip="Enter ste value for range"
                                                onchange="javascript:CheckZero(this.value);"  onkeypress="return isrange(event)"></asp:TextBox>
                                   <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red" ValidationGroup="NN" ErrorMessage="Enter a valid value"
                                                ControlToValidate="txtmultiple">
                                            </asp:RequiredFieldValidator>
                             
                             </div>
                            </div>

                        </div>
                    <div class="card-body card-body-nopadding" id="divisAdditionalGift" runat="server">
                           <h6>Additional Gift Details</h6>
                        <div class="form-row">
                         
                            <div class="form-group col-lg-3">
                                <span class="req"></span>
                                <label>Service Type</label>
                                </div>
                                 <div class="form-group col-lg-2">
                                <asp:RadioButton ID="rdInstant" runat="server" GroupName="TP" Checked="true" AutoPostBack="true" Text="&nbsp;&nbsp;Instant"
                                    OnCheckedChanged="rdInstant_CheckedChanged"  />
                                <%--   <asp:Label ID="Label2" AssociatedControlID="rdInstant" runat="server" Text="Instant"
                                    CssClass="CheckBoxLabel"></asp:Label>--%>
                                     </div>
                                   
                            <div class="form-group col-lg-2">
                                <asp:RadioButton ID="rdAtDueDate" runat="server" GroupName="TP" AutoPostBack="true" 
                                    OnCheckedChanged="rdInstant_CheckedChanged" Text="&nbsp;At&nbsp;Due&nbsp;Date" />
                                <%-- <asp:Label ID="Label4" AssociatedControlID="rdAtDueDate" runat="server" Text="At&nbsp;Due&nbsp;Date"
                                                                            CssClass="CheckBoxLabel"></asp:Label>--%>
                                </div>
                                 <div class="form-group col-lg-2">
                                <asp:TextBox ID="txtDueDate" class="form-control form-control-sm" onkeypress="return isNumberKey(this, event);"
                                    placeholder="Lucky draw date" runat="server" onchange="javascript:CheckDateExist(this.value);"
                                    ToolTip="Enter lucky draw date"></asp:TextBox>

                                <cc1:CalendarExtender ID="CalendarExtendertxtDueDate" runat="server" TargetControlID="txtDueDate"
                                    Format="dd/MM/yyyy">
                                </cc1:CalendarExtender>
                                <cc1:MaskedEditExtender ID="MaskedEditExtendertxtDueDate" runat="server" TargetControlID="txtDueDate"
                                    Mask="99/99/9999" MaskType="Date">
                                </cc1:MaskedEditExtender>
                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtendertxtDueDate" runat="server" TargetControlID="txtDueDate"
                                    WatermarkText="Lucky draw date">
                                </cc1:TextBoxWatermarkExtender>
                            </div>
                           
                        </div>
                            <div class="form-row">
                                 <div class="form-group col-lg-3">
                                <span class="req"></span>
                                <label>Rewards Distributions</label>
                                     </div>
                                     <div class="form-group col-lg-2">
                                           <asp:RadioButton ID="rdRandomDistri" runat="server" GroupName="RD" Checked="true" AutoPostBack="true" Text="&nbsp;&nbsp;Randon"
                                    OnCheckedChanged="rdRandomDistri_CheckedChanged"  />                               
                            </div>
                            <div class="form-group col-lg-2">
                                <asp:RadioButton ID="rdSequenceDistri" runat="server" GroupName="RD" AutoPostBack="true" Text="&nbsp;Sequence"
                                    OnCheckedChanged="rdRandomDistri_CheckedChanged" />
                                <%-- <asp:Label ID="Label10" AssociatedControlID="rdSequenceDistri" runat="server" Text="Sequence"
                                                                            CssClass="CheckBoxLabel"></asp:Label>--%>
                            </div>
                            </div>
                             <div class="form-row">        
                                 <h6> Paricipants</h6>                 
                                  <span class="req"></span>
                                
                             </div>
                        
                        <div class="form-row" id="divinstant" runat="server">
                          
                           
                            <div class="form-group col-lg-3">
                                <asp:RadioButton ID="rdFirstnth" runat="server" GroupName="RL" Checked="true" AutoPostBack="true" Text="&nbsp;First 'n' Participants"
                                    OnCheckedChanged="rdAllParticipant_CheckedChanged"  />
                                 </div>
                            <div class="form-group col-lg-3">
                                 <asp:TextBox ID="txttcodes" runat="server" class="form-control form-control-sm" onkeypress="return isNumberKey(this, event);"
                                    AutoPostBack="true" OnTextChanged="GetWinners_TextChanged"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqtcodes" runat="server" ForeColor="Red" ValidationGroup="NN" ErrorMessage="*"
                                    ControlToValidate="txttcodes"></asp:RequiredFieldValidator>
                            </div>
                            </div>
                              <div class="form-row" id="divinstant2" runat="server">
                              <div class="form-group col-lg-3">
                                 <asp:RadioButton ID="rdFirstRandomnth" runat="server" GroupName="RL" Checked="true"  Text="&nbsp;Every nth Participants"
                                      AutoPostBack="true" OnCheckedChanged="rdAllParticipant_CheckedChanged" />
                                    </div>
                            <div class="form-group col-lg-3">
                                <asp:TextBox ID="txteverynth" runat="server" onkeypress="return isNumberKey(this, event);"
                                    class="form-control form-control-sm" AutoPostBack="true" OnTextChanged="GetWinners1_TextChanged"></asp:TextBox>

                                <asp:RequiredFieldValidator ID="reqeverynth" runat="server" ForeColor="Red" ValidationGroup="NN" ErrorMessage="*"
                                    ControlToValidate="txteverynth"></asp:RequiredFieldValidator>
                                <asp:TextBox ID="txtnth" runat="server" class="form-control form-control-sm" ReadOnly="false"
                                    onkeypress="return isNumberKey(this, event);" Style="display: none;"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqnth" runat="server" ForeColor="Red" ValidationGroup="NN" ErrorMessage="*"
                                    ControlToValidate="txtnth"></asp:RequiredFieldValidator>
                            </div>
                                   <div class="form-group col-lg-3">
                                        <label style="margin-top: 1px;margin-left: 35px;">(No. Of Rewards)</label>
                                                                         <%--   <b>Every&nbsp;n<sup>th</sup>&nbsp;Participants</b>--%>
                                   </div>
                                <div class="form-group col-lg-3">
                                     <asp:TextBox ID="txteverywin" runat="server" class="form-control form-control-sm" onkeypress="return isNumberKey(this, event);"
                                    AutoPostBack="true" OnTextChanged="GetWinners1_TextChanged"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqeverywin" runat="server" ForeColor="Red" ValidationGroup="NN"
                                    ErrorMessage="*" ControlToValidate="txteverywin"></asp:RequiredFieldValidator>
                                </div>
                                  </div>

                        <div class="form-row" id="divinstant3" runat="server">
                            <div class="form-group col-lg-3">
                                <asp:RadioButton ID="rdRandom" runat="server" GroupName="RL" AutoPostBack="true"
                                    OnCheckedChanged="rdAllParticipant_CheckedChanged" Text="&nbsp;Random Participants" />
                            </div>
                             <div class="form-group col-lg-3">
                                 <asp:TextBox ID="txttcodesrand" runat="server" class="form-control form-control-sm" onkeypress="return isNumberKey(this, event);"
                                    AutoPostBack="true" OnTextChanged="GetWinners2_TextChanged"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqtcodesrand" runat="server" ForeColor="Red" ValidationGroup="NN"
                                    ErrorMessage="*" ControlToValidate="txttcodesrand"></asp:RequiredFieldValidator>
                             </div>
                           

                        </div>
                         <div class="form-row" id="divinstant4" runat="server">
                              <div class="form-group col-lg-3">
                                <asp:RadioButton ID="rdAllParticipant" runat="server" GroupName="RL" AutoPostBack="true" Text="&nbsp;All Participants"
                                    OnCheckedChanged="rdAllParticipant_CheckedChanged" />
                            </div>
                            <div class="form-group col-lg-3">
                                <asp:TextBox ID="txtrand" runat="server" class="form-control form-control-sm" onkeypress="return isNumberKey(this, event);"
                                    onchange="GetVal(this.value)" Style="display: none;"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqrand" runat="server" ForeColor="Red" ValidationGroup="NN2324"
                                    ErrorMessage="*" ControlToValidate="txtrand"></asp:RequiredFieldValidator>
                            </div>
                         </div>


                        <div class="form-row" id="divduedate" runat="server">
                            <div class="form-group col-lg-4">
                                  <asp:RadioButton ID="rdAlltonthrand" runat="server" GroupName="DL" AutoPostBack="true" Text="&nbsp;First 'n' from all participants"
                                                                                OnCheckedChanged="rdAlltoAll_CheckedChanged" />
                            </div>
                             <div class="form-group col-lg-3">
                                   <asp:TextBox
                                    AutoPostBack="true" OnTextChanged="GetWinner_TextChanged" ID="txtalltonth" 
                                    runat="server"  class="form-control form-control-sm" placeholder="Random 'n' Winners" onkeypress="return isNumberKey(this, event);"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqalltonth" runat="server" ForeColor="Red" ValidationGroup="NN" ErrorMessage="*"
                                    ControlToValidate="txtalltonth"></asp:RequiredFieldValidator>
                             </div>
                              <div class="form-group col-lg-2">
                                     <label style="margin-top: 1px;margin-left: 45px;">(Every n<sup>th</sup>)</label>
                             </div>

                              <div class="form-group col-lg-3">
                                   <asp:TextBox ID="txtrandfreq"
                                    AutoPostBack="true" OnTextChanged="GetWinner_TextChanged" runat="server"
                                    class="form-control form-control-sm" placeholder="Participants" onkeypress="return isNumberKey(this, event);"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqrandfreq" runat="server" ForeColor="Red" ValidationGroup="NN" ErrorMessage="*"
                                    ControlToValidate="txtrandfreq"></asp:RequiredFieldValidator>
                             </div>
                            </div>
                             <div class="form-row" id="divduedate2" runat="server">
                                  <div class="form-group col-lg-4">
                                        <asp:RadioButton ID="rdAllton" runat="server" GroupName="DL" AutoPostBack="true" 
                                      Text="&nbsp;Random 'n' from all participants" OnCheckedChanged="rdAlltoAll_CheckedChanged" />
                                  </div>
                                  <div class="form-group col-lg-3">
                                      <asp:TextBox
                                    AutoPostBack="true" OnTextChanged="GetWinner1_TextChanged" ID="txtalltonCustomer"
                                 runat="server" class="form-control form-control-sm" placeholder="Random 'n' Winners"
                                    onkeypress="return isNumberKey(this, event);"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqalltonCustomer" runat="server" ForeColor="Red" ErrorMessage="*"
                                    ValidationGroup="NN" ControlToValidate="txtalltonCustomer"></asp:RequiredFieldValidator>
                             
                                  </div>
                                 </div>
                                 <div class="form-row" id="divduedate3" runat="server">
                                       <div class="form-group col-lg-4">
                                           <asp:RadioButton ID="rdFirstnton" runat="server" GroupName="DL" Checked="true" AutoPostBack="true" 
                                                      Text="&nbsp;First 'n' from all participants" OnCheckedChanged="rdAlltoAll_CheckedChanged" />
                                       </div>
                                      <div class="form-group col-lg-3">
                                             <asp:TextBox ID="txtallpFirstn" runat="server" class="form-control form-control-sm" placeholder="First 'n' Participants"
                                    onkeypress="return isNumberKey(this, event);" AutoPostBack="true" OnTextChanged="GetWinner2_TextChanged"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqallpFirstn" runat="server" ForeColor="Red" ValidationGroup="NN" ErrorMessage="*"
                                    ControlToValidate="txtallpFirstn"></asp:RequiredFieldValidator>
                                       </div>
                                      <div class="form-group col-lg-2">
                                             <label style="margin-top: 1px;margin-left: 45px;">(Winners)</label>
                                       </div>
                                      <div class="form-group col-lg-3">
                                          <asp:TextBox ID="txtallpFirstnton" runat="server"
                                    AutoPostBack="true" OnTextChanged="GetWinner2_TextChanged" class="form-control form-control-sm"
                                    placeholder="Winner Count" onkeypress="return isNumberKey(this, event);"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="reqallpFirstnton" runat="server" ForeColor="Red"
                                    ValidationGroup="NN" ControlToValidate="txtallpFirstnton"></asp:RequiredFieldValidator>
                                       </div>
                                     </div>
                    <div class="form-row" id="divduedate4" runat="server">
                        <div class="form-group col-lg-4">
                            <asp:RadioButton ID="rdAlltoAll" runat="server" GroupName="DL" AutoPostBack="true"
                                Text="&nbsp;All Participants" OnCheckedChanged="rdAlltoAll_CheckedChanged" />
                        </div>
                        <div class="form-group col-lg-3">
                            <label>All winners</label>
                        </div>

                    </div>
                          </div>
                    

                         <div class="card-admin form-wizard medias" id="divisAdditionalGift_Grid" runat="server">
                      <div class="card-body card-body-nopadding">
                        <div class="form-row" >
                            
                            <div class="form-group col-lg-3">
                                <asp:Label ID="lblRwdHeader" runat="server"></asp:Label>
                                <asp:Label ID="lblRwdCounts" runat="server" ForeColor="Red" Font-Size="9pt"></asp:Label>
                            </div>
                            <div class="form-group col-lg-9">
                                <asp:Label ID="lblProCount" runat="server" Text="Total Product Details Counts "></asp:Label>
                                [<asp:Label ID="lblProDetCount" runat="server" ForeColor="Green"></asp:Label>]
                            </div>
                        </div>
                           <div class="form-row" >
                                 <div class="form-group col-lg-2"><span class="req"></span><label>Gift Name</label>
                                    
                                     <asp:DropDownList runat="server" ID="ddlAddGift" CssClass="form-control form-control-sm"  onchange="FillAvailable(this.value);">
                                                            </asp:DropDownList>
                                                            <asp:RequiredFieldValidator ID="ReqvalAddGidt" runat="server" ControlToValidate="ddlAddGift"
                                                      ErrorMessage="*"          ValidationGroup="ADG" InitialValue="--Select--"></asp:RequiredFieldValidator>
                                 </div>
                               <div class="form-group col-lg-2"><span class="req"></span><label>Available Quantity</label>
                                    <asp:Label ID="lbltotqty" runat="server" Text="0"></asp:Label>
                               </div>
                               <div class="form-group col-lg-2"><span class="req"></span><label>Qunatity</label>
                                   <asp:TextBox ID="txtGiftQty" MaxLength="10" runat="server" 
                                       CssClass="form-control form-control-sm" onkeypress="return isNumberKey(this, event);"></asp:TextBox>
                               </div>
                               <div class="form-group col-lg-2"><span class="req"></span><label>Infinite</label>
                                   <br />
                                   <asp:CheckBox ID="ChkInfinite" runat="server" Text="Infinie" AutoPostBack="true" 
                                                                OnCheckedChanged="ChkInfinite_CheckedChanged"></asp:CheckBox>
                               </div>
                               <div class="form-group col-lg-4"><span class="req"></span><label>Action</label>
                                   <br />
                                   <asp:Button ID="btnGSave" runat="server" Text="Save" ValidationGroup="ADG" class="btn btn-primary float-left mt-10"
                                       OnClick="btnGSave_Click" />&nbsp;&nbsp;<asp:Button
                                           ID="btnGReset" CausesValidation="false" runat="server" Text="Reset" class="btn btn-primary float-left ml-0"
                                           OnClick="btnGReset_Click" />
                               </div>
                           </div>
                    </div>

                      <asp:GridView ID="GrdVwGift" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                                                                    EmptyDataText="Record Not Found" 
                                                                     BorderColor="transparent" 
                                                                    OnRowCommand="GrdVwGift_RowCommand">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="S.No">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblsrno" runat="server" Text='<%# Bind("AdditionalGift_ID") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="4%" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Gift Name">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblgiftname" runat="server" Text='<%# Bind("GiftName") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="15%" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="&nbsp;&nbsp;&nbsp;&nbsp;Gift Count">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblgiftcount" runat="server" Text='<%# Convert.ToInt32(Eval("GiftCount")) == 0 ? "Infinite" : Eval("GiftCount")  %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="15%" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Action">
                                                                            <ItemTemplate>
                                                                                <asp:ImageButton ID="Imgbtngftedit" runat="server" CommandArgument='<%# Bind("AdditionalGift_ID") %>'
                                                                                    CausesValidation="false" CommandName="EditGiftRow" ToolTip="Edit Gift Details"
                                                                                    ImageUrl="~/Content/images/edit.png" />&nbsp;
                                                                                <asp:ImageButton ID="Imgbtngftdel" runat="server" CommandArgument='<%# Bind("AdditionalGift_ID") %>'
                                                                                    CausesValidation="false" CommandName="DeleteGiftRow" ToolTip="Delete Gift" ImageUrl="~/Content/images/delete.png" />&nbsp;
                                                                            </ItemTemplate>
                                                                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="7%" />
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <%--<PagerStyle HorizontalAlign="Center" CssClass="pagination" />--%>
                                                                    <%--<RowStyle CssClass="tr_line1" />--%>
                                                                    <%--<AlternatingRowStyle CssClass="tr_line2" />--%>
                                                                </asp:GridView>
                                                                <asp:HiddenField ID="hdngiftrowid" runat="server" />
                                                                <asp:HiddenField ID="hdneditvalue" runat="server" />


                    
                  </div>
                
                          <div class="form-row">
                               <div class="form-group col-lg-8"></div>
                              <div class="form-group col-lg-2">
                                  <asp:Button ID="btnSave" runat="server" CssClass="btn btn-primary mb-1 mr-2" OnClick="btnSave_Click"
                                                ValidationGroup="SRVS" Text="Save" />
                                  <asp:Button ID="btnCancel" runat="server" CssClass="btn btn-success mb-1" OnClick="btnCancel_Click"
                                                 Text="Cancel" />
                              </div>
                              
                      
                      </div>
                    </div>
                    
                    
               
                 
                </div>

                </div>
            </div>
             </div>
         </div>
         
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
                            <div class="regis_popup" style="line-height: 25px;overflow : auto ; height: 700px;">
                             
                                <table cellpadding="0px" cellspacing="10px" width="100%" class="grid" style="line-height: 25px;overflow : auto ; height: 500px;">
                                    
                                   
                                   
                                   
                                  
                                   
                                    <tr id="divissoundComments" runat="server">
                                        <td colspan="2">
                                            <fieldset class="Newfield">
                                                <legend>Message</legend>
                                                <table width="100%">
                                                    <tr>
                                                        <td align="right" style="width: 27%;">
                                                            <asp:RequiredFieldValidator ID="RFVIsMessage" runat="server" ForeColor="Red" ValidationGroup="NN"
                                                                ControlToValidate="txtCommentsTxt"></asp:RequiredFieldValidator>
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
                                                    <tr>
                                                        <td style="width: 23%; text-align: right;">
                                                            <asp:RequiredFieldValidator ID="RFVIsSoundH" runat="server" ForeColor="Red" ValidationGroup="NN"
                                                                ControlToValidate="flSoundH"></asp:RequiredFieldValidator>
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
                                                            <asp:RequiredFieldValidator ID="RFVIsSoundE" runat="server" ForeColor="Red" ValidationGroup="NN"
                                                                ControlToValidate="flSoundE"></asp:RequiredFieldValidator>
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
                                                    <tr>
                                                        <td colspan="2">
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
                                                </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                  
                                </table>
                            </div>
                        </div>
                    </div>
                </asp:Panel>


                    
</asp:Content>

