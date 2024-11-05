<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true"
    CodeFile="NewsUpdate.aspx.cs" Inherits="admin_NewsUpdate" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register assembly="AjaxControlToolkit" namespace="AjaxControlToolkit.HTMLEditor" tagprefix="cc2" %>
<%@ Register   Namespace="CustomControl" TagPrefix="Custom" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
<script language="javascript" type="text/javascript">
    function checkAll(frm,mode)
{    var i=0;   
    for(;i<frm.elements.length;i++)   
     if(frm.elements[i].type=="checkbox")
         frm.elements[i].checked=mode;             
}
    </script>
<script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(49).addClass("active");
            $(".accordion2 div.open").eq(45).show();

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
    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                <ContentTemplate>
          <asp:UpdateProgress ID="UpdateProgress2" runat="server" AssociatedUpdatePanelID="UpdatePanel2">
                        <ProgressTemplate>
                            <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
                                top: 0px;" class="modalBackground">
                                <div style="margin-top: 300px;" align="center">
                                    <img alt="" src="../images/icons/ajax-loader.gif" /><br />
                                    <span style="color: White">Please Wait.... </span>
                                </div>
                            </div>
                        </ProgressTemplate>
                    </asp:UpdateProgress>
    <div id="content" style="width:100%">
        <div class="pin" style="width:100%;" >
            <div class="detail_heading" style="width:100%">
                <p>
                    News Update</p>
            </div>
            <table cellspacing="2" cellpadding="0" class="tab">
            <tr>
                    <td  valign="top">
                        <strong>News Heading : </strong></td>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>
                             <strong>News Summary : </strong>              
                         </td>
                         </tr>
                           <tr>
                           <td>
                            
                             <Custom:CustomEditor  runat="server" ID="Editor2" Height="225px"  />
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="Editor2"
                            ErrorMessage="*"></asp:RequiredFieldValidator>
                            </td> <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                            <td valign="top">
                             <cc2:Editor ID="Editor1" runat="server" />
                        <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ControlToValidate="Editor1"
                            ErrorMessage="*"></asp:RequiredFieldValidator>--%>
                    </td>
                </tr>                
                <tr>
                    <td align="right" colspan="3" >
                        <asp:Label ID="lblid" runat="server" Visible="False"></asp:Label>
                        <asp:Label ID="lblmdg" runat="server" ForeColor="#FF3300">
                        </asp:Label>                
                        <asp:ImageButton ID="btnsave" ImageUrl="~/images/Button/save.png" runat="server"
                            OnClick="btnsave_Click" />
                        <asp:ImageButton ID="btncancel" ImageUrl="~/images/Button/cancel.png" runat="server"
                            OnClick="btncancel_Click" CausesValidation="False" />
                    </td>
                </tr>
            </table>
            <hr /><br />
            <div>
                <asp:ImageButton ID="ImageButton1" runat="server" 
                    ImageUrl="~/images/Delete1.png" CausesValidation="false" 
                    onclick="ImageButton1_Click" /> 
                <cc1:ConfirmButtonExtender ID="ConfirmButtonExtender1" runat="server" ConfirmText="Are You Sure ? "
                 TargetControlID="ImageButton1">
                </cc1:ConfirmButtonExtender>
                <asp:ImageButton ID="ImageButton2" runat="server" 
                    ImageUrl="~/images/activate.png" CausesValidation="false" 
                    onclick="ImageButton2_Click" />     
                    <asp:Label runat="server" ID="lblConmsg" Text="" ForeColor="Red"></asp:Label>            
                </div>
            <div class="member11">
                <asp:GridView ID="GridView1" runat="server" CssClass="table" EnableModelValidation="True"
                    CellPadding="0" AutoGenerateColumns="False" BorderStyle="None" OnRowCommand="GridView1_RowCommand">
                    <PagerStyle />
                    <AlternatingRowStyle CssClass="tr2" />
                    <Columns>
                    <asp:TemplateField ItemStyle-HorizontalAlign="Center">
                        <HeaderTemplate>
                            <input id="chkselecth" name="chkselecth" type="checkbox" onchange="checkAll(this.form,this.checked)" />
                        </HeaderTemplate>
                        <ItemTemplate>
                            <input id="chkselect" name="chkselect" type="checkbox" value='<%# Eval("tbl_id") %>' />
                        </ItemTemplate>
                        <HeaderStyle CssClass="tr" />
                        <ItemStyle HorizontalAlign="Center"></ItemStyle>
                    </asp:TemplateField>
                        <asp:BoundField DataField="Updated_Date" HeaderText="Date">
                            <HeaderStyle CssClass="tr" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Heading">
                           
                            <ItemTemplate>
                                <asp:Label ID="Label2" runat="server" Text='<%# Bind("News_heading") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr" />
                            <ItemStyle CssClass="tt_lft" HorizontalAlign="Justify" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Summary">                           
                            <ItemTemplate>
                                <asp:Label ID="Label1" runat="server" Text='<%# Bind("News") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr" />
                            <ItemStyle CssClass="tt_lft" HorizontalAlign="Justify" />
                        </asp:TemplateField>
                        <asp:BoundField DataField="Act_Flag" HeaderText="Status">
                            <HeaderStyle CssClass="tr" />
                        </asp:BoundField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:ImageButton ToolTip="Edit" ID="imgbtnedit" runat="server" CausesValidation="false"
                                    ImageUrl="~/images/Button/019.png" CommandArgument='<%# Bind("tbl_id") %>' CommandName="EditRow" />
                              <%--  <asp:ImageButton ToolTip="Delete" ID="ImageButton1" runat="server" CausesValidation="false"
                                    ImageUrl="~/images/Button/cross.png" CommandArgument='<%# Bind("tbl_id") %>'
                                    CommandName="DeleteRow" />--%>
                               
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr" />
                        </asp:TemplateField>
                    </Columns>
                    <RowStyle CssClass="tr1" />
                </asp:GridView>
            </div>
        </div>
    </div>
     </ContentTemplate>   
    </asp:UpdatePanel>
</asp:Content>
