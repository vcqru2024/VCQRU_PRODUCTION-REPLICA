<%@ Page Language="C#" MasterPageFile="~/Demo/MasterPage.master" AutoEventWireup="true" Title="Status"
    CodeFile="Message.aspx.cs" Inherits="Messageshow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<%--<script type="text/javascript">
    $(document).ready(function() {

        $(".accordion2 p").eq(-1).addClass("active");
        $(".accordion2 div.open").eq(-1).show();

        $(".accordion2 p").click(function() {
            $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
            $(this).toggleClass("active");
            $(this).siblings("p").removeClass("active");
        });

    });
    </script>--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="head_cont">
                <h2 class="msg_info">
                    <table width="99%">
                        <tr>
                            <td width="85%">
                                &nbsp;&nbsp;&nbsp;Message
                            </td>
                            <td align="right">
                                
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <div style="width: 100%; text-align: center; color:Red; ">
            <%if (Session["MyNewMessage"] != null)
              { %>
                <strong> <%=Session["MyNewMessage"].ToString()%> </strong>
                <%} %>
            </div>
</asp:Content>
