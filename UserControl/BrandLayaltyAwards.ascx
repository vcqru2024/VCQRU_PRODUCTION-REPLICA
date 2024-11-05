<%@ Control Language="C#" AutoEventWireup="true" CodeFile="BrandLayaltyAwards.ascx.cs" Inherits="UserControl_BrandLayaltyAwards" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

  <script type="text/javascript">
        //$(document).ready(function() {

        //    $(".accordion2 p").eq(13).addClass("active");
        //    $(".accordion2 div.open").eq(11).show();

        //    $(".accordion2 p").click(function() {
        //        $(this).next("div.open").slideToggle("slow")
		//.siblings("div.open:visible").slideUp("slow");
        //        $(this).toggleClass("active");
        //        $(this).siblings("p").removeClass("active");
        //    });

        //});
    </script>

    <script type="text/javascript">
      <%--  function checklabel(vl) {
            PageMethods.checkNewLabel(vl, onCompleteLaebl)
        }
        function onCompleteLaebl(Result) {
            if (Result == true) {
                document.getElementById("<%=lblLabelChk.ClientID %>").innerHTML = "Label Name Already exist.";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";
            }
            else {
                document.getElementById("<%=lblLabelChk.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
            }
            ChkSaveBtn();
        }
        function ChkSaveBtn() {
            var vl = document.getElementById("<%=lblLabelChk.ClientID %>").innerHTML;           
            if (vl == "") {                
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
            }
            else {
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";
            }
        }   --%>
    </script>
<%--<div class="col-lg-12 card card-admin form-wizard medias">
										<div class="">
											<div class="row pb-2 pt-2 background-section-form">
												<div class="col-lg-10">
													<h4 class="mb-0">Record(s) found<span> (2)</span></h2>
												</div>
												<div class="col-lg-2">
													<select class="form-control mb-0">
														<option>25 Rows</option>
														<option>20 Rows</option>
														<option>15 Rows</option>
													</select>
												</div>
											</div>
											<table class="table table-striped">
												<thead>
													<tr>
														<th>S.No</th>
														<th>Product Name</th>
														<th>Label Name</th>
														<th>Price/Label</th>
														<th>Description</th>
														<th>Sound File</th>
														<th>Action</th>
													</tr>
												</thead>
												<tbody>
													<tr>
														<td>
															1
														</td>
														<td>
															Pro 21 March
														</td>
														<td>
															Virtual Label (00*00)
														</td>
														<td>
															<i class="fa fa-rupee"></i> 0.05 + (Applicable Tax)
														</td>
														<td>
															test
														</td>
														<td class="text-center">
															<a href="#" style="color: #5A738E; "><i class="fa fa-play-circle"></i></a>
														</td>
														<td class="text-center">
															<a href="#" style="color: #5A738E; "><i class="fa fa-pencil"></i></a> &nbsp;
															<a href="#" style="color: #5A738E; "><i class="fa fa-search"></i></a> &nbsp;
															<a href="#" style="color: #5A738E; "><i class="fa fa-plus"></i></a>
														</td>
													</tr>
												</tbody>
											</table>
										</div>
									</div>--%>
<%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>

<div class="col-lg-12 card card-admin form-wizard medias">
										<div class="">
											<div class="row pb-2 pt-2 background-section-form">
												<div class="col-lg-10">
													<h4 class="mb-0">Record(s) found<span> (<asp:Label ID="lblcount" runat="server"></asp:Label>)</span></h2>
												</div>
												<div class="col-lg-2">
													<%--<select class="form-control mb-0">
														<option>25 Rows</option>
														<option>20 Rows</option>
														<option>15 Rows</option>
													</select>--%>
                                                    <asp:DropDownList ID="ddlRowProductCnt" runat="server" 
                                                         class="form-control mb-0"  >
                                        <asp:ListItem Value="5">25 Rows</asp:ListItem>
                                        <asp:ListItem Value="6">50 Rows</asp:ListItem>
                                        <asp:ListItem Value="100">100 Rows</asp:ListItem>
                                        <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                        <asp:ListItem Value="1000">1000 Rows</asp:ListItem>
                                        <asp:ListItem Value="1001">All Rows</asp:ListItem>
                                    </asp:DropDownList>
												</div>
											</div>
                                            <asp:GridView ID="GrdAwards" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                    DataKeyNames="IsDelete,IsActive" EmptyDataText="Record Not Found" 
                    
                    BorderColor="transparent" 
                    AllowPaging="True" PageSize="15">
                    <Columns>
                        
                        <asp:TemplateField HeaderText="S.No.">
                            <ItemTemplate>
                                <%=++str %>
                            </ItemTemplate>
                           <%-- <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="7%" />--%>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" Awards Name">
                            <ItemTemplate>
                                <asp:Label ID="lblname" runat="server" Text='<%# Bind("AwardName") %>'></asp:Label>
                            </ItemTemplate>
                           <%-- <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" Width="35%" />--%>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText=" Points">
                            <ItemTemplate>
                                <asp:Label ID="lblsize" runat="server" Text='<%# Bind("Points") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />--%>
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action" Visible="true">
                            <ItemTemplate>
                                <%
                                    try
                                    {
                                        dflag = Convert.ToInt32(GrdAwards.DataKeys[index].Values["IsDelete"].ToString());
                                        aflag = Convert.ToInt32(GrdAwards.DataKeys[index].Values["IsActive"].ToString());
                                    }
                                    catch { }

                                    if (dflag == 0)
                                    { %>
                                        <asp:ImageButton ID="ImgbtnEdit" runat="server" ImageUrl="~/Content/images/edit.png" CommandArgument='<%# Bind("RowId") %>'
                                    CausesValidation="false" CommandName="EditLabel" ToolTip="Price Edit" />&nbsp;
                                    <%if (aflag == 0)
                                      {  
                                    %>
                                    <asp:ImageButton ID="imgawrdactive" runat="server" ImageUrl="~/Content/images/check_act.png"
                                        CausesValidation="false" ToolTip='<%# Bind("IsActiveMsg") %>' CommandArgument='<%# Bind("RowId") %>'
                                        CommandName="IsActive" Height="12px" Width="12px" />&nbsp;
                                    <%}
                                      else
                                      {%>
                                    <asp:ImageButton ID="imgawrddeactive" runat="server" ImageUrl="~/Content/images/check_gr.png"
                                        CausesValidation="false" ToolTip='<%# Bind("IsActiveMsg") %>' CommandArgument='<%# Bind("RowId") %>'
                                        CommandName="IsActive" Height="12px" Width="12px" />&nbsp;
                                    <%}                                     
                                    %> 
                                    <asp:ImageButton ID="imgshowlbl" runat="server" ImageUrl="~/Content/images/delete.png"
                                    CausesValidation="false" ToolTip='<%# Bind("IsDeleteMsg") %>' CommandArgument='<%# Bind("RowId") %>'
                                    CommandName="IsDelete" Height="10px" Width="10px" />&nbsp;
                                    
                                     <%}
                                    else
                                    { %>
                                         <asp:Label ID="lbldelaward" Text="Deleted" ForeColor="Red" runat="server" ></asp:Label>
                                         <%  }                                 
                                    %>                                    
                                   
                                <%index++; %>    
                                    
                                    
                            </ItemTemplate>
                        <%--    <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle HorizontalAlign="Center" Width="10%" />--%>
                        </asp:TemplateField>
                    </Columns>
                   <%-- <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />--%>
                </asp:GridView>
                                            </div>
    </div>
 
  <%-- </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
        </Triggers>
    </asp:UpdatePanel>--%>