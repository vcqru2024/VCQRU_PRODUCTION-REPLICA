<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="AddDealer.aspx.cs" Inherits="Manufacturer_AddDealer" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(16).addClass("active");
            $(".accordion2 div.open").eq(11).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <%--<script type="text/javascript" src="js/jquery-1.7.2.min.js" language="javascript">
    </script>--%>

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
                $("body").append("<p id='preview'><img src='" + this.href + "' alt='Image preview' />" + c + "</p>");
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

    <style type="text/css">
        #preview
        {
            position: absolute;
            border: 3px solid #ccc;
            background: #333;
            padding: 5px;
            display: none;
            color: #fff;
            box-shadow: 4px 4px 3px rgba(103, 115, 130, 1);
        }
    </style>

    <script language="javascript" type="text/javascript">
        function checkmobileno(vl) {
            vl = vl + "*" + document.getElementById("<%=hdncmphdn.ClientID %>").value;
            PageMethods.checkMobileNo(vl, onCompletePlanNew)
        }            
        function checkplan(vl) {
            vl = vl + "*" + document.getElementById("<%=hdncmphdn.ClientID %>").value;
            PageMethods.checkNewPlan(vl, onCompletePlan)
        }
        function onCompletePlan(Result) {
            if (Result == true) {
                document.getElementById("<%=lblLabelChk.ClientID %>").innerHTML = "Email ID Already exist.";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";
            }
            else {
                document.getElementById("<%=lblLabelChk.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";
            }
            MyCheck();
        }   
        function onCompletePlanNew(Result) {
            if (Result == true) {
                document.getElementById("<%=lblLblChkMo.ClientID %>").innerHTML = "Mobile No. Already exist.";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";
            }
            else {
                document.getElementById("<%=lblLblChkMo.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";
            }
            MyCheck();
        }
        function MyCheck() {
            var em = document.getElementById("<%=lblLabelChk.ClientID %>").innerHTML;
            var mb = document.getElementById("<%=lblLblChkMo.ClientID %>").innerHTML;
            if ((em == "") && (mb == "")) {
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";
            }
            else {
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";
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
                            Add/Edit Dealer Information<asp:HiddenField ID="hdncmphdn" runat="server" /></i></h4>
                    </header>
                    


                    <div  class="card-body card-body-nopadding">
                   <%-- <h6> Product Info</h6>--%>
                  
                    <div class="form-row">
                        <div class="form-group col-lg-6">
                            <span class="req">*</span><label>Dealer Name</label>
                           <asp:TextBox ID="txtplanname" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator1456" runat="server" ForeColor="Red" ErrorMessage="*"
                                                        ValidationGroup="CCC" ControlToValidate="txtplanname"></asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group col-lg-6">
                            <span class="req">*</span>
                            <label>Contact Person</label>
                            <asp:TextBox ID="txtcontactprson" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                               <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red" ErrorMessage="*"
                                                        ValidationGroup="CCC" ControlToValidate="txtcontactprson"></asp:RequiredFieldValidator>
                        </div>
                    </div>

                      <div class="form-row">
                          <div class="form-group col-lg-6">
                              <span class="req">*</span><label>Email</label>
                              <asp:TextBox ID="txtEmail" CssClass="form-control form-control-sm" runat="server" onchange="checkplan(this.value);"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator2sdfsd" runat="server" ForeColor="Red" ErrorMessage="*"
                                  ValidationGroup="CCC" ControlToValidate="txtEmail"></asp:RequiredFieldValidator>
                              <asp:RegularExpressionValidator ID="RegularExpressionValidator44534" ValidationGroup="CCC"
                                  runat="server" ControlToValidate="txtEmail" Style="color: Red;" Display="Dynamic"
                                  SetFocusOnError="true" ErrorMessage="Ex:a@a.com" ValidationExpression="\w+([-+.']\w+)*@\w+([-.]\w+)*\.\w+([-.]\w+)*"></asp:RegularExpressionValidator>
                               <asp:Label ID="lblLabelChk" runat="server" CssClass="astrics" Text=""></asp:Label>
                               
                          </div>
                        <div class="form-group col-lg-6">
                            <span class="req">*</span>
                            <label>Mobile No</label>
                            <asp:TextBox ID="txtMobileNo" CssClass="form-control form-control-sm" MaxLength="13" OnKeyPress="return isNumberKey(this, event);"
                                                     onchange="checkmobileno(this.value);"  runat="server"></asp:TextBox>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator266" runat="server" ForeColor="Red" ErrorMessage="*"
                                                        ValidationGroup="CCC" ControlToValidate="txtMobileNo"></asp:RequiredFieldValidator>
                            <asp:Label ID="lblLblChkMo" runat="server" CssClass="astrics" Text=""></asp:Label>
                        </div>

                    </div>
                         
                    <div class="form-row">
                        <div class="form-group col-lg-6">
                            <span class="req">*</span><label>Address</label>
                            <asp:TextBox ID="txtaddress" CssClass="form-control form-control-sm" runat="server"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red" ErrorMessage="*"
                                ValidationGroup="CCC" ControlToValidate="txtaddress"></asp:RequiredFieldValidator>


                        </div>
                        <div class="form-group col-lg-6">
                            <span class="req">*</span>
                            <label>City</label>
                              <asp:TextBox ID="ddlUserType" runat="server" CssClass="form-control form-control-sm" ></asp:TextBox>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red" ErrorMessage="*"
                                                        ValidationGroup="CCC" ControlToValidate="ddlUserType"></asp:RequiredFieldValidator>
                        </div>

                    </div>
                    
                     <div class="form-row">
                        <div class="form-group col-lg-6">
                               <asp:Label ID="lblrowid" runat="server" Visible="false"></asp:Label>
                                                <asp:Label ID="lblentrydate" runat="server" Visible="false"></asp:Label>
                            </div>
                         <div class="form-group col-lg-4"><asp:Button ID="btnSave" OnClick="btnSave_Click" ValidationGroup="CCC" CssClass="btn btn-primary float-right mb-0"
                                                    runat="server" Text="Save" /></div>
                         <div class="form-group col-lg-2">   <asp:Button ID="btnReset" OnClick="btnReset_Click" CssClass="btn btn-primary float-right mb-0" runat="server"
                                                    Text="Cancel" /></div>
                         </div>
                      
                    
                        
                    
                </div>
            </div>
        </div>
        </div>
    
    </div>
</asp:Content>
