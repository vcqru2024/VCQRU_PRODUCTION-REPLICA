<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true"
    Title="Brand Loyalty Master Setting" CodeFile="TrackTraceDetails.aspx.cs" Inherits="TrackTraceDetails" %>

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

        function sendTolistbox() {           
            var value = $('#<%=txtProductionInit.ClientID%>').val();
            if (value.length > 0) {
                var option = $("<option />").val("0").html(value);
                $('#<%=lstProdUnit.ClientID%>').append(option);
                $('#<%=txtProductionInit.ClientID%>').val('');
            }
            else {
                alert('Please enter production unit!');
            }
            return false;
        }
        function sendTolistbox_remove() {
           
            var selectedList1 = $('#<%=lstProdUnit.ClientID%> option:selected');
            <%-- var selectedList = $('#<%=lstChannels.ClientID%>  option:selected').toArray();--%>
            
             if (selectedList1.length == 0) {
                 alert("Please select any production unit to remove.");
                 //  e.preventDefault();
             } else {

                 //  $(selectedDesa).append($(selectedList).clone());
                 $(selectedList1).remove();
                 //  alert(selectedDesa.length);

             }
            return false;
        }
         function sendTolistbox2() {           
            var value = $('#<%=txtChannels.ClientID%>').val();
            if (value.length > 0) {
                var option = $("<option />").val("0").html(value);
                $('#<%=lstChannels.ClientID%>').append(option);
                $('#<%=txtChannels.ClientID%>').val('');
            }
            else {
                alert('Please enter warehouse!');
            }
            return false;
         }
        function sendTolistbox2_remove() {
           
            var selectedList = $('#<%=lstChannels.ClientID%> option:selected');
            <%-- var selectedList = $('#<%=lstChannels.ClientID%>  option:selected').toArray();--%>
            
            if (selectedList.length == 0) {
                alert("Please select any channels to remove.");
              //  e.preventDefault();
            } else {
                
              //  $(selectedDesa).append($(selectedList).clone());
                $(selectedList).remove();
              //  alert(selectedDesa.length);

                }
            return false;
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
                           <h6>Paking Details</h6>
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
                         <div class="form-row">

                             <div class="form-group col-lg-3">
                                 <span class="req"></span>
                                 <label>Production Unit</label>
                             </div>
                             <div class="form-group col-lg-4">
                                 <asp:TextBox ID="txtProductionInit" placeholder="Enter production unit" class="form-control form-control-sm" runat="server">
                                 </asp:TextBox>
                                <br />
                                   <%--<asp:Button ID="btnAddProduction" ToolTip="Add production unit"  class="btn btn-primary float-right mb-0"  runat="server" 
                                       Text="Add" OnClientClick="return sendTolistbox();"/>--%>
                                 <asp:Button ID="btnAddProduction" ToolTip="Add production unit"  class="btn btn-primary float-right mb-0"  runat="server" 
                                       Text="Add" OnClick="btnAddProduction_Click"  />
                             </div>
                             
                             <div class="form-group col-lg-4">
                                   <asp:ListBox ID="lstProdUnit"   placeholder="Production Unit List" class="form-control form-control-sm" runat="server" ></asp:ListBox>
                                 </div>
                             <div class="form-group col-lg-1">
                               <%--  <asp:Button ID="Button1"  ToolTip="Remove production unit" class="btn btn-primary float-left mb-0"  runat="server" Text="Remove" OnClientClick="return sendTolistbox_remove();"/>--%>
                                   <asp:Button ID="Button1"  ToolTip="Remove production unit" class="btn btn-primary float-left mb-0"  runat="server" Text="Remove" OnClick="Button1_Click"/>
                             </div>

                         </div>
                          <div class="form-row">

                             <div class="form-group col-lg-3">
                                 <span class="req"></span>
                                 <label>Warehouse</label>
                             </div>
                             <div class="form-group col-lg-4">
                                 <asp:TextBox ID="txtChannels" placeholder="Enter Warehouse Name" class="form-control form-control-sm" runat="server">
                                 </asp:TextBox>
                                 <br />
                                 <%--  <asp:Button ID="btnChannels"  ToolTip="Add Channels" class="btn Warebtn-primary float-right mb-0"  runat="server" 
                                       Text="Add"  OnClientClick="return sendTolistbox2();"/>--%>
                                   <asp:Button ID="btnChannels"  ToolTip="Add Channels" class="btn btn-primary float-right mb-0"  runat="server" 
                                       Text="Add"  OnClick="btnChannels_Click"/>
                             </div>
                             
                             <div class="form-group col-lg-4">
                                   <asp:ListBox ID="lstChannels"   placeholder="Channel List" class="form-control form-control-sm" SelectionMode="Multiple" runat="server" ></asp:ListBox>
                             </div>
                               <div class="form-group col-lg-1">
                               <%--  <asp:Button ID="Button2" ToolTip="Remove Channels"  class="btn btn-primary float-left mb-0" 
                                      runat="server" Text="Remove" OnClientClick="return sendTolistbox2_remove();"/>--%>
                                     <asp:Button ID="Button2" ToolTip="Remove Channels"  class="btn btn-primary float-left mb-0" 
                                      runat="server" Text="Remove" OnClick="Button2_Click"/>
                             </div>
                         </div>
                         <div class="form-row">
 
                             <div class="form-group col-lg-3">
                                 <span class="req"></span>
                                 <label>Distributor (.xls) <br /><a id="hylnkDistributor" runat="server" title="Download" href="~/Distributor.xls">View Format</a></label>
                             </div>
                             <div class="form-group col-lg-4">
                                  <asp:FileUpload ID="FileUploadDistributor" runat="server" class="form-control form-control-sm" 
                                      onchange="fileTypeCheckFiles(this.value,'ctl00_ContentPlaceHolder1_FileUploadDistributor');" ></asp:FileUpload>
                             </div>
                             
                             <div class="form-group col-lg-4">
                                
                                 <a id="A1" runat="server" title="Download" target="_blank" href="FrmDealer.aspx?utype=2">Distributor List</a>
                             </div>

                         </div>
                         <div class="form-row">

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
                         </div>
                         </div>
                     </div>
                
            
             <div class="card-body card-body-nopadding">
               <div class="form-row">
                     <div class="form-group col-lg-3">

                     </div>
                    <div class="form-group col-lg-3">

                     </div>
                     <div class="form-group col-lg-3">
                           
                     </div>
 
     <div class="form-group col-lg-3"> <asp:Button ID="btnSave" runat="server" Text="Save" class="btn btn-primary float-right mb-0" OnClick="btnSave_Click" />
                                <%--<asp:Button ID="btnReset" runat="server" Text="Reset" class="btn btn-primary float-left mb-0" OnClick="btnReset_Click" />--%>
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
