<%@ Page Language="C#" MasterPageFile="~/Admin/AdminMaster.master" AutoEventWireup="true" CodeFile="ResetForm.aspx.cs" Inherits="admin_ResetForm" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

    <script language="javascript" type="text/javascript">
function Valid()
{
if(document.getElementById("txtpass").value=="")
{
   alert('Please Enter Correct Password');
   return false;
   }
 if(document.getElementById("txtpass").value==document.getElementById("<%=lblpass.ClientID %>").value)
    return true;
 else
 {
    alert('Please Enter Correct Password');
    return false;
    }
}
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div id="content">
        <div class="first_in">
            <div class="detail_heading">
                <p>
                    Reset DataBase <span style="color:Red;float:right;font-weight:normal;font-size:12px;">
                        <asp:Label ID="lblresetmsg" runat="server" Text="" ></asp:Label></span> </p>
            </div>
            <table cellspacing="2" cellpadding="1" class="tab">
                <tr runat="server" id="txt" visible="true">
                    <td align="right" >
                        <strong>Enter Password : </strong>
                    </td>
                    <td>
                        <asp:TextBox ID="txtPass" runat="server" CssClass="txt_box" TextMode="Password"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ErrorMessage="*" ControlToValidate="txtPass" ValidationGroup="rest"></asp:RequiredFieldValidator>
                        <input type="hidden" id="lblpass" runat="server" value="zncfzxcz" />
                    </td>
                </tr>
                <tr class="txt_box" runat="server" id="chk" visible="false">
                    <td align="right">
                        &nbsp;</td>
                    <td >
                        <asp:CheckBox ID="chkCalc" runat="server" Text=" Reset Calculations" /><br />
                        <asp:CheckBox ID="chkMem" runat="server" Text=" Reset Calculations & Members" /><br />
                        <asp:CheckBox ID="chkMaster" runat="server" Text=" Reset Masters" /><br />
                        <asp:CheckBox ID="chkAll" runat="server" Text=" Reset All" />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        &nbsp;
                    </td>
                    <td>
                        <asp:ImageButton ID="imgbtnlogin" runat="server" 
                             ImageUrl="~/images/Button/login.png" 
                            onclick="imgbtnlogin_Click"  ValidationGroup="rest"/>
                        <asp:ImageButton ID="ImageButton1" ImageUrl="~/images/Button/reset.png"
                            runat="server" OnClick="ImageButton1_Click" />
                    </td>
                </tr>
                <tr>
                    <td align="right">
                        &nbsp;</td>
                    <td>
                        <asp:Label ID="lblcaldate" runat="server" ForeColor="#CC0000"></asp:Label>
                    </td>
                </tr>
            </table>
        </div>
    </div>
</asp:Content>

