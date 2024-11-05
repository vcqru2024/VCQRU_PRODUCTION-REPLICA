<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" Title="Status"
    CodeFile="Message.aspx.cs" Inherits="Messageshow" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<script type="text/javascript">
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
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
  <%--  <div class="head_cont">
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
            <div style="width: 100%; text-align: center; color:Red; ">--%>
    <div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
            <div class="portfolio-list sort-destination" data-sort-id="portfolio">
                <div class="card card-admin form-wizard profile box_card">

                       <header class="card-header">
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Message</h4>
                            </header>
                    <div class="card-body card-body-nopadding">
                        <div>

                            <%if (Session["MyNewMessageTC"] != null)
              { %>
                <strong style="font-size:14px;"> <%=Session["MyNewMessageTC"].ToString()%> </strong>
                <%} %>
            <% else if (Session["MyNewMessage"] != null)
              { %>
                <strong style="font-size:14px;"> <%=Session["MyNewMessage"].ToString()%> </strong>
                <%} %>
                   </div>
                        </div>
                    </div>
                 </div>
             </div>
         </div>
             </div>
        </div>
           <%-- </div>--%>
</asp:Content>
