<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="Dashboard.aspx.cs" Inherits="Admin_Dashboard" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    
    <script src="js/date.format.js"></script>
    <script src="//cdn.rawgit.com/rainabba/jquery-table2excel/1.1.0/dist/jquery.table2excel.min.js"></script>

    <script type="text/javascript">
        var objdata1 = "";
        var objdata = "";
        var objproductmaster = "";
        var objworkingmaster = "";
        var objlegaldocument = "";
        var objLabelsRecord = "";
        var countLabelsRecord = 0;
        var objRequestedLabels = "";
        var countRequestedLabels = 0;
        var objdispachLabelsRecord = "";
        var countdispachLabelsRecord = 0;
        var countwork = 0;
        var countlegaldoc = 0;
        var html = "";
        var j = 0;
        var k = 0;
        var countpmaster = 0;
        $(document).ready(function () {
            var username = "";
            username = '<%= Session["User_Type"] %>';
            if (username == "") {
                window.location.href = "<%=ProjectSession.absoluteSiteBrowseUrl%>/Info/Login.aspx?Page=Dashboard.aspx&usertype=Admin";
            }
            $('#divprogress').css("display", "block");
            bindpayment();
            bindintrusted();
            bindProductmaster();
            bindworkingmaster();
            bindlegaldocument();
            bindRequestedLabels();
            bindDispachLabelsRecord();

           

            $('#divprogress').css("display", "none");


            
        });

       
        function actionintrusted(id, action) {
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/Upgradeaccount",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var upHTML = data.d;
                    if (upHTML == "yes") {
                        window.location.href = "../Index.aspx?Upg=Yes";;
                    }
                }
            });
        }
        function updateaccount() {
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/Upgradeaccount",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var upHTML = data.d;
                    if (upHTML == "yes") {
                        window.location.href = "../Index.aspx?Upg=Yes";
                    }
                }
            });
        }

        function Export() {
            //$("#Interested").table2excel({
            //    // exclude CSS class
            //    exclude: ".noExl",
            //    name: "Worksheet Name",
            //    filename: "Interested",
            //    fileext: ".xls", // file extension
            //    preserveColors: true
            //});

            $("#legaldocument").table2excel({
                // exclude CSS class
                exclude: ".noExl",
                name: "Worksheet Name",
                filename: "Product",
                fileext: ".xls", // file extension
                preserveColors: true
            });
        };


        function bindpayment() {
            objdata = "";
            var username = '<%= Session["User_Type"] %>';
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/bindpayment",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    objdata = $.parseJSON(data.d);
                    var trpayHTML = '';
                    var totalamount = 0;
                    if (objdata.length > 0) {
                        k = 0;
                        $('#Payment > tbody').html('');
                        for (var ii in objdata) {                          
                            var id = objdata[k].Row_Id;
                            var amount = objdata[k].Req_Amount;
                            var comp = objdata[k].Comp_Name;
                            trpayHTML += '<tr>' +
                            '<td>' + formatJsonDate(objdata[k].Req_Date) + '</td>' +
                            '<td>' + objdata[k].Comp_Name + '</td>' +
                            '<td>' + objdata[k].Bank_Name + '</td>' +
                            '<td>' + objdata[k].PMT + '</td>' +
                            '<td>' + objdata[k].PayMode + '</td>' +
                            '<td>' + objdata[k].Details + '</td>' +
                            '<td>' + objdata[k].Req_Amount + '</td>' +
                            '<td>' + objdata[k].Rec_Amount + '</td>' +
                            '<td>' + objdata[k].Remark + '</td>' +
                            '<td>';
                            if (objdata[k].Flag != 0) {
                                trpayHTML += objdata[k].ReqSt;

                            }
                            if (username == "Admin") {
                                trpayHTML += '<a href="javascript:;"  onclick="return approvepayment(' + id + ',' + amount + ',\'' + comp + '\',\'' + objdata[k].Remark + '\',\'' + objdata[k].Pro_Name + '\',\'' + objdata[k].Comp_ID + '\');"><img src="../Content/images/check_act.png" style="width: 15px" /></a>' +
                                '<a href="javascript:;"  onclick="arejectpayment(' + objdata[k].Row_Id + ',' + amount + ',\'' + comp + '\',\'' + objdata[k].Comp_ID + '\'); return false;"><img src="../Content/images/Erase.png" style="width: 15px; margin-left: 10px" /></a>' +
                                '</td>' +
                                '</tr>';
                            }
                            totalamount = totalamount + parseInt(objdata[0].Req_Amount);
                            //k++;
                        }
                        $('#lbltotalpay').text(totalamount);
                    }
                    else {
                        trpayHTML += "<td colspan='11' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td>";
                    }
                    $('#Label1').text(objdata.length);
                    $('#Payment > tbody').html(trpayHTML);
                }
            });
        }

        function approvepayment(e, amount, name, remark, proname, compid) {
            $.confirm({
                title: 'Confirm!',
                content: 'Are you sure to verify Requested payment Amount <span style="color:blue;" >' + amount + '</span> of <span style="color:blue;" >' + name + '</span> Company !',
                buttons: {
                    confirm: function () {
                        $.confirm({
                            title: 'Details Information',
                            content: 'url:form.html',
                            onContentReady: function () {
                                this.$content.find('label#pname').text(proname);
                                this.$content.find('#preqamount').text(amount);
                                this.$content.find('#premark').text(remark);
                            },
                            boxWidth: '800px',
                            useBootstrap: false,
                            buttons: {
                                sayMyName: {
                                    text: 'Confirm',
                                    btnClass: 'btn-warning',
                                    action: function () {
                                        var input = this.$content.find('input#input-name').val();
                                        var errorText = this.$content.find('.text-danger');
                                        if (input == '') {
                                            errorText.html('<div class="text-danger help-block">Please don\'t keep the Amount field empty OR Integer only<div>').slideDown(200);
                                            return false;
                                        } else if (input < parseInt(amount)) {
                                            errorText.html('<div class="text-danger help-block">Please enter valid pay amount less than requested amount : <b>' + amount + '</b><div>').slideDown(200);
                                            return false;
                                        }
                                        else {
                                            
                                            $.ajax({
                                                type: "POST",
                                                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/paymentverify",
                                                data: "{'id':'" + e + "', 'compid':'" + compid + "', 'payprice':'" + input + "','requiredpayment':'" + amount + "'}",
                                                contentType: "application/json; charset=utf-8",
                                                dataType: "json",
                                                success: function (data) {
                                                    var upHTML = data.d;
                                                    if (upHTML != "") {
                                                        $.alert('Payment request Verify successfully from  <span style="color:blue;" >' + Reg.Comp_Name + ' </span> Company !');
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

        function arejectpayment(e, amount, name, compid) {

            $.confirm({
                title: 'Are you sure to canceled Requested payment Amount <span style="color:blue;" >' + amount + '</span> of <span style="color:blue;" >' + name + '</span> Company !',
                content: 'url:cancilpaymentform.html',
                boxWidth: '800px',
                useBootstrap: false,
                buttons: {
                    sayMyName: {
                        text: 'Confirm',
                        btnClass: 'btn-warning',
                        action: function () {
                            var input = this.$content.find('input#input-name').val();
                            var errorText = this.$content.find('.text-danger');
                            if (input == '') {
                                errorText.html('<div class="text-danger help-block">Please don\'t keep the Remark field empty<div>').slideDown(200);
                                return false;
                            }
                            else {
                                $.ajax({
                                    type: "POST",
                                    url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/rejectpayment",
                                    data: "{'id':'" + e + "', 'compid':'" + compid + "', 'remark':'" + input + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (data) {
                                        var upHTML = data.d;
                                        if (upHTML != "") {
                                            $.alert('Payment request canceled successfully from  <span style="color:blue;" >' + Reg.Comp_Name + ' </span> Company !');
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
            //$.confirm({
            //    title: 'Confirm!',
            //    content: 'Are you sure to cancel this request?',
            //    buttons: {
            //        confirm: function () {
            //            $.ajax({
            //                type: "POST",
            //                url: "/Admin/adminhandeler.asmx/actionintrusted",
            //                data: "{'id':" + e + ",'action':'IntReqCancel'}",
            //                contentType: "application/json; charset=utf-8",
            //                dataType: "json",
            //                success: function (data) {
            //                    var upHTML = data.d;
            //                    if (upHTML == "IntReqCancel") {
            //                        bindintrusted();
            //                        //toastr.success("Interested Request has been accepted successfully !");
            //                    }
            //                }
            //            });
            //            $.alert('Interested Request has been canceled successfully !');
            //        },
            //        cancel: function () {
            //            $.alert('Canceled!');
            //        },
            //    }
            //});

        }

        //function formatJsonDate(jsonDate) {
        //    return (new Date(parseInt(jsonDate.substr(6)))).format("dd/mm/yyyy");
        //}
        function bindintrusted() {
            objdata1 = "";
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/bindintrusted",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    objdata1 = $.parseJSON(data.d);
                    var trHTML = '';
                    j = 0;
                    if (objdata1.length > 0) {
                        $('#Interested > tbody').html('');
                        for (var i in objdata1) {

                            trHTML += '<tr>' +
                            '<td>' + formatJsonDate(objdata1[j].cdate) + '</td>' +
                            '<td>' + objdata1[j].cname + '</td>' +
                            '<td>' + objdata1[j].cpersob + '</td>' +
                            '<td>' + objdata1[j].cmobile + '</td>' +
                            '<td>' + objdata1[j].cemail + '</td>' +
                            '<td>' + objdata1[j].ReqStFlag + '</td>' +
                            '<td class="noExl">' +
                            '<a href="javascript:;"  onclick="approveinterust(' + objdata1[j].id + '); return false;"><img src="../Content/images/check_act.png" style="width: 15px" /></a>' +
                            '<a href="javascript:;"  onclick="arejectinterust(' + objdata1[j].id + '); return false;"><img src="../Content/images/Erase.png" style="width: 15px; margin-left: 10px" /></a>' +
                            '</td>' +
                            '</tr>';
                            j++;
                        }
                    }
                    else {
                        trHTML += "<td colspan='7' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td>";
                    }
                    $('#Interestedcount').text(objdata1.length);
                    $('#Interested > tbody').html(trHTML);
                }
            });
        }

        function approveinterust(e) {
            $.confirm({
                title: 'Confirm!',
                content: 'Are you sure to accepted this Request?',
                buttons: {
                    confirm: function () {
                        $.ajax({
                            type: "POST",
                            url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/actionintrusted",
                            data: "{'id':" + e + ",'action':'IntReqAccept'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                var upHTML = data.d;
                                if (upHTML == "IntReqAccept") {
                                    bindintrusted();
                                    //toastr.success("Interested Request has been accepted successfully !");
                                }
                            }
                        });
                        $.alert('Interested Request has been accepted successfully !');
                    },
                    cancel: function () {
                        $.alert('Canceled!');
                    },
                }
            });
        }
        function arejectinterust(e) {
            $.confirm({
                title: 'Confirm!',
                content: 'Are you sure to cancel this request?',
                buttons: {
                    confirm: function () {
                        $.ajax({
                            type: "POST",
                            url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/actionintrusted",
                            data: "{'id':" + e + ",'action':'IntReqCancel'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                var upHTML = data.d;
                                if (upHTML == "IntReqCancel") {
                                    bindintrusted();
                                    //toastr.success("Interested Request has been accepted successfully !");
                                }
                            }
                        });
                        $.alert('Interested Request has been canceled successfully !');
                    },
                    cancel: function () {
                        $.alert('Canceled!');
                    },
                }
            });
        }

        function bindProductmaster() {
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/Productmaster",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    objproductmaster = $.parseJSON(data.d);
                    var trproHTML = '';
                    if (objproductmaster.length > 0) {
                        $('#lblProductMaster').text(objproductmaster.length);
                        $('#ProductMaster > tbody').val("");
                        for (var i in objproductmaster) {
                            trproHTML += '<tr>' +
                                '<td>';
                            if (objproductmaster[countpmaster].Email_Vari_flag != 1) {
                                if (objproductmaster[countpmaster].D == "ENo") {
                                    if (objproductmaster[countpmaster].Status == 0) {
                                        trproHTML += '<span style="color:Green">Account de-activate</span>';
                                    }

                                }
                                else if (objproductmaster[countpmaster].D == "EYes") {
                                    trproHTML += '<span style="color:Maroon">Documents not-verified </span>';
                                }
                                else {
                                    trproHTML += '<span style="color:Red">Profile Not Update or Documents Not-Uploaded</span>';
                                }
                            }
                            else {
                                trproHTML += '<span style="color:Red">E-mail verification pending</span>';
                            }
                            trproHTML += '</td>' +
                             '<td>' + formatJsonDate(objproductmaster[countpmaster].Reg_Date) + '</td>' +
                             '<td>' + objproductmaster[countpmaster].Comp_Name + '</td>' +
                             '<td>' + objproductmaster[countpmaster].Comp_Email + '</td>' +
                             '<td>' + objproductmaster[countpmaster].Contact_Person + '</td>' +
                             '<td>' + objproductmaster[countpmaster].Mobile_No + '</td>' +
                             '<td>' + objproductmaster[countpmaster].TypeCmp + '</td>';
                            if (objproductmaster[countpmaster].SoundPath != 0) {
                                //trproHTML += '<td><a href=' + objproductmaster[countpmaster].SoundPath + ' class="sm2_link" target="_blank"><img alt="" src="../Content/images/Verify.png" height="14px" width="14px" title="Sound" /></a></td>';
                                trproHTML += '<td><audio controls="controls"><source src="<%=ProjectSession.absoluteSiteBrowseUrl%>\\Data\\Data\\' + objproductmaster[countpmaster].SoundPath + '" type="audio/mp3" /></audio></td>';
                            }
                            else {
                                trproHTML += '<td><img alt="" src="../Content/images/VolumeN.png" height="14px" width="14px" title="Sound not uploaded" /></td>';
                            }
                            '</tr>';
                            countpmaster++;
                        }
                    }
                    else {
                        trproHTML += "<td colspan='8' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td>";
                    }
                    $('#ProductMaster > tbody').append(trproHTML);
                }
            });
        }

        function bindworkingmaster() {
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/working",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    objworkingmaster = $.parseJSON(data.d);
                    var trworkHTML = '';
                    if (objproductmaster.length > 0) {
                        $('#lblworking').text(objworkingmaster.length);
                        $('#working > tbody').val("");
                        for (var i in objworkingmaster) {
                            trworkHTML += '<tr>' +
                                '<td>';
                            if (objworkingmaster[countwork].P > 0) {
                                if ((objworkingmaster[countwork].Sound_Flag == 1) && (objworkingmaster[countwork].Doc_Flag == 1)) {
                                    if (objworkingmaster[countwork].R == 2) {
                                        trworkHTML += '<span style="color:Green">Request Pending</span>';
                                    }
                                    else if (objworkingmaster[countwork].R == 3) {
                                        trworkHTML += '<span style="color:Green">Request canceled by admin  </span>';
                                    }
                                    else if (objworkingmaster[countwork].R == 4) {
                                        trworkHTML += '<span style="color:Green">Label print request not send</span>';
                                    }
                                }

                                else if ((objworkingmaster[countwork].Sound_Flag == 1) && (objworkingmaster[countwork].Doc_Flag == 0)) {
                                    trworkHTML += '<span style="color:Maroon">Sound file verified & document not-verified</span>';
                                }
                                else if ((objworkingmaster[countwork].Sound_Flag == 1) && (objworkingmaster[countwork].Doc_Flag == -1)) {
                                    trworkHTML += '<span style="color:Maroon">Sound file verified & document cenceled</span>';
                                }
                                else if ((objworkingmaster[countwork].Sound_Flag == 0) && (objworkingmaster[countwork].Doc_Flag == -1)) {
                                    trworkHTML += '<span style="color:Maroon">Sound file not-verified & document cenceled</span>';
                                }
                                else if ((objworkingmaster[countwork].Sound_Flag == 0) && (objworkingmaster[countwork].Doc_Flag == -1)) {
                                    trworkHTML += '<span style="color:Maroon">Sound file not-verified & document verified</span>';
                                }
                                else if ((objworkingmaster[countwork].Sound_Flag == 0) && (objworkingmaster[countwork].Doc_Flag == 0)) {
                                    trworkHTML += '<span style="color:Maroon">Sound & document file verification pending</span>';
                                }
                                else if ((objworkingmaster[countwork].Sound_Flag == -1) && (objworkingmaster[countwork].Doc_Flag == 0)) {
                                    trworkHTML += '<span style="color:Maroon">Sound file canceled & document verification pending</span>';
                                }
                                else if ((objworkingmaster[countwork].Sound_Flag == -1) && (objworkingmaster[countwork].Doc_Flag == 1)) {
                                    trworkHTML += '<span style="color:Maroon">Sound file canceled & document verified</span>';
                                }
                                else {
                                    trworkHTML += '<span style="color:Maroon">Sound & document upload again</span>';
                                }
                            }
                            else {
                                trworkHTML += '<span style="color:Red">Product not-registered</span>';
                            }
                            trworkHTML += '</td>' +
                             '<td>' + formatJsonDate(objworkingmaster[countwork].Reg_Date) + '</td>' +
                             '<td>' + objworkingmaster[countwork].Comp_Name + '</td>' +
                             '<td>' + objworkingmaster[countwork].Comp_Email + '</td>' +
                             '<td>' + objworkingmaster[countwork].Contact_Person + '</td>' +
                             '<td>' + objworkingmaster[countwork].Mobile_No + '</td>';
                            '</tr>';
                            countwork++;
                        }
                    }
                    else {
                        trworkHTML += "<td colspan='6' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td>";
                    }
                    $('#working > tbody').append(trworkHTML);
                }
            });
        }

        function gettexdetails(proid, compid) {
            


        }

        var counttaxdetails1 = 0;
        var strCompanyName = '';
        function taxdetails(proid, productname, compid) {
            $.confirm({
                title: 'Tax Details',
                content: 'url:approvedoc.html',
                onContentReady: function () {
                    $.ajax({
                        type: "POST",
                        url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/taxdata",
                        data: "{'id':'" + proid + "', 'compid':'" + compid + "'}",
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: function (data) {
                            //alert(data);
                            //alert(" alert(data);" + "   " + data[0][1]);
                            //alert(data[0][0]);
                            var taxdata = "";
                            taxdata = $.parseJSON(data.d);
                           // alert(taxdata);
                             //alert("parseJSON;" + "   " + taxdata[0].Comp_Name);
                             //alert("parseJSON;" + "   " + taxdata[0]);
                             if (taxdata != "") {
                                 strCompanyName = taxdata[counttaxdetails1].Comp_Name;
                                $('#ddlcompidfortax').text(taxdata[counttaxdetails1].Comp_Name);
                                $('#lblcompcat').text(taxdata[counttaxdetails1].Category_Name);
                                $('#lblAddress').text(taxdata[counttaxdetails1].Dispatch_Location);
                            }
                        }
                    });
                },
                boxWidth: '800px',
                useBootstrap: false,
                buttons: {
                    sayMyName: {
                        text: 'Confirm',
                        btnClass: 'btn-warning',
                        action: function () {
                            
                            var lbltax = $('#txtLabelServiceTax').val();
                            var lblvat = $('#txtLabelVAT').val();
                            var servtax = $('#txtAmcServiceTax').val();
                            var servvat = $('#txtAMCVATx').val();
                            var errorText = this.$content.find('.text-danger');
                            if (lbltax == '') {
                                errorText.html('<br><div class="text-danger help-block" style="color:Red">Please don\'t keep the Lable Service Tax field empty<div>').slideDown(200);
                                return false;
                            } else if (lblvat == '') {
                                errorText.html('<br><div class="text-danger help-block" style="color:Red">Please don\'t keep the Lable Vat field empty<div>').slideDown(200);
                                return false;
                            } else if (servtax == '') {
                                errorText.html('<br><div class="text-danger help-block" style="color:Red">Please don\'t keep the Service Service Tax field empty<div>').slideDown(200);
                                return false;
                            } else if (servvat == '') {
                                errorText.html('<br><div class="text-danger help-block" style="color:Red">Please don\'t keep the Service Vat field empty<div>').slideDown(200);
                                return false;
                            }
                            else {
                                
                                $.ajax({
                                    type: "POST",
                                    url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/savetaxsetting",//$('#ddlcompidfortax').val() change by shweta
                                    data: "{'proid':'" + proid + "', 'productname':'" + productname + "', 'compid':'" + compid + "','compname':'" + strCompanyName + "','ltax':'" + $('#txtLabelServiceTax').val() + "', 'lvat':'" + $('#txtLabelVAT').val() + "', 'stax':'" + $('#txtAmcServiceTax').val() + "','svat':'" + $('#txtAMCVATx').val() + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (data) {
                                        var taxresult = data.d;
                                        if (taxresult != "") {
                                            $.alert(taxresult);
                                            bindlegaldocument();
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
        }
        function isNumberKey(sender, evt) {
            var txt = sender.value;
            var dotcontainer = txt.split('.');
            var charCode = (evt.which) ? evt.which : event.keyCode;
            if (!(dotcontainer.length == 1 && charCode == 46) && charCode > 31 && (charCode < 48 || charCode > 57))
                return false;

            return true;
        }
//        function bindlegaldocument() {
//         $.confirm({
//                        title: 'Confirm!',
//                        content: "Confirm1",
//                        buttons: {
//                            confirm: function () {

//                                $.ajax({
//                                                    type: "POST",
//                                                    url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/legaldocument",
//                                                    data: "{}",
//                                                    contentType: "application/json; charset=utf-8",
//                                                    dataType: "json",
//                                                    success: function (data) {
//                                                        
//                                                        objlegaldocument = $.parseJSON(data.d);
//                                                        countlegaldoc = 0;
//                                                        var trproHTML = '';
//                                                        if (objlegaldocument.length > 0) {
//                                                            $('#legaldocument > tbody').html("");
//                                                            for (var i in objlegaldocument) {
//                                                                trproHTML += '<tr>' +
//                                                                 '<td>' + formatJsonDate(objlegaldocument[countlegaldoc].Entry_Date) + '</td>' +
//                                                                 '<td>' + objlegaldocument[countlegaldoc].Comp_Name + '</td>' +
//                                                                 '<td>' + objlegaldocument[countlegaldoc].Pro_Name + '</td>' +
//                                                                 '<td><audio controls="controls"><source src=' + objlegaldocument[countlegaldoc].SoundPath + ' type="audio/wav" /></audio></td>' +
//                                                                 //'<td><a href=' + objlegaldocument[countlegaldoc].SoundPath + ' class="sm2_link" target="_blank"><img onclick="playAudio(\'' + objlegaldocument[countlegaldoc].SoundPath + '\')" alt="" src="../Content/images/Verify.png" height="14px" width="14px" title="Sound" /></a></td>' +
//                                                                 '<td><a href=' + objlegaldocument[countlegaldoc].DocPath + ' class="sm2_link" target="_blank">View</a></td>' +
//                                                                 '<td>' + objlegaldocument[countlegaldoc].WAVFILE_ST + '</td>' +
//                                                                 '<td>' + objlegaldocument[countlegaldoc].DOCST + '</td>' +
//                                                                 '<td>';
//                                                                var action = "";
//                                                                var id = "no"; var proid = objlegaldocument[countlegaldoc].Pro_ID; var noofcode = "no";
//                                                                var request_Amout = "no";
//                                                                var compID = objlegaldocument[countlegaldoc].Comp_ID;
//                                                                var proname = objlegaldocument[countlegaldoc].Pro_Name;
//                                                                var compname = objlegaldocument[countlegaldoc].Comp_Name;
//                                                                var labeltype = "no"; var Request_No = "no"; var contactPerson = objlegaldocument[countlegaldoc].Contact_Person;
//                                                                if (objlegaldocument[countlegaldoc].Tax == 0) {
//                                                                    if (objlegaldocument[countlegaldoc].Sound_Flag == 1) {
//                                                                        trproHTML += '<a href="javascript:;"  onclick="taxdetails(\'' + proid + '\',\'' + proname + '\',\'' + compID + '\'); return false;"><img src="../Content/images/Verify.png" title="Verified Sound" style="width: 15px" /></a>';
//                                                                    }
//                                                                    else if (objlegaldocument[countlegaldoc].Sound_Flag == -1) {
//                                                                        trproHTML += '<a href="javascript:;"  onclick="taxdetails(\'' + proid + '\',\'' + proname + '\',\'' + compID + '\'); return false;"><img src="../Content/images/UnVerify.png" title="Sound file Cancel by admin" style="width: 15px" /></a>';
//                                                                    }
//                                                                    else {
//                                                                        trproHTML += '<a href="javascript:;"  onclick="taxdetails(\'' + proid + '\',\'' + proname + '\',\'' + compID + '\'); return false;"><img src="../Content/images/UnVerify_.png" title="Click for Verify Sound" style="width: 15px" /></a>';
//                                                                    }
//                                                                    if (objlegaldocument[countlegaldoc].Doc_Flag == 1) {
//                                                                        trproHTML += '<a href="javascript:;"  onclick="taxdetails(\'' + proid + '\',\'' + proname + '\',\'' + compID + '\'); return false;"><img src="../Content/images/generated_bill.png" title="Verified Documents" style="width: 15px; margin-left: 10px" /></a>';
//                                                                    }
//                                                                    else if (objlegaldocument[countlegaldoc].Doc_Flag == -1) {
//                                                                        trproHTML += '<a href="javascript:;"  onclick="taxdetails(\'' + proid + '\',\'' + proname + '\',\'' + compID + '\'); return false;"><img src="../Content/images/generated_billC.png" title="Document Cancel by admin" style="width: 15px; margin-left: 10px" /></a>';
//                                                                    }
//                                                                    else {
//                                                                        trproHTML += '<a href="javascript:;"  onclick="taxdetails(\'' + proid + '\',\'' + proname + '\',\'' + compID + '\'); return false;"><img src="../Content/images/not_verified.png" title="Click for Verify Documents" style="width: 15px; margin-left: 10px" /></a>';
//                                                                    }
//                                                                }
//                                                                else {
//                                                                    if (objlegaldocument[countlegaldoc].Sound_Flag == 1) {
//                                                                        action = "VerifySound";
//                                                                        trproHTML += '<a href="javascript:;"  onclick="commonmethod(\'' + id + '\',\'' + proid + '\',\'' + noofcode + '\',\'' + request_Amout + '\',\'' + compID + '\',\'' + action + '\',\'' + proname + '\',\'' + compname + '\',\'' + labeltype + '\',\'' + Request_No + '\',\'' + contactPerson + '\'); return false;"><img src="../Content/images/Verify.png" title="Verified Sound" style="width: 15px" /></a>';
//                                                                    }
//                                                                    else if (objlegaldocument[countlegaldoc].Sound_Flag == -1) {
//                                                                        action = "VerifySound";
//                                                                        trproHTML += '<a href="javascript:;"  onclick="commonmethod(\'' + id + '\',\'' + proid + '\',\'' + noofcode + '\',\'' + request_Amout + '\',\'' + compID + '\',\'' + action + '\',\'' + proname + '\',\'' + compname + '\',\'' + labeltype + '\',\'' + Request_No + '\',\'' + contactPerson + '\'); return false;"><img src="../Content/images/UnVerify.png" title="Sound file Cancel by admin" style="width: 15px" /></a>';
//                                                                    }
//                                                                    else {
//                                                                        action = "VerifySound";
//                                                                        trproHTML += '<a href="javascript:;"  onclick="commonmethod(\'' + id + '\',\'' + proid + '\',\'' + noofcode + '\',\'' + request_Amout + '\',\'' + compID + '\',\'' + action + '\',\'' + proname + '\',\'' + compname + '\',\'' + labeltype + '\',\'' + Request_No + '\',\'' + contactPerson + '\'); return false;"><img src="../Content/images/UnVerify_.png" title="Click for Verify Sound" style="width: 15px" /></a>';
//                                                                    }
//                                                                    if (objlegaldocument[countlegaldoc].Doc_Flag == 1) {
//                                                                        action = "VerifyDocuments";
//                                                                        trproHTML += '<a href="javascript:;"  onclick="commonmethod(\'' + id + '\',\'' + proid + '\',\'' + noofcode + '\',\'' + request_Amout + '\',\'' + compID + '\',\'' + action + '\',\'' + proname + '\',\'' + compname + '\',\'' + labeltype + '\',\'' + Request_No + '\',\'' + contactPerson + '\'); return false;"><img src="../Content/images/generated_bill.png" title="Verified Documents" style="width: 15px; margin-left: 10px" /></a>';
//                                                                    }
//                                                                    else if (objlegaldocument[countlegaldoc].Doc_Flag == -1) {
//                                                                        action = "VerifyDocuments";
//                                                                        trproHTML += '<a href="javascript:;"  onclick="commonmethod(\'' + id + '\',\'' + proid + '\',\'' + noofcode + '\',\'' + request_Amout + '\',\'' + compID + '\',\'' + action + '\',\'' + proname + '\',\'' + compname + '\',\'' + labeltype + '\',\'' + Request_No + '\',\'' + contactPerson + '\'); return false;"><img src="../Content/images/generated_billC.png" title="Document Cancel by admin" style="width: 15px; margin-left: 10px" /></a>';
//                                                                    }
//                                                                    else {
//                                                                        action = "VerifyDocuments";
//                                                                        trproHTML += '<a href="javascript:;"  onclick="commonmethod(\'' + id + '\',\'' + proid + '\',\'' + noofcode + '\',\'' + request_Amout + '\',\'' + compID + '\',\'' + action + '\',\'' + proname + '\',\'' + compname + '\',\'' + labeltype + '\',\'' + Request_No + '\',\'' + contactPerson + '\'); return false;"><img src="../Content/images/not_verified.png" title="Click for Verify Documents" style="width: 15px; margin-left: 10px" /></a>';
//                                                                    }
//                                                                }
//                                                                trproHTML += '</td></tr>';
//                                                                countlegaldoc++;
//                                                            }
//                                                        }
//                                                        else {
//                                                            trproHTML += "<td colspan='8' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td>";
//                                                        }
//                                                        $('#lbllegaldocument').text(objlegaldocument.length);
//                                                        $('#legaldocument > tbody').html(trproHTML);
//                                                    }
//                                });
//                                //$.alert('Interested Request has been canceled successfully !');
//                            },
//                            cancel: function () {
//                                $.alert('Canceled!');
//                            },
//                        }
//                    });
//        
//        
//            
//        }
        
        
        
        
        function bindlegaldocument() {
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/legaldocument",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    
                    objlegaldocument = $.parseJSON(data.d);
                    countlegaldoc = 0;
                    var trproHTML = '';
                    if (objlegaldocument.length > 0) {
                        $('#legaldocument > tbody').html("");
                        for (var i in objlegaldocument) {
                            trproHTML += '<tr>' +
                             //'<td>' + formatJsonDate(objlegaldocument[countlegaldoc].Entry_Date) + '</td>' +
                             '<td>' + objlegaldocument[countlegaldoc].Entry_Date + '</td>' +
                             '<td>' + objlegaldocument[countlegaldoc].Comp_Name + '</td>' +
                             '<td>' + objlegaldocument[countlegaldoc].Pro_Name + '</td>' +
                             '<td><audio controls="controls"><source src=' + objlegaldocument[countlegaldoc].SoundPath + ' type="audio/wav" /></audio></td>' +
                             //'<td><a href=' + objlegaldocument[countlegaldoc].SoundPath + ' class="sm2_link" target="_blank"><img onclick="playAudio(\'' + objlegaldocument[countlegaldoc].SoundPath + '\')" alt="" src="../Content/images/Verify.png" height="14px" width="14px" title="Sound" /></a></td>' +
                             '<td><a href=' + objlegaldocument[countlegaldoc].DocPath + ' class="sm2_link" target="_blank">View</a></td>' +
                             '<td>' + objlegaldocument[countlegaldoc].WAVFILE_ST + '</td>' +
                             '<td>' + objlegaldocument[countlegaldoc].DOCST + '</td>' +
                             '<td>';
                            var action = "";
                            var id = "no"; var proid = objlegaldocument[countlegaldoc].Pro_ID; var noofcode = "no";
                            var request_Amout = "no";
                            var compID = objlegaldocument[countlegaldoc].Comp_ID;
                            var proname = objlegaldocument[countlegaldoc].Pro_Name;
                            var compname = objlegaldocument[countlegaldoc].Comp_Name;
                            var labeltype = "no"; var Request_No = "no"; var contactPerson = objlegaldocument[countlegaldoc].Contact_Person;
                            if (objlegaldocument[countlegaldoc].Tax == 0) {
                                if (objlegaldocument[countlegaldoc].Sound_Flag == 1) {
                                    trproHTML += '<a href="javascript:;"  onclick="taxdetails(\'' + proid + '\',\'' + proname + '\',\'' + compID + '\'); return false;"><img src="../Content/images/Verify.png" title="Verified Sound" style="width: 15px" /></a>';
                                }
                                else if (objlegaldocument[countlegaldoc].Sound_Flag == -1) {
                                    trproHTML += '<a href="javascript:;"  onclick="taxdetails(\'' + proid + '\',\'' + proname + '\',\'' + compID + '\'); return false;"><img src="../Content/images/UnVerify.png" title="Sound file Cancel by admin" style="width: 15px" /></a>';
                                }
                                else {
                                    trproHTML += '<a href="javascript:;"  onclick="taxdetails(\'' + proid + '\',\'' + proname + '\',\'' + compID + '\'); return false;"><img src="../Content/images/UnVerify_.png" title="Click for Verify Sound" style="width: 15px" /></a>';
                                }
                                if (objlegaldocument[countlegaldoc].Doc_Flag == 1) {
                                    trproHTML += '<a href="javascript:;"  onclick="taxdetails(\'' + proid + '\',\'' + proname + '\',\'' + compID + '\'); return false;"><img src="../Content/images/generated_bill.png" title="Verified Documents" style="width: 15px; margin-left: 10px" /></a>';
                                }
                                else if (objlegaldocument[countlegaldoc].Doc_Flag == -1) {
                                    trproHTML += '<a href="javascript:;"  onclick="taxdetails(\'' + proid + '\',\'' + proname + '\',\'' + compID + '\'); return false;"><img src="../Content/images/generated_billC.png" title="Document Cancel by admin" style="width: 15px; margin-left: 10px" /></a>';
                                }
                                else {
                                    trproHTML += '<a href="javascript:;"  onclick="taxdetails(\'' + proid + '\',\'' + proname + '\',\'' + compID + '\'); return false;"><img src="../Content/images/not_verified.png" title="Click for Verify Documents" style="width: 15px; margin-left: 10px" /></a>';
                                }
                            }
                            else {
                                if (objlegaldocument[countlegaldoc].Sound_Flag == 1) {
                                    vSound = "Verify Sound";
                                    action = "VerifySound";

                                    trproHTML += '<a href="javascript:;"  onclick="commonmethod(\'' + id + '\',\'' + proid + '\',\'' + noofcode + '\',\'' + request_Amout + '\',\'' + compID + '\',\'' + action + '\',\'' + proname + '\',\'' + compname + '\',\'' + labeltype + '\',\'' + Request_No + '\',\'' + contactPerson + '\'); return false;"><img src="../Content/images/Verify.png" title="Verified Sound" style="width: 15px" /></a>';
                                }
                                else if (objlegaldocument[countlegaldoc].Sound_Flag == -1) {
                                   
                                    vSound = "Verify Sound";
                                    action = "VerifySound";
                                   
                                    trproHTML += '<a href="javascript:;"  onclick="commonmethod(\'' + id + '\',\'' + proid + '\',\'' + noofcode + '\',\'' + request_Amout + '\',\'' + compID + '\',\'' + action + '\',\'' + proname + '\',\'' + compname + '\',\'' + labeltype + '\',\'' + Request_No + '\',\'' + contactPerson + '\'); return false;"><img src="../Content/images/UnVerify.png" title="Sound file Cancel by admin" style="width: 15px" /></a>';
                                }
                                else {
                                    vSound = "Verify Sound";
                                    action = "VerifySound";
                                    trproHTML += '<a href="javascript:;"  onclick="commonmethod(\'' + id + '\',\'' + proid + '\',\'' + noofcode + '\',\'' + request_Amout + '\',\'' + compID + '\',\'' + action + '\',\'' + proname + '\',\'' + compname + '\',\'' + labeltype + '\',\'' + Request_No + '\',\'' + contactPerson + '\'); return false;"><img src="../Content/images/UnVerify_.png" title="Click for Verify Sound" style="width: 15px" /></a>';
                                }
                                if (objlegaldocument[countlegaldoc].Doc_Flag == 1) {
                                    vSound = "Verify Documents";
                                    action = "VerifyDocuments";
                                    trproHTML += '<a href="javascript:;"  onclick="commonmethod(\'' + id + '\',\'' + proid + '\',\'' + noofcode + '\',\'' + request_Amout + '\',\'' + compID + '\',\'' + action + '\',\'' + proname + '\',\'' + compname + '\',\'' + labeltype + '\',\'' + Request_No + '\',\'' + contactPerson + '\'); return false;"><img src="../Content/images/generated_bill.png" title="Verified Documents" style="width: 15px; margin-left: 10px" /></a>';
                                }
                                else if (objlegaldocument[countlegaldoc].Doc_Flag == -1) {
                                    vSound = "Verify Documents";
                                    action = "VerifyDocuments";
                                    vReject = "Reject Sound";
                                    trproHTML += '<a href="javascript:;"  onclick="commonmethod(\'' + id + '\',\'' + proid + '\',\'' + noofcode + '\',\'' + request_Amout + '\',\'' + compID + '\',\'' + action + '\',\'' + proname + '\',\'' + compname + '\',\'' + labeltype + '\',\'' + Request_No + '\',\'' + contactPerson + '\'); return false;"><img src="../Content/images/generated_billC.png" title="Document Cancel by admin" style="width: 15px; margin-left: 10px" /></a>';
                                }
                                else {
                                    vSound = "Verify Documents";
                                    action = "VerifyDocuments";
                                    trproHTML += '<a href="javascript:;"  onclick="commonmethod(\'' + id + '\',\'' + proid + '\',\'' + noofcode + '\',\'' + request_Amout + '\',\'' + compID + '\',\'' + action + '\',\'' + proname + '\',\'' + compname + '\',\'' + labeltype + '\',\'' + Request_No + '\',\'' + contactPerson + '\'); return false;"><img src="../Content/images/not_verified.png" title="Click for Verify Documents" style="width: 15px; margin-left: 10px" /></a>';
                                }
                            }
                            trproHTML += '</td></tr>';
                            countlegaldoc++;
                        }
                    }
                    else {
                        trproHTML += "<td colspan='8' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td>";
                    }
                    $('#lbllegaldocument').text(objlegaldocument.length);
                    $('#legaldocument > tbody').html(trproHTML);
                }
            });
        }
        
        
        
        
//var vSound =" ";   

        
        
//        function commonmethod(id, proid, noofcode, request_Amout, compID, action, proname, compname, labeltype, Request_No, contactPerson) {
//            $('#divprogress').css("display", "block");
//           
//            $.ajax({
//                type: "POST",
//                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/actionmethod",
//                data: "{'id':'" + id + "', 'proid':'" + proid + "', 'noofcode':'" + noofcode + "', 'request_Amout':'" + request_Amout + "', 'compID':'" + compID + "', 'action':'" + action + "', 'proname':'" + proname + "', 'compname':'" + compname + "', 'labeltype':'" + labeltype + "', 'Request_No':'" + Request_No + "', 'contactPerson':'" + contactPerson + "'}",
//                contentType: "application/json; charset=utf-8",
//                dataType: "json",
//                success: function (data) {
//                    var upHTML = data.d;
//                    if (upHTML != "") {
//                        $('#divprogress').css("display", "none")
//                        $.alert(upHTML);
//                        if (action == "VerifyDocuments" || action == "VerifySound") {
//                            bindlegaldocument();
//                        }
//                        if (action == "PrintLabels" || action == "RequestCancel") {
//                            //alert('AlertPrintLabels');
//                            bindRequestedLabels();
//                        }
//                    }
//                }
//            });
//        }
           
        var vReject ="";
            var vSound =" ";   

         function commonmethod(id, proid, noofcode, request_Amout, compID, action, proname, compname, labeltype, Request_No, contactPerson) {
        
          // vSound ="Verify";
           if (action == "VerifySound")
           {
                vSound = "Approve/Reject Sound";
           }
           
           if (action == "VerifyDocuments")
           {
                vSound = "Approve/Reject Documents";
           }
//           if (action == "RejectSound")
//           {
//                vSound = "Reject Sound";
//           }
//           
//           if (action == "RejectDocuments")
//           {
//                vSound = "Reject Documents";
//           }
            if (action == "PrintLabels")
           {
                vSound = "Print Labels";
            }



            if (action == "VerifySound" || action == "VerifyDocuments" ) {
                $.confirm({
                    title: 'Confirm!',
                    content: "Are you sure you want to " + vSound + " for <span style='color:blue;' >" + compname + "  </span>  >>  <span style='color:blue;' > " + proname + " </span> ?</br>" +
                            "  <span>Comments </br><input name='Tax'  id='txtTaxrjt' class='textbox_pop'  type=text/></span> ",
                    buttons: {
                        sayMyName: {
                            text: 'Approve',
                            // btnClass: 'btn-warning',
                            action: function () {
                                $('#divprogress').css("display", "block");
                                $.ajax({
                                    type: "POST",
                                    url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/actionmethodApproveReject",
                                    data: "{'id':'" + id + "', 'proid':'" + proid + "', 'noofcode':'" + noofcode + "', 'request_Amout':'" + request_Amout + "', 'compID':'" + compID + "', 'action':'" + action + "', 'proname':'" + proname + "', 'compname':'" + compname + "', 'labeltype':'" + labeltype + "', 'Request_No':'" + Request_No + "', 'contactPerson':'" + contactPerson + "', 'txtComments':'" + $('#txtTaxrjt').val() + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (data) {
                                        var upHTML = data.d;
                                        if (upHTML != "") {
                                            $('#divprogress').css("display", "none")
                                            $.alert(upHTML);
                                            if (action == "VerifyDocuments" || action == "VerifySound") {
                                                bindlegaldocument();
                                            }
                                            if (action == "PrintLabels" || action == "RequestCancel") {
                                                //alert('AlertPrintLabels');
                                                bindRequestedLabels();
                                            }
                                        }
                                    }
                                });

                            }
                        },
                        sayMyName2: {
                            text: 'Reject',
                            //  btnClass: 'btn-warning',
                            action: function () {
                                $('#divprogress').css("display", "block");
                                $.ajax({
                                    type: "POST",
                                    url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/actionmethodApproveReject",
                                    data: "{'id':'" + id + "', 'proid':'" + proid + "', 'noofcode':'" + noofcode + "', 'request_Amout':'" + request_Amout + "', 'compID':'" + compID + "', 'action':'" + action + "reject', 'proname':'" + proname + "', 'compname':'" + compname + "', 'labeltype':'" + labeltype + "', 'Request_No':'" + Request_No + "', 'contactPerson':'" + contactPerson + "', 'txtComments':'" + $('#txtTaxrjt').val() + "'}",
                                    contentType: "application/json; charset=utf-8",
                                    dataType: "json",
                                    success: function (data) {
                                        var upHTML = data.d;
                                        if (upHTML != "") {
                                            $('#divprogress').css("display", "none")
                                            $.alert(upHTML);
                                            if (action == "VerifyDocuments" || action == "VerifySound") {
                                                bindlegaldocument();
                                            }
                                            //if (action == "PrintLabels" || action == "RequestCancel") {
                                            //    //alert('AlertPrintLabels');
                                            //    bindRequestedLabels();
                                            //}
                                        }
                                    }
                                });

                            }
                        },
                        cancel: function () {
                            $.alert('Canceled!');
                        }
                    }

                });
            }
            else {
                var printLabelOrQrCode = "0";
                var commentsPrintLabels = "Are you sure you want to " + vSound + " for <span style='color:blue;' >" + compname + "  </span>  >>  <span style='color:blue;' > " + proname + " </span> ?";
                if (action == "PrintLabels") {
                    commentsPrintLabels = "Are you sure you want to " + vSound + " for <span style='color:blue;' >" + compname + "  </span>  >>  <span style='color:blue;' > " + proname + " </span> ?" +
                        "<br /> Type :<br />  <input type='radio' name='printlbls' value='1' id='rddidgit' title='Print in Excel' />13 digit codes only<br /><input type='radio' id='rdQrcode' name='printlbls' value='2' title='Print in Pdf' />Qr Code only<br /><input type='radio'id='rddigitQrcode'  name='printlbls' value='3' title='Print in Pdf' /> 13 didgit code & QR code both <br /><input type='radio'id='rddigitQrcode'  name='printlbls' value='5' title='Print in Pdf' /> 13 didgit code  with Image file.  ";
                }
                
                $.confirm({
                    title: 'Confirm!',
                    content: commentsPrintLabels,
                    buttons: {
                        confirm: function () {
                          
                            printLabelOrQrCode = $("input[name='printlbls']:checked").val();
                            if (typeof (printLabelOrQrCode) == "undefined") {
                                $.alert('Please select any Type');
                                return;
                            }
                            $('#divprogress').css("display", "block");
                                
                            $.ajax({
                                type: "POST",
                                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/actionmethod",
                                data: "{'id':'" + id + "', 'proid':'" + proid + "', 'noofcode':'" + noofcode + "', 'request_Amout':'" + request_Amout + "', 'compID':'" + compID + "', 'action':'" + action + "', 'proname':'" + proname + "', 'compname':'" + compname + "', 'labeltype':'" + labeltype + "', 'Request_No':'" + Request_No + "', 'contactPerson':'" + contactPerson + "', 'PrintLabelOrQrcode':'" + printLabelOrQrCode + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) {
                                    var upHTML = data.d;
                                    if (upHTML != "") {
                                        $('#divprogress').css("display", "none")
                                        $.alert(upHTML);
                                        if (action == "VerifyDocuments" || action == "VerifySound") {
                                            bindlegaldocument();
                                        }
                                        if (action == "PrintLabels" || action == "RequestCancel") {
                                            //alert('AlertPrintLabels');
                                            bindRequestedLabels();
                                        }
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
            
        }



        function RequestCancel2(id, proid, noofcode, request_Amout, compID, action, proname, compname, labeltype, Request_No, contactPerson) {
            $.confirm({
                title: 'Confirm!',
                content: "Are you sure you want to cancel label request for <span style='color:blue;' >" + compname + "  </span>  >> " + proname + " >> " + labeltype + "?",
                buttons: {
                    confirm: function () {

                        $('#divprogress').css("display", "block");
                        $.ajax({
                            type: "POST",
                            url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/RequestCancel2",
                            data: "{'id':'" + id + "', 'proid':'" + proid + "', 'noofcode':'" + noofcode + "', 'request_Amout':'" + request_Amout + "', 'compID':'" + compID + "', 'action':'" + action + "', 'proname':'" + proname + "', 'compname':'" + compname + "', 'labeltype':'" + labeltype + "', 'Request_No':'" + Request_No + "', 'contactPerson':'" + contactPerson + "'}",
                            contentType: "application/json; charset=utf-8",
                            dataType: "json",
                            success: function (data) {
                                var upHTML = data.d;
                                if (upHTML != "") {
                                    $('#divprogress').css("display", "none")
                                    $.alert(upHTML);
                                    bindRequestedLabels();
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
        function bindRequestedLabels() {
           
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/RequestedLabels",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                  
                    objRequestedLabels = $.parseJSON(data.d);
                    countRequestedLabels = 0;
                    var trrlHTML = '';
                    if (objRequestedLabels.length > 0) {
                        $('#lblRequestedLabels').text(objRequestedLabels.length);
                        $('#RequestedLabels > tbody').html("");
                        for (var i in objRequestedLabels) {
                          //  alert(objRequestedLabels[countRequestedLabels].Labe_Prise);
                            var id = objRequestedLabels[countRequestedLabels].Row_ID;
                            var proid = objRequestedLabels[countRequestedLabels].Pro_ID;
                            var noofcode = objRequestedLabels[countRequestedLabels].Labels;
                            var request_Amout = objRequestedLabels[countRequestedLabels].Label_Prise;// "no";
                            var compID = objRequestedLabels[countRequestedLabels].Comp_ID;
                            var action = "PrintLabels";
                            var proname = (objRequestedLabels[countRequestedLabels].Pro_Name).trim();
                            var compname = (objRequestedLabels[countRequestedLabels].Comp_Name).trim();
                            var labeltype = (objRequestedLabels[countRequestedLabels].Label_Name).trim();
                            var Request_No = "no";
                            var contactPerson = "no";
                            trrlHTML += '<tr>' +
                               '<td>' + objRequestedLabels[countRequestedLabels].Tracking_No + '</td>' +
                           //  '<td>' + formatJsonDate(objRequestedLabels[countRequestedLabels].Entry_Date) + '</td>' +
                             '<td>' + objRequestedLabels[countRequestedLabels].Entry_Date + '</td>' +
                             '<td>' + objRequestedLabels[countRequestedLabels].Comp_Name + '</td>' +
                             '<td>' + objRequestedLabels[countRequestedLabels].Pro_Name + ' </td>' +
                             '<td>' + objRequestedLabels[countRequestedLabels].Label_Name + '</td>' +
                             '<td>' + objRequestedLabels[countRequestedLabels].Labels + '</td>' +
                             '<td>' + objRequestedLabels[countRequestedLabels].RequestStatusFlag + '</td>';
                            var action = "PrintLabels";
                            trrlHTML += '<td><a href="javascript:;"  onclick="commonmethod(\'' + id + '\',\'' + proid + '\',\'' + noofcode + '\',\'' + request_Amout + '\',\'' + compID + '\',\'' + action + '\',\'' + proname + '\',\'' + compname + '\',\'' + labeltype + '\',\'' + Request_No + '\',\'' + contactPerson + '\'); return false;"><img src="../Content/images/PrintN.png" style="width: 15px" /></a>';
                            var action = "RequestCancel";
                            trrlHTML += '<a href="javascript:;"  onclick="RequestCancel2(\'' + id + '\',\'' + proid + '\',\'' + noofcode + '\',\'' + request_Amout + '\',\'' + compID + '\',\'' + action + '\',\'' + proname + '\',\'' + compname + '\',\'' + labeltype + '\',\'' + Request_No + '\',\'' + contactPerson + '\'); return false;"><img src="../Content/images/Erase.png" style="width: 15px; margin-left: 10px" /></a>' +
                           '</td>' +
                           '</tr>';
                            countRequestedLabels++;
                        }
                    }
                    else {
                        trrlHTML += "<td colspan='8' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td>";
                    }
                    $('#RequestedLabels > tbody').html(trrlHTML);
                }
            });
        }

        function bindDispachLabelsRecord() {
            
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/dispachLabelsRecord",
                data: "{}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    objdispachLabelsRecord = $.parseJSON(data.d);
                    var trdlrHTML = '';
                    if (objdispachLabelsRecord.length > 0) {
                        $('#lbldispachLabelsRecord').text(objdispachLabelsRecord.length);
                        $('#dispachLabelsRecord > tbody').html("");
                        for (var i in objdispachLabelsRecord) {
                            trdlrHTML += '<tr>' +
                              // '<td>' + formatJsonDate(objdispachLabelsRecord[countdispachLabelsRecord].Comp_Name) + '</td>' +
                               '<td>' + objdispachLabelsRecord[countdispachLabelsRecord].Comp_Name + '</td>' +
                             '<td>' + objdispachLabelsRecord[countdispachLabelsRecord].Courier_Name + '</td>' +
                             '<td>' + objdispachLabelsRecord[countdispachLabelsRecord].Tracking_No + '</td>' +
                             '<td>' + formatJsonDate(objdispachLabelsRecord[countdispachLabelsRecord].Dispatch_Date) + ' </td>' +
                             '<td>' + formatJsonDate(objdispachLabelsRecord[countdispachLabelsRecord].Expected_Date) + '</td>' +
                             '<td>' + objdispachLabelsRecord[countdispachLabelsRecord].Dispatch_Location + '</td>' +
                             '<td>' + objdispachLabelsRecord[countdispachLabelsRecord].Qty + '</td>';
                            if (objdispachLabelsRecord[countdispachLabelsRecord].Flag == 0) {
                                trdlrHTML += '<span style="color:Blue">' + objdispachLabelsRecord[countdispachLabelsRecord].Status + '</span>';
                            }
                            else if (objdispachLabelsRecord[countdispachLabelsRecord].Flag == 1) {
                                trdlrHTML += '<span style="color:Green">' + objdispachLabelsRecord[countdispachLabelsRecord].Status + '</span>';
                            }
                            else if (objdispachLabelsRecord[countdispachLabelsRecord].Flag == 2) {
                                trdlrHTML += '<span style="color:Green">' + objdispachLabelsRecord[countdispachLabelsRecord].Status + '</span>';
                                trrlHTML += '<a href="javascript:;"  onclick="dLabelsRecord(' + objdispachLabelsRecord[countdispachLabelsRecord].Courier_Disp_ID + '); return false;"></a>';
                            }
                            else if (objdispachLabelsRecord[countdispachLabelsRecord].Flag == -1) {
                                trdlrHTML += '<span style="color:Red">' + objdispachLabelsRecord[countdispachLabelsRecord].Status + '</span>';
                            }
                            '</tr>';
                            countdispachLabelsRecord++;
                        }
                    }
                    else {
                        trdlrHTML += "<td colspan='8' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td>";
                    }
                    $('#dispachLabelsRecord > tbody').html(trdlrHTML);
                }
            });
        }
        function dLabelsRecord(id) {
            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/dispachLabelsRecord",
                data: "{'lblid':'" + id + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                    var trdlrHTML = '';
                    var objectdata = $.parseJSON(data.d);
                    $('#productGrdCodePrint > tbody').html("");
                    if (objectdata.length > 0) {
                        trdlrHTML += '<tr>' +
                       '<td>' + objectdata[0].Pro_Name + '</td>' +
                        '<td>' + objectdata[0].Label_Name + '</td>' +
                        '<td>' + objectdata[0].Series_From + '</td>' +
                        '<td>' + objectdata[0].Series_To + '</td>' +
                        '<td>' + objectdata[0].Qty + '</td>' +
                        '</tr>';
                    }
                    else {
                        trdlrHTML += "<td colspan='8' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td>";
                    }
                    $('#productGrdCodePrint > tbody').html(trdlrHTML);
                    $('#divproductwise').show();
                }
            });
        }



        //function RequestedLabels() {
        //    
        //    $.ajax({
        //        type: "POST",
        //        url: "<=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/RequestedLabels",
        //        data: "{}",
        //        contentType: "application/json; charset=utf-8",
        //        dataType: "json",
        //        success: function (data) {
        //            objLabelsRecord = $.parseJSON(data.d);
        //            var trlrHTML = '';
        //            if (objLabelsRecord.length > 0) {
        //                $('#lblLabelsRecord').text(objLabelsRecord.length);
        //                $('#LabelsRecord > tbody').val("");
        //                for (var i in objLabelsRecord) {
        //                    trlrHTML += '<tr>' +
        //                       '<td>' + formatJsonDate(objLabelsRecord[countLabelsRecord].Tracking_No) + '</td>' +
        //                     '<td>' + objLabelsRecord[countLabelsRecord].Entry_Date + '</td>' +
        //                     '<td>' + objLabelsRecord[countLabelsRecord].Comp_Name + '</td>' +
        //                     '<td>' + objLabelsRecord[countLabelsRecord].Pro_Name + ' </td>' +
        //                     '<td>' + objLabelsRecord[countLabelsRecord].Label_Name + '</td>' +
        //                     '<td>' + objLabelsRecord[countLabelsRecord].Labels + '</td>' +
        //                     '<td>' + objLabelsRecord[countLabelsRecord].RequestStatusFlag + '</td>';
        //                    if (objLabelsRecord[countLabelsRecord].Sound_Flag == 1) {
        //                        trlrHTML += '<a href="javascript:;"  onclick="RequestedLabels(' + objLabelsRecord[countLabelsRecord].Row_ID + ',"1"); return false;"><img src="../Content/images/check_act.png" style="width: 15px" /></a>';
        //                    }
        //                    else if (objLabelsRecord[countLabelsRecord].Sound_Flag == -1) {
        //                        trlrHTML += '<a href="javascript:;"  onclick="RequestedLabels(' + objLabelsRecord[countLabelsRecord].Row_ID + ',"2"); return false;"><img src="../Content/images/check_act.png" style="width: 15px" /></a>';
        //                    }
        //                    '</tr>';
        //                    countLabelsRecord++;
        //                }
        //            }
        //            else {
        //                trlrHTML += "<td colspan='8' style='text-align: center;color: red;font-size: 18px;'>No Record Found!</td>";
        //            }
        //            $('#LabelsRecord > tbody').append(trlrHTML);
        //        }
        //    });
        //}
        function LabelsRecord(id) {
            var data = confirm("Are you sure to contact this person and verify?");
            if (data == true) {
                alert("verify");
                bindintrusted();
            }
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
                <a href="#">Home</a>
            </li>
            <li class="active">Dashboard</li>
        </ul>
        <!-- /.breadcrumb -->

        <!-- #section:basics/content.searchbox -->
        <!-- /.nav-search -->

        <!-- /section:basics/content.searchbox -->
    </div>
    <div class="page-content">
        <!-- #section:settings.box -->
        <div class="ace-settings-container" id="ace-settings-container">
            <div class="btn btn-app btn-xs btn-warning ace-settings-btn" id="ace-settings-btn">
                <i class="ace-icon fa fa-cog bigger-150"></i>
            </div>

            <div class="ace-settings-box clearfix" id="ace-settings-box">
                <div class="pull-left width-50">
                    <!-- #section:settings.skins -->
                    <div class="ace-settings-item">
                        <div class="pull-left">
                            <select id="skin-colorpicker" class="hide">
                                <option data-skin="no-skin" value="#438EB9">#438EB9</option>
                                <option data-skin="skin-1" value="#222A2D">#222A2D</option>
                                <option data-skin="skin-2" value="#C6487E">#C6487E</option>
                                <option data-skin="skin-3" value="#D0D0D0">#D0D0D0</option>
                            </select>
                        </div>
                        <span>&nbsp; Choose Skin</span>
                    </div>

                    <!-- /section:settings.skins -->

                    <!-- #section:settings.navbar -->
                    <div class="ace-settings-item">
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-navbar" />
                        <label class="lbl" for="ace-settings-navbar">Fixed Navbar</label>
                    </div>

                    <!-- /section:settings.navbar -->

                    <!-- #section:settings.sidebar -->
                    <div class="ace-settings-item">
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-sidebar" />
                        <label class="lbl" for="ace-settings-sidebar">Fixed Sidebar</label>
                    </div>

                    <!-- /section:settings.sidebar -->

                    <!-- #section:settings.breadcrumbs -->
                    <div class="ace-settings-item">
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-breadcrumbs" />
                        <label class="lbl" for="ace-settings-breadcrumbs">Fixed Breadcrumbs</label>
                    </div>

                    <!-- /section:settings.breadcrumbs -->

                    <!-- #section:settings.rtl -->
                    <div class="ace-settings-item">
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-rtl" />
                        <label class="lbl" for="ace-settings-rtl">Right To Left (rtl)</label>
                    </div>

                    <!-- /section:settings.rtl -->

                    <!-- #section:settings.container -->
                    <div class="ace-settings-item">
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-add-container" />
                        <label class="lbl" for="ace-settings-add-container">
                            Inside
										<b>.container</b>
                        </label>
                    </div>

                    <!-- /section:settings.container -->
                </div>
                <!-- /.pull-left -->

                <div class="pull-left width-50">
                    <!-- #section:basics/sidebar.options -->
                    <div class="ace-settings-item">
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-hover" />
                        <label class="lbl" for="ace-settings-hover">Submenu on Hover</label>
                    </div>

                    <div class="ace-settings-item">
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-compact" />
                        <label class="lbl" for="ace-settings-compact">Compact Sidebar</label>
                    </div>

                    <div class="ace-settings-item">
                        <input type="checkbox" class="ace ace-checkbox-2" id="ace-settings-highlight" />
                        <label class="lbl" for="ace-settings-highlight">Alt. Active Item</label>
                    </div>

                    <!-- /section:basics/sidebar.options -->
                </div>
                <!-- /.pull-left -->
            </div>
            <!-- /.ace-settings-box -->
        </div>
        <!-- /.ace-settings-container -->

        <!-- /section:settings.box -->
        <div class="page-content-area">
            <div class="page-header">
                <h1>Dashboard
								<small>
                                    <i class="ace-icon fa fa-angle-double-right"></i>
                                    overview &amp; stats
                                </small>
                </h1>
            </div>
            <!-- /.page-header -->
            

            <div id="Div1" runat="server">

                <div class="row">
                    <div class="col-xs-12">
                        <!-- PAGE CONTENT BEGINS -->

                        <div class="row">
                            <div class="space-6"></div>

                            <div class="col-sm-12 infobox-container">
                                <!-- #section:pages/dashboard.infobox -->
                                <a href="CodeGeneration.aspx">
                                    <div class="infobox infobox-green">
                                        <div class="infobox-icon">
                                            <img src="../Content/images/generate_code_.png" alt="" style="width: 40px" />
                                        </div>
                                        <div class="infobox-data">
                                            <span class="infobox-data-number"></span>
                                            <div class="infobox-content">Code Bank</div>
                                        </div>
                                    </div>
                                </a>
                                <a href="CodeGeneration.aspx">
                                    <div class="infobox infobox-green">
                                        <div class="infobox-icon">
                                            <img src="../Content/images/registered_companies.png" alt="" style="width: 40px" />
                                        </div>
                                        <div class="infobox-data">
                                            <span class="infobox-data-number"></span>
                                            <div class="infobox-content">Company</div>
                                        </div>
                                    </div>
                                </a>
                                <a href="CodeGeneration.aspx">
                                    <div class="infobox infobox-green">
                                        <div class="infobox-icon">
                                            <img src="../Content/images/generate_bill.png" alt="" style="width: 40px" />
                                        </div>
                                        <div class="infobox-data">
                                            <span class="infobox-data-number"></span>
                                            <div class="infobox-content">Bills</div>
                                        </div>
                                    </div>
                                </a>
                                <a href="CodeGeneration.aspx">
                                    <div class="infobox infobox-green">
                                        <div class="infobox-icon">
                                            <img src="../Content/images/payment_h.png" alt="" style="width: 40px" />
                                        </div>
                                        <div class="infobox-data">
                                            <span class="infobox-data-number"></span>
                                            <div class="infobox-content">Payment</div>
                                        </div>
                                    </div>
                                </a>
                                <a href="CodeGeneration.aspx">
                                    <div class="infobox infobox-green">
                                        <div class="infobox-icon">
                                            <img src="../Content/images/Send_Mail.png" alt="" style="width: 40px" />
                                        </div>
                                        <div class="infobox-data">
                                            <span class="infobox-data-number"></span>
                                            <div class="infobox-content">Send Mail</div>
                                        </div>
                                    </div>
                                </a>
                                <a href="CodeGeneration.aspx">
                                    <div class="infobox infobox-green">
                                        <div class="infobox-icon">
                                            <img src="../Content/images/24x24.png" alt="" style="width: 40px" />
                                        </div>
                                        <div class="infobox-data">
                                            <span class="infobox-data-number"></span>
                                            <div class="infobox-content">Courier</div>
                                        </div>
                                    </div>
                                </a>
                                <a href="CodeGeneration.aspx">
                                    <div class="infobox infobox-green">
                                        <div class="infobox-icon">
                                            <img src="../Content/images/prices_h.png" alt="" style="width: 40px" />
                                        </div>
                                        <div class="infobox-data">
                                            <span class="infobox-data-number"></span>
                                            <div class="infobox-content">Bank Account</div>
                                        </div>
                                    </div>
                                </a>
                                <a href="CodeGeneration.aspx">
                                    <div class="infobox infobox-green">
                                        <div class="infobox-icon">
                                            <img src="../Content/images/print.png" alt="" style="width: 40px" />
                                        </div>
                                        <div class="infobox-data">
                                            <span class="infobox-data-number"></span>
                                            <div class="infobox-content">Print</div>
                                        </div>
                                    </div>
                                </a>
                                <a href="CodeGeneration.aspx">
                                    <div class="infobox infobox-green">
                                        <div class="infobox-icon">
                                            <img src="../Content/images/product_enquiry.png" alt="" style="width: 40px" />
                                        </div>
                                        <div class="infobox-data">
                                            <span class="infobox-data-number"></span>
                                            <div class="infobox-content">Enquiry</div>
                                        </div>
                                    </div>
                                </a>
                                <a href="CodeGeneration.aspx">
                                    <div class="infobox infobox-green">
                                        <div class="infobox-icon">
                                            <img src="../Content/images/generate_bill.png" alt="" style="width: 40px" />
                                        </div>
                                        <div class="infobox-data">
                                            <span class="infobox-data-number"></span>
                                            <div class="infobox-content">Grace Period</div>
                                        </div>
                                    </div>
                                </a>
                                <a href="CodeGeneration.aspx">
                                    <div class="infobox infobox-green">
                                        <div class="infobox-icon">
                                            <img src="../Content/images/phone_.png" alt="" style="width: 40px" />
                                        </div>
                                        <div class="infobox-data">
                                            <span class="infobox-data-number"></span>
                                            <div class="infobox-content">Customer Care</div>
                                        </div>
                                    </div>
                                </a>
                                <!-- /section:pages/dashboard.infobox.dark -->
                            </div>
                        </div>
                        <!-- /.row -->
                        <!-- #section:custom/extra.hr -->
                        <div class="hr hr32 hr-dotted"></div>
                    </div>
                    <!-- /.col -->
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="table-header">
                                    <div style="float: left;">
                                        <img src="../Content/images/regis_pro.png" />Payment Request Record(s) found
                                    </div>
                                    <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 30px; width: auto; line-height: 22px;">
                                        <label id="Label1" style="color: #fff;">0</label>
                                    </div>
                                    <div style="float: right">
                                        <div style="float: left;">Payment Requested:</div>
                                        <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 50px; width: auto; line-height: 22px;">
                                            <label id="lbltotalpay" style="color: #fff;">0</label>
                                        </div>
                                    </div>
                                    <%-- <span style="float: left">
                                    <img src="../Content/images/regis_pro.png" />
                                    Payment Request Record(s) found <span class="small_font">(<label id="Label1"
                                        runat="server" style="color: red">0</label>)</span>
                                </span>
                                <span style="float: right; margin-right: 20px;">Payment Requested:<span class="small_font">(<label id="lbltotalpay"
                                    runat="server" style="color: red">0</label>)</span>
                                </span>--%>
                                </div>
                                <table id="Payment" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>Date</th>
                                            <th>Company Name</th>
                                            <th>Bank Name</th>
                                            <th>Payment</th>
                                            <th>Pay Mode</th>
                                            <th>Details</th>
                                            <th>Req. Amount</th>
                                            <th>Rec. Amount</th>
                                            <th>Remarks</th>
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
                    <div class="clearfix" style="margin-bottom: -110px;"></div>

                    <% if (Session["User_Type"] != null)
                       {
                           if (Session["User_Type"].ToString() == "Admin")
                           { %>

                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="table-header">
                                    <div style="float: left;">
                                        <img src="../Content/images/regis_pro.png" />Interested For Demo Record(s) found
                                    </div>
                                    <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 30px; width: auto; line-height: 22px;">
                                        <label id="Interestedcount" style="color: #fff;">0</label>
                                    </div>
                                    <%--<div style="float:right;margin-right:20px;">
                                        <a href="javascript:void(0)" id="btnExport" onclick=" return Export();"><i class="fa fa-file-excel-o" style="color: #fff;font-size: 20px;margin-top: 10px;"></i></a>
                                    </div>--%>
                                </div>
                                <table id="Interested" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>Request Date</th>
                                            <th>Company Name</th>
                                            <th>Contact Person</th>
                                            <th>Mobile No.</th>
                                            <th>E-mail</th>
                                            <th>Status</th>
                                            <th class="noExl">Action</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.span -->
                        </div>
                    </div>

                    <div class="clearfix" style="margin-bottom: 15px;"></div>

                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="table-header">
                                    <div style="float: left;">
                                        <img src="../Content/images/regis_pro.png" />New Registered Companies Record(s) found
                                    </div>
                                    <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 30px; width: auto; line-height: 22px;">
                                        <label id="lblProductMaster" style="color: #fff;">0</label>
                                    </div>
                                </div>
                                <table id="ProductMaster" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>Status</th>
                                            <th>Request Date</th>
                                            <th>Company Name</th>
                                            <th>E-mail</th>
                                            <th>Contact Person</th>
                                            <th>Mobile No.</th>
                                            <th>Type</th>
                                            <th>Sound</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.span -->
                        </div>
                    </div>

                    <div class="clearfix" style="margin-bottom: 15px;"></div>
                    <div class="col-xs-12">
                        <div class="row">

                            <div class="col-xs-12">
                                <div class="table-header">
                                    <div style="float: left;">
                                        <img src="../Content/images/regis_pro.png" />
                                        Working Status Companys Record(s) found
                                    </div>
                                    <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 30px; width: auto; line-height: 22px;">
                                        <label id="lblworking" style="color: #fff;">0</label>
                                    </div>
                                </div>
                                <table id="working" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>Working Status</th>
                                            <th>Request Date</th>
                                            <th>Company Name</th>
                                            <th>E-mail</th>
                                            <th>Contact Person</th>
                                            <th>Mobile No.</th>
                                        </tr>
                                    </thead>
                                    <tbody>
                                    </tbody>
                                </table>
                            </div>
                            <!-- /.span -->
                        </div>
                    </div>


                    <%}
                       } %>
                    <div class="clearfix" style="margin-bottom: 15px;"></div>
                    <div class="col-xs-12">
                        <div class="row">

                            <div class="col-xs-12">
                                <div class="table-header">
                                    <div style="float: left;">
                                        <img src="../Content/images/regis_pro.png" />
                                        Product wise legal document and Sound File Record(s)
                                    </div>
                                    <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 30px; width: auto; line-height: 22px;">
                                        <label id="lbllegaldocument" style="color: #fff;">0</label>
                                    </div>
                                    <div style="float:right;margin-right:20px;">
                                        <a href="javascript:void(0)" id="btnProductExport" onclick=" return Export();"><i class="fa fa-file-excel-o" style="color: #fff;font-size: 20px;margin-top: 10px;"></i></a>
                                    </div>
                                </div>
                                <table id="legaldocument" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>Request Date</th>
                                            <th>Company Name</th>
                                            <th>Product Name</th>
                                            <th>Sound File</th>
                                            <th>Documents</th>
                                            <th>Sound Status</th>
                                            <th>Documents Status</th>
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

                    <div class="clearfix" style="margin-bottom: 15px;"></div>
                    <div class="col-xs-12">
                        <div class="row">
                            <div class="col-xs-12">
                                <div class="table-header">
                                    <div style="float: left;">
                                        <img src="../Content/images/regis_pro.png" />
                                        Labels Request Record(s) found 
                                    </div>
                                    <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 30px; width: auto; line-height: 22px;">
                                        <label id="lblRequestedLabels" style="color: #fff;">0</label>
                                    </div>
                                </div>
                                <table id="RequestedLabels" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>Tracking No.</th>
                                            <th>Request Date</th>
                                            <th>Company Name</th>
                                            <th>Product Name</th>
                                            <th>Labels Info.</th>
                                            <th>No. of Labels</th>
                                            <th>Status</th>
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

                    <div class="clearfix" style="margin-bottom: 15px;"></div>
                    <div class="col-xs-12">
                        <div class="row">

                            <div class="col-xs-12">
                                <div class="table-header">
                                    <div style="float: left;">
                                        <img src="../Content/images/regis_pro.png" />
                                        Dispatch Labels Record(s) found 
                                    </div>
                                    <div style="float: left; background-color: red; font-size: 15px; font-weight: bold; height: 25px; margin: 5px 5px 0px; text-align: center; min-width: 30px; width: auto; line-height: 22px;">
                                        <label id="lbldispachLabelsRecord" style="color: #fff;">0</label>
                                    </div>
                                </div>
                                <table id="dispachLabelsRecord" class="table table-striped table-bordered table-hover">
                                    <thead>
                                        <tr>
                                            <th>Company Name</th>
                                            <th>Courier Name</th>
                                            <th>Tracking No.</th>
                                            <th>Disp. Date</th>
                                            <th>Exp. Date</th>
                                            <th>Location</th>
                                            <th>Quantity</th>
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
            </div>

            <!-- /.page-content-area -->
        </div>
    </div>
</asp:Content>

