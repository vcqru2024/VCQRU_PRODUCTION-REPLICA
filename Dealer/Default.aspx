<%@ Page Title="" Language="C#" MasterPageFile="~/Dealer/DealerMaster.master" AutoEventWireup="true" CodeFile="Default.aspx.cs" Inherits="Dealer_Default" %>
<%@Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <script type="text/javascript">
        $(document).ready(function() {
         
            $(".accordion2 p").eq(0).addClass("active");
            $(".accordion2 div.open").eq(0).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
</asp:Content>

