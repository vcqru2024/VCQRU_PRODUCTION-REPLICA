<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="AddBigDataAnalysis.aspx.cs"
     Inherits="Manufacturer_AddBigDataAnalysis" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">


    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(19).addClass("active");
            $(".accordion2 div.open").eq(11).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });

         
    </script>
<script>
   
    function showImgBtn123() {
         document.getElementById("<%=btnExceldwn.ClientID%>").click();
    }
       
 
</script>
    <style type="text/css">
        #popupAlert
        {
            position: absolute;
            background: url(../Content/images/alert_bg_login.png) repeat;
            z-index: 10001;
            padding: 6px;
            width: auto;
            font-size: 13px;
            display: inline-block;
            left: 30%;
        }
        #popupAlert div.content_area_alert
        {
            font-family: Tahoma, Geneva, sans-serif;
            font-size: 11px;
            position: relative;
            border: solid 1px #ffffff;
            display: inline-block;
            min-width: 300px;
        }
        #popupAlert div.content_area_alert div.alert_f_header
        {
            background: #e74b4b;
            display: block;
            width: 100%;
        }
        #popupAlert div.content_area_alert div.alert_f_header div.alert_here
        {
            font-family: oswald;
            font-size: 20px;
            font-weight: 300;
            color: #ffffff;
            padding: 15px;
            padding-right: 50px;
        }
        .popclosebtn
        {
            font-size: 14px;
            line-height: 14px;
            right: 11px;
            top: 10px;
            position: absolute;
            color: #6fa5fd;
            font-weight: 700;
            display: block;
        }
    </style>

    <script type="text/javascript" language="javascript">
        function fileTypeCheck(mm) {
            PageMethods.checkFile(mm, onengcheck)
        }
        function onengcheck(Result) {
            var size = document.getElementById("<%=FileUpload1.ClientID%>").files[0].size;
            if (Result == true) {
                if (size > 1024000)
                    document.getElementById("<%=lblImg.ClientID %>").innerHTML = "FileSize should not exceed 1MB";
                else
                    document.getElementById("<%=lblImg.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnsave.ClientID %>").disabled = true;
                document.getElementById("<%=btnsave.ClientID %>").className = "button_all_Sec";

            }
            else {
                if (size > 1024000) {
                    document.getElementById("<%=lblImg.ClientID %>").innerHTML = "FileSize should not exceed 1MB";
                    document.getElementById("<%=btnsave.ClientID %>").disabled = true;
                    document.getElementById("<%=btnsave.ClientID %>").className = "button_all_Sec";
                }
                else {
                    document.getElementById("<%=lblImg.ClientID %>").innerHTML = "";
                    document.getElementById("<%=btnsave.ClientID %>").disabled = false;
                    document.getElementById("<%=btnsave.ClientID %>").className = "button_all";
                }
            }
            ChkRegProVal();
        }
        function onengcheck(Result) {
            var size = document.getElementById("<%=FileUpload2.ClientID%>").files[0].size;
            if (Result == true) {
                if (size > 1024000)
                    document.getElementById("<%=lblImg1.ClientID %>").innerHTML = "FileSize should not exceed 1MB";
                else
                    document.getElementById("<%=lblImg1.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnsave.ClientID %>").disabled = true;
                document.getElementById("<%=btnsave.ClientID %>").className = "button_all_Sec";

            }
            else {
                if (size > 1024000) {
                    document.getElementById("<%=lblImg1.ClientID %>").innerHTML = "FileSize should not exceed 1MB";
                    document.getElementById("<%=btnsave.ClientID %>").disabled = true;
                    document.getElementById("<%=btnsave.ClientID %>").className = "button_all_Sec";
                }
                else {
                    document.getElementById("<%=lblImg1.ClientID %>").innerHTML = "";
                    document.getElementById("<%=btnsave.ClientID %>").disabled = false;
                    document.getElementById("<%=btnsave.ClientID %>").className = "button_all";
                }
            }
            ChkRegProVal();
        }
        function ChkRegProVal() {
            if ((document.getElementById("<%=lblImg.ClientID %>").innerHTML == "") && (document.getElementById("<%=lblImg1.ClientID %>").innerHTML == "")) {
                document.getElementById("<%=btnsave.ClientID %>").disabled = false;
                document.getElementById("<%=btnsave.ClientID %>").className = "button_all";
            }
            else {
                document.getElementById("<%=btnsave.ClientID %>").disabled = true;
                document.getElementById("<%=btnsave.ClientID %>").className = "button_all_Sec";
            }
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="lbleditlabelid" runat="server" Text="" Visible="false"></asp:Label>
    <div class="col-lg-9">
        <div class="sort-destination-loader sort-destination-loader-showing">
            <div class="row portfolio-list sort-destination" data-sort-id="portfolio">
                <div class="col-lg-12 card card-admin form-wizard profile">
                    <header class="card-header">
                        <h4 class="card-title"><i class="fa fa-pencil-square-o"> 
                            Add/Edit Details</i></h4>
                    </header>
           <div id="DivMshLac" runat="server" visible="false">
                                                    <p>
                                                        <asp:Label Text="" ID="lblMshLac" ForeColor="Red" runat="server" />
                                                    </p>

                                                </div>

                    <div  class="card-body card-body-nopadding">
                   <%-- <h6> Product Info</h6>--%>
                  
                    <div class="form-row">
                        <div class="form-group col-lg-6">
                            <span class="req">*</span><label>Data Quantity</label>
                            <asp:DropDownList ID="ddlQty" runat="server" CssClass="form-control form-control-sm" AutoPostBack="true" OnSelectedIndexChanged="ddlQty_SelectedIndexChanged">
                                                </asp:DropDownList>
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ForeColor="Red"
                                                    ErrorMessage="*" ValidationGroup="FTset" ControlToValidate="ddlQty" InitialValue="0">
                                                </asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group col-lg-6">
                            <span class="req">*</span>
                            <label>Data Price (Rs)</label>
                            <asp:TextBox ID="txtPrice" CssClass="form-control form-control-sm" runat="server" ReadOnly="true"></asp:TextBox>
                             <asp:DropDownList ID="ddlPrice" runat="server" CssClass="drp" Enabled="false" Visible="false">
                                                </asp:DropDownList>
                        </div>
                    </div>

                      <div class="form-row">
                          <div class="form-group col-lg-6">
                              <span class="req"></span><label>View Consumer/End user</label>
                            <asp:ImageButton ID="btnExceldwn" runat="server"  Width="25px" Height="25px" Visible="true" ImageUrl="~/Content/images/excel.png" ToolTip="Download Excel" OnClick="btnExceldwn_Click1" />
                               
                          </div>
                           
                        <div class="form-group col-lg-6">
                           <asp:Label ID="lblImg" runat="server" ForeColor="Red" Font-Size="10px"></asp:Label>
                                  <asp:FileUpload ID="FileUpload1" Width="200px" runat="server" onchange="fileTypeCheck(this.value);" visible="false" />
                                                <a id="Doc1"  visible="false"  target="_blank" title="View Photo First" runat="server">View</a>
                             <asp:Label ID="lblImg1" runat="server" ForeColor="Red" Font-Size="10px"></asp:Label>
                              <asp:FileUpload ID="FileUpload2" Width="200px"  runat="server" onchange="fileTypeCheck1(this.value);" visible="false" />
                                                <a id="Doc2" target="_blank" title="View Photo Second" runat="server" visible="false">View</a>
                        </div>

                    </div>
                         
                   
                     <div class="form-row">
                        <div class="form-group col-lg-6">
                               <asp:Label ID="lblrowid" runat="server" Visible="false"></asp:Label>
                                                <asp:Label ID="lblentrydate" runat="server" Visible="false"></asp:Label>
                            </div>
                         <div class="form-group col-lg-4">  <asp:CheckBox Text="Send Mail To Company" runat="server" ID="chkSendMail" Visible="False" />
                                                <asp:Button ID="btnsave" runat="server" CssClass="btn btn-primary float-right mb-0" OnClick="btnsave_Click"
                                                    ValidationGroup="FTset" Text="Save" /></div>
                         <div class="form-group col-lg-2">   <asp:Button ID="btnReset" OnClick="btnReset_Click" CssClass="btn btn-primary float-right mb-0" runat="server"
                                                    Text="Cancel" /></div>
                         </div>
                      
                    
                        
                    
                </div>
            </div>
        </div>
        </div>
    <asp:Label ID="lblid" runat="server" Visible="false"></asp:Label>
    </div>
</asp:Content>
