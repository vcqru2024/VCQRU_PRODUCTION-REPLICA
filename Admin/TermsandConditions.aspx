<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="TermsandConditions.aspx.cs" Inherits="Admin_TermsandConditions" %>

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
    
     <div>

        <header class="card-header">
           <h4 class="card-title" style="text-align:center;">Accepted History</h4>
        </header>

          <br />
        <table class="table table-bordered">
            <tr>
                <th>
                    <asp:Label ID="lblcompid" runat="server" Text="Select Company"></asp:Label>
                </th>
                <td>
                    <asp:DropDownList ID="ddlcompid" runat="server"> </asp:DropDownList>
                </td>
                <td>
                    <asp:Button class="btn btn-primary" ID="btnsearch" runat="server" type="submit" Text="Search" OnClick="btnsearch_Click"/>
                   <br />  <asp:Label ID="lblmsz" runat="server"></asp:Label>
                </td>
            </tr>
           
        </table>

        <!-- An Gridview to store and show item in the table form -->
        <asp:GridView ID="grdwallethistory" runat="server" AutoGenerateColumns="False" class="table table-bordered table-striped align-middle">
            <Columns>
              
                <asp:BoundField DataField="Comp_ID" ReadOnly="true" HeaderText="Comp ID" />
                <asp:BoundField DataField="Comp_Name" ReadOnly="true" HeaderText="Comp Name" />
                <asp:BoundField DataField="IsAccept" ReadOnly="true" HeaderText="Acceptance Status" />
                <asp:BoundField DataField="IPAddress" ReadOnly="true" HeaderText="IP Address" />
                <asp:BoundField DataField="Browser" ReadOnly="true" HeaderText="Browser" />
                 <asp:BoundField DataField="DeviceDetails" ReadOnly="true" HeaderText="Device Details" />
                 <asp:BoundField DataField="MacID" ReadOnly="true" HeaderText="Mac ID" />
                <asp:BoundField DataField="SkipCount" ReadOnly="true" HeaderText="Skip Count" />
                <asp:BoundField DataField="ReqDate" ReadOnly="true" HeaderText="Date & Time" />
                
              
            </Columns>
        </asp:GridView>

    </div>
</asp:Content>

