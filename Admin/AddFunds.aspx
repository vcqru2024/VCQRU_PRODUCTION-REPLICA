<%@ Page Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="AddFunds.aspx.cs" Inherits="Admin_AddFunds" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script src="../Content/js/toastr.min.js"></script>
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

    <script type="text/javascript">
        $(document).ready(function () {
            var username = '<%= Session["User_Type"] %>';

            //            $("#txtDateFrom").datepicker("setDate", new Date());
            //            $("#txtDateto").datepicker("setDate", new Date());
            $("#txtDateFrom").datepicker();
            $("#txtDateto").datepicker();
            if (username = "") {
                window.location.href = "<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/Login.aspx?Page=CodeLabelPrint.aspx&usertype=Admin";;
            }
            else {
                if (username == "Company")
                    window.location.href = "Index.aspx";
            }
            $('.input-daterange').datepicker({
                todayBtn: "linked"

            });
            getcompany();

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
            var Amount = $("#txtAmount").val();

            var count = 0;
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/AddFunds",
                data: "{'compid':'" + compid + "','Amount':'" + Amount + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    debugger;
                    var response = data.d;
                    if (response == "Success") {

                        toastr.success("Balance Added Successfully");
                        setTimeout(function () {
                            location.reload();
                        },2000);
                        

                    }


                },
                error: function (err) {
                    debugger;
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
                <img src="../images/demo.png" />Add Funds
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


                    <td align="justify" style="width: 20%;">
                        <select id="ddlComp_Id" class="reg_txt">
                        </select>
                    </td>

                    <td align="justify" style="width: 20%; padding-left: 1%;">
                        <input type="text" id="txtAmount" class="reg_txt" style="height: 30px;" />

                    </td>

                    <td align="justify" style="padding-left: 3%;">
                        <div class="merg_btn">
                            <input type="button" name="btnsubmit" style="height: 40px;" value="Add" id="ctl00_ContentPlaceHolder1_btnTransaction" onclick="return filldata()" class="btn btn-primary" />
                        </div>
                    </td>
                </tr>
                <tr>
                    <td colspan="5"></td>
                </tr>
            </table>
        </fieldset>

    </div>

</asp:Content>
