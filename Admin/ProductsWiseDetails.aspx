<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="ProductsWiseDetails.aspx.cs" Inherits="Admin_ProductsWiseDetails" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <link href="assets/css/style.default.css" rel="stylesheet" />
    <script src="js/jquery.dataTables.min.js"></script>
    <script type="text/javascript">
        var count = 0;
        jQuery(document).ready(function () {
            // dynamic table
            
            getcompany();
            Bindcompanyproduct();
        });
        //$(window).load(function () {
        //    jQuery('#dyntable').dataTable({
        //        "sPaginationType": "full_numbers",
        //        "aaSortingFixed": [[0, 'asc']],
        //        "fnDrawCallback": function (oSettings) {
        //            //jQuery.uniform.update();
        //        }
        //    });

        //});

        function resetdata() {
            $('#ddlComp_Id').val('');
            $('#ddlPro_ID').val('');
            $('#ddlChecked').val('');
            $('#dyntable > tbody').html("");
            getcompany();
            Bindcompanyproduct();
            $('#lblcountLicence').text("0");
        }
        function filldemoalocation() {
         
            $('#divprogress').show();
            var lblcompid = $('#ddlComp_Id').val();
            var lblcompproid = $('#ddlPro_ID').val();
            var lblstatusid = $('#ddlChecked').val();
            if (lblcompid == "0") {
                $.alert("Please select Company first");
                $('#divprogress').hide();
                return false;
            }
            if (lblcompproid == "0") {
                $.alert("Please select Product");
                $('#divprogress').hide();
                return false;
            }
            else {
                count = 0;
                $.ajax({
                    type: "POST",
                    url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/FillGridstatusProducts",
                    data: "{'comp':'" + lblcompid + "','comppro':'" + lblcompproid + "','status':'" + lblstatusid + "'}",
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (data) {
                       
                        $('#dyntable').dataTable().fnDestroy();
                        $('#dyntable > tbody').html("");
                        $('#lblcountLicence').text("0");
                        var objdispachLabelsRecord = $.parseJSON(data.d);
                        var trdlrHTML = '';
                        $('#lblcountLicence').text(objdispachLabelsRecord.length);
                        if (objdispachLabelsRecord.length > 0) {
                           

                            for (var i in objdispachLabelsRecord) {
                                var flag = objdispachLabelsRecord[count].Use_Count;
                                trdlrHTML += '<tr>' +
                                    '<td>' + (parseInt(count) + 1) + '</td>' +
                                   '<td>' + objdispachLabelsRecord[count].Pro_ID + '</td>' +
                                 '<td>' + objdispachLabelsRecord[count].Pro_Name + '</td>' +
                                 '<td>' + objdispachLabelsRecord[count].Code1 + '</td>' +
                                 '<td>';
                                if (flag != "0") {
                                    trdlrHTML += '<img src="../Content/images/check_act.png" alt="" title="Code Checked" />';
                                }
                                trdlrHTML += '</td>' +
                                             '</tr>';
                                count++;
                            }
                        }
                        else {
                            trdlrHTML += "<td colspan='8' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td>";
                        }
                        $('#dyntable > tbody').html(trdlrHTML);

                        jQuery('#dyntable').dataTable({
                            "sPaginationType": "full_numbers",
                            "aaSortingFixed": [[0, 'asc']],
                            "fnDrawCallback": function (oSettings) {
                                //jQuery.uniform.update();
                            }
                        });
                        
                    }
                });
            }
            $('#divprogress').hide();
        }

        function getcompany() {
            debugger;
            $("select[id$=ddlPro_ID]").html('<option selected="selected" value="0">Select Product</option>');
            $("select[id$=ddlComp_Id]").html('<option selected="selected" value="0">Select Company</option>');
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getcompany",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    debugger;
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
                        debugger;
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
                <img src="../images/productwisecodedetails.png" />
                Products Wise Code Details 
            </h3>
        </div>
    </div>
    <div class="col-md-10">
        <fieldset class="field_profile" style="margin: 0 auto;">
            <legend>
                <img src="../images/search_icon.png" />
                Search</legend>
            <table width="100%" cellpadding="0" cellspacing="2" class="tab_regis">
                <tr>
                    <td align="justify" style="width: 20%;">
                        <select id="ddlComp_Id" class="reg_txt">
                        </select>
                    </td>
                    <td align="justify" style="width: 20%;">
                        <select id="ddlPro_ID" class="reg_txt">
                        </select>
                    </td>
                    <td align="justify" style="width: 20%;">
                        <select id="ddlChecked" class="reg_txt">
                            <option value="0">--Select Status--</option>
                            <option value="1">Checked</option>
                            <option value="2">Unchecked</option>

                        </select>
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
                    <%--<div style="float: right">
                        <div style="float: left;">Total Alloted Codes :</div>
                        <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 50px; width: auto; line-height: 22px;">
                            <label id="lbltotalcodes" style="color: #fff;">0</label>
                        </div>
                    </div>--%>
                </div>
                <table id="dyntable" class="table table-striped table-bordered table-hover table-responsive">
                    <thead>
                        <tr>
                            <th>S.No.</th>
                            <th>Series</th>
                            <th>Product Name</th>
                            <th>Code1</th>
                            <th>Status</th>
                        </tr>
                    </thead>
                    <%--<tbody>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                        <tr>
                            <td>1</td>
                            <td>AB16-00-000</td>
                            <td>xyz</td>
                            <td>44281</td>
                            <td></td>
                        </tr>
                    </tbody>--%>
                    <tbody></tbody>
                </table>
            </div>

            <!-- /.span -->
        </div>
    </div>
    <div class="clearfix" style="height: 180px"></div>
</asp:Content>

