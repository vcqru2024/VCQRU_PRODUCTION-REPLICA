<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="ProFileAuthentiCation.aspx.cs" Inherits="Admin_ProFileAuthentiCation"   %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        .table.table-striped.table-bordered.table-hover {
            background-color: #fff;
        }
    </style>
   <%--  <script type="text/javascript" language="javascript">
        function ValidateEmail(email) {
            if (email != "") {
                var reEmail = /^(?:[\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~]+\.)*[\w\!\#\$\%\&\'\*\+\-\/\=\?\^\`\{\|\}\~]+@(?:(?:(?:[a-zA-Z0-9](?:[a-zA-Z0-9\-](?!\.)){0,61}[a-zA-Z0-9]?\.)+[a-zA-Z0-9](?:[a-zA-Z0-9\-](?!$)){0,61}[a-zA-Z0-9]?)|(?:\[(?:(?:[01]?\d{1,2}|2[0-4]\d|25[0-5])\.){3}(?:[01]?\d{1,2}|2[0-4]\d|25[0-5])\]))$/;
                if (!email.match(reEmail)) {
                    document.getElementById('<%=MylblMsg.ClientID %>').innerHTML = "Email Id is Not Well Format!";
                    document.getElementById('<%=BtnSendMail.ClientID %>').disabled = true;
                    document.getElementById("<%=BtnSendMail.ClientID %>").className = "button_all_Sec";
                    return false;
                }
                else {
                    document.getElementById("<%=MylblMsg.ClientID %>").innerHTML = "";
                    document.getElementById("<%=BtnSendMail.ClientID %>").disabled = false;
                    document.getElementById("<%=BtnSendMail.ClientID %>").className = "button_all";
                    return true;
                }
            }
            else {
                document.getElementById("<%=MylblMsg.ClientID %>").innerHTML = "";
                document.getElementById("<%=BtnSendMail.ClientID %>").disabled = false;
                document.getElementById("<%=BtnSendMail.ClientID %>").className = "button_all";
                return true;
            }
        }
    </script>--%>
    <script type="text/javascript">
        var result = "";
        
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
            $("#lblCloseDivPro").click(function () {
                $('#lbldivproductwise').hide();
            });
            $("#imgBtnCloseVerifyDoc").click(function () {
                $('#lbldivVerifyDoc').hide();
            });
            $("#imgBtnClose").click(function () {
                $('#lbldivproductSendMail').hide();
                
            });

            $("#lblAmcCloseDiv").click(function () {
                $('#lbldivAmc').hide();
                $('#lbldivproductwise').show();
            });
            Bindcategory();
            filldemoalocation();
        });

        function resetdata() {
            $('#txtCompanyName').val('');
            $('#ddlcat').val(0);
            $('#ddlstatus').val('--Status--');
            $('#ddltypecomp').val(0);
            $("#txtDateFrom").val('');
            $("#txtDateto").val('');
            $('#dyntable > tbody').html("");
            $('#lblcountLicence').text("0");
            //$('#activecomp').checked(true);
            document.getElementById("activecomp").checked = true;
            Bindcategory();
            filldemoalocation();
        }

        function Bindcategory() {
            $("select[id$=ddlcat]").html('<option selected="selected" value="0">--Select Category --</option>');
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getcategory",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                  
                    var objdata = $.parseJSON(data.d);
                    $('.ddlcat').find('option').remove();
                    var _options = "";
                    if ((objdata != undefined) && (objdata.length != 0)) {
                        _options = '<option selected="selected" value="0">--Select Category --</option>';
                        for (var i = 0; i < objdata.length; i++)
                            _options += "<option value='" + objdata[i].Cat_Id + "' onclick>" + objdata[i].Cat_Name + "</option>";
                        $("select[id$=ddlcat]").html(_options);
                    }
                }
            });

        }


        function fileExists(chkurl) {
            $.ajax({
                url: chkurl,
                type: 'HEAD',
                success: function () {
                    result = "Y";
                },
                error: function () {
                    result = "N";
                }
            });

        }
        function getcompanyDocs() {

        }
        function getallcompproduct(compid,strtype) {
            
            var newcountpro = 0;
        
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getcomppro",
                data: "{'compid':'" + compid + "','strType':'" + strtype + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    if (strtype == "product") {
                        $('#lblcountproducts').text("0");
                        var objdispplayproduct = $.parseJSON(data.d);
                        var trdlrHTML = '';
                        $('#lblcountproducts').text(objdispplayproduct.length);
                        if (objdispplayproduct.length > 0) {
                            $('#Grdcomppro1 > tbody').html("");
                            count = 0;
                            for (var i in objdispplayproduct) {
                                trdlrHTML += '<tr>' +
                                    '<td>' + (parseInt(newcountpro) + 1) + '</td>' +
                                   '<td>' + objdispplayproduct[newcountpro].Pro_Name + '</td>' +
                                 '<td>' + objdispplayproduct[newcountpro].Label_Name + '</td>' +
                                 '<td>' + objdispplayproduct[newcountpro].Rate_Per_Label + '</td>' +
                                 '<td>' + objdispplayproduct[newcountpro].Pro_Desc + '</td>' +
                                 '<td><audio style="width:150px" controls="controls"><source src="' + objdispplayproduct[newcountpro].SoundPath + '" type="audio/m3" /></audio></td>';
                                trdlrHTML += '<td><a href="javascript:;"  onclick="getAMCdata(\'' + objdispplayproduct[newcountpro].Pro_ID + '\',\'' + objdispplayproduct[newcountpro].Pro_Name + '\'); return false;"><img src="../Content/images/AmcRenewal.png" style="width: 15px; margin-left: 10px" title="View/Renewal your Amc"/></a>' +
                                             '<a href="' + objdispplayproduct[newcountpro].DocPath + '" target="_blank"><img src="../Content/images/search.png" style="width: 15px; margin-left: 10px" title="View products legal document"/></a></td>';
                                trdlrHTML += '</td>';
                                trdlrHTML += '</tr>';
                                newcountpro++;
                            }
                        }
                        else {
                            trdlrHTML += "<tr><td colspan='9' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td></tr>";
                        }
                        $('#Grdcomppro1 > tbody').html(trdlrHTML);
                        $('#lbldivproductwise').show();
                    }
                    else if (strtype == "doc")
                    {
                    //    $('#lblcountproducts').text("0");
                        var objdispplayproduct = $.parseJSON(data.d);
                        var trdlrHTML = '';
                      //  $('#lblcountproducts').text(objdispplayproduct.length);
                        if (objdispplayproduct.length > 0) {
                            $('#GrdcompproVerifyDoc > tbody').html("");
                            count = 0;
                            for (var i in objdispplayproduct) {
                                var txtCommts = objdispplayproduct[newcountpro].Remarks;
                                trdlrHTML += '<tr>' +
                                    '<td>' + (parseInt(newcountpro) + 1) + '</td>' +
                                   '<td>' + objdispplayproduct[newcountpro].DocName + '</td>'+
                                '<td><input type="text" id="txtComments' + (parseInt(newcountpro) + 1) + '" value="' + txtCommts + '" /></td>';

                                //'<td>' + objdispplayproduct[newcountpro].DocDet + '</td>'
                                if (objdispplayproduct[newcountpro].Download == "Download")
                                {
                                    trdlrHTML += '<td><a  href=' + objdispplayproduct[newcountpro].DocDet + '  target="_blank" >Download</a></td>';
                                }
                                else if (objdispplayproduct[newcountpro].Download == "sound")
                                {
                                    //<audio style="width:150px" controls="controls"><source src="' + objdispplayproduct[newcountpro].SoundPath + '" type="audio/wav" /></audio>
                                    trdlrHTML += '<td><audio style="width:80px" controls="controls"><source src="' + objdispplayproduct[newcountpro].DocDet + '" type="audio/mp3" /></audio></td>';
                                }
                                else {
                                    trdlrHTML += '<td>' + objdispplayproduct[newcountpro].DocDet + '</td>';
                                }
                                //<img  src="' + objdispplayproduct[newcountpro].StatusImg + '" />
                                trdlrHTML += '<td>' + objdispplayproduct[newcountpro].StatusName + '</td> <td><input type="checkbox" name="chkStatus" id="chk' + (parseInt(newcountpro) + 1) + '"  class="childchk" /></td>';
                                trdlrHTML += ' <td style="display:none;">' + objdispplayproduct[newcountpro].Status + '</td><td  class="clsRating" id ="tdFlagID' + (parseInt(newcountpro) + 1) + '" style="display:none;">' + objdispplayproduct[newcountpro].FlagID + '</td>';
                                    
                                //             '<a href="' + objdispplayproduct[newcountpro].DocPath + '" target="_blank"><img src="../Content/images/search.png" style="width: 15px; margin-left: 10px" title="View products legal document"/></a></td>' +
                                // '<td><audio style="width:150px" controls="controls"><source src="' + objdispplayproduct[newcountpro].SoundPath + '" type="audio/wav" /></audio></td>';
                                //trdlrHTML += '<td><a href="javascript:;"  onclick="getAMCdata(\'' + objdispplayproduct[newcountpro].Pro_ID + '\',\'' + objdispplayproduct[newcountpro].Pro_Name + '\'); return false;"><img src="../Content/images/AmcRenewal.png" style="width: 15px; margin-left: 10px" title="View/Renewal your Amc"/></a>' +
                                //             '<a href="' + objdispplayproduct[newcountpro].DocPath + '" target="_blank"><img src="../Content/images/search.png" style="width: 15px; margin-left: 10px" title="View products legal document"/></a></td>';
                               // trdlrHTML += '</td>';
                                trdlrHTML += '</tr>';
                               
                                newcountpro++;
                            }
                            trdlrHTML += '<tr style="text-align:right;font-weight:bold;">' +
                                  '<td colspan="8"><a tooltip="Please select the above doc to verify."  href="javascript:;"   onclick="UpdateDocStatus(\'' + compid + '\',\'Verify\'); return false;" >Verify</a> &nbsp; &nbsp;' +
                               '<a  href="javascript:;" tooltip="Please select the above doc to reject."   onclick="UpdateDocStatus(\'' + compid + '\',\'Reject\'); return false;" >Reject</a>'+
                               '   <div align="left" id="divLoaderdoc" style="display:none;"><img alt="" src="../Content/images/ajax-loader.gif" /><br /><span style="color: White;">Please Wait.....<br /></span></div></td></tr>';

                            trdlrHTML += '<tr><td> </td></tr>';
                        }
                        else {
                            trdlrHTML += "<tr><td colspan='9' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td></tr>";
                        }
                       
                        $('#GrdcompproVerifyDoc > tbody').html(trdlrHTML);
                        $('#lbldivVerifyDoc').show();
                    }
                }
            });
          
        }
        function checkAll(ctrl)
        {
            //alert(ctrl.id);
            //var dd = $('#' + ctrl.id).prop('checked', this.checked);
            //alert(dd);
            if ($('#' + ctrl.id).is(":checked") == true)
            {
                $('.childchk').prop('checked', true);
            }
            else if ($('#' + ctrl.id).is(":checked") == false) {
                $('.childchk').prop('checked', false);
            }
        }
        function UpdateDocStatus(compid, strtype) {
           
            var data = new Array();
            var dataChecked = new Array();
            var listName1 = new Array();
            var listComments1 = new Array();
            //$('#GrdcompproVerifyDoc td').click(function (e) {
            //    var p = $(this).parent().find('input:checkbox').attr('checked', 'checked');
            //    alert(p);
            //});
            var cnt = 0;
            $("#GrdcompproVerifyDoc tr").each(function() {
                
                if ($(this).find('.childchk').is(":checked") == true) {
                    data[cnt] = $(this).find('td:last').text();
                    listName1[cnt] = $(this).find('td:eq(1)').text();                    
                  //  listComments1[cnt] = $(this).find('td:eq(2)').find('input').val();
                    listComments1[cnt] = $(this).find("td:eq(2) input[type='text']").val();
                    //alert(listComments1[cnt]);
                    cnt = cnt + 1;
                   
                }
                //$(this).children('td').each(function (ii, vv) {
                //    data[i] = $(this).text();
                //});,'compid':'" + compid + "','strtype':'" + strtype + "'
            })
            if (data.length == 0)
            {
                $.alert("Please select document.");
                return false;
            }
            $('#divLoaderdoc').show();
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getCompDocVerify",
                data: JSON.stringify({ list: data, listName: listName1, listComments: listComments1, 'compid': compid, 'strtype': strtype }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    $('#divLoaderdoc').hide();
                    //$('#lbldivVerifyDoc').hide();
                    $.alert('Updated Successfully');
                    filldemoalocation();
                    //$('#lblAmccountproducts').text(proname);
                    //var alldata = data.d;
                    //var amcdata = alldata.split('#');
                    //var objdispplayproductamc = $.parseJSON(amcdata[0]);                   
                }
            });
        }
        function getAMCdata(proid, proname) {
          
            var planid = "";
            var newcountawc = 0;
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getproductamc",
                data: "{'proid':'" + proid + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    
                    $('#lblAmccountproducts').text(proname);
                    var alldata = data.d;
                    var amcdata = alldata.split('#');
                    var objdispplayproductamc = $.parseJSON(amcdata[0]);
                    if (amcdata[1] != "") {
                        var objdispplayproductamcselect = $.parseJSON(amcdata[1]);
                        if (objdispplayproductamcselect.length > 0) {
                            planid = objdispplayproductamcselect[0].Plan_ID;
                        }
                    }
                    var trdlrHTML = '';
                    if (objdispplayproductamc.length > 0) {
                        $('#GrdAmccomppro > tbody').html("");
                        newcountawc = 0;
                        for (var i in objdispplayproductamc) {
                            if (planid == objdispplayproductamc[newcountawc].Plan_ID) {
                                trdlrHTML += '<tr readonly="readonly">' +
                                             '<td>' + (parseInt(newcountawc) + 1) + '</td>' +
                                             '<td><input type="radio" id="option' + newcountawc + '" disabled="true" name="filter" value="All" checked="checked" /></td>' +
                                             '<td>' + objdispplayproductamc[newcountawc].Plan_Name + '</td>' +
                                             '<td>' + objdispplayproductamc[newcountawc].APlan_Amount + '</td>' +
                                             '</tr>';
                            }
                            else {
                                trdlrHTML += '<tr>' +
                                             '<td>' + (parseInt(newcountawc) + 1) + '</td>' +
                                             '<td><input type="radio" id="option' + newcountawc + '" name="filter" value="All" /></td>' +
                                             '<td>' + objdispplayproductamc[newcountawc].Plan_Name + '</td>' +
                                             '<td>' + objdispplayproductamc[newcountawc].APlan_Amount + '</td>' +
                                             '</tr>';
                            }
                            newcountawc++;
                        }
                    }
                    else {
                        trdlrHTML += "<tr><td colspan='9' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td></tr>";
                    }
                    $('#GrdAmccomppro > tbody').html(trdlrHTML);
                }
            });
            $('#lbldivproductwise').hide();
           // $('#AMCDts').appendTo($('#lbldivAmc').html());
            $('#lbldivAmc').show();
            //$('#lbldivproductwise').show();
        }


        function filldemoalocation() {
           
            $('#divprogress').show();
            var rates = $("input:radio[name=filter]:checked").val()
            var compname = $('#txtCompanyName').val();
            var category = $('#ddlcat').val();
            var status = $('#ddlstatus').val();
            var comptype = $('#ddltypecomp').val();
            var fromdate = $("#txtDateFrom").val();
            var todate = $("#txtDateto").val();
            var all = "0";
            var Active = "0";
            var DeActive = "0";
            var compDelete = "0";
            if (rates == "All") {
                all = "1";
            }
            else if (rates == "Activate") {
                Active = "1";
            }
            else if (rates == "DeActivate") {
                DeActive = "1";
            }
            else if (rates == "Delete") {
                compDelete = "1";
            }
            var newcount = 0;

            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getregisteredcompany",
                data: "{'company':'" + compname + "','category':'" + category + "','status':'" + status + "','comptype':'" + comptype + "','from':'" + fromdate + "','to':'" + todate + "','all':'" + all + "','active':'" + Active + "','Dactive':'" + DeActive + "','delete':'" + compDelete + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    
                    $('#lblcountLicence').text("0");
                    var objdispachLabelsRecord = $.parseJSON(data.d);
                    var trdlrHTML = '';
                    $('#lblcountLicence').text(objdispachLabelsRecord.length);
                    if (objdispachLabelsRecord.length > 0) {
                        $('#GrdCodePrint > tbody').html("");
                        count = 0;
                        for (var i in objdispachLabelsRecord) {
                            var FSound = "";
                            var Veri = objdispachLabelsRecord[newcount].Email_Vari_Flag;
                            var versio = objdispachLabelsRecord[newcount].TypeCmp;
                            $('#hdnCompanyType').val(versio);
                            var Doc_Flag = objdispachLabelsRecord[newcount].Doc_Flag;
                            var Doc_Flag1 = objdispachLabelsRecord[newcount].Doc_Flag1;
                            var stat = objdispachLabelsRecord[newcount].Status;
                            var IsRetailer = objdispachLabelsRecord[newcount].IsRetailer;
                            var FPath = "";
                            var CurrCompID = objdispachLabelsRecord[newcount].Comp_ID;
                            FPath = "../Data/Sound" + "/" + CurrCompID.substring(5, 9) + "/" + CurrCompID.substring(5, 9) + ".mp3";
                            //FSound = fileExists(FPath);
                            trdlrHTML += '<tr>' +
                                //'<td>' + (parseInt(newcount) + 1) + '</td>' +
                              '<td>' + formatJsonDate(objdispachLabelsRecord[newcount].Reg_Date) + '</td>' +
                               //'<td>' + formatJsonDate1(objdispachLabelsRecord[newcount].Reg_Date) + '</td>' +
                             '<td>' + objdispachLabelsRecord[newcount].Comp_Name + '</td>' +
                             '<td>' + objdispachLabelsRecord[newcount].Comp_Email + '</td>' +
                             '<td>' + objdispachLabelsRecord[newcount].Contact_Person + '</td>' +
                             '<td>' + objdispachLabelsRecord[newcount].Mobile_No + '</td>';
                            if (IsRetailer == 0) {
                                trdlrHTML += '<td>' + objdispachLabelsRecord[newcount].TypeCmp + '</td>';
                            }
                            else {
                                trdlrHTML += '<td>R</td>';
                            }
                            //if (result == "Y") {
                            trdlrHTML += '<td><audio style="width:150px" controls="controls"><source src="' + objdispachLabelsRecord[newcount].SoundPath + '" type="audio/wav" /></audio></td>';
                            //}
                            // if (result == "N") {
                            //    trdlrHTML += '<td><img alt="" src="../Content/images/VolumeN.png" height="14px" width="14px" title="Sound not uploaded" /></td>';
                            // }
                            trdlrHTML += '<td>';
                            debugger;
                            if (Veri == 1) {
                                if (stat == 0) {
                                    if (Doc_Flag < 7) {
                                        if (Doc_Flag1 == 1) {
                                            trdlrHTML += '<a href="javascript:;"  onclick="arejectinterustTest(\'' + objdispachLabelsRecord[newcount].Comp_ID + '\',\'' + objdispachLabelsRecord[newcount].Comp_Name + '\',-1,\'VerifyDoc\',\'' + objdispachLabelsRecord[newcount].Comp_Email + '\'); return false;"><img src="../Content/images/generated_bill.png" style="width: 15px; margin-left: 10px" title="Click for Verify Documents"/></a>';
                                        }
                                    }
                                    else {
                                        trdlrHTML += '<a href="#"  onclick="arejectinterustTest(\'' + objdispachLabelsRecord[newcount].Comp_ID + '\',\'' + objdispachLabelsRecord[newcount].Comp_Name + '\',1,\'AccountActiveOrDeActive\',\'' + objdispachLabelsRecord[newcount].Comp_Email + '\'); return false;"><img src="../Content/images/check_gr_red.png" style="width: 15px; margin-left: 10px" title="Company account de-active"/></a>';
                                    }
                                }
                                else {
                                    if (Doc_Flag < 7) {
                                        if (Doc_Flag1 == 1) {
                                            trdlrHTML += '<a href="javascript:;"  onclick="arejectinterustTest(\'' + objdispachLabelsRecord[newcount].Comp_ID + '\',\'' + objdispachLabelsRecord[newcount].Comp_Name + '\',-1,\'VerifyDoc\',\'' + objdispachLabelsRecord[newcount].Comp_Email + '\'); return false;"><img src="../Content/images/generated_bill.png" style="width: 15px; margin-left: 10px" title="Click for Verify Documents"/></a>';
                                        }
                                    }
                                    //trdlrHTML += '<a href="javascript:;"  onclick=arejectinterust(' + objdispachLabelsRecord[newcount].Comp_ID + '); return false;><img src="../Content/images/check_act.png" style="width: 15px; margin-left: 10px" title="Company account active"/></a>';
                                    trdlrHTML += '<a href="javascript:;"  onclick="arejectinterustTest(\'' + objdispachLabelsRecord[newcount].Comp_ID + '\',\'' + objdispachLabelsRecord[newcount].Comp_Name + '\',0,\'AccountActiveOrDeActive\',\'' + objdispachLabelsRecord[newcount].Comp_Email + '\'); return false;"><img src="../Content/images/check_act.png" style="width: 15px; margin-left: 10px" title="Company account active"/></a>';
                                }
                            }
                            else if (Veri == 0) {
                                trdlrHTML += '<a href="javascript:;"  onclick="arejectinterustTest(\'' + objdispachLabelsRecord[newcount].Comp_ID + '\',\'' + objdispachLabelsRecord[newcount].Comp_Name + '\',-1,\'Resend\',\'' + objdispachLabelsRecord[newcount].Comp_Email + '\'); return false;"><img src="../Content/images/Resend_Mail.png" style="width: 15px; margin-left: 10px" title="Click for Verification Mail (Resend)"/></a>' +
                                             '<a href="javascript:;"  onclick="arejectinterustTest(\'' + objdispachLabelsRecord[newcount].Comp_ID + '\',\'' + objdispachLabelsRecord[newcount].Comp_Name + '\',-1,\'VerifyMail\',\'' + objdispachLabelsRecord[newcount].Comp_Email + '\'); return false;"><img src="../Content/images/Verify_Mail1.png" style="width: 15px; margin-left: 10px" title="Click for Verification Mail (Pending)"/></a>';
                            }
                           // alert(objdispachLabelsRecord[newcount].Comp_ID);
                            trdlrHTML += '<a href="javascript:;"  onclick="arejectinterustTest(\'' + objdispachLabelsRecord[newcount].Comp_ID + '\',\'' + objdispachLabelsRecord[newcount].Comp_Name + '\',-1,\'SendMail\',\'' + objdispachLabelsRecord[newcount].Comp_Email + '\'); return false;"><img src="../Content/images/mail.png" style="width: 15px; margin-left: 10px" title="Click for Send Mail"/></a>' +
                                         '<a href="javascript:;"  onclick="arejectinterustTest(\'' + objdispachLabelsRecord[newcount].Comp_ID + '\',\'' + objdispachLabelsRecord[newcount].Comp_Name + '\',-1,\'DeleteRow\',\'' + objdispachLabelsRecord[newcount].Comp_Email + '\'); return false;"><img src="../Content/images/delete.png" style="width: 15px; margin-left: 10px" title="Click for Delete Company Account"/></a>' +
                                         '<a href="javascript:;"  onclick="arejectinterustTest(\'' + objdispachLabelsRecord[newcount].Comp_ID + '\',\'' + objdispachLabelsRecord[newcount].Comp_Name + '\',-1,\'logincredential\',\'' + objdispachLabelsRecord[newcount].Comp_Email + '\'); return false;"><img src="../Content/images/vwnm1.png" style="width: 15px; margin-left: 10px" title="Click for Show login credential"/></a>' +
                                         '<a href="#"  onclick="arejectinterustTest(\'' + objdispachLabelsRecord[newcount].Comp_ID + '\',\'' + objdispachLabelsRecord[newcount].Comp_Name + '\',-1,\'EditCompnay\',\'' + objdispachLabelsRecord[newcount].Comp_Email + '\'); return false;"><img src="../Content/images/edit.png" style="width: 15px; margin-left: 10px" title="Click for Edit Company Account"/></a>' +
                                         '<a href="javascript:;"  onclick="arejectinterustTest(\'' + objdispachLabelsRecord[newcount].Comp_ID + '\',\'' + objdispachLabelsRecord[newcount].Comp_Name + '\',-1,\'compproduct\',\'' + objdispachLabelsRecord[newcount].Comp_Email + '\'); return false;"><img src="../Content/images/view_product.png" style="width: 15px; margin-left: 10px" title="Click for View Company Products"/></a>';
                                //'<a href="javascript:;"  onclick="getallcompproduct(\'' + objdispachLabelsRecord[newcount].Comp_ID + '\'); return false;"><img src="../Content/images/view_product.png" style="width: 15px; margin-left: 10px" title="Click for View Compnay Products"/></a>';
                            if (versio == "D") {
                                trdlrHTML += '<a href="javascript:;"  onclick="arejectinterust(' + objdispachLabelsRecord[newcount].Comp_ID + '); return false;"><img src="../Content/images/upg.png" style="width: 15px; margin-left: 10px" title="Click for upgrade company version"/></a>';
                            }
                            trdlrHTML += '</td>';
                            trdlrHTML += '</tr>';
                            newcount++;

                        }
                    }
                    else {
                        trdlrHTML += "<tr><td colspan='8' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td></tr>";
                    }
                    $('#GrdCodePrint > tbody').html(trdlrHTML);

                }
            });
            $('#divprogress').hide();
        }
        function BtnSendMailClick(strValue1) {

            //string strtxtcc, string strtxtbcc, string strtxtsubject,string strtxtbody
            if ($('#txtsubject').val().length == 0) {
                $.alert('Please enter subject');
                return false;
            }
            if ($('#txtbody').val().length == 0) {
                $.alert('Please enter message');
                return false;
            }
            // event.preventDefault();
            //  alert(strValue1);

            //   if (strValue1 == "clickSendMail") {
            //var formdata = $('#form1').serialize();
            var data = new FormData();
            var files = $("#FileUploadFormail").get(0).files;

            // Add the uploaded image content to the form data collection
            if (files.length > 0) {
                data.append("UploadedFile", files[0]);

                //  data.append("comp_id", $('#hdnCompanyID').val());
                // data.append("comp_id", $('#hdnCompanyID').val());
            }
            data.append("comp_id", $('#hdnCompanyID').val());
            data.append("strtxtsubject", $('#txtsubject').val());
            data.append("strtxtbody", $('#txtbody').val());
            //   alert(data);
            $('#divLoader').show();


            if (window.FormData !== undefined) {
                $.ajax({
                    type: "POST",
                    // url: "/Admin/adminhandeler.asmx/CompanyUploadFilr",
                    url: '<%=ProjectSession.absoluteSiteBrowseUrl%>/MasterHandler.ashx?method=CompanyUploadFilr',
                    // data: "{'compid':'" + $('#hdnCompanyID').val() + "','strtxtcc':'" + $('#txtcc').val() + "','strtxtbcc':'" + $('#txtbcc').val() + "','strtxtsubject':'" + $('#txtsubject').val() + "','strtxtbody':'" + $('#txtbody').val() + "'}",
                    data: data,
                    contentType: false,
                    processData: false,
                    datatype: 'json',
                    success: function (data) {
                        $.alert(data);
                        $('#divLoader').hide();
                        //$.alert('Mail sent successfully');
                        // $.alert(data);
                        //$.ajax({
                        //    type: "POST",
                        //    url: "/Admin/adminhandeler.asmx/CompanySendMail",
                        //    // data: "{'compid':'" + $('#hdnCompanyID').val() + "','strtxtcc':'" + $('#txtcc').val() + "','strtxtbcc':'" + $('#txtbcc').val() + "','strtxtsubject':'" + $('#txtsubject').val() + "','strtxtbody':'" + $('#txtbody').val() + "'}",
                        //    data: "{'compid':'" + $('#hdnCompanyID').val() + "','strtxtcc':'','strtxtbcc':'','strtxtsubject':'" + $('#txtsubject').val() + "','strtxtbody':'" + $('#txtbody').val() + "'}",
                        //    contentType: "application/json; charset=utf-8",
                        //    // contentType: "multipart/form-data",
                        //    dataType: "json",
                        //    success: function (data) {
                        //        $.alert(data.d);
                        //    }
                        //});
                    },
                    //error: function (xhr, status, p3, p4) {
                    //    var err = "Error " + " " + status + " " + p3 + " " + p4;
                    //    if (xhr.responseText && xhr.responseText[0] == "{")
                    //        err = JSON.parse(xhr.responseText).Message;
                    //   // console.log(err);
                    //}
                    error: function (err) {
                        $('#divLoader').hide();
                        alert(err.statusText);
                    }

                });
            }
            else {
                alert("FormData is not supported.");
            }
            //    }

        }
        
            function arejectinterustTest(compid, Comp_Name, intStatus, strType, strCompEmail) {

                var strActivate = '';
                if (intStatus == 0) {
                    strActivate = "de-Activate";
                }
                else if (intStatus == 1) {
                    strActivate = "Activate";
                }

                var strMessage1 = '';
                if (strType == "AccountActiveOrDeActive") {
                    strMessage1 = 'Are you sure to ' + strActivate + '  <span style=color:blue; > ' + Comp_Name + '</span>   Account ?"';
                }
                else if (strType == "VerifyMail") {
                    strMessage1 = 'Are you sure to verify e-mail of<span style=color:blue; > ' + Comp_Name + '</span>   Account ?"';
                }
                else if (strType == "DeleteRow") {
                    //  $('#lbldivproductSendMail').show();
                    strMessage1 = 'Are you sure you want to delete <span style=color:blue; > ' + Comp_Name + '</span>   Account ?"';
                }
                //else if (strType == "VerifyDoc") {
                // //   strMessage1 = 'Are you sure to verify Documents of<span style=color:blue; > ' + Comp_Name + '</span>   Account ?"';

                //}
               

                if (strType == "VerifyDoc") {
                    //  $('#lbldivVerifyDoc').show();
                    
                    getallcompproduct(compid, "doc");
                   
                }
                else if (strType == "SendMail") {
                    $('#txtsend').val(strCompEmail);
                    $('#hdnCompanyID').val(compid);
                    // clear text
                    $('#txtsubject').val('');
                    $('#txtbody').val('');
                    //$('#txtsend').val('');
                    $('#lbldivproductSendMail').show();
                }
                else if (strType == "logincredential") {
                    $.ajax({
                        type: "POST",
                        url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/CompanyAccActivate",
                        data: "{'compid':'" + compid + "','intStatus':" + intStatus + ",'strType':'" + strType + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {

                            var upHTML = data.d;
                            if (upHTML !== "") {
                                $.alert(upHTML);
                               // filldemoalocation();
                            }
                            else {
                                $.alert("Failed to update");
                            }
                        }
                    });
                }
                else if (strType == "EditCompnay") {
                    window.open("<%=ProjectSession.absoluteSiteBrowseUrl%>/Manufacturer/UpDateCompanyProfile.aspx?frmadmin=1&Comp_type=" + $('#hdnCompanyType').val() + "&CompanyId=" + compid);
                }
                else if (strType == "compproduct") {
                    getallcompproduct(compid, "product");
                }
                else {
                    $.confirm({
                        title: 'Confirm!',
                        content: strMessage1,
                        buttons: {
                            confirm: function () {

                                $.ajax({
                                    type: "POST",
                                    url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/CompanyAccActivate",
                                    data: "{'compid':'" + compid + "','intStatus':" + intStatus + ",'strType':'" + strType + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (data) {

                                        var upHTML = data.d;
                                        if (upHTML !== "") {
                                            $.alert(upHTML);
                                            filldemoalocation();
                                        }
                                        else {
                                            $.alert("Failed to update");
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
            function arejectinterust_All(compid, Comp_Name, intStatus, strType) {

                $('#lbldivproductSendMail').show();
                var strActivate = '';
                if (intStatus == 0) {
                    strActivate = "de-Activate";
                }
                else if (intStatus == 1) {
                    strActivate = "Activate";
                }

                var strMessage1 = '';
                if (strType == "AccountActiveOrDeActive") {
                    strMessage1 = 'Are you sure to ' + strActivate + '  <span style=color:blue; > ' + Comp_Name + '</span>   Account ?"';
                }
                else if (strType == "VerifyMail") {
                    strMessage1 = 'Are you sure to verify e-mail of<span style=color:blue; > ' + Comp_Name + '</span>   Account ?"';
                }
                else if (strType == "VerifyDoc") {
                    strMessage1 = 'Are you sure to verify Documents of<span style=color:blue; > ' + Comp_Name + '</span>   Account ?"';

                }
                $.confirm({
                    title: 'Confirm!',
                    content: strMessage1,
                    buttons: {
                        confirm: function () {

                            $.ajax({
                                type: "POST",
                                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/CompanyAccActivate",
                                data: "{'compid':'" + compid + "','intStatus':" + intStatus + ",'strType':'" + strType + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) {

                                    var upHTML = data.d;
                                    if (upHTML !== "") {
                                        $.alert(upHTML);
                                        filldemoalocation();
                                    }
                                    else {
                                        $.alert("Failed to update");
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
            //function arejectinterustTes2t(compid, Comp_Name, intStatus) {
            //    // alert('');
            //    debugger;
            //    if (intStatus == 0) {
            //        if ($.confirm("Are you sure to Activate  <span style=color:blue; > " + Comp_Name + " </span>   Account ?")) {

            //            $.ajax({
            //                type: "POST",
            //                url: "/Admin/adminhandeler.asmx/CompanyAccActivate",
            //                data: "{'compid':'" + compid + "','intStatus':" + intStatus + "}",
            //                contentType: "application/json; charset=utf-8",
            //                dataType: "json",
            //                success: function (data) {
            //                    // alert('Regis Done');
            //                    //  $.alert(data);
            //                }
            //            });
            //        }
            //        else {
            //            return false;
            //        }
            //    }
            //    else if (intStatus == 1) {
            //        if ($.confirm("Are you sure to de-Activate  <span style=color:blue; > " + Comp_Name + " </span>   Account ?")) {

            //            $.ajax({
            //                type: "POST",
            //                url: "/Admin/adminhandeler.asmx/CompanyAccActivate",
            //                data: "{'compid':'" + compid + "','intStatus':" + intStatus + "}",
            //                contentType: "application/json; charset=utf-8",
            //                dataType: "json",
            //                success: function (data) {
            //                    // alert('Regis Done');
            //                    //  $.alert(data);
            //                }
            //            });
            //        }
            //        else {
            //            return false;
            //        }
            //    }}





            //var counttaxdetails1 = 0;
            //var strCompanyName = '';
            //function arejectinterust(compid) {
            //    $.confirm({
            //        title: 'Tax Details',
            //        content: 'url:approvedoc2.html',
            //        onContentReady: function () {
            //            $.ajax({
            //                type: "POST",
            //                url: "/Admin/adminhandeler.asmx/taxdata1",
            //                data: "{'id':'" + proid + "', 'compid':'" + compid + "'}",
            //                contentType: "application/json; charset=utf-8",
            //                dataType: "json",
            //                success: function (data) {
            //                    //alert(data);
            //                    //alert(" alert(data);" + "   " + data[0][1]);
            //                    //alert(data[0][0]);
            //                    var taxdata = "";
            //                    taxdata = $.parseJSON(data.d);
            //                    //alert("parseJSON;" + "   " + taxdata[0].Comp_Name);
            //                    //alert("parseJSON;" + "   " + taxdata[0]);
            //                    if (taxdata != "") {
            //                        strCompanyName = taxdata[counttaxdetails1].Comp_Name;
            //                        $('#ddlcompidfortax').text(taxdata[counttaxdetails1].Comp_Name);
            //                        $('#lblcompcat').text(taxdata[counttaxdetails1].Category_Name);
            //                        $('#lblAddress').text(taxdata[counttaxdetails1].Dispatch_Location);
            //                    }
            //                }
            //            });
            //        },
            //        boxWidth: '800px',
            //        useBootstrap: false,
            //        buttons: {
            //            sayMyName: {
            //                text: 'Confirm',
            //                btnClass: 'btn-warning',
            //                action: function () {

            //                    var lbltax = $('#txtLabelServiceTax').val();
            //                    var lblvat = $('#txtLabelVAT').val();
            //                    var servtax = $('#txtAmcServiceTax').val();
            //                    var servvat = $('#txtAMCVATx').val();
            //                    var errorText = this.$content.find('.text-danger');
            //                    if (lbltax == '') {
            //                        errorText.html('<br><div class="text-danger help-block" style="color:Red">Please don\'t keep the Lable Service Tax field empty<div>').slideDown(200);
            //                        return false;
            //                    } else if (lblvat == '') {
            //                        errorText.html('<br><div class="text-danger help-block" style="color:Red">Please don\'t keep the Lable Vat field empty<div>').slideDown(200);
            //                        return false;
            //                    } else if (servtax == '') {
            //                        errorText.html('<br><div class="text-danger help-block" style="color:Red">Please don\'t keep the Service Service Tax field empty<div>').slideDown(200);
            //                        return false;
            //                    } else if (servvat == '') {
            //                        errorText.html('<br><div class="text-danger help-block" style="color:Red">Please don\'t keep the Service Vat field empty<div>').slideDown(200);
            //                        return false;
            //                    }
            //                    else {

            //                        $.ajax({
            //                            type: "POST",
            //                            url: "/Admin/adminhandeler.asmx/savetaxsetting",//$('#ddlcompidfortax').val() change by shweta
            //                            data: "{'proid':'" + proid + "', 'productname':'" + productname + "', 'compid':'" + compid + "','compname':'" + strCompanyName + "','ltax':'" + $('#txtLabelServiceTax').val() + "', 'lvat':'" + $('#txtLabelVAT').val() + "', 'stax':'" + $('#txtAmcServiceTax').val() + "','svat':'" + $('#txtAMCVATx').val() + "'}",
            //                            contentType: "application/json; charset=utf-8",
            //                            dataType: "json",
            //                            success: function (data) {
            //                                var taxresult = data.d;
            //                                if (taxresult != "") {
            //                                    $.alert(taxresult);
            //                                    bindlegaldocument();
            //                                }
            //                            }
            //                        });
            //                    }
            //                }
            //            },
            //            cancel: function () {
            //                $.alert('Canceled!');
            //            }
            //        }
            //    });
            //}
            //function arejectinterust(intComp_ID) {
            //    alert('reached');
            //    $.confirm({
            //        title: 'Confirm!',
            //        content: 'Are you sure to cancel this request?',
            //        buttons: {
            //            confirm: function () {
            //                $.ajax({
            //                    type: "POST",
            //                    url: "/Admin/adminhandeler.asmx/actionintrusted",
            //                    data: "{'id':" + e + ",'action':'IntReqCancel'}",
            //                    contentType: "application/json; charset=utf-8",
            //                    dataType: "json",
            //                    success: function (data) {
            //                        var upHTML = data.d;
            //                        if (upHTML == "IntReqCancel") {
            //                            bindintrusted();
            //                            //toastr.success("Interested Request has been accepted successfully !");
            //                        }
            //                    }
            //                });
            //                $.alert('Interested Request has been canceled successfully !');
            //            },
            //            cancel: function () {
            //                $.alert('Canceled!');
            //            },
            //        }
            //    });
            //}

        </script>
</asp:Content>

<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
   
          
  <%--   <asp:Panel ID="PanelAlert" runat="server" Width="20%" Style="display: none;">
                        <div class="popupContent" style="width: 100%;">
                            <div class="pop_log_bg">
                                <div>
                                    <asp:Button ID="btnAlertPnlClose" CssClass="popupClose" runat="server" CausesValidation="false" /></div>
                                <!--<fieldset class="service_field" >-->
                                <div class="service_head_p">
                                    <p>
                                        <span class="left">
                                            <asp:Label ID="LabelAlertheader" runat="server" Text="Password" Font-Size="12px"></asp:Label>
                                        </span><span class="right" style="visibility: hidden;"><span class="astrics"><strong>
                                        </strong></span></span>
                                    </p>
                                </div>
                                <div class="regis_popup" style="text-align: center;">
                                    <br />
                                    <asp:Label ID="LabelAlertText" runat="server" Text="" Font-Size="11px"></asp:Label><br />
                                    <br />
                                   
                                    <asp:Button ID="btnYes" runat="server" Text="Yes" CssClass="button_all" OnClick="btnYes_Click" CausesValidation="false" />&nbsp;&nbsp;<asp:Button
                                        Visible="false" ID="btnCancel" runat="server" Text="Reject" CssClass="button_all"
                                        OnClick="btnCancel_Click" />&nbsp;&nbsp;<asp:Button ID="btnNo" runat="server" Text="No"
                                            Visible="false" CssClass="button_all" OnClick="btnNo_Click" />
                                </div>
                            </div>
                        </div>
                    </asp:Panel>--%>
                    <!--===============================Popup Close================================-->
                   <%-- <asp:Label ID="Label12" runat="server"></asp:Label><asp:Label ID="LabelCalText" runat="server"
                        Visible="false"></asp:Label>
                    <cc1:ModalPopupExtender ID="ModalPopupExtenderAlert" runat="server" BackgroundCssClass="NewmodalBackground"
                        CancelControlID="btnAlertPnlClose" PopupControlID="PanelAlert" TargetControlID="Label12">
                    </cc1:ModalPopupExtender>--%>
                    <!--===============================PopUp Alert Starts===============================-->
    <input type="hidden" name="hdnCompanyID" id="hdnCompanyID" />
    <input type="hidden" name="hdnCompanyType" id="hdnCompanyType" />
     <%--<div id="lbldivproductActiveInactive" align="center" style="background-color: #333; position: fixed; left: 0; height: 100%; width: 100%; top: 0px; display: none; z-index: 111;"
        class="NewmodalBackground">
        <div style="margin: 60px 150px;" align="center">
            <div class="col-xs-12" style="border: 1px solid #ddd;">
                <div class="row">
                    <div style="max-height: 400px; overflow: auto;">
                        <div class="table-header">
                            <div style="float: left;">
                               Alert
                            </div>
                           
                            <div style="float: right">
                                <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 50px; width: auto; line-height: 22px;">
                                    <span id="lblCloseDiv" style="color: #fff; cursor: pointer;">Close</span>
                                </div>
                            </div>
                        </div>
                        <table id="Grdcomppro" class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <td>Are you sure to Activate  <span style='color:blue;' >$('#txtCompanyName').val()</span>   Account</td>
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
    </div>--%>
    <div id="lbldivproductwise" align="center" style="background-color: #333; position: fixed; left: 0; height: 100%; width: 100%; top: 0px; display: none;z-index:100001;opacity:0.9;filter:alpha(opacity=50);"
        class="NewmodalBackground">
        <div style="margin: 60px 150px;" align="center">
            <div class="col-xs-12" style="border: 1px solid #ddd;">
                <div class="row">
                    <div style="max-height: 400px; overflow: auto;">
                        <div class="table-header">
                            <div style="float: left;">
                                <img src="../Content/images/regis_pro.png" />Products(s) found
                            </div>
                            <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 30px; width: auto; line-height: 22px;">
                                <label id="lblcountproducts" style="color: #fff;">0</label>
                            </div>
                            <div style="float: right">
                                <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 50px; width: auto; line-height: 22px;">
                                    <span id="lblCloseDivPro" style="color: #fff; cursor: pointer;">Close</span>
                                </div>
                            </div>
                        </div>
                        <table id="Grdcomppro1" class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>S.No</th>
                                    <th>Product Name</th>
                                    <th>Label Name</th>
                                    <th>Price/Label</th>
                                    <th>Description</th>
                                    <th>Sound File</th>
                                    <th>Action</th>
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
        <div id="AMCDts"></div>
    </div>
    <div id="lbldivVerifyDoc" align="center" style="background-color:#000; position: fixed; left: 0; height: 100%; width: 100%; top: 0px; display: none; z-index:100001;opacity:0.9;filter:alpha(opacity=50);"
        class="NewmodalBackground">
         <asp:UpdatePanel ID="UpdatePanel2" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress2" AssociatedUpdatePanelID="UpdatePanel1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 1507px; width: 100%;
                        z-index: 100001; top: 0px;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
         <div style="margin: 150px 150px;width:700px" align="center">
            <div class="col-xs-12" style="border: 1px solid #ddd;">
                <div class="row">
                    <div style="max-height: 600px; overflow: auto;">
                        <div class="table-header">
                            <div style="float: left;">
                                <img src="../Content/images/generated_bill.png" /><b>Verify Doc</b>
                            </div>
                            <div style="float: right">
                                <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 50px; width: auto; line-height: 22px;">
                                    <span id="imgBtnCloseVerifyDoc" style="color: #fff; cursor: pointer;">Close</span>
                                </div>
                            </div>
                        </div>
                        <table id="GrdcompproVerifyDoc" class="table table-striped table-bordered table-hover">

                            <thead>
                                <tr>
                                    <th>S.No</th>
                                    <th>Doc Name</th>
                                      <th>Document Comments</th>
                                    <th>Document Details</th>
                                    <th>
                                        Status</th>
                                    <th>
                                         <input type="checkbox" name="name" value=""  id="chkmaster" class="ckhmaster" onchange="checkAll(this);" />Select All</th>
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
                 </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="lbldivproductSendMail" align="center" style="background-color:#000; position: fixed; left: 0; height: 100%; width: 100%; top: 0px; display: none; z-index:100001;opacity:0.9;filter:alpha(opacity=50);"
        class="NewmodalBackground">
         <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
            <asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 1507px; width: 100%;
                        z-index: 100001; top: 0px;" class="NewmodalBackground">
                        <div style="margin-top: 300px;" align="center">
                            <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                            <span style="color: White;">Please Wait.....<br />
                            </span>
                        </div>
                    </div>
                </ProgressTemplate>
            </asp:UpdateProgress>
         <div style="margin: 150px 150px;width:500px" align="center">
            <div class="col-xs-12" style="border: 1px solid #ddd;">
                <div class="row">
                    <div style="max-height: 400px; overflow: auto;">
                        <div class="table-header">
                            <div style="float: left;">
                           
                                <img src="../Content/images/mail_ico.png" />   <b>Send Mail</b>
                            </div>
                          <%--  <div style="float: right;  font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 30px; width: auto; line-height: 22px;">
                                <label id="lblcountproducts" style="color: #fff;"></label>
                                 
                            </div>--%>
                            <div style="float: right">

                                <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 50px; width: auto; line-height: 22px;">
                                   
                                    <span id="imgBtnClose" style="color: #fff; cursor: pointer;">Close</span>
                                </div>
                            </div>
                        </div>
                        <table id="GrdcompproSendMail" class="table table-striped table-bordered table-hover">
                             <thead>
                                <tr>
                                    <th>General Info</th>
                                    <th style="text-align:right;"> <span >( <strong style="color:red">*</strong></span><span> indicates mandatory fields)</span></th>
                                    
                                </tr>
                            </thead>
                           <%-- <tr>
                                <td colspan="2" align="center">
                                    <asp:Label ID="MylblMsg" runat="server" Text="" ForeColor="Red" Font-Size="8pt"></asp:Label>
                                </td>
                            </tr>--%>
                            <tr>
                                <td style="width: 30%;" align="right">
                                    <strong>Send To :</strong>
                                </td>
                                <td align="left" style="width: 70%;">
                                    <%--<asp:TextBox ID="txtsend" runat="server" CssClass="textbox_pop" Width="200px" Enabled="false"></asp:TextBox>--%>
                                     <input type="text" name="txtsend" id="txtsend"  class="textbox_pop" style="Width:200px" />
                                </td>
                            </tr>
                           <%-- <tr runat="server" visible="false">
                                <td align="right">
                                    <strong>Cc :</strong>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtcc" runat="server" CssClass="txt_box" onblur="ValidateEmail(this.value)"></asp:TextBox>
                                </td>
                            </tr>
                            <tr runat="server" visible="false">
                                <td align="right">
                                    <strong>Bcc :</strong>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtbcc" runat="server" CssClass="txt_box" onblur="ValidateEmail(this.value)"></asp:TextBox>
                                </td>
                            </tr>--%>
                            <tr>
                                <td align="right">
                                    <strong style="color: Red;">*</strong><strong>Subject :</strong>
                                </td>
                                <td align="left">
                                    <input type="text" name="txtsubject" id="txtsubject"  class="textbox_pop" style="Width:200px" />
                                    <%--<asp:TextBox ID="txtsubject" runat="server" CssClass="textbox_pop" Width="200px"></asp:TextBox>--%>
                                    <%--<asp:RequiredFieldValidator ControlToValidate="txtsubject" ErrorMessage="*" ID="RequiredFieldValidator1"
                                        runat="server" ValidationGroup="Mail"></asp:RequiredFieldValidator>--%>
                                </td>
                            </tr>
                            <tr >
                                <td align="right">
                                    <strong style="color: Red;">*</strong><strong>Message :</strong>
                                </td>
                                <td align="left">
                                    <textarea   name="txtbody" id="txtbody" class="textbox_pop" style="Width:200px"></textarea>
                                      <%--<input type="text"  name="txtbody" id="txtbody" class="textbox_pop" style="Width:200px" />--%>
                                    <%--<asp:TextBox ID="txtbody" runat="server" CssClass="textbox_pop" TextMode="MultiLine"
                                        Height="100px" Width="202px"></asp:TextBox>--%>
                                    <%--<asp:RequiredFieldValidator ControlToValidate="txtbody" ErrorMessage="*" ID="RequiredFieldValidator2"
                                        runat="server" ValidationGroup="Mail"></asp:RequiredFieldValidator>--%>
                                </td>
                            </tr>
                            <tr >
                                <td align="right">
                                    <strong>Upload File :</strong>
                                </td>
                                <td align="left">
                                      <input type="file" name="FileUploadFormail" id="FileUploadFormail" style="Width:200px" />
                                    <%--<asp:FileUpload ID="FileUploadFormail" runat="server" name="FileUploadFormail" />--%>
                                </td>
                            </tr>
                            <tr><td align="right"></td><td>
                                <%--<asp:Button ID="BtnSendMail" runat="server" ValidationGroup="Mail" Style="cursor: pointer;"
                                        Text="Send Mail" CssClass="button_all" OnClientClick="BtnSendMailClick('clickSendMail'); return false;"  OnClick="BtnSendMail_Click"/>--%>
                                <input type="button" name="BtnSendMail"  class="button_all" id="BtnSendMail" value="Send Mail"  onclick ="BtnSendMailClick('clickSendMail'); return false" />
                                <div align="left" id="divLoader" style="display:none;">
                                    <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                                    <span style="color: White;">Please Wait.....<br />
                                    </span>
                                </div>
                                                       </td></tr>
                            <tbody>
                            </tbody>
                        </table>
                    </div>
                    <!-- /.span -->
                </div>
            </div>
        </div>
                 </ContentTemplate>
        </asp:UpdatePanel>
    </div>
    <div id="lbldivAmc" align="center" style="background-color: #333; position: fixed; left: 0; height: 100%; width: 100%; top: 0px; display: none; z-index: 111;"
        class="NewmodalBackground">
        <div style="margin: 60px 150px;" align="center">
            <div class="col-xs-12" style="border: 1px solid #ddd;">
                <div class="row">
                    <div style="max-height: 400px; overflow: auto;">
                        <div class="table-header">
                            <div style="float: left;">
                                Amc Renewal 
                            </div>
                            <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 30px; width: auto; line-height: 22px;">
                                <label id="lblAmccountproducts" style="color: #fff;">0</label>
                            </div>
                            <div style="float: right">
                                <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 50px; width: auto; line-height: 22px;">
                                    <span id="lblAmcCloseDiv" style="color: #fff; cursor: pointer;">Back</span>
                                </div>
                            </div>
                        </div>
                        <table id="GrdAmccomppro" class="table table-striped table-bordered table-hover">
                            <thead>
                                <tr>
                                    <th>S.No</th>
                                    <th>Select</th>
                                    <th>Plan Name</th>
                                    <th>Amount (In Rs.)</th>
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

        <div class="col-sm-12">
            <h3 class="header blue lighter smaller">
                <img src="../images/registered_companies.png" />Registered Companies 	
            </h3>
        </div>
    </div>
    <div class="col-md-12">
        <fieldset class="field_profile" style="margin: 0 auto;">
            <legend>
                <img src="../images/search_icon.png" />
                Search</legend>
            <table width="100%" cellpadding="0" cellspacing="2" class="tab_regis">
                <tr>
                    <td>
                        <input type="text" id="txtCompanyName" placeholder="Company" class="text" />

                    </td>


                    <td align="justify">
                        <select id="ddlcat" class="reg_txt">
                        </select>
                    </td>
                    <td align="justify">
                        <select id="ddlstatus" class="reg_txt">
                            <option selected="selected" value="--Status--">--Status--</option>
                            <option value="1">Activated</option>
                            <option value="0">Not Activated</option>
                        </select>
                    </td>
                    <td align="justify">
                        <select id="ddltypecomp" class="reg_txt">
                            <option selected="selected" value="0">--All--</option>
                            <option value="L">License</option>
                            <option value="D">Demo</option>
                            <option value="R">Retailer</option>
                        </select>
                    </td>
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
                    <td colspan="10"></td>
                </tr>
            </table>
        </fieldset>
        <br />
        <fieldset class="Newfield" style="width: 98%">
            <legend>Icon Meaning</legend>
            <table width="90%" cellpadding="0" cellspacing="2" class="tab_regis">
                <tr>
                    <td style="width: 2%;">
                        <img alt="" src="../Content/images/check_act.png" />
                    </td>
                    <td style="width: 19%;">Active Account
                    </td>
                    <td width="2%">
                        <img alt="" src="../Content/images/check_gr_red.png" />
                    </td>
                    <td width="16%">De-Active Account
                    </td>
                    <td width="2%">
                        <img alt="" src="../Content/images/generated_bill.png" height="14px" width="14px" />
                    </td>
                    <td width="18%">Verify Documents
                    </td>
                    <td width="2%">
                        <img alt="" src="../Content/images/edit.png" />
                    </td>
                    <td width="15%">Edit Account
                    </td>
                    <td width="2%">
                        <img alt="" src="../Content/images/upg.png" height="12px" width="12px" />
                    </td>
                    <td width="13%">Upgrade Version
                    </td>
                    <td width="2%">
                        <img alt="" src="../Content/images/mail.png" />
                    </td>
                    <td width="14%">Send Mail
                    </td>
                </tr>
                <tr>
                    <td colspan="12" style="width: 100%;">
                        <table style="width: 100%;">
                            <tr>
                                <td style="width: 2%;">
                                    <img alt="" src="../Content/images/vwnm1.png" />
                                </td>
                                <td style="width: 19%;">Show login credential
                                </td>
                                <td width="2%">
                                    <img alt="" src="../Content/images/delete.png" />
                                </td>
                                <td width="16%">Delete Account
                                </td>
                                <td style="width: 2%;">
                                    <img alt="" src="../Content/images/Verify_Mail1.png" />
                                </td>
                                <td style="width: 18%;">E-Mail Verification by admin
                                </td>
                                <td width="2%">
                                    <img alt="" src="../Content/images/Resend_Mail.png" />
                                </td>
                                <td>E-mail Verification Mail(Resend)
                                </td>
                                <td width="3%">
                                    <img alt="" src="../Content/images/view_product.png" height="20px" width="20px" />
                                </td>
                                <td>View Company Products 
                                </td>
                            </tr>
                        </table>
                    </td>
                </tr>
            </table>
        </fieldset>
        <br />
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
                    <div style="float: right" id="rate">
                        <div style="float: left; margin-left: 0px">
                            <input type="radio" id="allcomp" name="filter" checked="checked" onchange="return filldemoalocation();" value="All" />
                            All
                        </div>
                        <div style="float: left; margin-left: 20px">
                            <input type="radio" id="activecomp" name="filter"  value="Activate" onchange="return filldemoalocation();" />Activate
                        </div>
                        <div style="float: left; margin-left: 20px">
                            <input type="radio" id="deactivecomp" name="filter" value="DeActivate" onchange="return filldemoalocation();" />
                            De-Activate
                        </div>
                        <div style="float: left; margin-left: 20px; margin-right: 20px">
                            <input type="radio" name="filter" id="deletecomp" value="Delete" onchange="return filldemoalocation();" />
                            Delete
                        </div>
                    </div>
                </div>
                <table id="GrdCodePrint" class="table table-striped table-bordered table-hover">
                    <thead>
                        <tr>
                            <th width="10%">Reg. Date</th>
                            <th width="10%" style="word-wrap:break-word;">Company Name</th>
                            <th width="10%">Email</th>
                            <th width="10%" style="word-wrap:break-word;">Contact Person</th>
                            <th width="10%">Mobile No.</th>
                            <th width="10%">Type</th>
                            <th width="20%">Sound</th>
                            <th width="15%">Action</th>
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

<%--function BtnSendMailClick1(strValue1) {          
            //string strtxtcc, string strtxtbcc, string strtxtsubject,string strtxtbody
            if ($('#txtsubject').val().length == 0) {
                $.alert('Please enter subject');
                return false;
            }
            if ($('#txtbody').val().length == 0) {
                $.alert('Please enter message');
                return false;
            }
            // event.preventDefault();
            //  alert(strValue1);

            //   if (strValue1 == "clickSendMail") {
            //var formdata = $('#form1').serialize();
            var data = new FormData();
            var files = $("#FileUploadFormail").get(0).files;

            //// Add the uploaded image content to the form data collection
            if (files.length > 0) {
                data.append("UploadedFile", files[0]);

                //    //  data.append("comp_id", $('#hdnCompanyID').val());
                //    // data.append("comp_id", $('#hdnCompanyID').val());
                //}
                //data.append("comp_id", $('#hdnCompanyID').val());
                //data.append("strtxtsubject", $('#txtsubject').val());
                //data.append("strtxtbody", $('#txtbody').val());
                //   alert(data);
                $('#divLoader').show();


                if (window.FormData !== undefined) {
                    //$.ajax({
                    //    type: "POST",
                    //    url: "/Admin/adminhandeler.asmx/CompanyUploadFilr",
                    //    // data: "{'compid':'" + $('#hdnCompanyID').val() + "','strtxtcc':'" + $('#txtcc').val() + "','strtxtbcc':'" + $('#txtbcc').val() + "','strtxtsubject':'" + $('#txtsubject').val() + "','strtxtbody':'" + $('#txtbody').val() + "'}",
                    //    data: data,
                    //    contentType: false,
                    //    processData: false,
                    //    datatype: 'json',
                    //    success: function (data) {

                    // $.alert(data);
                    $.ajax({
                        type: "POST",
                        url: "/Admin/adminhandeler.asmx/CompanySendMail",
                        // data: "{'compid':'" + $('#hdnCompanyID').val() + "','strtxtcc':'" + $('#txtcc').val() + "','strtxtbcc':'" + $('#txtbcc').val() + "','strtxtsubject':'" + $('#txtsubject').val() + "','strtxtbody':'" + $('#txtbody').val() + "'}",
                        //data: "{'compid':'" + $('#hdnCompanyID').val() + "','strtxtcc':'','strtxtbcc':'','strtxtsubject':'" + $('#txtsubject').val() + "','strtxtbody':'" + $('#txtbody').val() + "'}",
                        data: "{'compid':'" + $('#hdnCompanyID').val() + "','strtxtcc':'','strtxtbcc':'','strtxtsubject':'" + $('#txtsubject').val() + "','strtxtbody':'" + $('#txtbody').val() + "'}",
                        contentType: "application/json; charset=utf-8",
                        //contentType: "multipart/form-data",
                        dataType: "json",
                        success: function (data) {
                            //$.alert(data.d);
                            $('#divLoader').hide();
                            $.alert('Mail sent successfully');
                        }
                    });
                    //    },
                    //    //error: function (xhr, status, p3, p4) {
                    //    //    var err = "Error " + " " + status + " " + p3 + " " + p4;
                    //    //    if (xhr.responseText && xhr.responseText[0] == "{")
                    //    //        err = JSON.parse(xhr.responseText).Message;
                    //    //   // console.log(err);
                    //    //}
                    //    error: function (err) {
                    //        $('#divLoader').hide();
                    //        alert(err.statusText);
                    //    }

                    //});
                }
                else {
                    alert("FormData is not supported.");
                }

            }
        }--%>