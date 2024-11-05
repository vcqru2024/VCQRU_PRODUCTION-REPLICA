<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true"
    Title="Brand Loyalty Master Setting" CodeFile="BrandLoyaltySettings.aspx.cs" Inherits="BrandLoyaltySettings" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(12).addClass("active");
            $(".accordion2 div.open").eq(11).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
            ShowImagePreview();
        });
        // Configuration of the x and y offsets
        function ShowImagePreview() {
            xOffset = -20;
            yOffset = 40;

            $("a.preview").hover(function(e) {
                this.t = this.title;
                this.title = "";
                var c = (this.t != "") ? "<br/>" + this.t : "";
                $("body").append("<p id='preview'><img src='" + this.href + "' alt='Image preview' /></p>");
                $("#preview")
            .css("top", (e.pageY - xOffset) + "px")
            .css("left", (e.pageX + yOffset) + "px")
            .fadeIn("slow");
            },

    function() {
        this.title = this.t;
        $("#preview").remove();
    });

            $("a.preview").mousemove(function(e) {
                $("#preview")
            .css("top", (e.pageY - xOffset) + "px")
            .css("left", (e.pageX + yOffset) + "px");
            });
        };

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
                    <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
                        z-index: 100001; top: 0px;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
           <%-- <div class="head_cont">
                <h2 class="loyalty_settings" >
                    <table width="99%">
                        <tr>
                            <td width="25%">
                                
                            </td>
                            <td width="60%">
                                <asp:Label ID="Label3" runat="server" CssClass="astrics"></asp:Label>
                            </td>
                            <td align="right" style="display: none;">
                               
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>--%>
            
              <header class="card-header">
                                <h4 class="card-title"><i class="fa fa-pencil-square-o">  </i><asp:Label Text="Brand Loyalty Settings" ID="lblSet" runat="server" />
                                     <asp:ImageButton ID="imgNew" OnClick="imgNew_Click" ImageUrl="~/images/add_new.png"
                                    runat="server" ToolTip="Create New Label"  Visible="false"/>
                                </h4>
                            </header>

            

            <div class="card-body card-body-nopadding" runat="server" id="tblBL">
                <div id="newMsg" runat="server" >
                <p>
                    <asp:Label ID="Label2" runat="server"></asp:Label>
                </p>
            </div>
                <h6>General Info</h6>
                 <div class="form-row">
                    <div class="form-group col-lg-3">
                          <span class="req"></span><label>Min. Bank Transfer</label>
                         <asp:TextBox ID="txtminbanktransfer" runat="server" class="form-control form-control-sm"  placeholder="Min. Bank Transfer Amount" onkeypress="return isNumberKey(this, event);"></asp:TextBox>
                    </div>
                      <div class="form-group col-lg-3">
                            <span class="req"></span><label>1 Rs. Equal To Points</label>
                          <asp:TextBox ID="txtonersequalto" runat="server" class="form-control form-control-sm" placeholder="Points..." onkeypress="return isNumberKey(this, event);"></asp:TextBox>
                    </div>
               <div class="form-group col-lg-6">
                            <span class="req"></span><label>Minimum limit of referral amount(Referral service)</label>
                          <asp:TextBox ID="txtMinimumRefAmount" runat="server" class="form-control form-control-sm" placeholder="amount..." onkeypress="return isNumberKey(this, event);"></asp:TextBox>
                    </div>
                      <div class="form-group col-lg-3">
                             <asp:CheckBox ID="chkIsActive" runat="server" Text="IsActive" Checked="true"  Visible="false"/>
                          <asp:CheckBox ID="chkIsDelete" runat="server" Text="IsDelete" Visible="false"/>
                    </div>
                    
                </div>
                <div class="form-row">
                     
                    <div class="form-group col-lg-3">
                          <span class="req"></span><label>Awards Distributes &nbsp;&nbsp;</label>
                        <asp:CheckBox ID="chkcourier" runat="server" Text="  By Courier" />&nbsp;&nbsp;<asp:CheckBox ID="chkdealer" runat="server" Text="  By Dealer" />
                    </div>
                </div>
                    </div>
                <div class="card-body card-body-nopadding" runat="server" id="tblRS">
                 <h6><strong>Note : End user can refer their "referral code" to other user's. And limit to that is Referral Limit.</strong></h6>
                <div class="form-row">
                    <div class="form-group col-lg-6">
                        <span class="req"></span>
                        <label>Referral Limit</label>
                        <asp:TextBox ID="txtLimit" runat="server" class="form-control form-control-sm" placeholder="Limit for referral" onkeypress="return isNumberKey(this, event);"></asp:TextBox>
                    </div>
                </div>
              
            </div>
            
             <div class="card-body card-body-nopadding">
               <div class="form-row">
                     <div class="form-group col-lg-1">
                            <asp:Button ID="btnSave" runat="server" Text="Save" class="btn btn-primary btn-block float-right mb-0" OnClick="btnSave_Click" />
                     </div>
 
     <div class="form-group col-lg-1">
                                <asp:Button ID="btnReset" runat="server" Text="Reset" class="btn btn-success btn-block float-right mb-0" OnClick="btnReset_Click" />
 </div>
                 </div>
                 </div>
            <asp:Panel ID="PnlDefault" runat="server" DefaultButton="btnSave" Visible="false">
                <fieldset class="field_profile">
                    <legend>Search</legend>
                    <table width="98%" cellpadding="0" cellspacing="10" class="tab_regis" >
                        <tr>
                            <td align="right" width="25%">
                                <strong></strong>
                            </td>
                            <td>
                               
                            </td>
                            <td align="right" width="25%">
                                <strong></strong>
                            </td>
                            <td>
                                
                            </td>                                                                                   
                        </tr>
                        <tr style="display:none;">                            
                            <td align="right" width="13%">
                                <strong>Is Active</strong>
                            </td>
                            <td>
                             
                            </td>
                            <td align="right" width="12%">
                                <strong>Is Delete</strong>
                            </td>
                            <td>
                                
                            </td>                            
                        </tr>
                        <tr>
                            <td align="right" width="25%">
                                <strong></strong>
                            </td>
                            <td>
                                
                            </td>
                            <td align="left" width="25%">
                                
                            </td>
                            <td align="justify">                                
                                                                                       
                            </td>                                                                                   
                        </tr>
                    </table>
                      <table width="98%" cellpadding="0" cellspacing="10" class="tab_regis" >
                          <tr>
                              <td colspan="4"></td>
                          </tr>
                        <tr>
                            
                            <td align="right" width="25%">
                                <strong>. </strong>
                            </td>
                            <td>
                             
                            </td>  
                             <td align="right" width="25%">
                           
                            </td>
                            <td>
                               
                            </td>                                                                           
                        </tr>
                    </table>
                    <table width="98%" cellpadding="0" cellspacing="10" class="tab_regis" runat="server" id="tblR1S">
                        <tr>
                            <td align="right">
                            
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </asp:Panel>
           
            <div class="grid_container">
            </div>
        </ContentTemplate>
        <Triggers>
            <%--<asp:PostBackTrigger ControlID="btnSave" />--%>
        </Triggers>
    </asp:UpdatePanel>
                    </div>
                </div>
            </div>
           </div>
           </div>
</asp:Content>
