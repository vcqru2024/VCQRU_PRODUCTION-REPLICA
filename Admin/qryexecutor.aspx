<%@ Page Language="C#" AutoEventWireup="true" CodeFile="qryexecutor.aspx.cs" Inherits="qryexecutor" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>SQL Query Executor</title>
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.10.2/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">
        <div class="container mt-4">
            
            <h2>SQL Query Executor</h2>
            <br />
            <asp:Label ID="lblErrorMessage" style="color:red;background-color:lawngreen;font-weight:bold;" runat="server"></asp:Label>

            <div class="form-group">
                <asp:Label ID="lblQuery" runat="server" Text="Enter SQL Query:" CssClass="form-label"></asp:Label>
                <asp:TextBox ID="txtQuery" runat="server" TextMode="MultiLine" CssClass="form-control" Rows="5" placeholder="Enter SQL Query"></asp:TextBox>
            </div>
            <asp:Button ID="btnSubmit" runat="server" Text="Submit" CssClass="btn btn-primary" OnClick="btnSubmit_Click" />
            
            <div class="mt-4">
                <asp:GridView ID="gvResults" runat="server" CssClass="table table-striped table-bordered" AutoGenerateColumns="True"></asp:GridView>
            </div>
            
            <div class="mt-4">
                <asp:Button ID="btnExport" runat="server" Text="Export to Excel" CssClass="btn btn-success" OnClick="btnExport_Click" />
            </div>
        </div>
    </form>
</body>
</html>
