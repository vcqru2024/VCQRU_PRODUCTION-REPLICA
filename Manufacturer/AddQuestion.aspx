<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="AddQuestion.aspx.cs" Inherits="Manufacturer_AddQuestion" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function () {

            $(".accordion2 p").eq(17).addClass("active");
            $(".accordion2 div.open").eq(11).show();

            $(".accordion2 p").click(function () {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <style type="text/css">
        .myrd input
        {
            position: relative;
            padding: 5px;
            margin-left: 5px;
            margin-top: 9px;
        }
        .myrd label
        {
            position: relative;
            padding: 5px;
            font-weight: bold;
        }
    </style>

    <script language="javascript" type="text/javascript">
         function checkCourior(vl) {
             var val = vl + "*" + document.getElementById("<%=hdnCompID.ClientID %>").value;
             PageMethods.checkNewLabel(val, onCompleteLaebl)
         }
         function onCompleteLaebl(Result) {
             if (Result == true) {
                 document.getElementById("<%=lblCouriorChk.ClientID %>").innerHTML = "Question already exist.";
                 document.getElementById("<%=btnSubmit.ClientID %>").disabled = true;
                 document.getElementById("<%=btnSubmit.ClientID %>").className = "btn btn-primary float-right mb-0";
             }
             else {
                 document.getElementById("<%=lblCouriorChk.ClientID %>").innerHTML = "";
                 document.getElementById("<%=btnSubmit.ClientID %>").disabled = false;
                 document.getElementById("<%=btnSubmit.ClientID %>").className = "btn btn-primary float-right mb-0";
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
                            Add/Edit Question<asp:HiddenField ID="hdnCompID" runat="server" /></i></h4>
                    </header>


                    <div id="DivNewMsg" runat="server" style="width: 88%;">
                        <p>
                            <asp:Label ID="lblpopmsg" runat="server"></asp:Label>
                        </p>
                    </div>

                    <div  class="card-body card-body-nopadding">
                   <%-- <h6> Product Info</h6>--%>
                  
                    <div class="form-row">
                        <div class="form-group col-lg-6">
                            <span class="req">*</span><label>Question Name</label>
                           <asp:TextBox ID="txtName" runat="server" CssClass="form-control form-control-sm" Text="" MaxLength="500"
                                                    onchange="checkCourior(this.value)"></asp:TextBox>
                             <asp:Label ID="lblCouriorChk" runat="server" CssClass="astrics" Text=""></asp:Label>
                          <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red" ErrorMessage="*"
                                                    ValidationGroup="PR1" ControlToValidate="txtName">
                                                </asp:RequiredFieldValidator>
                        </div>
                        <div class="form-group col-lg-6">
                            
                        </div>
                    </div>

                    
                     <div class="form-row">
                        <div class="form-group col-lg-6">
                               <asp:Label ID="lblrowid" runat="server" Visible="false"></asp:Label>
                                                <asp:Label ID="lblentrydate" runat="server" Visible="false"></asp:Label>
                            </div>
                         <div class="form-group col-lg-4">
                                 <asp:Button ID="btnSubmit" OnClick="btnSubmit_Click" ValidationGroup="PR1"
                                                CssClass="btn btn-primary float-right mb-0" runat="server" Text="Save" /></div>
                         <div class="form-group col-lg-2">   <asp:Button ID="btnReset" OnClick="btnReset_Click" CssClass="btn btn-primary float-right mb-0" runat="server"
                                                    Text="Cancel" /></div>
                         </div>
                      
                    
                        
                    
                </div>
            </div>
        </div>
        </div>
       <asp:Label ID="lblBankId" runat="server" Text="" Visible="false"></asp:Label>
                    <asp:HiddenField ID="dhnactiontype" runat="server" />
    </div>
</asp:Content>
