<%@Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="AddProductDetails.aspx.cs" Inherits="Manufacturer_AddProductDetails" %>
<%@Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1"%>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script>
        function CheckBatch_NoVal(vl) {
           
            if (document.getElementById('<%=HDF.ClientID %>').value == "") {
                document.getElementById("<%=LblMsg.ClientID %>").innerHTML = "Select Products.";
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";
                return;
            }
            else {
                var vv = document.getElementById('<%=HDF.ClientID %>').value;
                PageMethods.CheckBatch_No(vl + vv, CheckBatch_NoHello)
            }
        }
        function CheckBatch_NoHello(Result) {
            if (Result == true) {
                document.getElementById("<%=LblMsg.ClientID %>").innerHTML = "BatchNo  Already exist.";

            }
            else {
                document.getElementById("<%=LblMsg.ClientID %>").innerHTML = "";

            }
        }
        </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:HiddenField ID="HDF" runat="server"></asp:HiddenField>
     <div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
                <div class="card card-admin form-wizard profile box_card">


                      <header class="card-header">
                        <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Add/Edit Product Details</h4>
                    </header>


                      <div  class="card-body card-body-nopadding">
                    <h6> General Info</h6>
                          <div class="form-row">
                              <div class="form-group col-lg-12">

                                  <asp:Label ID="LblMsg" runat="server"></asp:Label>

                                  <asp:Label ID="Label4" runat="server"></asp:Label>


                                  <asp:Label ID="lblpopmsg" runat="server"></asp:Label>
                                  <asp:Label ID="lblCompPassText" runat="server" Text="" Font-Size="12px" ForeColor="Red"></asp:Label><br />
                              </div>
                          </div>
                           
                          <div class="form-row">
                              <div class="form-group col-lg-3">
                                  <span class="req">*</span><label>Product Name</label>
                                  <asp:DropDownList ID="ddlProduct" runat="server" CssClass="form-control form-control-sm"    AutoPostBack="true" OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged">
                                  </asp:DropDownList>
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" InitialValue="--Select--"
                                      ForeColor="Red" ValidationGroup="PRO" ControlToValidate="ddlProduct" ErrorMessage="*"></asp:RequiredFieldValidator>
                              </div>
                              <div class="form-group col-lg-3">
                                  <span class="req">*</span>
                                  <label>No. Of Available Codes</label>
                                  <asp:TextBox ID="LblAvlCodes" MaxLength="50" Enabled="false" ForeColor="Red"
                                      CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                                  <asp:HiddenField ID="HdnAvlCodes" runat="server" />
                                  <asp:HiddenField ID="HdnSeriesIni" runat="server" />
                                  <asp:HiddenField ID="HdnBatchSize" runat="server" />
                                  <asp:RequiredFieldValidator ID="RequiredFieldValidatorNew3" runat="server" ForeColor="Red" ErrorMessage="*"
                                      ValidationGroup="PRO" ControlToValidate="LblAvlCodes"></asp:RequiredFieldValidator>

                              </div>
                              <div class="form-group col-lg-3">
                                  <span class="req">*</span><label>Batch No</label>
                                  <asp:TextBox ID="txtBatchNo" MaxLength="10"  CssClass="form-control form-control-sm" runat="server"
                                                                onchange="CheckBatch_NoVal(this.value)"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red" Enabled="false"
                                                                ValidationGroup="PRO" ControlToValidate="txtBatchNo" ErrorMessage="*"></asp:RequiredFieldValidator>
                              </div>
                              <div class="form-group col-lg-3">
                                  <span class="req">*</span>
                                  <label>MRP</label>
                                <asp:TextBox ID="txtMRP"  CssClass="form-control form-control-sm" runat="server" MaxLength="7"
                                                                OnKeyPress="return isNumberKey(this, event);" onchange="mathRoundForTaxes(this.id);"></asp:TextBox>
                                 <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red" ErrorMessage="*" Enabled="false"
                                                                ValidationGroup="PRO" ControlToValidate="txtMRP"></asp:RequiredFieldValidator>

                              </div>
                          </div>
                           
                           <div class="form-row">
                              <div class="form-group col-lg-3">
                                  <span class="req">*</span><label>Mfd_Date</label>
                                  <asp:TextBox ID="txtMfd_Date" MaxLength="50" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red" ErrorMessage="*" Enabled="false"
                                                                ValidationGroup="PRO" ControlToValidate="txtMfd_Date"></asp:RequiredFieldValidator>
                              </div>
                              <div class="form-group col-lg-3">
                                  <span class="req"></span>
                                  <label>Exp_Date</label>
                                <asp:TextBox ID="txtExp_Date" MaxLength="50"  onchange="checkproduct(this.value);"
                                                               CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                                 <asp:CompareValidator ID="CompareValidator2" runat="server" ValidationGroup="PRO"
                                                                ControlToCompare="txtMfd_Date" ControlToValidate="txtExp_Date" ForeColor="Red"
                                                                Type="Date" Operator="GreaterThan" ErrorMessage="Exp Date is greater than Mfd Date."></asp:CompareValidator>

                              </div>
                               <div class="form-group col-lg-3">
                                  <span class="req">*</span><label>Your Batch Size</label>
                                  [<asp:Label ID="lblbatchsize" runat="server" ForeColor="Red" Font-Size="11px"
                                                                Font-Bold="true"></asp:Label>]
                                
                              </div>
                          </div>
                           
                           
                          <div class="form-row" style="display:none;">
                              <div class="form-group col-lg-3">
                                   <span class="req"></span><label>Warranty (in months)</label>
                                   <asp:TextBox runat="server" onkeypress="return isNumberKey(this, event);" MaxLength="2"  ID="txtWarr" CssClass="form-control form-control-sm" />
                                  </div>
                               </div>
                          <div class="form-row" style="display:none;">
                               <div class="form-group col-lg-6" >
                                  
                                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ForeColor="Red"
                                                                ValidationGroup="PRO" ControlToValidate="txtNoOfCodes"></asp:RequiredFieldValidator>--%>
                                                            <strong><span class="astrics">*</span> No. Of Codes :</strong><asp:HiddenField ID="hdneditrowid"
                                                                runat="server" />
                                                     
                                                            <asp:TextBox ID="txtNoOfCodes" MaxLength="6" Width="91%" onchange="CheckAvilableCodes(this.value);"
                                                                CssClass="textbox_pop" runat="server" ReadOnly="true"></asp:TextBox>
                                                       
                                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="PRO"
                                                                ForeColor="Red" ControlToCompare="txtMfd_Date" ControlToValidate="txtExp_Date"
                                                                Operator="GreaterThanEqual" Type="Date" Text="Exp date must be Greater.."></asp:CompareValidator>
                                                      
                                                            <asp:CheckBox ID="chkComments" runat="server" AutoPostBack="true" Text="  Use Old"
                                                                OnCheckedChanged="chkComments_CheckedChanged" />
                                                            <strong><span class="astrics">&nbsp;</span> Comment :</strong>
                                                       
                                                            <asp:TextBox ID="txtComment" MaxLength="100" TextMode="MultiLine" Width="95%" Height="30px"
                                                                CssClass="textbox_pop" onkeyDown="return checkTextAreaMaxLength(this,event,'100');"
                                                                runat="server"></asp:TextBox>
                                                       
                                   </div>
                              </div>
                          </div>


                     <div class="card-admin form-wizard medias">
                     
                       <%--  <h5>Pasted Label Info</h5>--%>
                <asp:GridView ID="GrdProductPrintLablelDet" runat="server" AutoGenerateColumns="False"
                                                                   CssClass="table table-striped" EmptyDataText="Record Not Found" 
                                                                    
                                                                    BorderColor="transparent" OnRowCommand="GrdProductPrintLablelDet_RowCommand">
                                                                    <Columns>
                                                                        <%--<asp:TemplateField HeaderText="Product Name">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblLablProNm" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                            <ItemStyle HorizontalAlign="Center" Width="20%" />
                                                                        </asp:TemplateField>--%>
                                                                        <asp:TemplateField HeaderText="Series Initial">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lvlpronm" runat="server" Text='<%# Bind("Pro_ID") %>'></asp:Label><b>-</b><asp:Label
                                                                                    ID="lblLabelNm" runat="server" Text='<%# Bind("Series_Initial") %>'></asp:Label>
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

                <div  class="card-body card-body-nopadding">                  
                          <div class="form-row">
                              <div class="form-group col-lg-8">
                                  <span style="color: Red;">Please paste Labels batch wise at a time in sequence of series
                                                    no.</span>
                                  </div>
                               <div class="form-group col-lg-2">
                                    <asp:Label ID="lblproid" runat="server" Visible="false"></asp:Label><asp:Label ID="lblnoofcodes"
                                                    runat="server" Visible="false"></asp:Label>
                                     <asp:Button ID="btnSave" OnClick="btnSave_Click" ValidationGroup="PRO" class="btn btn-primary float-right mb-5" 
                                                    runat="server" Text="Save" />
                               </div>
                              <div class="form-group col-lg-2">
                                  <asp:Button ID="btnReset" OnClick="btnReset_Click" class="btn btn-primary float-left mb-5"  runat="server"
                                                    Text="Cancel" />
                              </div>
                                  
                              </div>
                    
                    
                </div>
                    </div>
                
                
                </div>
            </div>
         </div>
         </div>
    <asp:Panel ID="PanelProductDetails" runat="server" Width="36%" Style="display: none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="Button1" CssClass="popupClose" runat="server" /></div>
                            <!--<fieldset class="service_field" >-->
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="lblheading" Font-Bold="true" runat="server"></asp:Label>
                                        <asp:Label ID="lblSame" runat="server" Visible="false"></asp:Label>&nbsp;&nbsp;
                                    </span><span class="right"><span class="astrics"><strong>*</strong></span><em> indicates
                                        mandatory fields</em></span></p>
                            </div>
                            <div class="regis_popup">
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    
                                    <tr>
                                        <td>
                                            <fieldset class="Newfield">
                                                <legend><span id="Label782">General Info</span></legend>
                                                <table width="98%" cellpadding="0" cellspacing="2">
                                                    
                                                   
                                                    <tr>
                                                        <td align="right">
                                                           
                                                            <strong><span id="mfd" runat="server" class="astrics">*</span>  :</strong>
                                                        </td>
                                                        <td>
                                                            
                                                        </td>
                                                        <td align="right">
                                                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red"
                                                                ValidationGroup="PRO" ControlToValidate="txtExp_Date"></asp:RequiredFieldValidator>
                                                            <strong style="color: Red;">*</strong>--%>
                                                            <strong> :</strong>
                                                        </td>
                                                        <td>
                                                           
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                        </td>
                                                        <td>
                                                        </td>                                                        
                                                        <td align="right" colspan="2">
                                                            
                                                        </td>
                                                    </tr>
                                                   
                                                    <tr>
                                                        <td align="right">
                                                            <strong><span id="Span1" runat="server" class="astrics">*</span> Your Batch Size :</strong>
                                                        </td>
                                                        <td colspan="3">
                                                            &nbsp;
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
                                                            <asp:Label ID="lblname" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2" align="left">
                                                            <asp:CheckBox ID="chkHindi" Enabled="false" runat="server" AutoPostBack="true" Text="  Use Old"
                                                                OnCheckedChanged="chkHindi_CheckedChanged" />
                                                        </td>
                                                        <td colspan="2" align="left">
                                                            <asp:CheckBox ID="chkEnglish" Enabled="false" Text="   Use Old" runat="server" OnCheckedChanged="chkHindi_CheckedChanged"
                                                                AutoPostBack="true" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" style="width: 8%">
                                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator522" runat="server" ForeColor="Red"
                                                               ValidationGroup = "PRO" ControlToValidate="flSound"></asp:RequiredFieldValidator>--%>
                                                            <strong>
                                                                <asp:Label ID="L2" runat="server" CssClass="astrics" Text="*"></asp:Label>
                                                                Hindi :</strong>
                                                        </td>
                                                        <td style="width: 40%">
                                                            <asp:FileUpload ID="flSound" Enabled="false" onchange="fileTypeCheckeng(this.value);"
                                                                runat="server" Style="width: 88%;" />
                                                            <a id="SFileE" runat="server" target="_blank" title="Hindi File play" style="cursor: pointer;">
                                                                <img alt="" src="Content/images/play.png" /></a>
                                                        </td>
                                                        <td align="right" style="width: 10%">
                                                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator6English" runat="server" ForeColor="Red"
                                                             ValidationGroup = "PRO" ControlToValidate="flSoundE"></asp:RequiredFieldValidator>--%>
                                                            <strong>
                                                                <asp:Label ID="L1" runat="server" CssClass="astrics" Text="*"></asp:Label>
                                                                English :</strong>
                                                        </td>
                                                        <td>
                                                            <asp:FileUpload ID="flSoundE" Enabled="false" onchange="fileTypeCheckengE(this.value);"
                                                                runat="server" Style="width: 88%;" />
                                                            <a id="SFileH" runat="server" target="_blank" title="English File play" style="cursor: pointer;">
                                                                <img alt="" src="Content/images/play.png" /></a>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblfile" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
                                                        </td>
                                                        <td>
                                                        </td>
                                                        <td>
                                                            <asp:Label ID="lblfileE" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <fieldset id="Fieldset1" runat="server" class="Newfield Newfield_width2" style="width: 97%;">
                                                <legend>Pasted Label Info</legend>
                                                <table width="100%" style="text-align: center;">
                                                    <tr style="background-color: #E6E6E6;">
                                                        <td align="center" style="width: 35%;">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ForeColor="Red"
                                                                ValidationGroup="APL" ControlToValidate="txtSeries_Initial"></asp:RequiredFieldValidator><strong><span
                                                                    class="astrics">*</span> Series Initial </strong>
                                                        </td>
                                                        <td style="width: 15%; text-align: center;">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red"
                                                                ValidationGroup="APL" ControlToValidate="txtSeriesFrom"></asp:RequiredFieldValidator>
                                                            <strong><span class="astrics">*</span>From</strong>
                                                        </td>
                                                        <td style="width: 15%; text-align: center;">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ForeColor="Red"
                                                                ValidationGroup="APL" ControlToValidate="txtSeriesTo"></asp:RequiredFieldValidator>
                                                            <strong><span class="astrics">*</span>To</strong>
                                                        </td>
                                                        <td style="width: 20%; text-align: center;">
                                                            <strong>Qty</strong>
                                                        </td>
                                                        <td style="width: 15%;">
                                                            <asp:HiddenField ID="hdnFieldUpdate" Value="Save" runat="server" />
                                                            &nbsp;<asp:DropDownList ID="ddlLabel" runat="server" Visible="false">
                                                            </asp:DropDownList>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:TextBox ID="txtSeries_Initial1" Width="50px" runat="server" CssClass="textbox_pop"
                                                                ReadOnly="true" onchange="ChkInitial(this.value,this.id);" MaxLength="10" Text=""></asp:TextBox><b>-</b>
                                                            <asp:TextBox ID="txtSeries_Initial" Width="50px" runat="server" CssClass="textbox_pop"
                                                                onchange="InitialSeries(this.value,this.id);" MaxLength="4" OnKeyPress="return isNumberKey(this, event);"
                                                                Text=""></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtSeriesFrom" Width="50px" runat="server" CssClass="textbox_pop"
                                                                onchange="FormatVal(this.value,this.id);" MaxLength="4" OnKeyPress="return isNumberKey(this, event);"
                                                                Text=""></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtSeriesTo" Width="50px" runat="server" CssClass="textbox_pop"
                                                                MaxLength="4" onchange="ToatVal(this.value,this.id)" OnKeyPress="return isNumberKey(this, event);"
                                                                Text=""></asp:TextBox>
                                                            <asp:HiddenField ID="hdnSerialOrder" runat="server" />
                                                            <asp:HiddenField ID="hdnSeriesFrom" runat="server" />
                                                            <asp:HiddenField ID="hdnSeriesTo" runat="server" />
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="LblCountQty" CssClass="textbox_pop" runat="server" Width="100px"
                                                                Text="" Enabled="false" Style="text-align: center;"></asp:TextBox>
                                                        </td>
                                                        <td>
                                                            <asp:ImageButton ID="btnAddPro" ImageUrl="~/Content/images/add_new.png" runat="server" ValidationGroup="APL"
                                                                OnClick="btnAddPro_Click" />&nbsp;<asp:ImageButton ID="btnResetPro" ImageUrl="~/Content/images/reset.png"
                                                                    runat="server" CausesValidation="false" OnClick="btnResetPro_Click" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="7" align="center">
                                                            <asp:Label ID="lblProDetailsMsg" runat="server" Text="" ForeColor="Red"></asp:Label><asp:Label
                                                                ID="lblUpFlTblId" runat="server" Text="" Visible="false"></asp:Label><asp:Label ID="lblC"
                                                                    runat="server" Text="" Visible="false"></asp:Label>
                                                            <div align="center" style="overflow: auto; height: 150px;">
                                                                
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                       
                                    </tr>
                                    <tr style="display: none;">
                                        <td colspan="2">
                                            <asp:Label ID="lblnoteSound" Style="font-family: Arial; font-size: 12px; color: red;"
                                                runat="server" Text="Note:- Audio file to be uploaded on the website should be in the prescribed format as below"></asp:Label>
                                            <br />
                                            <asp:Label ID="lblfiletype" Style="font-family: Arial; font-size: 12px; color: red;"
                                                runat="server" Text="File Type ---- .wav"></asp:Label>
                                            <br />
                                            <asp:Label ID="lblfileformat" Style="font-family: Arial; font-size: 12px; color: red;"
                                                runat="server" Text="Format ---- 8KHz, 16bit mono"></asp:Label>
                                            <br />
                                            <asp:Label ID="lblBitRate" Style="font-family: Arial; font-size: 12px; color: red;"
                                                runat="server" Text="Bit Rate ---- 128 kbps"></asp:Label>
                                            <br />
                                            <asp:Label ID="lblrecord" Style="font-family: Arial; font-size: 12px; color: Blue;"
                                                runat="server" Text="For record the audio file, Please click the link "></asp:Label>&nbsp;
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
                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtendertxtMRP" runat="server" FilterMode="ValidChars"
                    ValidChars="1234567890." TargetControlID="txtMRP">
                </cc1:FilteredTextBoxExtender>
                <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtendertxtnoofCodes" runat="server"
                    FilterMode="ValidChars" ValidChars="1234567890" TargetControlID="txtNoOfCodes">
                </cc1:FilteredTextBoxExtender>
              <%--  <cc1:CalendarExtender ID="CalendarExtender1dtfrom" TargetControlID="txtDateFrom"
                    runat="server" Format="dd/MM/yyyy">
                </cc1:CalendarExtender>--%>
                <%--<cc1:MaskedEditExtender ID="MaskedEditExtenderdtfrom1" runat="server" TargetControlID="txtDateFrom"
                    MaskType="Date" Mask="99/99/9999">
                </cc1:MaskedEditExtender>--%>
               <%-- <cc1:CalendarExtender ID="CalendarExtender2dtto" TargetControlID="txtDateTo" runat="server"
                    Format="dd/MM/yyyy">
                </cc1:CalendarExtender>--%>
               <%-- <cc1:MaskedEditExtender ID="MaskedEditExtendttoder2" runat="server" TargetControlID="txtDateTo"
                    MaskType="Date" Mask="99/99/9999">
                </cc1:MaskedEditExtender>--%>
                <!--PopUp Close-->
                <!--===============================PopUp Password Starts===============================-->
                <asp:Panel ID="PanelShowPassword" runat="server" Width="20%" Style="display: none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnPasswordPnlClose" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                            <!--<fieldset class="service_field" >-->
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="lblPassPnlHead" runat="server" Text="Password" Font-Size="12px"></asp:Label>
                                    </span><span class="right" style="visibility: hidden;"><span class="astrics"><strong>
                                    </strong></span></span>
                                </p>
                            </div>
                            <div class="regis_popup" style="text-align: center;">
                                <br />
                                
                                <br />
                                <div id="infobtn" runat="server" visible="true">
                                    <asp:Button ID="btnYesActivation" runat="server" Text="Ok" CssClass="button_all"
                                        OnClick="btnYesActivation_Click" />&nbsp;&nbsp;<asp:Button ID="btnNoActivation" runat="server"
                                            Text="No" CssClass="button_all" OnClick="btnNoActivation_Click" />
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <!--===============================Popup Close================================-->
                <asp:Label ID="LabelControl" runat="server"></asp:Label>
</asp:Content>

