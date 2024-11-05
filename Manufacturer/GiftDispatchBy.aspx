<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true"
    Title="Courier Dispatch" CodeFile="GiftDispatchBy.aspx.cs" Inherits="GiftDispatchBy" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(15).addClass("active");
            $(".accordion2 div.open").eq(11).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
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
                document.getElementById("btnCourierSubmit.ClientID").className = "btn btn-primary float-right mb-5";

            }
            else {
                document.getElementById("lbltrackduplicate.ClientID").innerHTML = "";
                document.getElementById("btnCourierSubmit.ClientID").disabled = false;
                document.getElementById("btnCourierSubmit.ClientID").className = "btn btn-primary float-right mb-5";
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
           
        //    $('#<=Courier1.ClientID%>''#ctl00_ContentPlaceHolder1_btnCourier').hide();
            $('#tblCourier').hide();
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
       
        function showtbl() {
            //var chk1 = $('#ctl00_ContentPlaceHolder1_Courier1').is(":checked");
            var chk1 = $('#<%=Courier1.ClientID%>').is(":checked");
            if (chk1 == true)
            {
                $('#trDealer').hide();
                $('#trDealer1').hide();
                $('#tblCourier').show();
                $('#tblCourier1').show();
                $('#tblCourier2').show();
                $('#ctl00_ContentPlaceHolder1_btnDealer').hide();
                $('#ctl00_ContentPlaceHolder1_btnCourier').show();
            }
            var chk2 = $('#<%=Dealer1.ClientID%>').is(":checked");
            //var chk2 = $('#ctl00_ContentPlaceHolder1_Dealer1').is(":checked");
           // alert(chk2);
            if (chk2 == true) {
                $('#trDealer').show();
                $('#trDealer1').show();
               // $('#trCourier').hide();
                $('#tblCourier').hide();
                $('#tblCourier1').hide();
                $('#tblCourier2').hide();
                $('#ctl00_ContentPlaceHolder1_btnDealer').show();
                $('#ctl00_ContentPlaceHolder1_btnCourier').hide();
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
  <%--  <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
            <%--<asp:UpdateProgress ID="UpdateProgress1" AssociatedUpdatePanelID="UpdatePanel1" runat="server"
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
            </asp:UpdateProgress>--%>
     <div class="col-lg-9">

        <div class="sort-destination-loader sort-destination-loader-showing">
            <div class="row portfolio-list sort-destination" data-sort-id="portfolio">
            <div class="col-lg-12 card card-admin form-wizard profile">
                <header class="card-header">
                                <h4 class="card-title"><i class="fa fa-pencil-square-o">Dispatch by Courier/Dealer</i></h4>
                            </header>

            <div id="newMsg" runat="server">
                <p>
                    <asp:Label ID="lblmsgHeader" runat="server"></asp:Label>
                </p>
            </div>

                <div class="card-body card-body-nopadding">
                     <div class="form-row">
                         <span class="req">*</span><label>Mandatory to select</label>
                     </div>
                    <div class="form-row">
                        <div class="form-group col-lg-4">
                            <asp:DropDownList ID="ddlcompname" runat="server" CssClass="reg_txt" AutoPostBack="false"
                               Visible="false" />
                          <asp:DropDownList runat="server" CssClass="form-control form-control-sm" ID="ddlService" AutoPostBack="True" OnSelectedIndexChanged="ddlService_SelectedIndexChanged">
                                <asp:ListItem Selected="True" Value="">Select Service</asp:ListItem>
                                <asp:ListItem Value="SRV1001">Build Loyalty</asp:ListItem>
                                <asp:ListItem Value="SRV1006">Raffle Scheme</asp:ListItem>
                                <asp:ListItem Value="SRV1020">Referral</asp:ListItem>
                            </asp:DropDownList>  <span class="req">*</span>
                            <asp:RequiredFieldValidator ControlToValidate="ddlService" runat="server" ValidationGroup="servss" ForeColor="Red"
                                InitialValue="" />
                        </div>
                        <div class="form-group col-lg-4">
                            <asp:DropDownList ID="ddlproname" runat="server" CssClass="form-control form-control-sm" AutoPostBack="true"
                                OnSelectedIndexChanged="ddlproname_SelectedIndexChanged" />
                        </div>
                        <div class="form-group col-lg-4">
                            <asp:DropDownList ID="ddlAward" runat="server" CssClass="form-control form-control-sm" AutoPostBack="false" />
                        </div>
                    </div>
                    <div class="form-row">
                        <div class="form-group col-lg-4">
                            <asp:TextBox ID="txtMobile" runat="server" CssClass="form-control form-control-sm" placeholder="Mobile No."
                                onkeypress="return isNumberKey(this, event);"></asp:TextBox>
                        </div>
                        <div class="form-group col-lg-4">
                            <asp:ImageButton ID="BtnSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                OnClick="BtnSearch_Click" ToolTip="Search" ValidationGroup="servss" />
                            <asp:ImageButton ID="BtnRefesh" runat="server" ImageUrl="~/Content/images/reset.png" OnClick="BtnRefesh_Click"
                                ToolTip="Refresh" />
                        </div>
                    </div>
                </div>
                </div>
                 <div class="col-lg-12 card card-admin form-wizard medias">
                     <div class="row pb-2 pt-2 background-section-form">
												<div class="col-lg-8">
													<h4 class="mb-0">Record(s) found<span> (<asp:Label ID="lblcount" runat="server"></asp:Label>)</span></h4>
												</div>
                                                <div class="col-lg-2">
                                                     <asp:Label ID="lblToatalCashPoints" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label
                                    ID="lblToatalPoints" runat="server"></asp:Label>
                                                </div>
												<div class="col-lg-2">

													<%--<select class="form-control mb-0">
														<option>25 Rows</option>
														<option>20 Rows</option>
														<option>15 Rows</option>
													</select>--%>
                                                     <asp:DropDownList ID="ddlRowProductCnt" runat="server" AutoPostBack="true"
                                                         Visible="false" >
                                        <asp:ListItem Value="25">25 Rows</asp:ListItem>
                                        <asp:ListItem Value="50">50 Rows</asp:ListItem>
                                        <asp:ListItem Value="100">100 Rows</asp:ListItem>
                                        <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                        <asp:ListItem Value="1000">1000 Rows</asp:ListItem>
                                        <asp:ListItem Value="1001">All Rows</asp:ListItem>
                                    </asp:DropDownList>
												</div>
											</div>
                     <asp:GridView ID="GridView1" runat="server" AutoGenerateColumns="False"
                         CssClass="table table-striped" EmptyDataText="Record Not Found"
                        BorderColor="transparent">
                        <Columns>                            
                          <asp:TemplateField ItemStyle-Width="20px" HeaderStyle-HorizontalAlign="Left" ItemStyle-HorizontalAlign="Left"
                                HeaderStyle-CssClass="tr_haed" ItemStyle-CssClass="pad">
                                <ItemTemplate>                                  
                                     <%#Container.DataItemIndex+1 %>
                                </ItemTemplate>
                                <ItemStyle Width="1%" HorizontalAlign="Center" />
                            </asp:TemplateField>
                            
                            <asp:TemplateField HeaderText="Product Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblCourierName" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify" Width="23%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Email">
                                <ItemTemplate>
                                    <asp:Label ID="lblCourierEmail" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
                                    
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify"  Width="20%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Mobile No">
                                <ItemTemplate>
                                   
                                    <asp:Label ID="lblCDispMobileNo"  runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                                </ItemTemplate>
                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Address">
                                <ItemTemplate>
                                   
                                    <asp:Label ID="lblCDispAddress" runat="server" Text='<%# Bind("Address") %>'></asp:Label>&nbsp;&nbsp;
                                  <%--  <asp:Label ID="Label2"  runat="server" Text='<%# Bind("City") %>'></asp:Label>&nbsp;&nbsp;
                                    <asp:Label ID="Label4"  runat="server" Text='<%# Bind("PinCode") %>'></asp:Label>--%>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                            </asp:TemplateField>
                             <asp:TemplateField HeaderText="Award/Gift">
                                <ItemTemplate>                                   
                                    <asp:Label ID="lblCDispGiftName"  runat="server" Text='<%# Bind("GiftName") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="">
                                <HeaderTemplate>
                                    <asp:CheckBox Text="Select All" runat="server"  id="chkmaster" class="ckhmaster" onchange="checkAll(this);"  />
                                </HeaderTemplate>
                                <ItemTemplate>
                                     <asp:CheckBox Text="" runat="server" name="chkStatus"  id="childchk2" CssClass="childchk" />
                                    <asp:Label ID="M_Consumer_MCodeid" runat="server" Text='<%# Bind("M_Consumer_MCodeid") %>' Visible="false"></asp:Label>
                                    <asp:Label ID="M_Consumerid" runat="server" Text='<%# Bind("M_Consumerid") %>' Visible="false"></asp:Label>
                                     <asp:Label ID="Gift_Pkid" runat="server" Text='<%# Bind("Gift_Pkid") %>' Visible="false"></asp:Label>
                                    <asp:Label ID="SST_id" runat="server" Text='<%# Bind("SST_id") %>' Visible="false"></asp:Label>
                                   
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="12%" />
                            </asp:TemplateField>
                                                        
                        </Columns>                       
                        <EmptyDataRowStyle HorizontalAlign="Center" />
                     <%--   <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                        <RowStyle CssClass="tr_line1" />
                        <AlternatingRowStyle CssClass="tr_line2" />--%>
                    </asp:GridView>
                     </div>
               
            <div class="col-lg-12 card card-admin form-wizard profile">
                <div class="card-body card-body-nopadding">
                    <div class="form-row">
                         <div class="form-group col-lg-6">
                        <span class="req"></span>
                        <label>Dispatch Info</label>
                             </div>
                    </div>
                    <div class="form-row">
                         <div class="form-group col-lg-6">
                         <span class="req">*</span> <label>Select Type</label>
                         <asp:RadioButton Text="Dealer" runat="server" onclick="showtbl();" GroupName="group1" ID="Dealer1"  Checked="true"/>
                                    <asp:RadioButton Text="Courier" runat="server" onclick="showtbl();" GroupName="group1" ID="Courier1" />
                             </div>
                    </div>
                    <div class="form-row" id="trDealer">
                        <div class="form-group col-lg-6">
                            <span class="req">*</span>
                            <label>Select Dealer</label>
                            <asp:DropDownList ID="ddlDealer" runat="server" AutoPostBack="false" CssClass="form-control form-control-sm"></asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorPR2" runat="server" ForeColor="Red" ErrorMessage="*"
                                ValidationGroup="PR2" ControlToValidate="ddlDealer" InitialValue="--Select--">
                            </asp:RequiredFieldValidator>

                        </div>
                      
                    </div>
                    <div class="form-row" id="trDealer1">
                        <div class="form-group col-lg-6"></div>
                        <div class="form-group col-lg-4">
                            <asp:Button ID="btnDealer" ValidationGroup="PR2" CssClass="btn btn-primary float-right mb-0" runat="server" Text="Save" OnClick="Button11_Click" />
                            </div><div class="form-group col-lg-2">
                            <asp:Button ID="Button123" CausesValidation="false" CssClass="btn btn-primary float-right mb-0" runat="server" Text="Cancel" OnClick="Button2_Click1" />
                        </div>
                    </div>
                    <div class="form-row" id="tblCourier" style="display: none;">
                        <div class="form-group col-lg-6">
                            <span class="req">*</span>
                            <label>Courier Company</label>
                            <asp:DropDownList ID="ddlCourierCompany" runat="server" CssClass="form-control form-control-sm">
                            </asp:DropDownList>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ForeColor="Red" ErrorMessage="*"
                                ValidationGroup="PR1" ControlToValidate="ddlCourierCompany" InitialValue="--Select--">
                            </asp:RequiredFieldValidator>
                        </div>
                    </div>
                    <div class="form-row" id="tblCourier1" style="display: none;">
                        <div class="form-group col-lg-6">
                            <span class="req">*</span>
                            <label>Dispatch Date</label>
                            <asp:TextBox ID="txtDispatchDate" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ForeColor="Red"
                                ValidationGroup="PR1" ControlToValidate="txtDispatchDate">
                            </asp:RequiredFieldValidator>
                        </div>
                         <div class="form-group col-lg-6">
                             <span class="req">*</span>
                            <label>Expected Date</label>
                             <asp:TextBox ID="txtExpectedDate" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                              <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ForeColor="Red" ErrorMessage="*"
                                                    ValidationGroup="PR1" ControlToValidate="txtExpectedDate">
                                                </asp:RequiredFieldValidator>
                             
                         </div>
                    </div>
                    <div class="form-row" id="tblCourier2" style="display: none;">
                        
                        <div class="form-group col-lg-6">
                            <asp:CompareValidator ID="CompareValidator2" runat="server" ValidationGroup="PRO"
                                ForeColor="Red" ControlToCompare="txtDispatchDate" ControlToValidate="txtExpectedDate"
                                Operator="GreaterThanEqual" Type="Date" Text="Invalid date!"></asp:CompareValidator>
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
                        </div>
                        <div class="form-group col-lg-4">
                            <asp:Button ID="btnCourier" ValidationGroup="PR1" CssClass="btn btn-primary float-right mb-0" runat="server" Text="Save" OnClick="Button10_Click" />
                            </div><div class="form-group col-lg-2">
                            <asp:Button ID="Button2" CausesValidation="false" CssClass="btn btn-primary float-right mb-0" runat="server" Text="Cancel" OnClick="Button2_Click1" />
                        </div>
                    </div>
            </div>
            </div>
             <asp:Label ID="lblCourierId" runat="server" Text="" Visible="false"></asp:Label>
             </div>
         </div>
         </div>
            
           
                           <%-- <div class="regis_popup">
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="left" style="padding-left: 8px;"></td>
                                        <td align="right" style="padding-right: 8px;">&nbsp;&nbsp;
                                           
                                            
                                          
                                            
                                        </td>
                                    </tr>
                                </table>
                                
                            </div>--%>
        <%--</ContentTemplate>
    </asp:UpdatePanel>--%>
</asp:Content>
