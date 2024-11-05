<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="CommissionSetting.aspx.cs" Inherits="Admin_CommissionSetting" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      <title>Commission Setting</title>

    <style>
        select {
            font-family: inherit;
            font-size: inherit;
            line-height: inherit;
            width: 100%;
        }
    </style>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <style type="text/css">
        .auto-style1 {
            width: 73px;
        }

        .auto-style2 {
            margin-right: 0px;
        }
        .sidebar + .main-content{
             padding: 20px;
        }
        .app-table table{
            margin-bottom: 20px !important;
        }
        .app-table table tr td{
            width: 33.33%;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
      <script type="text/javascript">
        function Search_Gridview(strKey) {
            var strData = strKey.value.toLowerCase().split(" ");
            var tblData = document.getElementById("<%=gridview1.ClientID %>");
            var rowData;
            for (var i = 1; i < tblData.rows.length; i++) {
                rowData = tblData.rows[i].innerHTML;
                var styleDisplay = 'none';
                for (var j = 0; j < strData.length; j++) {
                    if (rowData.toLowerCase().indexOf(strData[j]) >= 0)
                        styleDisplay = '';
                    else {
                        styleDisplay = 'none';
                        break;
                    }
                }
                tblData.rows[i].style.display = styleDisplay;
            }
        }
      </script>  <!-- Add the table for Register form -->

    <div class="breadcrumbs" id="breadcrumbs">
        <script type="text/javascript">
            try { ace.settings.check('breadcrumbs', 'fixed') } catch (e) { }
        </script>

        <ul class="breadcrumb">
            <li>
                <i class="ace-icon fa fa-home home-icon"></i>
                <a href="#">Home</a>
            </li>
            <li class="active">Commission Setting</li>
        </ul>
    </div>

   <br />

    <div class="app-table">
        <table class="table table-bordered">
            <thead>
                <tr>
                    <th style="text-align:center;">
                        Choose Vendor
                    </th>
                  <th style="text-align:center;">
                        Choose Service
                    </th>
                    
                    <th style="text-align:center;">
                         Action
                    </th>
                </tr>
            </thead>
            <tbody>
                <tr>
                    <td style="text-align:center;">
                       <asp:DropDownList ID="ddlcompany" runat="server">
                            
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFiledValidtor2" ControlToValidate="ddlcompany" runat="server" ValidationGroup="version" ErrorMessage="Fill Information"></asp:RequiredFieldValidator>
                    </td>
                    <td style="text-align:center;">
                           <asp:DropDownList ID="ddlservice" runat="server">
                            <asp:ListItem>--Select--</asp:ListItem>
                            <asp:ListItem Value="SRV1029">Cashback-UPI</asp:ListItem>
                            <asp:ListItem Value="SRV1028">Instant Payout</asp:ListItem>
                            <asp:ListItem Value="SRV1027">Auto Cash Transfer</asp:ListItem>
                           
                            
                        </asp:DropDownList>
                        <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ControlToValidate="ddlservice" runat="server" ValidationGroup="version" ErrorMessage="Fill Information"></asp:RequiredFieldValidator>
                    </td>
                    
                    <td style="text-align:center;">
                        <asp:Button class="btn btn-primary" ID="btnsearch" runat="server" type="submit" Text="Search" ValidationGroup="version" OnClick="btnsearch_Click" />
                    </td>
                </tr>
            </tbody>
        </table>
    </div>
    <div>   
       
            <!-- Filter the item of the Gridview-->
            <asp:TextBox ID="txtFilterGrid1Record" 
                class="form-control" runat="server" placeholder="Search "
                onkeyup="Search_Gridview(this)">
            </asp:TextBox>
            <br />
            <br />
        <asp:UpdatePanel ID="upd1" runat="server">

            <ContentTemplate>
 <!-- An Gridview to store and show item in the table form -->
            <asp:gridview ID="gridview1" runat="server" OnRowDataBound="gridview1_RowDataBound"  AutoGenerateColumns="False" ShowHeaderWhenEmpty="True" OnRowEditing="gridview1_RowEditing" OnRowCancelingEdit="gridview1_RowCancelingEdit" OnRowUpdating="gridview1_RowUpdating"  DataKeyNames="id" class="table table-bordered table-striped align-middle">
                <columns>
                    <asp:TemplateField HeaderText="SNO">
                    <EditItemTemplate>
                    <asp:Label ID="lbl_ID" runat="server" Text='<%# Eval("Id") %>'></asp:Label>
                      </EditItemTemplate>
                     <ItemTemplate>
                    <asp:Label ID="lbl_ID" runat="server" Text='<%# Bind("Id") %>'></asp:Label>
                    </ItemTemplate>
                     </asp:TemplateField>
                    <asp:TemplateField HeaderText="Slab">
                        <EditItemTemplate>
                            <asp:Label ID="txtSlab" runat="server" Text='<%# Eval("Slab") %>'></asp:Label>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblSlab" runat="server" Text='<%# Bind("Slab") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                     <asp:TemplateField HeaderText="Vendor Name">
                        
                        <ItemTemplate>
                            <asp:Label ID="lblComp_ID" runat="server" Text='<%# Bind("Comp_ID") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>

                    <%--<asp:TemplateField HeaderText="Comm. Amount">
                        <EditItemTemplate>
                            <asp:TextBox ID="txt_Comm_Amount" runat="server" Text='<%# Bind("Comm_Amount") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblComm_Amount" runat="server" Text='<%# Bind("Comm_Amount") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                     <asp:TemplateField HeaderText="Comm. Type">
                    <EditItemTemplate>
                    
                        <asp:DropDownList ID="ddlComm_Type" runat="server">
                            <asp:ListItem Value="0">(%)Per.</asp:ListItem>
                            <asp:ListItem Value="1">(₹)Rs.</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                     <ItemTemplate>

                          <asp:DropDownList ID="ddlselectedComm_Type" runat="server">
                            <asp:ListItem Value="0">(%)Per.</asp:ListItem>
                            <asp:ListItem Value="1">(₹)Rs.</asp:ListItem>
                        </asp:DropDownList>

                     
                       </ItemTemplate>
                     </asp:TemplateField>--%>
                    
                      <asp:TemplateField HeaderText="Charge Type">
                    <EditItemTemplate>
                  
                        <asp:DropDownList ID="ddlCharge_Type" runat="server">
                            <asp:ListItem Value="False">(%)Per.</asp:ListItem>
                            <asp:ListItem Value="True">(₹)Rs.</asp:ListItem>
                        </asp:DropDownList>
                    </EditItemTemplate>
                     <ItemTemplate>
                         <asp:HiddenField ID="hdfchargetype" runat="server" Value='<%# Eval("Charge_Type") %>' />
                          <asp:HiddenField ID="hfComm_ID" runat="server" Value='<%# Eval("Comm_ID") %>' />
                         <asp:HiddenField ID="hfSlab_Id" runat="server" Value='<%# Eval("id") %>' />
                          <asp:DropDownList ID="ddlselectedCharge_Type" runat="server">
                            <asp:ListItem Value="False">(%)Per.</asp:ListItem>
                            <asp:ListItem Value="True">(₹)Rs.</asp:ListItem>
                        </asp:DropDownList>
                     <%--  <asp:Label ID="lblCharge_Type" runat="server" Text='<%# Bind("Charge_Type") %>'></asp:Label>--%>
                       </ItemTemplate>
                     </asp:TemplateField>

                    <asp:TemplateField HeaderText="Charge Amount">
                        <EditItemTemplate>
                            <asp:TextBox ID="txt_Charge_Amount" runat="server" Text='<%# Bind("Charge_Amount") %>'></asp:TextBox>
                        </EditItemTemplate>
                        <ItemTemplate>
                            <asp:Label ID="lblCharge_Amount" runat="server" Text='<%# Bind("Charge_Amount") %>'></asp:Label>
                        </ItemTemplate>
                    </asp:TemplateField>
                   
                     
                      <asp:TemplateField HeaderText="Action" ShowHeader="False">
                          <EditItemTemplate>
                              <asp:LinkButton ID="LinkButton1" runat="server" class="btn btn-primary" CausesValidation="False" CommandName="Update" Text="Update"></asp:LinkButton>
                              &nbsp;<%--<asp:LinkButton ID="LinkButton2" runat="server" class="btn btn-primary" CausesValidation="False" CommandName="Cancel" Text="View"></asp:LinkButton>--%>
                          </EditItemTemplate>
                          <ItemTemplate>
                             
                              
                               <asp:LinkButton ID="LinkButton4" runat="server" class="btn btn-primary"  CausesValidation="False" CommandName="Edit" Text="Edit"></asp:LinkButton>
                              <%--<asp:Button ID="Button2" runat="server" class="btn btn-primary btn-sm" type="button"  Text="Back" />--%>

                          </ItemTemplate>
                    </asp:TemplateField>
                     

                </columns>
                <EmptyDataTemplate> No Record Available</EmptyDataTemplate>
            </asp:gridview>
       
            </ContentTemplate>
        </asp:UpdatePanel>
           
    </div>
</asp:Content>

