<%@ Page Title="Dispatch To Dealer" Language="C#" MasterPageFile="~/Manufacturer/MasterPage.master" AutoEventWireup="true" CodeFile="GiftDispatch.aspx.cs" Inherits="Manufacturer_GiftDispatch" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <%--Start Date Picker--%>
      <link href="assets/css/datepicker.css" rel="stylesheet" type="text/css" />
    <script src="js/bootstrap-datepicker.js" type="text/javascript"></script>
 <%--  <link href="../Content/css/jquery-confirm.css" rel="stylesheet" />
    <script src="../Content/js/jquery-confirm.js" type="text/javascript"></script>--%>
    <script type="text/javascript">
        $(document).ready(function() {
            //showMessageFromPopJs('dd');
            $(".accordion2 p").eq(15).addClass("active");
            $(".accordion2 div.open").eq(11).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });
            
        });
        $('#divprogress').hide();
        $("#txtDispatchDate").datepicker();
        $("#txtExpectedDate").datepicker();
    </script>
    
    <style type="text/css">
        .myrd input
        {
            position: relative;
            padding: 5px;
            margin-left: 5px;
            margin-top: 9px;
        }
        .myrd label
        {
            position: relative;
            padding: 5px;
            font-weight: bold;
        }
        .pad
        {
            text-align: left;
            padding: 0px 4px 0 4px;
        }
        </style>

    <script language="javascript" type="text/javascript">
        function divexpandcollapse(divname) {
            var div = document.getElementById(divname);
            var img = document.getElementById('img' + divname);
            if (div.style.display == "none") {
                div.style.display = "inline";
                img.src = "../Content/images/minus.gif";
            } else {
                div.style.display = "none";
                img.src = "../Content/images/plus.gif";
            }
        }
        function CheckTrackingNo(mm) {
            PageMethods.MethodChkTrackingNo();
        }
        function onengcheck(Result) {
            if (Result == true) {
                document.getElementById("lbltrackduplicate").innerHTML = "Tracking No Already Exist.";
                document.getElementById("btnCourierSubmit").disabled = true;
                document.getElementById("btnCourierSubmit.ClientID").className = "button_all_Sec";

            }
            else {
                document.getElementById("lbltrackduplicate.ClientID").innerHTML = "";
                document.getElementById("btnCourierSubmit.ClientID").disabled = false;
                document.getElementById("btnCourierSubmit.ClientID").className = "button_all";
            }
        }

        function UpdatePage() {
            




            var dataGift_Pkid = new Array();
            var dataConsumer_Pkid = new Array();
            var dataCodeConsumer_Pkid = new Array();
            var dataChecked = new Array();
            var listName1 = new Array();
            var listComments1 = new Array();
            var strType = '';

           
            var cnt = 0;
            $("#GrdCodePrint tr").each(function () {

                if ($(this).find('.childchk').is(":checked") == true) {
                    dataGift_Pkid[cnt] = $(this).find('td:last').text();
                    dataConsumer_Pkid[cnt] = $(this).find('td:eq(8)').text();
                    dataCodeConsumer_Pkid[cnt] = $(this).find('td:eq(7)').text();
                    //listName1[cnt] = $(this).find('td:eq(1)').text();
                    //dataConsumer_Pkid[cnt] = $(this).find('td:eq(7)').find('input').val();
                    //listComments1[cnt] = $(this).find("td:eq(2) input[type='text']").val();
                    //alert(listComments1[cnt]);
                    cnt = cnt + 1;

                }
                //$(this).children('td').each(function (ii, vv) {
                //    data[i] = $(this).text();
                //});,'compid':'" + compid + "','strtype':'" + strtype + "'
            }) 
            if (dataGift_Pkid.length == 0) {
                showMessageFromPopJs("Please select Consumer.");
                return false;
            }

            var chk1 = $('#Courier1').is(":checked");

            var chk2 = $('#Dealer1').is(":checked");
            if (chk1 == true) {
                strType = "courier";
                if ($('#ddlCourierCompany').val() == "0")
                {
                    showMessageFromPopJs("Please select Courier.");
                    return false;
                }
            }
            else if (chk2 == true) {
                strType = "dealer";
                if ($('#ddlDealer').val() == "0") {
                    showMessageFromPopJs("Please select Dealer.");
                    return false;
                }
            }
            
            //var did = 0;
            //if ($('#ddlDealer').val() != undefined)
            //{ alert(''); did = $('#ddlDealer').val(); }

            // $('#divLoaderdoc').show();
            //$('#divprogress').show();
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/UpdateDispatchGift",
                data: JSON.stringify({
                    Gift_Pkid: dataGift_Pkid, Consumer_Pkid: dataConsumer_Pkid, "dealid": $('#ddlDealer').val(), "courid": $('#ddlCourierCompany').val(), "dispdate": $('#txtDispatchDate').val(),
                    "expdate": $('#txtExpectedDate').val(), "strType": strType, CodeConsumer_Pkid: dataCodeConsumer_Pkid
                }),
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                  //  $('#divLoaderdoc').hide();
                    //$('#lbldivVerifyDoc').hide();
                    $('#divprogress').hide();
                    showMessageFromPopJs('Updated Successfully');
                    // filldemoalocation();
                    //$('#lblAmccountproducts').text(proname);
                    //var alldata = data.d;
                    //var amcdata = alldata.split('#');
                    //var objdispplayproductamc = $.parseJSON(amcdata[0]);                   
                }
            });
        }
        $(document).ready(function () {
            $('#tblCourier').hide();
           // alert(username);
            <%--var username = '<%=Session["User_Type"]%>';
            if (username == "") {
                window.location.href = "<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/Login.aspx?Page=GiftDispatch.aspx";
            }
            else {
                if (username == "Company")
                    window.location.href = "<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/Login.aspx";
            }--%>
          
            //$('.input-daterange').datepicker({
            //    todayBtn: "linked"

            //});
            //$("#lblCloseDivPro").click(function () {
            //    $('#lbldivproductwise').hide();
            //});
            //$("#imgBtnCloseVerifyDoc").click(function () {
            //    $('#lbldivVerifyDoc').hide();
            //});
            //$("#imgBtnClose").click(function () {
            //    $('#lbldivproductSendMail').hide();
                
            //});

            //$("#lblAmcCloseDiv").click(function () {
            //    $('#lbldivAmc').hide();
            //    $('#lbldivproductwise').show();
            //});
         // $('#divprogress').css("display", "block");
            Bindcategory();
            filldemoalocation();
            $('#divprogress').hide();
            $('#divprogress').css("display", "none");
           });


        function checkAll(ctrl) {
            //alert(ctrl.id);
            //var dd = $('#' + ctrl.id).prop('checked', this.checked);
            //alert(dd);
            if ($('#' + ctrl.id).is(":checked") == true) {
                $('.childchk').prop('checked', true);
            }
            else if ($('#' + ctrl.id).is(":checked") == false) {
                $('.childchk').prop('checked', false);
            }
        }
       
        function showtbl() {
            var chk1 = $('#Courier1').is(":checked");
            if (chk1 == true)
            {
                $('#trDealer').hide();
                $('#tblCourier').show();
            }
            var chk2 = $('#Dealer1').is(":checked");
           // alert(chk2);
            if (chk2 == true) {
                $('#trDealer').show();
               // $('#trCourier').hide();
                $('#tblCourier').hide();
            }
        }
        function resetdata() {
            $('#txtMobile').val('');
          //  $('#ddlcat').val(0);
           $('#ddlstatus').val('--Status--');
          //  $('#ddltypecomp').val(0);
          //  $("#txtDateFrom").val('');
           // $("#txtDateto").val('');
            //$('#dyntable > tbody').html("");
            $('#lblcountLicence').text("0");
            //$('#activecomp').checked(true);
            //document.getElementById("activecomp").checked = true;
            Bindcategory();
            filldemoalocation();
        }

        function Bindcategory() {
          
            $("select[id$=ddlstatus]").html('<option selected="selected" value="0">--Select Award/Gift --</option>');
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getGiftByCompany",
                data: "{'strType':'gift'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    var objdata = $.parseJSON(data.d);
                    $('.ddlstatus').find('option').remove();
                    var _options = "";
                    if ((objdata != undefined) && (objdata.length != 0)) {
                        _options = '<option selected="selected" value="0">--Select Award/Gift --</option>';
                        for (var i = 0; i < objdata.length; i++)
                            _options += "<option value='" + objdata[i].Gift_Pkid + "' onclick>" + objdata[i].GiftName + "</option>";
                        $("select[id$=ddlstatus]").html(_options);
                    }
                }
            });
            $("select[id$=ddlDealer]").html('<option selected="selected" value="0">--Select Dealer--</option>');
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getGiftByCompany",
                data: "{'strType':'dealer'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    var objdata = $.parseJSON(data.d);
                    $('.ddlDealer').find('option').remove();
                    var _options = "";
                    if ((objdata != undefined) && (objdata.length != 0)) {
                        _options = '<option selected="selected" value="0">--Select Dealer --</option>';
                        for (var i = 0; i < objdata.length; i++)
                            _options += "<option value='" + objdata[i].Row_Id + "' onclick>" + objdata[i].Dealer_Name + "</option>";
                        $("select[id$=ddlDealer]").html(_options);
                    }
                }
            });
            $("select[id$=ddlCourierCompany]").html('<option selected="selected" value="0">--Select Company --</option>');
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/getGiftByCompany",
                data: "{'strType':'couriercompany'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    var objdata = $.parseJSON(data.d);
                    $('.ddlCourierCompany').find('option').remove();
                    var _options = "";
                    if ((objdata != undefined) && (objdata.length != 0)) {
                        _options = '<option selected="selected" value="0">--Select Company --</option>';
                        for (var i = 0; i < objdata.length; i++)
                            _options += "<option value='" + objdata[i].CourierPkid + "' onclick>" + objdata[i].Courier_Name + "</option>";
                        $("select[id$=ddlCourierCompany]").html(_options);
                    }
                }
            });

        }

        
        function filldemoalocation() {
            if ($('#ddlservice').val() == "0")
            {
                //alert('Please select service to dispatch award.');
              //  return;
            }
         //   $('#divprogress').show();
          //  var rates = $("input:radio[name=filter]:checked").val()
           // var txtMobile = $('#txtMobile').val();
           // var ddlGift = $('#ddlstatus').val();
            //var all = "0";
            //var Active = "0";
            //var DeActive = "0";
            //var compDelete = "0";
            //if (rates == "All") {
            //    all = "1";
            //}
            //else if (rates == "Activate") {
            //    Active = "1";
            //}
            //else if (rates == "DeActivate") {
            //    DeActive = "1";
            //}
            //else if (rates == "Delete") {
            //    compDelete = "1";
            //}
           // var data = new FormData();
           // data.append("txtMobile", $('#txtMobile').val());
           // data.append("ddlstatus", $('#ddlstatus').val());
            alert$(('#ddlservice').val());
            var newcount = 0;
            debugger;
            $.ajax({
               type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/DispatchGift",
                data: "{'txtMobile':'" + $('#txtMobile').val() + "','ddlstatus':'" + $('#ddlstatus').val() + "', 'ddlService': '" + $('#ddlservice').val() + "' }",//{ 'txtMobile': , 'ddlService': $('#ddlstatus').val() },
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {

                    $('#lblcountLicence').text("0");
                    var objdispachLabelsRecord = $.parseJSON(data.d);
                    if (objdispachLabelsRecord != null)
                    {
                        var trdlrHTML = '';
                        $('#lblcountLicence').text(objdispachLabelsRecord.length);
                        if (objdispachLabelsRecord.length > 0) {
                            $('#GrdCodePrint > tbody').html("");
                            count = 0;
                            for (var i in objdispachLabelsRecord) {
                                // var FSound = "";
                                //var Veri = objdispachLabelsRecord[newcount].Email_Vari_Flag;
                                //var versio = objdispachLabelsRecord[newcount].TypeCmp;
                                // $('#hdnCompanyType').val(versio);
                                // var Doc_Flag = objdispachLabelsRecord[newcount].Name;
                                // var Doc_Flag1 = objdispachLabelsRecord[newcount].Email;
                                // var stat = objdispachLabelsRecord[newcount].Mobile;
                                // var IsRetailer = objdispachLabelsRecord[newcount].Address;
                                // var FPath = "";
                                // var CurrCompID = objdispachLabelsRecord[newcount].Comp_ID;
                                // FPath = "../Data/Sound" + "/" + CurrCompID.substring(5, 9) + "/" + CurrCompID.substring(5, 9) + ".wav";
                                //FSound = fileExists(FPath);
                                trdlrHTML += '<tr class="tr_line1">' +
                                   '<td style="text-align:center">' + (parseInt(newcount) + 1) + '</td>' +
                                  //'<td>' + formatJsonDate(objdispachLabelsRecord[newcount].Reg_Date) + '</td>' +
                                   //'<td>' + formatJsonDate1(objdispachLabelsRecord[newcount].Reg_Date) + '</td>' +
                                 '<td>' + objdispachLabelsRecord[newcount].Pro_Name + '</td>' +
                                 '<td>' + objdispachLabelsRecord[newcount].Email + '</td>' +
                                 '<td>' + objdispachLabelsRecord[newcount].MobileNo + '</td>' +
                                 '<td>' + objdispachLabelsRecord[newcount].Address + ',' + objdispachLabelsRecord[newcount].City + ',' + objdispachLabelsRecord[newcount].PinCode + '</td>' +
                                '<td >' + objdispachLabelsRecord[newcount].GiftName + '</td>';
                                trdlrHTML += '<td style="text-align:center"><input type="checkbox" name="chkStatus" id="chk' + (parseInt(newcount) + 1) + '"  class="childchk" /></td>';
                                trdlrHTML += ' <td style="display:none;">' + objdispachLabelsRecord[newcount].M_Consumer_MCodeid + '</td>  <td style="display:none;">' + objdispachLabelsRecord[newcount].M_Consumerid + '</td>   <td style="display:none;">' + objdispachLabelsRecord[newcount].Gift_Pkid + '</td>   ';
                                newcount++;

                            }
                        }
                        else {
                           // alert('');
                            trdlrHTML += "<tr><td colspan='9' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td></tr>";
                        }
                        $('#GrdCodePrint > tbody').html(trdlrHTML);
                    }
                    else {
                       // alert('');
                        trdlrHTML += "<tr><td colspan='9' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td></tr>";
                        $('#GrdCodePrint > tbody').html(trdlrHTML);
                    }
                   

                }
            });
            $('#divprogress').hide();
        }




    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>
          
            <div class="head_cont">
                <h2 class="courier_dispatch">
                    <table width="99%">
                        <tr>
                            <td width="50%">
                                <%--&nbsp;Courier Dispatch--%>
                                &nbsp;Dispatch Award/Gift by Courier/Dealer
                            </td>
                            <td width="50">
                                <asp:Label ID="lblmsg" runat="server" CssClass="small_font"></asp:Label>
                            </td>
                            <td align="right">
                                <%--<asp:ImageButton ID="imgNew" ToolTip="Add New Courier Dispatch" OnClick="imgNew_Click"
                                    ImageUrl="~/Content/images/add_new.png" runat="server" CausesValidation="false" />--%>
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>
           
            </div>
            <div id="newMsg" runat="server">
                <p>
                    <asp:Label ID="lblmsgHeader" runat="server"></asp:Label>
                </p>
            </div>

            <asp:Panel ID="PnlDefault" runat="server"  >
                <fieldset class="field_profile">
                    <legend>
                        <asp:Label ID="Label3" runat="server" Text="Search"></asp:Label></legend>
                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                        <tr>
                            <td align="justify" style="width: 9%;">
                                <%-- <asp:TextBox ID="txtMobile" runat="server" CssClass="reg_txt" placeholder="MobileNo"></asp:TextBox>--%>
                                <select id="ddlService" class="reg_txt">
                                    <option selected="selected" value="">Select Service</option>
                                    <option value="SRV1001">Build Loyalty</option>
                                    <option value="SRV1006">Raffle Scheme</option>
                                    <option value="SRV1020">Referral</option>
                                </select>
                            </td>
                            <td align="justify" style="width: 9%;">
                                <select id="ddlstatus" class="reg_txt">
                                    <option selected="selected" value="--Status--">Select Award/Gift</option>
                                    <%-- <option value="1">Activated</option>
                            <option value="0">Not Activated</option>--%>
                                </select>
                                <%--  <asp:DropDownList ID="ddlDeliveryBy" runat="server" CssClass="reg_txt" AutoPostBack="true">
                                    <asp:ListItem Value="Courier">Courier</asp:ListItem>
                                    <asp:ListItem Value="Dealer">Dealer</asp:ListItem>
                                </asp:DropDownList>--%>
                            </td>
                            <td align="justify" style="width: 9%;">
                                <input type="text" id="txtMobile" placeholder="Mobile" class="reg_txt" />
                                <%--<asp:TextBox ID="txtSearchName" runat="server" CssClass="reg_txt" placeholder="Award Name"></asp:TextBox>--%>
                            </td>

                            <td align="left" width="12%">
                                <div class="merg_btn">
                                    <%--<asp:ImageButton ID="BtnSearch"  runat="server" ImageUrl="~/Content/images/search_rec.png"
                                         ToolTip="Search" />
                                    <asp:ImageButton ID="BtnRefesh" runat="server" ImageUrl="~/Content/images/reset.png" 
                                        ToolTip="Refresh" />--%>
                                    <img src="../Content/images/search_rec.png" style="cursor: pointer" onclick="return filldemoalocation();" />
                                    <img src="../Content/images/reset.png" style="cursor: pointer" onclick="return resetdata();" />
                                </div>
                            </td>
                        </tr>
                    </table>
                </fieldset>
            </asp:Panel>

           
                <div class="grid_container"  >
                    <h4>
                        <table width="100%" cellpadding="0" cellspacing="0">
                            <tr>
                                <td width="6%" align="center">
                                    <img src="../Content/images/regis_pro.png" alt="products" />
                                </td>
                                <td class="bord_right">
                                    <asp:Label ID="lblGridHeaderText" runat="server" Text="Record(s) found"></asp:Label>
                                    <span class="small_font">( <label id="lblcountLicence" >0</label>)</span>
                                </td>
                                <td align="right">
                                    <asp:Label ID="lbltotal" CssClass="small_font" runat="server"></asp:Label>
                                </td>
                                <td align="right" style="padding-right: 20px; display: none;">
                                    <asp:Label ID="lblrecpayment" Style="font-family: Verdana; font-size: 12px; color: Black;"
                                        Text="Payment Received: " CssClass="small_font" runat="server"></asp:Label>
                                    &nbsp;
                                    <asp:Label ID="lbltotalpay" Style="font-family: Verdana; font-size: 12px; color: Red;"
                                        CssClass="small_font" runat="server"></asp:Label>
                                </td>
                            </tr>
                        </table>
                    </h4>
                      <div style="line-height: 25px;overflow : auto ;max-height: 600px;">
                    <table id="GrdCodePrint"  width="100%" cellspacing="0" cellpadding="0" class="grid" ><%--class="table table-striped table-bordered table-hover"--%>

                                        <thead>
                                            <tr>
                                                <th class="tr_haed" align="justify">S.No</th>
                                                <th class="tr_haed" align="justify">Name</th>
                                                <th class="tr_haed" align="justify">Email</th>
                                                <th class="tr_haed" align="justify">Mobile</th>
                                                <th align="justify" class="tr_haed">Address</th>

                                                <th class="tr_haed" align="justify">Award/Gift<th align="justify" class="tr_haed">
                                                    <input type="checkbox" name="name" value="" id="chkmaster" class="ckhmaster" onchange="checkAll(this);" />
                                                    Select All</th>
                                                </th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                        </tbody>
                                    </table>
                          </div>
                </div>
           
           
                <fieldset class="Newfield Newfield_width">
                    <legend>
                        <span id="ctl00_ContentPlaceHolder1_Labeldd">Dispatch Info</span>
                    </legend>
                    <table width="100%">
                        <tr>
                            <td align="right"> <strong><span class="astrics"></span>Select Type :</strong></td>
                            <td><table >
                       
                            <tr style="height: 20px;">
                               <%-- <td  align="right">
                                    <strong><span class="astrics"></span>Select Type :</strong>
                                   


                                </td>--%>
                                <td>
                                   <%-- <asp:RadioButton Text="Courier" runat="server" ID="RadioButton1"  GroupName="kk" />
                                    <asp:RadioButton Text="Dealer" runat="server" ID="RadioButton2" GroupName="kk"  />--%>
                                    <input type="radio" name="group1" id="Dealer1" value="Dealer" checked="checked"  onclick="showtbl();" " >Dealer
                                    <input type="radio" name="group1" id="Courier1" onclick="showtbl();"  value="Courier" >Courier
                                    
                                </td>
                            </tr>
                           </table></td>
                        </tr>
                        <tr>
                           
                            <td colspan="2"><table width="100%" >
                            <tr style="height: 20px;" id="trDealer">
                                 <td width="10%" align="right"></td>
                                <td style="width:60%">
                                    <table width="100%" cellpadding="0" cellspacing="2" class="tab_regis" id="tblDealer">
                                        <tr>
                                            <td width="20%" align="right">
                                                  <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="DDLCourierCompany" InitialValue="--Select--">
                                                </asp:RequiredFieldValidator>--%>
                                                <strong><span class="astrics">*</span>Select Dealer :</strong>
                                                <%--<span id="ctl00_ContentPlaceHolder1_RequiredFieldValidator12" style="color: Red; visibility: hidden;">its required</span>--%>


                                            </td>
                                            <td width="40%">
                                                <select id="ddlDealer" class="drp">
                                                    <option selected="selected" value="0">Select Dealer</option>
                                                </select>
                                            </td>
                                        </tr>
                                    </table>
                                </td>
                                
                            </tr>
                               </table></td>
                        </tr>
                        <tr>
                            <td colspan="2"><table width="100%" >
                            <tr style="height: 20px;" id="trcourier" >
                             <td width="20%" align="right"></td>
                                <td style="width:80%" >
                                    <table width="100%" cellpadding="0" cellspacing="2" class="tab_regis" id="tblCourier">
                                       
                                        <tr>
                                            <td width="20%"  align="right">
                                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="DDLCourierCompany" InitialValue="--Select--">
                                                </asp:RequiredFieldValidator>--%>
                                                <strong><span class="astrics">*</span>Courier Company :</strong>
                                            </td>
                                            <td width="50%" >
                                               <%-- <asp:DropDownList ID="DDLCourierCompany" runat="server" >
                                                </asp:DropDownList>--%>
                                                <select id="ddlCourierCompany" class="drp">
                                                    <option selected="selected" value="0">Select Courier Company</option>
                                                </select>
                                            </td>
                                           
                                        </tr>
                                        <%--<tr>
                                            <td align="right">
                                               
                                                <strong><span class="astrics">*</span>Tracking No. :</strong>
                                            </td>
                                            <td>                                              
                                                  <input type="text" id="txtTrackingNo"  maxlength="50"  class="textbox_pop"  onchange="javascript:CheckTrackingNo(this.value);" />
                                            </td>
                                        </tr>--%>
                                        <tr>
                                            <td align="right">                                               
                                            </td>
                                            <td>
                                                <asp:Label ID="Label5" runat="server" ForeColor="Red" ></asp:Label>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="txtDispatchDate">
                                                </asp:RequiredFieldValidator>--%>
                                                <strong><span class="astrics">*</span>Dispatch Date :</strong>
                                            </td>
                                            <td>
                                              <%--  <asp:TextBox ID="txtDispatchDate" runat="server" CssClass="textbox_pop" onchange="ChkDate(this.value)"
                                                    onkeydown="return checkShortcut();"></asp:TextBox>--%>
                                                <div id="datepicker456">
                                                <input type="text" id="txtDispatchDate"   class="textbox_pop"  name="start" /><%--onchange="ChkDate(this.value)" onkeydown="return checkShortcut();"--%>
                                                    </div>
                                            </td>
                                        </tr>
                                        <tr>
                                            <td align="right">
                                                <%--<asp:CompareValidator ID="CompareValidator2" runat="server" ValidationGroup="PRO"
                                                    ForeColor="Red" ControlToCompare="txtDispatchDate" ControlToValidate="txtExpectedDate"
                                                    Operator="GreaterThanEqual" Type="Date" Text="Invalid date!"></asp:CompareValidator>--%>
                                                <%--<asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ForeColor="Red"
                                                    ValidationGroup="PR1" ControlToValidate="txtExpectedDate">
                                                </asp:RequiredFieldValidator>--%>
                                                <strong><span class="astrics">*</span>Expected Date :</strong>
                                            </td>
                                            <td>
                                                <%--<asp:TextBox ID="txtExpectedDate" runat="server" CssClass="textbox_pop" onkeydown="return checkShortcut();"></asp:TextBox>--%>
                                                <div id="datepicker123">
                                                 <input type="text" id="txtExpectedDate"   class="textbox_pop" name="end"   /><%--onkeydown="return checkShortcut();"--%>
                                                    </div>
                                            </td>
                                        </tr>
                                      <%--  <tr>
                                            <td colspan="2">
                                                 <cc1:CalendarExtender ID="CalendarExtenderdatefrom" runat="server" TargetControlID="txtDispatchDate"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtenderdatefrom" runat="server" TargetControlID="txtDispatchDate"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtenderdatefrom" runat="server"
                                        TargetControlID="txtDispatchDate" WatermarkText="Date From....">
                                    </cc1:TextBoxWatermarkExtender>
                                    <cc1:CalendarExtender ID="CalendarExtender1to" runat="server" TargetControlID="txtExpectedDate"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender1to" runat="server" TargetControlID="txtExpectedDate"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1to" runat="server" TargetControlID="txtExpectedDate"
                                        WatermarkText="Date To....">
                                    </cc1:TextBoxWatermarkExtender>
                                            </td>
                                        </tr>--%>
                                      <%--  <tr>
                                            <td align="right">
                                          
                                                <strong><span class="astrics">*</span>Dispatch Location :</strong>
                                            </td>
                                            <td>
                                              
                                                <textarea id="txtDispLocation" rows="5" cols="3"  > </textarea>
                                            </td>
                                        </tr>--%>
                                    </table>
                                  <%--  <cc1:CalendarExtender ID="CalendarExtender4" TargetControlID="txtDispatchDate" runat="server"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                  
                                    <cc1:CalendarExtender ID="CalendarExtender5" TargetControlID="txtExpectedDate" runat="server"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>--%>
                                </td>
                                              
                            </tr>
                        
                    </table></td>
                        </tr>
                    </table>
                    
                        
                             
                    </fieldset>
           
                            <div class="regis_popup">
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="left" style="padding-left: 8px;"></td>
                                        <td align="right" style="padding-right: 8px;">&nbsp;&nbsp;
                                            <%--<asp:Button ID="Button1" ValidationGroup="PR1" CssClass="button_all" runat="server" Text="Save" />--%>
                                            <input type="button" name="name"  id="btnSave" value="Save" class="button_all"  onclick ="UpdatePage(); return false"  /> &nbsp;&nbsp;
                                            <asp:Button ID="Button2" CausesValidation="false" CssClass="button_all" runat="server" Text="Cancel" OnClick="Button2_Click" />
                                        </td>
                                    </tr>
                                </table>
                                
                            </div>
                       
        </ContentTemplate>
    </asp:UpdatePanel>
</asp:Content>


