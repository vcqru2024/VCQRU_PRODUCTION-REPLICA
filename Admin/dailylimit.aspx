<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="dailylimit.aspx.cs" Inherits="Admin_dailylimit" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 20px;
        }

        .container {
            max-width: 600px;
            margin: auto;
        }

        h1, h2 {
            text-align: center;
        }

        label {
            margin: 10px 0 5px;
        }

        input {
            padding: 10px;
            margin-bottom: 15px;
            width: 100%;
        }

        .button {
            padding: 10px;
            background-color: #4CAF50;
            color: white;
            border: none;
            cursor: pointer;
            width: 100%;
        }

            .button:hover {
                background-color: #45a049;
            }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #dddddd;
            text-align: left;
            padding: 8px;
        }

        th {
            background-color: #f2f2f2;
        }

        .error {
            color: red;
            margin-top: 10px;
            text-align: center;
        }
    </style>
    <script type="text/javascript">
        window.onload = function () {
            document.getElementById('<%= btnSetLimit.ClientID %>').onclick = function () {
                const compId = document.getElementById('<%= ddlCompId.ClientID %>').value;
                const limit = document.getElementById('<%= txtLimit.ClientID %>').value;

                // Reset error message
                document.getElementById('lblError').innerText = '';

                if (!compId || !limit) {
                    document.getElementById('lblError').innerText = 'Please fill in all fields.';
                    return false;
                }
            };
        };
    </script>

    <div class="container">
        <h1>Set IMPS Daily Limit</h1>

        <asp:Panel ID="pnlLimitForm" runat="server">
            <asp:Label ID="lblCompId" runat="server" Text="Company ID:" AssociatedControlID="ddlCompId"></asp:Label>
            <asp:DropDownList ID="ddlCompId" runat="server" aria-label="Company ID" CssClass="form-control"></asp:DropDownList>


            <asp:Label ID="lblLimit" runat="server" Text="Daily Limit:" AssociatedControlID="txtLimit"></asp:Label>
            <asp:TextBox ID="txtLimit" runat="server" TextMode="Number" Required="true" aria-label="Daily Limit"></asp:TextBox>

            <asp:Label ID="lblError" runat="server" CssClass="error" Visible="false"></asp:Label>
            <asp:Button ID="btnSetLimit" runat="server" Text="Set Limit" OnClick="btnSetLimit_Click" CssClass="button" />
             <asp:Button ID="btnUpdateLimit" runat="server" Text="Update Limit" OnClick="btnUpdateLimit_Click" CssClass="button" />
        </asp:Panel>

        <h2>Current Company Limits</h2>
        <asp:GridView ID="gvLimits" runat="server" AllowPaging="true" AutoGenerateColumns="False">
            <Columns>
                <asp:BoundField DataField="Comp_Name" HeaderText="Company Name" />
                <asp:BoundField DataField="Limit" HeaderText="Daily Limit" />
                <asp:BoundField DataField="Entry_date" HeaderText="Entry Date" DataFormatString="{0:yyyy-MM-dd HH:mm:ss}" />
            </Columns>
        </asp:GridView>
    </div>
</asp:Content>

