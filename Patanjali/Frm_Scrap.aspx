<%@ Page Title="" Language="C#" MasterPageFile="~/Patanjali/pfl.master" AutoEventWireup="true"
    CodeFile="Frm_Scrap.aspx.cs" Inherits="Patanjali_Frm_Scrap" %>
    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="asp" %>

        <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
            <script type="text/javascript">
                $(document).ready(function () {

                    $(".accordion2 p").eq(27).addClass("active");
                    $(".accordion2 div.open").eq(26).show();

                    $(".accordion2 p").click(function () {
                        $(this).next("div.open").slideToggle("slow")
                            .siblings("div.open:visible").slideUp("slow");
                        $(this).toggleClass("active");
                        $(this).siblings("p").removeClass("active");
                    });

                });
            </script>

            <script type="text/javascript">
                function checkAll(frm, mode) {
                    var i = 0;
                    for (; i < frm.elements.length; i++)
                        if (frm.elements[i].type == "checkbox")
                            frm.elements[i].checked = mode;
                }
            </script>
        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

            <%-- <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0">
                    <ProgressTemplate>
                        <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%;
                        top: 0px; z-index: 100001;" class="NewmodalBackground">
                            <div style="margin-top: 300px;" align="center">
                                <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                                <span style="color: White;">Please Wait.....<br />
                                </span>
                            </div>
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>--%>


            <div class="home-section">
                <div class="app-breadcrumb">
                    <div class="row">
                        <div class="col">
                            <h5>Scrap Label Status Summary
                                <asp:HiddenField ID="hidden1" runat="server" />
                            </h5>
                        </div>
                        <div class="col">
                            <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="../Patanjali/dashboard.aspx">Dashboard</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Scrap Label Status Summary
                                    </li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
                <!-- table view -->
                <div class="user-role-card">
                    <div class="card">
                        <div class="card-body">
                            <div class="row">
                                <div class="col col-md-4 mb-3">
                                    <div class="global-search">
                                        <div class="form-group ">
                                            <input type="search" class="form-control"
                                                onkeyup="performSearch(this.value)" placeholder="Search">
                                            <span><i class="fa fa-search"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col mb-3">
                                    <ul class="action-button-global">

                                        <li>
                                            <a href="FrmScrapEntry.aspx" class="btn btn-sm btn-primary"><i
                                                    class='bx bx-plus'></i>add
                                                Scrap</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <div class="row">

                                <div class="col">
                                    <label for="Product Name" class="form-label">Product Name<span>*</span></label>
                                    <asp:DropDownList ID="ddlProduct" CssClass="form-select"
                                        runat="server" AutoPostBack="true"
                                        OnSelectedIndexChanged="ddlProduct_SelectedIndexChanged">
                                    </asp:DropDownList>
                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                        ControlToValidate="ddlProduct" ErrorMessage="*" InitialValue="--Select--"
                                        ValidationGroup="abc" runat="server"></asp:RequiredFieldValidator>
                                </div>
                                <div class="col">
                                    <label for="Product Description" class="form-label">From</label>

                                    <asp:TextBox ID="txtscrapfrom" onchange="upperMe()"
                                        CssClass="form-control" runat="server"></asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator2" runat="server"
                                        ValidationGroup="abc" ControlToValidate="txtscrapfrom"
                                        ErrorMessage="ex: AA06-01-001" Display="None" ViewStateMode="Enabled"
                                        ValidationExpression="[A-Z][A-Z][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]">
                                    </asp:RegularExpressionValidator>

                                </div>
                                <div class="col">
                                    <label for="Dispatch Location" class="form-label">To</label>
                                    <asp:TextBox ID="txtscrapto" CssClass="form-control" runat="server">
                                    </asp:TextBox>
                                    <asp:RegularExpressionValidator ID="RegularExpressionValidator1" runat="server"
                                        ValidationGroup="abc" ControlToValidate="txtscrapto"
                                        ErrorMessage="ex: AA06-01-001" Display="None" ViewStateMode="Enabled"
                                        ValidationExpression="[A-Z][A-Z][0-9][0-9]-[0-9][0-9]-[0-9][0-9][0-9][0-9]">
                                    </asp:RegularExpressionValidator>
                                </div>
                                <div class="col">
                                    <label for="" class="form-label text-white">*</label><br>
                                    <asp:Button ID="btnSearch" OnClick="btnSearch_Click"
                                        ValidationGroup="chk94" class="btn btn-primary" runat="server" Text="Search" />

                                    <asp:Button ID="btnRefresh" OnClick="btnRefresh_Click"
                                        class="btn btn-success" runat="server" CausesValidation="false" Text="Reset" />
                                </div>
                            </div>
                            <h4 class="mb-0">Record's Found :<span>
                                <asp:Label ID="lblcount" runat="server"></asp:Label>
                                <asp:Label ID="lblC" Text="0" runat="server" Visible="false"></asp:Label>
                            </span></h4>
                        <asp:Label ID="LblMsg" CssClass="small_font" runat="server"></asp:Label>

                        <div class="row">
                            <div class="col-lg-3">
                                <asp:button id="btnAvailable" runat="server"
                                    Style="background-color: #c7efc8; width: 15px; height: 15px; border: 1px solid #bdb5b5; margin-right: 10px;"
                                    onclick="btnAvailable_Click" tooltip="Click For Filter" /><label>Labels Available
                                </label>
                            </div>
                            <div class="col-lg-3">
                                <asp:Button ID="btnUsed" runat="server"
                                    Style="background-color: Yellow; width: 15px; height: 15px; border: 1px solid #bdb5b5; margin-right: 10px;"
                                    OnClick="btnUsed_Click" ToolTip="Click For Filter" /><label>Pasted Labels</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:Button ID="btnCourierRescrap" runat="server"
                                    Style="background-color: #FFFFFF; width: 15px; height: 15px; border: 1px solid #bdb5b5; margin-right: 10px;"
                                    OnClick="btnCourierRescrap_Click" ToolTip="Click For Filter" /><label>Scrap Durung
                                    Courier Receipt</label>
                            </div>
                            <div class="col-lg-3">
                                <asp:Button ID="btnScrap" runat="server"
                                    Style="background-color: #fbe3e4; width: 15px; height: 15px; border: 1px solid #bdb5b5; margin-right: 10px;"
                                    OnClick="btnScrap_Click" ToolTip="Click For Filter" /><label>Scrap at Pasting Time
                                </label>
                            </div>
                        </div>
                        <div class="app-table mt-2">
                            <div class="table-responsive">

                                <asp:GridView ID="Grdscrap" runat="server" AutoGenerateColumns="False"
                                    CssClass="table table-hover table-striped" DataKeyNames="ScrapeFlag,ff"
                                    EmptyDataText="Record Not Found">
                                    <Columns>

                                        <asp:TemplateField HeaderText="Serial Code">
                                            <ItemTemplate>
                                                <asp:Label ID="Label1SeNew" runat="server"
                                                    Text='<%# Bind("SerialCode") %>'></asp:Label>
                                                <asp:Label ID="lblactudate123nEW" CssClass="tr_line1" runat="server"
                                                    Width="5px" Visible="false" Text='<%# Bind("Series_Order") %>'>
                                                </asp:Label>
                                                <asp:Label ID="Label1Se" runat="server"
                                                    Text='<%# Bind("Series_Serial") %>' Width="5px" Visible="false">
                                                </asp:Label>
                                            </ItemTemplate>

                                            <ItemStyle />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Product Name">
                                            <ItemTemplate>
                                                <asp:Label ID="Label1SeNew4" runat="server"
                                                    Text='<%# Bind("Pro_Name") %>'></asp:Label>
                                            </ItemTemplate>

                                            <ItemStyle />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Status">
                                            <ItemTemplate>
                                                <asp:Label ID="Label1Status" runat="server"
                                                    Text='<%# Bind("ScrapeStatus") %>'></asp:Label>
                                            </ItemTemplate>

                                            <ItemStyle />
                                        </asp:TemplateField>
                                        <asp:TemplateField ItemStyle-HorizontalAlign="Center" Visible="false">
                                            <HeaderTemplate>
                                                <input id="chkselecth" name="chkselecth" type="checkbox"
                                                    onchange="checkAll(this.form,this.checked)" />
                                            </HeaderTemplate>
                                            <ItemTemplate>
                                                <% try {
                                                    ScrapeFlag=Convert.ToInt32(Grdscrap.DataKeys[index].Values["ScrapeFlag"].ToString());
                                                    } catch { } if (ScrapeFlag==1) { %>
                                                    <input id="Checkbox1" name="chkselect" checked="checked"
                                                        type="checkbox" value='<%# Eval("SerialCode") %>' />
                                                    <% } else { %>
                                                        <input id="chkselect" name="chkselect" type="checkbox"
                                                            value='<%# Eval("SerialCode") %>' />
                                                        <% } index++;%>
                                            </ItemTemplate>

                                            <ItemStyle HorizontalAlign="Center" Width="1%" />
                                        </asp:TemplateField>
                                    </Columns>

                                </asp:GridView>
                                <asp:Label ID="lblcode" Visible="false" runat="server"></asp:Label>
                                <asp:Label ID="lblfullcode" Visible="false" runat="server"></asp:Label>

                            </div>
                        </div>
                        </div>
                        <!--  -->
                    </div>
                </div>
            </div>
            <script type="text/javascript">
                function performSearch(searchText) {
                    $('#ctl00_ContentPlaceHolder1_Grdscrap tbody tr').each(function () {
                        var row = $(this);
                        var found = false;
                        row.find('td').each(function () {
                            var cellText = $(this).text().toLowerCase();
                            if (cellText.includes(searchText.toLowerCase())) {
                                found = true;
                                return false; // Exit the loop if found
                            }
                        });

                        if (found) {
                            row.show();
                        } else {
                            row.hide();
                        }
                    });
                }
            </script>

        </asp:Content>