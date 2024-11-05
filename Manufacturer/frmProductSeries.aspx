<%@ Page Title="Products Series Details" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="frmProductSeries.aspx.cs" Inherits="frmProductSeries" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
<script type="text/javascript">
    $(document).ready(function () {

        $(".accordion2 p").eq(7).addClass("active");
        $(".accordion2 div.open").eq(4).show();

        $(".accordion2 p").click(function () {
            $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
            $(this).toggleClass("active");
            $(this).siblings("p").removeClass("active");
        });

    });
</script>

<script language="javascript" type="text/javascript">
    function postbackFromJS(sender, e) {
        var postBack = new Sys.WebForms.PostBackAction();
        postBack.set_target(sender);
        postBack.set_eventArgument(e);
        postBack.performAction();
    }
    function divexpandcollapse(divname) {
        var div = document.getElementById(divname);
        var img = document.getElementById('img' + divname);
        if (div.style.display == "none") {
            div.style.display = "inline";
            img.src = "Images/minus.gif";
        } else {
            div.style.display = "none";
            img.src = "Images/plus.gif";
        }
    }
 </script> 
 <script type="text/javascript" src="../Content/Scripts/jquery-latest.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
<%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>            
            <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
                        top: 0px;" class="NewmodalBackground">                        
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>

     <div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
                        <div class="card card-admin form-wizard profile box_card">
                            <header class="card-header">
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Product Series Detail For Pasted Labels</h4>
                            </header>


                              <div class="card-body card-body-nopadding">

                                  <div class="form-row">
                                      
                                       <div class="col-lg-3">
                                           
                                           <div class="form-inline">
                                               <div class="form-group mb-4">
                                          <label for="staticEmail2" class="sr-only sr-custom">Select Product</label>
                                          <asp:DropDownList ID="ddlProduct" class="form-control form-control-lg" OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged"
                                              AutoPostBack="true" runat="server">
                                          </asp:DropDownList>
                                      </div>
                                               </div>
                                      </div>

                            </div>
                            <div class="card-admin form-wizard medias">
                              <div class="row pb-2 pt-2 background-section-form">
                                    <div class="col-lg-8">
                                        <h4 class="mb-0">Record's Found :<span> <asp:Label ID="lblcount" runat="server"></asp:Label></span></h4>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="lblToatalCashPoints" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label
                                            ID="lblToatalPoints" runat="server"></asp:Label>
                                    </div>
                                    <div class="col-lg-2">
                                       <%-- <asp:DropDownList ID="ddlRowProductCnt" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRowsShow_SelectedIndexChanged">
                                            <asp:ListItem Value="25">25 Rows</asp:ListItem>
                                            <asp:ListItem Value="50">50 Rows</asp:ListItem>
                                            <asp:ListItem Value="100">100 Rows</asp:ListItem>
                                            <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                            <asp:ListItem Value="1000">1000 Rows</asp:ListItem>
                                            <asp:ListItem Value="1001">All Rows</asp:ListItem>
                                        </asp:DropDownList>--%>
                                    </div>
                                </div>
                                <div class="table-responsive table_large">
                              <asp:GridView ID="GrdPrintLabel" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered Frm_Scrap"
                    EmptyDataText="Record Not Found" 
                   BorderColor="transparent" OnPageIndexChanging="GrdPrintLabel_PageIndexChanging"
                    AllowPaging="True" PageSize="10">
                    <Columns>
                        <asp:TemplateField HeaderText="Batch No.">
                            <ItemTemplate>
                                <asp:Label ID="lblcode1" runat="server" Text='<%# Bind("Batch_No") %>'></asp:Label>
                                 <asp:Label ID="lblCompId" runat="server" Text='<%# Bind("Row_ID") %>' Visible="false"></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Code Sequence">
                            <ItemTemplate>
                                <asp:Label ID="lblsername" runat="server" Text='<%# Bind("Series_Limit") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="30%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Scrap Labels">
                            <ItemTemplate>
                                <asp:Label ID="lblcrapsername" runat="server" Text='<%# Bind("ScrapLabel") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="60%" />
                        </asp:TemplateField>
                    </Columns>
                                  <EmptyDataTemplate  >
                                      Record Not Found
                                  </EmptyDataTemplate>
                   <%-- <PagerStyle HorizontalAlign="Center" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />--%>
                </asp:GridView>
                              </div>
                                </div>
                           </div>

                          
                        </div>
                    </div>
         </div>
             </div>
            <%--<div class="head_cont">
                <h2 class="send_feedback">
                    <table width="99%">
                        <tr>
                            <td width="85%">
                                Product Series Detail For Pasted Labels
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>--%>
            
            <div class="grid_container">
               <%-- <h4>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <img src="../Content/images/regis_pro.png" alt="products" />
                            </td>
                            <td class="bord_right">
                                Record(s) found <span class="small_font">(<asp:Label ID="lblcount" runat="server"></asp:Label>)</span>
                            </td>
                            <td align="right">
                            </td>
                        </tr>
                    </table>
                </h4>--%>
                
            </div>
       <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>



</asp:Content>

