<%@ Page Title="Packet Allocation" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master"
    AutoEventWireup="true" CodeFile="DemoCodeAllocation.aspx.cs" Inherits="DemoCodeAllocation" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
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
        var count = 0;
        $(document).ready(function () {
            var username = '<%=Session["User_Type"]%>';

            $("#txtDateFrom").datepicker("setDate", new Date());
            $("#txtDateto").datepicker("setDate", new Date());
            if (username == "") {
                window.location.href = "<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/Login.aspx?Page=DemoCodeAllocation.aspx&usertype=Admin";
            }
            else {
                if (username == "Company")
                    window.location.href = "<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/Login.aspx";
            }
            $('.input-daterange').datepicker({
                todayBtn: "linked"

            });
            filldemoalocation();
        });

        function Bindcompanyproduct(value) {
            $('#trpkg').show();
            $('#ddlpkg').find('option').remove();
            $("select[id$=ddlpkg]").html('<option selected="selected" value="0">Select Packet</option>');
            var objdata1 = "";
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getpacketbytypeid",
                data: "{'bunchCode':'" + value + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var objdata = $.parseJSON(data.d);
                    $('#ddlpkg').find('option').remove();
                    var _options = "";
                    if ((objdata != undefined) && (objdata.length != 0)) {
                        _options = '<option selected="selected" value="0">Select Packet</option>';
                        for (var i = 0; i < objdata.length; i++)
                            _options += "<option value='" + objdata[i].bunchCode + "'>" + objdata[i].Packet_Name + "</option>";
                        $("select[id$=ddlpkg]").html(_options);
                    }

                }
            });
        }

        function avilablelabels() {
            var avilablelabel = "0";
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getpackagetype",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var upHTML = $.parseJSON(data.d);
                    if (upHTML != "") {
                        avilablelabel = upHTML;
                        AddPrintLables(avilablelabel);
                    }
                }
            });
        }
        function AddPrintLables(remaining) {
            $.confirm({
                title: 'Confirm!',
                content: 'Are you sure to add Package Allocation !',
                buttons: {
                    confirm: function () {
                        $.confirm({
                            title: 'Package Allocation',
                            content: 'url:packageAllocation.html',
                            onContentReady: function () {
                                $("select[id$=ddlpkg]").html('<option selected="selected" value="0">Select Product</option>');
                                $("select[id$=ddlpkgtype]").html('<option selected="selected" value="0">Select Package Type</option>');
                                var objdata = remaining;
                                $('.ddlpkgtype').find('option').remove();
                                var _options = "";
                                if ((objdata != undefined) && (objdata.length != 0)) {
                                    _options = '<option selected="selected" value="0">Select Package Type</option>';
                                    for (var i = 0; i < objdata.length; i++)
                                        _options += "<option value='" + objdata[i].totalCount + "' onclick='Bindcompanyproduct(" + objdata[i].bunchCode + ")'>" + objdata[i].bunchCode + "</option>";
                                    $("select[id$=ddlpkgtype]").html(_options);
                                    //Bindcompanyproduct();
                                }
                            },
                            boxWidth: '600px',
                            useBootstrap: false,
                            buttons: {
                                sayMyName: {
                                    text: 'Confirm',
                                    btnClass: 'btn-warning',
                                    action: function () {
                                        
                                        var input = this.$content.find('input#txtemail').val();
                                        var input1 = this.$content.find('input#txtcompname').val();
                                        var input2 = this.$content.find('input#txtperson').val();
                                        var input3 = this.$content.find('input#txtmobile').val();
                                        var input4 = $("#ddlpkgtype option:selected").text();
                                        var input5 = $("#ddlpkg option:selected").text();
                                        var errorText = this.$content.find('.text-danger');
                                        if (input == '') {
                                            errorText.html('<div class="text-danger help-block">Please don\'t keep the Email field empty<div>').slideDown(200);
                                            return false;
                                        } if (input1 == '') {
                                            errorText.html('<div class="text-danger help-block">Please don\'t keep the Company Name field empty<div>').slideDown(200);
                                            return false;
                                        } if (input2 == '') {
                                            errorText.html('<div class="text-danger help-block">Please don\'t keep the Contact Persion Name field empty<div>').slideDown(200);
                                            return false;
                                        } if (input3 == '') {
                                            errorText.html('<div class="text-danger help-block">Please don\'t keep the Mobile field empty<div>').slideDown(200);
                                            return false;
                                        } if (input4 == '') {
                                            errorText.html('<div class="text-danger help-block">Please don\'t keep the Packet Type field empty<div>').slideDown(200);
                                            return false;
                                        } if (input5 == '') {
                                            errorText.html('<div class="text-danger help-block">Please don\'t keep the Packet field empty<div>').slideDown(200);
                                            return false;
                                        } 
                                        else {
                                            debugger;
                                            $.ajax({
                                                type: "POST",
                                                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/submitalocation",
                                                data: "{'email':'" + input + "','comp':'" + input1 + "','person':'" + input2 + "','mbile':'" + input3 + "','pkgtype':'" + input4 + "','packet':'" + input5 + "'}",
                                                contentType: "application/json; charset=utf-8",
                                                dataType: "json",
                                                success: function (data) {
                                                    var upHTML = data.d;
                                                    if (upHTML != "") {
                                                        $.alert(upHTML);
                                                        filldemoalocation();
                                                    }
                                                }
                                            });
                                        }
                                    }
                                },
                                cancel: function () {
                                    $.alert('Canceled!');
                                }
                            }
                        });
                    },
                    cancel: function () {
                        $.alert('Canceled!');
                    },
                }
            });

        }


        function filldemoalocation() {
            var Comp = $('#txtCompName').val();
            var Persion = $('#txtpersnName').val();
            var fromdate = $("#txtDateFrom").val();
            var todate = $("#txtDateto").val();
            $("#txtCompName").val('');
            $("#txtpersnName").val('');
            count = 0;
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/filldemoalocation",
                data: "{'Company':'" + Comp + "','fromdate':'" + fromdate + "','todate':'" + todate + "','Persion':'" + Persion + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    objdispachLabelsRecord = $.parseJSON(data.d);
                    var trdlrHTML = '';
                    if (objdispachLabelsRecord.length > 0) {
                        $('#lblcountLicence').text(objdispachLabelsRecord.length);
                        $('#GrdCodePrint > tbody').html("");
                        for (var i in objdispachLabelsRecord) {
                            trdlrHTML += '<tr>' +
                               '<td>' + objdispachLabelsRecord[count].SendDate + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].Comp_Name + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].Contact_Name + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].Contact_No + ' </td>' +
                             '<td>' + objdispachLabelsRecord[count].Email_ID + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].Packet_Name + ' </td>' +
                            '</tr>';
                            count++;
                        }
                    }
                    else {
                        trdlrHTML += "<td colspan='8' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td>";
                    }
                    $('#GrdCodePrint > tbody').html(trdlrHTML);

                }
            });
        }

        function checkemail() {
            var email = $('#txtemail').val();
            if (email == '') {
                $.alert("Enter Email Address !");
            }
            else {
                var emailReg = new RegExp("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
                var valid = emailReg.test(email);
                if (!valid) {
                    $.alert("Please enter the correct email."); return false;
                }
                else {
                    //alert(email);
                    $.ajax({
                        type: "POST",
                        url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/chkemail",
                        data: "{'email':'" + email + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            var upHTML = data.d;
                            if (upHTML != "") {
                                //$('#lblmsg').text(upHTML);
                                $.alert(upHTML);
                                $('#txtemail').val('');
                            }
                        }
                    });
                }
            }
        }

        function resetdata() {
            $("#txtCompName").val('');
            $("#txtpersnName").val('');
            $("#txtDateFrom").datepicker("setDate", new Date());
            $("#txtDateto").datepicker("setDate", new Date());
            $('#GrdCodePrint > tbody').html('');
            var fromdate = $("#txtDateFrom").val();
            var todate = $("#txtDateto").val();
            var Comp = "";
            var Persion = "";
            var packetcode = "";
            count = 0;
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/filldemoalocation",
                data: "{'Company':'" + Comp + "','fromdate':'" + fromdate + "','todate':'" + todate + "','Persion':'" + Persion + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#lblcountLicence').text("0");
                    objdispachLabelsRecord = $.parseJSON(data.d);
                    var trdlrHTML = '';
                    $('#lblcountLicence').text(objdispachLabelsRecord.length);
                    if (objdispachLabelsRecord.length > 0) {
                        $('#GrdCodePrint > tbody').html("");
                        for (var i in objdispachLabelsRecord) {
                            trdlrHTML += '<tr>' +
                               '<td>' + objdispachLabelsRecord[count].SendDate + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].Comp_Name + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].Contact_Name + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].Contact_No + ' </td>' +
                             '<td>' + objdispachLabelsRecord[count].Email_ID + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].Packet_Name + ' </td>' +
                            '</tr>';
                            count++;
                        }
                    }
                    else {
                        trdlrHTML += "<td colspan='8' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td>";
                    }
                    $('#GrdCodePrint > tbody').html(trdlrHTML);

                }
            });
        }
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="breadcrumbs" id="breadcrumbs">
        <script type="text/javascript">
            try { ace.settings.check('breadcrumbs', 'fixed') } catch (e) { }
        </script>

        <ul class="breadcrumb">
            <li>
                <i class="ace-icon fa fa-home home-icon"></i>
                <a href="Dashboard.aspx">Home</a>
            </li>
            <li class="active"></li>
        </ul>
        <!-- /.breadcrumb -->

        <!-- #section:basics/content.searchbox -->
        <!-- /.nav-search -->

        <!-- /section:basics/content.searchbox -->
    </div>
    <div class="col-md-12">

        <div class="col-sm-10">
            <h3 class="header blue lighter smaller">
                <img src="../images/demo.png" />Packet Allocation
            </h3>
        </div>
        <div class="col-sm-2">
            <h3 class="lighter smaller">
                <img src="../images/addadv.png" style="width: 25%" onclick="return avilablelabels();" />
            </h3>
        </div>
    </div>
    <div class="col-md-10">
        <fieldset class="field_profile" style="margin: 0 auto;">
            <legend>
                <img src="../images/search_icon.png" />
                Search</legend>
            <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                <tr>
                    <td>
                        <input type="text" id="txtCompName" placeholder="Company Name" class="input-sm" /></td>
                    <td>
                        <input type="text" id="txtpersnName" placeholder="Contact Person" class="input-sm" /></td>
                    <td align="justify" colspan="2">
                        <div class="hero-unit">
                            <div class="input-daterange" id="datepicker">
                                <input type="text" id="txtDateFrom" class="input-sm" name="start" />
                                <span class="add-on" style="vertical-align: top; height: 30px; font-size: 21px; font-weight: bold;">To</span>
                                <input type="text" id="txtDateto" class="input-sm" name="end" />
                            </div>
                        </div>
                    </td>
                    <td align="justify">
                        <div class="merg_btn">
                            <img src="../Content/images/search_rec.png" onclick="return filldemoalocation();" />
                            <img src="../Content/images/reset.png" onclick="return resetdata();" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="5"></td>
                </tr>
            </table>
        </fieldset>

    </div>
    <div class="clearfix" style="height: 180px"></div>
    <div class="col-xs-12">
        <div class="row">
            <div class="col-xs-12">
                <div class="table-header">
                    <div style="float: left;">
                        <img src="../Content/images/regis_pro.png" />Record(s) found
                    </div>
                    <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 30px; width: auto; line-height: 22px;">
                        <label id="lblcountLicence" style="color: #fff;">0</label>
                    </div>
                    <%-- <div style="float: right">
                        <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 50px; width: auto; line-height: 22px;">
                            <img src="../Content/images/download.png" style="cursor: pointer" onclick="return Downloaddata();" />
                        </div>
                    </div>--%>
                </div>
                <table id="GrdCodePrint" class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>Allot Date</th>
                            <th>Company Name</th>
                            <th>Contact Person</th>
                            <th>Contact No.</th>
                            <th>Email ID</th>
                            <th>Packet secret code</th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <!-- /.span -->
        </div>
    </div>
    <div class="clearfix" style="height: 180px"></div>
</asp:Content>
