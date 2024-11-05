<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true"
    CodeFile="frmUploadDocuments.aspx.cs" Inherits="frmUploadDocuments" Title="Upload Document" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript" language="javascript">
        function hellotest() {
            document.getElementById("ctl00_ContentPlaceHolder1_UpdateProgress1").style.display = "block";
        }
        $(document).ready(function () {

            $(".accordion2 p").eq(2).addClass("active");
            $(".accordion2 div.open").eq(0).show();

            $(".accordion2 p").click(function () {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });
             
            

        });
    </script>

    <script type="text/javascript" src="jquery/1.10.2/ClientControl.js"></script>

    <script type="text/javascript" language="javascript">

        function fileTypeCheckFiles(mm) {
         
            var size = document.getElementById("<%=FileUploadaddpfrrof.ClientID%>").files[0].size;
            var index = mm.toString().lastIndexOf('.');
            var ext = mm.toString().substring(index, mm.toString().length);
            var ext23 = ext.toLocaleUpperCase();
            if (!((ext.toLocaleUpperCase() == ".JPG") || (ext.toLocaleUpperCase() == ".JPEG") || (ext.toLocaleUpperCase() == ".PNG") || (ext.toLocaleUpperCase() == ".ZIP") || (ext.toLocaleUpperCase() == ".PDF") || (ext.toLocaleUpperCase() == ".DOC") || (ext.toLocaleUpperCase() == ".DOCX"))) {
                if (size > 10240000)
                    document.getElementById("<%=llvl.ClientID %>").innerHTML = "FileSize should not exceed 10MB";
                else
                    document.getElementById("<%=llvl.ClientID %>").innerHTML = "Invalid";

                document.getElementById("<%=btnUploadDoc.ClientID %>").disabled = true;
                document.getElementById("<%=btnUploadDoc.ClientID %>").className = "btn btn-primary float-right mb-5";

            }
            else {
                if (size > 10240000) {
                    document.getElementById("<%=llvl.ClientID %>").innerHTML = "FileSize should not exceed 10MB";
                document.getElementById("<%=btnUploadDoc.ClientID %>").disabled = true;
                    document.getElementById("<%=btnUploadDoc.ClientID %>").className = "btn btn-primary float-right mb-5";
            }
            else {
                document.getElementById("<%=llvl.ClientID %>").innerHTML = "Invalid";
                document.getElementById("<%=llvl.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnUploadDoc.ClientID %>").disabled = false;
                    document.getElementById("<%=btnUploadDoc.ClientID %>").className = "btn btn-primary float-right mb-5";
            }
        }
        ChkUploadDoc();
    }

        function fileTypeCheckFiles0(mm) {
            debugger;
        var size = document.getElementById("<%=FileUploadowner.ClientID%>").files[0].size;
            var index = mm.toString().lastIndexOf('.');
            var ext = mm.toString().substring(index, mm.toString().length);
            var ext23 = ext.toLocaleUpperCase();
            if (!((ext.toLocaleUpperCase() == ".JPG") || (ext.toLocaleUpperCase() == ".JPEG") || (ext.toLocaleUpperCase() == ".PNG") || (ext.toLocaleUpperCase() == ".ZIP") || (ext.toLocaleUpperCase() == ".PDF") || (ext.toLocaleUpperCase() == ".DOC") || (ext.toLocaleUpperCase() == ".DOCX"))) {
                if (size > 10240000)
                    document.getElementById("<%=llvl0.ClientID %>").innerHTML = "FileSize should not exceed 10MB";
                else
                    document.getElementById("<%=llvl0.ClientID %>").innerHTML = "Invalid";
                document.getElementById("<%=llvl0.ClientID %>").innerHTML = "Invalid";
                document.getElementById("<%=btnUploadDoc.ClientID %>").disabled = true;
                document.getElementById("<%=btnUploadDoc.ClientID %>").className = "btn btn-primary float-right mb-5";

            }
            else {
                if (size > 10240000) {
                    document.getElementById("<%=llvl0.ClientID %>").innerHTML = "FileSize should not exceed 10MB";
                    document.getElementById("<%=btnUploadDoc.ClientID %>").disabled = true;
                    document.getElementById("<%=btnUploadDoc.ClientID %>").className = "btn btn-primary float-right mb-5";
                }
                else {
                    document.getElementById("<%=llvl0.ClientID %>").innerHTML = "Invalid";
                    document.getElementById("<%=llvl0.ClientID %>").innerHTML = "";
                    document.getElementById("<%=btnUploadDoc.ClientID %>").disabled = false;
                    document.getElementById("<%=btnUploadDoc.ClientID %>").className = "btn btn-primary float-right mb-5";
                }
            }
            ChkUploadDoc();
        }
        function fileTypeCheckFiles1(mm) {
            debugger;
            var size = document.getElementById("<%=FileUploadsignature.ClientID%>").files[0].size;
            var index = mm.toString().lastIndexOf('.');
            var ext = mm.toString().substring(index, mm.toString().length);
            var ext23 = ext.toLocaleUpperCase();
            if (!((ext.toLocaleUpperCase() == ".JPG") || (ext.toLocaleUpperCase() == ".JPEG") || (ext.toLocaleUpperCase() == ".PNG") || (ext.toLocaleUpperCase() == ".ZIP") || (ext.toLocaleUpperCase() == ".PDF") || (ext.toLocaleUpperCase() == ".DOC") || (ext.toLocaleUpperCase() == ".DOCX"))) {
                if (size > 10240000)
                    document.getElementById("<%=llvl1.ClientID %>").innerHTML = "FileSize should not exceed 10MB";
            else
                document.getElementById("<%=llvl1.ClientID %>").innerHTML = "Invalid";
                //document.getElementById("<%=llvl1.ClientID %>").innerHTML = "Invalid";
                document.getElementById("<%=btnUploadDoc.ClientID %>").disabled = true;
                document.getElementById("<%=btnUploadDoc.ClientID %>").className = "btn btn-primary float-right mb-5";
            }
            else {
                if (size > 10240000) {
                    document.getElementById("<%=llvl1.ClientID %>").innerHTML = "FileSize should not exceed 10MB";
                    document.getElementById("<%=btnUploadDoc.ClientID %>").disabled = true;
                    document.getElementById("<%=btnUploadDoc.ClientID %>").className = "btn btn-primary float-right mb-5";
                }
                else {
                    document.getElementById("<%=llvl1.ClientID %>").innerHTML = "Invalid";
                    document.getElementById("<%=llvl1.ClientID %>").innerHTML = "";
                    document.getElementById("<%=btnUploadDoc.ClientID %>").disabled = false;
                    document.getElementById("<%=btnUploadDoc.ClientID %>").className = "btn btn-primary float-right mb-5";
                }
            }
            ChkUploadDoc();
        }
        function ChkUploadDoc() {
            debugger;
            if (((document.getElementById("<%=llvl.ClientID %>").innerHTML) != "") || ((document.getElementById("<%=llvl0.ClientID %>").innerHTML) != "") || ((document.getElementById("<%=llvl1.ClientID %>").innerHTML) != "")) {
                document.getElementById("<%=btnUploadDoc.ClientID %>").disabled = true;
                document.getElementById("<%=btnUploadDoc.ClientID %>").className = "btn btn-primary float-right mb-5";
            }
            else {
                document.getElementById("<%=btnUploadDoc.ClientID %>").disabled = false;
                document.getElementById("<%=btnUploadDoc.ClientID %>").className = "btn btn-primary float-right mb-5";
            }
        }
    </script>

    <!--------tooltip------>
    <!-- jQuery via Google CDN -->

    <script src="../Content/js/tooltip/jquery.min.js" language="javascript" type="text/javascript"></script>

    <!-- Style-my-tooltips plugin script and style_my_tooltips function call with default option parameters -->
    <link href="../Content/js/tooltip/style-my-tooltips.css" rel="stylesheet" type="text/css" />

    <script type="text/javascript" language="javascript" src="../Content/js/tooltip/jquery.style-my-tooltips.js"></script>

    <script type="text/javascript" language="javascript">
        jQuery.noConflict();
        (function ($) {
            $(document).ready(function () {
                $("[title]").style_my_tooltips({
                    tip_follows_cursor: false, //boolean
                    tip_delay_time: 700, //milliseconds
                    tip_fade_speed: 300 //milliseconds
                });
                //dynamically added elements demo function
                $("a[rel='add new element']").click(function (e) {
                    e.preventDefault();
                    $(this).attr("title", "Add another element").parent().after("<p title='New paragraph title'>This is a new paragraph! Hover to see the title.</p>");
                });
            });
        })(jQuery);
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
                <div class="card card-admin form-wizard profile box_card">
                    


    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%; top: 0px; z-index: 999;"
                        class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
           
                            <header class="card-header">
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Upload Documents</h4>
                            </header>


            
              <div class="card-body card-body-nopadding">
                  <div class="row">
                      <div class="col-lg-12">
                      <div id="NewMsgpop" class="alert_boxes_green big_msg alert alert-success" runat="server">
                <p>
                    <asp:Label ID="LblMsgUpdate" runat="server"></asp:Label>
                </p>
               </div>
            </div>
                  </div>
                    <div class="form-row">
                        
                            <div class="col-lg-4">
                                <div class="form-group text_boxicon">
                                 <span class="req">*</span><label>Company Description</label>
                            <asp:TextBox ID="txtcompinfo" runat="server" MaxLength="25" class="form-control form-control-sm"></asp:TextBox>

                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorupl2" runat="server" ForeColor="Red"
                                ValidationGroup="UPLOADchkup" ErrorMessage="its required" ControlToValidate="txtcompinfo"></asp:RequiredFieldValidator>
                                <asp:Image ID="lblremarksinfo" runat="server" Text="" CssClass="imgIcon" onmouseover="tooltip.pop(this, this.alt)" />
                            </div>
                        </div>
                     
                        
                        <div class="col-lg-4">
                            <div class="form-group text_boxicon">
                                <span class="req">*</span><label>Company PAN /TAN No</label>
                          <asp:TextBox ID="txtpantanno" runat="server" MaxLength="16" class="form-control form-control-sm"></asp:TextBox>
                          <asp:RequiredFieldValidator ID="RequiredFieldValidatorupl4" runat="server" ForeColor="Red"
                              ValidationGroup="UPLOADchkup" ErrorMessage="its required" ControlToValidate="txtpantanno"></asp:RequiredFieldValidator>
                          <asp:RegularExpressionValidator ValidationGroup="UPLOADchkup" ValidationExpression="[A-Z]{5}\d{4}[A-Z]{1}"
                              ControlToValidate="txtpantanno" ID="RegularExpressionValidator4" runat="server"
                              ErrorMessage="Invalid ex:ABCDE1234F" Display="None" SetFocusOnError="true"></asp:RegularExpressionValidator>
                          <cc1:ValidatorCalloutExtender ID="ValidatorCalloutExtenderPan" runat="server" TargetControlID="RegularExpressionValidator4">
                          </cc1:ValidatorCalloutExtender>
                            <asp:Image ID="lblremarkspantan" runat="server" CssClass="imgIcon" Text="" onmouseover="tooltip.pop(this, this.alt)" />
                            </div>
                            </div>

                        <div class="col-lg-4">
                      <div class="form-group text_boxicon">
                                <span class="req">*</span><label>GSTIN No</label>
                           <asp:TextBox ID="txtvat" runat="server" MaxLength="16" class="form-control form-control-sm"></asp:TextBox>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidatorupl5" runat="server" ForeColor="Red"
                                        ValidationGroup="UPLOADchkup" ErrorMessage="its required" ControlToValidate="txtvat"></asp:RequiredFieldValidator>
                            <asp:Image ID="lblremarksvatno" runat="server" Text="" CssClass="imgIcon" onmouseover="tooltip.pop(this, this.alt)" />
                      </div>
                  
                  </div>
                        
                    </div>
            
                  
                   <div class="form-row">
                       <div class="col-lg-4">
                      <div class="form-group text_boxicon">
                                <span class="req">*</span><label>Address Document</label>
                           <asp:FileUpload ID="FileUploadaddpfrrof" runat="server" class="form-control form-control-sm" onchange="fileTypeCheckFiles(this.value);"></asp:FileUpload>
                                <asp:Label ID="llvl" runat="server" CssClass="astrics"></asp:Label>
                           
                               <asp:RequiredFieldValidator ID="RequiredFieldValidatorupl8" runat="server" ForeColor="Red"
                                        ValidationGroup="UPLOADchkup" ErrorMessage="its required" ControlToValidate="FileUploadaddpfrrof"></asp:RequiredFieldValidator>
                            <asp:Image ID="lblremarksaddresproof" runat="server" Text="" CssClass="imgIcon" onmouseover="tooltip.pop(this, this.alt)" />
                      </div>
                      </div>
                      <div class="form-group col-lg-2 mt4">
                        <a id="HyperLink0" runat="server" class="btn btn-primary btn-block" target="_blank" title="View Documents">View</a>
                      </div>
                       <div class="col-lg-4">
                           <div class="form-group text_boxicon">
                                <span class="req">*</span><label>Authorised Person/Document</label>
                          <asp:FileUpload ID="FileUploadowner" runat="server" class="form-control form-control-sm" onchange="fileTypeCheckFiles0(this.value);"></asp:FileUpload>
                                <asp:Label ID="llvl0" runat="server" CssClass="astrics"></asp:Label>
                           <asp:RequiredFieldValidator ID="RequiredFieldValidatorupl9" runat="server" ForeColor="Red"
                                        ValidationGroup="UPLOADchkup" ErrorMessage="its required" ControlToValidate="FileUploadowner"></asp:RequiredFieldValidator>
                               <asp:Image ID="lblremarksownerproof" runat="server" CssClass="imgIcon" Text="" onmouseover="tooltip.pop(this, this.alt)" />
                          </div>  
                      </div>
                      <div class="form-group col-lg-2 mt4">
                        <a id="HyperLink1" runat="server" class="btn btn-primary btn-block" target="_blank" title="View Documents">View</a>
                      </div>
                      
                  </div>
                 

                   <div class="form-row">
                    <div class="col-lg-4">
                            <div class="form-group text_boxicon">
                                <span class="req">*</span><label>Signature Documents</label>
                          <asp:FileUpload ID="FileUploadsignature" runat="server" class="form-control form-control-sm" onchange="fileTypeCheckFiles1(this.value);"></asp:FileUpload>
                                <asp:Label ID="llvl1" runat="server" CssClass="astrics"></asp:Label>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorupl10" runat="server" ForeColor="Red"
                                        ValidationGroup="UPLOADchkup" ErrorMessage="its required" ControlToValidate="FileUploadsignature"></asp:RequiredFieldValidator>
                                <asp:Image ID="lblremarkssignature" runat="server" Text="" CssClass="imgIcon" onmouseover="tooltip.pop(this, this.alt)" />
                            
                      </div>
                        </div>
                      <div class="form-group col-lg-2 mt4">
                        <a id="HyperLink2" runat="server" class="btn btn-primary btn-block" target="_blank" title="View Documents">View</a>
                      </div>
                      <div class="form-group offset-lg-5 col-lg-1 mt4">
                          <asp:Button ID="btnEdit" CausesValidation="true" runat="server" class="btn float-right btn-sccess btn-block mb-0" style="color: #0088cc;"  
                                    Text="Edit" OnClick="btnEdit_Click" ></asp:Button>
                                <asp:Button ID="btnUploadDoc" CausesValidation="true" runat="server" class="btn btn-primary float-right mb-0"  Style="display:none;"
                                    Text="Upload Document" OnClick="btnUploadDoc_Click" ValidationGroup="UPLOADchkup"></asp:Button>
                      </div>
                  </div>
                 
                   <!--<div class="form-row">
                      <div class="form-group col-lg-12">
                           
                                <asp:Label ID="lblfiletype" Style="font-family: Arial; font-size: 12px; color: red;"
                                    runat="server" Text="File Type ---- .zip,.png,.jpg,.jpeg,.pdf,.doc,.docx. Size should be less than 10MB."></asp:Label>
                                <asp:HiddenField ID="HiddenField0" runat="server" />
                                <asp:HiddenField ID="HiddenField1" runat="server" />
                                <asp:HiddenField ID="HiddenField2" runat="server" />
                                <asp:Image ID="lblremarkssoundinfo" runat="server" Text="" Visible="false" onmouseover="tooltip.pop(this, this.alt)" />
                      </div>
                       </div>-->

            
            <table cellpadding="0" cellspacing="0" width="100%">
                <tr>
                    <td>
                        <asp:Panel ID="PanelAlert" runat="server" Width="20%" Style="display: none;">
                            <div class="popupContent" style="width: 100%;">
                                <div class="pop_log_bg">
                                    <div>
                                        <asp:Button ID="btnAlertPnlClose" CssClass="popupClose" runat="server" CausesValidation="false" />
                                    </div>
                                    <div class="service_head_p">
                                        <p>
                                            <span class="left">
                                                <asp:Label ID="LabelAlertheader" runat="server" Text="Password" Font-Size="12px"></asp:Label>
                                            </span><span class="right" style="visibility: hidden;"><span class="astrics"><strong></strong></span></span>
                                        </p>
                                    </div>
                                    <div class="regis_popup" style="text-align: center;">
                                        <br />
                                        <asp:Label ID="LabelAlertText" runat="server" Text="" Font-Size="11px"></asp:Label><br />
                                        <br />
                                        <div id="infobtn" runat="server" visible="false">
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </asp:Panel>
                        <!--===============================Popup Close================================-->
                        <asp:Label ID="Label12" runat="server"></asp:Label><asp:Label ID="Label13" runat="server"
                            Visible="false"></asp:Label>
                        <cc1:ModalPopupExtender ID="ModalPopupExtenderAlert" runat="server" BackgroundCssClass="NewmodalBackground"
                            CancelControlID="btnAlertPnlClose" PopupControlID="PanelAlert" TargetControlID="Label12">
                        </cc1:ModalPopupExtender>
                        <asp:ValidationSummary runat="server" ShowMessageBox="true" ShowSummary="false" />
                    </td>
                </tr>
            </table>
                  </div>
        </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnUploadDoc" />
        </Triggers>
    </asp:UpdatePanel>
                      </div>





            </div>
        </div>

    </div>
        </div>
</asp:Content>
