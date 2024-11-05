<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="ManualPayout.aspx.cs" Inherits="Admin_ManualPayout" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <title></title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css" />
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.4/jquery.min.js"></script>

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
    <script src="js/date.format.js"></script>
    <script src="//cdn.rawgit.com/rainabba/jquery-table2excel/1.1.0/dist/jquery.table2excel.min.js"></script>


    <style type="text/css">
        .auto-style1 {
            width: 73px;
        }

        .auto-style2 {
            margin-right: 0px;
        }

        .sidebar + .main-content {
            padding: 20px;
        }

        .app-table table {
            margin-bottom: 20px !important;
        }

        .card-header {
            padding: .75rem 1.25rem;
            margin-bottom: 0;
            border-bottom: 1px solid #a36ae1;
            color: #FFF;
            background: -webkit-linear-gradient(180deg, rgb(73 141 247) 0%, rgb(167 105 224) 100%);
            background: linear-gradient(180deg, rgb(73 141 247) 0%, rgb(167 105 224) 100%);
        }

        .box_card .card-header .card-title {
            font-size: 1.4em;
        }

        .previous {
            background: -webkit-linear-gradient(180deg, rgb(73 141 247) 0%, rgb(167 105 224) 100%);
            background: linear-gradient(180deg, rgb(73 141 247) 0%, rgb(167 105 224) 100%);
            color: #FFF;
        }

        .next {
            background-color: #04AA6D;
            color: white;
        }

        .round {
            border-radius: 50%;
        }
    </style>
    <script type="text/javascript">
        function Export() {
            //$("#Interested").table2excel({
            //    // exclude CSS class
            //    exclude: ".noExl",
            //    name: "Worksheet Name",
            //    filename: "Interested",
            //    fileext: ".xls", // file extension
            //    preserveColors: true
            //});

            $("#ctl00_ContentPlaceHolder1_GridView1").table2excel({
                // exclude CSS class
                exclude: ".noExl",
                name: "Worksheet Name",
                filename: "ManualPayoutDetails",
                fileext: ".xls", // file extension
                preserveColors: true
            });
        };

        function FailureExport() {
            //$("#Interested").table2excel({
            //    // exclude CSS class
            //    exclude: ".noExl",
            //    name: "Worksheet Name",
            //    filename: "Interested",
            //    fileext: ".xls", // file extension
            //    preserveColors: true
            //});

            $("#ctl00_ContentPlaceHolder1_GridView2").table2excel({
                // exclude CSS class
                exclude: ".noExl",
                name: "Worksheet Name",
                filename: "FailurePayoutDetails",
                fileext: ".xls", // file extension
                preserveColors: true
            });
        };

    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
         <div class="col-md-12">

        <div class="col-sm-12">
            <h3 class="header blue lighter smaller">
                <img src="../images/demo.png" />Manual Payout Details
            </h3>
        </div>
     
    </div>
    <div class="col-md-12">
        <div class="col-lg-12" style="margin-top: 5px;">
            <asp:Label ID="lblMsg" runat="server" ></asp:Label>
        </div>
        <div class="col-lg-12" style="margin-top: 5px;">

            <div class="col-lg-3">

                 <span class="req"></span><label>From.</label>
                <br />
                <asp:TextBox ID="txtDateFrom" required="" runat="server" TextMode="Date" class="input-sm"> From Date. </asp:TextBox>


            </div>

              <div class="col-lg-2">

                 <span class="req"></span><label>To .</label>
                  <br />
                <asp:TextBox ID="txtDateTo" runat="server" required="" TextMode="Date" class="input-sm"> To Date. </asp:TextBox>


            </div>

              <div class="col-lg-3">

                 <span class="req"></span><label>Select Vendor</label>
                  <br />
              <asp:DropDownList ID="ddlcompid" runat="server"> 

                  <asp:ListItem>--Select--</asp:ListItem>
                  <asp:ListItem  Value="Comp-1274">JOHNSON PAINTS CO.</asp:ListItem>
                  <asp:ListItem Value="Comp-1707">DURGA COLOUR AND CHEM.P LTD.</asp:ListItem>
                   <asp:ListItem  Value="Comp-1723">CHERYL CHEMICAL AND POLYMERS</asp:ListItem>
                  

              </asp:DropDownList>


            </div>
          
         
    <div class="col-lg-1">
                <div class="merg_btn" style="margin-left:10%;">
                    
                  

                   
                    <asp:ImageButton ID="lnkfileDownload" CssClass="btn btn-primary" runat="server" ImageUrl="~/Content/images/demo.png"
                        ToolTip="Search Details" OnClick="lnkfileDownload_Click" />
                </div>
            </div>
          
        </div>
        <div class="clearfix"></div>
        <hr />

        <div class="col-lg-12" style="margin-top: 5px;">
          
              <div class="col-lg-4">

                    <asp:FileUpload ID="fl_CodeStatus" CssClass="form-control" runat="server" />
              </div>

              <div class="col-lg-4">
                <div class="merg_btn">
                    
                   

                   
                    <asp:ImageButton ID="imgbtnupload" CssClass="btn btn-primary" runat="server" ImageUrl="~/Content/images/upgrade.png"
                        ToolTip="Upload Statement" OnClick="imgbtnupload_Click" />
                </div>
            </div>

              <div class="col-lg-4" runat="server" id="payoutjpc">
                Hint : Sheet name should be as "Manualpayout.xlsx".
                <br />
                (<a href="../images/Transactions/Manualpayout.xlsx">Click here to download</a>)
            </div>
            <div class="col-lg-4" runat="server" id="payoutOther">
                Hint : Sheet name should be as "Manualpayout.xlsx".
                <br />
                (<a href="../images/Transactions/ManualpayoutAll.xlsx">Click here to download</a>)
            </div>

            
          
             
        </div>
         <div class="col-lg-12" style="margin-top: 5px;">
             <asp:Label ID="lbluploadmessage" runat="server" ></asp:Label>
         </div>

           <div class="clearfix"></div>
        <hr />
     
    </div>
    <div class="clearfix" style="height: 180px"></div>
    <div class="col-xs-12">
        <div class="row" id="SearchDataDiv" runat="server">
            <div class="col-xs-12">
                <div class="table-header">
                    <div style="float: left;">
                        <img src="../Content/images/regis_pro.png" />Search Details
                    </div>
                    <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 30px; width: auto; line-height: 22px;">
                       <asp:Label ID="lblcount" runat="server" style="color: #fff;">0</asp:Label>
                       
                    </div>
                    <div style="float:right;margin-right:20px;">
                                        <a href="javascript:void(0)" id="btnProductExport" onclick=" return Export();"><i class="fa fa-file-excel-o" style="color: #fff;font-size: 20px;margin-top: 10px;"></i></a>
                                    </div>
                  
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
                               

                                <asp:TemplateField HeaderText="Comp. Name">
                                    <ItemTemplate>
                                      
                                      <asp:Label ID="lblComp_Name" runat="server" Text='<%# Bind("Comp_Name") %>'></asp:Label>
                                        
                                    </ItemTemplate>

                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Record's In">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRecordsIn" runat="server" Text='<%# Bind("RecordsIn") %>'></asp:Label>
                                    </ItemTemplate>


                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="FilePath">
                                    <ItemTemplate>
                                         <a href="https://www.vcqru.com/<%# Eval("FilePath")%>">Downlaod Uploaded File</a>
                                      <%--  <asp:Label ID="lblFilePath" runat="server" Text='<%# Bind("FilePath") %>'></asp:Label>--%>
                                    </ItemTemplate>


                                </asp:TemplateField>
                                

                               <asp:TemplateField HeaderText="Payout Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblPayoutDate" runat="server" Text='<%# Bind("PayoutDate") %>'></asp:Label>
                                    </ItemTemplate>


                                </asp:TemplateField>
                                

                            </Columns>

                        </asp:GridView>
                    </div>

                </div>
            </div>
            <!-- /.span -->
        </div>


         <div class="row" id="FailureDiv" runat="server" visible="false">
            <div class="col-xs-12">
                <div class="table-header">
                    <div style="float: left;">
                        <img src="../Content/images/regis_pro.png" /> Failure Transaction Details
                    </div>
                    <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 30px; width: auto; line-height: 22px;">
                       <asp:Label ID="lblfailure" runat="server" style="color: #fff;">0</asp:Label>
                       
                    </div>
                    <div style="float:right;margin-right:20px;">
                                        <a href="javascript:void(0)" id="btnfailureProductExport" onclick=" return FailureExport();"><i class="fa fa-file-excel-o" style="color: #fff;font-size: 20px;margin-top: 10px;"></i></a>
                                    </div>
                  
                </div>

                <div class="table-responsive">
                    <div class="col-md-12">
                        <asp:Label ID="Label2" runat="server"></asp:Label>

                        <asp:GridView ID="GridView2" AllowPaging="true" AllowSorting="true" AutoGenerateColumns="false" runat="server" CssClass="table table-bordered table-hover table-condenced">
                            <HeaderStyle CssClass="tab-header" />
                            <Columns>

                                <asp:TemplateField HeaderText="S.No.">
                                    <ItemTemplate>
                                        <%#Container.DataItemIndex+1 %>
                                    </ItemTemplate>
                                </asp:TemplateField>
                               

                                <asp:TemplateField HeaderText="MobileNo">
                                    <ItemTemplate>
                                      
                                      <asp:Label ID="Label1" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                                        
                                    </ItemTemplate>

                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Amount">
                                    <ItemTemplate>
                                        <asp:Label ID="Label3" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
                                    </ItemTemplate>


                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="TransactionDate">
                                    <ItemTemplate>
                                        <asp:Label ID="Label4" runat="server" Text='<%# Bind("TransactionDate") %>'></asp:Label>
                                    </ItemTemplate>


                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Company Name.">
                                    <ItemTemplate>
                                        <asp:Label ID="Label5" runat="server" Text='<%# Bind("CompanyName") %>'></asp:Label>
                                    </ItemTemplate>


                                </asp:TemplateField>
                                
                                 <asp:TemplateField HeaderText="Remarks">
                                    <ItemTemplate>
                                        <asp:Label ID="Label6" runat="server" Text='<%# Bind("TranRemarks") %>'></asp:Label>
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

