<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="CodeLabelPrint.aspx.cs" Inherits="Admin_CodeLabelPrint" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {
            var username = '<%= Session["User_Type"] %>';

//            $("#txtDateFrom").datepicker("setDate", new Date());
//            $("#txtDateto").datepicker("setDate", new Date());
            $("#txtDateFrom").datepicker();
            $("#txtDateto").datepicker();
            if (username = "") {
                window.location.href = "<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/Login.aspx?Page=CodeLabelPrint.aspx&usertype=Admin"; ;
            }
            else {
                if (username == "Company")
                    window.location.href = "Index.aspx";
            }
            $('.input-daterange').datepicker({
                todayBtn: "linked"

            });
            getcompany();
            Bindcompanyproduct();
        });

        function getcompany() {
           
            $("select[id$=ddlPro_ID]").html('<option selected="selected" value="0">Select Product</option>');
            $("select[id$=ddlComp_Id]").html('<option selected="selected" value="0">Select Company</option>');
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getcompany",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                  
                    var objdata = $.parseJSON(data.d);
                    $('.ddlComp_Id').find('option').remove();
                    var _options = "";
                    if ((objdata != undefined) && (objdata.length != 0)) {
                        _options = '<option selected="selected" value="0">Select Company</option>';
                        for (var i = 0; i < objdata.length; i++)
                            _options += "<option value='" + objdata[i].Comp_ID + "' onclick>" + objdata[i].Comp_Name + "</option>";
                        $("select[id$=ddlComp_Id]").html(_options);
                    }
                }
            });

        }

    </script>
    <link href="assets/css/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="js/bootstrap-datepicker.js" type="text/javascript"></script>
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
        function filldata() {
            var compid = $('#ddlComp_Id').val();
            var proid = $('#ddlPro_ID').val();
            var fromdate = $("#txtDateFrom").val();
            var todate = $("#txtDateto").val();
            var count = 0;
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getfilterdata",
                data: "{'compid':'" + compid + "','proid':'" + proid + "','fromdate':'" + fromdate + "','todate':'" + todate + "'}",
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
                               '<td>' + formatJsonDate(objdispachLabelsRecord[count].print_date) + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].Comp_Name + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].pro_id + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].SerFr + ' </td>' +
                             '<td>' + objdispachLabelsRecord[count].SerTo + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].Pro_Name + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].Codes + '</td>' +
                             '<td><input id="chkselect" name="chkselect" type="checkbox" value=' + objdispachLabelsRecord[count].DownFl + '  title="Select" /></td>' +
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
        function Downloaddata() {
           
            var chkvalues = $('#chkselect').val();
            //$.alert(chkvalues);
            $.confirm({
                title: 'Confirm!',
                content: 'Are you sure to Download this?',
                buttons: {
                    confirm: function () {
                        $.ajax({
                            type: "POST",
                            url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/downloadcodelabelprint",
                            data: "{'chkselect':'" + chkvalues + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                               
                                var upHTML = data.d;
                                toastr.success(upHTML);
                            }
                        });
                    },
                    cancel: function () {
                        $.alert('Canceled!');
                    },
                }
            });
        }

        function resetdata() {
//            $("#txtDateFrom").datepicker("setDate", new Date());
//            $("#txtDateto").datepicker("setDate", new Date());
              $("#txtDateFrom").datepicker();
            $("#txtDateto").datepicker();
            getcompany();
            $('#GrdCodePrint > tbody').html('');
        }
        function Bindcompanyproduct() {
            debugger;
            $('#ddlComp_Id').on('change', function () {
                var compid = $('#ddlComp_Id').val();
                $('.ddlPro_ID').find('option').remove();
                $("select[id$=ddlPro_ID]").html('<option selected="selected" value="0">Select Product</option>');
                var objdata1 = "";
                $.ajax({
                    type: "POST",
                    url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getcompanyproducts",
                    data: "{'compid':'" + compid + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                        
                        var objdata = $.parseJSON(data.d);
                        $('.ddlPro_ID').find('option').remove();
                        var _options = "";
                        if ((objdata != undefined) && (objdata.length != 0)) {
                            _options = '<option selected="selected" value="0">Select Product</option>';
                            for (var i = 0; i < objdata.length; i++)
                                _options += "<option value='" + objdata[i].Pro_ID + "' onclick>" + objdata[i].Pro_Name + "</option>";
                            $("select[id$=ddlPro_ID]").html(_options);
                        }
                    }
                });

            })
        }
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
    </div>
    <div class="col-md-10">
        <fieldset class="field_profile" style="margin: 0 auto;">
            <legend>
                <img src="../images/search_icon.png" />
                Search</legend>
            <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                <tr>
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
                        <select id="ddlComp_Id" class="reg_txt">
                        </select>
                    </td>
                    <td align="justify" style="width: 20%;">
                        <select id="ddlPro_ID" class="reg_txt">
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
                    <div style="float: right">
                        <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 7px 5px 0px; text-align: center; min-width: 50px; width: auto; line-height: 22px;">
                            <%--<img src="../Content/images/download.png" style="cursor: pointer" onclick="return Downloaddata();" />--%>
                             <asp:ImageButton ID="BtnDownloadLicence" runat="server" ImageUrl="~/Content/images/download.png"
                                    ToolTip="Download Excel File" OnClick="BtnDownloadLicence_Click" />
                        </div>
                    </div>
                </div>
                <table id="GrdCodePrint" class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>Print Date</th>
                            <th>Company Name</th>
                            <th>Series</th>
                            <th>From</th>
                            <th>To</th>
                            <th>Product Name</th>
                            <th>Printed Codes</th>
                            <th>
                                <input type="checkbox" id="chkselecth" name="chkselecth" title="Select All" onchange="checkAll(this.form,this.checked)" /></th>
                        </tr>
                    </thead>
                    <tbody>
                    </tbody>
                </table>
            </div>
            <!-- /.span -->
        </div>
    </div>
</asp:Content>

