<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="CreditBalance.aspx.cs" Inherits="Admin_CreditBalance" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <style type="text/css">
        .auto-style1 {
            width: 73px;
        }

        .auto-style2 {
            margin-right: 0px;
        }

        .sidebar + .main-content {
            padding: 20px;
        }

        .app-table table {
            margin-bottom: 20px !important;
        }

        .card-header {
            padding: .75rem 1.25rem;
            margin-bottom: 0;
            border-bottom: 1px solid #a36ae1;
            color: #FFF;
            background: -webkit-linear-gradient(180deg, rgb(73 141 247) 0%, rgb(167 105 224) 100%);
            background: linear-gradient(180deg, rgb(73 141 247) 0%, rgb(167 105 224) 100%);
        }

        .box_card .card-header .card-title {
            font-size: 1.4em;
        }

        .previous {
            background: -webkit-linear-gradient(180deg, rgb(73 141 247) 0%, rgb(167 105 224) 100%);
            background: linear-gradient(180deg, rgb(73 141 247) 0%, rgb(167 105 224) 100%);
            color: #FFF;
        }

        .next {
            background-color: #04AA6D;
            color: white;
        }

        .round {
            border-radius: 50%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     
    <!-- Add the table for Register form -->
    <div class="app-table">
        <header class="card-header">
            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Credit cash wallet balance</h4>

        </header>
          <br />
        <table class="table table-bordered">
            <tr>
                <th>
                    <asp:Label ID="lblcompid" runat="server" Text="Company"></asp:Label>
                </th>
                <td>
                    <asp:DropDownList ID="ddlcompid" OnSelectedIndexChanged="ddlcompid_SelectedIndexChanged" AutoPostBack="true" runat="server"> </asp:DropDownList>
                </td>
                <th>
                    <asp:Label ID="lblbalance1" runat="server" Text="Wallet Balace"></asp:Label>
                </th>
                <td>
                    <asp:Label ID="lblbalance" runat="server" Text="₹ 0.00"></asp:Label>
                </td>
                <th>
                    <asp:Label ID="Label1" runat="server" Text="Credit Balace"></asp:Label>
                </th>
                <td>
                    <asp:TextBox ID="txtamount" TextMode="Number" MaxLength="7" runat="server" Text="0.00"></asp:TextBox>
                </td>

               
                <td>
                    <asp:Button class="btn btn-primary" ID="btncredit" runat="server" type="submit" Text="Credit" OnClick="btncredit_Click"/>
                   <br />  <asp:Label ID="lblmsz" runat="server"></asp:Label>
                </td>
            </tr>
           
        </table>
    </div>
     <div>

    
      

      <header class="card-header">
          <p style="text-align:center;"> <h4 class="card-title">Credit balance History</h4></p> 

        </header>
        <asp:GridView ID="grdwallethistory" runat="server" AutoGenerateColumns="False" class="table table-bordered table-striped align-middle">
            <Columns>
              
                <asp:BoundField DataField="Comp_Name" ReadOnly="true" HeaderText="Vendor Name" />
                <asp:BoundField DataField="OldBal" ReadOnly="true" HeaderText="Old Balance" />
                <asp:BoundField DataField="Amount" ReadOnly="true" HeaderText="Credited Amount" />
                <asp:BoundField DataField="NewBal" ReadOnly="true" HeaderText="New Balalance" />
                <asp:BoundField DataField="Cr_Dr_Type" ReadOnly="true" HeaderText="Cr./Dr. Type" />
                <asp:BoundField DataField="ReqDate" ReadOnly="true" HeaderText="Date & Time" />
                
              
            </Columns>
        </asp:GridView>

    </div>
  
</asp:Content>

