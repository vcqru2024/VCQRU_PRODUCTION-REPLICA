<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="AutoCashTransferDetails.aspx.cs" Inherits="Admin_AutoCashTransferDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

      <div class="breadcrumbs" id="breadcrumbs">
        <script type="text/javascript">
            try { ace.settings.check('breadcrumbs', 'fixed') } catch (e) { }
        </script>

        <ul class="breadcrumb">
            <li>
                <i class="ace-icon fa fa-home home-icon"></i>
                <a href="#">Home</a>
            </li>
            <li class="active">Auto Cash Transfer Details</li>
        </ul>
    </div>
    <div class="page-content">
        <!-- #section:settings.box -->
        <div class="ace-settings-container" id="ace-settings-container">
            <div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btn">
                <i class="ace-icon fa fa-cog bigger-150"></i>
            </div>

            <div class="ace-settings-box clearfix" id="ace-settings-box">
                <div class="pull-left width-50">
                    <!-- #section:settings.skins -->
                    <div class="ace-settings-item">
                        <div class="pull-left">
                            <select id="skin-colorpicker" class="hide">
                                <option data-skin="no-skin" value="#438EB9">#438EB9</option>
                                <option data-skin="skin-1" value="#222A2D">#222A2D</option>
                                <option data-skin="skin-2" value="#C6487E">#C6487E</option>
                                <option data-skin="skin-3" value="#D0D0D0">#D0D0D0</option>
                            </select>
                        </div>
                        <span>&nbsp; Choose Skin</span>
                    </div>

                    <!-- /section:settings.skins -->

                    <!-- #section:settings.navbar -->
                    <div class="ace-settings-item">
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-navbar" />
                        <label class="lbl" for="ace-settings-navbar">Fixed Navbar</label>
                    </div>

                    <!-- /section:settings.navbar -->

                    <!-- #section:settings.sidebar -->
                    <div class="ace-settings-item">
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-sidebar" />
                        <label class="lbl" for="ace-settings-sidebar">Fixed Sidebar</label>
                    </div>

                    <!-- /section:settings.sidebar -->

                    <!-- #section:settings.breadcrumbs -->
                    <div class="ace-settings-item">
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-breadcrumbs" />
                        <label class="lbl" for="ace-settings-breadcrumbs">Fixed Breadcrumbs</label>
                    </div>

                    <!-- /section:settings.breadcrumbs -->

                    <!-- #section:settings.rtl -->
                    <div class="ace-settings-item">
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl" />
                        <label class="lbl" for="ace-settings-rtl">Right To Left (rtl)</label>
                    </div>

                    <!-- /section:settings.rtl -->

                    <!-- #section:settings.container -->
                    <div class="ace-settings-item">
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-add-container" />
                        <label class="lbl" for="ace-settings-add-container">
                            Inside
										<b>.container</b>
                        </label>
                    </div>

                    <!-- /section:settings.container -->
                </div>
                <!-- /.pull-left -->

                <div class="pull-left width-50">
                    <!-- #section:basics/sidebar.options -->
                    <div class="ace-settings-item">
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-hover" />
                        <label class="lbl" for="ace-settings-hover">Submenu on Hover</label>
                    </div>

                    <div class="ace-settings-item">
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-compact" />
                        <label class="lbl" for="ace-settings-compact">Compact Sidebar</label>
                    </div>

                    <div class="ace-settings-item">
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-highlight" />
                        <label class="lbl" for="ace-settings-highlight">Alt. Active Item</label>
                    </div>

                    <!-- /section:basics/sidebar.options -->
                </div>
                <!-- /.pull-left -->
            </div>
            <!-- /.ace-settings-box -->
        </div>
        <!-- /.ace-settings-container -->

        <!-- /section:settings.box -->
        <div class="page-content-area">
            <div class="page-header">
                <h1>Code status & Ifsc code master</h1>
            </div>
            <!-- /.page-header -->
            <div class="row">

         
           <div class="page-header">
                <h1>Upload Code Status File</h1>
            </div>
                <div class="col-lg-12" style="margin-top: 50px">
                    
                     <div class="col-lg-4">
                        <span class="req"></span><label>Select payout released file</label><br />
                        <asp:DropDownList ID="ddlpayoutRelease" runat="server" class="input-sm">
                           
                            <asp:ListItem>All</asp:ListItem>
                        </asp:DropDownList>
                         <br />
                        Hint : To get code details. <br /> (<asp:LinkButton ID="lnkpayoutReleasedownlaod" runat="server" Text="Click here to download" OnClick="lnkpayoutReleasedownlaod_Click"></asp:LinkButton>)

</div>
                    
                    <div class="col-lg-4">
                        <asp:FileUpload ID="fl_CodeStatus" CssClass="form-control" runat="server" />
                        <br />
                        Hint : Sheet name should be as "Codestatus.xlsx". <br /> (<a href="../images/Transactions/CodeStatus.xlsx">Click here to download</a>)

                    </div>
                    <div class="col-lg-4">
                        <asp:Button ID="btncodestatus" runat="server" Text="Upload Excel File" CssClass="btn btn-primary" OnClick="btncodestatus_Click" /></div>
                    <div class="col-lg-2"></div>
                </div>
                <div class="col-lg-12" style="margin-top: 50px">
                     <asp:Label ID="lblcodestatus" runat="server"></asp:Label>
                </div>


                   <hr />
                <br />
                <hr />
           <div class="page-header">
                <h1>Upload IFSCcode Master File</h1>
            </div>
                <div class="col-lg-12" style="margin-top: 50px">
                    
                    
                    <div class="col-lg-4">
                        <asp:FileUpload ID="FileUpload1" CssClass="form-control" runat="server" />
                        <br />
                        Hint : Sheet name should be as "IFSCcodeMaster.xlsx". <br /> (<a href="../images/Transactions/IFSCcodeMasterDetails.xlsx">Click here to download</a>)

                    </div>
                    <div class="col-lg-4">
                        <asp:Button ID="Button1" runat="server" Text="Upload Excel File" CssClass="btn btn-primary" OnClick="Button1_Click" /></div>
                    <div class="col-lg-2"></div>
                </div>
                <div class="col-lg-12" style="margin-top: 50px">
                     <asp:Label ID="lblIfsccode" runat="server"></asp:Label>
                </div>

            </div>
        </div>
    </div>
</asp:Content>

