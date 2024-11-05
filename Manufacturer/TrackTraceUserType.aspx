<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true"
    Title="User Types" CodeFile="TrackTraceUserType.aspx.cs" Inherits="TrackTraceUserType" %>

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

          function fileTypeCheckFiles(mm, ctrl) {

           // var size = document.getElementById("<%=FileUploadDistributor.ClientID%>").files[0].size;
            var index = mm.toString().lastIndexOf('.');
            var ext = mm.toString().substring(index, mm.toString().length);
            var ext23 = ext.toLocaleUpperCase();
            if (ext.toLocaleUpperCase() == ".XLS" || ext.toLocaleUpperCase() == ".XLSX") {

                <%--  if (size > 10240000)
                    document.getElementById("<%=llvl.ClientID %>").innerHTML = "FileSize should not exceed 10MB";
                else
                    document.getElementById("<%=llvl.ClientID %>").innerHTML = "Invalid";--%>


            }
            else {
                alert('Incorrect file format, Please select .xls file');
                document.getElementById(ctrl).value = '';
            }
           <%-- else {
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
            }--%>

          }

       
        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
       <div class="col-lg-9">

        <div class="sort-destination-loader sort-destination-loader-showing">
            <div class="row portfolio-list sort-destination" data-sort-id="portfolio">
                <div class="col-lg-12 card card-admin form-wizard profile">


   <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
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
            </asp:UpdateProgress>--%>
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
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"><asp:Label Text="Track and Trace Master" ID="lblSet" runat="server" />  </i>
                                     <asp:ImageButton ID="imgNew" OnClick="imgNew_Click" ImageUrl="~/images/add_new.png"
                                    runat="server" ToolTip="Create New Label"  Visible="false"/>
                                </h4>
                            </header>

            <div id="newMsg" runat="server" >
                <p>
                    <asp:Label ID="Label2" runat="server"></asp:Label>
                </p>
            </div>

             <div class="card-body card-body-nopadding" id="divTNT1" runat="server" >
                           
              <%--   <div class="form-row">

                             <div class="form-group col-lg-3">
                                 <span class="req"></span>
                                 <label>No of items/Product per Unit/Cartoon</label>
                             </div>
                        <div class="form-group col-lg-4">
                               <asp:TextBox ID="txtNoofItems" placeholder="Enter no of items" class="form-control form-control-sm" runat="server">
                                 </asp:TextBox>
                        </div>
                     </div>--%>
                         
                         <div class="form-row" id="addmode">
 
                             <div class="form-group col-lg-3">
                                 <span class="req"></span>
                                 <label>Select UserType  <br /><a id="hylnkDistributor" runat="server" title="Download" href="~/UserType.xls">View Format(.xls)</a></label>
                             </div>
                              <div class="form-group col-lg-4">
                                  <asp:DropDownList runat="server" CssClass="form-control form-control-sm" ID="ddlUT" >                                     
                                  </asp:DropDownList>
                                  <asp:RequiredFieldValidator ErrorMessage="*" ValidationGroup="ff" ControlToValidate="ddlUT" InitialValue="0" runat="server" ForeColor="Red" />
                             </div>

                             <div class="form-group col-lg-4">
                                  <asp:FileUpload ID="FileUploadDistributor" runat="server" class="form-control form-control-sm" 
                                      onchange="fileTypeCheckFiles(this.value,'ctl00_ContentPlaceHolder1_FileUploadDistributor');" ></asp:FileUpload>
                             </div>
                             
                            
                         </div>
                         <%--<div class="form-row">

                             <div class="form-group col-lg-3">
                                 <span class="req"></span>
                                 <label>Retailers (.xls)<br />  <a id="HylnkRetailer" runat="server"  title="Download" href="~/Retailer.xls">View Format</a></label>
                             </div>
                             <div class="form-group col-lg-4">
                                 <asp:FileUpload ID="FileUploadRetailer" runat="server" class="form-control form-control-sm" 
                                      onchange="fileTypeCheckFiles(this.value,'ctl00_ContentPlaceHolder1_FileUploadRetailer');"></asp:FileUpload>
                             </div>

                             <div class="form-group col-lg-4">
                                     <a id="A2" runat="server" title="Download" target="_blank" href="FrmDealer.aspx?utype=3">Retailers List</a>
                             </div>
                         </div>--%>
                         </div>



                    <div class="card-body card-body-nopadding">
                        <div class="form-row">
                            <div class="form-group col-lg-3">
                            </div>
                            <div class="form-group col-lg-3">
                            </div>
                          

                            <div class="form-group col-lg-3">
                                <asp:Button ID="btnSave" runat="server" Text="Save" class="btn btn-primary float-right mb-0" OnClick="btnSave_Click"  ValidationGroup="ff" />
                                </div>
                                <div class="form-group col-lg-3">
                                <asp:Button ID="btnReset" runat="server" Text="Cancel" class="btn btn-primary float-left mb-0" OnClick="btnReset_Click2" />
                            </div>
                        </div>
                    </div>
                    </div>
            <asp:Panel ID="PnlDefault" runat="server"  Visible="false">
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
       <%--</ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave"  />
            <asp:AsyncPostBackTrigger ControlID="btnAddProduction" EventName="click"  />
            <asp:AsyncPostBackTrigger ControlID="btnChannels" EventName="click"  />
        </Triggers>
    </asp:UpdatePanel>--%>
                    </div>
                </div>
            </div>
          
           <%--</div>--%>
</asp:Content>
