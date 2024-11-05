<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="KycBankDetails.aspx.cs" Inherits="Manufacturer_KycBankDetails" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <asp:Label ID="Label6" runat="server"></asp:Label>
     <asp:Label ID="Label9" runat="server"></asp:Label>
     <asp:Label ID="Label3" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
    <div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
                <div class="card card-admin form-wizard profile box_card">
                    <header class="card-header">
                        <h4 class="card-title"><i class="fa fa-pencil-square-o"></i><asp:Label ID="lblheading" runat="server" Text="Bank KYC Detail" Font-Bold="true"></asp:Label></h4>
                    </header>
                     <div id="newmsg" runat="server">
                        <p>
                            <asp:Label ID="lblmsgHeader" runat="server"></asp:Label></p>
                    </div>
                    <div id="NewMsgpop" class="alert_boxes_green big_msg" runat="server">
                                <p>
                                    <asp:Label ID="LblMsgUpdate" runat="server"></asp:Label>
                                </p>
                            </div>
                    <div  class="card-body card-body-nopadding">
                  <div class="form-row">
                         <div class="form-group col-lg-10">
                             <h6> Bank Kyc Info</h6>
                                </div>
                                <div class="form-group col-lg-2">
                                    <asp:Button ID="Button2" runat="server" Text="Cancel" CausesValidation="false" OnClick="btnReset_Click" ValidationGroup="false" CssClass="btn btn-primary btn-block" />
                                </div>
                            
                       
                                </div>
                  
                  
                    <div class="form-row">
                        <asp:HiddenField id="HiddenM_ConID" runat="server" />
                        <div class="form-group col-lg-3">
                            <span class="req">*</span><label>Consumer Name</label>
                            <asp:TextBox ID="txtName" MaxLength="50" onchange="checkproduct(this.value);"
                                class="form-control form-control-sm" runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'50');" ReadOnly="true" ></asp:TextBox>
                         </div>
                          <div class="form-group col-lg-3">
                            <span class="req">*</span><label>Mobile</label>
                            <asp:TextBox ID="txtMobile" TextMode="MultiLine" class="form-control form-control-sm" MaxLength="250" Height="40px"  runat="server" ReadOnly="true" ></asp:TextBox>
                            </div>

                        <div class="form-group col-lg-3">
                            <span class="req">*</span><label>KYC Status</label>
                            <asp:TextBox ID="txtKYC" TextMode="MultiLine" class="form-control form-control-sm" MaxLength="250" Height="40px"  runat="server" ReadOnly="true" ></asp:TextBox>
                            </div>
                           <div class="form-group col-lg-3">
                            <span class="req">*</span><label>Kyc Mode</label>
                            <asp:TextBox ID="kycMode" TextMode="MultiLine" class="form-control form-control-sm" MaxLength="250" Height="40px"  runat="server" ReadOnly="true" reado ></asp:TextBox>
                         </div>
                      <div class="form-group col-lg-3">
                            <span class="req">*</span><label>Entry Date</label>
                            <asp:TextBox ID="BankReqdate" TextMode="MultiLine" class="form-control form-control-sm" MaxLength="250" Height="40px"  runat="server" ReadOnly="true" ></asp:TextBox>
                         </div>


                          <div class="form-group col-lg-3">
                            <span class="req"></span>
                            <label>Account Holder</label>
                            <asp:TextBox ID="TextAccountHolder"  class="form-control form-control-sm"  runat="server" ></asp:TextBox>
                         </div> 
                        <div class="form-group col-lg-3">
                            <span class="req"></span>
                            <label>Account No.</label>
                            <asp:TextBox ID="TextAccountNo"  class="form-control form-control-sm" runat="server"></asp:TextBox>                        

                        </div>
                         <div class="form-group col-lg-3">
                            <span class="req">*</span><label>IFSC Code</label>
                            <asp:TextBox ID="TextIFSC"  class="form-control form-control-sm" runat="server"   ></asp:TextBox>
                         </div> 
                      
                        <div class="form-group col-lg-3">
                            <span class="req">*</span><label>Bank Name</label>
                            <asp:TextBox ID="TextBankName" MaxLength="50" onchange="checkproduct(this.value);"
                                class="form-control form-control-sm" runat="server"   ></asp:TextBox>
                         </div>
                         <div class="form-group col-lg-3">
                            <span class="req">*</span><label>Branch</label>
                            <asp:TextBox ID="TextBranch" class="form-control form-control-sm"  runat="server" ></asp:TextBox>
                          </div>                           
                        <div class="form-group col-lg-3">   
                            <span class="req">*</span><label>Kyc Status</label>
                                    <asp:DropDownList ID="KycStatus" Visible="true" runat="server" CssClass="form-control">
                                        <asp:ListItem Value="" ID="KycStatusItem1">Select KYC Status</asp:ListItem>
                                        <asp:ListItem Value="1">Success</asp:ListItem>
                                        <asp:ListItem Value="0">Failure</asp:ListItem>                                        
                                    </asp:DropDownList>
                                     </div>
                                         <div class="form-group col-lg-3">     
                                             <span class="req">*</span><label>Remark</label>
                                        <asp:TextBox ID="TextRemark" MaxLength="200" onchange="checkproduct(this.value);"
                                        class="form-control form-control-sm" runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'200');" placeholder="Remark"></asp:TextBox>
                                        </div>

                          
                            <div class="form-group col-lg-3" runat="server" ID="imgPassbook">
                                <span class="req">*</span><label>Passbook File</label>
                                <asp:Image runat="server" ID="imgPan" style="width: 150px;height: 110px; display:block" />
                            <a id="HyperLinkPan" runat="server" class="btn btn-primary btn-block" target="_blank" title="View Documents" style="width: 150px;margin-top:2px;">View </a>     
                            </div>

                        
                                        

                             
                       
                    </div>
                        <div class="form-row">                       
                                            <div class="form-group col-lg-3">                     
                                        <asp:Button ID="Button1"  OnClick="ImgSearch_Click" ValidationGroup="servss"
                                        class="btn float-right btn-primary btn-block" style="color: #0088cc;"    runat="server" Text="Submit" />
                      					
                                            </div>
                                        </div>
                                    
        </div>
        </div>
   
    </div>
             </div>
        </div>
            </div>
</asp:Content>


