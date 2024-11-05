<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true"
    Title="Courier Dispatch" CodeFile="FrmAwardCourierDispatch.aspx.cs" Inherits="FrmAwardCourierDispatch" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(15).addClass("active");
            $(".accordion2 div.open").eq(11).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <style type="text/css">
        .myrd input
        {
            position: relative;
            padding: 5px;
            margin-left: 5px;
            margin-top: 9px;
        }
        .myrd label
        {
            position: relative;
            padding: 5px;
            font-weight: bold;
        }
        .pad
        {
            text-align: left;
            padding: 0px 4px 0 4px;
        }
    </style>

    <script language="javascript" type="text/javascript">
        function divexpandcollapse(divname) {
            var div = document.getElementById(divname);
            var img = document.getElementById('img' + divname);
            if (div.style.display == "none") {
                div.style.display = "inline";
                img.src = "../Content/images/minus.gif";
            } else {
                div.style.display = "none";
                img.src = "../Content/images/plus.gif";
            }
        }
        function CheckTrackingNo(mm) {
            PageMethods.MethodChkTrackingNo(mm, onengcheck)
        }
        function onengcheck(Result) {
            if (Result == true) {
                document.getElementById("<%=lbltrackduplicate.ClientID %>").innerHTML = "Tracking No Already Exist.";
                document.getElementById("<%=btnCourierSubmit.ClientID %>").disabled = true;
                document.getElementById("<%=btnCourierSubmit.ClientID %>").className = "button_all_Sec";

            }
            else {
                document.getElementById("<%=lbltrackduplicate.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnCourierSubmit.ClientID %>").disabled = false;
                document.getElementById("<%=btnCourierSubmit.ClientID %>").className = "button_all";
            }
        }              
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
            <asp:UpdateProgress ID="UpdateProgress1"  runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 1507px; width: 100%;
                        z-index: 100001; top: 0px;" class="NewmodalBackground">
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
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Dispatch Award/Gift</h4>
                            </header>
                 
                <div class="card-body card-body-nopadding">
                    <div id="newMsg" runat="server">
                <p>
                    <asp:Label ID="lblmsgHeader" runat="server"></asp:Label>
                </p>
            </div>
                    <div class="form-row">
                       <div class="form-group col-lg-2">
                                <asp:Button ID="imgNew" Text="Add New Courier Dispatch" OnClick="imgNew_Click1" CssClass="btn btn-primary btn-block mb-0"
                                    runat="server" CausesValidation="false" />
                         </div>
                    </div>
                     <div class="form-row">
                         <span>*</span><label>Mandatory to select</label>
                     </div>
                    <div class="form-row">
                        <div class="form-group col-lg-3">
                             <asp:DropDownList ID="ddlcompname" runat="server" CssClass="reg_txt" AutoPostBack="false"
                                        OnSelectedIndexChanged="ddlcompname_SelectedIndexChanged" Visible="false" />
                          <asp:DropDownList runat="server" CssClass="form-control form-control-sm" ID="ddlService" AutoPostBack="True" OnSelectedIndexChanged="ddlService_SelectedIndexChanged">
                                    <asp:ListItem Selected="True" Value="">Select Service</asp:ListItem>
                                    <asp:ListItem Value="SRV1001">Build Loyalty</asp:ListItem>
                                    <asp:ListItem Value="SRV1006">Raffle Scheme</asp:ListItem>
                                    <asp:ListItem Value="SRV1020">Referral</asp:ListItem>                                  
                                </asp:DropDownList>
                                 <asp:RequiredFieldValidator  ControlToValidate="ddlService" runat="server"  ValidationGroup="servss" ForeColor="Red"
                                                     InitialValue=""/>
                        </div>
                          <div class="form-group col-lg-3">
                               <asp:DropDownList ID="ddlproname" runat="server" CssClass="form-control form-control-sm" AutoPostBack="true"
                                         OnSelectedIndexChanged="ddlproname_SelectedIndexChanged" />
                          </div>
                        <div class="form-group col-lg-2">
                            <asp:DropDownList ID="ddlAward" runat="server" CssClass="form-control form-control-sm" AutoPostBack="false"/>
                        </div>
                        <div class="form-group col-lg-2">
                            <asp:DropDownList ID="ddlDeliveryBy" runat="server" CssClass="form-control form-control-sm" AutoPostBack="false"
                                OnSelectedIndexChanged="ddlDeliveryBy_SelectedIndexChanged">
                                <asp:ListItem Value="">Select DeliveryBy</asp:ListItem>
                                <asp:ListItem Value="courier">Courier</asp:ListItem>
                                <asp:ListItem Value="dealer">Dealer</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                        <div class="form-group col-lg-2">
                            <asp:ImageButton ID="BtnSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png"
                                OnClick="BtnSearch_Click" ToolTip="Search" ValidationGroup="servss" />
                            <asp:ImageButton ID="BtnRefesh" runat="server" class="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" OnClick="BtnRefesh_Click"
                                ToolTip="Refresh" />
                        </div>
                        </div>
                   
                    
                    


                    <div class="card-admin form-wizard medias">
                     <div class="row pb-2 pt-2 background-section-form">
												<div class="col-lg-8">
													<h4 class="mb-0">Record's Found : <span> <asp:Label ID="lblcount" runat="server"></asp:Label></span></h4>
												</div>
                                                <div class="col-lg-2">
                                                     <asp:Label ID="lblToatalCashPoints" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label
                                    ID="lblToatalPoints" runat="server"></asp:Label>
                                                </div>
												<div class="col-lg-2">

													<%--<select class="form-control mb-0">
														<option>25 Rows</option>
														<option>20 Rows</option>
														<option>15 Rows</option>
													</select>--%>
                                                     <asp:DropDownList ID="ddlRowProductCnt" runat="server" AutoPostBack="true"
                                                         Visible="false" >
                                        <asp:ListItem Value="25">25 Rows</asp:ListItem>
                                        <asp:ListItem Value="50">50 Rows</asp:ListItem>
                                        <asp:ListItem Value="100">100 Rows</asp:ListItem>
                                        <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                        <asp:ListItem Value="1000">1000 Rows</asp:ListItem>
                                        <asp:ListItem Value="1001">All Rows</asp:ListItem>
                                    </asp:DropDownList>
												</div>
											</div>
                        <div class="table-responsive table_large">
                     <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                         CssClass="table table-striped table-bordered" EmptyDataText="Record Not Found"  DataKeyNames="Dealer_Name,Courier_Name,GiftName,AwardName"
                      BorderColor="transparent">
                        <Columns>                            
                            <asp:TemplateField ItemStyle-Width="20px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                HeaderStyle-CssClass="tr_haed" ItemStyle-CssClass="pad">
                                <ItemTemplate>
                                    <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                                <ItemStyle Width="1%" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Dealer Name">
                                <ItemTemplate>
                                   <asp:Label ID="lblCorierName" runat="server" Text='<%# Bind("DealerCourierNAme") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify"  Width="23%" />
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Tracking No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblContact" runat="server" Text='<%# Bind("TrackingNo") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify"  Width="12%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Awards/Gift Name">
                                <ItemTemplate>
                                     
                                 <asp:Label ID="Label2" runat="server" Text='<%# Bind("GiftAwardName") %>'></asp:Label>
                                 
                                   
                                    <asp:Label ID="lblCDispIDs" Visible="false" runat="server" Text='<%# Bind("Gift_Pkid") %>'></asp:Label>
                                     <asp:Label ID="M_LoyaltyAwards_RowId" Visible="false" runat="server" Text='<%# Bind("RowId") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify"  Width="20%" />
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Product">
                                <ItemTemplate>
                                    <asp:Label ID="lblContactdel" runat="server" Text='<%# Bind("Code1") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify"  Width="12%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblContactdel" runat="server" Text='<%# Bind("ConsumerName") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify"  Width="12%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Email">
                                <ItemTemplate>
                                    <asp:Label ID="lblContactdel" runat="server" Text='<%# Bind("Email1") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                            </asp:TemplateField>
                           
                           
                            <asp:TemplateField HeaderText="Delivery Status">
                                <ItemTemplate>
                                    <asp:Label ID="lblAddressLocation" runat="server" Text='<%# Bind("Status1") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify" Width="12%" />
                            </asp:TemplateField>
                                                        
                        </Columns>
                        <EmptyDataRowStyle HorizontalAlign="Center" />
                       <%-- <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
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
        </div>
            <asp:Panel ID="DemoPanel" runat="server">
                <div class="grid_container">
                   <%-- <h4>
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="6%" align="center">
                                    <img src="../Content/images/regis_pro.png" alt="products" />
                                </td>
                                <td class="bord_right">
                                    <asp:Label ID="lblGridHeaderText" runat="server" Text="Record(s) found"></asp:Label>
                                    <span class="small_font">(<asp:Label ID="" runat="server"></asp:Label>)</span>
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbltotal" CssClass="small_font" runat="server"></asp:Label>
                                </td>
                                <td align="right" style="padding-right: 20px; display: none;">
                                    <asp:Label ID="lblrecpayment" Style="font-family: Verdana; font-size: 12px; color: Black;"
                                        Text="Payment Received: " CssClass="small_font" runat="server"></asp:Label>
                                    &nbsp;
                                    <asp:Label ID="lbltotalpay" Style="font-family: Verdana; font-size: 12px; color: Red;"
                                        CssClass="small_font" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </h4>--%>
                    <asp:GridView ID="GrdCourierDispatch" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="Dispatch_Location,Received_Flag" CssClass="grid" EmptyDataText="Record Not Found"
                        EmptyDataRowStyle-HorizontalAlign="Center" EnableModelValidation="True" Width="100%"
                        BorderStyle="None" BorderWidth="0" BorderColor="transparent" AllowPaging="True"
                        PageSize="15" OnPageIndexChanging="GrdCourierDispatch_PageIndexChanging" OnRowCommand="GrdCourierDispatch_RowCommand">
                        <Columns>
                            <asp:TemplateField ItemStyle-Width="20px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                HeaderStyle-CssClass="tr_haed" ItemStyle-CssClass="pad">
                                <ItemTemplate>
                                   <%-- <a href="JavaScript:divexpandcollapse('div<%# Eval("RowId") %>');">
                                        <img id="imgdiv<%# Eval("RowId") %>" width="9px" border="0" src="../Content/images/plus.gif"
                                            alt="" title="View Products" />--%>
                                  <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                                <ItemStyle Width="1%" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <%--<asp:TemplateField ItemStyle-Width="20px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                HeaderStyle-CssClass="tr_haed" ItemStyle-CssClass="pad">
                                <ItemTemplate>
                                    <%=++sno%>
                                </ItemTemplate>
                                <ItemStyle Width="1%" HorizontalAlign="Center" />
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Courier Company">
                                <ItemTemplate>
                                    <asp:Label ID="lblCourierName" runat="server" Text='<%# Bind("Courier_Name") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="23%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Awards Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblCourierEmail" runat="server" Text='<%# Bind("AwardName") %>'></asp:Label>
                                    <asp:Label ID="lblCDispID" Visible="false" runat="server" Text='<%# Bind("RowId") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="20%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Tracking No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblContact" runat="server" Text='<%# Bind("Tracking_No") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Dispatch Date">
                                <ItemTemplate>
                                    <asp:Label ID="lbldispdt" runat="server" Text='<%# Bind("Dispatch_Date","{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Expected Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblexpdt" runat="server" Text='<%# Bind("Expected_Date","{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Received Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblrecevdt" runat="server" Text='<%# Bind("Received_Date","{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Delivery By">
                                <ItemTemplate>
                                    <asp:Label ID="lblAddressLocation" runat="server" Text='<%# Bind("Delivery_Type") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <%
                                        string mm = "";
                                        try
                                        {
                                            dis = GrdCourierDispatch.DataKeys[index].Values["Dispatch_Location"].ToString(); mm = dis;
                                            IDisp = Convert.ToInt32(GrdCourierDispatch.DataKeys[index].Values["Received_Flag"].ToString());
                                        }
                                        catch { }                                    
                                    %>
                                    <%if (IDisp == 0)
                                      { %>
                                    <asp:ImageButton ID="ImgbtnEditCourier" runat="server" ImageUrl="~/Content/images/edit.png"
                                        CommandName="CourierEdit" CommandArgument='<%# Bind("RowId") %>' ToolTip="Edit Courier Dispatch info"
                                        CausesValidation="false" />&nbsp;
                                    <asp:ImageButton ID="ImgbtnDeleteCourier" runat="server" ImageUrl="~/Content/images/delete.png"
                                        CommandName="CourierDelete" CommandArgument='<%# Bind("RowId") %>' ToolTip="Delete Courier Dispatch info"
                                        CausesValidation="false" />
                                    &nbsp;
                                    <asp:ImageButton ID="ImgReceiveCourier" runat="server" ImageUrl="~/Content/images/tick-circle.png"
                                        CommandName="ReceiveCourier" CommandArgument='<%# Bind("RowId") %>' Height="13px"
                                        Width="13px" ToolTip="Receive Courier" CausesValidation="false" />
                                    <%}
                                      else if (IDisp == 1)
                                      { %>
                                    <asp:Label ID="lbldispstatus" runat="server" Text="Delivered" ForeColor="Green"></asp:Label>
                                    <%}
                                      else
                                      {%>
                                    <asp:Label ID="lbldispstatuscance" runat="server" Text="Cancel" ForeColor="Red"></asp:Label>
                                    <%} %>
                                    <%index++; %>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="9%" />
                            </asp:TemplateField>
                            <asp:TemplateField>
                                <ItemTemplate>
                                    <tr>
                                        <td colspan="90%" style="background-color: White">
                                            <div id="div<%# Eval("RowId") %>" style="display: none; position: relative; overflow: auto;
                                                width: 98%">
                                                <fieldset class="Newfield Newfield_width2">
                                                    <legend>Awards Dispatch Location information</legend>
                                                    <div style="padding-left: 5px; width: 98.5%;">
                                                        <asp:GridView ID="GrdLablelDet" runat="server" AutoGenerateColumns="False" CssClass="grid"
                                                            EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center" EnableModelValidation="True"
                                                            Width="100%" BorderStyle="None" BorderWidth="0" BorderColor="transparent">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="Dispatch Location">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblAddresscLocation" runat="server" Text='<%# Bind("Dispatch_Location") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Left" />
                                                                    <ItemStyle HorizontalAlign="Left" CssClass="grd_pad" Width="150px" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            <EmptyDataRowStyle HorizontalAlign="Center" />
                                                            <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                            <RowStyle CssClass="tr_line1" />
                                                            <AlternatingRowStyle CssClass="tr_line2" />
                                                        </asp:GridView>
                                                    </div>
                                                </fieldset>
                                            </div>
                                        </td>
                                    </tr>
                                </ItemTemplate>
                            </asp:TemplateField>
                        </Columns>
                        <EmptyDataRowStyle HorizontalAlign="Center" />
                        <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                        <RowStyle CssClass="tr_line1" />
                        <AlternatingRowStyle CssClass="tr_line2" />
                    </asp:GridView>
                    <asp:GridView ID="GrdVwDealer" runat="server" AutoGenerateColumns="False"
                        DataKeyNames="IsDispatch,IsDelivered" CssClass="grid" EmptyDataText="Record Not Found"
                        EmptyDataRowStyle-HorizontalAlign="Center" EnableModelValidation="True" Width="100%"
                        BorderStyle="None" BorderWidth="0" BorderColor="transparent" AllowPaging="True"
                        PageSize="15" OnPageIndexChanging="GrdVwDealer_PageIndexChanging" OnRowCommand="GrdVwDealer_RowCommand">
                        <Columns>                            
                            <asp:TemplateField ItemStyle-Width="20px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                HeaderStyle-CssClass="tr_haed" ItemStyle-CssClass="pad">
                                <ItemTemplate>
                                    <%=++sno%>
                                </ItemTemplate>
                                <ItemStyle Width="1%" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Dealer Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblCourierName" runat="server" Text='<%# Bind("Dealer_Name") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="13%" />
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Tracking No">
                                <ItemTemplate>
                                    <asp:Label ID="lblCourierName" runat="server" Text='<%# Bind("TrackingNo") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Awards Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblAwardNames" runat="server" Text='<%# Bind("AwardName") %>'></asp:Label>
                                    <asp:Label ID="lblCDispIDs" Visible="false" runat="server" Text='<%# Bind("RowId") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="20%" />
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Tracking No.">
                                <ItemTemplate>
                                    <asp:Label ID="lblContactdel" runat="server" Text='<%# Bind("Tracking_No") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Redeem Date">
                                <ItemTemplate>
                                    <asp:Label ID="lbldispdtdel" runat="server" Text='<%# Bind("Entry_date","{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Expected Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblexpdt" runat="server" Text='<%# Bind("Expected_Date","{0:dd-MMM-yyyy}") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Received Date">
                                <ItemTemplate>
                                <%                                        
                                        try
                                        {
                                            isdel = Convert.ToInt32(GrdVwDealer.DataKeys[index1].Values["IsDelivered"].ToString());
                                        }
                                        catch { }
                                        if (isdel == 1)
                                        {%>
                                    <asp:Label ID="lblrecevdtdel" runat="server" Text='<%# Bind("Received_Date","{0:dd-MMM-yyyy}") %>'></asp:Label>
                                    <%}
                                        else
                                        { %>
                                        <span>-- --</span>
                                    <%} %>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Delivery By">
                                <ItemTemplate>
                                    <asp:Label ID="lblAddressLocation" runat="server" Text='<%# Bind("Delivery_Type") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                            </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <%                                        
                                        try
                                        {
                                            isdis = Convert.ToInt32(GrdVwDealer.DataKeys[index1].Values["IsDispatch"].ToString());
                                            isdel = Convert.ToInt32(GrdVwDealer.DataKeys[index1].Values["IsDelivered"].ToString());
                                        }
                                        catch { }                                    
                                    %>
                                    <%if (isdel == 0)
                                      { %>
                                    <%--<asp:ImageButton ID="ImgbtnEditCourier" runat="server" ImageUrl="~/images/edit.png"
                                        CommandName="CourierEdit" CommandArgument='<%# Bind("RowId") %>' ToolTip="Edit Courier Dispatch info"
                                        CausesValidation="false" />&nbsp;
                                    <asp:ImageButton ID="ImgbtnDeleteCourier" runat="server" ImageUrl="~/images/delete.png"
                                        CommandName="CourierDelete" CommandArgument='<%# Bind("RowId") %>' ToolTip="Delete Courier Dispatch info"
                                        CausesValidation="false" />
                                    &nbsp;--%>
                                    <asp:ImageButton ID="ImgReceiveDealer" runat="server" ImageUrl="~/Content/images/tick-circle.png"
                                        CommandName="ReceiveDealer" CommandArgument='<%# Bind("RowId") %>' Height="13px"
                                        Width="13px" ToolTip="Receive Dealer" CausesValidation="false" />
                                    <%}
                                      else if (isdel == 1)
                                      { %>
                                    <asp:Label ID="lbldispstatusde" runat="server" Text="Delivered" ForeColor="Green"></asp:Label>
                                    <%}
                                      else
                                      {%>
                                    <asp:Label ID="lbldispstatuscancedel" runat="server" Text="Cancel" ForeColor="Red"></asp:Label>
                                    <%} %>
                                    <%index1++; %>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="9%" />
                            </asp:TemplateField>                            
                        </Columns>
                        <EmptyDataRowStyle HorizontalAlign="Center" />
                        <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                        <RowStyle CssClass="tr_line1" />
                        <AlternatingRowStyle CssClass="tr_line2" />
                    </asp:GridView>
                    
                    <asp:Label ID="lblCourierId" runat="server" Text="" Visible="false"></asp:Label>
                </div>
            </asp:Panel>
            <asp:Panel ID="PanelNewCourier" runat="server" Width="40%" Style="display: none;">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="ButtonNewCourier" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                        <!--<fieldset class="service_field" >-->
                        <div class="service_head_p">
                            <p>
                                <span class="left"><strong>
                                    <asp:Label ID="lblAddCourierHeader" runat="server" Text=""></asp:Label></strong>
                                </span><span class="right"><span class="astrics"><strong>*</strong></span> <em>indicates
                                    mandatory fields</em></span></p>
                        </div>
                        <asp:Panel ID="Panel1" runat="server">
                            <div class="regis_popup">
                                <div id="Div1" runat="server" style="width: 86% !important;">
                                    <p>
                                        <asp:Label ID="Label1" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <div id="DivNewMsg" runat="server" style="width: 86% !important;">
                                    <p>
                                        <asp:Label ID="lblpopmsg" runat="server"></asp:Label>
                                    </p>
                                </div>
                                  <fieldset id="Fieldset1" runat="server" class="Newfield Newfield_width2">
                                    <legend>Search</legend>
                                    <table width="50%" cellpadding="0" cellspacing="2" class="tab_regis">
                                         <tr>
                                            <td align="center">
                                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ForeColor="Red"
                                                    ErrorMessage="*" ValidationGroup="PR1" ControlToValidate="ddlAwards" InitialValue="--Select--">
                                                </asp:RequiredFieldValidator>--%>
                                                <strong><span class="astrics"></span>Awards/Gift Name</strong>
                                            </td>
                                            <td align="left">
                                                <asp:DropDownList ID="ddlAwards" runat="server" CssClass="drp" OnSelectedIndexChanged="ddlAwards_SelectedIndexChanged"
                                                    AutoPostBack="true">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                    </table>
                                      </fieldset>
                                <fieldset id="Fieldset2" runat="server" class="Newfield Newfield_width2">
                                    <legend>Dispatch Info</legend>
                                    <table width="100%" cellpadding="0" cellspacing="2" class="tab_regis">
                                        <tr> <td align="right">Select &nbsp;&nbsp;</td>
                                            <td>
                                                <asp:RadioButton Text="Courier" runat="server" ID="rdbtnCourier" onchange="showtbl();"  GroupName="kk"/>
                                                <asp:RadioButton Text="Dealer" runat="server"  ID="rdbtnDealer" GroupName="kk" onchange="showtbl();" />
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="100%" cellpadding="0" cellspacing="2" class="tab_regis" id="tbldealer">
                                        <tr> <td align="right">Select &nbsp;&nbsp;</td>
                                            <td>
                                                <asp:RadioButton Text="Courier" runat="server"  GroupName="kk"/>
                                                <asp:RadioButton Text="Dealer" runat="server"  GroupName="kk"/>
                                            </td>
                                        </tr>
                                    </table>
                                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis" id="tblCourier">
                                        <%--<tr>
                                            <td align="right" width="35%">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="DDLCompany" InitialValue="--Select--">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Company :</strong>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="DDLCompany" runat="server" CssClass="drp" AutoPostBack="true"
                                                    OnSelectedIndexChanged="DDLCompany_SelectedIndexChanged">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>--%>
                                      <%--  <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ForeColor="Red"
                                                    ErrorMessage="*" ValidationGroup="PR1" ControlToValidate="ddlAwards" InitialValue="--Select--">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Awards/Gift Name</strong>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="ddlAwards" runat="server" CssClass="drp" OnSelectedIndexChanged="ddlAwards_SelectedIndexChanged"
                                                    AutoPostBack="true">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>--%>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="DDLCourierCompany" InitialValue="--Select--">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Courier Company :</strong>
                                            </td>
                                            <td>
                                                <asp:DropDownList ID="DDLCourierCompany" runat="server" CssClass="drp">
                                                </asp:DropDownList>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="txtTrackingNo">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Tracking No. :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtTrackingNo" onchange="javascript:CheckTrackingNo(this.value)" runat="server" CssClass="textbox_pop" 
                                                    Text="" MaxLength="50"></asp:TextBox><%--onchange="javascript:upperMe()"--%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">                                               
                                            </td>
                                            <td>
                                                <asp:Label ID="lbltrackduplicate" runat="server" ForeColor="Red" ></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="txtDispatchDate">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Dispatch Date :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDispatchDate" runat="server" CssClass="textbox_pop" onchange="ChkDate(this.value)"
                                                    onkeydown="return checkShortcut();"></asp:TextBox><%-- ReadOnly="true" --%>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="PRO"
                                                    ForeColor="Red" ControlToCompare="txtDispatchDate" ControlToValidate="txtExpectedDate"
                                                    Operator="GreaterThanEqual" Type="Date" Text="Invalid date!"></asp:CompareValidator>
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="txtExpectedDate">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Expected Date :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtExpectedDate" runat="server" CssClass="textbox_pop" onkeydown="return checkShortcut();"></asp:TextBox>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="txtDispLocation">
                                                </asp:RequiredFieldValidator>
                                                <strong><span class="astrics">*</span>Dispatch Location :</strong>
                                            </td>
                                            <td>
                                                <asp:TextBox ID="txtDispLocation" ReadOnly="true" runat="server" TextMode="MultiLine"
                                                    Style="width: 88%;" Height="35px" Text="" BackColor="#E6E6E6" />
                                            </td>
                                        </tr>
                                    </table>
                                    <cc1:CalendarExtender ID="CalendarExtender1" TargetControlID="txtDispatchDate" runat="server"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <%-- <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtDispatchDate"
                                        MaskType="Date" Mask="99/99/9999">
                                    </cc1:MaskedEditExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtExpectedDate"
                                        MaskType="Date" Mask="99/99/9999">
                                    </cc1:MaskedEditExtender>--%>
                                    <cc1:CalendarExtender ID="CalendarExtender2" TargetControlID="txtExpectedDate" runat="server"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                </fieldset>
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="left" style="padding-left: 8px;">
                                        </td>
                                        <td align="right" style="padding-right: 8px;">
                                            &nbsp;&nbsp;<asp:Button ID="btnCourierSubmit" OnClick="btnCourierSubmit_Click" ValidationGroup="PR1"
                                                CssClass="button_all" runat="server" Text="Save" />&nbsp;&nbsp;<asp:Button ID="btnCourierReset"
                                                    OnClick="btnCourierReset_Click" CausesValidation="false" CssClass="button_all"
                                                    runat="server" Text="Reset" />
                                        </td>
                                    </tr>
                                </table>
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="right">
                                            <asp:Label ID="lblnote" Style="font-family: Arial; font-size: 12px; color: Red;"
                                                runat="server" Text="Note :- Please add product series detail first, then Click the save button "></asp:Label>
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </asp:Panel>
                    </div>
                </div>
            </asp:Panel>
            <cc1:ModalPopupExtender ID="ModalPopupExtenderNewDesign" runat="server" PopupControlID="PanelNewCourier"
                BackgroundCssClass="NewmodalBackground" TargetControlID="LabelNewDesign" CancelControlID="ButtonNewCourier">
            </cc1:ModalPopupExtender>
            <asp:Label ID="LabelNewDesign" runat="server"></asp:Label>
            <!--===============================PopUp Alert Starts===============================-->
            <asp:Panel ID="PanelAlert" runat="server" Width="20%" Style="display: none;">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="btnAlertPnlClose" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                        <!--<fieldset class="service_field" >-->
                        <div class="service_head_p">
                            <p>
                                <span class="left">
                                    <asp:Label ID="LabelAlertheader" runat="server" Text="Password" Font-Size="12px"></asp:Label>
                                </span><span class="right" style="visibility: hidden;"><span class="astrics"><strong>
                                </strong></span></span>
                            </p>
                        </div>
                        <div class="regis_popup" style="text-align: center;">
                            <br />
                            <asp:Label ID="LabelAlertText" runat="server" Text="" Font-Size="11px"></asp:Label><br />
                            <br />
                            <a id="btnYesActivation1" runat="server" class="button_all" style="text-decoration: none;"
                                href="~/Data/Bill/Invoice/16-10-2014/INVO14-1153.pdf" target="_blank">Print Receipt</a>
                            <asp:Button ID="btnYesActivation" Visible="false" runat="server" Text="Yes" CssClass="button_all"
                                OnClick="btnYesActivation_Click" />&nbsp;&nbsp;<asp:Button ID="btnNoActivation" runat="server"
                                    Text="No" CssClass="button_all" OnClick="btnNoActivation_Click" />
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <!--===============================Popup Close================================-->
            <asp:Label ID="Label12" runat="server"></asp:Label><asp:Label ID="LabelCalText" runat="server"
                Visible="false"></asp:Label>
            <cc1:ModalPopupExtender ID="ModalPopupExtenderAlert" runat="server" BackgroundCssClass="NewmodalBackground"
                CancelControlID="btnAlertPnlClose" PopupControlID="PanelAlert" TargetControlID="Label12">
            </cc1:ModalPopupExtender>
            <!--=============================== Receive PopUp Alert Starts===============================-->
            <asp:Panel ID="PanelReceive" runat="server" Width="20%" Style="display: none;">
                <div class="popupContent" style="width: 100%;">
                    <div class="pop_log_bg">
                        <div>
                            <asp:Button ID="recbtnclose" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                        <!--<fieldset class="service_field" >-->
                        <div class="service_head_p">
                            <p>
                                <span>Confirmation</span></p>
                        </div>
                        <div class="regis_popup" style="text-align: center;">
                            <div id="nMsg" runat="server" style="width: 86% !important;">
                                <p>
                                    <asp:Label ID="nMsgLabel2" runat="server"></asp:Label>
                                </p>
                            </div>
                            <br />
                            <strong><span><span class="astrics">*</span>Receive Date : </span></strong>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                                ValidationGroup="REC" ControlToValidate="txtreceivedt">
                            </asp:RequiredFieldValidator>
                            <asp:TextBox ID="txtreceivedt" runat="server" CssClass="textbox_pop" Width="150px"></asp:TextBox>
                            <br />
                            <br />
                            <asp:Button ID="recbtnYes" runat="server" Text="Yes" CssClass="button_all" ValidationGroup="REC"
                                OnClick="recbtnYes_Click" />&nbsp;&nbsp;<asp:Button ID="recbtnno" runat="server"
                                    Text="No" CssClass="button_all" />
                            <cc1:CalendarExtender ID="CalendarExtender3" TargetControlID="txtreceivedt" runat="server"
                                Format="dd/MM/yyyy">
                            </cc1:CalendarExtender>
                        </div>
                    </div>
                </div>
            </asp:Panel>
            <cc1:ModalPopupExtender ID="ReceiveModalPopup" runat="server" BackgroundCssClass="NewmodalBackground"
                CancelControlID="recbtnclose" OkControlID="recbtnno" PopupControlID="PanelReceive"
                TargetControlID="lblrectrat">
            </cc1:ModalPopupExtender>
            <asp:Label ID="lblrectrat" runat="server"></asp:Label>
            <!--=============================== Receive PopUp Alert End===============================-->
       <%-- </ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>
