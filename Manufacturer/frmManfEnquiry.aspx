    <%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" EnableEventValidation="false" AutoEventWireup="true"
        CodeFile="frmManfEnquiry.aspx.cs" Inherits="frmManfEnquiry" Title="Enquiry Details" %>

    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

         <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

        <script src="https://code.jquery.com/jquery-migrate-1.3.0.js"></script>


        <script type="text/javascript">
            $(document).ready(function () {

                $(".accordion2 p").eq(36).addClass("active");
                $(".accordion2 div.open").eq(30).show();

                $(".accordion2 p").click(function () {
                    $(this).next("div.open").slideToggle("slow")
                        .siblings("div.open:visible").slideUp("slow");
                    $(this).toggleClass("active");
                    $(this).siblings("p").removeClass("active");
                });

                $("#saveButton").click(function () {
                    $('#progress').show();
                    var session = '<%= Session["CompanyId"] %>';
                    var IpAddress = GetUserIP();
                    var BrowserDetails = Object.keys(jQuery.browser)[1];

                    //                // Check for Chrome
                    //                if ($.browser.chrome)   
                    //                {
                    //                    BrowserDetails ="Google Chrome";
                    //                }
                    //                // Check for IE
                    //                else if ($.browser.msie)
                    //                {
                    //                    BrowserDetails = "Internet Explorer";

                    //            }
                    //// Check for Safari
                    //                else if ($.browser.safari)
                    //                {
                    //                    BrowserDetails = "Safari";
                    //                }

                    var nVer = navigator.appVersion;
                    var nAgt = navigator.userAgent;
                    var browserName = navigator.appName;
                    var fullVersion = '' + parseFloat(navigator.appVersion);
                    var majorVersion = parseInt(navigator.appVersion, 10);
                    var nameOffset, verOffset, ix;

                    // In Opera, the true version is after "OPR" or after "Version"
                    if ((verOffset = nAgt.indexOf("OPR")) != -1) {
                        browserName = "Opera";
                        fullVersion = nAgt.substring(verOffset + 4);
                        if ((verOffset = nAgt.indexOf("Version")) != -1)
                            fullVersion = nAgt.substring(verOffset + 8);
                    }
                    // In MS Edge, the true version is after "Edg" in userAgent
                    else if ((verOffset = nAgt.indexOf("Edg")) != -1) {
                        browserName = "Microsoft Edge";
                        fullVersion = nAgt.substring(verOffset + 4);
                    }
                    // In MSIE, the true version is after "MSIE" in userAgent
                    else if ((verOffset = nAgt.indexOf("MSIE")) != -1) {
                        browserName = "Microsoft Internet Explorer";
                        fullVersion = nAgt.substring(verOffset + 5);
                    }
                    // In Chrome, the true version is after "Chrome" 
                    else if ((verOffset = nAgt.indexOf("Chrome")) != -1) {
                        browserName = "Chrome";
                        fullVersion = nAgt.substring(verOffset + 7);
                    }
                    // In Safari, the true version is after "Safari" or after "Version" 
                    else if ((verOffset = nAgt.indexOf("Safari")) != -1) {
                        browserName = "Safari";
                        fullVersion = nAgt.substring(verOffset + 7);
                        if ((verOffset = nAgt.indexOf("Version")) != -1)
                            fullVersion = nAgt.substring(verOffset + 8);
                    }
                    // In Firefox, the true version is after "Firefox" 
                    else if ((verOffset = nAgt.indexOf("Firefox")) != -1) {
                        browserName = "Firefox";
                        fullVersion = nAgt.substring(verOffset + 8);
                    }
                    // In most other browsers, "name/version" is at the end of userAgent 
                    else if ((nameOffset = nAgt.lastIndexOf(' ') + 1) <
                        (verOffset = nAgt.lastIndexOf('/'))) {
                        browserName = nAgt.substring(nameOffset, verOffset);
                        fullVersion = nAgt.substring(verOffset + 1);
                        if (browserName.toLowerCase() == browserName.toUpperCase()) {
                            browserName = navigator.appName;
                        }
                    }



                    debugger;
                    $.ajax({
                        type: "POST",


                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=InsertVendorTermsCondition&Comp_Id=' + session + '&Content=This is demo request on qa.&IPAddress=' + IpAddress + '&Browser=' + browserName + '&DeviceDetails=NA&MacID=NA',
                        success: function (data) {
                            debugger;
                            var page = "";
                            var resut = data;
                            if (resut == 1) {

                                var modal = document.getElementById('modal');
                                modal.style.display = "none";
                            }
                            else {
                                var modal = document.getElementById('modal');
                                modal.style.display = "none";
                            }

                            $('#progress').hide();
                        },
                    });
                });

                $("#cancelButton").click(function () {

                    $('#progress').show();
                    var session = '<%= Session["CompanyId"] %>';
                    var IpAddress = GetUserIP();
                    var BrowserDetails = navigator.appName;
                    debugger;

                    var nVer = navigator.appVersion;
                    var nAgt = navigator.userAgent;
                    var browserName = navigator.appName;
                    var fullVersion = '' + parseFloat(navigator.appVersion);
                    var majorVersion = parseInt(navigator.appVersion, 10);
                    var nameOffset, verOffset, ix;

                    // In Opera, the true version is after "OPR" or after "Version"
                    if ((verOffset = nAgt.indexOf("OPR")) != -1) {
                        browserName = "Opera";
                        fullVersion = nAgt.substring(verOffset + 4);
                        if ((verOffset = nAgt.indexOf("Version")) != -1)
                            fullVersion = nAgt.substring(verOffset + 8);
                    }
                    // In MS Edge, the true version is after "Edg" in userAgent
                    else if ((verOffset = nAgt.indexOf("Edg")) != -1) {
                        browserName = "Microsoft Edge";
                        fullVersion = nAgt.substring(verOffset + 4);
                    }
                    // In MSIE, the true version is after "MSIE" in userAgent
                    else if ((verOffset = nAgt.indexOf("MSIE")) != -1) {
                        browserName = "Microsoft Internet Explorer";
                        fullVersion = nAgt.substring(verOffset + 5);
                    }
                    // In Chrome, the true version is after "Chrome" 
                    else if ((verOffset = nAgt.indexOf("Chrome")) != -1) {
                        browserName = "Chrome";
                        fullVersion = nAgt.substring(verOffset + 7);
                    }
                    // In Safari, the true version is after "Safari" or after "Version" 
                    else if ((verOffset = nAgt.indexOf("Safari")) != -1) {
                        browserName = "Safari";
                        fullVersion = nAgt.substring(verOffset + 7);
                        if ((verOffset = nAgt.indexOf("Version")) != -1)
                            fullVersion = nAgt.substring(verOffset + 8);
                    }
                    // In Firefox, the true version is after "Firefox" 
                    else if ((verOffset = nAgt.indexOf("Firefox")) != -1) {
                        browserName = "Firefox";
                        fullVersion = nAgt.substring(verOffset + 8);
                    }
                    // In most other browsers, "name/version" is at the end of userAgent 
                    else if ((nameOffset = nAgt.lastIndexOf(' ') + 1) <
                        (verOffset = nAgt.lastIndexOf('/'))) {
                        browserName = nAgt.substring(nameOffset, verOffset);
                        fullVersion = nAgt.substring(verOffset + 1);
                        if (browserName.toLowerCase() == browserName.toUpperCase()) {
                            browserName = navigator.appName;
                        }
                    }



                    $.ajax({
                        type: "POST",


                        url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=InsertUpdateVendorTermsCondition&Comp_Id=' + session + '&Content=This is demo request on qa.&IPAddress=' + IpAddress + '&Browser=' + browserName + '&DeviceDetails=NA&MacID=NA',
                        success: function (data) {
                            debugger;
                            var page = "";
                            var resut = data;
                            if (resut == 1) {

                                var modal = document.getElementById('modal');
                                modal.style.display = "none";
                            }

                            else {
                                var modal = document.getElementById('modal');
                                modal.style.display = "none";
                            }

                            $('#progress').hide();
                        },
                    });
                });

            });

            function Device_Type() {
                var Return_Device;
                if (/(up.browser|up.link|mmp|symbian|smartphone|midp|wap|phone|android|iemobile|w3c|acs\-|alav|alca|amoi|audi|avan|benq|bird|blac|blaz|brew|cell|cldc|cmd\-|dang|doco|eric|hipt|inno|ipaq|java|jigs|kddi|keji|leno|lg\-c|lg\-d|lg\-g|lge\-|maui|maxo|midp|mits|mmef|mobi|mot\-|moto|mwbp|nec\-|newt|noki|palm|pana|pant|phil|play|port|prox|qwap|sage|sams|sany|sch\-|sec\-|send|seri|sgh\-|shar|sie\-|siem|smal|smar|sony|sph\-|symb|t\-mo|teli|tim\-|tosh|tsm\-|upg1|upsi|vk\-v|voda|wap\-|wapa|wapi|wapp|wapr|webc|winw|winw|xda|xda\-) /i.test(navigator.userAgent)) {
                    if (/(tablet|ipad|playbook)|(android(?!.*(mobi|opera mini)))/i.test(navigator.userAgent)) {
                        Return_Device = 'Tablet';
                    }
                    else {
                        Return_Device = 'Mobile';
                    }
                }
                else if (/(tablet|ipad|playbook)|(android(?!.*(mobi|opera mini)))/i.test(navigator.userAgent)) {
                    Return_Device = 'Tablet';
                }
                else {
                    Return_Device = 'Desktop';
                }

                return Return_Device;
            }

            function GetUserIP() {
                var ret_ip;
                $.ajaxSetup({ async: false });
                $.get('https://jsonip.com/', function (r) {
                    ret_ip = r.ip;
                });
                return ret_ip;
            }



        </script>
        <script type="text/javascript">

            const closeModalBtn = document.getElementById("closeModal");
            window.onload = function () {

                debugger;
                var session = '<%= Session["CompanyId"] %>';
                var IpAddress = GetUserIP();
                var DeviceType = Device_Type();

                var nVer = navigator.appVersion;
                var nAgt = navigator.userAgent;
                var browserName = navigator.appName;
                var fullVersion = '' + parseFloat(navigator.appVersion);
                var majorVersion = parseInt(navigator.appVersion, 10);
                var nameOffset, verOffset, ix;

                // In Opera, the true version is after "OPR" or after "Version"
                if ((verOffset = nAgt.indexOf("OPR")) != -1) {
                    browserName = "Opera";
                    fullVersion = nAgt.substring(verOffset + 4);
                    if ((verOffset = nAgt.indexOf("Version")) != -1)
                        fullVersion = nAgt.substring(verOffset + 8);
                }
                // In MS Edge, the true version is after "Edg" in userAgent
                else if ((verOffset = nAgt.indexOf("Edg")) != -1) {
                    browserName = "Microsoft Edge";
                    fullVersion = nAgt.substring(verOffset + 4);
                }
                // In MSIE, the true version is after "MSIE" in userAgent
                else if ((verOffset = nAgt.indexOf("MSIE")) != -1) {
                    browserName = "Microsoft Internet Explorer";
                    fullVersion = nAgt.substring(verOffset + 5);
                }
                // In Chrome, the true version is after "Chrome" 
                else if ((verOffset = nAgt.indexOf("Chrome")) != -1) {
                    browserName = "Chrome";
                    fullVersion = nAgt.substring(verOffset + 7);
                }
                // In Safari, the true version is after "Safari" or after "Version" 
                else if ((verOffset = nAgt.indexOf("Safari")) != -1) {
                    browserName = "Safari";
                    fullVersion = nAgt.substring(verOffset + 7);
                    if ((verOffset = nAgt.indexOf("Version")) != -1)
                        fullVersion = nAgt.substring(verOffset + 8);
                }
                // In Firefox, the true version is after "Firefox" 
                else if ((verOffset = nAgt.indexOf("Firefox")) != -1) {
                    browserName = "Firefox";
                    fullVersion = nAgt.substring(verOffset + 8);
                }
                // In most other browsers, "name/version" is at the end of userAgent 
                else if ((nameOffset = nAgt.lastIndexOf(' ') + 1) <
                    (verOffset = nAgt.lastIndexOf('/'))) {
                    browserName = nAgt.substring(nameOffset, verOffset);
                    fullVersion = nAgt.substring(verOffset + 1);
                    if (browserName.toLowerCase() == browserName.toUpperCase()) {
                        browserName = navigator.appName;
                    }
                }

                $('#ctl00_ContentPlaceHolder1_hdfIpaddresss').attr('value', IpAddress);
                $('#ctl00_ContentPlaceHolder1_hdfDeviceDetails').attr('value', DeviceType);
                $('#ctl00_ContentPlaceHolder1_hdfBrowser').attr('value', browserName);







                //$('input[id=hdfIpaddresss]').val(IpAddress);
                //$('input[id=hdfDeviceDetails]').val(DeviceType);
                //$('input[id=hdfBrowser]').val(browserName);



                debugger;
                $.ajax({
                    type: "POST",


                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/MasterHandler.ashx?method=VendorTermsCondition&Comp_Id=' + session,
                    success: function (data) {
                        debugger;
                        var page = "";
                        var resut = data;
                        if (resut == 1) {

                        }
                        else {
                            // Function to open the modal
                            function openModal() {
                                var modal = document.getElementById('modal');
                                modal.style.display = 'block';
                            }

                            // Call the function to open the modal when the window reloads
                            openModal();

                            var myDate = new Date();
                            var curr_date = myDate.getDate();
                            var curr_month = myDate.getMonth();
                            var curr_year = myDate.getFullYear();

                            var fromDate = curr_date + '/' + curr_month + 1 + '/' + curr_year;
                            var Duration = 1;
                            //var Todate = myDate.setFullYear(myDate.getFullYear() + Duration);
                            //var dat = Date.parse(Todate);
                            //var To_date = dat.getDate();
                            //var To_month = dat.getMonth();
                            var To_year = myDate.getFullYear() + Duration;
                            var TillDate = curr_date + '/' + curr_month + 1 + '/' + To_year;
                            var Datetime = myDate.toLocaleString().toString('dd/MM/yyyy HH:mm');


                            //$('#ctl00_ContentPlaceHolder1_lblduration').html(Duration + ' year');
                            //$('#ctl00_ContentPlaceHolder1_lblagreementfrom').html(fromDate);
                            $('#DateandTime').text(Datetime);
                            $('#DateandTime1').text(Datetime);
                            $('#Datetime').text(fromDate);
                            $('#Datefrom').text(fromDate);
                            $('#Dateto').text(TillDate);
                            $('#Datefrom').text(fromDate);
                            $('#Dateto').text(TillDate);


                            $('#Duration').text(Duration + ' year.');




                            var CompanyName = data.split('~')[1];

                            $('#NameofCompany').html(CompanyName);

                            $('#ctl00_ContentPlaceHolder1_lblpartyb').html(CompanyName);
                            $('#PartyB').html(CompanyName);
                            $('#PartyB1').html(CompanyName);
                            $('#PartyB2').html(CompanyName);
                            $('#PartyB3').html(CompanyName);
                            $('#PartyB4').html(CompanyName);
                            $('#PartyB5').html(CompanyName);
                            $('#PartyB6').text(CompanyName);
                            $('#PartyB7').text(CompanyName);
                            $('#PartyB8').text(CompanyName);
                            $('#PartyB9').text(CompanyName);
                            $('#PartyB10').text(CompanyName);
                            $('#PartyB11').text(CompanyName);

                            var DirectorPanNo = data.split('~')[6];
                            if (DirectorPanNo == '')
                            {
                                $("#modal").addClass("app-modal d-none");
                                $("#modal").removeClass("app-modal");
                            }


                            $('#DirectorPanNo').text(DirectorPanNo);

                            var OfficeAddress = data.split('~')[3];
                            if (OfficeAddress == '') {
                                $("#modal").addClass("app-modal d-none");
                                $("#modal").removeClass("app-modal");
                            }

                            $('#OfficeAddress').text(OfficeAddress);

                            var ResidentialAddressofDirector = data.split('~')[7];

                            if (ResidentialAddressofDirector == '') {
                                $("#modal").addClass("app-modal d-none");
                                $("#modal").removeClass("app-modal");
                            }
                            $('#ResidentialAddressofDirector').text(ResidentialAddressofDirector);

                            var DirectorName = data.split('~')[8];
                            if (DirectorName == '') {
                                $("#modal").addClass("app-modal d-none");
                                $("#modal").removeClass("app-modal");
                            }
                            $('#DirectorName').text(DirectorName);

                            var DirectorFatherName = data.split('~')[9];
                          
                            if (DirectorFatherName == '') {
                                $("#modal").addClass("app-modal d-none");
                                $("#modal").removeClass("app-modal");
                            }
                            $('#DirectorFatherName').text(DirectorFatherName);

                            var DirectorAadharNo = data.split('~')[10];
                            if (DirectorAadharNo == '') {
                                $("#modal").addClass("app-modal d-none");
                                $("#modal").removeClass("app-modal");
                            }

                            $('#DirectorAadharNo').text(DirectorAadharNo);

                            var ServiceName = data.split('~')[11];

                            if (ServiceName == '') {
                                $("#modal").addClass("app-modal d-none");
                                $("#modal").removeClass("app-modal");
                            }
                            $('#Servicename').text(ServiceName);





                        }

                        $('#progress').hide();
                    },
                })
            };
        </script>
        <%--Terms and condition Start--%>

    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
            <ContentTemplate>--%>
        <asp:UpdateProgress ID="UpdateProgress1" runat="server"
            DisplayAfter="0">
            <ProgressTemplate>
                <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%; top: 0px; z-index: 999;"
                    class="NewmodalBackground">
                    <div style="margin-top: 300px;" align="center">
                        <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                        <span style="color: White;">Please Wait.....<br />
                        </span>
                    </div>
                </div>
            </ProgressTemplate>
        </asp:UpdateProgress>


        <div id="page-content-wrapper">
            <div class="container-fluid xyz">
                <div class="row">
                    <div class="col-lg-12">
                        <div class="card card-admin form-wizard profile box_card">
                            <header class="card-header">
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Enquiry Detail</h4>
                            </header>

                            <div class="card-body card-body-nopadding">
                                <div class="form-row">
                                    <div class="form-group col-lg-2">
                                        <asp:HiddenField ID="hdfIpaddresss" runat="server" />
                                        <asp:HiddenField ID="hdfDeviceDetails" runat="server" />
                                         <asp:HiddenField ID="hdfBrowser" runat="server" />
                                        <asp:Label ID="lblToatalCashPoints" runat="server"></asp:Label>
                                        <asp:Label ID="lblToatalPoints" runat="server"></asp:Label>
                                        <asp:DropDownList ID="ddlRowProductCnt" runat="server" AutoPostBack="true"
                                            Visible="false">
                                            <asp:ListItem Value="25">25 Rows</asp:ListItem>
                                            <asp:ListItem Value="50">50 Rows</asp:ListItem>
                                            <asp:ListItem Value="100">100 Rows</asp:ListItem>
                                            <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                            <asp:ListItem Value="1000">1000 Rows</asp:ListItem>
                                            <asp:ListItem Value="1001">All Rows</asp:ListItem>
                                        </asp:DropDownList>
                                        <asp:Button ID="btnDownloadExcel" runat="server" Text="Download Report" CausesValidation="false" OnClick="btnDownloadExcel_Click" ValidationGroup="false" CssClass="btn btn-primary btn-block" />

                                    </div>
                                    <div class="form-group col-lg-8"></div>
                                    <div class="form-group col-lg-2">

                                        <asp:Button ID="btnCodeStatus" runat="server" Text="Code Status" CausesValidation="false" OnClick="btnCodeStatus_Click" ValidationGroup="false" CssClass="btn btn-primary btn-block" />
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-lg-2">
                                        <%--<label>Product Name</label>--%>
                                        <asp:DropDownList ID="ddlproname" runat="server" CssClass="form-control form-control-sm" />
                                    </div>

                                    <div class="form-group col-lg-2">
                                        <asp:DropDownList ID="ddlservice" runat="server" CssClass="form-control form-control-sm" />
                                    </div>
                                    <div class="form-group col-lg-2">
                                        <asp:DropDownList ID="ddlMode" runat="server" CssClass="form-control form-control-sm">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="form-group col-lg-2">
                                        <asp:DropDownList ID="ddlStatus" runat="server" CssClass="form-control form-control-sm">
                                            <asp:ListItem Text="--Selest Status--"></asp:ListItem>
                                            <asp:ListItem Text="Success"></asp:ListItem>
                                            <asp:ListItem Text="Unsuccess"></asp:ListItem>
                                        </asp:DropDownList>
                                    </div>
                                    <div class="form-group col-lg-2">
                                        <asp:TextBox ID="txtDateFrom" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateFrom" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                                            ErrorMessage="Please enter valid date." ValidationGroup="servss" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDateFrom" ErrorMessage="Please enter valid date." ValidationGroup="servss" />
                                    </div>
                                    <div class="form-group col-lg-2">
                                        <asp:TextBox ID="txtDateTo" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                        <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateTo" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                                            ErrorMessage="Please enter valid date." ValidationGroup="servss" />
                                        <asp:RequiredFieldValidator runat="server" ControlToValidate="txtDateTo" ErrorMessage="Please enter valid date." ValidationGroup="servss" />
                                    </div>
                                    <div class="form-group col-lg-2">
                                        <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png" ValidationGroup="servss"
                                            ToolTip="Search" OnClick="ImgSearch_Click" />
                                        <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" ToolTip="Reset"
                                            OnClick="ImgRefresh_Click" />
                                    </div>
                                </div>



                                <div class="form-row" style="margin-top: -15px;">



                                    <div class="form-group col-lg-6">
                                        <cc1:CalendarExtender ID="CalendarExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                            Format="dd/MM/yyyy">
                                        </cc1:CalendarExtender>
                                        <cc1:MaskedEditExtender ID="MaskedEditExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                            Mask="99/99/9999" MaskType="Date">
                                        </cc1:MaskedEditExtender>
                                        <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtenderdatefrom" runat="server"
                                            TargetControlID="txtDateFrom" WatermarkText="Enquiry From">
                                        </cc1:TextBoxWatermarkExtender>
                                        <cc1:CalendarExtender ID="CalendarExtender1to" runat="server" TargetControlID="txtDateTo"
                                            Format="dd/MM/yyyy">
                                        </cc1:CalendarExtender>
                                        <cc1:MaskedEditExtender ID="MaskedEditExtender1to" runat="server" TargetControlID="txtDateTo"
                                            Mask="99/99/9999" MaskType="Date">
                                        </cc1:MaskedEditExtender>
                                        <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1to" runat="server" TargetControlID="txtDateTo"
                                            WatermarkText="Enquiry To">
                                        </cc1:TextBoxWatermarkExtender>
                                    </div>
                                </div>

                                <div class="card-admin form-wizard medias">
                                    <!--<div class="row pb-2 pt-2 background-section-form">
                            <div class="col-lg-4">
                                <h4 class="mb-0">Record's Found
                                    <span><asp:Label ID="lblcount" runat="server"></asp:Label><asp:Label ID="lblC" Text="0" runat="server" Visible="false"></asp:Label></span>
                                </h4>
                              <p><span>  Note:  </span>To view more than 100 records, Download Details.</p>
                            </div>
                            <div class="col-lg-4">fv
                                <asp:Label ID="LblMsg" CssClass="small_font" runat="server"></asp:Label>
                            </div>
                        
                        </div>-->
                                    <div class="table-responsive table_large">
                                        <asp:GridView ID="GrdEnquiry" runat="server" AutoGenerateColumns="False" CssClass="table table-striped tblSorting table-bordered Frm_Scrap"
                                            EmptyDataText="Record Not Found" BorderColor="transparent">
                                            <Columns>
                                                <asp:TemplateField HeaderText="Enquiry Date">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblcompname" runat="server" Text='<%# Eval("EnquiryDate") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Product Name">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblproductname" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Enquiry Mode">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblallotcode" runat="server" Text='<%# Bind("ModeOfInquiry") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Enquiry Detail">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblnoCodes" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Code 1">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblBalnoCodes" runat="server" Text='<%# Bind("Received_Code1") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Code 2">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblcdoBalnoCodes" runat="server" Text='<%# Bind("Received_Code2") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Status">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblstatussucc" runat="server" Text='<%# Bind("Successstatus") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>

                                                <asp:TemplateField HeaderText="Sbuid/Rid/Mstar/Technician Id/Tech Master Id">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblTechnician" runat="server" Text='<%# Bind("employeeid") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>
                                                <asp:TemplateField HeaderText="Dealer Code">
                                                    <ItemTemplate>
                                                        <asp:Label ID="lblDistributor" runat="server" Text='<%# Bind("distributorid") %>'></asp:Label>
                                                    </ItemTemplate>
                                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                </asp:TemplateField>
                                            </Columns>
                                            <%--<PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                        <RowStyle CssClass="tr_line1" />
                        <AlternatingRowStyle CssClass="tr_line2" />--%>
                                        </asp:GridView>
                                    </div>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>
        </div>

        <%-- modal --%>
        <style>

             .app-modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 10000;
            }

            .modal-content {
                background-color: #fff;
                position: absolute;
                top: 50%;
                left: 50%;
                transform: translate(-50%, -50%);
                padding: 20px;
                border-radius: 5px;
                box-shadow: 0 2px 10px rgba(0, 0, 0, 0.2);
            }
            /* Styles for the modal container */
            .app-modal .modal {
                display: none;
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background-color: rgba(0, 0, 0, 0.5);
                z-index: 1;
            }

            /* Styles for the modal content */
            .app-modal .modal-dialog {
                height: 550px;
                    width: 100%;
        max-width: 80%;
        overflow: hidden;
            }
             .app-modal .modal-dialog .modal-content{
                 height:450px;
                  padding:0;
             }
             .app-modal .modal-dialog .modal-content .modal-body{
                 padding:0;
             }

            /* Styles for the close button */
            /*.close-btn {
        position: absolute;
        top: 10px;
        right: 10px;
        font-size: 20px;
        cursor: pointer;
    }*/

            /* Styles for the modal header */
            .app-modal .modal-header {
                text-align: center;
                align-items: center;
                /*margin-bottom: 10px;*/
                padding: 8px;
            }

                .app-modal .modal-header h6 {
                    margin-bottom: 0;
                }
            /* Styles for the modal footer */
            .app-modal .modal-footer {
                text-align: center;
                padding: 8px;
                margin-top: 10px;
            }
            .app-modal .modal-body{
                overflow-y:scroll;
            }
            /* Styles for the save and cancel buttons in the footer */
            .app-modal #saveButton, #cancelButton {
                background-color: #008CBA;
                color: #fff;
                padding: 4px 16px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                margin: 5px;
            }

                .app-modal #saveButton:hover, #cancelButton:hover {
                    background-color: #005b84;
                }
                .tandc{
                    font-size:24px;
                    color:#2086d0;
                    margin: 10px 0;
                }

            .app-modal .close-btn {
                background-color: transparent;
                font-size: 24px;
                padding:0;
            }
        </style>
       
        <div class="app-modal" id="modal">
            <div class="modal-dialog modal-dialog-scrollable">

           
                <asp:Panel  runat="server" ID="pnl1">
        <div class="modal-content">
            <!-- Modal content here -->
         <h6 style="text-align:center;font-weight: 800; color: #000;" class="tandc">Terms and Conditions</h6> 
          
                    <div class="modal-body" id="DivAgreement" runat="server">
                        <div class="document-1">
            <div class="over-box p-3">
           
                <p style="color:#000;margin-bottom:10px;">
                    Standard End User License Agreement (EULA) for VCQRU Product
                    Genuineness Enquiry System and Business Promotion Software
                    Services &amp; Dealer Employee KYC Process and Anti counterfeit &amp;
                    Loyalty
                </p>
                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">User Agreement: Acceptance of Terms</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    <span style="font-weight: 800; color: #000;">
                        PLEASE READ CAREFULLY BEFORE USING THE SERVICES PROVIDED BY VCQRU AND ITS
                        PRODUCT LABEL (PRODUCT):
                    </span> This End-User License Agreement (&quot;EULA&quot;) is a legal
                    agreement between (a) VCQRU (Brand owned by VCQRU Private Limited) and (b) you (either an
                    individual or a single entity) that governs your use of any Software Product, installed on or
                    made available by VCQRU.
                </p>
                <p style="line-height: 1.5;margin-bottom:10px;">THIS AGREEMENT EXECUTED at Sector-74 , Gurgaon on <span style="color: #ff0000;" id="DateandTime1">DateandTime</span>,Between</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    M/s <b style="font-size:16px;color:#000">VCQRU Private Limited</b> (Pan No. number: AAICV2277K) Office Unit No. 1502-1503, Tower-4,
                    15 th Floor, DLF Corporate Green, Sector-74A, Southern peripheral Road, Gurugram-122004 through its
                    authorized Signatory Mr. Rakesh Kumar (Adhaar No. 9352 2121 9162), S/o Mahender Singh
                    R/o.: H16 GF South city-2, Gurgaon, Haryana-122018. (hereinafter called the (LESSOR) which
                    expression shall unless excluded by or repugnant to the context include his/ her/ their heirs,
                    executors, administrators, representatives and assigns of the first part.
                </p>
                <p>AND</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    M/s <span style="color: #ff0000;" id="NameofCompany">NameofCompany</span> (Pan No.: <span
                        style="color: #ff0000;" id="DirectorPanNo">DirectorPanNo</span>)
                    Office at <span style="color: #ff0000;" id="OfficeAddress">OfficeAddress</span> its authorized Signatory <span
                        style="color: #ff0000;" id="DirectorName">
                        DirectorName
                    </span> (Adhaar No. <span id="DirectorAadharNo">DirectorAadharNo</span>) S/O Mr.<span id="DirectorFatherName">
                        DirectorFatherName
                    </span> R/o.: <span style="color: #ff0000;" id="ResidentialAddressofDirector">ResidentialAddressofDirector</span>
                    (hereinafter called
                    the ‘SECOND PARTY’) of the other part.
                </p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    <strong style="font-size:14px";>
                        BY CLICKING &quot;I AGREE&quot;, OR BY USING THE VCQRU PRODUCT GENUINENESS ENQUIRY
                        SYSTEM AND BUSINESS PROMOTION SOFTWARE SERVICES, YOU (1) REPRESENT THAT
                        YOU ARE OF THE LEGAL AGE OF MAJORITY IN YOUR COUNTRY, STATE, PROVINCE
                        JURISDICTION OF RESIDENCE AND, IF APPLICABLE, YOU ARE DULY AUTHORIZED BY
                        YOUR EMPLOYER TO ENTER INTO THIS CONTRACT AND (2) YOU AGREE TO BE BOUND
                        BY THE TERMS OF THIS EULA. IF YOU DO NOT ACCEPT THE EULA TERMS, DO NOT USE
                        THE VCQRU PRODUCT GENUINENESS ENQUIRY SYSTEM AND BUSINESS PROMOTION
                        SOFTWARE SERVICES.
                    </strong>
                </p>
                <p style="color:#000;margin-bottom:10px;">
                    This Agreement shall remain effective from <span style="color: #ff0000;" id="Datefrom">Datefrom</span> to <span
                        style="color: #ff0000;"  id="Dateto">Dateto</span> for
                    <span style="color: #ff0000;" id="Duration">Duration</span>
                </p>

                <p style="line-height: 1.5;margin-bottom:10px;">
                    <span style="font-weight: 800; color: #000;">
                        This User Agreement constitutes a binding contract between you, Party A (VCQRU Pvt Ltd) and 
                        <span style="color: #ff0000;" id="PartyB">
                            VendorName
                        </span> with regard to the use of various services that are provided by VCQRU.
                </p>

                <p style="line-height: 1.5;margin-bottom:10px;">
                    1.1 VCQRU Private Limited a Company Incorporated under the “The Companies Act-2013”, with its principal
                    office at <b style="font-size:16px";>
                        Unit No. 1502-1503, Tower-4, 15 th Floor, DLF Corporate Green, Sector-74A, Southern peripheral
                        Road, Gurugram-122004,
                    </b> Haryana provides various product genuineness enquiry and Business promotion
                    related software services through its Website ( www.vcqru.com), Twitter account, Facebook account,
                    Google +
                    account, other social media accounts, mobile-cellular technology, post/courier as well as through its
                    call-
                    center.
                </p>


                <p style="line-height: 1.5;margin-bottom:10px;">
                    1.2 VCQRU shall provide you (&quot;<span style="color: #ff0000;" id="PartyB1">VendorName</span>
                    &quot;) a method and enabling mechanism
                    through its website, printed labels and services so that purchasers of your product (“consumers”) on
                    their own
                    through VCQRU, Product genuineness inquiry related services can obtain details inter alia, genuineness
                    of
                    product, name of product, name of manufacturer, Maximum retail price (MRP), date of manufacturing, date
                    of
                    expiry, batch number, customized business promotion message from manufacturer throughout India
                    (&quot;Service/s
                    or VCQRU Services&quot;). These Services may be availed by the Manufacturer and Consumers in India or
                    abroad
                    as per the purchase order conditions with you.
                </p>
                <p style="line-height: 1.5;margin-bottom:24px;">
                    1.3 VCQRU provides Users a facility to know if the product they have purchased is actually
                        manufactured by
                    the Manufacturer it claims or it is a fake, duplicate of the original product. It does not comment on
                    the quality of
                    the product. VCQRU also provides various business promotional services for your sales promotion and
                    loyalty
                    building. The information would be provided on the basis of the coupon generated and printed by VCQRU of
                    provided quantity and the production and supply chain should follow the process provided by VCQRU.
                </p>

                <p style="line-height: 1.5;margin-bottom:24px;">
                    1.4 The product genuineness inquiry services utilize use of a scratch label pasted on the product with
                    precoding
                    at your (manufacturer) end. The codes on the scratch labels are sent by Manufacturer to command center
                    for
                    verification. The system works on the premise that the fake/counterfeit/spurious/duplicate product
                    producers
                    cannot economically produce fakes/counterfeit/spurious/duplicate products without purchasing an original
                    genuine product as they will not be able to match the codes on the scratch labels. However, in one event
                    when
                    the codes of scratch label of a genuine original product without verification are used on
                    duplicate/fake/counterfeit/spurious product, then the same may get passed from the system. Hence, fake
                    product
                    can pass through the system only when one original product is purchased by fake producers. However, this
                    cannot be done for many products due to economic loss to duplicate/fake/counterfeit /spurious producers
                    as
                    they have to buy one original for one duplicate. The fake manufacturers will not setup their production
                    facility at
                    huge cost to produce without knowing correct codes. The Manufacturer fully understands this and accepts
                    this
                    while using the services.
                </p>
                <p style="line-height: 1.5;margin-bottom:24px;">
                    1.5 This User Agreement (“Agreement”) is applicable to all VCQRU Services. In addition to this Agreement
                    and
                    depending on the Services opted for by the Manufacturer, the Manufacturer may be required to read and
                    accept
                    the relevant terms and conditions of service for each such Service, which may be updated or modified by
                    VCQRU
                </p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    1.6 VCQRU Services are offered to the User conditioned on acceptance without modification of all the
                    terms,
                    conditions and notices contained in this Agreement, as may be posted on the Website from time to time.
                    For the
                    removal of doubts, it is clarified that availing of the Services by the User constitutes an
                    acknowledgement and
                    acceptance by the User of this Agreement. If the User does not agree with any part of such terms,
                    conditions
                    and notices, the User must not avail VCQRU Services.
                </p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    1.7 Additionally, the Manufacturer (<span style="color: #ff0000;" id="PartyB2">VendorName</span>)
                    itself may provide terms and guidelines
                    that govern use or the operating rules and policies applicable to each product sold having VCQRU product
                    genuineness inquiry facility and business promotional services. The consumer shall be responsible for
                    ensuring compliance with the terms and guidelines or operating rules and policies of the product
                    purchased.
                </p>

                <p style="line-height: 1.5;margin-bottom:10px;">
                    1.8 Any contract to provide any service by VCQRU is not complete until full due payment as per purchase
                    order
                    towards the service, if applicable, is received from the Manufacturer and accepted by VCQRU.
                </p>
                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:24px;">2. Modification of Terms</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    VCQRU reserves the right to change the terms, conditions and notices under which the Services are
                    offered
                    through the Website, including but not limited to the charges for the Services provided through the
                    Website. The
                    Manufacturer shall be responsible for regularly reviewing these terms and conditions.
                </p>
                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">3. Privacy Policy</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    The Manufacturer hereby consents, expresses and agrees that he has read and fully understands the
                    Privacy
                    Policy of VCQRU. The Manufacturer further consents that the terms and contents of such Privacy Policy
                    are
                    acceptable to him.
                </p>
                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:24px;">4. Limited User</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    4.1 The Manufacturer agrees and undertakes not to sell, trade or resell or exploit for any commercial
                    purposes,
                    any portion of the Service. For the removal of doubt, it is clarified that VCQRU Services, including the
                    use of the
                    Website, is not for commercial use but is specifically meant for personal use only.
                </p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    4.2 The Manufacturer further agrees and undertakes not to reverse engineer, modify, copy, distribute,
                    transmit,
                    display, perform, reproduce, publish, license, create derivative works from, transfer, or sell any
                    information,
                    software, products or services obtained from the Website. Limited reproduction and copying of the
                    content of the
                    Website is permitted provided that the VCQRU &#39;s name is stated as the source. For the removal of
                    doubt, it is
                    clarified that unlimited or wholesale reproduction, copying of the content for commercial or
                    non-commercial
                    purposes and unwarranted modification of data and information within the content of the Website is not
                    permitted.
                </p>

                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">5. Disclaimer of Warranties/Limitation of Liability</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    5.1 VCQRU has endeavored to ensure that all the information provided by it is correct, but VCQRU neither
                    warrants nor makes any representations regarding the quality, accuracy or completeness of any data or
                    information. VCQRU makes no warranty, express or implied, concerning the Website and/or its contents and
                    disclaims all warranties of fitness for a particular purpose and warranties of merchantability in
                    respect of services,including any liability, responsibility or any other claim, whatsoever, in respect
                    of any loss, whether direct or
                    consequential, to any User or any other person, arising out of or from the use of any such information.
                </p >
                <p style="line-height: 1.5;margin-bottom:10px;">
                    5.2 To the extent VCQRU acts only as a facilitator of Services on information of product on behalf of
                    third party
                    product manufacturers, it shall not have any liability whatsoever for any aspect of the arrangements
                    between the
                    product manufacturers and the consumers as regards the standards and rendering of services by the
                    products
                    of these manufacturers. In no circumstances shall VCQRU be liable for the services provided by the
                    products.
                </p>
                <p style="line-height: 1.5;margin-bottom:24px;">
                    5.3 Although VCQRU makes reasonable commercial efforts to ensure that the description and content on
                    each
                    page of the Website is correct, it does not, however, takes responsibility for changes that occurred due
                    to human
                    or data entry errors or for any loss or damages suffered by any User due to any information contained
                    herein.
                    Also, VCQRU is not the original product manufacturer and cannot therefore control or prevent changes in
                    the
                    published descriptions or representations, which are always based upon information provided by the
                    manufacturers. VCQRU acts only as a facilitator of product related information between manufacturer and
                    user
                    and shall not be held liable for any changes, deficiencies, disputes, etc. related to the products being
                    provided
                    by product manufacturers, including the matters related to product warranty / guarantee / refund /
                    delays offered
                    by product manufacturers.
                </p>
                <p style="line-height: 1.5;margin-bottom:24px;">
                    5.4 VCQRU does not endorse any advertiser on its website in any manner. The Manufacturer s are requested
                    to verify the accuracy of all information on their own before undertaking any reliance on such
                    information.
                </p>

                <p style="line-height: 1.5;margin-bottom:24px;">
                    5.5 VCQRU does not, by offering product genuineness inquiry services or business promotional services to
                    particular product, represent or warrant that use of such product is without risk, and shall not be
                    liable for
                    damages or losses that may result from use of such products.
                </p>

                <p style="line-height: 1.5;margin-bottom:24px;">
                    5.6 VCQRU shall take responsibility for any direct losses, costs, consequences that the Manufacturer may
                    suffer on account of deficiency in service, if any, under this agreement. However, VCQRU’s Liability is
                    limited to
                    the extent of the data received for the purpose of KYC and other Services.
                </p>
                <p style="line-height: 1.5;margin-bottom:24px;">
                    Neither shall VCQRU be responsible for the delay or inability to use/avail the Website or Services, the
                    provision
                    of or failure to provide services by product manufacturers, or for any information, software, products,
                    services
                    and related graphics obtained from VCQRU, whether based on contract, tort, negligence, strict liability
                    or
                    otherwise. Further, VCQRU shall not be held responsible for non-availability of the website during
                    periodic
                    maintenance operations or any unplanned suspension of access to the services that may occur due to
                    technical
                    reasons or for any reason beyond VCQRU’s control. Subject to VCQRU giving minimum assurance about its
                    reasonable precautions to keep its website and data thereon free from any malware. The Manufacturer
                    understands and agrees that any material and/or data downloaded or otherwise obtained from Website/VCQRU
                    is done entirely at their own discretion and risk and they will be solely responsible for any damage to
                    their
                    computer systems or any other loss that results from such material and/or data.
                </p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    The maximum liability on part of VCQRU arising under any circumstances, in respect of any Services
                    availed,
                    shall be limited up to a maximum of the refund of total amount received from the Manufacturer for
                    providing the
                    services less any cancellation, refund or others charges, as may be applicable. In no case VCQRU shall
                    be liable
                    for any consequential loss, damage or additional expense whatsoever. In no event VCQRU shall be liable
                    for
                    any kind of refunds/returns of charges/fee paid consumer to product manufacturer for dispute related to
                    quality
                    or manufacturing defects of the product.
                </p>
                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">6. Links to Third Party Sites</p>
                <p style="line-height: 1.5;margin-bottom:24px;">
                    6.1 The Website may contain links to other websites (&quot;Linked Sites&quot;). The Linked Sites are not
                    under the control
                    of VCQRU or the Website and VCQRU is not responsible for the contents of any Linked Site, including
                    without
                    limitation any link contained in a Linked Site, or any changes or updates to a Linked Site. VCQRU is not
                    responsible for any form of transmission, whatsoever, received by the Manufacturer from any Linked Site.
                    VCQRU is providing these links to the Manufacturer only as a convenience, and the inclusion of any link
                    does
                    not imply endorsement by VCQRU or the Website of the Linked Sites or any association with its operators
                    or
                    owners including the legal heirs or assigns thereof.
                </p>

                <p style="line-height: 1.5;margin-bottom:24px;">
                    6.2 VCQRU is not responsible for any errors, omissions or representations on any Linked Site. VCQRU does
                    not endorse any advertiser on any Linked Site in any manner. The Manufacturer s are requested to verify
                    the
                    accuracy of all information on their own before undertaking any reliance on such information.
                </p>

                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:24px;">7. Prohibition against Unlawful Use</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    As a condition of the use of the Website, the Manufacturer warrants that they will not use the Website
                    for any
                    purpose that is unlawful or illegal under any law for the time being in force within or outside India or
                    prohibited
                    by this Agreement including both specific and implied. In addition, the Website shall not be used in any
                    manner,
                    which could damage, disable, overburden or impair it or interfere with any other party&#39;s use and/or
                    enjoyment of
                    the Website. The Manufacturer shall refrain from obtaining or attempting to obtain any materials or
                    information
                    through any means not intentionally made available or provided for or through the Website.
                </p>
                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:24px;">8. Use of Communication Services</p>
                <p style="line-height: 1.5;">
                    8.1 The Website may contain services such as email, chat, bulletin board services, information related
                    to various
                    products, news groups, forums, communities, personal web pages, calendars, and/or other message
                    (hereinafter
                    collectively referred to as &quot;Communication Services&quot;).
                </p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    The Manufacturer agrees and undertakes to use the Communication Services only to post, send and receive
                    messages and material that are proper and related to the Communication Service. By way of example, and
                    not
                    as a limitation, the Manufacturer agrees and undertakes that when using a Communication Service, the
                    Manufacturer will not:
                </p>

                <ol type="a">
                    <li>defame, abuse, harass, stalk, threaten or otherwise violate the legal rights of others;</li>
                    <li>
                        publish, post, upload, distribute or disseminate any inappropriate, profane, defamatory, infringing,
                        obscene, indecent or unlawful topic, name, material or information;
                    </li>
                    <li>
                        upload files that contain software or other material protected by intellectual property laws unless
                        the
                        Manufacturer owns or controls the rights thereto or have received all necessary consents;
                    </li>
                    <li>
                        upload or distribute files that contain viruses, corrupted files, or any other similar software or
                        programs
                        that may damage the operation of the Website or another&#39;s computer
                    </li>
                    <li>
                        advertise or offer to sell or buy any goods or services for any business purpose, unless such
                        Communication Service specifically allows such messages;
                    </li>
                    <li>conduct or forward surveys, contests, pyramid schemes or chain letters;</li>
                    <li>
                        download any file posted by another Manufacturer of a Communication Service that the Manufacturer
                        know, or reasonably should know, cannot be legally distributed in such manner;
                    </li>
                    <li>
                        falsify or delete any author attributions, legal or other proper notices or proprietary designations
                        or labels
                        of the origin or source of software or other material contained in a file that is uploaded;
                    </li>
                    <li>
                        violate any code of conduct or other guidelines, which may be applicable for or to any particular
                        Communication Service;
                    </li>
                    <li>violate any applicable laws or regulations for the time being in force in or outside India; and</li>
                    <li>
                        violate any of the terms and conditions of this Agreement or any other terms and conditions for the
                        use
                        of the Website contained elsewhere herein.
                    </li>


                </ol>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    8.2 VCQRU will review materials posted through Communication Service and shall remove any materials in
                    consultation with Manufacturer. VCQRU reserves the right to terminate the Manufacturer &#39;s access to
                    any or all
                    of the Communication Services at any time with reasonable advance notice.
                </p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    8.3 VCQRU reserves the right at all times to disclose any information as is necessary to satisfy or
                    comply with
                    any applicable law, regulation, legal process or governmental request, or to edit, refuse to post or to
                    remove any
                    information or materials, in whole or in part, in VCQRU’s sole discretion. VCQRU will not disclose to /
                    share any
                    of its service user’s data with Third Parties, Political Parties &amp; Competitors.
                </p>

                <p style="line-height: 1.5;margin-bottom:24px;">
                    8.4 VCQRU does not control or endorse the content, messages or information found in any communication
                    service and, therefore, VCQRU specifically disclaims any liability or responsibility whatsoever
                    regarding the
                    communication services and any actions resulting from the Manufacturer’s participation in any
                    communication
                    service.
                </p>
                <p style="line-height: 1.5;margin-bottom:24px;">
                    8.5 Materials uploaded to a Communication Service may be subject to posted limitations on usage,
                    reproduction
                    and/or dissemination. Manufacturer is responsible for keeping himself updated of and adhering to such
                    limitations if they download the materials.
                </p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    8.6 When you register with VCQRU, we or any of our partners/affiliate/group companies may contact you
                    from
                    time to time to provide the offers/information of such products/services that we believe may benefit
                    you.
                </p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    8.7 After receipt of material, in case of any issue in material you need to report us back about the
                    same within
                    24 to 48 hours. VCQRU will not be responsible if the report about material issue will be received after
                    given time.
                </p>


                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">9. Termination/Access Restriction</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    VCQRU reserves the right, in its sole discretion, to terminate the access to the website and the related
                    services
                    or any portion thereof at any time, without notice in the event of default of purchase order conditions
                    or as per
                    orders from Government agencies.
                </p>

                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">10. Fees Payment</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    10.1 VCQRU reserves the right to charge fees for its services and products, as well as transaction fees
                    based
                    on certain completed transactions using the VCQRU Services. VCQRU further reserves the right to alter
                    any
                    and all fees from time to time, without notice.
                </p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    10.2 The Manufacturer shall be liable to pay all applicable charges, fees, duties, taxes, levies and
                    assessments
                    for availing the VCQRU Services.
                </p>


                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:34px;">11. Manufacturer&#39;s Obligations and User Account</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    11.1 The Manufacturer represent and confirm that the Manufacturer has the requisite authority to enter
                    into a
                    binding contract and is not a person barred from availing the Services under the laws of India or other
                    applicable
                    law.
                </p>
                <p style="line-height: 1.5;margin-bottom:24px;">
                    11.2 To avail a Service through the Website, the Manufacturer has and must continue to maintain at his
                    sole
                    cost: (a) all the necessary equipment’s including a computer and modem etc. to access the Website/avail
                    Services; (b) own access to the World Wide Web. The Manufacturer shall be responsible for accessing the
                    Services and that access may involve third party fees including, airtime charges or internet service
                    provider’s
                    charges which are to be exclusively borne by the Manufacturer.
                </p>
                <p style="line-height: 1.5;margin-bottom:24px;">
                    11.3 The Manufacturer also understands that the Services may include certain communications from VCQRU
                    as Service announcements and administrative messages. The Manufacturer understands and agrees that the
                    Services are provided on an &quot;as is&quot; basis and that VCQRU does not assume any responsibility
                    for deletions,
                    mis-delivery or failure to store any Manufacturer communications or personalized settings.
                </p>

                <p style="line-height: 1.5;margin-bottom:24px;">
                    11.4 The Manufacturer also agrees to: (a) provide true, accurate and complete information about himself
                    and
                    his beneficiaries as prompted by the registration form (&quot;Registration Data&quot;) on the Website;
                    and (b) maintain and
                    promptly update the Registration Data to keep it true, accurate, current and complete. If the
                    Manufacturer provide
                    any information that is untrue, inaccurate, not current or incomplete or VCQRU has reasonable grounds to
                    suspect that such information is untrue, inaccurate, not current or incomplete, VCQRU has the right to
                    suspend
                    or terminate the Manufacturer &#39;s registration and refuse any and all current or future use of the
                    Website and/or
                    any Service.
                </p>

                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">12. Breach</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    12.1 Without prejudice to the other remedies available to VCQRU under this agreement, or under
                    applicable law,
                    VCQRU may limit the Manufacturer &#39;s activity, or end the Manufacturer &#39;s listing, warn other
                    Manufacturer s of
                    the Manufacturer &#39;s actions, immediately temporarily/indefinitely suspend or terminate the
                    Manufacturer &#39;s
                    registration, and/or refuse to provide the Manufacturer with access to the website if:
                </p>
                <ol type="a">
                    <li>the Manufacturer is in breach of this agreement, and/or the documents it incorporates by reference;
                    </li>
                    <li>VCQRU is unable to verify or authenticate any information provided by the Manufacturer, or</li>
                    <li>
                        VCQRU believes that the Manufacturer &#39;s actions may infringe on any third-party rights or breach
                        any
                        applicable law or otherwise result in any liability for the Manufacturer, other Manufacturer s of
                        the website and/or
                        VCQRU.
                    </li>
                </ol>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    12.2 VCQRU may at any time in its sole discretion reinstate suspended Manufacturer s. Once the
                    Manufacturer
                    have been indefinitely suspended the Manufacturer may not register or attempt to register with VCQRU or
                    use
                    the website in any manner whatsoever until such time that the Manufacturer is reinstated by VCQRU.
                    Notwithstanding the foregoing, if the Manufacturer breaches this agreement, or the documents it
                    incorporates
                    by reference, VCQRU reserves the right to recover any amounts due and owing by the Manufacturer to VCQRU
                    and/or the product manufacturer and to take strict legal action as VCQRU deems necessary.
                </p>

                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">13. Proprietary Rights</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    13.1 VCQRU may provide the Manufacturer with content such as sound, photographs, graphics, video or
                    other
                    material contained in sponsor advertisements or information. This material may be protected by
                    copyrights,
                    trademarks or other intellectual property rights and laws. The Manufacturer may use this material only
                    as
                    expressly authorized by VCQRU and shall not copy, transmit or create derivative works of such material
                    without
                    express authorization from VCQRU.
                </p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    13.2 The Manufacturer acknowledges and agrees that they shall not upload, post, reproduce or distribute
                    any
                    content on or through the Website that is protected by copyright or other proprietary right of a third
                    party, without
                    obtaining the permission of the owner of such right. Any copyrighted or other proprietary content
                    distributed on
                    or through the Website with the consent of the owner must contain the appropriate copyright or other
                    proprietary
                    rights notice. The unauthorized submission or distribution of copyrighted or other proprietary content
                    is illegal
                    and could subject the Manufacturer to personal liability or criminal prosecution.
                </p>

                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:48px;">14. Relationship</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    None of the provisions of this Agreement, terms and conditions, notices or the right to use the Website
                    by the
                    Manufacturer contained herein or any other section or pages of the Website and/or the Linked Sites,
                    shall be
                    deemed to constitute a partnership between the Manufacturer and VCQRU and no party shall have any
                    authority
                    to bind or shall be deemed to be the agent of the other in any way. It may be noted, however, that if by
                    using the
                    Website, the Manufacturer authorizes VCQRU and its agents to access third party sites designated by them
                    or
                    on their behalf for retrieving requested information, the Manufacturer shall be deemed to have appointed
                    VCQRU
                    and its agents as their agent for this purpose.
                </p>

                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">15. Headings</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    The headings and subheadings herein are included for convenience and identification only and are not
                    intended
                    to describe, interpret, define or limit the scope, extent or intent of this Agreement, or the right to
                    use the Website
                    by the Manufacturer contained herein or any other section or pages of the Website or any Linked Sites in
                    any
                    manner whatsoever.
                </p>

                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">16. Interpretation of Number and Genders</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    The terms and conditions herein shall apply equally to both the singular and plural form of the terms
                    defined.
                    Whenever the context may require, any pronoun shall include the corresponding masculine and feminine.
                    The
                    words &quot;include&quot;, &quot;includes&quot; and &quot;including&quot; shall be deemed to be followed
                    by the phrase &quot;without limitation&quot;.
                    Unless the context otherwise requires, the terms &quot;herein&quot;, &quot;hereof&quot;,
                    &quot;hereto&quot;, &quot;hereunder&quot; and words of similar
                    import refer to this Agreement as a whole.
                </p>
                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">17. Indemnification</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    The Parties agree to indemnify, defend and hold harmless each other from and against any and all losses,
                    liabilities, claims, damages, costs and expenses (including legal fees and disbursements in connection
                    therewith
                    and interest chargeable thereon) asserted against or incurred by such Party by any third party or
                    consumer that
                    arise out of, result from, or may be payable by virtue of, any breach or non-performance of any
                    representation,
                    warranty, covenant or agreement made or obligation to be performed by the Parties pursuant to this
                    Agreement.
                    The Manufacturer also agrees that VCQRU shall not be liable for any and all losses, liabilities, claims,
                    damages,
                    costs and expenses (including legal fees and disbursements in connection therewith and interest
                    chargeable
                    thereon) for delay, non-delivery of results or messages due to malfunction of third party operator’s
                    services like
                    internet services, SMS services, social media services, email / fax services etc. which are beyond the
                    control of
                    VCQRU.
                </p>

                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:24px;">18. Severability</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    If any provision of this Agreement is determined to be invalid or unenforceable in whole or in part,
                    such invalidity
                    or unenforceability shall attach only to such provision or part of such provision and the remaining part
                    of such
                    provision and all other provisions of this Agreement shall continue to be in full force and effect.
                </p>

                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">19. Termination of Agreement and Services</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    19.1 Either the Manufacturer or VCQRU may terminate this Agreement and a Service with or without cause
                    at
                    any time to be effective after a period of 3 months.
                </p>

                <p style="line-height: 1.5;margin-bottom:10px;">
                    19.2 The Manufacturer agrees that VCQRU may under certain circumstances and without prior notice,
                    immediately terminate the Manufacturer &#39;s Manufacturer id and access to the Website/Services. Causes
                    for
                    termination may include, but shall not be limited to, breach by the Manufacturer of this Agreement,
                    requests by
                    enforcement or government agencies, requests by the Manufacturer, non-payment of fees owed by the
                    Manufacturer in connection with the Services.
                </p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    19.3 This Agreement may be terminated by either the Manufacturer or VCQRU through a written notice to
                    the
                    other. VCQRU shall not be liable to the Manufacturer or any third party for termination of any Service.
                    Should
                    the Manufacturer object to any terms and conditions of this Agreement, or become dissatisfied with the
                    Service
                    in any way, the Manufacturer &#39;s only recourse is to immediately: (a) discontinue use of the
                    Website/Service; and
                    (b) notify VCQRU of such discontinuance.
                </p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    19.4 Upon termination of the Service, Manufacturer &#39;s right to use the Website/Services and software
                    shall
                    immediately cease. The Manufacturer shall have no right and VCQRU shall have no obligation thereafter to
                    execute any of the Manufacturer &#39;s uncompleted tasks or forward any unread or unsent messages to the
                    Manufacturer or any third party. Once the Manufacturer &#39;s registration or the Services are
                    terminated, cancelled
                    or suspended, any data that the Manufacturer has stored on the Website may not be retrieved later.
                </p>



                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">20. Notices</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    All notices and communications (including those related to changes in the agreement, Service,
                    termination of
                    Service etc.,) shall be in writing, in English and shall deemed given if delivered personally or by
                    commercial
                    messenger or courier service, or mailed by registered or certified mail (return receipt requested) or
                    sent via
                    email/facsimile (with acknowledgment of complete transmission) to the following address:
                </p>

                <ol type="a" style="line-height: 1.5;margin-bottom:24px;">
                    <li>If to VCQRU, at accounts@vcqru.com / info@vcqru.com, and/or at the address posted on the Website.
                    </li>
                    <li>
                        If to a non-registered Manufacturer, at the communication and/or email address specified in the
                        application form availing of a VCQRU Service.
                    </li>
                    <li>
                        If to a registered Manufacturer, at the communication and/or email address specified in the
                        registration
                        form. Notice shall be deemed to have been served 48 hours after it has been sent, dispatched,
                        displayed,
                        as the case may be, unless, where notice has been sent by email, it comes to the knowledge of the
                        sending party, that the email address is invalid.
                    </li>

                </ol>

                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:24px;">21. Governing Law</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    This agreement shall be governed by and constructed in accordance with the laws of India without
                    reference to
                    conflict of laws principles and disputes arising in relation hereto shall be subject to the exclusive
                    jurisdiction of
                    the courts of Gurugram, Haryana.
                </p>

                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">22. Proposal Outline</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    This proposal outlines the scope of work for the implementation of an <span
                        style="color: #ff0000;" id="Servicename">(Servicename)</span> for <span style="color: #ff0000;" id="PartyB3">
                       VendorName
                    </span> . The goal of this project is to safeguard the authenticity of <span style="color: #ff0000;" id="PartyB4">
                        VendorName
                    </span>’s products and provide end-users with a reliable means of verifying the authenticity of the
                    products they purchase.
                </p>

                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">23. Services</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    23.1 <b style="font-size:16px";>Build Loyalty Service:</b> - We are providing an <span style="color: #ff0000;">App-based / Web
                        Based</span> solution of build loyalty services.
                    In this, we provide smart coupons codes to <span style="color: #ff0000;" id="PartyB5">VendorName</span> (If we are taking care of
                    Printing), and against each coupon code, we are giving a certain amount as a benefit. The User gets the
                    coupon code on the product they have bought and they verify the coupon using the VCQRU platform
                    (App/Website/IVR/ SMS). Once they enter their Required Details points against their coupon code get
                    added to
                    their wallet. As per the gift table the users can claim the benefit and it will be redeemed as per the
                    initial
                    requirement (UPI/ Bank Transfer/ Gift provided by <span style="color: #ff0000;" id="PartyB6">VendorName</span>
                </p>

                <p style="line-height: 1.5;margin-bottom:10px;">
                    23.2 <b style="font-size:16px";>Anti-Counterfeit Service:- </b> We generate, and provide smart coupons codes to <span
                        style="color: #ff0000;" id="PartyB7">VendorName</span> which can be pasted on their products.
                    Through this coupon they can verify that they are
                    purchasing the genuine product of <span style="color: #ff0000;" id="PartyB8">VendorName</span>. It
                    can be helpful for the management as
                    well because through which they can have the data of the actual end users.
                </p>
                <p style="line-height: 1.5;margin-bottom:24px;">
                    23.3 E Warranty: We generate, and provide smart coupons codes to <span style="color: #ff0000;" id="PartyB11">VendorName</span> which
                    can be pasted on their products. Through this coupon they can validate the date of purchase on the basis
                    of
                    which they can claim the warranty further. It can be helpful for the management as well because through
                    which
                    they can have the data of the actual end users.
                </p>
                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:24px;">24. Payment Term Agreement</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    This Payment Term Agreement (&quot;Agreement&quot;) is entered into between VCQRU PVT LTD and <span
                        style="color: #ff0000;" id="PartyB9">
                        VendorName
                    </span> on <span style="color: #ff0000;" id="DateandTime">DateandTime</span>
                </p>
                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:14px;">Payment Terms:</p>
                <ol type="1">
                    <li><b style="font-size:16px";>Payment Due Date: </b>All payments are due within 30 days from the date of invoice for eligible
                        clients only.</li>
                    <li>
                        <b style="font-size:16px";>Late Payment Penalties:</b>Late payments will incur a late fee of 2% per month on the outstanding
                        balance.
                    </li>
                    <li>
                        <b style="font-size:16px";>Payment Methods:</b> Payment should be made through by A/c payees’ cheque or NEFT/RTGS or
                        electronic funds transfer.
                    </li>
                    <li>
                        <b style="font-size:16px";>Deposit or Advance Payment:</b>A deposit or advance payment of 50% is required prior to delivery
                        of
                        materials. This deposit will be applied to the final invoice or refunded as per the terms of the
                        agreement. A
                        50% deposit or advance must be pay before start the job work and rest 50% is required before
                        delivery of
                        the materials at least for first three orders.
                    </li>
                    <li></li>
                </ol>

                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">Invoicing for Material:</p>
                <ol type="1">
                    <li><b style="font-size:16px";>Frequency:</b>Invoices will be issued at the time of Dispatching material in case of Item invoice
                    </li>
                    <li><b style="font-size:16px";>Delivery:</b></li>
                    <li>
                        <b style="font-size:16px";>Invoice Submission:</b>Client shall make payment based on the invoiced amount within the
                        specified
                        payment terms as mentioned above.
                    </li>

                </ol>

                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">Payment terms for IT Services:</p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    <b style="font-size:16px";>
                        The following payment milestones for our projects to ensure a transparent and structured payment
                        process:
                    </b>
                </p>
                <ol>
                    <li>
                        <b style="font-size:16px";>Initial Deposit/Advance payment:</b>A non-refundable initial deposit of 20% of the total project
                        cost will
                        be due upon signing the service agreement. This payment will secure our commitment to the project
                        and initiate the necessary preparations.
                    </li>
                    <li>
                        <b style="font-size:16px";>Milestone 1: Design Approval:</b>20% of the total project cost will be invoiced upon completion
                        of the
                        project&#39;s initial phase which is design approval.
                    </li>
                    <li><b style="font-size:16px";>Milestone 2: First Demo:</b>20% of the total project cost will be invoiced after the first demo.
                    </li>
                    <li>
                        <b style="font-size:16px";>Milestone 4: Final Demo:</b>30% of the total project cost will be invoiced after the final demo
                        and go
                        live approval, this invoice should be approved before making the project live.
                    </li>
                    <li><b style="font-size:16px";>Milestone 5:</b>Final Payment10% of the total project cost will be invoiced after making the
                        project live.</li>
                    <li>
                        <b style="font-size:16px";>Annual Maintenance charges:</b>We are delighted to offer a complimentary 6-month bug support
                        period for all our projects. This support period commences from the date of project go-live. After
                        this
                        duration, in order to continue providing ongoing support, we kindly request our clients to avail our
                        paid
                        support services. This support package covers minor cosmetic changes as well as bug support. This
                        charge can be calculated on the basis of project and its execution requirements.
                    </li>
                    <li style="line-height: 1.5;margin-bottom:24px;">
                        <b style="font-size:16px";>Change Request Charges:</b>For any change requests beyond the initial bug support period, we will
                        review each request and provide a detailed cost and time estimation. Once the change request is
                        approved by the client, we will proceed with invoicing the corresponding charges. Upon receipt of
                        payment, our dedicated development team will be promptly assigned to address the requested
                        changes.
                    </li>
                    <li style="line-height: 1.5;margin-bottom:24px;">
                        We believe this approach allows us to maintain the highest level of service and dedication to our
                        clients while ensuring the sustainability of our support operations. By clearly defining the scope
                        and
                        costs associated with post-support period changes, we can efficiently allocate our resources and
                        deliver timely solutions.
                    </li>
                </ol>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    All payment needs to release against the invoices immediately to start the next milestone.
                    We believe that these payment milestones will provide a fair and balanced approach to ensure the timely
                    completion of the project while aligning with the value delivered at each stage. The exact payment
                    terms, due
                    dates, and any applicable taxes will be clearly outlined in the formal agreement or contract.
                </p>

                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">Disputed Invoices:</p>
                <ol type="I">
                    <li>
                        <b style="font-size:16px";>Resolution Process:</b>In case of any dispute related to an invoice, the Client shall promptly
                        notify the
                        Company in writing within 7 days of receiving the invoice.
                    </li>
                    <li>
                        <b style="font-size:16px";>Review and Resolution:</b>The Company and the Client will work together in good faith to resolve
                        the
                        dispute within a reasonable timeframe.
                    </li>
                    <li>
                        <b style="font-size:16px";>Payment Obligations:</b>Pending resolution of the dispute, the Client shall pay any undisputed
                        portion of
                        the invoice by the original due date.
                    </li>
                </ol>
                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">Termination of Services:</p>
                <ol type="a">
                    <li><b style="font-size:16px";>Termination Rights:</b>Either party may terminate the agreement by providing 30 Days notice to
                        the other party.</li>
                    <li>
                        <b style="font-size:16px";>Payment Obligations:</b>In the event of termination, the Client shall be responsible for any
                        outstanding
                        payments for services or goods delivered up to the termination date.
                    </li>
                    <li>
                        <b style="font-size:16px";>Confidentiality:</b>All financial and payment-related information exchanged between the Company
                        and the
                        Client shall be treated as confidential and shall not be disclosed to any third party without prior
                        written consent.
                    </li>

                </ol>

                <p style="color: #1F86CF;line-height: 1.5;margin-bottom:10px;">
                    <b style="font-size:16px";>Governing Law:-</b> The governing law specifies the legal jurisdiction under which a contract or
                    transaction is
                    regulated and enforced. In India, the governing law is often determined by the choice of law clause in
                    the
                    contract. However, if parties do not explicitly specify a governing law, the transaction could be
                    subject to the laws
                    of the region where it is executed.
                </p>
                <p style="line-height: 1.5;margin-bottom:10px;">
                    For contracts and transactions in the Gurgaon region, Indian laws will generally apply. Some of the key
                    laws that
                    might be relevant include:
                </p>
                <p style="line-height: 1.5;margin-bottom:10px;"><b style="font-size:16px";>Indian Contract Act, 1872:</b> Governs the general principles of contracts and enforceability.</p>
                <p style="line-height: 1.5;margin-bottom:10px;"><b style="font-size:16px";>Sales of Goods Act, 1930:</b> Pertains to the sale of goods, warranties, and conditions.</p>
                <p style="line-height: 1.5;margin-bottom:10px;"><b style="font-size:16px";>Goods and Services Tax (GST) Act:</b> Governs taxation on goods and services in India.</p>



            </div>
        </div>
                    </div>

              
                    <div class="modal-footer">

                         <asp:Button ID="btnAccepted" style="background-color: #008CBA;color: #fff;padding: 4px 16px;border: none;border-radius: 5px;cursor: pointer;margin: 5px;" runat="server" OnClick="btnAccepted_Click" Text="Accept" />
                   
                        <button id="cancelButton" type="button">Skip</button>
                    </div>
                </div>
                 </asp:Panel>
               
            </div>
            </div>
       <%--<style>
            .document-1 {
                background-image: url("../assets/VCQRU_LETTER-HEAD.jpg");
                width: 100%;
                height: 100vh;
                background-repeat: no-repeat;
                background-position: top;
                background-size: contain;
                display: table;
                margin: 0 auto;
            }

            .over-box {
               width: 90%;
        margin: auto;
        height: 1050px;
        overflow: auto;
        margin-top: 220px;
        margin-bottom: 150px;
            }

            @media only screen and (max-width: 1024px) {
                .over-box {
                    width: 70%;
                    margin: 0 auto;
                    height: 800px;
                    margin-top: 20%;
                    margin-bottom: 100px;
                }
            }

            @media only screen and (max-width: 768px) {
                .over-box {
                    width: 90%;
        margin: 0 auto;
        height: 660px;
        margin-top: 140px;
        margin-bottom: 50px;
                }
                .app-modal .modal-dialog{
                    height:460px;
                }
            }
           @media only screen and (max-width: 425px) {
               .over-box{
                   width: 90%;
        margin: 0 auto;
        height: 350px;
        margin-top: 90px;
        margin-bottom: 0;
               }
           }
        </style>--%>
        <script>
            // Get references to HTML elements
            const openModalBtn = document.getElementById("openModal");
            const closeModalBtn = document.getElementById("closeModal");
            const modal = document.getElementById("modal");

            // Function to open the modal
            openModalBtn.addEventListener("click", () => {
                modal.style.display = "block";
            });

            // Function to close the modal
            closeModalBtn.addEventListener("click", () => {
                modal.style.display = "none";
            });

            // Function to save the modal
            const saveButton = document.getElementById("saveButton");
            saveButton.addEventListener("click", () => {
                // Add your save functionality here
                alert("Saved!");
                modal.style.display = "none";
            });

            // Function to cancel and close the modal
            const cancelButton = document.getElementById("cancelButton");
            cancelButton.addEventListener("click", () => {
                debugger;
                modal.style.display = "Skiped !.";
            });

        </script>
        <%-- end --%>

        <div class="grid_container">
            <%--<h4>
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="6%" align="center">
                                    <img src="../Content/images/regis_pro.png" alt="products" />
                                </td>
                                <td class="bord_right">
                                    Record(s) found <span class="small_font">(<asp:Label ID="lblcount" runat="server"></asp:Label>)</span>
                                </td>
                            </tr>
                        </table>
                    </h4>--%>
        </div>
        <%-- </ContentTemplate>
        </asp:UpdatePanel>--%>
    </asp:Content>
