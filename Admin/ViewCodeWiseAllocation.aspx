<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="ViewCodeWiseAllocation.aspx.cs" Inherits="Admin_ViewCodeWiseAllocation" %>

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
                window.location.href = "../Info/Login.aspx?Page=ViewCodeWiseAllocation.aspx&usertype=Admin";
            }
            else {
                if (username == "Company")
                    window.location.href = "../Info/Login.aspx";
            }
            $('.input-daterange').datepicker({
                todayBtn: "linked"

            });
            filldemoalocation();
            $("#CloseDiv").click(function () {
                $('#divproductwise').hide();
            });
        });

        function filldemoalocation() {
            debugger;
            var Comp = $('#txtCompName').val();
            var fromdate = $("#txtDateFrom").val();
            var todate = $("#txtDateto").val();
            count = 0;
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getdailyallocation",
                data: "{'comp':'" + Comp + "','from':'" + fromdate + "','to':'" + todate + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    debugger;
                    $('#lblcountLicence').text("0");
                    var objdispachLabelsRecord = $.parseJSON(data.d);
                    var trdlrHTML = '';
                    $('#lblcountLicence').text(objdispachLabelsRecord.length);
                    if (objdispachLabelsRecord.length > 0) {
                        $('#GrdCodePrint > tbody').html("");
                        for (var i in objdispachLabelsRecord) {
                            trdlrHTML += '<tr>' +
                               '<td>' + objdispachLabelsRecord[count].Allot_Date + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].Comp_Name + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].codeAllocation + '</td>' +
                             '<td><span style="cursor:pointer;color:blue;" onclick="return getreturn(\'' + objdispachLabelsRecord[count].Comp_ID + '\',\'' + objdispachLabelsRecord[count].Allot_Date + '\')">View Details</span> </td>' +
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
        function getreturn(compid, date) {
            var wisecount = 0;
            debugger;
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getproductwisedetails",
                data: "{'comp':'" + compid + "','date':'" + date + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    debugger;
                    var objdispachLabelsRecord = $.parseJSON(data.d);
                    var trdlrHTML = '';
                    if (objdispachLabelsRecord.length > 0) {
                        $('#productGrdCodePrint > tbody').html("");
                        for (var i in objdispachLabelsRecord) {
                            trdlrHTML += '<tr>' +
                               '<td>' + objdispachLabelsRecord[wisecount].Pro_ID + '</td>' +
                             '<td>' + objdispachLabelsRecord[wisecount].Pro_Name + '</td>' +
                             '<td>' + objdispachLabelsRecord[wisecount].AllotedCodes + '</td>'
                            '</tr>';
                            wisecount++;
                        }
                    }
                    else {
                        trdlrHTML += "<td colspan='8' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td>";
                    }
                    $('#productGrdCodePrint > tbody').html(trdlrHTML);

                }
            });
            $('#divproductwise').show();
        }


        function close() {
            debugger;
            
        }
        function resetdata() {
            $("#txtCompName").val('');
            $("#txtDateFrom").datepicker("setDate", new Date());
            $("#txtDateto").datepicker("setDate", new Date());
            $('#GrdCodePrint > tbody').html('');
            var fromdate = $("#txtDateFrom").val();
            var todate = $("#txtDateto").val();
            var Comp = "";
            count = 0;
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getdailyallocation",
                data: "{'comp':'" + Comp + "','from':'" + fromdate + "','to':'" + todate + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#lblcountLicence').text("0");
                    var objdispachLabelsRecord = $.parseJSON(data.d);
                    var trdlrHTML = '';
                    $('#lblcountLicence').text(objdispachLabelsRecord.length);
                    if (objdispachLabelsRecord.length > 0) {
                        $('#GrdCodePrint > tbody').html("");
                        for (var i in objdispachLabelsRecord) {
                            trdlrHTML += '<tr>' +
                               '<td>' + objdispachLabelsRecord[count].Allot_Date + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].Comp_Name + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].codeAllocation + '</td>' +
                             '<td><span style="cursor:pointer;color:blue;" onclick="return getreturn("' + objdispachLabelsRecord[count].Comp_ID + '","' + objdispachLabelsRecord[count].Allot_Date + '")">View Details</span> </td>' +
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
    <div id="divproductwise" align="center" style="position: fixed; left: 0; height: auto; width: 100%; top: 0px; display: none; z-index: 111;"
        class="NewmodalBackground">
        <div style="margin: 300px;" align="center">
            <div class="col-xs-12">
                <div class="row">
                    <div class="col-xs-12">
                        <div class="table-header">
                            <div style="float: left;">
                                <img src="../Content/images/regis_pro.png" />Products Wise Details
                            </div>
                            <%--<div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 30px; width: auto; line-height: 22px;">
                                <label onclick="return close();" style="color: #fff;">Close</label>
                            </div>--%>
                            <div style="float: right">
                                <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 50px; width: auto; line-height: 22px;">
                                    <span id="CloseDiv" style="color:#fff;cursor:pointer;">Close</span>
                                </div>
                            </div>
                        </div>
                        <table id="productGrdCodePrint" class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>Series</th>
                                    <th>Product Name</th>
                                    <th>Alloted Codes</th>
                                </tr>
                            </thead>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                    <!-- /.span -->
                </div>
            </div>
        </div>
    </div>
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
                <img src="../images/demo.png" />Daily Code Allocation 
            </h3>
        </div>
        <%--<div class="col-sm-2">
            <h3 class="lighter smaller">
                <img src="../images/addadv.png" style="width: 25%" onclick="return avilablelabels();" />
            </h3>
        </div>--%>
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
                            <th>Date</th>
                            <th>Company Name</th>
                            <th>Alloted Codes</th>
                            <th>View</th>
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

