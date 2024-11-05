<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Transactions.aspx.cs" Inherits="Consumer_Transactions" %>

<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="System.Web.DataVisualization, Version=4.0.0.0, Culture=neutral, PublicKeyToken=31bf3856ad364e35" Namespace="System.Web.UI.DataVisualization.Charting" TagPrefix="asp" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>VCQRU | We secure you</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta http-equiv="X-UA-Compatible" content="IE=edge" />
    <meta name="description" content="" />
    <meta name="keywords" content="" />
    <meta name="author" content="codedthemes">
    <link rel="icon" href="../img-1/favicon.png" type="image/x-icon">
    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800&display=swap" rel="stylesheet">
    <link rel="stylesheet" type="text/css" href="../assetsfrui/icon/icofont/css/icofont.css" />
    <link rel="stylesheet" type="text/css" href="../assetsfrui/css/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../assetsfrui/icon/themify-icons/themify-icons.css" />
    <link rel="stylesheet" type="text/css" href="../assetsfrui/css/style.css" />

    <link href="../Content/css/toastr.min.css" rel="stylesheet" />
    <link rel="icon" href="../img-1/favicon.png" type="image/x-icon" />
    <link href="https://fonts.googleapis.com/css?family=Poppins:300,400,500,600,700,800&display=swap" rel="stylesheet" />
    <link rel="stylesheet" type="text/css" href="../assetsfrui/icon/icofont/css/icofont.css" />
    <link rel="stylesheet" type="text/css" href="../assetsfrui/css/bootstrap/css/bootstrap.min.css" />
    <link rel="stylesheet" type="text/css" href="../assetsfrui/icon/themify-icons/themify-icons.css" />
    <link rel="stylesheet" type="text/css" href="../assetsfrui/css/style.css" />
    <link href="../assets/css/font-awesome.min.css" rel="stylesheet" />
    <style>
        #nvh {
            background-color: #5da8ff;
        }

            #nvh ul li a {
                color: #fff;
            }

        .red {
            color: red !important;
        }

        #lblUser_name {
            color: #fff;
        }

        .list_items {
            width: calc(100% / 2) !important;
            padding-top: 20px;
            padding-bottom: 20px;
            text-align: center;
        }

        .chart_class {
            width: 75%;
            height: 50%;
        }

        .hide {
            display: none;
        }

        .paragraph {
            font-size: 12px !important;
            color: forestgreen !important;
        }

        .gift-containt {
            display: block;
            width: 75%;
            padding-left: 33px;
        }

        .transaction-details {
            color: gray;
            font-size: 15px;
            font-weight: normal;
            overflow: hidden;
            text-overflow: clip;
            white-space: nowrap;
        }

        .item-box {
            padding-left: 21px;
            padding-top: 23px;
            padding-bottom: 13px;
        }

        .coupen_panel {
            padding: 20px;
            display: inline-block;
            width: 100%;
            text-align: left;
        }

            .coupen_panel h4 {
                margin: 0px 0px 0px 0px;
                font-size: 31px;
            }

        b#pop5 {
            font-weight: 500;
            margin-left: 5px;
        }

        .coupen_details p {
            color: #646464;
            line-height: normal;
            margin-bottom: 14px;
        }

        img.succes_img {
            float: right;
            width: 82px;
            height: 51px;
            padding: 0px 15px;
        }

        .coupen_details {
            margin-top: 14px;
        }

            .coupen_details span.time {
                float: left;
                width: 100%;
                margin-top: 4px;
                margin-bottom: 4px;
            }

        p#pop3 {
            margin-bottom: 0px;
            font-weight: 600;
        }

        .modal-body hr {
            margin-top: 0px;
        }

        @media only screen and (min-width: 1400px) {
            .img_gift {
                height: 130px;
                width: 100%;
            }

            .img_gift_pen {
                width: 43%;
                height: 110px;
            }

            .transaction-details {
                color: gray;
                font-size: 15px;
                font-weight: normal;
            }
        }


        @media (min-width: 768px) {
            .img_gift {
                height: 150px;
                width: 100%;
            }

            .img_gift_speaker {
                width: 95%;
                height: 110px;
            }

            .img_gift_pen {
                width: 43%;
                height: 110px;
            }

            .transaction-details {
                color: gray;
                font-size: 15px;
                font-weight: normal;
            }
        }


        @media (max-width: 600px) {
            .img_gift {
                width: 100%;
            }

            .paragraph {
                font-size: x-small !important;
                color: forestgreen !important;
            }

            .img_gift_speaker {
                width: 118%;
                height: 48px;
            }

            .img_gift_pen {
                width: 43%;
                height: 67px;
            }

            .transaction-details {
                color: gray;
                font-size: 12px;
                font-weight: normal;
            }
        }
    </style>

    <style>
        /* Fullscreen overlay */
        #overlay {
            position: fixed;
            top: 0;
            left: 0;
            z-index: 10000; /* Higher than the modal z-index */
            width: 100vw; /* Ensure it covers the full width of the viewport */
            height: 100vh; /* Ensure it covers the full height of the viewport */
            display: none; /* Hidden by default */
            background: rgba(0, 0, 0, 0.6); /* Semi-transparent background */
        }

        /* Spinner wrapper */
        .cv-spinner {
            height: 100%;
            display: flex;
            justify-content: center;
            align-items: center;
        }

        /* Spinner styling */
        .spinner {
            width: 40px;
            height: 40px;
            border: 4px #ddd solid;
            border-top: 4px #2e93e6 solid;
            border-radius: 50%;
            animation: sp-anime 0.8s infinite linear;
        }

        /* Spinner animation */
        @keyframes sp-anime {
            100% {
                transform: rotate(360deg);
            }
        }
    </style>

   





</head>
<body>

    <form id="form1" runat="server">
        <asp:HiddenField ID="warrantycode" runat="server" />
        <asp:HiddenField ID="mmvalue" runat="server" />
        <cc1:ToolkitScriptManager
            runat="server"
            ID="ToolkitScriptManager1"
            ScriptMode="Release" />
        <!-- Pre-loader start -->
        <div class="theme-loader">
            <div class="loader-track">
                <div class="loader-bar"></div>
            </div>
        </div>
        <asp:HiddenField ID="page_width" runat="server" />
        <!-- Pre-loader end -->
        <div id="pcoded" class="pcoded">
            <div class="pcoded-overlay-box"></div>
            <div class="pcoded-container navbar-wrapper">

                <nav class="navbar header-navbar pcoded-header" id="nvh">
                    <div class="navbar-wrapper">
                        <div class="navbar-logo">

                            <div class="mobile-search">
                                <div class="header-search">
                                    <div class="main-search morphsearch-search">
                                        <div class="input-group">
                                            <span class="input-group-addon search-close"><i class="ti-close"></i></span>
                                            <input type="text" class="form-control" placeholder="Enter Keyword">
                                            <span class="input-group-addon search-btn"><i class="ti-search"></i></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="menu_toogle" style="display: none;">
                                <i class="ti-menu"></i>
                            </div>
                            <a href="dashboard.aspx" runat="server" id="logo">
                                <img class="img-fluid logo_img" runat="server" id="Complogo" src="../assetsfrui/images/auth/logo.png" />
                            </a>
                            <a class="mobile-options">
                                <i class="ti-more"></i>
                            </a>
                        </div>

                        <div class="navbar-container container-fluid">
                            <ul class="nav-left">
                                <%--<li>
								<a href="Codecheck.aspx">Check Code</a>
                           </li>--%>
                                <li>
                                    <a href="Dashboard.aspx"><i class="fa fa-tachometer" aria-hidden="true"></i>Dashboard</a>
                                </li>
                                <li>
                                    <a href="profile.aspx?ncjjh8"><i class="fa fa-users" aria-hidden="true"></i>Profile</a>
                                </li>
                                <li class="active">
                                    <a href="transactions.aspx"><i class="fa fa-money" aria-hidden="true"></i>Transactions</a>
                                </li>

                            </ul>
                            <ul class="nav-right">


                                <li class="user-profile header-notification">

                                    <asp:Image class="img-radius" alt="User-Profile-Image" ID="top_profile_img" runat="server" />
                                    <span>
                                        <asp:Label ID="lblUser_name" runat="server" /></span>
                                    <i class="ti-angle-down"></i>

                                    <ul class="show-notification profile-notification">
                                        <li>
                                            <a href="changepassword.aspx">
                                                <i class="ti-user"></i>Change Password
                                            </a>
                                        </li>

                                        <li>
                                            <i class="ti-layout-sidebar-left"></i>
                                            <asp:Button runat="server" BorderStyle="None" BackColor="Transparent" Text="Logout" OnClick="Logout" />

                                        </li>
                                    </ul>
                                </li>
                            </ul>
                        </div>
                    </div>
                </nav>
                <div class="pcoded-main-container">
                    <div class="pcoded-wrapper">

                        <div class="pcoded-content">
                            <div class="pcoded-inner-content">
                                <div class="main-body">
                                    <div class="page-wrapper">

                                        <div class="page-body">
                                            <div class="row">



                                                <!-- tabs card start -->
                                                <div class="col-sm-12">
                                                    <div class="card tabs-card">
                                                        <div class="card-block p-0">
                                                            <!-- Nav tabs -->
                                                            <ul class="nav nav-tabs md-tabs md-tabs1" role="tablist">
                                                                <li class="nav-item1" id="history_list">
                                                                    <a class="nav-link active" style="cursor: pointer" runat="server" data-toggle="tab" role="tab" id="History" onclick="transaction(this)"><i class="fa fa-home"></i>History</a>
                                                                    <div class="slide"></div>
                                                                </li>
                                                                <li class="nav-item1" id="summary_list">
                                                                    <a class="nav-link" data-toggle="tab" style="cursor: pointer" runat="server" role="tab" id="Summary" onclick="transaction(this)"><i class="fa fa-key" onclick="transaction(this)"></i>Summary</a>

                                                                    <div class="slide"></div>
                                                                </li>
                                                                <li class="nav-item1" id="claim_list" runat="server">
                                                                    <a class="nav-link" data-toggle="tab" style="cursor: pointer" runat="server" role="tab" id="Claim" onclick="transaction(this)"><i class="fa fa-play-circle" onclick="transaction(this)"></i>Claim</a>
                                                                    <div class="slide"></div>
                                                                </li>

                                                            </ul>
                                                            <center>
                                                                <asp:Label ID="term" Visible="false" CssClass="text-amazon" Text="<b>You can only avail of any offer & benefits after a month of your first scan.</b>" runat="server"></asp:Label></center>

                                                            <!-- Tab panes -->
                                                            <div class="tab-content card-block card-block_mob">
                                                                <div class="tab-pane active" id="pan_history" runat="server">

                                                                    <div id="JPC_Notes" runat="server" visible="false">
                                                                        <p style="text-align: center;">
                                                                            <b>Note : </b>Current balance and transactions reflect data for current financial year only. 
                                                                        </p>
                                                                    </div>

                                                                    <asp:Repeater ID="Repeater1" runat="server" OnItemDataBound="Repeater1_ItemDataBound">
                                                                        <ItemTemplate>
                                                                            <div class="statement" id="statement" runat="server" onclick="getaw(this)">
                                                                                <div class="company_logo" id="logo1" runat="server">
                                                                                    <img id="img" src='<%#"../img/product/"+Eval("Pro_id")+".jpg" %>' onerror="this.src='../img/product/imagefound.jpg';" runat="server" onclick="getaw(this)" />

                                                                                </div>
                                                                                <div id="chk123" class="company_text" runat="server" onclick="getaw(this)">

                                                                                    <span>
                                                                                        <asp:Label ID="comp_name" runat="server" Style="font-size: 15px" Text='<%#Eval("Comp_Name")%>' onClick="getaw(this)" /></span>
                                                                                    <small>
                                                                                        <asp:Label CssClass="transaction-details" ID="pro_name" runat="server" Text='<%#Eval("Pro_Name") %>' onClick="getaw(this)" />
                                                                                        <asp:Label CssClass="transaction-details" ID="trans_num" runat="server" Text='<%#Eval("trans_num") %>' onClick="getaw(this)" />
                                                                                    </small>
                                                                                    <small>
                                                                                        <asp:Label CssClass="transaction-details" ID="updthalf" runat="server" Text='<%#Eval("Updthalf") %>' onClick="getaw(this)" />
                                                                                        <asp:Label CssClass="transaction-details" ID="updtfull" Style="display: none" runat="server" Text='<%#Eval("Updtfull") %>' onClick="getaw(this)" />
                                                                                    </small>
                                                                                    <div class='<%#Eval("clr") %>' id="clrdiv">
                                                                                        <small>
                                                                                            <asp:Label Style="font-size: 12px; font-family: sans-serif; font-weight: normal"
                                                                                                ID="tr_message" runat="server" Text='<%#Eval("msg1").ToString().Replace("<product>",""+Eval("Pro_Name")).Replace("<company>",""+Eval("Comp_Name")).Replace("<date>",""+Eval("Enq_Date")) %>' onClick="getaw(this)" />
                                                                                            <asp:Label CssClass="transaction-details" Style="display: none" ID="tr_message2" runat="server" Text='<%#Eval("msg2").ToString().Replace("<product>",""+Eval("Pro_Name")).Replace("<company>",""+Eval("Comp_Name")).Replace("<date>",""+Eval("Enq_Date")) %>' onClick="getaw(this)" />
                                                                                        </small>

                                                                                        <small>
                                                                                            <%--Lubigen Start--%>
                                                                                            <asp:Label runat="server" ID="UPIID" Text='<%#Eval("UPIID")%>' Style="display: none" />
                                                                                            <asp:Label runat="server" ID="PaymentStatus" Text='<%#Eval("PaymentStatus")%>' Style="display: none" />
                                                                                            <asp:Label runat="server" ID="BankRefID" Text='<%#Eval("BankRefID")%>' Style="display: none" />
                                                                                            <asp:Label runat="server" ID="TransactionDate" Text='<%#Eval("TransactionDate")%>' Style="display: none" />
                                                                                            <asp:Label runat="server" ID="PaymentRemarks" Text='<%#Eval("PaymentRemarks")%>' Style="display: none" />
                                                                                            <%--Lubigen End--%>

                                                                                            <%--SRV1029--%>
                                                                                            <asp:Label runat="server" ID="UPI_ID" Text='<%#Eval("UPI_ID")%>' Style="display: none" />
                                                                                            <asp:Label runat="server" ID="UPI_OrderID" Text='<%#Eval("OrderID")%>' Style="display: none" />
                                                                                            <asp:Label runat="server" ID="UPI_Status" Text='<%#Eval("Status")%>' Style="display: none" />
                                                                                            <asp:Label runat="server" ID="UPI_Remarks" Text='<%#Eval("Remarks")%>' Style="display: none" />
                                                                                            <%--SRV1029--%>
                                                                                        </small>
                                                                                        <small>
                                                                                            <asp:Label ID="tr_status" Style="display: none" runat="server" Text='<%#Eval("tr_status") %>' onClick="getaw(this)" /></small>

                                                                                        <small>
                                                                                            <asp:Label ID="code" Style="display: none" runat="server" Text='<%#Eval("code1")+""+Eval("code2") %>' onClick="getaw(this)" />
                                                                                            <asp:Label runat="server" ID="serviceid" Text='<%#Eval("service_id")%>' Style="display: none" />
                                                                                            <%--//Added by BIpin for Hypersonic--%>
                                                                                            <asp:Label runat="server" ID="vehicleno" Text='<%#Eval("vehicleno")%>' Style="display: none" />
                                                                                            <asp:Label runat="server" ID="device" Text='<%#Eval("device")%>' Style="display: none" />
                                                                                            <%--//Added by BIpin for Hypersonic--%>
                                                                                            <asp:Label runat="server" ID="purchasedate" Text='<%#Eval("PurchaseDate")%>' Style="display: none" />
                                                                                            <asp:Label runat="server" ID="warrantyexpiredate" Text='<%#Eval("ExpirationDate")%>' Style="display: none" />
                                                                                            <asp:Label runat="server" ID="warrrantyperiod" Text='<%#Eval("WarrantyPeriod")%>' Style="display: none" />
                                                                                            <asp:Label runat="server" ID="numberofdays" Text='<%#Eval("NumberofDays")%>' Style="display: none" />
                                                                                            <asp:Label runat="server" ID="claimstatus" Text='<%#Eval("iswarrantyclaimed")%>' Style="display: none" />
                                                                                            <asp:Label runat="server" ID="user_comment" Text='<%#Eval("comment")%>' Style="display: none" />
                                                                                            <asp:Label runat="server" ID="vendorcomment" Text='<%#Eval("vendorcomments")%>' Style="display: none" />
                                                                                            <asp:Label runat="server" ID="vendorclaimstatus" Text='<%#Eval("vendorclaimstatus")%>' Style="display: none" />
                                                                                            <asp:Label runat="server" ID="customer_bill" Text='<%#Eval("BillNo")%>' Style="display: none" />
                                                                                            <asp:Label runat="server" ID="bill_path" Text='<%#Eval("imagepathbill")%>' Style="display: none" />
                                                                                            <asp:Label runat="server" ID="warranty_id" Text='<%#Eval("warranty_id")%>' Style="display: none" />
                                                                                        </small>
                                                                                    </div>
                                                                                </div>
                                                                                <asp:Label runat="server" ID="claimbutton" CssClass="btn btn-success btn-outline-success" Style="font-size: xx-small !important; font-weight: 600" Text="Claim" onclick="getaw(this)" />
                                                                                <div class='<%# Eval("cls") %>' id="company_amt" runat="server" onclick="getaw(this)">

                                                                                    <span><span id="sign" runat="server"><%# Eval("_sign")%> </span>
                                                                                        <asp:Label Style="display: none" ID="currency" runat="server" Text='<%#Eval("cureency")%>' />
                                                                                        <asp:Label ID="Label2" Style="font-size: 18px; font-family: Consolas; font-weight: normal"
                                                                                            runat="server" Text='<%#Eval("currency_sign")%>' onClick="getaw(this)" />
                                                                                        <asp:Label Style="font-size: 18px; font-family: Arial; font-weight: normal" ID="loyalty" runat="server" Text='<%#Eval("Loyalty") %>' onClick="getaw(this)" /></span>


                                                                                </div>
                                                                            </div>
                                                                        </ItemTemplate>


                                                                    </asp:Repeater>

                                                                    <div class="text-center fotter_btn">
                                                                        <asp:Button runat="server" ID="Transactionload" CssClass="btn btn-outline-primary btn-round btn-sm" Text="View More" OnClick="Transactionload_Click5" />
                                                                    </div>

                                                                </div>
                                                                <div class="tab-pane" id="pan_Summary" runat="server">

                                                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                                        <ContentTemplate>
                                                                            <asp:Button runat="server" ID="call_Summary" Style="display: none" OnClick="call_Summary_Click" />
                                                                            <asp:Button runat="server" ID="Button1" OnClick="call_Summary_Click" Style="display: none" />
                                                                            <%--<div class="row">
  
<div class="form-group col-md-5">
    
<label class="col-sm-12 col-form-label custom_label">Service /Code check Summary</label>
    <asp:Chart ID="chartService_code" runat="server" style="width:330px; height:330px">
        <Series>
            <asp:Series Name="Series1" Legend="Legend1"></asp:Series>
        </Series>
        
        <ChartAreas>
            <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
        </ChartAreas>
        <Legends>
            <asp:Legend Name="Legend1" Docking="Bottom">
            </asp:Legend>
            
        </Legends>
    </asp:Chart>
</div>

<div class="form-group col-md-2 custom_labediv">
<label class="col-sm-4 col-form-label custom_labe2"></label>
 
</div>
    <div class="form-group col-md-5">
    
<label class="col-sm-12 col-form-label custom_label">Loyalty Won Summary</label>
  <asp:Chart ID="Chartloyalty_won" runat="server" style="width:330px; height:330px">
        <Series>
            <asp:Series Name="Series1" Legend="Legend1"></asp:Series>
        </Series>
        <ChartAreas>
            <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
        </ChartAreas>
        <Legends>
            <asp:Legend Name="Legend1" Docking="Bottom">
            </asp:Legend>
            
        </Legends>
    </asp:Chart>
</div>

</div>--%>
                                                                            <%--<div class="row">
    <asp:Button runat="server" ID="Button2" OnClick="call_Summary_Click" style="display:none" />
<div class="form-group col-md-5">
    
<label class="col-sm-12 col-form-label custom_label">Comapny /Code check Summary</label>
    <asp:Chart ID="ChartCompany_code" runat="server" style="width:330px; height:330px" Palette="Excel">
        <Series>
            <asp:Series Name="Series1" Legend="Legend1"></asp:Series>
        </Series>
        <ChartAreas>
            <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
        </ChartAreas>
        <Legends>
            <asp:Legend Name="Legend1" Docking="Bottom">
            </asp:Legend>
            
        </Legends>
    </asp:Chart>
</div>
<div class="form-group col-md-2 custom_labediv">
<label class="col-sm-4 col-form-label custom_labe2"></label>
 
</div>
    <div class="form-group col-md-5">
    
<label class="col-sm-12 col-form-label custom_label">Code Summary</label>
  <asp:Chart ID="Chartcode" runat="server" style="width:330px; height:330px" Palette="Chocolate">
        <Series>
            <asp:Series Name="Series1" Legend="Legend1"></asp:Series>
        </Series>
        <ChartAreas>
            <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
        </ChartAreas>
        <Legends>
            <asp:Legend Name="Legend1" Docking="Bottom">
            </asp:Legend>
            
        </Legends>
    </asp:Chart>
</div>

</div>--%>
                                                                            <div class="row">
                                                                                <asp:Button runat="server" ID="Button3" OnClick="call_Summary_Click" Style="display: none" />
                                                                                <div class="col-sm-12">
                                                                                    <asp:Label ID="No_record" runat="server" Text="No Record found for Summary." Visible="false" />
                                                                                    <asp:Chart ID="Chartyearlycode" runat="server" Visible="false">

                                                                                        <ChartAreas>
                                                                                            <asp:ChartArea Name="ChartArea1"></asp:ChartArea>
                                                                                        </ChartAreas>
                                                                                        <Legends>
                                                                                            <asp:Legend Name="Legend1" Docking="Bottom">
                                                                                            </asp:Legend>

                                                                                        </Legends>
                                                                                        <Titles>
                                                                                            <asp:Title Docking="Left" Name="Title1" Text="Code Checked">
                                                                                            </asp:Title>
                                                                                            <asp:Title Docking="Bottom" Name="Title2" Text="Companies">
                                                                                            </asp:Title>
                                                                                            <asp:Title Docking="Top" Name="Title3" Text="Loyalty Won">
                                                                                            </asp:Title>

                                                                                        </Titles>
                                                                                    </asp:Chart>

                                                                                </div>





                                                                            </div>


                                                                        </ContentTemplate>
                                                                    </asp:UpdatePanel>

                                                                </div>

                                                                <div class="tab-pane" id="pan_Claim" runat="server">
                                                                    <div id="overlay">
                                                                        <div class="cv-spinner">
                                                                            <span class="spinner"></span>
                                                                        </div>
                                                                    </div>
                                                                    <asp:UpdatePanel ID="UpdatePanel3" runat="server" UpdateMode="Conditional" ChildrenAsTriggers="true">
                                                                        <ContentTemplate>

                                                                            <asp:Button ID="btnshowclm" runat="server" OnClick="btnshowclm_Click" Style="display: none;" />
                                                                            <asp:Button ID="Button2" runat="server" OnClick="btnshowclm_Click" Style="display: none;" />

                                                                            <%--<div class="row" id="divclaim" runat="server" visible="false">--%>

                                                                            <%-- <div id="paytm" runat="server" class="card borderless-card" style="display:none">--%>
                                                                            <div id="paytm" runat="server" class="card borderless-card" visible="false">
                                                                                <div class="card-block success-breadcrumb gift-two">
                                                                                    <div class="row">
                                                                                        <div class="col-lg-3 col-md-3 mb-3">
                                                                                            <div>
                                                                                                <img src="../images/Gift/paytm.png" class="img_gift img-fluid" />
                                                                                            </div>
                                                                                        </div>
                                                                                        <div class="col-lg-2 col-md-2 mb-3">
                                                                                            <h5>You are eligible to Claim
                                                                                            <br />
                                                                                                <asp:Label ID="lblcur" runat="server" Text=""></asp:Label>&nbsp;<asp:Label ID="lblptmp" runat="server" Text=""></asp:Label></h5>
                                                                                        </div>
                                                                                        <div class="col-lg-4 col-md-4 mb-3">
                                                                                            <div>
                                                                                                <asp:Label ID="lblrp" runat="server" Text="" Visible="false"></asp:Label>
                                                                                                <asp:Label ID="lbltp" runat="server" Text="" Visible="false"></asp:Label>
                                                                                                <asp:LinkButton runat="server" ID="btnptmp" ClientIDMode="Static" CausesValidation="false" CssClass="btn btn-info btn-round" Style="vertical-align: central; color: #FF5370; background-color: white; border-color: white; float: right;" Text="Claim" OnClick="btnptmp_Click"></asp:LinkButton>
                                                                                                <asp:Label ID="lblptmm" runat="server" Text="" Visible="false"></asp:Label>
                                                                                                <asp:HiddenField ID="hcc" runat="server" />
                                                                                                <asp:HiddenField ID="totalpoints" runat="server" />
                                                                                            </div>
                                                                                        </div>

                                                                                    </div>


                                                                                </div>
                                                                            </div>

                                                                            <asp:Repeater ID="Repeater2" runat="server">
                                                                                <ItemTemplate>
                                                                                    <div class="card borderless-card">
                                                                                        <div class="card-block success-breadcrumb gift-one">
                                                                                            <div class="row">
                                                                                                <div class="col-lg-3 col-md-3 mb-3">
                                                                                                    <div>
                                                                                                        <img src='<%#Eval("Gift_image")%>' runat="server" class="img_gift img-fluid" />
                                                                                                    </div>
                                                                                                </div>
                                                                                                <div class="col-lg-2 col-md-2 mb-3">
                                                                                                    <h5>
                                                                                                        <asp:Label ID="heading" runat="server" Text='<%#Eval("Gift_name")%>'></asp:Label>
                                                                                                        <br />
                                                                                                        <asp:Label ID="lblcur" runat="server" Text=""></asp:Label>&nbsp;<asp:Label ID="lblptmp" runat="server" Style="font-size: small;" Text='<%#Eval("Gift_value")%>'></asp:Label><asp:Label runat="server" Style="font-size: small;" Text=" Pts"></asp:Label></h5>
                                                                                                </div>
                                                                                                <div class="col-lg-4 col-md-4 mb-3">
                                                                                                    <div id="DivPointClaim" runat="server" visible="false">
                                                                                                        <asp:CheckBox ID="ChkMoile" runat="server" Text="Mobile No." AutoPostBack="true" OnCheckedChanged="ChkMoile_CheckedChanged" Checked="true" />
                                                                                                        &nbsp;&nbsp;&nbsp;&nbsp;
                                                                                                         <asp:CheckBox ID="ChkUpiId" runat="server" Text="Upi Id" OnCheckedChanged="ChkUpiId_CheckedChanged" AutoPostBack="true" />

                                                                                                        <div style="display: block; width: 100%" id="DivPointClaimMobile" runat="server" visible="false">


                                                                                                            <asp:TextBox ID="txtMobileNo" CssClass="form-control" placeholder="Enter Mobile Number" MaxLength="10" runat="server"></asp:TextBox>
                                                                                                            <br />
                                                                                                            Note : Please enter correct UPI ID/ Mobile no. linked to UPI to avoid transaction failure.
                                                                                                        </div>

                                                                                                        <div style="display: block; width: 100%" id="DivPointClaimUpi" runat="server" visible="false">


                                                                                                            <asp:TextBox ID="txtUpiId" CssClass="form-control" placeholder="Enter UPI ID " MaxLength="99" runat="server"></asp:TextBox>
                                                                                                            <br />
                                                                                                            Note : Please enter correct UPI ID/ Mobile no. linked to UPI to avoid transaction failure.
                                                                                                        </div>



                                                                                                    </div>

                                                                                                    <%--UPI Start--%>
                                                                                                    <div style="display: block; width: 100%" id="DivPointClaim_UPI" runat="server" visible="false">





                                                                                                        <div style="display: block; width: 100%" id="Div3" runat="server">


                                                                                                            <asp:TextBox ID="txtUpiId_UPI" CssClass="form-control" placeholder="Enter UPI ID " MaxLength="50" runat="server"></asp:TextBox>
                                                                                                            <br />
                                                                                                            Note : Please check correct UPI ID linked to UPI to avoid transaction failure.
                                                                                                        </div>

                                                                                                    </div>
                                                                                                    <%--UPI End--%>
                                                                                                </div>
                                                                                                <div class="col-lg-3 col-md-3 mb-3">
                                                                                                    <div class="text-center">
                                                                                                        <asp:Label ID="lblrp" runat="server" Text='<%#Eval("Gift_value")%>' Visible="false"></asp:Label>
                                                                                                        <asp:Label ID="lbltp" runat="server" Text="" Style="display: none"></asp:Label>
                                                                                                        <asp:LinkButton runat="server" ID="btnptmp" CausesValidation="false" CssClass="btn btn-info btn-round" Style="vertical-align: central; color: #FF5370; background-color: white; border-color: white;" Text="Claim" OnClick="btnptmp_Click1" Visible="false"></asp:LinkButton>
                                                                                                        <asp:LinkButton runat="server" ID="btnpointClaim" CausesValidation="false" CssClass="btn btn-info btn-round" Style="vertical-align: central; color: #FF5370; background-color: white; border-color: white;" Text="Claim" OnClick="btnpointClaim_Click" Visible="false"></asp:LinkButton>

                                                                                                        <asp:LinkButton runat="server" ID="btnpointClaim_UPI" ClientIDMode="Static" CausesValidation="false" CssClass="btn btn-info btn-round btn-loader" Style="vertical-align: central; color: #FF5370; background-color: white; border-color: white; float: right;" Text="Claim" OnClick="btnpointClaim_UPI_Click" OnClientClick="showLoader();" Visible="false"></asp:LinkButton>
                                                                                                        <asp:Label ID="lblptmm" runat="server" Text='<%#Eval("gift_message")%>' Visible="true"></asp:Label>
                                                                                                        <asp:HiddenField ID="hcc" runat="server" />
                                                                                                    </div>
                                                                                                </div>
                                                                                            </div>

                                                                                        </div>
                                                                                    </div>
                                                                                </ItemTemplate>
                                                                            </asp:Repeater>
                                                                            <%-- <div class="card borderless-card">
                                                                                <div class="card-block danger-breadcrumb" style="display: flex; padding-right: 5px;">

                                                                                    <div style="display: block; width: 15%">
                                                                                        <img src="../images/Gift/led.png" class="img_gift" />
                                                                                    </div>
                                                                                    <div class="gift-containt">
                                                                                        <h5>JBL Bluetooth Headset(<asp:Label ID="lblbheadp" runat="server" Text="50000"></asp:Label>
                                                                                            Pts)</h5>
                                                                                        <div style="width: 100%; display: flex;">
                                                                                            <h6 style="width: 40%">Model: T450BT</h6>
                                                                                            <div style="display: block; width: 100%; padding-right: 31px; padding-left: 50px; padding-top: 21px;"></div>
                                                                                            <div style="display: block; width: 60%; padding-right: 31px; padding-left: 50px; padding-top: 21px; float: right;">
                                                                                                <asp:Button runat="server" ID="btnbheadp" CssClass="btn btn-info btn-round" Style="vertical-align: central; color: #FF5370; background-color: white; border-color: white; float: right;" Text="Claim" OnClick="Unnamed_Click" />
                                                                                                <asp:Label ID="lblbhmsg" runat="server" Text="" Visible="false"></asp:Label>
                                                                                            </div>



                                                                                        </div>
                                                                                    </div>


                                                                                </div>
                                                                            </div>

                                                                            <div class="card borderless-card" style="display: block">
                                                                                <div class="card-block primary-breadcrumb" style="display: flex; padding-right: 5px;">
                                                                                    <div style="display: block; width: 15%">
                                                                                        <img src="../images/Gift/watch.png" class="img_gift" style="width: 80%">
                                                                                    </div>
                                                                                    <div class="gift-containt">
                                                                                        <h5>Casio G-Shock(<asp:Label ID="lblcgshockp" runat="server" Text="21000"></asp:Label>Pts)</h5>
                                                                                        <div style="width: 100%; display: flex;">
                                                                                            <h6 style="width: 40%">Model: GA-100CF</h6>
                                                                                            <div style="display: block; width: 100%; padding-right: 31px; padding-left: 50px; padding-top: 21px;"></div>
                                                                                            <div style="display: block; width: 60%; padding-right: 31px; padding-left: 50px; padding-top: 21px; float: right;">
                                                                                                <asp:Button runat="server" class="btn btn-info btn-round" ID="btncgshockp" Style="vertical-align: central; color: #4099ff; background-color: white; border-color: white; float: right;" Text="Claim" OnClick="Unnamed_Click1" />
                                                                                                <asp:Label ID="lblcgshock" runat="server" Text="" Visible="false"></asp:Label>
                                                                                            </div>



                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>

                                                                            <div class="card borderless-card">
                                                                                <div class="card-block info-breadcrumb" style="display: flex; padding-right: 5px;">
                                                                                    <div style="display: block; width: 15%">
                                                                                        <img src="../images/Gift/headphones.png" class="img_gift" />
                                                                                    </div>
                                                                                    <div class="gift-containt">
                                                                                        <h5>JBL Bluetooth Headset(<asp:Label ID="lbljbhp" runat="server" Text="15000"></asp:Label>Pts)</h5>
                                                                                        <div style="width: 100%; display: flex;">
                                                                                            <h6 style="width: 40%">Model: T450BT</h6>
                                                                                            <div style="display: block; width: 100%; padding-right: 31px; padding-left: 50px; padding-top: 21px;"></div>
                                                                                            <div style="display: block; width: 60%; padding-right: 31px; padding-left: 50px; padding-top: 21px; float: right;">
                                                                                                <asp:Button ID="btnjbhp" runat="server" class="btn btn-info btn-round" Style="vertical-align: central; color: #00bcd4; background-color: white; border-color: white; float: right;" Text="Claim" OnClick="Unnamed_Click2" />
                                                                                                <asp:Label ID="lbljbhm" runat="server" Text="" Visible="false"></asp:Label>
                                                                                            </div>



                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>

                                                                            <div class="card borderless-card">
                                                                                <div class="card-block warning-breadcrumb" style="display: flex; padding-right: 5px;">
                                                                                    <div style="display: block; width: 15%">
                                                                                        <img src="../images/Gift/speaker.png" class="img_gift_speaker">
                                                                                    </div>
                                                                                    <div class="gift-containt">
                                                                                        <h5>JBL Bluetooth Speaker(<asp:Label ID="lbljbsp" runat="server" Text="7000"></asp:Label>Pts)</h5>
                                                                                        <div style="width: 100%; display: flex;">
                                                                                            <h6 style="width: 40%">Model: Charge 4</h6>
                                                                                            <div style="display: block; width: 100%; padding-right: 31px; padding-left: 50px; padding-top: 21px;"></div>
                                                                                            <div style="display: block; width: 60%; padding-right: 31px; padding-left: 50px; padding-top: 21px; float: right;">
                                                                                                <asp:Button ID="btnjbsp" runat="server" class="btn btn-info btn-round" Style="vertical-align: central; color: #f1c40f; background-color: white; border-color: white; float: right;" Text="Claim" OnClick="Unnamed_Click3" />
                                                                                                <asp:Label ID="lbljbsm" runat="server" Text="" Visible="false"></asp:Label>
                                                                                            </div>



                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>

                                                                            <div class="card borderless-card">
                                                                                <div class="card-block success-breadcrumb" style="display: flex; padding-right: 5px;">
                                                                                    <div style="display: block; width: 15%">
                                                                                        <img src="../images/Gift/pen.png" class="img_gift_pen">
                                                                                    </div>
                                                                                    <div class="gift-containt">
                                                                                        <h5>Parker Pen(<asp:Label ID="lblppp" runat="server" Text="2000"></asp:Label>Pts)</h5>
                                                                                        <div style="width: 100%; display: flex;">
                                                                                            <h6 style="width: 40%">Model: CT (systemark)</h6>
                                                                                            <div style="display: block; width: 100%; padding-right: 31px; padding-left: 50px; padding-top: 21px;"></div>
                                                                                            <div style="display: block; width: 60%; padding-right: 31px; padding-left: 50px; padding-top: 21px; float: right;">
                                                                                                <asp:Button ID="btnppp" runat="server" class="btn btn-info btn-round" Style="vertical-align: central; color: #2ed8b6; background-color: white; border-color: white; float: right;" Text="Claim" OnClick="Unnamed_Click4" />
                                                                                                <asp:Label ID="lblppm" runat="server" Text="" Visible="false"></asp:Label>
                                                                                            </div>



                                                                                        </div>
                                                                                    </div>
                                                                                </div>
                                                                            </div>--%>
                                                                        </ContentTemplate>
                                                                        <Triggers>
                                                                            <asp:AsyncPostBackTrigger ControlID="btnshowclm" EventName="Click" />
                                                                            <asp:AsyncPostBackTrigger ControlID="btnptmp" EventName="Click" />

                                                                        </Triggers>

                                                                    </asp:UpdatePanel>
                                                                </div>


                                                            </div>


                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <!-- tabs card end -->


                                        </div>
                                    </div>

                                    <div id="styleSelector">
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <%--Chat modal start --%>
        <%--<div class="modal fade right" style="z-index:9999999999" id="modalComment" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
  aria-hidden="true">
  <div class="modal-dialog modal-side modal-bottom-right modal-notify modal-info" role="document">
    <!--Content-->
    <div class="modal-content">
      <!--Header-->
      <div class="modal-header">
        <p class="heading">Commets
        </p>

        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true" class="white-text">&times;</span>
        </button>
      </div>
         <div class="modal-body">

        <div class="row">
         
          <div class="col-9">
              <h6>User: </h6>
            <p id="warrantyuserComment"></p>

              <h6>Vendor:</h6>
            <p id="warrantyvendorcommentchat"></p>
          </div>
        </div>
      </div>

      <!--Footer-->
      <div class="modal-footer justify-content-center">
        <a class="btn btn-info" data-dismiss="modal" >Close</a>
     
      </div>
    </div>
    <!--/.Content-->
  </div>
</div>--%>
        <%--Chat modal End --%>

        <%-- Claim modal start --%>
        <div class="modal fade" id="Claimmodal" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
            <div class="modal-dialog modal-dialog-centered" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h4 class="modal-title" id="smallModalLabel">Upload Product Image (VCQRU)</h4>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <p id="pbrowse1">
                            <b style="color: black">To Upload Image * </b>&nbsp;<input type="file" accept="image/*" name="name" id="productupload_warr" value="" style="display: none" multiple /><a id="imageupload" onclick="callfileupload()" style="text-decoration: underline; cursor: pointer">Click Here</a>
                            <div style="color: gray" id="filelist"></div>
                            <hr />
                            <p class="paragraph">
                                Note: Upload maximum 5 images covering all angles of damaged part.<br />
                                Images should be clear, Size limit:400kb per image.
                            </p>
                            <br />
                            <b style="color: black">Comments *</b>&nbsp;&nbsp;<span style="font-size: 12px; color: forestgreen">(Max: 150 words)</span>&nbsp;&nbsp;<span id="spanEmail" style="color: black;"></span>
                            <input type="text" id="wrr_Comments_id" placeholder="Comments" name="Comments" maxlength="150" data-msg-required="Please enter your comments." class="form-control"><br />

                        </p>
                    </div>
                    <div class="modal-footer">
                        <input type="button" name="name22" class="btn btn-primary" id="btnbrowsesave" value="submit" data-dismiss="modal" onclick="save();" />

                    </div>
                </div>
            </div>
        </div>

        <%-- Claim Modal End --%>



        <!-- Button trigger modal -->

        <!-----Issue Modal start-->
        <div class="modal fade" id="IssueModal" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <div class="modal-content">
                    <div class="modal-header" style="padding-bottom: 2rem">
                        <%--<button type="button" class="close" data-dismiss="modal">&times;</button>--%>
                        <h4 class="modal-title" style="float: left; position: absolute;">Report An Issue</h4>
                    </div>
                    <%--<div class="modal-body">--%>

                    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                        <ContentTemplate>
                            <br />

                            <asp:TextBox ID="Report" onkeyDown="checkTextAreaMaxLength(this,event,'250');" placeholder="Enter Your Query...." Style="width: 98%; border-style: none; font-family: Arial; font-weight: 400; margin-top: -15px; margin-left: 5px; margin-bottom: -7px" Height="70px" runat="server" TextMode="MultiLine"></asp:TextBox>


                            <br />
                            <div id="Report_message" class="alert alert-success" role="alert" runat="server" style="width: 100%">
                                <p>
                                    <%--<asp:Label ID="LblMsgUpdateupld" runat="server"></asp:Label>--%>
                                </p>
                            </div>
                            <%--<asp:Label runat="server" ID="lblreport" style="padding-left:2rem"></asp:Label>--%>
                            <div class="modal-footer">

                                <asp:Button runat="server" ID="btnreport" type="button" class="btn btn-primary waves-effect waves-light m-r-20" Text="Submit" OnClick="btnreport_Click" />
                                <button class="btn btn" data-dismiss="modal">Close</button>
                            </div>

                        </ContentTemplate>
                    </asp:UpdatePanel>
                </div>

            </div>
        </div>




        <!----- Issue Modal end----->



        <!-- Modal -->




        <div class="modal fade" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">

                <div class="modal-content">
                    <div class="coupen_panel" style="padding: 20px">
                        <img class="succes_img" id="pop_img" src="../img/checkmark.png">
                        <span class="gray" id="pop1" style="font-size: 17px"></span>
                        <span id="Bill" style="font-size: medium; color: black; position: fixed; right: 10px; top: 86px;"></span>
                        <h4 id="pop2" style="font-family: Consolas"></h4>
                        <div class="coupen_details">
                            <span>
                                <p id="code">Code:</p>
                                <b id="pop5"></b></span>
                            <%--Lubigen start--%>
                            <br />
                            <span>
                                <p id="UPIID">UPI Id: </p>
                                <b id="UPIIDval"></b></span>
                            <br />
                            <span>
                                <p id="PaymentStatus">Payment Status: </p>
                                <b id="PaymentStatusval"></b></span>
                            <br />
                            <span>
                                <p id="BankRefID">Bank Ref. ID: </p>
                                <b id="BankRefIDval"></b></span>
                            <br />
                            <span class="time">
                                <p id="TransactionDate">Transaction Date: </p>
                                <b id="TransactionDateval"></b></span>
                            <br />
                            <span>
                                <p id="PaymentRemarks">Payment Remarks: </p>
                                <b id="PaymentRemarksval"></b></span>

                            <%--Lubigen end--%>

                            <asp:HiddenField ID="code_value" runat="server" />
                            <span class="time" id="pop4"></span>
                            <%--Hypersoic--%>
                            <p id="vehicleno" class="hide" style="font-weight: 600"></p>
                            <p id="device" class="hide" style="font-weight: 600"></p>
                            <%--Hypersoic end--%>
                            <p id="pop3"></p>
                            <p id="pop_period" class="hide" style="font-weight: 600"></p>
                            <p id="pop_expiry" class="hide" style="font-weight: 600"></p>

                            <p id="remaining" class="hide" style="font-weight: 600"></p>
                        </div>
                        <div id="warranty_message" style="position: fixed; float: right; right: 10px; bottom: 50px; font-size: larger; color: blue; cursor: pointer"><a id="download" class="btn btn-info" style="background-color: #d4000000 !important; border-color: #00bcd400 !important"><i class="ti-download">Product Images</i></a>&nbsp;<%--<a  onclick="chatmodal()"><i id="warcomment" class="ti-comments"></i></a>--%></div>
                        <p style="font-weight: 400; color: gray; text-decoration: underline; cursor: pointer
    /* margin-top: -2px; */"
                            id="warcomment">
                            Show Comments
                        </p>
                        <div id="warrantycommentdetails" class="hide">

                            <div class="col-9">

                                <h6>User: </h6>
                                <p id="war_user_comment" style="font-weight: 600; color: darkgray;"></p>

                                <h6>Vendor:</h6>
                                <p id="war_vendor_comment" style="font-weight: 600; color: darkgray;"></p>
                            </div>
                        </div>
                    </div>
                    <div class="modal-body" style="padding-left: 1rem; padding-right: 1rem; padding-top: 0px">
                        <%--  <img id="pop_img" style="float:right; width:80px; height:80px" src="../img/ok.png"/>
		<div id="pop1" >
            
          </div>
          
          <div id="pop2">
		</div>
               
		<div class="mod_tran_content" id="pop3"></div>
    <div class="mod_tran_content" id="pop4"></div>
            <div class="hide_pop" id="pop5"></div>
                        --%>

                        <hr />
                        <div style="float: left"><strong>VCQRU</strong></div>
                        <div style="float: right">
                            <button type="button" style="border-style: none; color: darkblue; text-decoration: underline; background-color: transparent; cursor: pointer" data-toggle="modal" data-target="#IssueModal" data-dismiss="modal">Report Issue</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </form>
    <script type="text/javascript" src="../assetsfrui/js/jquery.min.js"></script>

    <script type="text/javascript" src="../assetsfrui/js/bootstrap.min.js"></script>
    <!-- <script type="text/javascript" src="assets/js/jquery-slimscroll/jquery.slimscroll.js"></script> -->
    <script type="text/javascript" src="../assetsfrui/js/script.js"></script>
    <script src="../assetsfrui/js/pcoded.min.js"></script>
    <script src="../assetsfrui/js/vartical-demo.js"></script>
    <script src="../Content/js/toastr.min.js"></script>
    <!-- <script src="assets/js/jquery.mCustomScrollbar.concat.min.js"></script> -->

</body>

<script>
    debugger;
    //$('#productupload_warr').fileupload({
    //    maxNumberOfFiles: 5
    //});
    $(document).ready(function () {
        if ($('#mmvalue').val() !== '0') {
            $('#claim_list').css("display", "none");
            $('#summary_list').addClass('list_items');
            $('#history_list').addClass('list_items');

        }
    });
    $('input[type="file"]').change(function (e) {
        var fileName = e.target.files[0].name;
        if (parseInt(e.target.files.length) > 5) {
            alert("You are only allowed to upload a maximum of 5 files");
        }
        else {
            var filescode = "";
            if (e.target.files.length > 0) {
                for (var i = 0; i < e.target.files.length; i++) {
                    filescode = filescode + '<p style="font-size: 11px; margin-bottom: 0rem;">' + e.target.files[i].name + '</p>';
                }
            }
            $('#filelist').html(filescode);
        }
    });




    function bill() {
        debugger;
        $.ajax({
            type: "POST",
                <%--url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=browsesave&email=' + email + '&billno=' + wrbillno + '&purchasedate=' + wrpurchasedate+'&mobile='+mobile,--%>
            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=billdetails&code=' + $('#pop5').text(),
            success: function (data) {

                if (data == '') {
                    alert('No Image uploaded');
                }
                else {
                    var link = document.createElement('a');

                    link.setAttribute('download', 'Product Bill');
                    link.style.display = 'none';

                    document.body.appendChild(link);

                    //for (var i = 0; i < urls.length; i++) {
                    //    link.setAttribute('href', urls[i]);
                    //    link.click();
                    //}

                    document.body.removeChild(link);


                            //window.open('<%=ProjectSession.absoluteSiteBrowseUrl%>' + paths[i].substr(2, paths[i].length));
                    link.setAttribute('href', '<%=ProjectSession.absoluteSiteBrowseUrl%>' + data.substr(2, data.length));
                    link.click();

                }
            },
            error: function (err) {
                //$('#divLoader').hide();
                alert(err.statusText);
            }
        });
    }
    $('#download').click(function () {


        $.ajax({
            type: "POST",
                <%--url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=browsesave&email=' + email + '&billno=' + wrbillno + '&purchasedate=' + wrpurchasedate+'&mobile='+mobile,--%>
            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=imagedetails&code=' + $('#pop5').text(),
            success: function (data) {






                if (data == '') {
                    alert('No Image uploaded');
                }
                else {
                    var link = document.createElement('a');

                    link.setAttribute('download', 'Product');
                    link.style.display = 'none';

                    document.body.appendChild(link);

                    //for (var i = 0; i < urls.length; i++) {
                    //    link.setAttribute('href', urls[i]);
                    //    link.click();
                    //}

                    document.body.removeChild(link);
                    var paths = data.split(',');
                    for (var i = 0; i < paths.length; i++) {
                            //window.open('<%=ProjectSession.absoluteSiteBrowseUrl%>' + paths[i].substr(2, paths[i].length));
                        link.setAttribute('href', '<%=ProjectSession.absoluteSiteBrowseUrl%>' + paths[i].substr(2, paths[i].length));
                        link.click();
                    }
                }
            },
            error: function (err) {
                //$('#divLoader').hide();
                alert(err.statusText);
            }
        });

    });
    function chatmodal() {
        $('#modalComment').modal();
    }

    function callfileupload() {
        $('#productupload_warr').click();
    }
    debugger;
    function save() {
        debugger;

        var $fileUpload = $("input[type='file']");
        //if (parseInt($fileUpload.get(0).files.length) > 5) {
        //    alert("You are only allowed to upload a maximum of 5 files");


        //}
        //else {


        var wrecomment = $('#wrr_Comments_id').val();
        var fData = new FormData();
        var files = $("#productupload_warr").get(0).files;
        var warr_code = $(code).text();
        if (files.length <= 0) {
            alert("Please upload image!");
            return false;
        } else if (files.length > 0) {
            for (var i = 0; i < files.length; i++) {
                fData.append("UploadedFile" + i, files[i]);
                const fsize = files.item(i).size;
                if (Math.round((fsize / 1024)) > 400) {
                    alert("File size can not exceed 400KB");
                    return false;
                }
            }

        }

        if ($('#wrr_Comments_id').val() == "") {

            alert("Please Enter Comments");
            return false;
        }

        fData.append("comment", wrecomment);

        $.ajax({
            type: "POST",
                <%--url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=browsesave&email=' + email + '&billno=' + wrbillno + '&purchasedate=' + wrpurchasedate+'&mobile='+mobile,--%>
            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=updatewarrantydetails&code=' + warr_code + '&comment=' + wrecomment,
            data: fData,
            contentType: false,
            processData: false,
            datatype: 'json',
            success: function (data) {
                //$('#p1msgWarranty').html(data);
                //$('#smallModalWarranty').modal();
                debugger;
                toastr.options.fadeOut = 1500;
                toastr.success('Warranty Claimed Successfully.');
                location.reload(true);
            },
            error: function (err) {
                //$('#divLoader').hide();
                alert(err.statusText);
            }
        });
        //}
    }



    $(document).ready(function () {

        $('#page_width').val($(window).width());


    });

    $('#IssueModal').on('hidden.bs.modal', function () {
        $('#Report').val('');
        $('#Report_message').css('display', 'none');

    })
    function checkTextAreaMaxLength(textBox, e, length) {

        var mLen = textBox["MaxLength"];
        if (null == mLen)
            mLen = length;

        var maxLength = parseInt(mLen);
        if (!checkSpecialKeys(e)) {
            if (textBox.value.length > maxLength - 1) {
                if (window.event)//IE
                    e.returnValue = false;
                else//Firefox
                    e.preventDefault();
            }
        }
    }
    function checkSpecialKeys(e) {
        if (e.keyCode != 8 && e.keyCode != 46 && e.keyCode != 37 && e.keyCode != 38 && e.keyCode != 39 && e.keyCode != 40)
            return false;
        else
            return true;
    }

    $('.menu_toogle').click(function () {
        $('.nav-left').toggleClass('slide_show');
    });
    $('.statement').click(function () {
        if (y == 0)
            $('#exampleModal').modal();
    });
    var y = 0;
    var code = '';
    debugger;
    $('#warcomment').click(function () {
        $('#warrantycommentdetails').toggleClass('hide');
    });
    function getaw(obj) {
        debugger;
        var parts = obj.id.split("_");
        $('#warrantycommentdetails').addClass('hide');
        code = '#' + parts[0] + '_' + parts[1] + '_code'
        if (parts[2] == 'claimbutton') {
            $('#Claimmodal').modal();
            // $('#warrantycode').va()
            y = 1;
        }
        else if (y == 1 && parts[2] == 'statement') {
            y = 1;
        }
        else {
            y = 0;
        }
        debugger;
        if (y == 0) {
<%--Lubigen Start--%>

            UPIID = '#' + parts[0] + '_' + parts[1] + '_UPIID'
            PaymentStatus = '#' + parts[0] + '_' + parts[1] + '_PaymentStatus'
            BankRefID = '#' + parts[0] + '_' + parts[1] + '_BankRefID'
            TransactionDate = '#' + parts[0] + '_' + parts[1] + '_TransactionDate'
            PaymentRemarks = '#' + parts[0] + '_' + parts[1] + '_PaymentRemarks'

            comp_name = '#' + parts[0] + '_' + parts[1] + '_comp_name'
            <%--Lubigen End--%>
               <%--Hypersoic--%>
            vehicleno = '#' + parts[0] + '_' + parts[1] + '_vehicleno'
            device = '#' + parts[0] + '_' + parts[1] + '_device'
               <%--Hypersoic--%>

            tr_message = '#' + parts[0] + '_' + parts[1] + '_tr_message2'
            comment = '#' + parts[0] + '_' + parts[1] + '_user_comment'
            vendorcomment = '#' + parts[0] + '_' + parts[1] + '_vendorcomment'
            loyalty = '#' + parts[0] + '_' + parts[1] + '_loyalty'
            pro_name = '#' + parts[0] + '_' + parts[1] + '_pro_name'
            updt = '#' + parts[0] + '_' + parts[1] + '_updtfull'
            tr_status = '#' + parts[0] + '_' + parts[1] + '_tr_status'
            customer_bill = '#' + parts[0] + '_' + parts[1] + '_customer_bill'
            trans_num = '#' + parts[0] + '_' + parts[1] + '_trans_num'
            currency = '#' + parts[0] + '_' + parts[1] + '_currency'
            serviceid = '#' + parts[0] + '_' + parts[1] + '_serviceid'
            purchasedate = '#' + parts[0] + '_' + parts[1] + '_purchasedate'
            warrantyexpiredate = '#' + parts[0] + '_' + parts[1] + '_warrantyexpiredate'
            warrrantyperiod = '#' + parts[0] + '_' + parts[1] + '_warrrantyperiod'
            numberofdays = '#' + parts[0] + '_' + parts[1] + '_numberofdays'
            vendorclaimstatus = '#' + parts[0] + '_' + parts[1] + '_vendorclaimstatus'
            sign = '#' + parts[0] + '_' + parts[1] + '_sign'

             <%--SRV1029--%>
            UPI_ID = '#' + parts[0] + '_' + parts[1] + '_UPI_ID'
            UPI_OrderID = '#' + parts[0] + '_' + parts[1] + '_UPI_OrderID'
            UPI_Status = '#' + parts[0] + '_' + parts[1] + '_UPI_Status'
            UPI_Remarks = '#' + parts[0] + '_' + parts[1] + '_UPI_Remarks'
            <%--SRV1029--%>

            x = $(tr_message).closest('#clrdiv').attr('class')
            if ($(currency).text() == 'cash') {
                $('#pop2').text('₹. ' + $(loyalty).text());
            }
            else if ($(currency).text() == 'pts') {
                $('#pop2').text('Pts. ' + $(loyalty).text());
            } else
                $('#pop2').text($(loyalty).text());

            x = $(tr_message).closest('#clrdiv').attr('class')
            $('#pop1').text($(tr_message).text());
            if ($(vendorclaimstatus).text() == 'Reject') {
                $('#pop_img').attr('src', '../img/Rejected.png');

            }
            else if ($(vendorclaimstatus).text() == 'Approved') {
                $('#pop_img').attr('src', '../img/approved.jpg');

            }
            else if ($(vendorclaimstatus).text() == 'Pending') {
                $('#pop_img').attr('src', '../img/Pending.jpg');
            }
            else {
                if ($(tr_status).text() == 'Success')
                    $('#pop_img').attr('src', '../img/checkmark.png');
<%--Lubigen Start--%>
                else if ($(tr_status).text() == 'Claim Approved')
                    $('#pop_img').attr('src', '../img/checkmark.png');
                    <%--Lubigen End--%>
                else
                    $('#pop_img').attr('src', '../img/cancel.png');
            }


            if ($(sign).text().substr(1, 1) != '-') {
                $('#warranty_message').addClass('hide');
                $('#warcomment').addClass('hide');

            }
            else {
                $('#warranty_message').removeClass('hide');
                $('#warcomment').removeClass('hide');
            }

            if ($(trans_num).text() == '')
                if ($(serviceid).text() == 'SRV1023') {
                    $('#vehicleno').text('vehicle no :  ' + $(vehicleno).text().substr(0));
                    $('#device').text('device  : ' + $(device).text().substr(0));
                    $('#pop3').text('Purchased on  ' + $(purchasedate).text().substr(0));
                    $('#pop_period').text('Warranty Period  ' + $(warrrantyperiod).text() + ' Months');
                    $('#pop_expiry').text('Expiration Date  ' + $(warrantyexpiredate).text().substr(0));
                    $('#warranty_message').removeClass('hide');
                    if ($(numberofdays).text() >= 0) {
                        $('#remaining').text($(numberofdays).text() + ' Days Remaining');

                    }
                    //Added by Bipin for Hypersonic
                    if ($(comp_name).text() == 'TECHNICAL MINDS PRIVATE LIMITED') {
                        $('#vehicleno').removeClass('hide');
                        $('#device').removeClass('hide');

                    }
                    //Added by Bipin for Hypersonic

                    $('#pop_period').removeClass('hide');
                    $('#pop_expiry').removeClass('hide');
                    $('#remaining').removeClass('hide');
                    if ($(customer_bill).text() == '')
                        $('#Bill').addClass('hide');
                    else
                        $('#Bill').removeClass('hide');
                    $('#Bill').html('Invoice no. <a style="color:blue; text-decoration:underline; cursor:pointer" onclick="bill()">' + $(customer_bill).text() + '</a>');


                    $('#war_user_comment').text($(comment).text());
                    $('#war_vendor_comment').text($(vendorcomment).text());
                    $('#warcomment').removeClass('hide');

                    if ($(UPIID).text() == '') {

                        $('#UPIID').removeClass('unhide_pop')
                        $('#UPIID').addClass('hide_pop')

                        $('#UPIIDval').removeClass('unhide_pop')
                        $('#UPIIDval').addClass('hide_pop')

                        $('#PaymentStatus').removeClass('unhide_pop')
                        $('#PaymentStatus').addClass('hide_pop')
                        $('#PaymentStatusval').removeClass('unhide_pop')
                        $('#PaymentStatusval').addClass('hide_pop')

                        $('#BankRefID').removeClass('unhide_pop')
                        $('#BankRefID').addClass('hide_pop')

                        $('#BankRefIDval').removeClass('unhide_pop')
                        $('#BankRefIDval').addClass('hide_pop')

                        $('#TransactionDate').removeClass('unhide_pop')
                        $('#TransactionDate').addClass('hide_pop')

                        $('#TransactionDateval').removeClass('unhide_pop')
                        $('#TransactionDateval').addClass('hide_pop')

                        $('#PaymentRemarks').removeClass('unhide_pop')
                        $('#PaymentRemarks').addClass('hide_pop')

                        $('#PaymentRemarksval').removeClass('unhide_pop')
                        $('#PaymentRemarksval').addClass('hide_pop')
                    }
                }
                 <%--SRV1029--%>
                else if ($(serviceid).text() == 'SRV1029') {
                    $('#UPIIDval').text($(UPI_ID).text());
                    $('#PaymentStatusval').text($(UPI_Status).text());
                    $('#BankRefIDval').text($(UPI_OrderID).text());

                    $('#PaymentRemarksval').text($(UPI_Remarks).text());

                    if ($(UPI_ID).text() == '') {

                        $('#UPIID').removeClass('unhide_pop')
                        $('#UPIID').addClass('hide_pop')

                        $('#UPIIDval').removeClass('unhide_pop')
                        $('#UPIIDval').addClass('hide_pop')

                        $('#PaymentStatus').removeClass('unhide_pop')
                        $('#PaymentStatus').addClass('hide_pop')
                        $('#PaymentStatusval').removeClass('unhide_pop')
                        $('#PaymentStatusval').addClass('hide_pop')

                        $('#BankRefID').removeClass('unhide_pop')
                        $('#BankRefID').addClass('hide_pop')

                        $('#BankRefIDval').removeClass('unhide_pop')
                        $('#BankRefIDval').addClass('hide_pop')

                        $('#TransactionDate').removeClass('unhide_pop')
                        $('#TransactionDate').addClass('hide_pop')

                        $('#TransactionDateval').removeClass('unhide_pop')
                        $('#TransactionDateval').addClass('hide_pop')

                        $('#PaymentRemarks').removeClass('unhide_pop')
                        $('#PaymentRemarks').addClass('hide_pop')

                        $('#PaymentRemarksval').removeClass('unhide_pop')
                        $('#PaymentRemarksval').addClass('hide_pop')
                    }

                    else {
                        $('#UPIID').addClass('unhide_pop')
                        $('#UPIIDval').addClass('unhide_pop')
                        $('#PaymentStatus').addClass('unhide_pop')
                        $('#PaymentStatusval').addClass('unhide_pop')
                        $('#BankRefID').addClass('unhide_pop')
                        $('#BankRefIDval').addClass('unhide_pop')
                        $('#TransactionDate').addClass('hide_pop')
                        $('#TransactionDateval').addClass('hide_pop')
                        $('#PaymentRemarks').addClass('unhide_pop')
                        $('#PaymentRemarksval').addClass('unhide_pop')


                        if (x == "Green") {
                            $('#PaymentStatusval').removeClass('Red')
                            $('#PaymentStatusval').addClass('Green');

                            $('#PaymentRemarksval').removeClass('Red')
                            $('#PaymentRemarksval').addClass('Green');

                        }
                        else if (x == "Gray") {
                            $('#PaymentStatusval').removeClass('Green')
                            $('#PaymentStatusval').removeClass('Red');
                            $('#PaymentStatusval').addClass('Gray');

                            $('#PaymentRemarksval').removeClass('Green')
                            $('#PaymentRemarksval').removeClass('Red');
                            $('#PaymentRemarksval').addClass('Gray');

                        }
                        else {
                            $('#PaymentStatusval').removeClass('Green')
                            $('#PaymentStatusval').addClass('Red');

                            $('#PaymentRemarksval').removeClass('Green')
                            $('#PaymentRemarksval').addClass('Red');
                        }
                    }




                }
                       <%--SRV1029--%>
<%--Lubigen Start--%>
                else if ($(comp_name).text() == 'Lubigen Pvt Ltd') {
                    $('#UPIIDval').text($(UPIID).text());
                    $('#PaymentStatusval').text($(PaymentStatus).text());
                    $('#BankRefIDval').text($(BankRefID).text());
                    $('#TransactionDateval').text($(TransactionDate).text());
                    $('#PaymentRemarksval').text($(PaymentRemarks).text());

                    if ($(UPIID).text() == '') {

                        $('#UPIID').removeClass('unhide_pop')
                        $('#UPIID').addClass('hide_pop')

                        $('#UPIIDval').removeClass('unhide_pop')
                        $('#UPIIDval').addClass('hide_pop')

                        $('#PaymentStatus').removeClass('unhide_pop')
                        $('#PaymentStatus').addClass('hide_pop')
                        $('#PaymentStatusval').removeClass('unhide_pop')
                        $('#PaymentStatusval').addClass('hide_pop')

                        $('#BankRefID').removeClass('unhide_pop')
                        $('#BankRefID').addClass('hide_pop')

                        $('#BankRefIDval').removeClass('unhide_pop')
                        $('#BankRefIDval').addClass('hide_pop')

                        $('#TransactionDate').removeClass('unhide_pop')
                        $('#TransactionDate').addClass('hide_pop')

                        $('#TransactionDateval').removeClass('unhide_pop')
                        $('#TransactionDateval').addClass('hide_pop')

                        $('#PaymentRemarks').removeClass('unhide_pop')
                        $('#PaymentRemarks').addClass('hide_pop')

                        $('#PaymentRemarksval').removeClass('unhide_pop')
                        $('#PaymentRemarksval').addClass('hide_pop')
                    }

                    else {
                        $('#UPIID').addClass('unhide_pop')
                        $('#UPIIDval').addClass('unhide_pop')
                        $('#PaymentStatus').addClass('unhide_pop')
                        $('#PaymentStatusval').addClass('unhide_pop')
                        $('#BankRefID').addClass('unhide_pop')
                        $('#BankRefIDval').addClass('unhide_pop')
                        $('#TransactionDate').addClass('unhide_pop')
                        $('#TransactionDateval').addClass('unhide_pop')
                        $('#PaymentRemarks').addClass('unhide_pop')
                        $('#PaymentRemarksval').addClass('unhide_pop')


                        if (x == "Green") {
                            $('#PaymentStatusval').removeClass('Red')
                            $('#PaymentStatusval').addClass('Green');

                            $('#PaymentRemarksval').removeClass('Red')
                            $('#PaymentRemarksval').addClass('Green');

                        }
                        else if (x == "Gray") {
                            $('#PaymentStatusval').removeClass('Green')
                            $('#PaymentStatusval').removeClass('Red');
                            $('#PaymentStatusval').addClass('Gray');

                            $('#PaymentRemarksval').removeClass('Green')
                            $('#PaymentRemarksval').removeClass('Red');
                            $('#PaymentRemarksval').addClass('Gray');

                        }
                        else {
                            $('#PaymentStatusval').removeClass('Green')
                            $('#PaymentStatusval').addClass('Red');

                            $('#PaymentRemarksval').removeClass('Green')
                            $('#PaymentRemarksval').addClass('Red');
                        }
                    }




                }
                     <%--Lubigen End--%>

                else {

                    if ($(UPI_ID).text() == '') {

                        $('#UPIID').removeClass('unhide_pop')
                        $('#UPIID').addClass('hide_pop')

                        $('#UPIIDval').removeClass('unhide_pop')
                        $('#UPIIDval').addClass('hide_pop')

                        $('#PaymentStatus').removeClass('unhide_pop')
                        $('#PaymentStatus').addClass('hide_pop')
                        $('#PaymentStatusval').removeClass('unhide_pop')
                        $('#PaymentStatusval').addClass('hide_pop')

                        $('#BankRefID').removeClass('unhide_pop')
                        $('#BankRefID').addClass('hide_pop')

                        $('#BankRefIDval').removeClass('unhide_pop')
                        $('#BankRefIDval').addClass('hide_pop')

                        $('#TransactionDate').removeClass('unhide_pop')
                        $('#TransactionDate').addClass('hide_pop')

                        $('#TransactionDateval').removeClass('unhide_pop')
                        $('#TransactionDateval').addClass('hide_pop')

                        $('#PaymentRemarks').removeClass('unhide_pop')
                        $('#PaymentRemarks').addClass('hide_pop')

                        $('#PaymentRemarksval').removeClass('unhide_pop')
                        $('#PaymentRemarksval').addClass('hide_pop')
                    }
                    $('#pop3').text($(pro_name).text());
                    $('#pop_period').addClass('hide');
                    $('#pop_expiry').addClass('hide');
                    $('#remaining').addClass('hide');
                    $('#warranty_message').addClass('hide');
                    $('#warcomment').addClass('hide');

                }

            else
                $('#pop3').text($(trans_num).text());
            $('#pop4').text($(updt).text());
            if (x == "Green") {
                $('#pop1').removeClass('Red')
                $('#pop1').addClass('Green');
            }
            else if (x == "Gray") {
                $('#pop1').removeClass('Green')
                $('#pop1').removeClass('Red');
                $('#pop1').addClass('Gray');
            }
            else {
                $('#pop1').removeClass('Green')
                $('#pop1').addClass('Red');
            }
            debugger;
            z = $(code).text()
            if ($(code).text() == '') {
                $('#pop5').removeClass('unhide_pop')
                $('#pop5').addClass('hide_pop')
                $('#code').removeClass('unhide_pop')
                $('#code').addClass('hide_pop')

            }
            else {
                $('#pop5').removeClass('hide_pop')
                $('#pop5').addClass('unhide_pop')
                $('#code').addClass('unhide_pop')
                $('#code').removeClass('hide_pop')
                $('#pop5').text($(code).text())
                $('#code_value').val($(code).text())

            }
            $('#pop1').addClass($(tr_message).closest('#clrdiv').attr('class'));
        }
    }


    function openModal(msg) {
        alert(msg);
        $('#btnshowclm').click();
    }

    function transaction(obj) {
        debugger;
        if (obj.id == 'History') {
            $('#pan_Summary').removeClass('active')
            $('#pan_Claim').removeClass('active')
            $('#pan_history').addClass('active')
            return false;

        }
        else if (obj.id == 'Summary') {
            $('#call_Summary').click();
            $('#pan_Summary').addClass('active')
            $('#pan_Claim').removeClass('active')
            $('#pan_history').removeClass('active')

            return false;
        }
        else if (obj.id == 'Claim') {
            $('#btnshowclm').click();
            $('#pan_Summary').removeClass('active')
            $('#pan_history').removeClass('active')
            $('#pan_Claim').addClass('active')

            return false;
        }
    }


</script>

<script type="text/javascript">
    function showLoader() {
        $('#overlay').show();  // Show overlay and spinner
    }

    function hideLoader() {
        $('#overlay').hide();  // Hide overlay and spinner
    }

    $(document).ready(function () {
        // Show loader when any button with the class '.btn-loader' is clicked
        $('.btn').click(function () {
            
            showLoader();
        });
        $('#btnpointClaim_UPI').on('click', function () {
            
            showLoader();
        });

        // Handle partial postbacks (if applicable) with PageRequestManager
        var prm = Sys.WebForms.PageRequestManager.getInstance();

        // Show loader when an async request begins
        prm.add_beginRequest(function () {
            showLoader();
        });

        // Hide loader when the async request completes
        prm.add_endRequest(function () {
            hideLoader();
        });
    });
</script>

</html>
