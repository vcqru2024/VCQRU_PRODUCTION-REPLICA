<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="FrmCraeteLabel.aspx.cs" Inherits="Admin_FrmCraeteLabel" %>

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


        /**THE SAME CSS IS USED IN ALL 3 DEMOS**/
        /**gallery margins**/
        ul.gallery {
            margin-left: 3vw;
            margin-right: 3vw;
        }

        .zoom {
            -webkit-transition: all 0.35s ease-in-out;
            -moz-transition: all 0.35s ease-in-out;
            transition: all 0.35s ease-in-out;
            cursor: -webkit-zoom-in;
            cursor: -moz-zoom-in;
            cursor: zoom-in;
        }

            .zoom:hover,
            .zoom:active,
            .zoom:focus {
                /**adjust scale to desired size, 
add browser prefixes**/
                -ms-transform: scale(2.5);
                -moz-transform: scale(2.5);
                -webkit-transform: scale(2.5);
                -o-transform: scale(2.5);
                transform: scale(2.5);
                position: relative;
                z-index: 100;
            }

        .thumbnail {
            margin-bottom: 0px !important;
        }

        /**To keep upscaled images visible on mobile, 
increase left & right margins a bit**/
        @media only screen and (max-width: 768px) {
            ul.gallery {
                margin-left: 15vw;
                margin-right: 15vw;
            }

            /**TIP: Easy escape for touch screens,
give gallery's parent container a cursor: pointer.**/
            .DivName {
                cursor: pointer;
            }

            .thumbnail {
                margin-bottom: 0px !important;
            }
        }
    </style>
    <script type="text/javascript">
        var count = 0;
        $(document).ready(function () {
            var username = '<%=Session["User_Type"]%>';
            if (username == "") {
                window.location.href = "<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/Login.aspx?Page=CodeUsesOfCompany.aspx&usertype=Admin";
            }
            else {
                if (username == "Company")
                    window.location.href = "<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/Login.aspx";
            }
            $('.input-daterange').datepicker({
                todayBtn: "linked"

            });
            filldemoalocation();
            $("#CloseDiv").click(function () {
                $('#divproductwise').hide();
            });
            $("#lblCloseDiv").click(function () {
                $('#lbldivproductwise').hide();
            });
            $("#editCloseDiv").click(function () {
                $('#editdivproductwise').hide();
            });
            $('#FileUpload1').uploadify({
                'swf': 'uploadify.swf',
                'uploader': 'Upload.ashx',
                'fileTypeDesc': 'Image Files',
                'fileTypeExts': '*.gif; .jpg; .png',
                'buttonImage': 'Browse.png',
                'auto': true,
                'multi': false,
                'height': 30,
                'width': 120,
                'onSelect': function (event, queueID, fileObj, response, data) {
                    debugger;
                },
                'onUploadComplete': function (file, data, response) {
                    debugger;
                    var new_file = file.name
                    $('#lblimage').text(new_file);
                    //$('#lblupimg').attr('src', '../Data/Sound/Label/' + new_file).width(150).height(50);
                }
            });
        });

        function avilablelabels() {
            $('#divproductwise').show();
        }
        function Viewlabelprice(id, name, size) {
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/labelpricedetails",
                data: "{'lblid':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var upHTML = $.parseJSON(data.d);
                    if (upHTML.length > 0) {
                        $('#lbldate').text(formatJsonDate(upHTML[0].Entry_Date));
                        $('#lblprice').text(upHTML[0].Label_Prise);
                        $('#lblname').text(name);
                        $('#lblsizes').text(size);
                        $('#lbldivproductwise').show();
                    }
                }
            });

        }
        function checklabel() {
            debugger;
            var lblname = $('#txtlabelname').val();
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/checkNewLabel",
                data: "{'res':'" + lblname + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var upHTML = data.d;
                    if (upHTML != "") {
                        $.alert(upHTML);
                        $('#txtlabelname').val('');
                    }
                }
            });
        }
        function ActiveLabel(id, name, size) {
            $.confirm({
                title: 'Confirm!',
                content: 'Are you sure to De-Activate <span style="color:blue;">' + name + '</span>( ' + size + ' ) Label ?',
                buttons: {
                    confirm: function () {
                        $.ajax({
                            type: "POST",
                            url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/actionlabel",
                            data: "{'lblid':'" + id + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                var upHTML = data.d;
                                filldemoalocation();
                                $.alert("De-Activated Sucessfully !");
                            }
                        });
                    },
                    cancel: function () {
                        $.alert('Canceled!');
                    },
                }
            });
            //$.alert("Active Label" + id);
        }

        function DeActiveLabel(id, name, size) {
            $.confirm({
                title: 'Confirm!',
                content: 'Are you sure to Active this Label?',
                buttons: {
                    confirm: function () {
                        $.ajax({
                            type: "POST",
                            url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/actionlabel",
                            data: "{'lblid':'" + id + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                var upHTML = data.d;
                                filldemoalocation();
                                $.alert("Activated Sucessfully !");
                            }
                        });
                    },
                    cancel: function () {
                        $.alert('Canceled!');
                    },
                }
            });
        }
        function EditLabel(id) {
            debugger;
            $.confirm({
                title: 'Confirm!',
                content: 'Are you sure to Edit this Label?',
                buttons: {
                    confirm: function () {
                        debugger;
                        $.ajax({
                            type: "POST",
                            url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/editlabel",
                            data: "{'lblid':'" + id + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                debugger;
                                var upHTML = $.parseJSON(data.d);
                                if (upHTML.length > 0) {
                                    var size = (upHTML[0].Label_Size).split('X');
                                    $('#edittxtlabelcode').text(id);
                                    $('#edittxtlabelname').text(upHTML[0].Label_Name);
                                    $('#edittxtlabelwdth').text(size[0]);
                                    $('#edittxtlabelhgt').text(size[1]);
                                    $('#edittxtlabelprice').val(upHTML[0].Label_Prise);
                                    $('#editlblimg').attr('src', '../Data/Sound/Label/' + upHTML[0].Label_Image).width(150).height(50);
                                    $('#editdivproductwise').show();
                                }
                                else {
                                    $.alert("No Record Found !");
                                }
                            }
                        });
                        //$.alert('Interested Request has been canceled successfully !');
                    },
                    cancel: function () {
                        $.alert('Canceled!');
                    },
                }
            });
            //$.alert("Edit Label" + id);
        }
        function filldemoalocation() {
            debugger;
            var lblname = $('#txtlblName').val();
            count = 0;
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getlabels",
                data: "{'label':'" + lblname + "'}",
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
                            var flag = objdispachLabelsRecord[count].Flag;
                            trdlrHTML += '<tr>' +
                                '<td>' + (parseInt(count) + 1) + '</td>' +
                               '<td>' + objdispachLabelsRecord[count].Label_Name + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].Label_Size + '</td>' +
                             '<td>' + objdispachLabelsRecord[count].Label_Prise + '</td>' +
                             '<td  style="text-align: center" class="list-inline gallery"><img class="thumbnail zoom" src="../Data/Sound/Label/' + objdispachLabelsRecord[count].Label_Image + '" height="50" width="150" /></td>' +
                             '<td>' +
                             '<a href="javascript:;" onclick="EditLabel(\'' + objdispachLabelsRecord[count].Label_Code + '\')"><img src="../Content/images/edit.png" title="Price Edit" /></a>';
                            if (flag == "1") {
                                trdlrHTML += '<a href="javascript:;" onclick="ActiveLabel(\'' + objdispachLabelsRecord[count].Label_Code + '\',\'' + objdispachLabelsRecord[count].Label_Name + '\',\'' + objdispachLabelsRecord[count].Label_Size + '\')"><img src="../Content/images/showhide2.png" title="Status of this Label is Activated."/></a>';
                            }
                            else {
                                trdlrHTML += '<a href="javascript:;" onclick="DeActiveLabel(\'' + objdispachLabelsRecord[count].Label_Code + '\',\'' + objdispachLabelsRecord[count].Label_Name + '\',\'' + objdispachLabelsRecord[count].Label_Size + '\')"><img src="../Content/images/showhide1.png"  title="Status of this Label is De-Activated." /></a>';
                            }
                            trdlrHTML += '<a href="javascript:;" onclick="Viewlabelprice(\'' + objdispachLabelsRecord[count].Label_Code + '\',\'' + objdispachLabelsRecord[count].Label_Name + '\',\'' + objdispachLabelsRecord[count].Label_Size + '\')"><img src="../Content/images/lence.png" title="View Label Price Details" /></a>' +
                       '</td>' +
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
        function getreturn(compid) {
            var wisecount = 0;
            debugger;
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getcodeuseddetails",
                data: "{'comp':'" + compid + "'}",
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
                             '<td>' + objdispachLabelsRecord[wisecount].Pro_Name + '</td>' +
                             '<td>' + objdispachLabelsRecord[wisecount].AllotedCodes + '</td>' +
                             '<td>' + objdispachLabelsRecord[wisecount].PrintCodes + '</td>' +
                            '<td>' + objdispachLabelsRecord[wisecount].FilledCode + '</td>' +
                            '<td>' + objdispachLabelsRecord[wisecount].BalanceForPrinting + '</td>' +
                            '<td>' + objdispachLabelsRecord[wisecount].BalanceForFilling + '</td>' +
                            '<td>' + objdispachLabelsRecord[wisecount].checkCode + '</td>' +
                            '<td>' + objdispachLabelsRecord[wisecount].Uncheck + '</td>' +
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
            $("#txtlblName").val('');
            filldemoalocation();
            //debugger;
            //$("#txtCompName").val('');
            //$('#GrdCodePrint > tbody').html('');
            //var Comp = "";
            //count = 0;
            //$.ajax({
            //    type: "POST",
            //    url: "/Admin/adminhandeler.asmx/getdailyallocation",
            //    data: "{'comp':'" + Comp + "'}",
            //    contentType: "application/json; charset=utf-8",
            //    dataType: "json",
            //    success: function (data) {
            //        $('#lblcountLicence').text("0");
            //        var objdispachLabelsRecord = $.parseJSON(data.d);
            //        var trdlrHTML = '';
            //        $('#lblcountLicence').text(objdispachLabelsRecord.length);
            //        if (objdispachLabelsRecord.length > 0) {
            //            $('#GrdCodePrint > tbody').html("");
            //            for (var i in objdispachLabelsRecord) {
            //                trdlrHTML += '<tr>' +
            //                   '<td>' + objdispachLabelsRecord[count].Allot_Date + '</td>' +
            //                 '<td>' + objdispachLabelsRecord[count].Comp_Name + '</td>' +
            //                 '<td>' + objdispachLabelsRecord[count].codeAllocation + '</td>' +
            //                 '<td>' + objdispachLabelsRecord[count].Allot_Date + '</td>' +
            //                 '<td>' + objdispachLabelsRecord[count].Comp_Name + '</td>' +
            //                 '<td>' + objdispachLabelsRecord[count].codeAllocation + '</td>' +
            //                 '<td>' + objdispachLabelsRecord[count].Allot_Date + '</td>' +
            //                 '<td>' + objdispachLabelsRecord[count].Comp_Name + '</td>' +
            //                 '<td>' + objdispachLabelsRecord[count].codeAllocation + '</td>' +
            //                 '<td>' + objdispachLabelsRecord[count].codeAllocation + '</td>' +
            //                 '<td><span style="cursor:pointer;color:blue;" onclick="return getreturn("' + objdispachLabelsRecord[count].Comp_ID + '")">View Details</span> </td>' +
            //                '</tr>';
            //                count++;
            //            }
            //        }
            //        else {
            //            trdlrHTML += "<td colspan='8' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td>";
            //        }
            //        $('#GrdCodePrint > tbody').html(trdlrHTML);

            //    }
            //});
        }


        function updateprice() {
            debugger;
            $.confirm({
                title: 'Confirm!',
                content: 'Are you sure to Upadte the price(' + $('#edittxtlabelprice').val() + ') of ' + $('#edittxtlabelname').text() + '?',
                buttons: {
                    confirm: function () {
                        debugger;
                        if ($('#edittxtlabelprice').val() != "") {
                            $.ajax({
                                type: "POST",
                                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/Updatelabelprice",
                                data: "{'lblid':'" + $('#edittxtlabelcode').text() + "','price':'" + $('#edittxtlabelprice').val() + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) {
                                    debugger;
                                    var upHTML = data.d;
                                    if (upHTML == "Updated") {
                                        $.alert("Price Updated Sucessfully !");
                                        $('#editdivproductwise').hide();
                                        filldemoalocation();
                                    }
                                    else {
                                        $.alert("Price Not Updated !");
                                    }
                                }
                            });
                        }
                        else {
                            $.alert("price field cant be empty !");
                        }
                        //$.alert('Interested Request has been canceled successfully !');
                    },
                    cancel: function () {
                        $.alert('Canceled!');
                    },
                }
            });
        }



        function SaveLabel() {
            

            if ($('#txtlabelname').val() == '') {
                $.alert("Please Enter Label name ");
                return false;
            }
            if ($('#txtlabelwdth').val() == '') {
                $.alert("Please Enter width ");
                return false;
            }
            if ($('#txtlabelhgt').val() == '') {
                $.alert("Please Enter height");
                return false;
            }
            if ($('#txtlabelprice').val() == '') {
                $.alert("Please Enter price");
                return false;
            }
            if ($('#lblimage').text() == '') {
                $.alert("Please Select label image");
                return false;
            }
            else {
                $.confirm({
                    title: 'Confirm!',
                    content: 'Are you sure to Create Lable(' + $('#txtlabelname').val() + ') ?',
                    buttons: {
                        confirm: function () {
                            debugger;
                            $.ajax({
                                type: "POST",
                                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/savelabel",
                                data: "{'price':'" + $('#txtlabelprice').val() + "','name':'" + $('#txtlabelname').val() + "','width':'" + $('#txtlabelwdth').val() + "','height':'" + $('#txtlabelhgt').val() + "','img':'" + $('#lblimage').text() + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) {
                                    debugger;
                                    var upHTML = data.d;
                                    if (upHTML !== "") {
                                        $.alert("Label created sucesfully <b>" + $('#txtlabelname').val() + "</b> (" + upHTML + ")");
                                        filldemoalocation();
                                    }
                                    else {
                                        $.alert("Label not created !");
                                    }
                                }
                            });
                            //$.alert('Interested Request has been canceled successfully !');
                        },
                        cancel: function () {
                            $.alert('Canceled!');
                        },
                    }
                });
            }
        }


    </script>
    <link href="assets/css/uploadify.css" rel="stylesheet" />
    <script src="assets/js/jquery.uploadify.min.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="lbldivproductwise" align="center" style="background-color: #eee; position: fixed; left: 0; height: 100%; width: 100%; top: 0px; display: none; z-index: 111;"
        class="NewmodalBackground">
        <div style="margin: 50px 375px;" align="center">
            <div class="col-xs-12" style="border: 1px solid #ddd;">
                <div class="row">
                    <div>
                        <div class="table-header">
                            <div style="float: left;">
                                <label id="lblname"></label>
                                (<label id="lblsizes"></label>) Price Details 
                            </div>
                            <%--<div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 30px; width: auto; line-height: 22px;">
                                <label onclick="return close();" style="color: #fff;">Close</label>
                            </div>--%>
                            <div style="float: right">
                                <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 50px; width: auto; line-height: 22px;">
                                    <span id="lblCloseDiv" style="color: #fff; cursor: pointer;">Close</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <table class="table">
                            <tr>
                                <th>Price Change Date</th>
                                <th>Price (In Rs.)</th>
                            </tr>
                            <tr>
                                <td>
                                    <label id="lbldate"></label>
                                </td>
                                <td>
                                    <label id="lblprice"></label>
                                </td>
                            </tr>
                        </table>
                    </div>
                    <!-- /.span -->
                </div>
            </div>
        </div>
    </div>
    <div id="divproductwise" align="center" style="background-color: #eee; position: fixed; left: 0; height: 100%; width: 100%; top: 0px; display: none; z-index: 111;"
        class="NewmodalBackground">
        <div style="margin: 50px 375px;" align="center">
            <div class="col-xs-12" style="border: 1px solid #ddd;">
                <div class="row">
                    <div>
                        <div class="table-header">
                            <div style="float: left;">
                                <img src="../Content/images/regis_pro.png" />Create New Label
                            </div>
                            <%--<div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 30px; width: auto; line-height: 22px;">
                                <label onclick="return close();" style="color: #fff;">Close</label>
                            </div>--%>
                            <div style="float: right">
                                <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 50px; width: auto; line-height: 22px;">
                                    <span id="CloseDiv" style="color: #fff; cursor: pointer;">Close</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <table class="table">
                            <tr>
                                <td>Label Name</td>
                                <td>:</td>
                                <td>
                                    <input id="txtlabelname" style="width: 100%" onchange="checklabel();" type="text" /></td>
                            </tr>
                            <tr>
                                <td>Label Size</td>
                                <td>:</td>
                                <td>
                                    <input id="txtlabelwdth" style="width: 48%" type="text" />
                                    X
                                    <input id="txtlabelhgt" style="width: 48%" type="text" /></td>
                            </tr>
                            <tr>
                                <td>Label Price</td>
                                <td>:</td>
                                <td>
                                    <input id="txtlabelprice" onkeypress="return isNumberKey(this, event);" style="width: 100%" type="text" /></td>
                            </tr>
                            <tr>
                                <td>Label Image</td>
                                <td>:</td>
                                <td>
                                    <%--<asp:FileUpload ID="FileUpload1" runat="server" /></td>--%>
                                    <input type="file" name="FileUpload1" id="FileUpload1" />
                                    <label id="lblimage"></label>
                            </tr>
                            <tr>
                                <td class="list-inline gallery">
                                    <%--<img class="thumbnail zoom" id="lblupimg" />--%>
                                </td>
                                <td></td>
                                <td style="text-align: right">
                                    <%--<asp:Button runat="server" type="button" OnClick="btnsubmit_Click" OnClientClick="return SaveLabel();" class="btn btn-success" Text="Save" />--%>
                                    <input type="button"   onclick="return SaveLabel();" class="btn btn-success" value="Save" /></td>
                            </tr>
                        </table>
                    </div>
                    <!-- /.span -->
                </div>
            </div>
        </div>
    </div>
    <div id="editdivproductwise" align="center" style="background-color: #eee; position: fixed; left: 0; height: 100%; width: 100%; top: 0px; display: none; z-index: 111;"
        class="NewmodalBackground">
        <div style="margin: 50px 375px;" align="center">
            <div class="col-xs-12" style="border: 1px solid #ddd;">
                <div class="row">
                    <div>
                        <div class="table-header">
                            <div style="float: left;">
                                <img src="../Content/images/regis_pro.png" />Edit Label
                            </div>
                            <%--<div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 30px; width: auto; line-height: 22px;">
                                <label onclick="return close();" style="color: #fff;">Close</label>
                            </div>--%>
                            <div style="float: right">
                                <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 50px; width: auto; line-height: 22px;">
                                    <span id="editCloseDiv" style="color: #fff; cursor: pointer;">Close</span>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div>
                        <table class="table">
                            <tr>
                                <td>Label Name</td>
                                <td>:</td>
                                <td>
                                    <label id="edittxtlabelcode" style="width: 100%; display: none"></label>
                                    <label id="edittxtlabelname" style="width: 100%"></label>
                                </td>
                            </tr>
                            <tr>
                                <td>Label Size</td>
                                <td>:</td>
                                <td>
                                    <label id="edittxtlabelwdth" style="width: 46%; text-align: center;"></label>
                                    X
                                    <label id="edittxtlabelhgt" style="width: 46%; text-align: center;"></label>
                                </td>
                            </tr>
                            <tr>
                                <td>Label Price</td>
                                <td>:</td>
                                <td>
                                    <input id="edittxtlabelprice" onkeypress="return isNumberKey(this, event);" style="width: 100%" type="text" /></td>
                            </tr>
                            <tr>
                                <td class="list-inline gallery">
                                    <img class="thumbnail zoom" id="editlblimg" /></td>
                                <td></td>
                                <td></td>
                            </tr>
                            <tr>
                                <td></td>
                                <td></td>
                                <td>
                                    <input type="button" onclick="return updateprice();" class="btn btn-warning" value="Update" /></td>
                            </tr>
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
                <img src="../images/demo.png" />Create Label 
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
            <table width="50%" cellpadding="0" cellspacing="2" class="tab_regis">
                <tr>
                    <td>
                        <input type="text" id="txtlblName" placeholder="Label Name" class="input-sm" /></td>


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
                <table id="GrdCodePrint" class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>S.No.</th>
                            <th>Label Name</th>
                            <th>Size(In mm.)</th>
                            <th>Price (In Rs.)</th>
                            <th>Label Image</th>
                            <th>Action</th>
                        </tr>
                    </thead>
                    <tbody>
                       <%-- <tr>
                            <td>1</td>
                            <td>Virtual Label</td>
                            <td>00 X 00</td>
                            <td>0.05</td>
                            <td style="text-align: center" class="list-inline gallery">
                                <img class="thumbnail zoom" src="../Data/Sound/Label/LBL_1043.jpg" height="50" width="150" /></td>
                            <td><a href="#">
                                <img src="../Content/images/edit.png" /></a><a href="#"><img src="../Content/images/showhide2.png" /></a><a href="#"><img src="../Content/images/showhide1.png" /></a><a href="#"><img src="../Content/images/lence.png" /></a></td>
                        </tr>--%>
                    </tbody>
                </table>
            </div>
            <!-- /.span -->
        </div>
    </div>
    <div class="clearfix" style="height: 180px"></div>

</asp:Content>

