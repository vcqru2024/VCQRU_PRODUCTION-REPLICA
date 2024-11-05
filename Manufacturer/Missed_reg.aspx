<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Missed_reg.aspx.cs" Inherits="Manufacturer_Missed_reg" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Amrutanjan Missed Call Registration</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>

    <style>
        body {
            background-image: url(../images/Amrutanjan/image/profile1.png);
            background-color: greenyellow;
            background-position: center;
            background-repeat: no-repeat;
            background-size: 100%;
        }    
        .form-box{
            box-shadow: inset 0px 6px 58px #000000;
            background-color: #ffdf24ba;
            margin-top: 30px;
            padding: 10px 65px 40px 65px;
            width: 50%;
        }
        .form-box input,select{
            margin-bottom:7px;
        }
        .form-box h4{
            padding: 30px;
            color: #333;
            font-size: 28px;
        }
        .form-box .form-control {
            border-radius: 79px;
        }
        .form-box .form-btn{
            background-color: #4cff00;
            padding: 8px 36px;
            border-radius: 4px;
            border: 1px solid #44df02;
            color: #333;
            font-size: 16px;
            font-weight: 600;
        }

        /*.col-md-6 {
            margin-left: 182px;
        }*/

        /*#fld1 {
            margin-left: 103px;
            margin-right: -163px;
        }*/

        /*#purchageimg {
            margin-left: 163px;
        }*/

        #btn {
            margin-right: -42px;
        }

        
    </style>
    <script type="text/javascript">
        function getaddress() {
            debugger;
            let pin = document.getElementById("pin").value;
            $.getJSON("https://api.postalpincode.in/pincode/" + pin, function (data) {
                createHTML(data);
            })
            function createHTML(data) {
                var add = " ";
                var msg = "";
                var namecon = "";
                debugger;
                var add = data[0].PostOffice[0]['Name'];
                var msg = data[0].PostOffice[0]['District'];
                var namecon = data[0].PostOffice[0]['State'];
                $("#txtAddress").val(add);
                $("#txtCity").val(msg);
                $("#txtState").val(namecon);
            }
        }
    </script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container form-box">
            <div class="row">
                <div class=" text-center mx-auto">
                    <h4><b>PLEASE FILL THE FORM</b></h4>
                </div>
            </div>
            <div class="row">
                <div class="col-sm-12  mx-auto">
                    <asp:DropDownList ID="ddlproduct" CssClass="form-control" runat="server">
                        <asp:ListItem disabled="disabled" Selected="selected">--Select Product--</asp:ListItem>
                        <asp:ListItem Text="New Amrutanjan Pain Balm Extra Power - 8ml" Value="1"></asp:ListItem>
                        <asp:ListItem Text="Amrutanjan New Maha Strong Pain Balm - 8ml" Value="2"></asp:ListItem>
                        <asp:ListItem Text="Amrutanjan Strong Pain Balm - 8ml" Value="3"></asp:ListItem>
                    </asp:DropDownList>
                   <%-- <asp:RequiredFieldValidator ID="rfvproduct" runat="server" ControlToValidate="ddlproduct" InitialValue="--Select Product--" Display="Dynamic" ForeColor="Red" ErrorMessage="Please Select Product*"></asp:RequiredFieldValidator>--%>
                </div>

            </div>
            <div class="row" id="fld1">

                <div class="col-sm-6">
                    
                    <asp:TextBox ID="txtPhoneNumber" ReadOnly="true" runat="server" placeholder="Enter Your Phone Number *" MaxLength="10" MinLength="10" CssClass="form-control input-form"></asp:TextBox>
                    
                   <%-- <asp:RequiredFieldValidator ID="rfvmob" runat="server" ControlToValidate="txtPhoneNumber" Display="Dynamic" ForeColor="Red" ErrorMessage="Enter Phone Number*"></asp:RequiredFieldValidator>--%>
                    </div>
                   <div class="col-sm-6">
                    
                    <asp:TextBox ID="txtParticipantName" runat="server" placeholder="Enter Your Name *" MaxLength="50" CssClass="form-control input-form"></asp:TextBox>
                     <%--<asp:RequiredFieldValidator ID="rfvpname" runat="server" ControlToValidate="txtParticipantName" Display="Dynamic" ForeColor="Red" ErrorMessage="Please Enter Name*"></asp:RequiredFieldValidator>--%>
                    </div>
                </div>
                <div class="row">
                    <div class="col-sm-6">
                            <asp:DropDownList ID="ddlgender" CssClass="form-control" runat="server">
                                <asp:ListItem disabled="disabled" Selected="selected">--Select Gender--</asp:ListItem>
                                <asp:ListItem>Male</asp:ListItem>
                                <asp:ListItem>Female</asp:ListItem>
                            </asp:DropDownList>
                          <%--<asp:RequiredFieldValidator ID="rfvgender" runat="server" ControlToValidate="ddlgender" InitialValue="--Select Gender--" Display="Dynamic" ForeColor="Red" ErrorMessage="Please Select Gender*"></asp:RequiredFieldValidator>--%>
                     </div>
                    <div class="col-sm-6">
                    <asp:TextBox ID="txtAge" runat="server" TextMode="Number" placeholder="Enter Your Age *" MaxLength="3" CssClass="form-control input-form"></asp:TextBox>
                     <%--<asp:RequiredFieldValidator ID="rfvage" runat="server" ControlToValidate="txtAge" Display="Dynamic" ForeColor="Red" ErrorMessage="Please Enter Age *"></asp:RequiredFieldValidator>--%>
                    </div>
                </div>
                  <div class="row">
                       <div class="col-sm-6">
                          <%-- <asp:TextBox ID="pin" runat="server" CssClass="form-control input-form" placeholder="Enter Pincode" maxlength="6" OnTextChanged="getaddress()"></asp:TextBox>--%>
                   <input type="text" runat="server" class="form-control input-form" id="pin" placeholder="Enter Pincode" maxlength="6" onchange="getaddress()" />
                       <%-- <asp:RequiredFieldValidator ID="rfvpin" runat="server" ControlToValidate="pin" Display="Dynamic" ForeColor="Red" ErrorMessage="Please Enter Pin Number*"></asp:RequiredFieldValidator>--%>
                    </div>
                 
                 <div class="col-sm-6">

                    <asp:TextBox ID="txtAddress"  runat="server" placeholder="Enter Your Address *" MaxLength="50" CssClass="form-control input-form"></asp:TextBox>
                    <%-- <asp:RequiredFieldValidator ID="rfvaddress" runat="server" ControlToValidate="txtAddress" Display="Dynamic" ForeColor="Red" ErrorMessage="Please Enter Address*"></asp:RequiredFieldValidator>--%>
                    </div>
                       </div>
             <div class="row">
                      <div class="col-sm-6">
                        <asp:TextBox ID="txtCity" runat="server" placeholder="Enter Your City *" MaxLength="50" CssClass="form-control input-form" ></asp:TextBox>
                        <%--<asp:RequiredFieldValidator ID="rfvcity" runat="server" ControlToValidate="txtCity" Display="Dynamic" ForeColor="Red" ErrorMessage="Please Enter City Name*"></asp:RequiredFieldValidator>--%>
                    
                    </div>
                 <div class="col-sm-6">
                    <asp:TextBox ID="txtState" runat="server" placeholder="Enter Your State *" MaxLength="50" CssClass="form-control input-form"></asp:TextBox>
                    <%--<asp:RequiredFieldValidator ID="rfvstate" runat="server" ControlToValidate="txtState" Display="Dynamic" ForeColor="Red" ErrorMessage="Please Enter State Name*"></asp:RequiredFieldValidator>--%>
                </div>
                       </div>
            <div class="row">
                    <div class="col-sm-12 mt-2" id="purchageimg">
                        <label>Upload Proof of Purchase<em></em></label>
                        <asp:FileUpload ID="FileUpload1" runat="server" CssClass="file-box" />
                        <asp:HiddenField ID="hfuploadfile" runat="server" />
                        <asp:HiddenField ID="hfproductId" runat="server" />
                    </div>
                    <div class="col-sm-12 text-center" id="btn">
                        <br />
                        <asp:Button ID="btnsave" runat="server" OnClick="btnsave_Click" CssClass="btn-primary form-btn" Text="Register" />
                        <asp:Button id="btnback" runat="server" OnClick="BtnBack_Click" Text="Back" CssClass="btn-primary form-btn" />
                    </div>
              
                </div>
           
            
            <br />
        </div>
    </form>
</body>
</html>
