<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="AddLabelRequest.aspx.cs" Inherits="Patanjali_AddLabelRequest" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

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

    
        <div class="home-section">
            <div class="app-breadcrumb">
                <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1 g-3">
                    <div class="col">
                        <h5>Add/Edit Label Request</h5>
                    </div>
                    <div class="col">
                        <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li>
                                <li class="breadcrumb-item"><a href="frmPrintLabelRequest.aspx">Request for print Labels</a></li>
                                <li class="breadcrumb-item active" aria-current="page">Add/Edit Label Request</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
            <div class="user-role-card">
                <div class="card">
                    <div class="card-body">

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

                        <form action="" novalidate class="needs-validation">
                            <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1 g-3">
                                <div class="col">
                                    <label for="Select Service" class="form-label">Product Name<span>*</span></label>
                                    <asp:DropDownList ID="ddlprotype" runat="server" CssClass="form-select"
                                    OnSelectedIndexChanged="ddlprotype_SelectedIndexChanged" AutoPostBack="true" required>
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiredFieldproductListValidator1" runat="server"
                                    InitialValue="--Select--" ForeColor="Red" ValidationGroup="reqlbl" ControlToValidate="ddlprotype"></asp:RequiredFieldValidator>
                                    <div class="invalid-feedback">Enter valid product name.</div>
                                </div>
                                <div class="col">
                                    <label for="" class="form-label">No. of Requested Label<span>*</span></label>
                                    <asp:TextBox ID="txtNoofLabel" MaxLength="10" runat="server" CssClass="form-control"
                                                onchange="FindAllGrandT(this.value)" required></asp:TextBox>
                                <asp:RequiredFieldValidator ID="RequiredFdfvgieldValidator3" runat="server" ValidationGroup="reqlbl"
                                                ControlToValidate="txtNoofLabel"></asp:RequiredFieldValidator>
                                            <cc1:FilteredTextBoxExtender ID="FilteredTextBoxExtender4" TargetControlID="txtNoofLabel"
                                                runat="server" FilterMode="InvalidChars" InvalidChars="`~!@#$%^&*(){}[]_+|\=-.,/',./';<>?:abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ">
                                            </cc1:FilteredTextBoxExtender>
                                    <div class="invalid-feedback">Enter valid email.</div>
                                </div>
                                <div class="col">
                                    <label for="" class="form-label">Label Type</label>
                                    <br>
                                   <asp:Label ID="lblTypeNew1" runat="server"></asp:Label>

                                <asp:DropDownList ID="ddlLabelType" runat="server" CssClass="form-control form-control-sm"
                                    Visible="false">
                                </asp:DropDownList>
                                <asp:RequiredFieldValidator ID="RequiddvvredFieldValidator2" runat="server" InitialValue="--Select--"
                                    ForeColor="Red" ValidationGroup="reqlbl" ControlToValidate="ddlLabelType"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col">
                                    <label for="" class="form-label">Net Amount (GST)</label>
                                     (<asp:Label ID="lblGrandTotal" runat="server" />)
                                 <asp:HiddenField ID="HdLabelCodeRequest" runat="server" />
                                </div>
                                <div class="col ms-auto text-end">
                                    <asp:Button ID="btnCancel" runat="server" OnClick="btnCancel_Click" CssClass="btn btn-light border px-3"
                                    Text="Cancel" />
                                   <asp:Button ID="btnRequestSend" runat="server" OnClick="btnRequestSend_Click" CssClass="btn btn-primary px-3"
                                    Text="Send Request" ValidationGroup="reqlbl" />
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
                        </form>
                    </div>
                </div>
            </div>
        </div>


</asp:Content>

