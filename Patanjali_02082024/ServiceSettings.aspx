<%@ Page Title="" Language="C#" MasterPageFile="~/Patanjali/pfl.master" AutoEventWireup="true"
    CodeFile="ServiceSettings.aspx.cs" Inherits="Partner_ServiceSettings" %>


    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>


        <asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
            <script type="text/javascript">
                $(document).ready(function () {

                    $(".accordion2 p").eq(10).addClass("active");
                    $(".accordion2 div.open").eq(8).show();

                    $(".accordion2 p").click(function () {
                        $(this).next("div.open").slideToggle("slow")
                            .siblings("div.open:visible").slideUp("slow");
                        $(this).toggleClass("active");
                        $(this).siblings("p").removeClass("active");
                    });

                });

                function checkAll(ctrl) {

                    // debugger;
                    //var dd = $('#' + ctrl.id).prop('checked', this.checked);
                    //alert(dd);
                    if ($('.ckhmaster').children().is(":checked") == true) {

                        $('.childchk').children().prop('checked', true);
                    }
                    else if ($('.ckhmaster').children().is(":checked") == false) {
                        //$('.childchk').prop('checked', false);

                        $('.childchk').children().prop('checked', false);
                    }
                }
                //function deleteItem(uniqueID, itemID) {
                //     var $form = $(this).closest('form');
                //    e.preventDefault();
                //    $('#smallModal').modal({
                //        backdrop: 'static',
                //        keyboard: false
                //    })
                //      .one('click', '#deleteCon', function (e) {

                //          __doPostBack(uniqueID, '');

                //      });
                //    //$("#dialog-confirm").dialog({
                //    //    title: 'confirmation',

                //    //    resizable: false,
                //    //    height: 200,
                //    //    width: 350,
                //    //    modal: true,
                //    //    buttons: {
                //    //        "Delete": function () {
                //    //            __doPostBack(uniqueID, '');
                //    //            $(this).dialog("close");

                //    //        },
                //    //        "Cancel": function () { $(this).dialog("close"); }
                //    //    }
                //    //});

                //    //$('#dialog-confirm').dialog('open');
                //    //return false;
                //}
                function deleteConfirm() {
                    $('#smallModal').modal();
                    return false;
                }
                //$('[id$=ctl00_ContentPlaceHolder1_GrdProductMaster_ctl02_imgBtnSecDelete]').live('click', function (e) {

                //    var $form = $(this).closest('form');
                //    e.preventDefault();
                //    $('#smallModal').modal({
                //        backdrop: 'static',
                //        keyboard: false
                //    })
                //      .one('click', '#deleteCon', function (e) {
                //          alert('ctl00_ContentPlaceHolder1_GrdProductMaster_ctl02_imgBtnSecDelete');
                //          __doPostBack('ctl00_ContentPlaceHolder1_GrdProductMaster_ctl02_imgBtnSecDelete', 'imgBtnSecDelete_Command');

                //      });

                //});
                //$('button[name="ctl00_ContentPlaceHolder1_GrdProductMaster_ctl02_imgBtnSecDelete"]').on('click', function (e) {
                //    alert('');
                //   // $form.trigger('submit');
                //    //var $form = $(this).closest('form');
                //    //e.preventDefault();
                //    //$('#smallModal').modal({
                //    //    backdrop: 'static',
                //    //    keyboard: false
                //    //})
                //    //  .one('click', '#deleteCon', function (e) {
                //    //      $form.trigger('submit');
                //    //  });
                //});
            </script>

            <script type="text/javascript" language="javascript">
                function CheckDateExist(val) {
                    var vl = "*" + document.getElementById("<%=selsrvid.ClientID %>").value + "*" + val;
                    if (document.getElementById("<%=ddlProduct.ClientID %>").value != '--Select--')
                        vl = document.getElementById("<%=ddlProduct.ClientID %>").value + "*" + document.getElementById("<%=selsrvid.ClientID %>").value + "*" + val;
                    PageMethods.checkGetDateIsExist(vl, IsDateFromExist)
                }
                function CheckDateExistNew(val) {
                    var vl = "*" + document.getElementById("<%=selsrvid.ClientID %>").value + "*" + val;
                    if (document.getElementById("<%=ddlProduct.ClientID %>").value != '--Select--')
                        vl = document.getElementById("<%=ddlProduct.ClientID %>").value + "*" + document.getElementById("<%=selsrvid.ClientID %>").value + "*" + val;
                    PageMethods.checkGetDateIsExistNew(vl, IsDateFromExist)
                }
                function IsDateFromExist(Result) {
                    var Arr = Result.toString().split('*');
                    if (Arr[0] == "true") {
                        document.getElementById("<%=lblsrvdtrngmsg.ClientID %>").innerHTML = Arr[1].toString();
                        document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                        document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";

                    }
                    else {
                        document.getElementById("<%=lblsrvdtrngmsg.ClientID %>").innerHTML = "";
                        document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                        document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";
                    }
                }
                function GetSubscription() {
                    var vl = "*" + document.getElementById("<%=selsrvid.ClientID %>").value;
                    if (document.getElementById("<%=ddlProduct.ClientID %>").value != '--Select--')
                        vl = document.getElementById("<%=ddlProduct.ClientID %>").value + "*" + document.getElementById("<%=selsrvid.ClientID %>").value;
                    PageMethods.checkGetSubscription(vl, ValidateGetSubscription)
                }
                function ValidateGetSubscription(Result) {
                    var Arr = Result.toString().split('*');
                    if (Arr[0] == "true") {
                        document.getElementById("<%=selsrvplanid.ClientID %>").value = Arr[2].toString();
                        document.getElementById("<%=lblsrvdtfrndto.ClientID %>").innerHTML = Arr[1].toString();
                        //document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                        //document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";
                    }
                    else {
                        document.getElementById("<%=lblsrvdtfrndto.ClientID %>").innerHTML = "Please subscribe service fisrt.";
                        //document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                        //document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
                    }
                }
                function fileTypeCheckengH(mm) {
                    PageMethods.checkFile(mm, onengcheckH)
                }
                function onengcheckH(Result) {
                    if (Result == true) {
                        document.getElementById("<%=lblfileH.ClientID %>").innerHTML = "Invalid File.";
                        document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                        document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";

                    }
                    else {
                        document.getElementById("<%=lblfileH.ClientID %>").innerHTML = "";
                        document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                        document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";
                    }
                    ChkRegProVal();
                }

                function fileTypeCheckengE(mm) {
                    PageMethods.checkFile(mm, onengcheckE)
                }
                function onengcheckE(Result) {
                    if (Result == true) {
                        document.getElementById("<%=lblfileE.ClientID %>").innerHTML = "Invalid File.";
                        document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                        document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";

                    }
                    else {
                        document.getElementById("<%=lblfileE.ClientID %>").innerHTML = "";
                        document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                        document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-5";
                    }
                    ChkRegProVal();
                }
                function CheckZero(val) {
                    if (parseFloat(val) == 0)
                        document.getElementById("<%=txtfrequency.ClientID %>").value = "";
                }
                function CheckDate(val) {
                    //alert(val);
                    var today = new Date();
                    var dd = today.getDate();
                    var mm = today.getMonth() + 1; //January is 0!
                    var yyyy = today.getFullYear();

                    if (dd < 10) {
                        dd = '0' + dd
                    }

                    if (mm < 10) {
                        mm = '0' + mm
                    }

                    today = dd + '/' + mm + '/' + yyyy;
                    //alert(today);
                    var diff = daydiff(parseDate(val), parseDate(today));
                    //alert(diff);
                    //alert(daydiff(parseDate(val), parseDate(today)));
                    if (parseFloat(diff) > 0)
                        document.getElementById("<%=txtloyaltydtfrom.ClientID %>").value = "";
                }
                function parseDate(str) {
                    //alert(str);
                    var mdy = str.split('/'); //alert(mdy[0]);alert(mdy[1]); alert(mdy[2]); alert(mdy[2] + '/' + mdy[1] + '/' + mdy[0]);
                    return new Date(mdy[2], mdy[1], mdy[0]);
                }

                function daydiff(first, second) {
                    //alert(first); alert(second);
                    return Math.round((second - first) / (1000 * 60 * 60 * 24));
                }


            </script>
            <script type="text/javascript" language="javascript">
                function GetService(vl) {
                    //document.getElementById('ctl00_ContentPlaceHolder1_selsrvid').value = vl;
                    document.getElementById('ContentPlaceHolder1_selsrvid').value = vl;
                }
                function GetVal(vl) {
                    document.getElementById('ctl00_ContentPlaceHolder1_hdnrand').value = vl;
                }
            </script>

            <script type="text/javascript" language="javascript">
                function SelectSingleRadiobuttonAmc(rdbtnid, PlanTime) {
                    var p = 0; var mon = 0;
                    var rdBtn = document.getElementById(rdbtnid);
                    var rdBtnList = document.getElementsByName("rdamcrewaut");
                    for (i = 0; i < rdBtnList.length; i++) {
                        if (rdBtnList[i].type == "radio" && rdBtnList[i].id != rdBtn.id) {
                            rdBtnList[i].checked = false;
                        }
                        if (rdBtnList[i].checked == true) {
                            p = i;
                            document.getElementById("<%=HdValAMC1.ClientID %>").value = PlanTime;
                            if (document.getElementById("<%=txtdtfromamc1.ClientID %>").value != "") {
                                var dt = document.getElementById("<%=txtdtfromamc1.ClientID %>").value;
                                var mydate = new Date(dt.substring(6, 10), (parseInt(dt.substring(3, 5)) == 12 ? 11 : parseInt(dt.substring(3, 5))), dt.substring(0, 2));
                                mon = PlanTime;
                                mydate = new Date(mydate.setMonth(mydate.getMonth() + parseInt(mon)));
                                var dateObj = new Date(mydate);
                                month = dateObj.getMonth();
                                day = dateObj.getDate();
                                year = dateObj.getFullYear();
                                FindInfo();
                                var newdate = FindVal((day > 1 ? day - 1 : day)).toString() + "/" + FindVal((month == 11 ? 12 : month)).toString() + "/" + year;
                                document.getElementById("<%=txtdttoamc1.ClientID %>").value = newdate;
                                document.getElementById("<%=HdDateTo1.ClientID %>").value = newdate;
                                debugger;
                                document.getElementById("<%=Label8.ClientID %>").innerHTML = "";
                                document.getElementById("<%=Div2.ClientID %>").className = "";
                                document.getElementById("<%=chkIsCustome.ClientID %>").checked = false;
                                document.getElementById("<%=txtPlanDiscount.ClientID %>").value = "";
                                document.getElementById("<%=txtPlanAmount.ClientID %>").value = "";
                            }
                            else {
                                document.getElementById("<%=Label8.ClientID %>").innerHTML = "Please select AMC Plan Date From for product " + document.getElementById("<%=txtProName.ClientID %>").value;
                                document.getElementById("<%=Div2.ClientID %>").className = "alert_boxes_pink big_msg";
                            }
                        }
                    }
                }
                function FindNextDateAmc(dt) {
                    var selectedDate = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)) - 1, dt.substring(0, 2));
                    var today = new Date();
                    today.setHours(0, 0, 0, 0);
                    if (selectedDate < today) {
                        document.getElementById("<%=Label8.ClientID %>").innerHTML = "Select current date or bigger than Current date!";
                        document.getElementById("<%=txtdtfromamc1.ClientID %>").value = "";
                        document.getElementById("<%=Div2.ClientID %>").className = "alert_boxes_pink big_msg";
                        document.getElementById("<%=btnAmcRenewal.ClientID %>").disabled = true;
                        document.getElementById("<%=btnAmcRenewal.ClientID %>").className = "btn btn-primary float-right mb-5";
                        return;
                    }
                    else {
                        document.getElementById("<%=Label8.ClientID %>").innerHTML = "";
                        document.getElementById("<%=Div2.ClientID %>").className = "";
                        document.getElementById("<%=btnAmcRenewal.ClientID %>").disabled = false;
                        document.getElementById("<%=btnAmcRenewal.ClientID %>").className = "btn btn-primary float-right mb-5";
                    }
                    var p = document.getElementById("<%=HdValAMC1.ClientID %>").value;
                    if (parseInt(p) >= 0) {
                        var mydate1 = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)), dt.substring(0, 2));
                        mon = p;  //mon = FinfMonth(p);
                        var mydate = new Date(mydate1.setMonth(mydate1.getMonth() + parseInt(mon)));
                        var dateObj = new Date(mydate);
                        month = dateObj.getMonth();
                        day = dateObj.getDate();
                        year = dateObj.getFullYear();
                        FindInfo();
                        var newdate = FindVal(day).toString() + "/" + FindVal(month).toString() + "/" + year;
                        document.getElementById("<%=txtdttoamc1.ClientID %>").value = newdate;
                        document.getElementById("<%=HdDateTo1.ClientID %>").value = newdate;

                        document.getElementById("<%=Label8.ClientID %>").innerHTML = "";
                        document.getElementById("<%=Div2.ClientID %>").className = "";
                    }
                }
                function IsCustom() {
                    var chk1 = document.getElementById("<%=HdValAMC1.ClientID %>").value;
                    var srvid = document.getElementById("<%=selsrvid.ClientID %>").value;
                    if (isNaN(chk1)) {
                        alert('Please select AMC Plan First!');
                        return;
                    }
                    else {
                        document.getElementById("<%=txtPlanAmount.ClientID %>").value = "";
                        document.getElementById("<%=txtPlanDiscount.ClientID %>").value = "";
                        document.getElementById("<%=hdnPlanAmount1.ClientID %>").value = "";
                        document.getElementById("<%=hdnPlanDiscount1.ClientID %>").value = "";
                        document.getElementById("<%=txtmPeriod.ClientID %>").value = "";
                        document.getElementById("<%=txtsPeriod.ClientID %>").value = "";
                        document.getElementById("<%=hdnmPeriod.ClientID %>").value = "";
                        document.getElementById("<%=hdnsPeriod.ClientID %>").value = "";
                        var chk = document.getElementById("<%=chkIsCustome.ClientID %>").checked;
                        if (chk == true) {
                            //var textbox11 = document.getElementById("<%=txtPlanAmount.ClientID %>");
                            //textbox11.readOnly = ""; //readOnly is cese-sensitive
                            var textbox12 = document.getElementById("<%=txtPlanDiscount.ClientID %>");
                            textbox12.readOnly = ""; //readOnly is cese-sensitive
                            //var textbox11 = document.getElementById("<%=txtmPeriod.ClientID %>");
                            //textbox11.readOnly = ""; //readOnly is cese-sensitive
                            var textbox12 = document.getElementById("<%=txtsPeriod.ClientID %>");
                            textbox12.readOnly = ""; //readOnly is cese-sensitive
                            var vl = chk1 + "*" + srvid;
                            PageMethods.WritePlanAmtDis(vl, oncheckPlanAmtDis)
                        }
                        else {
                            //var textbox = document.getElementById("<%=txtPlanAmount.ClientID %>");
                            //textbox.readOnly = "readonly"; //readOnly is cese-sensitive
                            var textbox1 = document.getElementById("<%=txtPlanDiscount.ClientID %>");
                            textbox1.readOnly = "readonly"; //readOnly is cese-sensitive
                            //var textbox = document.getElementById("<%=txtmPeriod.ClientID %>");
                            //textbox.readOnly = "readonly"; //readOnly is cese-sensitive
                            var textbox1 = document.getElementById("<%=txtsPeriod.ClientID %>");
                            textbox1.readOnly = "readonly"; //readOnly is cese-sensitive   
                        }
                    }
                }
                function oncheckPlanAmtDis(Result) {
                    var Arr = Result.toString().split('*');
                    var chk = document.getElementById("<%=chkIsCustome.ClientID %>").checked;
                    var period = document.getElementById("<%=HdValAMC1.ClientID %>").value;
                    if (chk == true) {

                        document.getElementById("<%=txtPlanAmount.ClientID %>").value = Arr[0].toString();
                        document.getElementById("<%=txtPlanDiscount.ClientID %>").value = Arr[0].toString();
                        document.getElementById("<%=hdnPlanAmount1.ClientID %>").value = Arr[0].toString();
                        document.getElementById("<%=hdnPlanDiscount1.ClientID %>").value = Arr[0].toString();
                        document.getElementById("<%=txtmPeriod.ClientID %>").value = period;
                        document.getElementById("<%=txtsPeriod.ClientID %>").value = period;
                        document.getElementById("<%=hdnmPeriod.ClientID %>").value = period;
                        document.getElementById("<%=hdnsPeriod.ClientID %>").value = period;
                    }
                    else {
                        document.getElementById("<%=txtPlanAmount.ClientID %>").value = "";
                        document.getElementById("<%=txtPlanDiscount.ClientID %>").value = "";
                        document.getElementById("<%=hdnPlanAmount1.ClientID %>").value = "";
                        document.getElementById("<%=hdnPlanDiscount1.ClientID %>").value = "";
                        document.getElementById("<%=txtmPeriod.ClientID %>").value = "";
                        document.getElementById("<%=txtsPeriod.ClientID %>").value = "";
                        document.getElementById("<%=hdnmPeriod.ClientID %>").value = "";
                        document.getElementById("<%=hdnsPeriod.ClientID %>").value = "";
                    }
                }
            </script>

            <script type="text/javascript" language="javascript">
                var month; //1 3 5 7 8 10 12==31,4 6 9 11==30 2 = 28*
                var day;
                var year;
                function FindInfo() {
                    var lep = (parseInt(year) % 4);
                    switch (parseInt(month)) {
                        case 1: // January
                            {
                                if (day > 31) {
                                    month = parseInt(month) + 1;
                                    day = parseInt(day) - 31;
                                }
                            }
                            break;
                        case 2: // Febuary
                            {
                                if (parseInt(lep) > 0) {
                                    if (day > 28) {
                                        month = parseInt(month) + 1;
                                        day = parseInt(day) - 28;
                                    }
                                }
                                else {
                                    if (day > 29) {
                                        month = parseInt(month) + 1;
                                        day = parseInt(day) - 29;
                                    }
                                }
                            }
                            break;
                        case 3: // March
                            {
                                if (day > 31) {
                                    month = parseInt(month) + 1;
                                    day = parseInt(day) - 31;
                                }
                            }
                            break;
                        case 4: // April
                            {
                                if (day > 30) {
                                    month = parseInt(month) + 1;
                                    day = parseInt(day) - 30;
                                }
                            }
                            break;
                        case 5: // May
                            {
                                if (day > 31) {
                                    month = parseInt(month) + 1;
                                    day = parseInt(day) - 31;
                                }
                            }
                            break;
                        case 6: // Jun
                            {
                                if (day > 30) {
                                    month = parseInt(month) + 1;
                                    day = parseInt(day) - 30;
                                }
                            }
                            break;
                        case 7: // July
                            {
                                if (day > 31) {
                                    month = parseInt(month) + 1;
                                    day = parseInt(day) - 31;
                                }
                            }
                            break;
                        case 8: // August
                            {
                                if (day > 31) {
                                    month = parseInt(month) + 1;
                                    day = parseInt(day) - 31;
                                }
                            }
                            break;
                        case 9: // September
                            {
                                if (day > 30) {
                                    month = parseInt(month) + 1;
                                    day = parseInt(day) - 30;
                                }
                            }
                            break;
                        case 10: // October
                            {
                                if (day > 31) {
                                    month = parseInt(month) + 1;
                                    day = parseInt(day) - 31;
                                }
                            }
                            break;
                        case 11: // November
                            {
                                if (day > 30) {
                                    month = parseInt(month) + 1;
                                    day = parseInt(day) - 30;
                                }
                            }
                            break;
                        default: // December
                            {
                                if (day > 31) {
                                    month = parseInt(month) + 1;
                                    if (parseInt(month) > 12) {
                                        year = parseInt(year) + 1;
                                        month = 1;
                                    }
                                    day = parseInt(day) - 31;
                                }
                            }
                    }
                    if (month == 0)
                        month = 12;
                }
                function FillAvailable(val) {
                    var Arr = val.toString().split('*');
                    // alert(Arr.length.toString());
                    if (Arr.length > 1) {
                        if (parseFloat(Arr[2]) == 0) {
                            if (parseFloat(Arr[1]) == 0)
                                document.getElementById("<%=lbltotqty.ClientID %>").innerHTML = "Not Available";
                            else {

                                document.getElementById("<%=lbltotqty.ClientID %>").innerHTML = Arr[1].toString();
                            }
                        }
                        else
                            document.getElementById("<%=lbltotqty.ClientID %>").innerHTML = "Mannual";
                    }
                    else
                        document.getElementById("<%=lbltotqty.ClientID %>").innerHTML = "";

                    var Arr2 = val.toString().split('*');
                    if (Arr2.length == 4) {
                        document.getElementById("<%=lblCouponRequest_ID.ClientID %>").innerHTML = Arr2[3].toString();
                    }
                    //alert("<=lblCouponRequest_ID.Text %>");
                }
            </script>
        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


            <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 1230px; width: 100%;
                        z-index: 100001; top: 0px;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>


            <asp:HiddenField ID="hdneditval" runat="server" />
            <asp:HiddenField ID="ActionText" runat="server" />
            <asp:HiddenField ID="IsAct" runat="server" />
            <asp:Label ID="lblproiddel" runat="server" Visible="false"></asp:Label>
            <asp:HiddenField ID="currindex" runat="server" />
            <asp:HiddenField ID="lblproidamc" runat="server" />
            <asp:HiddenField ID="hhdnCompID" runat="server" />
            <asp:HiddenField ID="selsrvid" runat="server" />
            <asp:HiddenField ID="selsrvplanid" runat="server" />

            <asp:HiddenField ID="hdnprizetransid" runat="server" />
            <asp:HiddenField ID="hdnsstid" runat="server" />
            <asp:HiddenField ID="hdnisaddi" runat="server" />
            <asp:HiddenField ID="docflag" runat="server" />
            <asp:HiddenField ID="HdFieldAmcId" runat="server" />
            <asp:HiddenField ID="HdFieldOfferId" runat="server" />
            <asp:HiddenField ID="hdnpointsval" runat="server" />

            <!--  -->

            <div class="home-section">
                <div class="app-breadcrumb">
                    <div class="row">
                        <div class="col">
                            <h5>Service Setting Master</h5>
                        </div>
                        <div class="col">
                            <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="dashboard.aspx">Dashboard</a></li>
                                    <li class="breadcrumb-item active" aria-current="page">Service Setting</li>
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
                                    
                                </div>
                                <div class="col mb-3">
                                    <ul class="action-button-global">

                                        <li>
                                            <a href="AddServiceSettings.aspx" class="btn btn-sm btn-primary"><i
                                                    class='bx bx-plus'></i>Add Service Setting</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>

                            <div id="NewMsgpop" runat="server">
                                <asp:Label ID="Label2" runat="server"></asp:Label>
                            </div>
                            <div class="row">
                                <div class="col">
                                    <label for="Product Name" class="form-label">Select Service</label>
                                    <asp:DropDownList ID="ddlsearchSrervice" CssClass="form-select" runat="server">
                                    </asp:DropDownList>
                                    <asp:TextBox ID="txtDateFrom" runat="server" CssClass="form-select form-control-sm"
                                        Visible="false"></asp:TextBox>
                                </div>
                                <div class="col">
                                    <label for="Product Description" class="form-label">Select Product</label>

                                    <asp:DropDownList ID="ddlsearchPro" CssClass="form-select" runat="server">
                                    </asp:DropDownList>
                                    <asp:TextBox ID="txtDateTo" runat="server" CssClass="form-select form-control-sm"
                                        Visible="false"></asp:TextBox>

                                </div>
                                <div class="col">
                                    <label for="Dispatch Location" class="form-label">Product Name</label>
                                    <asp:TextBox ID="txtProductName" placeholder="Product Name" runat="server"
                                        CssClass="form-control"></asp:TextBox>
                                </div>


                                <div class="col">
                                    <label for="" class="form-label text-white">*</label><br>
                                    <asp:Button ID="btnSearch" OnClick="btnSearch_Click"
                                        ValidationGroup="chk94" class="btn btn-primary" runat="server" Text="Search" />

                                    <asp:Button ID="btnRefresh" OnClick="btnRefresh_Click"
                                        class="btn btn-success" runat="server" CausesValidation="false" Text="Reset" />
                                </div>

                            </div>
                            <div class="row">
                                <!-- <div class="col-lg-8">
                                    <h4 class="mb-0">Record(s) found<span> (<asp:Label ID="lblcount" runat="server">
                                            </asp:Label>)</span></h4>
                                </div> -->
                                <div class="col-lg-2">
                                    <asp:Label ID="lblToatalCashPoints" runat="server"></asp:Label>
                                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label ID="lblToatalPoints" runat="server">
                                    </asp:Label>
                                </div>
                                <div class="col-lg-2">
                                    <asp:DropDownList ID="ddlRowProductCnt" Visible="false" runat="server"
                                        AutoPostBack="true" OnSelectedIndexChanged="ddlRowsShow_SelectedIndexChanged">
                                        <asp:ListItem Value="25">25 Rows</asp:ListItem>
                                        <asp:ListItem Value="50">50 Rows</asp:ListItem>
                                        <asp:ListItem Value="100">100 Rows</asp:ListItem>
                                        <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                        <asp:ListItem Value="1000">1000 Rows</asp:ListItem>
                                        <asp:ListItem Value="1001">All Rows</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>



                                <h6>Icon Meaning</h6>
                                <div class="row row-cols-xxl-4 row-cols-xl-4 row-cols-lg-4 row-cols-md-4 row-cols-1 g-3">
                                    <div class="col">
                                        <img alt="" src="../Content/images/edit.png" />
                                        Update Service Setting
                                    </div>

                                    <div class="col">
                                        <img alt="" src="../Content/images/check_act.png"
                                            style="height: 12px; width: 12px;" />
                                        Acive (Click for In-Active)

                                    </div>

                                    <div class="col">
                                        <img alt="" src="../Content/images/check_gr.png"
                                            style="height: 12px; width: 12px;" />
                                        In-Active (Click for Active)
                                    </div>

                                    <div class="col">
                                        <img alt="" src="../Content/images/delete.png" />
                                        Delete Service Setting
                                    </div>
                                </div>
                            <div class="app-table mt-2">
                                <div class="table-responsive">

                                    <asp:GridView ID="GrdProductMaster" runat="server" AutoGenerateColumns="False"
                                        CssClass="table table-striped table-hover mb-0" DataKeyNames="IsActive,Sound"
                                        EmptyDataText="Record Not Found"
                                        OnRowCommand="GrdProductMaster_RowCommand"
                                        OnPageIndexChanging="GrdProductMaster_PageIndexChanging1">
                                        <Columns>
                                            <asp:TemplateField HeaderText="S.No">
                                                <ItemTemplate>
                                                    <%=++c %>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Product Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblproname" runat="server"
                                                        Text='<%# Bind("Pro_Name") %>'></asp:Label>&nbsp;
                                                    
                                                    [<asp:Label
                                                        ID="lbladdsrvname" runat="server"
                                                        Text='<%# Bind("ServiceName") %>'></asp:Label>]
                                                    
                                                    <%--[<asp:Label
                                                        ID="lblrange" runat="server" Text='<%# Bind("servicerange") %>'>
                                                    </asp:Label>]--%>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="DateFrom">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblsstdtfrom" runat="server"
                                                        Text='<%# Bind("DateFrom","{0:MMM d, yyyy}") %>'></asp:Label>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="DateTo">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblsstdtto" runat="server"
                                                        Text='<%# Bind("DateTo","{0:MMM d, yyyy}") %>'></asp:Label>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Points">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblptgains" runat="server"
                                                        Text='<%# Convert.ToInt32(Eval("Points")) == 0 ? "No" : Eval("Points")  %>'>
                                                    </asp:Label>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Cash">
                                                <ItemTemplate>
                                                    <asp:Label ID="lbliScASHcONVERT" runat="server"
                                                        Text='<%# Convert.ToInt32(Eval("IsCashConvert")) == 0 ? "Yes" : "No"  %>'>
                                                    </asp:Label>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Frequency">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblfrequency" runat="server"
                                                        Text='<%# Convert.ToInt32(Eval("Frequency")) == 0 ? "No" : Eval("Frequency")  %>'>
                                                    </asp:Label>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                <ItemStyle  />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Comments">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblComments" runat="server"
                                                        Text='<%# Convert.ToString(Eval("Comments")) == "" ? "No" : Eval("Comments")  %>'>
                                                    </asp:Label>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                                <ItemStyle  />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Hindi">
                                                <ItemTemplate>
                                                    <% try {
                                                        vl=Convert.ToInt32(GrdProductMaster.DataKeys[index].Values["Sound"].ToString());
                                                        } catch { } if (vl==0) { %>
                                                        <ul class="graphic">
                                                            <li style="padding-left: 10px;"><a
                                                                    href='<%# Eval("SoundPath") %>' class="sm2_link">
                                                                </a></li>
                                                        </ul>
                                                        <%} else { %>No<%}%>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed bord_left"
                                                    HorizontalAlign="Center" />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="English">
                                                <ItemTemplate>
                                                    <% try {
                                                        vl=Convert.ToInt32(GrdProductMaster.DataKeys[index].Values["Sound"].ToString());
                                                        } catch { } if (vl==0) { %>
                                                        <ul class="graphic">
                                                            <li style="padding-left: 10px;"><a
                                                                    href='<%# Eval("SoundPath1") %>' class="sm2_link">
                                                                </a></li>
                                                        </ul>
                                                        <%} else { %>No<%}%>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed bord_left"
                                                    HorizontalAlign="Center" />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Action">
                                                <ItemTemplate>
                                                    <% try {
                                                        IsActive=Convert.ToInt32(GrdProductMaster.DataKeys[index].Values["IsActive"].ToString());
                                                        } catch { } if (IsActive !=-1) { %>
                                                        <asp:ImageButton ID="ImgBtnLoyalty" runat="server"
                                                            CausesValidation="false"
                                                            CommandArgument='<%#Bind("SST_Id") %>'
                                                            CommandName="EditRows" ImageUrl="~/Content/images/edit.png"
                                                            ToolTip="Add / Update Loyalty" />&nbsp;
                                                        <%if (IsActive==0) {%>
                                                            <asp:ImageButton ID="ImgIsActiveDelete" runat="server"
                                                                CausesValidation="false"
                                                                CommandArgument='<%#Bind("SST_Id") %>'
                                                                CommandName="IsActive"
                                                                ImageUrl="~/Content/images/check_gr.png"
                                                                ToolTip="Click for Activated Service Settings."
                                                                OnClientClick="return confirm('Are you sure to Activate.')" />
                                                            <%} else { %>
                                                                <asp:ImageButton ID="ImgIsActiveDeletes" runat="server"
                                                                    CausesValidation="false"
                                                                    CommandArgument='<%#Bind("SST_Id") %>'
                                                                    CommandName="IsActive"
                                                                    ImageUrl="~/Content/images/check_act.png"
                                                                    ToolTip="Click for De-Activated Service Settings."
                                                                    OnClientClick="return confirm('Are you sure to De-Activate.')" />
                                                                <%} %>
                                                                    &nbsp;
                                                                    <%--<asp:ImageButton ID="imgBtnSecDelete" runat="server"
                                                                        CommandArgument='<%#Bind("SST_Id") %>'
                                                                        OnCommand="imgBtnSecDelete_Command"
                                                                        CommandName="DeleteRow"
                                                                        ImageUrl="~/Content/images/delete.png"
                                                                        ToolTip="Delete"
                                                                        OnClientClick="return confirm('Are you sure to you want to delete?')" />--%>
                                                                    <%} else { %>
                                                                        <asp:Label ID="lblsrvst" runat="server"
                                                                            ForeColor="Red" Font-Size="8pt"
                                                                            Text="Expired"></asp:Label>
                                                                        <%} %>
                                                                            <%index++;%>
                                                </ItemTemplate>
                                                <%--<HeaderStyle CssClass="tr_haed bord_left"
                                                    HorizontalAlign="Center" />--%>
                                                <ItemStyle />
                                            </asp:TemplateField>
                                        </Columns>
                                        <%-- <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                        <RowStyle />
                                        <AlternatingRowStyle" />--%>
                                    </asp:GridView>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- js -->

            <div class="grid_container">


                <!-------------------Start Loyalty Popup--------------->
                <asp:Panel ID="AddLoyaltyPanel" runat="server" Width="40%" Style="display: none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btncloseloyalty" CssClass="popupClose" runat="server" />
                            </div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="Lblloyaltyhead" runat="server" Font-Bold="true"></asp:Label>
                                    </span>
                                </p>
                            </div>
                            <div class="regis_popup" style="line-height: 25px;overflow : auto ; height: 700px;">
                                <div id="DivMsg" runat="server">
                                    <p>
                                        <asp:Label ID="LblMsgBody" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <table cellpadding="0px" cellspacing="10px" width="100%" class="grid"
                                    style="line-height: 25px;overflow : auto ; height: 500px;">
                                    <tr>
                                        <td colspan="2">
                                            <table width="100%">
                                                <tr>
                                                    <td colspan="2" align="right">
                                                        <asp:Label ID="lblsrvdtrngmsg" runat="server" ForeColor="Red"
                                                            Font-Bold="true" Font-Size="10pt"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td colspan="2" align="right">
                                                        <asp:Label ID="lblsrvdtfrndto" runat="server" ForeColor="Green"
                                                            Font-Bold="true" Font-Size="10pt"></asp:Label>
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td style="padding-left: 15px; width: 50%;">
                                                        <strong>Product : </strong><span
                                                            class="astrics">*</span>&nbsp;&nbsp;<br />
                                                        <asp:DropDownList ID="ddlProduct" CssClass="drp" runat="server"
                                                            Width="65%" onchange="javascript:GetSubscription()">
                                                        </asp:DropDownList>
                                                        &nbsp;<a href="RegisteredProduct.aspx?Parm=New"
                                                            title="Add New Brand Loyalty Product"><img alt=""
                                                                src="../Content/images/add_new.png"
                                                                style="height: 17px; width: 17px;" /></a>
                                                        <asp:RequiredFieldValidator ID="RFVPro" runat="server"
                                                            ForeColor="Red" ValidationGroup="SRVS"
                                                            InitialValue="--Select--" ControlToValidate="ddlProduct">
                                                        </asp:RequiredFieldValidator>
                                                    </td>
                                                    <td>
                                                        <strong>Date Range : <span
                                                                class="astrics">*</span></strong>&nbsp;&nbsp;<br />
                                                        <asp:TextBox ID="txtloyaltydtfrom" Width="120px"
                                                            CssClass="reg_txt" runat="server" placeholder="Date From.."
                                                            onchange="javascript:CheckDateExist(this.value);">
                                                        </asp:TextBox>
                                                        <asp:RequiredFieldValidator ID="RFVIsDateFrom" runat="server"
                                                            ForeColor="Red" ValidationGroup="NN"
                                                            ControlToValidate="txtloyaltydtfrom">
                                                        </asp:RequiredFieldValidator>
                                                        &nbsp;&nbsp;
                                                        <asp:TextBox ID="txtloyaltydtto" Width="120px"
                                                            CssClass="reg_txt" runat="server"
                                                            onchange="javascript:CheckDateExistNew(this.value);"
                                                            placeholder="Date To.."></asp:TextBox><br />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>
                                                    </td>
                                                    <td>
                                                        <asp:CompareValidator ID="CompareValidator1" runat="server"
                                                            ValidationGroup="LOY" ControlToCompare="txtloyaltydtfrom"
                                                            ControlToValidate="txtloyaltydtto" ForeColor="Red"
                                                            Type="Date" Operator="GreaterThanEqual"
                                                            Text="Date To is Less Than Date From">
                                                        </asp:CompareValidator>
                                                        <cc1:CalendarExtender ID="CalendarExtender7" runat="server"
                                                            TargetControlID="txtloyaltydtfrom" Format="dd/MM/yyyy">
                                                        </cc1:CalendarExtender>
                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server"
                                                            TargetControlID="txtloyaltydtfrom" Mask="99/99/9999"
                                                            MaskType="Date">
                                                        </cc1:MaskedEditExtender>
                                                        <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender7"
                                                            runat="server" TargetControlID="txtloyaltydtfrom"
                                                            WatermarkText="Date From..">
                                                        </cc1:TextBoxWatermarkExtender>
                                                        <cc1:CalendarExtender ID="CalendarExtender8" runat="server"
                                                            TargetControlID="txtloyaltydtto" Format="dd/MM/yyyy">
                                                        </cc1:CalendarExtender>
                                                        <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server"
                                                            TargetControlID="txtloyaltydtto" Mask="99/99/9999"
                                                            MaskType="Date">
                                                        </cc1:MaskedEditExtender>
                                                        <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender8"
                                                            runat="server" TargetControlID="txtloyaltydtto"
                                                            WatermarkText="Date To..">
                                                        </cc1:TextBoxWatermarkExtender>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <table width="100%">
                                                <tr>
                                                    <td style="padding-left: 15px; width: 100%;">
                                                        <strong>: </strong><span class="astrics">*</span>>


                                                        <%-- <asp:RequiredFieldValidator ID="RequiredFieldValidator1"
                                                            runat="server" ForeColor="Red" ValidationGroup="gg"
                                                            InitialValue="0" ControlToValidate="ddlEC">
                                                            </asp:RequiredFieldValidator>--%>
                                                    </td>

                                                </tr>
                                                <tr>
                                                    <td>

                                                        <%--<asp:GridView ID="GrdLabel" runat="server"
                                                            AutoGenerateColumns="False" CssClass="table table-striped"
                                                            EmptyDataText="Record Not Found"
                                                            OnRowCommand="GrdLabel_RowCommand"
                                                            BorderColor="transparent">
                                                            <Columns>
                                                                <asp:TemplateField HeaderText="S.No.">
                                                                    <ItemTemplate>
                                                                        <%=++str %>
                                                                    </ItemTemplate>

                                                                    <ItemStyle />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="">
                                                                    <HeaderTemplate>
                                                                        <asp:CheckBox Text="All" runat="server"
                                                                            ID="chkmaster" class="ckhmaster"
                                                                            onchange="checkAll(this);" />
                                                                    </HeaderTemplate>
                                                                    <ItemTemplate>
                                                                        <asp:CheckBox Text="" runat="server"
                                                                            name="chkStatus" ID="childchk2"
                                                                            CssClass="childchk" />
                                                                        <asp:Label ID="lblBLoyalty_PointEarnedID"
                                                                            runat="server"
                                                                            Text='<%# Bind("BLoyalty_PointEarnedID") %>'
                                                                            Visible="false"></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Justify"
                                                                        CssClass="grd_pad" Width="5%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Name">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblname" runat="server"
                                                                            Text='<%# Bind("type") %>'></asp:Label>
                                                                    </ItemTemplate>
                                                                    <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Cash(Rs) 4points=1Rs">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblCash" runat="server"
                                                                            Text='<%# Bind("Cash1") %>'></asp:Label>
                                                                        <br />
                                                                        (<asp:Label ID="Label3" runat="server"
                                                                            Text='<%# Bind("points1") %>'></asp:Label>
                                                                        points)
                                                                    </ItemTemplate>

                                                                    <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="Consumer">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblsizeMobileNo" runat="server"
                                                                            Text='<%# Bind("MobileNo") %>'></asp:Label>

                                                                    </ItemTemplate>

                                                                    <ItemStyle HorizontalAlign="Left" Width="15%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="Bank">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblsizeBank_Name" runat="server"
                                                                            Text='<%# Bind("Bank_Name") %>'></asp:Label>
                                                                    </ItemTemplate>

                                                                    <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                                </asp:TemplateField>

                                                                <asp:TemplateField HeaderText="AccountNo">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblAccount_No" runat="server"
                                                                            Text='<%# Bind("Account_No") %>'>
                                                                        </asp:Label>
                                                                    </ItemTemplate>

                                                                    <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="RTGSCode">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblRTGS_Code" runat="server"
                                                                            Text='<%# Bind("RTGS_Code") %>'></asp:Label>
                                                                    </ItemTemplate>

                                                                    <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                                </asp:TemplateField>
                                                                <asp:TemplateField HeaderText="IFSCCode">
                                                                    <ItemTemplate>
                                                                        <asp:Label ID="lblIFSC_Code" runat="server"
                                                                            Text='<%# Bind("IFSC_Code") %>'></asp:Label>
                                                                    </ItemTemplate>

                                                                    <ItemStyle HorizontalAlign="Left" Width="10%" />
                                                                </asp:TemplateField>
                                                            </Columns>
                                                            </asp:GridView>--%>
                                                    </td>
                                                </tr>
                                            </table>

                                        </td>
                                    </tr>
                                    <tr id="divispoints" runat="server">
                                        <td style="width: 30%; text-align: right;">
                                            <strong>Points : </strong><span class="astrics">*</span>&nbsp;&nbsp;
                                            <asp:RequiredFieldValidator ID="RFVIsPoints" runat="server" ForeColor="Red"
                                                ValidationGroup="NN" ControlToValidate="txtloyaltypoints">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtloyaltypoints" Width="120px" CssClass="reg_txt"
                                                runat="server"
                                                onkeyDown="return checkTextAreaMaxLength(this,event,'5');">
                                            </asp:TextBox>&nbsp;&nbsp;
                                            <asp:CheckBox runat="server" ID="chkconvert" />
                                            <span id="lbliscash">Convert to Cash</span>
                                        </td>
                                    </tr>
                                    <tr id="divisreferral" runat="server">
                                        <td colspan="2">
                                            <table width="100%">
                                                <tr>
                                                    <td style="width: 30%; text-align: right; vertical-align: top;">
                                                        <strong>Referral Gift Type : </strong>&nbsp;&nbsp;&nbsp;&nbsp;
                                                    </td>
                                                    <td>
                                                        <asp:RadioButton ID="rdIsRefCash" runat="server"
                                                            Text="&nbsp;Cash&nbsp;&nbsp;" GroupName="REF"
                                                            AutoPostBack="false"
                                                            OnCheckedChanged="rdReferral_CheckedChanged"
                                                            Visible="false" />&nbsp;
                                                        <asp:RadioButton ID="rdIsRefPoints" runat="server"
                                                            Text="&nbsp;Points&nbsp;&nbsp;" GroupName="REF"
                                                            AutoPostBack="false"
                                                            OnCheckedChanged="rdReferral_CheckedChanged"
                                                            Visible="false" />&nbsp;
                                                        <asp:RadioButton ID="rdIsRefGift" runat="server"
                                                            Text="&nbsp;Gift&nbsp;&nbsp;" GroupName="REF"
                                                            AutoPostBack="false"
                                                            OnCheckedChanged="rdReferral_CheckedChanged"
                                                            Visible="false" />
                                                    </td>
                                                </tr>
                                                <tr id="divpoinscash" runat="server">
                                                    <td style="width: 30%; text-align: right; vertical-align: top;">
                                                        <strong>
                                                            <asp:Label ID="lblrefHead" runat="server" Text="Cash">
                                                            </asp:Label>
                                                            :
                                                        </strong>&nbsp;&nbsp;
                                                    </td>
                                                    <td>
                                                        <asp:RequiredFieldValidator ID="Reqreffrom" runat="server"
                                                            ForeColor="Red" ValidationGroup="NN"
                                                            ControlToValidate="txtreffrom">
                                                        </asp:RequiredFieldValidator>
                                                        &nbsp;<asp:TextBox ID="txtreffrom" Width="120px"
                                                            CssClass="reg_txt"
                                                            onkeypress="return isNumberKey(this, event);"
                                                            placeholder="For Referral" runat="server"
                                                            onkeyDown="return checkTextAreaMaxLength(this,event,'5');"
                                                            ToolTip="Enter Frequency to win alternet rewards points"
                                                            onchange="javascript:CheckZero(this.value);"></asp:TextBox>
                                                        &nbsp;&nbsp;
                                                        <asp:RequiredFieldValidator ID="Reqrefto" runat="server"
                                                            ForeColor="Red" ValidationGroup="NN"
                                                            ControlToValidate="txtrefto">
                                                        </asp:RequiredFieldValidator>
                                                        <asp:TextBox ID="txtrefto" Width="120px" CssClass="reg_txt"
                                                            onkeypress="return isNumberKey(this, event);" runat="server"
                                                            onkeyDown="return checkTextAreaMaxLength(this,event,'5');"
                                                            ToolTip="Enter Frequency to win alternet rewards points"
                                                            placeholder="For Users"
                                                            onchange="javascript:CheckZero(this.value);"></asp:TextBox>
                                                        &nbsp;
                                                        <asp:CheckBox ID="chkRefIsCash" runat="server"
                                                            Text="&nbsp;&nbsp;Is Point to Cash" Visible="false" />
                                                    </td>
                                                </tr>
                                                <tr id="divrefGift" runat="server">
                                                    <td style="width: 30%; text-align: right; vertical-align: top;">
                                                        <strong>Gift : </strong>&nbsp;&nbsp;&nbsp;&nbsp;
                                                    </td>
                                                    <td>
                                                        <asp:DropDownList ID="ddlrefGiftFrom" Width="130px"
                                                            CssClass="reg_txt" runat="server"
                                                            ToolTip="Seelct Gift to win Referals"
                                                            onchange="javascript:CheckZero(this.value);">
                                                        </asp:DropDownList>
                                                        &nbsp;&nbsp;<asp:DropDownList ID="ddlrefGiftTo" Width="130px"
                                                            CssClass="reg_txt" runat="server"
                                                            ToolTip="Seelct Gift to win Users">
                                                        </asp:DropDownList>
                                                    </td>
                                                </tr>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr id="divtxtReferralLimit" runat="server" visible="false">
                                        <td style="width: 30%; text-align: right; vertical-align: top;">
                                            <strong>Limit/User : </strong>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtReferralLimit" Width="120px" CssClass="reg_txt"
                                                onkeypress="return isNumberKey(this, event);" MaxLength="5"
                                                runat="server"
                                                onkeyDown="return checkTextAreaMaxLength(this,event,'2');"
                                                ToolTip="Enter can refer upto user (limit/user)"
                                                onchange="javascript:CheckZero(this.value);"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr id="divisfrequency" runat="server">
                                        <td style="width: 30%; text-align: right; vertical-align: top;">
                                            <strong>Frequency : </strong>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtfrequency" Width="120px" CssClass="reg_txt"
                                                onkeypress="return isNumberKey(this, event);" runat="server"
                                                onkeyDown="return checkTextAreaMaxLength(this,event,'2');"
                                                ToolTip="Enter Frequency to win alternet rewards points"
                                                onchange="javascript:CheckZero(this.value);"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr id="diviscash" runat="server">
                                        <td style="width: 30%; text-align: right; vertical-align: top;">
                                            <strong>Cash : </strong>&nbsp;&nbsp;
                                            <asp:RequiredFieldValidator ID="RFVIsCash" runat="server" ForeColor="Red"
                                                ValidationGroup="NN" ControlToValidate="txtcashamt">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtcashamt" Width="120px" CssClass="reg_txt"
                                                onkeypress="return isNumberKey(this, event);" runat="server"
                                                onkeyDown="return checkTextAreaMaxLength(this,event,'2');"
                                                ToolTip="Enter Frequency to win alternet rewards points"
                                                onchange="javascript:CheckZero(this.value);"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr id="divisAdditionalGift" runat="server">
                                        <td colspan="4">
                                            <fieldset class="Newfield">
                                                <legend>Additional Gift Details</legend>
                                                <table width="100%" cellpadding="2px" cellspacing="2px">
                                                    <tr>
                                                        <td colspan="2" width="50%">
                                                            <fieldset class="Newfield"
                                                                style="border: 1px solid #D9E0E6;">
                                                                <legend>Service Type</legend>
                                                                <div class="SingleCheckbox" style="padding-left: 25px;">
                                                                    <div
                                                                        style="float: left; width: 25%; margin-top: 5px;">
                                                                        <asp:RadioButton ID="rdInstant" runat="server"
                                                                            GroupName="TP" Checked="true"
                                                                            AutoPostBack="true"
                                                                            OnCheckedChanged="rdInstant_CheckedChanged" />
                                                                        <asp:Label ID="Label1"
                                                                            AssociatedControlID="rdInstant"
                                                                            runat="server" Text="Instant"
                                                                            CssClass="CheckBoxLabel"></asp:Label>
                                                                    </div>
                                                                    <div style="float: left; margin-top: 5px;">
                                                                        <asp:RadioButton ID="rdAtDueDate" runat="server"
                                                                            GroupName="TP" AutoPostBack="true"
                                                                            OnCheckedChanged="rdInstant_CheckedChanged" />
                                                                        <asp:Label ID="Label4"
                                                                            AssociatedControlID="rdAtDueDate"
                                                                            runat="server" Text="At&nbsp;Due&nbsp;Date"
                                                                            CssClass="CheckBoxLabel"></asp:Label>

                                                                        <asp:TextBox ID="txtDueDate" Width="120px"
                                                                            CssClass="reg_txt"
                                                                            onkeypress="return isNumberKey(this, event);"
                                                                            placeholder="Lucky draw date" runat="server"
                                                                            onchange="javascript:CheckDateExist(this.value);"
                                                                            ToolTip="Enter lucky draw date">
                                                                        </asp:TextBox>

                                                                        <cc1:CalendarExtender
                                                                            ID="CalendarExtendertxtDueDate"
                                                                            runat="server" TargetControlID="txtDueDate"
                                                                            Format="dd/MM/yyyy">
                                                                        </cc1:CalendarExtender>
                                                                        <cc1:MaskedEditExtender
                                                                            ID="MaskedEditExtendertxtDueDate"
                                                                            runat="server" TargetControlID="txtDueDate"
                                                                            Mask="99/99/9999" MaskType="Date">
                                                                        </cc1:MaskedEditExtender>
                                                                        <cc1:TextBoxWatermarkExtender
                                                                            ID="TextBoxWatermarkExtendertxtDueDate"
                                                                            runat="server" TargetControlID="txtDueDate"
                                                                            WatermarkText="Lucky draw date">
                                                                        </cc1:TextBoxWatermarkExtender>


                                                                        <%--<asp:RequiredFieldValidator
                                                                            ID="RequiredFieldValidator1" runat="server"
                                                                            ForeColor="Red" ValidationGroup="NN"
                                                                            ControlToValidate="txtDueDate">
                                                                            </asp:RequiredFieldValidator>--%>
                                                                    </div>
                                                                </div>
                                                            </fieldset>
                                                        </td>
                                                        <td colspan="3">
                                                            <fieldset class="Newfield"
                                                                style="border: 1px solid #D9E0E6;">
                                                                <legend>Rewards Distributions</legend>
                                                                <div class="SingleCheckbox" style="padding-left: 25px;">
                                                                    <div
                                                                        style="float: left; width: 27%; margin-top: 5px;">
                                                                        <asp:RadioButton ID="rdRandomDistri"
                                                                            runat="server" GroupName="RD" Checked="true"
                                                                            AutoPostBack="true"
                                                                            OnCheckedChanged="rdRandomDistri_CheckedChanged" />
                                                                        <asp:Label ID="Label9"
                                                                            AssociatedControlID="rdRandomDistri"
                                                                            runat="server" Text="Randon&nbsp;"
                                                                            CssClass="CheckBoxLabel"></asp:Label>
                                                                    </div>
                                                                    &nbsp;&nbsp;
                                                                    <div style="float: left; margin-top: 5px;">
                                                                        <asp:RadioButton ID="rdSequenceDistri"
                                                                            runat="server" GroupName="RD"
                                                                            AutoPostBack="true"
                                                                            OnCheckedChanged="rdRandomDistri_CheckedChanged" />
                                                                        <asp:Label ID="Label10"
                                                                            AssociatedControlID="rdSequenceDistri"
                                                                            runat="server" Text="Sequence"
                                                                            CssClass="CheckBoxLabel"></asp:Label>
                                                                    </div>
                                                                </div>
                                                            </fieldset>
                                                        </td>
                                                    </tr>
                                                    <tr id="divinstant" runat="server">
                                                        <td colspan="5">
                                                            <fieldset class="Newfield"
                                                                style="border: 1px solid #D9E0E6;">
                                                                <legend>Paricipants</legend>
                                                                <table width="100%" style="padding-left: 25px;">
                                                                    <tr>
                                                                        <td>
                                                                            <asp:RadioButton ID="rdFirstnth"
                                                                                runat="server" GroupName="RL"
                                                                                Checked="true" AutoPostBack="true"
                                                                                OnCheckedChanged="rdAllParticipant_CheckedChanged" />
                                                                        </td>
                                                                        <td>
                                                                            <b>First&nbsp;'n'&nbsp;Participants</b>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txttcodes" Width="100px"
                                                                                runat="server" CssClass="reg_txt"
                                                                                onkeypress="return isNumberKey(this, event);"
                                                                                AutoPostBack="true"
                                                                                OnTextChanged="GetWinners_TextChanged">
                                                                            </asp:TextBox>
                                                                            <asp:RequiredFieldValidator ID="reqtcodes"
                                                                                runat="server" ForeColor="Red"
                                                                                ValidationGroup="NN"
                                                                                ControlToValidate="txttcodes">
                                                                            </asp:RequiredFieldValidator>
                                                                        </td>
                                                                        <td>
                                                                            <%--<b>Random Winners</b>--%>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtnth" runat="server"
                                                                                CssClass="reg_txt" ReadOnly="false"
                                                                                Width="100px"
                                                                                onkeypress="return isNumberKey(this, event);"
                                                                                Style="display: none;"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ID="reqnth"
                                                                                runat="server" ForeColor="Red"
                                                                                ValidationGroup="NN"
                                                                                ControlToValidate="txtnth">
                                                                            </asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:RadioButton ID="rdFirstRandomnth"
                                                                                runat="server" GroupName="RL"
                                                                                Checked="true" AutoPostBack="true"
                                                                                OnCheckedChanged="rdAllParticipant_CheckedChanged" />
                                                                        </td>
                                                                        <td>
                                                                            <b>Every&nbsp;n<sup>th</sup>&nbsp;Participants</b>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txteverynth" Width="100px"
                                                                                runat="server" CssClass="reg_txt"
                                                                                onkeypress="return isNumberKey(this, event);"
                                                                                AutoPostBack="true"
                                                                                OnTextChanged="GetWinners1_TextChanged">
                                                                            </asp:TextBox>
                                                                            <asp:RequiredFieldValidator ID="reqeverynth"
                                                                                runat="server" ForeColor="Red"
                                                                                ValidationGroup="NN"
                                                                                ControlToValidate="txteverynth">
                                                                            </asp:RequiredFieldValidator>
                                                                        </td>
                                                                        <td>
                                                                            <b>No. Of Rewards</b>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txteverywin" runat="server"
                                                                                CssClass="reg_txt" Width="100px"
                                                                                onkeypress="return isNumberKey(this, event);"
                                                                                AutoPostBack="true"
                                                                                OnTextChanged="GetWinners1_TextChanged">
                                                                            </asp:TextBox>
                                                                            <asp:RequiredFieldValidator ID="reqeverywin"
                                                                                runat="server" ForeColor="Red"
                                                                                ValidationGroup="NN"
                                                                                ControlToValidate="txteverywin">
                                                                            </asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:RadioButton ID="rdRandom"
                                                                                runat="server" GroupName="RL"
                                                                                AutoPostBack="true"
                                                                                OnCheckedChanged="rdAllParticipant_CheckedChanged" />
                                                                        </td>
                                                                        <td>
                                                                            <b>Random Participants</b>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txttcodesrand"
                                                                                Width="100px" runat="server"
                                                                                CssClass="reg_txt"
                                                                                onkeypress="return isNumberKey(this, event);"
                                                                                AutoPostBack="true"
                                                                                OnTextChanged="GetWinners2_TextChanged">
                                                                            </asp:TextBox>
                                                                            <asp:RequiredFieldValidator
                                                                                ID="reqtcodesrand" runat="server"
                                                                                ForeColor="Red" ValidationGroup="NN"
                                                                                ControlToValidate="txttcodesrand">
                                                                            </asp:RequiredFieldValidator>
                                                                        </td>
                                                                        <td>
                                                                            <%--<b>Random Winners</b>&nbsp;--%>
                                                                        </td>
                                                                        <td>
                                                                            <asp:TextBox ID="txtrand" runat="server"
                                                                                CssClass="reg_txt" Width="100px"
                                                                                onkeypress="return isNumberKey(this, event);"
                                                                                onchange="GetVal(this.value)"
                                                                                Style="display: none;"></asp:TextBox>
                                                                            <asp:RequiredFieldValidator ID="reqrand"
                                                                                runat="server" ForeColor="Red"
                                                                                ValidationGroup="NN2324"
                                                                                ControlToValidate="txtrand">
                                                                            </asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:RadioButton ID="rdAllParticipant"
                                                                                runat="server" GroupName="RL"
                                                                                AutoPostBack="true"
                                                                                OnCheckedChanged="rdAllParticipant_CheckedChanged" />
                                                                        </td>
                                                                        <td>
                                                                            <b>All&nbsp;Participants</b>
                                                                        </td>
                                                                        <td>
                                                                            All&nbsp;Participants
                                                                        </td>
                                                                        <td>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </fieldset>
                                                        </td>
                                                    </tr>
                                                    <tr id="divduedate" runat="server">
                                                        <td colspan="5">
                                                            <fieldset class="Newfield"
                                                                style="border: 1px solid #D9E0E6;">
                                                                <legend>Participants</legend>
                                                                <table width="100%" style="padding-left: 25px;">
                                                                    <tr>
                                                                        <td width="3%">
                                                                            <asp:RadioButton ID="rdAlltonthrand"
                                                                                runat="server" GroupName="DL"
                                                                                AutoPostBack="true"
                                                                                OnCheckedChanged="rdAlltoAll_CheckedChanged" />
                                                                        </td>
                                                                        <td width="60%">
                                                                            <b>First 'n' from all
                                                                                participants</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                            <asp:TextBox AutoPostBack="true"
                                                                                OnTextChanged="GetWinner_TextChanged"
                                                                                ID="txtalltonth" Width="120px"
                                                                                runat="server" CssClass="reg_txt"
                                                                                placeholder="Random 'n' Winners"
                                                                                onkeypress="return isNumberKey(this, event);">
                                                                            </asp:TextBox>
                                                                            <asp:RequiredFieldValidator ID="reqalltonth"
                                                                                runat="server" ForeColor="Red"
                                                                                ValidationGroup="NN"
                                                                                ControlToValidate="txtalltonth">
                                                                            </asp:RequiredFieldValidator>
                                                                        </td>
                                                                        <td>
                                                                            <b>Every
                                                                                n<sup>th</sup></b>&nbsp;&nbsp;&nbsp;&nbsp;
                                                                            <asp:TextBox ID="txtrandfreq"
                                                                                AutoPostBack="true"
                                                                                OnTextChanged="GetWinner_TextChanged"
                                                                                Width="120px" runat="server"
                                                                                CssClass="reg_txt"
                                                                                placeholder="Participants"
                                                                                onkeypress="return isNumberKey(this, event);">
                                                                            </asp:TextBox>
                                                                            <asp:RequiredFieldValidator ID="reqrandfreq"
                                                                                runat="server" ForeColor="Red"
                                                                                ValidationGroup="NN"
                                                                                ControlToValidate="txtrandfreq">
                                                                            </asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:RadioButton ID="rdAllton"
                                                                                runat="server" GroupName="DL"
                                                                                AutoPostBack="true"
                                                                                OnCheckedChanged="rdAlltoAll_CheckedChanged" />
                                                                        </td>
                                                                        <td>
                                                                            <b>Random 'n' from all
                                                                                participants</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                            <asp:TextBox AutoPostBack="true"
                                                                                OnTextChanged="GetWinner1_TextChanged"
                                                                                ID="txtalltonCustomer" Width="120px"
                                                                                runat="server" CssClass="reg_txt"
                                                                                placeholder="Random 'n' Winners"
                                                                                onkeypress="return isNumberKey(this, event);">
                                                                            </asp:TextBox>
                                                                            <asp:RequiredFieldValidator
                                                                                ID="reqalltonCustomer" runat="server"
                                                                                ForeColor="Red" ValidationGroup="NN"
                                                                                ControlToValidate="txtalltonCustomer">
                                                                            </asp:RequiredFieldValidator>
                                                                        </td>
                                                                        <td>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:RadioButton ID="rdFirstnton"
                                                                                runat="server" GroupName="DL"
                                                                                Checked="true" AutoPostBack="true"
                                                                                OnCheckedChanged="rdAlltoAll_CheckedChanged" />
                                                                        </td>
                                                                        <td>
                                                                            <b>First 'n' from all
                                                                                participants</b>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
                                                                            <asp:TextBox ID="txtallpFirstn"
                                                                                runat="server" Width="120px"
                                                                                CssClass="reg_txt"
                                                                                placeholder="First 'n' Participants"
                                                                                onkeypress="return isNumberKey(this, event);"
                                                                                AutoPostBack="true"
                                                                                OnTextChanged="GetWinner2_TextChanged">
                                                                            </asp:TextBox>
                                                                            <asp:RequiredFieldValidator
                                                                                ID="reqallpFirstn" runat="server"
                                                                                ForeColor="Red" ValidationGroup="NN"
                                                                                ControlToValidate="txtallpFirstn">
                                                                            </asp:RequiredFieldValidator>
                                                                        </td>
                                                                        <td>
                                                                            <b>Winners</b>&nbsp;&nbsp;&nbsp;&nbsp;
                                                                            <asp:TextBox ID="txtallpFirstnton"
                                                                                runat="server" AutoPostBack="true"
                                                                                OnTextChanged="GetWinner2_TextChanged"
                                                                                Width="120px" CssClass="reg_txt"
                                                                                placeholder="Winner Count"
                                                                                onkeypress="return isNumberKey(this, event);">
                                                                            </asp:TextBox>
                                                                            <asp:RequiredFieldValidator
                                                                                ID="reqallpFirstnton" runat="server"
                                                                                ForeColor="Red" ValidationGroup="NN"
                                                                                ControlToValidate="txtallpFirstnton">
                                                                            </asp:RequiredFieldValidator>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td>
                                                                            <asp:RadioButton ID="rdAlltoAll"
                                                                                runat="server" GroupName="DL"
                                                                                AutoPostBack="true"
                                                                                OnCheckedChanged="rdAlltoAll_CheckedChanged" />
                                                                        </td>
                                                                        <td>
                                                                            <b>All Participants</b>
                                                                            &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span>All
                                                                                winners</span>
                                                                        </td>
                                                                        <td>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </fieldset>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <asp:Label ID="lblRwdHeader" runat="server"></asp:Label>
                                                            <asp:Label ID="lblRwdCounts" runat="server" ForeColor="Red"
                                                                Font-Size="9pt"></asp:Label>
                                                        </td>
                                                        <td colspan="3">
                                                            <asp:Label ID="lblProCount" runat="server"
                                                                Text="Total Product Details Counts "></asp:Label>
                                                            [<asp:Label ID="lblProDetCount" runat="server"
                                                                ForeColor="Green"></asp:Label>]
                                                        </td>
                                                    </tr>
                                                    <tr style="background-color: #E6E6E6;">
                                                        <td>
                                                            Gift Name
                                                        </td>
                                                        <td>
                                                            <%--Total Qty--%>Available Quantity
                                                        </td>
                                                        <td>
                                                            Qunatity
                                                        </td>
                                                        <td>
                                                            Infinite
                                                        </td>
                                                        <td>
                                                            Action
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                            <asp:DropDownList runat="server" ID="ddlAddGift"
                                                                CssClass="drp" Width="98%"
                                                                onchange="FillAvailable(this.value);">
                                                            </asp:DropDownList>
                                                            <asp:RequiredFieldValidator ID="ReqvalAddGidt"
                                                                runat="server" ControlToValidate="ddlAddGift"
                                                                ValidationGroup="ADG" InitialValue="--Select--">
                                                            </asp:RequiredFieldValidator>
                                                        </td>
                                                        <td align="center">
                                                            <asp:Label ID="lbltotqty" runat="server"></asp:Label>
                                                        </td>
                                                        <td width="10%">
                                                            <asp:TextBox ID="txtGiftQty" CssClass="reg_txt"
                                                                MaxLength="10" runat="server"
                                                                onkeypress="return isNumberKey(this, event);">
                                                            </asp:TextBox>
                                                        </td>
                                                        <td width="15%">
                                                            <asp:CheckBox ID="ChkInfinite" runat="server" Text="Infinie"
                                                                AutoPostBack="true"
                                                                OnCheckedChanged="ChkInfinite_CheckedChanged">
                                                            </asp:CheckBox>
                                                        </td>
                                                        <td width="15%">
                                                            <asp:Button ID="btnGSave" runat="server" Text="Save"
                                                                ValidationGroup="ADG" CssClass="button_all"
                                                                Style="min-width: 45px; padding: 5px 5px;"
                                                                OnClick="btnGSave_Click" />&nbsp;
                                                            <asp:Button ID="btnGReset" CausesValidation="false"
                                                                runat="server" Text="Reset" CssClass="button_all"
                                                                OnClick="btnGReset_Click"
                                                                Style="min-width: 45px; padding: 5px 5px;" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="5">
                                                            <div style="overflow: auto; height: 150px;">
                                                                <asp:GridView ID="GrdVwGift" runat="server"
                                                                    AutoGenerateColumns="False" CssClass="grid"
                                                                    EmptyDataText="Record Not Found"
                                                                    EmptyDataRowStyle-HorizontalAlign="Center"
                                                                    EnableModelValidation="True" Width="100%"
                                                                    BorderStyle="None" BorderWidth="0"
                                                                    BorderColor="transparent" AllowPaging="True"
                                                                    OnRowCommand="GrdVwGift_RowCommand" PageSize="15">
                                                                    <Columns>
                                                                        <asp:TemplateField HeaderText="S.No">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblsrno" runat="server"
                                                                                    Text='<%# Bind("AdditionalGift_ID") %>'>
                                                                                </asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle CssClass="tr_haed"
                                                                                HorizontalAlign="Center" />
                                                                            <ItemStyle HorizontalAlign="Center"
                                                                                CssClass="grd_pad" Width="4%" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Gift Name">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblgiftname"
                                                                                    runat="server"
                                                                                    Text='<%# Bind("GiftName") %>'>
                                                                                </asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle CssClass="tr_haed"
                                                                                HorizontalAlign="Justify" />
                                                                            <ItemStyle HorizontalAlign="Justify"
                                                                                CssClass="grd_pad" Width="15%" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField
                                                                            HeaderText="&nbsp;&nbsp;&nbsp;&nbsp;Gift Count">
                                                                            <ItemTemplate>
                                                                                <asp:Label ID="lblgiftcount"
                                                                                    runat="server"
                                                                                    Text='<%# Convert.ToInt32(Eval("GiftCount")) == 0 ? "Infinite" : Eval("GiftCount")  %>'>
                                                                                </asp:Label>
                                                                            </ItemTemplate>
                                                                            <HeaderStyle CssClass="tr_haed"
                                                                                HorizontalAlign="Center" />
                                                                            <ItemStyle HorizontalAlign="Center"
                                                                                CssClass="grd_pad" Width="15%" />
                                                                        </asp:TemplateField>
                                                                        <asp:TemplateField HeaderText="Action">
                                                                            <ItemTemplate>
                                                                                <asp:ImageButton ID="Imgbtngftedit"
                                                                                    runat="server"
                                                                                    CommandArgument='<%# Bind("AdditionalGift_ID") %>'
                                                                                    CausesValidation="false"
                                                                                    CommandName="EditGiftRow"
                                                                                    ToolTip="Edit Gift Details"
                                                                                    ImageUrl="~/Content/images/edit.png" />
                                                                                &nbsp;
                                                                                <asp:ImageButton ID="Imgbtngftdel"
                                                                                    runat="server"
                                                                                    CommandArgument='<%# Bind("AdditionalGift_ID") %>'
                                                                                    CausesValidation="false"
                                                                                    CommandName="DeleteGiftRow"
                                                                                    ToolTip="Delete Gift"
                                                                                    ImageUrl="~/Content/images/delete.png" />
                                                                                &nbsp;
                                                                            </ItemTemplate>
                                                                            <HeaderStyle CssClass="tr_haed"
                                                                                HorizontalAlign="Justify" />
                                                                            <ItemStyle HorizontalAlign="Justify"
                                                                                CssClass="grd_pad" Width="7%" />
                                                                        </asp:TemplateField>
                                                                    </Columns>
                                                                    <PagerStyle HorizontalAlign="Center"
                                                                        CssClass="pagination" />
                                                                    <RowStyle CssClass="tr_line1" />
                                                                    <AlternatingRowStyle CssClass="tr_line2" />
                                                                </asp:GridView>
                                                                <asp:HiddenField ID="hdngiftrowid" runat="server" />
                                                                <asp:HiddenField ID="hdneditvalue" runat="server" />
                                                            </div>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr id="divissoundComments" runat="server">
                                        <td colspan="2">
                                            <fieldset class="Newfield">
                                                <legend>Message</legend>
                                                <table width="100%">
                                                    <tr>
                                                        <td align="right" style="width: 27%;">
                                                            <asp:RequiredFieldValidator ID="RFVIsMessage" runat="server"
                                                                ForeColor="Red" ValidationGroup="NN"
                                                                ControlToValidate="txtCommentsTxt">
                                                            </asp:RequiredFieldValidator>
                                                            <strong><span class="astrics">*</span> Message :</strong>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtCommentsTxt" MaxLength="100"
                                                                TextMode="MultiLine" Width="95%" Height="30px"
                                                                CssClass="textbox_pop"
                                                                onkeyDown="return checkTextAreaMaxLength(this,event,'25');"
                                                                runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                        </td>
                                                        <td class="astrics">
                                                            Message should be in 25 character
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 23%; text-align: right;">
                                                            <asp:RequiredFieldValidator ID="RFVIsSoundH" runat="server"
                                                                ForeColor="Red" ValidationGroup="NN"
                                                                ControlToValidate="flSoundH">
                                                            </asp:RequiredFieldValidator>
                                                            <strong>
                                                                <asp:Label ID="L2" runat="server" CssClass="astrics"
                                                                    Text="*"></asp:Label>
                                                                Hindi :
                                                            </strong>
                                                        </td>
                                                        <td style="width: 40%">
                                                            <asp:FileUpload ID="flSoundH"
                                                                onchange="fileTypeCheckengH(this.value);" runat="server"
                                                                Style="width: 88%;" />
                                                        </td>
                                                        <td style="width: 15%;">
                                                            <div
                                                                style="width: 25px; float: right; padding-right: 15px;">
                                                                <ul class="graphic">
                                                                    <li><a id="FileDownHindi" runat="server"
                                                                            title="Play" class="sm2_link"></a></li>
                                                                </ul>
                                                            </div>
                                                            <asp:Label ID="lblfileH" runat="server"
                                                                Style="color: Red; font-family: Arial; font-size: 12px;">
                                                            </asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" style="width: 10%">
                                                            <asp:RequiredFieldValidator ID="RFVIsSoundE" runat="server"
                                                                ForeColor="Red" ValidationGroup="NN"
                                                                ControlToValidate="flSoundE">
                                                            </asp:RequiredFieldValidator>
                                                            <strong>
                                                                <asp:Label ID="L1" runat="server" CssClass="astrics"
                                                                    Text="*"></asp:Label>
                                                                English :
                                                            </strong>
                                                        </td>
                                                        <td>
                                                            <asp:FileUpload ID="flSoundE"
                                                                onchange="fileTypeCheckengE(this.value);" runat="server"
                                                                Style="width: 88%;" />
                                                        </td>
                                                        <td>
                                                            <div
                                                                style="width: 25px; float: right; padding-right: 15px;">
                                                                <ul class="graphic">
                                                                    <li><a id="FileDownEnglish" runat="server"
                                                                            title="Play" class="sm2_link"></a></li>
                                                                </ul>
                                                            </div>
                                                            <asp:Label ID="lblfileE" runat="server"
                                                                Style="color: Red; font-family: Arial; font-size: 12px;">
                                                            </asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td colspan="2">
                                                            <asp:Label ID="lblnoteSound"
                                                                Style="font-family: Arial; font-size: 12px; color: red;"
                                                                runat="server"
                                                                Text="Note:- Audio file to be uploaded on the website should be in the prescribed format as below">
                                                            </asp:Label>
                                                            <br />
                                                            <asp:Label ID="Label11"
                                                                Style="font-family: Arial; font-size: 12px; color: red;"
                                                                runat="server" Text="File Type ---- .wav"></asp:Label>
                                                            <br />
                                                            <asp:Label ID="lblfileformat"
                                                                Style="font-family: Arial; font-size: 12px; color: red;"
                                                                runat="server" Text="Format ---- 8KHz, 16bit mono">
                                                            </asp:Label>
                                                            <br />
                                                            <asp:Label ID="lblBitRate"
                                                                Style="font-family: Arial; font-size: 12px; color: red;"
                                                                runat="server" Text="Bit Rate ---- 128 kbps">
                                                            </asp:Label>
                                                            <br />
                                                            <asp:Label ID="Label12"
                                                                Style="font-family: Arial; font-size: 12px; color: Blue;"
                                                                runat="server"
                                                                Text="For record the audio file, Please click the link ">
                                                            </asp:Label>&nbsp;
                                                            <a href="http://wavepad.en.softonic.com/" style="font-family: Arial; font-size: 12px;
                                                                color: Blue;" target="_blank">Click</a>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="4">
                                            <asp:Button ID="btnSave" runat="server" CssClass="button_all"
                                                OnClick="btnSave_Click" ValidationGroup="SRVS" Text="OK" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupLoyalty" runat="server" BackgroundCssClass="NewmodalBackground"
                    PopupControlID="AddLoyaltyPanel" TargetControlID="LblTargetLoyalty"
                    CancelControlID="btncloseloyalty">
                </cc1:ModalPopupExtender>
                <asp:Label ID="LblTargetLoyalty" runat="server"></asp:Label>
                <asp:HiddenField ID="hdnloyalty" runat="server" />
                <!-------------------End Loyalty Popup--------------->
                <!-------------------Start Service Popup--------------->
                <asp:Panel ID="PanelServices" runat="server" Width="55%">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnclosesrv" CssClass="popupClose" runat="server" />
                            </div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="LabelAlertHeadsrv" runat="server" Font-Bold="true"
                                            Text="Our Services"></asp:Label>
                                    </span>
                                </p>
                            </div>
                            <div class="regis_popup">
                                <div class="wrapper" id="wrapper">
                                    <div class="specialties" id="specialties">
                                        <div class="container">
                                            <div class="heading text-center">
                                                <h2>
                                                    Our Services</h2>
                                            </div>
                                            <div class="row">
                                                <asp:Panel ID="pnlTextBox" runat="server">
                                                </asp:Panel>
                                                <asp:Panel ID="pnlDropDownList" runat="server">
                                                </asp:Panel>
                                                <asp:Literal ID="srvlitral" runat="server"></asp:Literal>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupExtenderServices" runat="server"
                    BackgroundCssClass="NewmodalBackground" PopupControlID="PanelServices"
                    TargetControlID="lblsrvcontrol" CancelControlID="btnclosesrv">
                </cc1:ModalPopupExtender>
                <asp:Label ID="lblsrvcontrol" runat="server"></asp:Label>
                <!-------------------End Start Service Popup--------------->
                <!-------------------Start Alert Popup--------------->
                <asp:Panel ID="PanelAlert" runat="server" Width="25%">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnclosealerttest" CssClass="popupClose" runat="server" />
                            </div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="LabelAlertHead" runat="server" Font-Bold="true" Text="Alert">
                                        </asp:Label>
                                    </span>
                                </p>
                            </div>
                            <div class="regis_popup">
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="center">
                                            <asp:Label ID="lblalert" runat="server" Font-Bold="true" Font-Size="10pt">
                                            </asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 7px;">
                                        </td>
                                    </tr>
                                    <tr align="center">
                                        <td>
                                            <asp:Button ID="btnYesAlert" runat="server" OnClick="btnYesAlert_Click"
                                                CssClass="button_all" CausesValidation="false" Text="Yes" />&nbsp;&nbsp;
                                            <asp:Button ID="btnNoAlert" runat="server" OnClick="btnNoAlert_Click"
                                                CssClass="button_all" Text="No" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupExtenderAlert" runat="server"
                    BackgroundCssClass="NewmodalBackground" PopupControlID="PanelAlert" TargetControlID="lbltestcontrol"
                    CancelControlID="btnclosealerttest">
                </cc1:ModalPopupExtender>
                <asp:Label ID="lbltestcontrol" runat="server"></asp:Label>
                <!-------------------End Alert Popup--------------->
                <!-------------------Start Plan Grid Popup--------------->
                <asp:Panel ID="PlanGridView" runat="server" Width="30%">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnplgrw" CssClass="popupClose" runat="server" />
                            </div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="lblplgrw" runat="server" Font-Bold="true" Text="Plan Details">
                                        </asp:Label>
                                    </span>
                                </p>
                            </div>
                            <div id="Div2" runat="server" style="width: 89%;">
                                <p>
                                    <asp:Label ID="Label8" runat="server"></asp:Label>
                                </p>
                            </div>
                            <div class="regis_popup">
                                <table width="100%" cellpadding="0px" cellspacing="5px">
                                    <tr>
                                        <td width="30%">
                                            <strong>Select Product</strong>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlProSelect" runat="server" CssClass="dropdown">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <strong>Select Plan</strong>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:GridView ID="PlanGridViewDetails" runat="server"
                                                AutoGenerateColumns="False" DataKeyNames="Plan_ID,Disp" CssClass="grid"
                                                EmptyDataText="Record Not Found"
                                                EmptyDataRowStyle-HorizontalAlign="Center" EnableModelValidation="True"
                                                Width="100%" BorderStyle="None" BorderWidth="0"
                                                BorderColor="transparent" AllowPaging="True"
                                                OnRowCommand="PlanGridViewDetails_RowCommand" PageSize="15">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <%try {
                                                                PlanID=PlanGridViewDetails.DataKeys[upplanindex].Values["Plan_ID"].ToString();//LabelFlag
                                                                Disp=Convert.ToInt32(PlanGridViewDetails.DataKeys[upplanindex].Values["Disp"].ToString());
                                                                } catch { } if (Session["Plan_ID"].ToString()==PlanID) {
                                                                Disp=1; if (Disp==0) { %>
                                                                <input type="radio" id="rdamcrenewalaut"
                                                                    name="rdamcrewaut" checked="checked"
                                                                    value='<%# Eval("PlanPeriod") %>'
                                                                    onclick="javascript:SelectSingleRadiobuttonAmc(this.id,this.value)" />
                                                                <% } else {%>
                                                                    <input type="radio" id="Radio1" name="rdamcrewaut"
                                                                        checked="checked" disabled="disabled"
                                                                        value='<%# Eval("PlanPeriod") %>'
                                                                        onclick="javascript:SelectSingleRadiobuttonAmc(this.id,this.value)" />
                                                                    <% } } else { if (Disp==0) {%>
                                                                        <input type="radio" id="Rrdamcrenewalaut"
                                                                            name="rdamcrewaut"
                                                                            value='<%# Eval("PlanPeriod") %>'
                                                                            onclick="javascript:SelectSingleRadiobuttonAmc(this.id,this.value)" />
                                                                        <% } else {%>
                                                                            <input type="radio" id="Radio2"
                                                                                name="rdamcrewaut" disabled="disabled"
                                                                                value='<%# Eval("PlanPeriod") %>'
                                                                                onclick="javascript:SelectSingleRadiobuttonAmc(this.id,this.value)" />
                                                                            <%} }%>
                                                                                <%upplanindex++; %>
                                                                                    <asp:Label ID="lblrenewalPlanID"
                                                                                        runat="server"
                                                                                        Text='<%# Bind("Plan_ID") %>'
                                                                                        Visible="false"></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                    </asp:TemplateField>
                                                    <%--<asp:TemplateField HeaderText="S.No">
                                                        <ItemTemplate>
                                                            <%=++sno %>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="grd_pad"
                                                            Width="4%" />
                                                        </asp:TemplateField>--%>
                                                        <asp:TemplateField HeaderText="Service Title">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lbladdsrvtitle" runat="server"
                                                                    Text='<%# Bind("PlanName") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad"
                                                                Width="15%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Time(In Months)">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblplntime" runat="server"
                                                                    Text='<%# Bind("PlanPeriod") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad"
                                                                Width="15%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Price">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblplnprice" runat="server"
                                                                    Text='<%# Bind("PlanPrice") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad"
                                                                Width="7%" />
                                                        </asp:TemplateField>
                                                        <%--<asp:TemplateField HeaderText="Action">
                                                            <ItemTemplate>
                                                                <asp:Button ID="ImgbtnRedeem" runat="server"
                                                                    CommandArgument='<%# Bind("Plan_ID") %>'
                                                                    CausesValidation="false" CommandName="BuyService"
                                                                    ToolTip="Redeem Awards" Text="Buy Now"
                                                                    CssClass="redeem" />&nbsp;
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad"
                                                                Width="7%" />
                                                            </asp:TemplateField>--%>
                                                </Columns>
                                                <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                <RowStyle CssClass="tr_line1" />
                                                <AlternatingRowStyle CssClass="tr_line2" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <strong>Plan Period</strong>
                                        </td>
                                        <td>
                                            <asp:HiddenField ID="HdValAMC1" runat="server" />
                                            <asp:HiddenField ID="HdDateTo1" runat="server" />
                                            <asp:TextBox ID="txtdtfromamc1" onchange="FindNextDateAmc(this.value);"
                                                runat="server" Width="120px" onkeydown="return checkShortcut();"
                                                CssClass="reg_txt"></asp:TextBox>
                                            <strong>To </strong>
                                            <asp:TextBox ID="txtdttoamc1" Enabled="false" runat="server"
                                                CssClass="reg_txt" Width="120px"></asp:TextBox><br />
                                            <%--<asp:Label ID="lblAmcText" runat="server" Style="font-size: 14px;">Old
                                                Amc End Date :</asp:Label>
                                                <br />
                                                <asp:Label ID="lblAmcenddate" runat="server" Font-Bold="true"
                                                    Font-Size="12px" CssClass="astrics" Text=""></asp:Label>
                                                <br />
                                                <asp:Label ID="lblOfferenddate" runat="server" Font-Bold="true"
                                                    Font-Size="12px" CssClass="astrics" Text=""></asp:Label>--%>
                                                <asp:TextBox ID="txtProName" runat="server" Style="display: none;">
                                                </asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <asp:CheckBox ID="chkIsCustome" runat="server" Text="  IsCustom"
                                                onchange="javascript:IsCustom();" />
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <table width="100%">
                                                <tr>
                                                    <td>
                                                        Master Price :
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPlanAmount" runat="server"
                                                            CssClass="reg_txt" ReadOnly="true"
                                                            onkeypress="return isNumberKey(this, event);"
                                                            onchange="javascript:WritrVal();" Width="100px">
                                                        </asp:TextBox>
                                                    </td>
                                                    <td>
                                                        Sale Price :
                                                    </td>
                                                    <td>
                                                        <asp:TextBox ID="txtPlanDiscount" runat="server"
                                                            CssClass="reg_txt" ReadOnly="true"
                                                            onkeypress="return isNumberKey(this, event);"
                                                            onchange="javascript:WritrVal1();" Width="100px">
                                                        </asp:TextBox>
                                                        <asp:HiddenField ID="hdnPlanAmount1" runat="server" Value="0" />
                                                        <asp:HiddenField ID="hdnPlanDiscount1" runat="server"
                                                            Value="0" />
                                                    </td>
                                                </tr>
                                                <tr>
                                                    <td>Master Period : </td>
                                                    <td>
                                                        <asp:TextBox ID="txtmPeriod" runat="server" CssClass="reg_txt"
                                                            onchange="javascript:WritrVal();"
                                                            onkeypress="return isNumberKey(this, event);"
                                                            ReadOnly="true" Width="50px"></asp:TextBox>
                                                    </td>
                                                    <td>Sale Period : </td>
                                                    <td>
                                                        <asp:TextBox ID="txtsPeriod" runat="server" CssClass="reg_txt"
                                                            onchange="javascript:WritrVal1();"
                                                            onkeypress="return isNumberKey(this, event);"
                                                            ReadOnly="true" Width="50px"></asp:TextBox>
                                                        <asp:HiddenField ID="hdnmPeriod" runat="server" Value="0" />
                                                        <asp:HiddenField ID="hdnsPeriod" runat="server" Value="0" />
                                                    </td>
                                            </table>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <cc1:CalendarExtender ID="CalendarerExtender3" runat="server"
                                                TargetControlID="txtdtfromamc1" Format="dd/MM/yyyy">
                                            </cc1:CalendarExtender>
                                            <%--<cc1:MaskedEditExtender ID="MaskedEerditExtender3" runat="server"
                                                TargetControlID="txtdtfromamc1" Mask="99/99/9999" MaskType="Date">
                                                </cc1:MaskedEditExtender>--%>
                                                <cc1:TextBoxWatermarkExtender ID="TextewrwBoxWatermarkExtender3"
                                                    runat="server" TargetControlID="txtdtfromamc1"
                                                    WatermarkText="From..">
                                                </cc1:TextBoxWatermarkExtender>
                                                <cc1:CalendarExtender ID="CalendarExerwtender4" runat="server"
                                                    TargetControlID="txtdttoamc1" Format="dd/MM/yyyy">
                                                </cc1:CalendarExtender>
                                                <cc1:MaskedEditExtender ID="MaskedEditwerweExtender4" runat="server"
                                                    TargetControlID="txtdttoamc1" Mask="99/99/9999" MaskType="Date">
                                                </cc1:MaskedEditExtender>
                                                <cc1:TextBoxWatermarkExtender ID="TextBowerxWatermarkExtender4"
                                                    runat="server" TargetControlID="txtdttoamc1" WatermarkText="To..">
                                                </cc1:TextBoxWatermarkExtender>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:CheckBox ID="chkterms" runat="server" Text="Terms & Conditions " /><a
                                                href="#">Terms
                                                & Condiions</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Button ID="btnAmcRenewal" runat="server" Text="Submit"
                                                OnClick="Submit_Click" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupExtenderGridView" runat="server"
                    BackgroundCssClass="NewmodalBackground" PopupControlID="PlanGridView" TargetControlID="lblctrlplgrw"
                    CancelControlID="btnplgrw">
                </cc1:ModalPopupExtender>
                <asp:Label ID="lblctrlplgrw" runat="server"></asp:Label>
                <!-------------------End Plan Grid Popup--------------->
            </div>

            <asp:Label Text="" ID="lblCouponRequest_ID" Visible="false" runat="server" />

        </asp:Content>