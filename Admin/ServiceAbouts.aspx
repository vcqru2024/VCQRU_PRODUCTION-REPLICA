<%@ Page Language="C#" MasterPageFile="~/Admin/MasterPage.master" AutoEventWireup="true"
    Title="About Services" CodeFile="ServiceAbouts.aspx.cs" Inherits="ServiceAbouts" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit.HTMLEditor"
    TagPrefix="cc2" %>
<%@ Register Namespace="CustomControl" TagPrefix="Custom" %>
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

    <script language="javascript" type="text/javascript">
        function checkAll(frm, mode) {
            var i = 0;
            for (; i < frm.elements.length; i++)
                if (frm.elements[i].type == "checkbox")
                frm.elements[i].checked = mode;
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 1207px; width: 100%;
                        top: 0px;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White">Please Wait.... </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
            <div class="head_cont">
                <h2 class="news_panel">
                    <table width="99%">
                        <tr>
                            <td width="85%">
                                About Services
                            </td>
                            <td>
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
            <div id="divmsg" runat="server">
                <p>
                    <asp:Label ID="lblmsg" runat="server"></asp:Label>
                </p>
            </div>
            <table cellspacing="2" cellpadding="0" class="regis_popup">
                <tr>
                    <td valign="top">
                        <strong>Service Name : </strong><span class="astrics">*</span>
                         <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ForeColor="Red"
                         ValidationGroup="SRV" ControlToValidate="ddlService" InitialValue="--Select--"></asp:RequiredFieldValidator>
                         <asp:DropDownList ID="ddlService" runat="server" onchange="javascript:checkExist();">
                     </asp:DropDownList> 
                    </td>
                </tr>              
                <tr>
                    <td valign="top">
                        <strong>About Service : </strong><span class="astrics">*</span>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Editor2"
                            ErrorMessage="*" Visible="false"></asp:RequiredFieldValidator>
                    </td>
                </tr>
                <tr>
                    <td style="height: 175px;">
                    <cc2:Editor ID="Editor1" runat="server" />
                        <%--<Custom:CustomEditor runat="server" ID="Editor2" />--%>
                    </td>                                       
                </tr>
                <tr>                   
                    <td>
                        <strong>Terms & Conditions : </strong><span class="astrics">*</span>
                    </td>
                </tr>
                <tr>
                 <td valign="top" style="height: 175px;">
                        <cc2:Editor ID="Editor2" runat="server" />
                    </td>
                </tr>
                <tr>                   
                    <td >
                        <strong>Advantage : </strong><span class="astrics">*</span>
                    </td>
                </tr>
                <tr>
                 <td valign="top" style="height: 175px;">
                        <cc2:Editor ID="Editor3" runat="server" />
                    </td>
                </tr>
                <tr>
                    <td align="right" colspan="3">
                        <asp:Label ID="lblid" runat="server" Visible="False"></asp:Label>
                        <asp:Button ID="btnsave" Text="Save" runat="server" CssClass="button_all" OnClick="btnsave_Click" ValidationGroup="SRV" />
                        <asp:Button ID="btncancel" Text="Reset" runat="server" CssClass="button_all" OnClick="btncancel_Click"
                            CausesValidation="False" />
                    </td>
                </tr>
            </table>
            <br />
            <div class="grid_container">
                <h4 class="visit_head">
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <input type="hidden" runat="server" id="hidden1" />
                                <img src="../Content/images/regis_pro.png" alt="products" />
                            </td>
                            <td class="bord_right">
                                <asp:Label ID="lblGridHeaderTextLicence" runat="server" Text="Record(s) found"></asp:Label>
                                <span class="small_font">(<asp:Label ID="lblcount" runat="server"></asp:Label>)</span>
                            </td>
                            <td align="right">
                                <span class="small_font">
                                    <asp:Button ID="ImageButton1" runat="server" Text="Delete" CssClass="button_all"
                                        CausesValidation="false" OnClick="ImageButton1_Click" Visible="false" />
                                    <cc1:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are You Sure ? "
                                        TargetControlID="ImageButton1">
                                    </cc1:ConfirmButtonExtender>
                                    <asp:Button ID="ImageButton2" runat="server" Text="Active / DeActive" CssClass="button_all"
                                        CausesValidation="false" OnClick="ImageButton2_Click"  Visible="false" />
                                    <asp:Label runat="server" ID="lblConmsg" Text="" ForeColor="Red"></asp:Label></span>
                            </td>
                            <td width="13%" align="center">
                                <div class="mainselection">
                                    <asp:DropDownList ID="ddlRowsShow" runat="server" AutoPostBack="true" OnSelectedIndexChanged="ddlRowsShow_SelectedIndexChanged">
                                        <asp:ListItem Value="25">25 Rows</asp:ListItem>
                                        <asp:ListItem Value="50">50 Rows</asp:ListItem>
                                        <asp:ListItem Value="100">100 Rows</asp:ListItem>
                                        <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                        <asp:ListItem Value="1000">1000 Rows</asp:ListItem>
                                        <asp:ListItem Value="1001">All Rows</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </td>
                        </tr>
                    </table>
                </h4>
                <asp:GridView ID="GridView1" runat="server" CssClass="grid" EnableModelValidation="True" DataKeyNames="IsActive"
                    Width="100%" EmptyDataText="Record Not Found" CellPadding="0" AutoGenerateColumns="False"
                    BorderStyle="None" OnRowCommand="GridView1_RowCommand">
                    <Columns>
                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" Visible="false">
                            <HeaderTemplate>
                                <input id="chkselecth" name="chkselecth" type="checkbox" onchange="checkAll(this.form,this.checked)" />
                            </HeaderTemplate>
                            <ItemTemplate>
                                <input id="chkselect" name="chkselect" type="checkbox" value='<%# Eval("Row_ID") %>' />
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle Width="5%" HorizontalAlign="Center" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date">
                            <ItemTemplate>
                                <asp:Label ID="Labeldate" runat="server" Text='<%# Bind("EntryDate") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle Width="17%" HorizontalAlign="Justify" CssClass="grd_pad" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="About">
                            <ItemTemplate>
                                <asp:Label ID="lblaboutsrv" runat="server" Text='<%# Bind("AboutService") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle Width="25%" HorizontalAlign="Justify" CssClass="grd_pad" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Terms & Conditions">
                            <ItemTemplate>
                                <asp:Label ID="lbltnc" runat="server" Text='<%# Bind("Terms_Conditions") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle Width="25%" HorizontalAlign="Justify" CssClass="grd_pad" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Advantage">
                            <ItemTemplate>
                                <asp:Label ID="lbladvantage" runat="server" Text='<%# Bind("Advantage") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle Width="25%" HorizontalAlign="Justify" CssClass="grd_pad" />
                        </asp:TemplateField>                        
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                            <asp:ImageButton ToolTip="Edit" ID="imgbtnedit" runat="server" CausesValidation="false"
                                    ImageUrl="~/Content/images/edit.png" CommandArgument='<%# Bind("Row_ID") %>' CommandName="EditRow" />&nbsp;
                            <%try
                              {
                                  IsVal = Convert.ToInt32(GridView1.DataKeys[index].Values["IsActive"].ToString());
                              }
                              catch (Exception ex)
                              {
                              }
                              if (IsVal == 0)
                              {
                                 %>
                                <asp:ImageButton ID="lnkstattus" runat="server" CausesValidation="false" CommandArgument='<%# Bind("Row_ID") %>' CommandName="ChangeStatus" ToolTip='<%# Bind("Status") %>' ImageUrl="~/Content/images/check_act.png" />&nbsp;
                                <%}
                              else
                              { %>
                                <asp:ImageButton ID="lnknewbtn" runat="server" CausesValidation="false" CommandArgument='<%# Bind("Row_ID") %>' CommandName="ChangeStatus" ToolTip='<%# Bind("Status") %>' ImageUrl="~/Content/images/check_gr.png" />&nbsp;
                                <%} %>
                                
                                    <asp:ImageButton ToolTip="Delete" ID="imgnewdeletebtn" runat="server" CausesValidation="false" OnClientClick="return confirm('Are you sure o delete this Entry.')"
                                    ImageUrl="~/Content/images/delete.png" CommandArgument='<%# Bind("Row_ID") %>' CommandName="DeleteRows" />
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                            <ItemStyle Width="10%" HorizontalAlign="Center" />
                        </asp:TemplateField>
                    </Columns>
                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />
                </asp:GridView>
            </div>
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>
