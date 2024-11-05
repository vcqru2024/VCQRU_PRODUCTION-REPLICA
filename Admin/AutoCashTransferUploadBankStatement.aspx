<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="AutoCashTransferUploadBankStatement.aspx.cs" Inherits="Admin_AutoCashTransferUploadBankStatement" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <style type="text/css">
        .tab_regis {
            color: #2d2d2d;
            font-family: Arial,Helvetica,sans-serif;
            font-size: 8pt;
            font-weight: normal;
            line-height: 27px;
            margin: 5px auto;
        }

        .field_profile legend, .field_popup legend {
            /*background: rgba(0, 0, 0, 0) url("../images/search_icon.png") no-repeat scroll 3px center;*/
            color: #5f5f5f;
            font-family: Arial,Helvetica,sans-serif;
            font-size: 9pt;
            font-weight: bold;
            margin: 3px 20px 3px 13px;
            padding: 5px 5px 0 35px;
            border: 1px solid #e3e3e3;
            border-radius: 4px;
            width: 98%;
        }

        fieldset {
            border: 1px solid #ddd;
        }

        .toast {
            left: 50%;
            position: fixed;
            transform: translate(-50%, 0px);
            z-index: 9999;
        }
    </style>
    
      <script type="text/javascript">
        

          function Confirm() {


              var confirm_value = document.createElement("INPUT");
              confirm_value.type = "hidden";
              confirm_value.name = "confirm_value";
              
              if (confirm("Are you sure you want to proceed this action ?")) {
                  confirm_value.value = "Yes";
              } else {
                  confirm_value.value = "No";
              }
              document.forms[0].appendChild(confirm_value);
          }

      </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
    <div class="col-md-12">

        <div class="col-sm-12">
            <h3 class="header blue lighter smaller">
                <img src="../images/demo.png" />Upload Bank's Statement 
            </h3>
        </div>
        <%--<div class="col-sm-2">
            <h3 class="lighter smaller">
                <img src="../images/addadv.png" style="width: 25%" onclick="return avilablelabels();" />
            </h3>
        </div>--%>
    </div>
    <div class="col-md-12">
        <div class="col-lg-12" style="margin-top: 5px;">
            <asp:Label ID="lblMsg" runat="server"></asp:Label>
        </div>
        <div class="col-lg-12" style="margin-top: 5px;">
            <div class="col-lg-3">

                 <span class="req"></span><label>From Date</label>

                <asp:TextBox ID="txtDateFrom" runat="server" TextMode="Date" class="input-sm"> From </asp:TextBox>


            </div>

            <div class="col-lg-3">

                <span class="req"></span><label>To Date</label>
                <asp:TextBox ID="txtDateto" runat="server" TextMode="Date" class="input-sm"> To </asp:TextBox>


            </div>

     
            <div class="col-lg-3">
                <div class="merg_btn">
                   
                    

                    <asp:ImageButton ID="lnkfileDownload" CssClass="btn btn-primary" runat="server" ImageUrl="~/Content/images/demo.png"
                        ToolTip="Search Excel File" OnClick="lnkfileDownload_Click" />
                </div>
            </div>

             <div class="col-lg-3">
                <div class="merg_btn">
                   
                    

                     Hint : Sheet name should be as "AutoCashTransfer.xlsx" <br /> (<a href="../images/Transactions/AutoCashTransferFormat.xlsx">Click here to download</a>)
                </div>
            </div>
        </div>

    </div>
    <div class="clearfix" style="height: 180px"></div>
    <div class="col-xs-12">
        <div class="row">
            <div class="col-xs-12">
                <div class="table-header">
                    <div style="float: left;">
                        <img src="../Content/images/regis_pro.png" />File Details
                    </div>
                    <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 30px; width: auto; line-height: 22px;">
                       <asp:Label ID="lblcount" runat="server" style="color: #fff;">0</asp:Label>
                       
                    </div>
                    <%-- <div style="float: right">
                        <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 50px; width: auto; line-height: 22px;">
                            <img src="../Content/images/download.png" style="cursor: pointer" onclick="return Downloaddata();" />
                        </div>
                    </div>--%>
                </div>

                <div class="table-responsive">
                    <div class="col-md-12">
                        <asp:Label ID="lblpoint" runat="server"></asp:Label>

                        <asp:GridView ID="GridView1" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false" runat="server" OnPageIndexChanging="GridView1_PageIndexChanging" OnRowCommand="GridView1_RowCommand" OnRowEditing="GridView1_RowEditing" OnRowCancelingEdit="GridView1_RowCancelingEdit" OnRowDataBound="GridView1_RowDataBound" CssClass="table table-bordered table-hover table-condenced">
                            <HeaderStyle CssClass="tab-header" />
                            <Columns>

                                <asp:TemplateField HeaderText="S.No.">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                               

                                <asp:TemplateField HeaderText="Report Number">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hfReportNumber" runat="server" Value='<%# Bind("ReportNumber")%>'></asp:HiddenField>
                                       <%-- <asp:Label ID="lblReportNumber" runat="server" Text='<%# Bind("ReportNumber") %>'></asp:Label>--%>
                                        <asp:LinkButton ID="lnkbtnReportNumber" Text='<%# Bind("ReportNumber") %>' CommandArgument="<%# Container.DataItemIndex %>" CommandName="IndivisualDownLoad" runat="server"></asp:LinkButton>
                                    </ItemTemplate>

                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="TotalRecords">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTotalRecords" runat="server" Text='<%# Bind("TotalRecords") %>'></asp:Label>
                                    </ItemTemplate>


                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Total Amount">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTotalAmount" runat="server" Text='<%# Bind("TotalAmount") %>'></asp:Label>
                                    </ItemTemplate>


                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date Range">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDateRange" runat="server" Text='<%# Bind("DateRange") %>'></asp:Label>
                                    </ItemTemplate>


                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Need Approval">
                                    <ItemTemplate>
                                        <asp:Label ID="lblNeedApproval" runat="server" Text='<%# Bind("IsApproval") %>'></asp:Label>
                                    </ItemTemplate>

                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Is Approved">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsApproved" runat="server" Text='<%# Bind("IsApproved") %>'></asp:Label>
                                    </ItemTemplate>

                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Is Payout Released">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsPayoutReleased" runat="server" Text='<%# Bind("IsPayoutReleased") %>'></asp:Label>
                                    </ItemTemplate>

                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Released Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblReleasedDate" runat="server" Text='<%# Bind("FilegeneratedDate") %>'></asp:Label>
                                    </ItemTemplate>

                                </asp:TemplateField>

                                 <asp:TemplateField HeaderText="Uploaded File">
                                    <ItemTemplate>
                                        <asp:HiddenField ID="hfPayoutReleasedPath" runat="server" Value='<%# Bind("PayoutReleasedPath")%>'></asp:HiddenField>
                                        <a href="https://www.vcqru.com/<%# Eval("PayoutReleasedPath")%>">Downlaod</a>
                                        <%--<asp:Label ID="lblUploadedfile" runat="server" Text='<%# Bind("PayoutReleasedPath") %>'></asp:Label>--%>
                                    </ItemTemplate>

                                </asp:TemplateField>

                                 <asp:TemplateField HeaderText="Date & time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblDateNTime" runat="server" Text='<%# Bind("FilegeneratedDate") %>'></asp:Label>
                                    </ItemTemplate>

                                </asp:TemplateField>

                                 <asp:TemplateField HeaderText="Is Deleted">
                                    <ItemTemplate>
                                        <asp:Label ID="lblIsDeleted" runat="server" Text='<%# Bind("IsDelete") %>'></asp:Label>
                                    </ItemTemplate>

                                </asp:TemplateField>
                              
                                <asp:TemplateField HeaderText="Action">

                                    <ItemTemplate>

                                       <asp:FileUpload ID="flupload" CssClass="form-control" runat="server"/>
                                        <br />
                                         <asp:Button  ID="lnkbtnupload" OnClientClick="Confirm()" CssClass="btn btn-primary"  Text="Upload" CommandArgument='<%# Container.DataItemIndex %>' CommandName="UploadBankFile" runat="server"></asp:Button>
                                        <br />

                                       <asp:Label ID="lblfilepath" runat="server"></asp:Label>                 
                                    </ItemTemplate>
                                  
                                </asp:TemplateField>

                            </Columns>

                        </asp:GridView>
                    </div>

                </div>
            </div>
            <!-- /.span -->
        </div>
    </div>
    <div class="clearfix" style="height: 180px"></div>

</asp:Content>

