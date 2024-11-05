<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="frmDemoPrintLable.aspx.cs" Inherits="Admin_frmDemoPrintLable" %>

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
    </style>
    <script type="text/javascript">
        var count = 0;
        debugger;
        $(document).ready(function () {
            var username = '<%= Session["User_Type"] %>';
           
            $("#txtDateFrom").datepicker("setDate", new Date());
            $("#txtDateto").datepicker("setDate", new Date());
            if (username = "") {
                window.location.href = "<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/Login.aspx?Page=frmDemoPrintLable.aspx&usertype=Admin";
            }
            else {
                if (username == "Company")
                    window.location.href = "Index.aspx";
            }
            $('.input-daterange').datepicker({
                todayBtn: "linked"

            });
           
            getddlNoofCodes();
            filldata();
        });


        function getddlNoofCodes() {
            
            $("select[id$=ddlNoofCodes]").html('<option selected="selected" value="0"> --All-- </option>');
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getddlNoofCodes",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                   
                    var objdata = $.parseJSON(data.d);
                    $('.ddlNoofCodes').find('option').remove();
                    var _options = "";
                    if ((objdata != undefined) && (objdata.length != 0)) {
                        _options = '<option selected="selected" value="0"> --All-- </option>';
                        for (var i = 0; i < objdata.length; i++)
                            _options += "<option value='" + objdata[i].PrintBunchofCode + "'>" + objdata[i].PP + "</option>";
                        $("select[id$=ddlNoofCodes]").html(_options);
                    }
                }
            });

        }
        //function resetdata() {
        //    $("#txtDateFrom").datepicker("setDate", new Date());
        //    $("#txtDateto").datepicker("setDate", new Date());
        //    getcompany();
        //    $('#GrdCodePrint > tbody').html('');
        //}


        function resetdata() {
            debugger;
            $("#txtDateFrom").datepicker("setDate", new Date());
            $("#txtDateto").datepicker("setDate", new Date());
            getddlNoofCodes();
            $('#GrdCodePrint > tbody').html('');
            var status = "--Status--";
            var noofcode = "0";
            var fromdate = $("#txtDateFrom").val();
            var todate = $("#txtDateto").val();
            var packetcode = "";
            count = 0;
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getdemoprintlabel",
                data: "{'status':'" + status + "','noofcode':'" + noofcode + "','fromdate':'" + fromdate + "','todate':'" + todate + "','code':'" + packetcode + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    debugger;
                    objdispachLabelsRecord = $.parseJSON(data.d);
                    var trdlrHTML = '';
                    if (objdispachLabelsRecord.length > 0) {
                        $('#lblcountLicence').text(objdispachLabelsRecord.length);
                        $('#GrdCodePrint > tbody').html("");
                        for (var i in objdispachLabelsRecord) {
                            var dates = (objdispachLabelsRecord[count].DownFl).split('*');
                            trdlrHTML += '<tr>' +
                               '<td>' + formatJsonDate(objdispachLabelsRecord[count].Print_Date) + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].Use_Type + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].PrintBunchofCode + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].CodeStatus + ' </td>' +
                             '<td><a href=Excel/' + dates[1] + '/Demo/' + objdispachLabelsRecord[count].Use_Type + '.xls>Download Excel File</a></td>' +
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
        function avilablelabels() {
            debugger;
            var avilablelabel = "0";
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getavilablecodes",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    debugger;
                    var upHTML = data.d;
                    if (upHTML != "") {
                        avilablelabel = upHTML;
                        AddPrintLables(avilablelabel);
                    }
                }
            });
        }

        function totallabels() {
            debugger;
            $('#lblCodes').text(parseInt($('#ddlNoPacket').val()) * parseInt($('#lblNoCode').val()));
        }

        function isNumberKey(sender, evt) {
            var txt = sender.value;
            var dotcontainer = txt.split('.');
            var charCode = (evt.which) ? evt.which : event.keyCode;
            if (!(dotcontainer.length == 1 && charCode == 46) && charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }
        function AddPrintLables(remaining) {
            debugger;
            $.confirm({
                title: 'Confirm!',
                content: 'Are you sure to add print label package !',
                buttons: {
                    confirm: function () {
                        $.confirm({
                            title: 'Add label Package',
                            content: 'url:addlabelpackage.html',
                            onContentReady: function () {
                                this.$content.find('label#lblAvailableCodes').text(remaining);
                                //var avilablecount = avilablelabels();
                                //this.$content.find('label#lblAvailableCodes').text(avilablecount);
                            },
                            boxWidth: '600px',
                            useBootstrap: false,
                            buttons: {
                                sayMyName: {
                                    text: 'Confirm',
                                    btnClass: 'btn-warning',
                                    action: function () {
                                        var input = this.$content.find('input#lblAvailableCodes').val();
                                        var input1 = this.$content.find('input#ddlNoPacket').val();
                                        var input2 = this.$content.find('input#lblNoCode').val();
                                        var input3 = this.$content.find('input#lblCodes').val();
                                        var errorText = this.$content.find('.text-danger');
                                        if (input1 == '') {
                                            errorText.html('<div class="text-danger help-block">Please don\'t keep the No of Packet field empty OR Integer only<div>').slideDown(200);
                                            return false;
                                        } if (input2 == '') {
                                            errorText.html('<div class="text-danger help-block">Please don\'t keep theCode Per Packet field empty OR Integer only<div>').slideDown(200);
                                            return false;
                                        } else if (input <= parseInt(input3)) {
                                            errorText.html('<div class="text-danger help-block">Please enter print label less than Available Codes<div>').slideDown(200);
                                            return false;
                                        }
                                        else {
                                            debugger;
                                            $.ajax({
                                                type: "POST",
                                                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/addlabelpacket",
                                                data: "{'numcode':'" + input2 + "', 'numpackage':'" + input1 + "'}",
                                                contentType: "application/json; charset=utf-8",
                                                dataType: "json",
                                                success: function (data) {
                                                    var upHTML = data.d;
                                                    if (upHTML != "") {
                                                        $.alert(upHTML);
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
        function filldata() {
            debugger;
            var status = $('#ddlStatus').val();
            var noofcode = $('#ddlNoofCodes').val();
            var fromdate = $("#txtDateFrom").val();
            var todate = $("#txtDateto").val();
            var packetcode = $("#txtpackName").val();
            count = 0;
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getdemoprintlabel",
                data: "{'status':'" + status + "','noofcode':'" + noofcode + "','fromdate':'" + fromdate + "','todate':'" + todate + "','code':'" + packetcode + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    debugger;
                    objdispachLabelsRecord = $.parseJSON(data.d);
                    var trdlrHTML = '';
                    $('#lblcountLicence').text(objdispachLabelsRecord.length);
                    if (objdispachLabelsRecord.length > 0) {
                        $('#GrdCodePrint > tbody').html("");
                        for (var i in objdispachLabelsRecord) {
                            var dates = (objdispachLabelsRecord[count].DownFl).split('*');
                            trdlrHTML += '<tr>' +
                               '<td>' + formatJsonDate(objdispachLabelsRecord[count].Print_Date) + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].Use_Type + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].PrintBunchofCode + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].CodeStatus + ' </td>' +
                             '<td><a href=Excel/' + dates[1] + '/Demo/' + objdispachLabelsRecord[count].Use_Type + '.xls>Download Excel File</a></td>' +
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
                <img src="../images/demo.png" />Print Labels
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
                        <input type="text" id="txtpackName" placeholder="Packet secret code" class="input-sm" /></td>
                    <td align="justify" colspan="2">
                        <div class="hero-unit">
                            <div class="input-daterange" id="datepicker">
                                <input type="text" id="txtDateFrom" class="input-sm" name="start" />
                                <span class="add-on" style="vertical-align: top; height: 30px; font-size: 21px; font-weight: bold;">To</span>
                                <input type="text" id="txtDateto" class="input-sm" name="end" />
                            </div>
                        </div>
                    </td>

                    <td align="justify" style="width: 20%;">
                        <select id="ddlStatus" class="reg_txt">
                            <option>--Status--</option>
                            <option>Not Alloted</option>
                            <option>Alloted</option>
                            <option>Used</option>
                        </select>
                    </td>
                    <td align="justify" style="width: 20%;">
                        <select id="ddlNoofCodes" class="reg_txt">
                        </select>
                    </td>
                    <td align="justify">
                        <div class="merg_btn">
                            <img src="../Content/images/search_rec.png" onclick="return filldata()" />
                            <img src="../Content/images/reset.png" onclick="return resetdata()" />
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
                            <th>Print Date</th>
                            <th>Packet Secret Code</th>
                            <th>Codes in packet</th>
                            <th>Status</th>
                            <th>
                                <%--<input type="checkbox" id="chkselecth" name="chkselecth" title="Select All" onchange="checkAll(this.form,this.checked)" />--%>
                               Download Excel File
                            </th>
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

