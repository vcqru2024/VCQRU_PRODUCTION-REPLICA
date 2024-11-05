<%@ Page Title="" Language="C#" MasterPageFile="~/Employee/Employee.master" AutoEventWireup="true" CodeFile="Metting.aspx.cs" Inherits="Employee_Metting" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script>
        function checkValidationGrp() {
            var validated = Page_ClientValidate('chk94');
            if (validated) {
               // alert('Page is valid!');
              var ddlMeetvalue = $('#<%=ddlMeetingStatus.ClientID%>').val();
                if (ddlMeetvalue == "1") {

                    if ($('#<%=txtFollowUpDate.ClientID%>').val().length == 0 || $('#<%=txtFollowUpTime.ClientID%>').val().length == 0) {
                        $('#<%=LblMsgUpdate.ClientID%>').text('Please select follow up date and time');
                        $('#<%=NewMsgpop.ClientID%>').addClass("alert_boxes_pink");
                        $(window).scrollTop(10);
                        
                        return false;
                    }
                    else {
                        $('#<%=LblMsgUpdate.ClientID%>').text('');
                        $('#<%=NewMsgpop.ClientID%>').removeClass("alert_boxes_pink");
                        return true;
                    }
                }
                else {
                    $('#<%=LblMsgUpdate.ClientID%>').text('');
                        $('#<%=NewMsgpop.ClientID%>').removeClass("alert_boxes_pink");
                    return true;
                }
            }
            //if (Page_IsValid) {
                
               
            //}
            //else {
            //    // do something else
            //   // alert('Page is not valid!');
            //}
        }

        // javascript to add to your aspx page
        function ValidateModuleList(source, args) {
            var chkListModules = document.getElementById('<%=chkbxServices.ClientID%>');
            var chkListinputs = chkListModules.getElementsByTagName("input");
            for (var i = 0; i < chkListinputs.length; i++) {
                if (chkListinputs[i].checked) {
                    args.IsValid = true;
                    return;
                }
            }
            args.IsValid = false;
        }
    </script>
    <script type="text/javascript">
function NewWindow() {
    //document.forms[0].target = '_blank';
}

$(document).ready(function () {
<%-- $('#<%=txtFollowUpDate.ClientID%>').hide();
    $('#<%=txtFollowUpTime.ClientID%>').hide();
    $('#<%=lblfldt.ClientID%>').hide();
    $('#<%=lblfltt.ClientID%>').hide();--%>
});
   
        function ShowDateTime() {

            var ddlMeetvalue = $('#<%=ddlMeetingStatus.ClientID%>').val();
            if (ddlMeetvalue == "1") {
                $('#<%=txtFollowUpTime.ClientID%>').removeAttr("type");
                <%-- $('#<%=lblfltt.ClientID%>').show();
                $('#<%=txtFollowUpDate.ClientID%>').show();
                $('#<%=txtFollowUpTime.ClientID%>')--%>

                $('#<%=lblfldt.ClientID%>').show();
                $('#<%=lblfltt.ClientID%>').show();
                $('#<%=txtFollowUpDate.ClientID%>').show();
                $('#<%=txtFollowUpTime.ClientID%>').show();
            }
            else {
                $('#<%=txtFollowUpDate.ClientID%>').hide();
                $('#<%=txtFollowUpTime.ClientID%>').hide();
                $('#<%=lblfldt.ClientID%>').hide();
                $('#<%=lblfltt.ClientID%>').hide();
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-lg-9">

        <div class="sort-destination-loader sort-destination-loader-showing">
            <div class="row portfolio-list sort-destination" data-sort-id="portfolio">
                <div class="col-lg-12 card card-admin form-wizard profile">

                    <header class="card-header">
                        <h4 class="card-title"><i class="fa fa-pencil-square-o">Meeting Details</i></h4>
                    </header>
                    <div id="NewMsgpop"  runat="server">
                        <p>
                            <asp:Label ID="LblMsgUpdate" runat="server"></asp:Label>
                        </p>
                    </div>
                     <div class="form-row">
                        <div class="form-group col-lg-6">
                            <span class="req">*</span><label>Select Supervisor</label>
                             <asp:DropDownList runat="server" ID="ddlEmpSupervisor" class="form-control form-control-sm" ></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red" InitialValue="0"
                                ValidationGroup="chk94" ControlToValidate="ddlEmpSupervisor" ErrorMessage="required">
                            </asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group col-lg-6">
                            <span class="req"></span><label>Meeting Title</label>
                            <asp:TextBox ID="txtMeetingTitle" MaxLength="100" class="form-control form-control-sm" runat="server"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator231" runat="server" ForeColor="Red"
                            ValidationGroup="chk94" ControlToValidate="txtMeetingTitle" ErrorMessage="required">
                        </asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-row">
                          <div class="form-group col-lg-6">
                            <span class="req">*</span><label>Select Service</label>
                            <asp:CheckBoxList runat="server" RepeatColumns="2" class="form-control form-control-sm"  ID="chkbxServices" DataTextField="ServiceName" DataValueField="Service_ID">                                
                            </asp:CheckBoxList>
                            <asp:CustomValidator runat="server" ID="cvmodulelist" ValidationGroup="chk94"
                                ClientValidationFunction="ValidateModuleList"
                                ErrorMessage="required"></asp:CustomValidator>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-lg-6">
                            <span class="req">*</span><label>Client/Company Name</label>
                            <asp:TextBox ID="txtCompanyName" MaxLength="100" class="form-control form-control-sm" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red"
                                ValidationGroup="chk94" ControlToValidate="txtCompanyName" ErrorMessage="required">
                            </asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group col-lg-6">
                            <span class="req"></span><label>Person Name</label>
                            <asp:TextBox ID="txtPersonName" MaxLength="100" class="form-control form-control-sm" runat="server"></asp:TextBox>
                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                            ValidationGroup="chk94" ControlToValidate="txtPersonName" ErrorMessage="required">
                        </asp:RequiredFieldValidator>--%>
                        </div>
                    </div>
                     <div class="form-row">
                        <div class="form-group col-lg-6">
                            <span class="req"></span><label>Email</label>
                            <asp:TextBox ID="txtEmail" MaxLength="50" class="form-control form-control-sm" runat="server"></asp:TextBox>
                             <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                    ControlToValidate="txtEmail"  ValidationGroup="chk94"
                            ErrorMessage="a@a.com" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                            <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red"
                                ValidationGroup="chk94" ControlToValidate="txtEmail" ErrorMessage="required">
                            </asp:RequiredFieldValidator>--%>
                        </div>
                        <div class="form-group col-lg-6">
                            <span class="req"></span><label>Mobile No</label>
                            <asp:TextBox ID="txtMobileNo" MaxLength="13" class="form-control form-control-sm" runat="server"></asp:TextBox>
                            <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                            ValidationGroup="chk94" ControlToValidate="txtPersonName" ErrorMessage="required">
                        </asp:RequiredFieldValidator>--%>
                        </div>
                    </div>
                     <div class="form-row">
                        <div class="form-group col-lg-6">
                            <span class="req">*</span><label>Meeting Date (mm/dd/yyyy)</label> 
                            <asp:TextBox ID="txtMeetingDate" MaxLength="10" class="form-control form-control-sm" runat="server" Enabled="false"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                ValidationGroup="chk94" ControlToValidate="txtMeetingDate" ErrorMessage="required">
                            </asp:RequiredFieldValidator>
                            <cc1:CalendarExtender ID="CalendarExtenderdatefrom" runat="server" TargetControlID="txtMeetingDate"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtenderdatefrom" runat="server" TargetControlID="txtMeetingDate"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtenderdatefrom" runat="server"
                                        TargetControlID="txtMeetingDate" WatermarkText="Date">
                                    </cc1:TextBoxWatermarkExtender>
                        </div>
                        <div class="form-group col-lg-6">
                            <span class="req">*</span><label>Meeting Time (hh:mm)</label>
                            <asp:TextBox ID="txtMeetingTime" MaxLength="8" class="form-control form-control-sm"  Enabled="false" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                ValidationGroup="chk94" ControlToValidate="txtMeetingTime" ErrorMessage="required">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-row">
                       
                        <div class="form-group col-lg-6">
                            <span class="req">*</span><label>Meeting Status</label>
                            <asp:DropDownList runat="server" ID="ddlMeetingStatus" class="form-control form-control-sm" onchange="ShowDateTime();" >
                                <asp:ListItem Text="Select"  Value="0" Selected="True" />
                                <asp:ListItem Text="Followup"  Value="1"/>
                                 <asp:ListItem Text="Cancel"  Value="2"/>
                                <asp:ListItem Text="Attended" Value="3" />
                                <asp:ListItem Text="Successfull" Value="4"/>
                                <asp:ListItem Text="NoOutput" Value="5"/>
                            </asp:DropDownList>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red"
                                ValidationGroup="chk94" ControlToValidate="ddlMeetingStatus" ErrorMessage="required" InitialValue="0">
                            </asp:RequiredFieldValidator>
                        </div>
                         <div class="form-group col-lg-3"> 
                              <span class="req"></span><label id="lblfldt"  runat="server">Date</label>
                                <asp:TextBox ID="txtFollowUpDate" MaxLength="15" class="form-control form-control-sm"     runat="server"></asp:TextBox>
                              <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ForeColor="Red"
                                ValidationGroup="chk94" ControlToValidate="txtFollowUpDate" ErrorMessage="required">
                            </asp:RequiredFieldValidator>--%>
                            <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtFollowUpDate"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtFollowUpDate"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server"
                                        TargetControlID="txtFollowUpDate" WatermarkText="Date">
                                    </cc1:TextBoxWatermarkExtender>
                              </div><div class="form-group col-lg-3">
                                   <span class="req"></span><label id="lblfltt"  runat="server">Time (hh:mm)</label>
                             <asp:TextBox ID="txtFollowUpTime" MaxLength="8" class="form-control form-control-sm" runat="server" ></asp:TextBox>
                                  <%--  <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtFollowUpTime"
                                        Format="hh:mm">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtFollowUpTime"
                                        Mask="hh:mm" MaskType="Time">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender2" runat="server"
                                        TargetControlID="txtFollowUpTime" WatermarkText="Time">
                                    </cc1:TextBoxWatermarkExtender>--%>
                         </div>
                    </div>
                    <div class="form-row">
                         <div class="form-group col-lg-6">
                              <span class="req"></span><label>Card Upload</label>                             
                              <asp:FileUpload ID="FileUpload1" runat="server" class="form-control form-control-sm" />
                           
                         </div>
                        <div class="form-group col-lg-6">
                              <span class="req"></span><label><br /><br /></label>   
                          <%--   <asp:LinkButton ID=""  runat="server"  OnClientClick="return NewWindow();" />--%>
                            <a id="LinkButton1" runat="server" target="_blank"></a>
                           
                              
                            </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-lg-6">
                            <asp:FileUpload ID="FileUpload2" runat="server" class="form-control form-control-sm" />
                        </div>
                        <div class="form-group col-lg-6">
                            <%--<asp:LinkButton ID="" runat="server" OnClientClick="return NewWindow();" />--%>
                            <a id="LinkButton2" runat="server" target="_blank"></a>
                        </div>
                         </div>
                    <div class="form-row">
                        <div class="form-group col-lg-6">
                            <asp:FileUpload ID="FileUpload3" runat="server" class="form-control form-control-sm" />
                            </div>
                         <div class="form-group col-lg-6">
                             <%-- <asp:LinkButton  ID=""  runat="server" OnClientClick="return NewWindow();" />--%>
                               <a id="LinkButton3" runat="server" target="_blank"></a>
                             </div>

                        </div>
                     <div class="form-row">
                           <div class="form-group col-lg-6">
                              <span class="req"></span>
                            <label>Visit Status</label>
                                <asp:TextBox ID="txtVisitStatus" MaxLength="300" class="form-control form-control-sm" TextMode="MultiLine" runat="server"></asp:TextBox>
                           </div>
                         </div>
                    <div class="form-row">
                        <div class="form-group col-lg-6">
                            <span class="req"></span>
                            <label>Follow Up Person Name</label>
                            <asp:TextBox ID="txtFlUpPersonName" MaxLength="100" class="form-control form-control-sm" runat="server"></asp:TextBox>
                        </div>
                        <div class="form-group col-lg-6">
                            <span class="req"></span>
                            <label>Follow Up Person Designation</label>
                            <asp:TextBox ID="txtFlupPersonDesignation" MaxLength="100" class="form-control form-control-sm" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-lg-6">
                            <span class="req"></span>
                            <label>Follow Up Person Email</label>
                            <asp:TextBox ID="txtFlupPersonEmail" MaxLength="50" class="form-control form-control-sm" runat="server"></asp:TextBox>
                             <asp:RegularExpressionValidator ID="RegularExpressionValidator891" runat="server"
                                    ControlToValidate="txtFlupPersonEmail"  ValidationGroup="chk94"
                            ErrorMessage="a@a.com" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                        </div>
                        <div class="form-group col-lg-6">
                            <span class="req"></span>
                            <label>Follow Up Person Mobile</label>
                            <asp:TextBox ID="txtFlupPersonMobile" MaxLength="13" class="form-control form-control-sm" runat="server"></asp:TextBox>
                        </div>
                    </div>
                    <div class="form-row">
                         
                      
                             <asp:Button ID="btnUpDate" OnClick="btnUpDate_Click"  ValidationGroup="chk94" class="btn btn-primary float-right mb-5"
                                runat="server" Text="Save"  OnClientClick="return checkValidationGrp();" />
                         &nbsp;&nbsp;
                        <asp:Button ID="Button1" OnClick="Button1_Click"   class="btn btn-primary float-right mb-5"
                                runat="server" Text="Cancel" /> 
                           <asp:Label Text="" Visible="false" ID="lblMeetid" runat="server" />
                        <asp:Label Text="" Visible="false" ID="lblMeetMasterid" runat="server" />
                        </div>
                           
                        
                </div>
            </div>
        </div>
    </div>

</asp:Content>

