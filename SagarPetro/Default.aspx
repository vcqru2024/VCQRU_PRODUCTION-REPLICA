<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Patanjali_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <style>
        .custom-grid {
            border-collapse: collapse;
            width: 100%;
        }

            .custom-grid th, .custom-grid td {
                padding: 8px;
                border: 1px solid #ddd;
            }

            .custom-grid th {
                background-color: #4CAF50;
                color: white;
            }

            .custom-grid tr:nth-child(even) {
                background-color: #f2f2f2;
            }

            .custom-grid tr:hover {
                background-color: #ddd;
            }
    </style>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    This is test file 
</asp:Content>

