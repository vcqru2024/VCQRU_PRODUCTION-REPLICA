<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="AddLabelRequest.aspx.cs" Inherits="Manufacturer_AddLabelRequest" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(21).addClass("active");
            $(".accordion2 div.open").eq(20).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <script type="text/javascript" language="javascript">
        function precise_round(num, decimals) {
            return Math.round(num * Math.pow(10, decimals)) / Math.pow(10, decimals);
        }
        function FindAllGrandT(vl) {

            var lblCode = document.getElementById("<%=HdLabelCodeRequest.ClientID %>").value;
            var ProID = document.getElementById("<%=ddlprotype.ClientID %>").value;
            if (lblCode == "") {
                document.getElementById("<%=Label1.ClientID %>").innerHTML = "Please select Product !";
                document.getElementById("<%=Div1.ClientID %>").className = "alert_boxes_pink big_msg";
                document.getElementById("<%=btnRequestSend.ClientID %>").disabled = true;
                document.getElementById("<%=btnRequestSend.ClientID %>").className = "btn btn-primary mr-2 mb-0";
                document.getElementById("<%=txtNoofLabel.ClientID %>").value = "";
                document.getElementById("<%=lblGrandTotal.ClientID %>").innerHTML = "";
                return;
            }
                        
            var code = document.getElementById("<%=txtNoofLabel.ClientID %>").value;
            if (code != "") {
                if (parseInt(code) > 100000)
                {
                    document.getElementById("<%=Label1.ClientID %>").innerHTML = "Please enter No. of Requested Label not exceeding 1000000 (1 lakh)";
                    document.getElementById("<%=Div1.ClientID %>").className = "alert_boxes_pink big_msg";
                    document.getElementById("<%=btnRequestSend.ClientID %>").disabled = true;
                    document.getElementById("<%=btnRequestSend.ClientID %>").className = "btn btn-primary float-right mb-0";
                    document.getElementById("<%=txtNoofLabel.ClientID %>").value = "";
                    document.getElementById("<%=lblGrandTotal.ClientID %>").innerHTML = "";                 
                    return;
                }
            }

            var val = lblCode + "-" + vl + "-" + ProID;
            PageMethods.FindAllAmount(val, onCompleteGrandT)
        }
        function onCompleteGrandT(Result) {
            var Arr = Result.toString().split('-'); 
            if (Arr[1].toString() == "True") {
                if (Arr[0].toString() == "0") {                    
                    document.getElementById("<%=Label1.ClientID %>").innerHTML = "Please enter requested  No. of print Labels !";
                    document.getElementById("<%=Div1.ClientID %>").className = "alert_boxes_pink big_msg";
                    document.getElementById("<%=btnRequestSend.ClientID %>").disabled = true;
                    document.getElementById("<%=btnRequestSend.ClientID %>").className = "btn btn-primary float-right mb-0";
                    document.getElementById("<%=txtNoofLabel.ClientID %>").value = "";
                    document.getElementById("<%=lblGrandTotal.ClientID %>").innerHTML = "";
                }
                else {
                    document.getElementById("<%=Label1.ClientID %>").innerHTML = "";
                    document.getElementById("<%=Div1.ClientID %>").className = "";
                    document.getElementById("<%=btnRequestSend.ClientID %>").disabled = false;
                    document.getElementById("<%=btnRequestSend.ClientID %>").className = "btn btn-primary mr-2 mb-0";
                    document.getElementById("<%=lblGrandTotal.ClientID %>").innerHTML = precise_round(Arr[0], 2);
                }                
            }
            else {
                document.getElementById("<%=lblGrandTotal.ClientID %>").innerHTML = "";
                document.getElementById("<%=Label1.ClientID %>").innerHTML = "Please enter requested  No. of print Labels !";
                document.getElementById("<%=Div1.ClientID %>").className = "alert_boxes_pink big_msg";
                document.getElementById("<%=btnRequestSend.ClientID %>").disabled = true;
                document.getElementById("<%=btnRequestSend.ClientID %>").className = "btn btn-primary float-right mb-0";
                document.getElementById("<%=txtNoofLabel.ClientID %>").value = "";
            }
        }
        
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <asp:Label ID="lbleditlabelid" runat="server" Text="" Visible="false"></asp:Label>
    <div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
                <div class="card card-admin form-wizard profile box_card box_card">
                    <header class="card-header">
                        <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Add/Edit Label Request</h4>
                    </header>
                     
                    
                    <div  class="card-body card-body-nopadding">
                        <div id="Div1" runat="server">
                        <p>
                            <asp:Label ID="Label1" runat="server"></asp:Label>

                        </p>
                       </div>
                     <div id="DivNewMsg" runat="server" >
                        <p>
                            <asp:Label ID="LabelRequestmsg" runat="server"></asp:Label>
                            <asp:Label ID="lblpopmsg" runat="server"></asp:Label>
                                <asp:HiddenField ID="hdnCompID" runat="server" />
                        </p>
                     </div>
                   <%-- <h6> Product Info</h6>--%>
                  
                        <div class="form-row">
                            <div class="form-group col-lg-4">
                                <span class="req">*</span><label>Product Name</label>
                                <asp:DropDownList ID="ddlprotype" runat="server" CssClass="form-control form-control-sm"
                                    OnSelectedIndexChanged="ddlprotype_SelectedIndexChanged" AutoPostBack="true">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldproductListValidator1" runat="server"
                                    InitialValue="--Select--" ForeColor="Red" ValidationGroup="reqlbl" ControlToValidate="ddlprotype"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group col-lg-4">
                                <span class="req">*</span><label>No. of Requested Label</label>
                                <asp:TextBox ID="txtNoofLabel" MaxLength="10" runat="server" CssClass="form-control form-control-sm"
                                                onchange="FindAllGrandT(this.value)"></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFdfvgieldValidator3" runat="server" ValidationGroup="reqlbl"
                                                ControlToValidate="txtNoofLabel"></asp:RequiredFieldValidator>
                                            <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" TargetControlID="txtNoofLabel"
                                                runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-.,/',./';<>?:abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ">
                                            </cc1:FilteredTextBoxExtender>
                            </div>
                            
                            <div class="form-group col-lg-3 text-right mt-4">
                                <asp:Button ID="btnRequestSend" runat="server" OnClick="btnRequestSend_Click" CssClass="btn btn-primary mr-2 mb-0"
                                    Text="Send Request" ValidationGroup="reqlbl" />
                                <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" CssClass="btn btn-success mb-0"
                                    Text="Cancel" />
                            </div>
                        </div>
                       
                        <div class="form-row">
                            <div class="form-group col-lg-6">
                               
                                <span class="req">*</span><label>Label Type - </label>
                                
                                <asp:Label ID="lblTypeNew1" runat="server"></asp:Label>

                                <asp:DropDownList ID="ddlLabelType" runat="server" CssClass="form-control form-control-sm"
                                    Visible="false">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiddvvredFieldValidator2" runat="server" InitialValue="--Select--"
                                    ForeColor="Red" ValidationGroup="reqlbl" ControlToValidate="ddlLabelType"></asp:RequiredFieldValidator>
                            </div>
                            <div class="form-group col-lg-6">
                               
                                 <span class="req">*</span><label>Net Amount (GST) - </label>
                                 (<asp:Label ID="lblGrandTotal" runat="server" />)
                                 <asp:HiddenField ID="HdLabelCodeRequest" runat="server" />
                            </div>
                        </div>

                         <div class="form-row" style="display:none;">
                            <div class="form-group col-lg-6">
                                 <span class="req"></span><label>Production Unit</label>
                                 <asp:DropDownList ID="ddlPU" runat="server" CssClass="form-control form-control-sm">
                                </asp:DropDownList>
                            </div>
                             <div class="form-group col-lg-6">
                                  <span class="req"></span><label>Channels</label>
                                 <asp:DropDownList ID="ddlChannels" runat="server" CssClass="form-control form-control-sm">
                                </asp:DropDownList>
                            </div>
                             </div>
                        
                    

                    
                     <asp:Label ID="lblBankId" runat="server" Text="" Visible="false"></asp:Label>
                     
                    
                </div>
            </div>
        </div>
        </div>
    </div>
    </div>
</asp:Content>
