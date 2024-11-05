<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true"
    Title="Register Product" CodeFile="RegisteredProduct.aspx.cs" Inherits="RegisteredProduct" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <%--<script type="text/javascript" src="../Content/js/scripts/JScript.js" language="javascript"></script>--%>

    <script type="text/javascript">
        $(document).ready(function () {

            $(".accordion2 p").eq(5).addClass("active");
            $(".accordion2 div.open").eq(4).show();

            $(".accordion2 p").click(function () {
                $(this).next("div.open").slideToggle("slow")
                    .siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });
    </script>

    <%--<script type="text/javascript" src="../../Content/jquery/1.10.2/ClientControl.js"></script>--%>

    <script language="javascript" type="text/javascript">
        function ChkRegProVal() {
            var con = document.getElementById('<%=RdYesMessage.ClientID %>').checked;
            if (con == true) {
                if ((document.getElementById("<%=lblname.ClientID %>").innerHTML == "") && (document.getElementById("<%=lblfile.ClientID %>").innerHTML == "") && (document.getElementById("<%=lblInvalidFile.ClientID %>").innerHTML == "") && (document.getElementById("<%=lblfileH.ClientID %>").innerHTML == "") && (document.getElementById("<%=lblfileE.ClientID %>").innerHTML == "") && (document.getElementById("<%=Label6.ClientID %>").innerHTML == "") && (document.getElementById("<%=Label9.ClientID %>").innerHTML == "")) {
                    document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                    document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
                }
                else {
                    document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                    document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";
                }
            }
            else {
                if ((document.getElementById("<%=lblname.ClientID %>").innerHTML == "") && (document.getElementById("<%=lblfile.ClientID %>").innerHTML == "") && (document.getElementById("<%=lblInvalidFile.ClientID %>").innerHTML == "") && (document.getElementById("<%=Label6.ClientID %>").innerHTML == "")) {
                    document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                    document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
                }
                else {
                    document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                    document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";
                }
            }
        }
        function ChkRegProValNew() {
            if ((document.getElementById("<%=lblname.ClientID %>").innerHTML == "") && (document.getElementById("<%=lblfile.ClientID %>").innerHTML == "") && (document.getElementById("<%=lblInvalidFile.ClientID %>").innerHTML == "")) {
                document.getElementById("<%=btnUpdate.ClientID %>").disabled = false;
                document.getElementById("<%=btnUpdate.ClientID %>").className = "button_all";
            }
            else {
                document.getElementById("<%=btnUpdate.ClientID %>").disabled = true;
                document.getElementById("<%=btnUpdate.ClientID %>").className = "button_all_Sec";
            }
        }
        function fileTypeCheckengNew(mm) {
            PageMethods.checkFile(mm, onengcheckNew)
        }
        function onengcheckNew(Result) {
            if (Result == true) {
                document.getElementById("<%=lblfile.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnUpdate.ClientID %>").disabled = true;
                document.getElementById("<%=btnUpdate.ClientID %>").className = "button_all_Sec";

            }
            else {
                document.getElementById("<%=lblfile.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnUpdate.ClientID %>").disabled = false;
                document.getElementById("<%=btnUpdate.ClientID %>").className = "button_all";
            }
            ChkRegProValNew();
        }
        function fileTypeCheckeng(mm) {
            PageMethods.checkFile(mm, onengcheck)
        }
        function onengcheck(Result) {
            if (Result == true) {
                document.getElementById("<%=lblfile.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";

            }
            else {
                document.getElementById("<%=lblfile.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
            }
            ChkRegProVal();
        }
        function fileTypeCheckeng11111(mm) {
            PageMethods.checkFileNew(mm, onengcheck1211)
        }
        function onengcheck1211(Result) {
            var size = document.getElementById("<%=ProDocFileUpload.ClientID%>").files[0].size;
            if (Result == true) {
                if (size > 10240000)
                    document.getElementById("<%=lblInvalidFile.ClientID %>").innerHTML = "FileSize should not exceed 10MB";
                else
                    document.getElementById("<%=lblInvalidFile.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";

            }
            else {
                if (size > 10240000) {
                    document.getElementById("<%=lblInvalidFile.ClientID %>").innerHTML = "FileSize should not exceed 10MB";
                    document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                    document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";
                }
                else {
                    document.getElementById("<%=lblInvalidFile.ClientID %>").innerHTML = "";
                    document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                    document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
                }
            }
            ChkRegProVal();
        }
        function fileTypeCheckengNew12(mm) {
            PageMethods.checkFileNew(mm, onengcheckNew12)
        }
        function onengcheckNew12(Result) {
            var size = document.getElementById("<%=ProDocFileUpload.ClientID%>").files[0].size;
            if (Result == true) {
                if (size > 10240000)
                    document.getElementById("<%=lblInvalidFile.ClientID %>").innerHTML = "FileSize should not exceed 10MB";
                else
                    document.getElementById("<%=lblInvalidFile.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnUpdate.ClientID %>").disabled = true;
                document.getElementById("<%=btnUpdate.ClientID %>").className = "button_all_Sec";

            }
            else {
                if (size > 10240000) {
                    document.getElementById("<%=lblInvalidFile.ClientID %>").innerHTML = "FileSize should not exceed 10MB";
                    document.getElementById("<%=btnUpdate.ClientID %>").disabled = true;
                    document.getElementById("<%=btnUpdate.ClientID %>").className = "button_all_Sec";
                }
                else {
                    document.getElementById("<%=lblInvalidFile.ClientID %>").innerHTML = "";
                    document.getElementById("<%=btnUpdate.ClientID %>").disabled = false;
                    document.getElementById("<%=btnUpdate.ClientID %>").className = "button_all";
                }

            }
            ChkRegProValNew();
        }

        function fileTypeCheckengH(mm) {
            PageMethods.checkFile(mm, onengcheckH)
        }
        function onengcheckH(Result) {
            if (Result == true) {
                document.getElementById("<%=lblfileH.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";

            }
            else {
                document.getElementById("<%=lblfileH.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
            }
            ChkRegProVal();
        }

        function fileTypeCheckengE(mm) {
            PageMethods.checkFile(mm, onengcheckE)
        }
        function onengcheckE(Result) {
            if (Result == true) {
                document.getElementById("<%=lblfileE.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";

            }
            else {
                document.getElementById("<%=lblfileE.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
            }
            ChkRegProVal();
        }
        function CheckProductNew(vl) {
            PageMethods.checkNewProduct(vl, onCompleteProductNew)
        }
        function onCompleteProductNew(Result) {
            if (Result == true) {
                document.getElementById("<%=lblname.ClientID %>").innerHTML = "Product Name Already exist.";
                document.getElementById("<%=btnUpdate.ClientID %>").disabled = true;
                document.getElementById("<%=btnUpdate.ClientID %>").className = "button_all_Sec";

            }
            else {
                document.getElementById("<%=lblname.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnUpdate.ClientID %>").disabled = false;
                document.getElementById("<%=btnUpdate.ClientID %>").className = "button_all";

            }
            ChkRegProValNew();
        }
        function checkproduct(vl) {
            PageMethods.checkNewProduct(vl, onCompleteProduct)
        }
        function onCompleteProduct(Result) {
            if (Result == true) {
                document.getElementById("<%=lblname.ClientID %>").innerHTML = "Product Name Already exist.";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";

            }
            else {
                document.getElementById("<%=lblname.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all";

            }
            ChkRegProVal();
        }
        function checkTextAreaMaxLength(textBox, e, length) {

            var mLen = textBox["MaxLength"];
            if (null == mLen)
                mLen = length;
            var maxLength = parseInt(mLen);
            if (!checkSpecialKeys(e)) {
                if (textBox.value.length > maxLength - 1) {
                    if (window.event)//IE
                    {
                        e.returnValue = false;
                        return false;
                    }
                    else//Firefox
                        e.preventDefault();
                }
            }
        }
        function checkSpecialKeys(e) {
            if (e.keyCode != 8 && e.keyCode != 46 && e.keyCode != 35 && e.keyCode != 36 && e.keyCode != 37 && e.keyCode != 38 && e.keyCode != 39 && e.keyCode != 40)
                return false;
            else
                return true;
        }
        function chkuseoldcomments() {
            var vl = document.getElementById("<%=lblproiddel.ClientID %>").innerHTML;
            PageMethods.checkOldRemarks(vl, oncheckOldRemarks)
        }
        function oncheckOldRemarks(Result) {
            var Arr = Result.toString().split(',');
            document.getElementById("<%=hdnoldAmcId.ClientID %>").value = Arr[0];
            var con = document.getElementById('<%=chkComments.ClientID %>').checked;
            if (con == true) {
                ValidatorEnable(document.getElementById('<%=RequiredFieldValidator10.ClientID%>'), false);
                ValidatorEnable(document.getElementById('<%=RequiredFieldValidator11.ClientID%>'), false);
                document.getElementById("<%=txtComment.ClientID %>").value = Arr[1];
                document.getElementById("<%=txtComment.ClientID %>").readOnly = true;
                var proid = document.getElementById("<%=lblproiddel.ClientID %>").innerHTML;
                document.getElementById("<%=flSoundPH.ClientID %>").disabled = true;
                document.getElementById("<%=A1.ClientID %>").style.display = "block";
                document.getElementById("<%=A1.ClientID %>").href = "Sound\\" + document.getElementById("<%=hhdnCompID.ClientID %>").value + "\\" + proid + "\\" + Arr[0] + "\\" + Arr[0] + "_H.wav";

                document.getElementById("<%=flSoundPE.ClientID %>").disabled = true;
                document.getElementById("<%=A2.ClientID %>").style.display = "block";
                document.getElementById("<%=A2.ClientID %>").href = "Sound\\" + document.getElementById("<%=hhdnCompID.ClientID %>").value + "\\" + proid + "\\" + Arr[0] + "\\" + Arr[0] + "_E.wav";

            }
            else {
                ValidationGroupEnable('promo', 'promo', true);
                document.getElementById("<%=txtComment.ClientID %>").readOnly = false;
                document.getElementById("<%=txtComment.ClientID %>").value = "";

                document.getElementById("<%=flSoundPH.ClientID %>").disabled = false;
                document.getElementById("<%=A1.ClientID %>").style.display = "none";
                document.getElementById("<%=A1.ClientID %>").href = "";

                document.getElementById("<%=flSoundPE.ClientID %>").disabled = false;
                document.getElementById("<%=A2.ClientID %>").style.display = "none";
                document.getElementById("<%=A2.ClientID %>").href = "";
            }
        }
        function chkuseoldsoundh() {
            var vl = document.getElementById("<%=lblproiddel.ClientID %>").innerHTML;
            vl += "-_H";
            PageMethods.checkOldSound(vl, oncheckOldSoundH)
        }
        function oncheckOldSoundH(Result) {
            var con = document.getElementById('<%=CheckBox1.ClientID %>').checked;
            if (con == true) {
                document.getElementById("<%=flSoundPH.ClientID %>").disabled = true;
                document.getElementById("<%=A1.ClientID %>").style.display = "block";
                document.getElementById("<%=A1.ClientID %>").href = Result;
                ValidatorEnable(document.getElementById('<%=RequiredFieldValidator10.ClientID%>'), true);
            }
            else {
                document.getElementById("<%=flSoundPH.ClientID %>").disabled = false;
                document.getElementById("<%=A1.ClientID %>").style.display = "none";
                document.getElementById("<%=A1.ClientID %>").href = "";
                ValidatorEnable(document.getElementById('<%=RequiredFieldValidator10.ClientID%>'), false);
            }
        }
        function chkuseoldsounde() {
            var vl = document.getElementById("<%=lblproiddel.ClientID %>").innerHTML;
            vl += "-_E";
            PageMethods.checkOldSound(vl, oncheckOldSoundE)
        }
        function oncheckOldSoundE(Result) {
            var con = document.getElementById('<%=CheckBox2.ClientID %>').checked;
            if (con == true) {
                document.getElementById("<%=flSoundPE.ClientID %>").disabled = true;
                document.getElementById("<%=A2.ClientID %>").style.display = "block";
                document.getElementById("<%=A2.ClientID %>").href = Result;
                ValidatorEnable(document.getElementById('<%=RequiredFieldValidator11.ClientID%>'), true);
            }
            else {
                document.getElementById("<%=flSoundPE.ClientID %>").disabled = false;
                document.getElementById("<%=A2.ClientID %>").style.display = "none";
                document.getElementById("<%=A1.ClientID %>").href = "";
                ValidatorEnable(document.getElementById('<%=RequiredFieldValidator11.ClientID%>'), false);
            }
        }
    </script>

    <style type="text/css">
        /*tab class*/ .ajax__tab_xp .ajax__tab_tab, .ajax__tab_xp .ajax__tab_outer, .ajax__tab_xp .ajax__tab_inner {
            /*background: url(images/menu_over.png) repeat-x !important;*/
            background: none !important;
            height: 20px !important;
            padding: 0 !important;
            margin: 0;
            color: #ffffff;
            font-family: Arial;
            font-size: 10pt;
            font-weight: bold;
        }

        .ajax__tab_xp .ajax__tab_inner {
            /*background: url(images/menu_over.png) repeat-x !important;*/
            height: 20px !important;
            -webkit-border-radius: 10px 10px 0px 0px !important;
            -moz-border-radius: 10px 10px 0px 0px !important;
            border-radius: 10px 10px 0px 0px !important;
            margin: 0;
            color: #ffffff;
        }

        .ajax__tab_xp .ajax__tab_outer {
            background: url(../Content/images/tab_bg.png) repeat-x !important;
            height: 20px !important;
            margin: 0;
            color: #ffffff;
            margin-right: 5px;
            -webkit-border-radius: 5px 5px 0px 0px !important;
            -moz-border-radius: 5px 5px 0px 0px !important;
            border-radius: 5px 5px 0px 0px !important;
            border: 1px solid #004795;
            border-bottom: none;
            margin-top: 7px;
            padding: 8px 8px 5px 8px !important;
        }
        /*tab class close*/ /*tab activ class*/

        .ajax__tab_xp .ajax__tab_active .ajax__tab_inner {
            -webkit-border-radius: 5px 5px 0px 0px !important;
            -moz-border-radius: 5px 5px 0px 0px !important;
            border-radius: 5px 5px 0px 0px !important;
        }

        .ajax__tab_xp .ajax__tab_active .ajax__tab_outer {
            -webkit-border-radius: 5px 5px 0px 0px !important;
            -moz-border-radius: 5px 5px 0px 0px !important;
            border-radius: 5px 5px 0px 0px !important;
        }

        .ajax__tab_xp .ajax__tab_active .ajax__tab_tab, .ajax__tab_xp .ajax__tab_active .ajax__tab_inner, .ajax__tab_xp .ajax__tab_active .ajax__tab_outer {
            background: #ffffff !important;
            height: 20px;
            padding: 0px;
            margin: 0;
            color: #333333;
        }

        .ajax__tab_xp .ajax__tab_active .ajax__tab_outer {
            margin-right: 5px;
            border: 1px solid #999;
            border-bottom: none;
        }
        /*tab activ class Close*/
    </style>

    <script type="text/javascript" language="javascript">
        $(document).ready(function () {
            ShowImagePreview();
        });
        // Configuration of the x and y offsets
        function ShowImagePreview() {
            xOffset = -20;
            yOffset = 40;

            $("a.preview").hover(function (e) {
                this.t = this.title;
                this.title = "";
                var c = (this.t != "") ? "<br/>" + this.t : "";
                $("body").append("<p id='preview'><img src='" + this.href + "' alt='Image preview' />" + c + "</p>");
                $("#preview")
                    .css("top", (e.pageY - xOffset) + "px")
                    .css("left", (e.pageX + yOffset) + "px")
                    .fadeIn("slow");
            },

                function () {
                    this.title = this.t;
                    $("#preview").remove();
                });

            $("a.preview").mousemove(function (e) {
                $("#preview")
                    .css("top", (e.pageY - xOffset) + "px")
                    .css("left", (e.pageX + yOffset) + "px");
            });
        };

    </script>

    <style type="text/css">
        #preview {
            position: absolute;
            border: 3px solid #ccc;
            background: #333;
            padding: 5px;
            display: none;
            color: #fff;
            box-shadow: 4px 4px 3px rgba(103, 115, 130, 1);
        }
    </style>

    <script type="text/javascript">
        function HasPageValidators() {
            var hasValidators = false;

            try {
                if (Page_Validators.length > 0) {
                    hasValidators = true;
                }
            }
            catch (error) {
            }

            return hasValidators;
        }

        function ValidationGroupEnable(chkvalidationGroupName, validationGroupName, isEnable) {
            if (HasPageValidators()) {
                for (i = 0; i < Page_Validators.length; i++) {
                    if (Page_Validators[i].validationGroup == chkvalidationGroupName) {
                        Page_Validators[i].validationGroup = validationGroupName;
                        ValidatorEnable(Page_Validators[i], isEnable);
                    }
                }
            }
        }
    </script>

    <script type="text/javascript" language="javascript">
        var month;  //1 3 5 7 8 10 12==31,4 6 9 11==30 2 = 28*
        var day;
        var year;
        function FindInfo() {
            var lep = (parseInt(year) % 4);
            switch (parseInt(month)) {
                case 1: // January
                    {
                        if (day > 31) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 31;
                        }
                    }
                    break;
                case 2: // Febuary
                    {
                        if (parseInt(lep) > 0) {
                            if (day > 28) {
                                month = parseInt(month) + 1;
                                day = parseInt(day) - 28;
                            }
                        }
                        else {
                            if (day > 29) {
                                month = parseInt(month) + 1;
                                day = parseInt(day) - 29;
                            }
                        }
                    }
                    break;
                case 3: // March
                    {
                        if (day > 31) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 31;
                        }
                    }
                    break;
                case 4: // April
                    {
                        if (day > 30) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 30;
                        }
                    }
                    break;
                case 5: // May
                    {
                        if (day > 31) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 31;
                        }
                    }
                    break;
                case 6: // Jun
                    {
                        if (day > 30) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 30;
                        }
                    }
                    break;
                case 7: // July
                    {
                        if (day > 31) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 31;
                        }
                    }
                    break;
                case 8: // August
                    {
                        if (day > 31) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 31;
                        }
                    }
                    break;
                case 9: // September
                    {
                        if (day > 30) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 30;
                        }
                    }
                    break;
                case 10: // October
                    {
                        if (day > 31) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 31;
                        }
                    }
                    break;
                case 11: // November
                    {
                        if (day > 30) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 30;
                        }
                    }
                    break;
                default: // December
                    {
                        if (day > 31) {
                            month = parseInt(month) + 1;
                            if (parseInt(month) > 12) {
                                year = parseInt(year) + 1;
                                month = 1;
                            }
                            day = parseInt(day) - 31;
                        }
                    }
            }
            if (parseInt(month) == 0)
                month = 12;
        }

        function ShowDiv(id) {
            var dv = document.getElementById("<%=Promotional.ClientID %>"); //Promotional Div4
            if (id == 1) {
                dv.style.display = 'block';
                ValidationGroupEnable('chk94', 'chk94', true);

            }
            else {
                dv.style.display = 'none';
                //ValidationGroupEnable('chk94', 'chk94', false);
                ValidatorEnable(document.getElementById('<%=RequiredFieldValidator7.ClientID%>'), false);
                ValidatorEnable(document.getElementById('<%=RequiredFieldValidator15Msg.ClientID%>'), false);
                ValidatorEnable(document.getElementById('<%=RequiredFieldValidator6English.ClientID%>'), false);
                ValidatorEnable(document.getElementById('<%=RequiredFieldValidatorHindi.ClientID%>'), false);
            }
            ChkRegProVal();
        }
        function SelectSingleRadiobutton(rdbtnid) {
            var vl = document.getElementById('<%=lblproid.ClientID %>').value;
            PageMethods.checkcheckproLabel(vl, onCompletecheckproLabel)
        }
        function onCompletecheckproLabel(Result) {
            var Arr = Result.toString().split('-');
            if (Arr[2] == "True") {
                document.getElementById("<%=lblTextAlert.ClientID %>").innerHTML = "There is <span style='color:blue;'>" + Arr[0] + "</span> request still pending for cancel <span style='color:blue;'>" + Arr[1] + "</span>, Do you want to cancel these request before changing Label Type.";
                $find("CancelPendingRequest").show();
            }
        }
        function SelectSingleRadiobuttonNew(rdbtnid) {
            var p = 0; var mon = 0;
            var rdBtn = document.getElementById(rdbtnid);
            var rdBtnList = document.getElementsByName("rdamc");
            for (i = 0; i < rdBtnList.length; i++) {
                if (rdBtnList[i].type == "radio" && rdBtnList[i].id != rdBtn.id) {
                    rdBtnList[i].checked = false;
                }
                if (rdBtnList[i].checked == true) {
                    var pArr = rdBtnList[i].value.toString().split('-');
                    p = pArr[1];
                    document.getElementById("<%=HdValAMC.ClientID %>").value = p;
                    if (document.getElementById("<%=txtdtfromamc.ClientID %>").value != "") {
                        var dt = document.getElementById("<%=txtdtfromamc.ClientID %>").value;
                        var mydate = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)), dt.substring(0, 2));
                        mon = p; //mon = FinfMonth(p);
                        mydate = new Date(mydate.setMonth(mydate.getMonth() + parseInt(mon)));
                        var dateObj = new Date(mydate);
                        month = dateObj.getMonth();
                        day = dateObj.getDate();
                        year = dateObj.getFullYear();
                        FindInfo();
                        var newdate = FindVal(day).toString() + "/" + FindVal(month).toString() + "/" + year;
                        document.getElementById("<%=txtdttoamc.ClientID %>").value = newdate;
                        document.getElementById("<%=HdDateTo.ClientID %>").value = newdate;

                        document.getElementById("<%=Label6.ClientID %>").innerHTML = "";
                        document.getElementById("<%=Div1.ClientID %>").className = "";
                    }
                    else {
                        document.getElementById("<%=Label6.ClientID %>").innerHTML = "Please select AMC Plan Date From for product " + document.getElementById("<%=txtProName.ClientID %>").value;
                        document.getElementById("<%=Div1.ClientID %>").className = "alert_boxes_pink big_msg";
                    }
                }
            }
        }
        function FindNextDate(dt) {
            var selectedDate = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)) - 1, dt.substring(0, 2));
            var today = new Date();
            today.setHours(0, 0, 0, 0);
            if (selectedDate < today) {
                document.getElementById("<%=Label6.ClientID %>").innerHTML = "Select current date or bigger than Current date!";
                document.getElementById("<%=txtdtfromamc.ClientID %>").value = "";
                document.getElementById("<%=Div1.ClientID %>").className = "alert_boxes_pink big_msg";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";
                return;
            }
            else {
                document.getElementById("<%=Label6.ClientID %>").innerHTML = "";
                document.getElementById("<%=Div1.ClientID %>").className = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
            }
            var p = document.getElementById("<%=HdValAMC.ClientID %>").value;
            if (parseInt(p) >= 0) {
                var mydate1 = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)), dt.substring(0, 2));
                mon = p;  //mon = FinfMonth(p);
                var mydate = new Date(mydate1.setMonth(mydate1.getMonth() + parseInt(mon)));
                var dateObj = new Date(mydate);
                month = dateObj.getMonth();
                day = dateObj.getDate();
                year = dateObj.getFullYear();
                FindInfo();
                var newdate = FindVal(day).toString() + "/" + FindVal(month).toString() + "/" + year;
                document.getElementById("<%=txtdttoamc.ClientID %>").value = newdate;
                document.getElementById("<%=HdDateTo.ClientID %>").value = newdate;
            }
            ChkRegProVal();
        }

    </script>

    <script type="text/javascript" language="javascript">

        function SelectSingleRadiobuttonNew12(rdbtnid) {
            var p = 0; var mon = 0;
            var rdBtn = document.getElementById(rdbtnid);
            var rdBtnList = document.getElementsByName("rdamcrew");
            for (i = 0; i < rdBtnList.length; i++) {
                if (rdBtnList[i].type == "radio" && rdBtnList[i].id != rdBtn.id) {
                    rdBtnList[i].checked = false;
                }
                if (rdBtnList[i].checked == true) {
                    var pArr = rdBtnList[i].value.toString().split('-');
                    p = pArr[1];
                    document.getElementById("<%=HdValAMC1.ClientID %>").value = p;
                    if (document.getElementById("<%=txtdtfromamc1.ClientID %>").value != "") {
                        var dt = document.getElementById("<%=txtdtfromamc1.ClientID %>").value;
                        var mydate = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)), dt.substring(0, 2));
                        mon = p; //mon = FinfMonth(p);
                        mydate = new Date(mydate.setMonth(mydate.getMonth() + parseInt(mon)));
                        var dateObj = new Date(mydate);
                        month = dateObj.getMonth();
                        day = dateObj.getDate();
                        year = dateObj.getFullYear();
                        FindInfo();
                        var newdate = FindVal(day).toString() + "/" + FindVal(month).toString() + "/" + year;
                        document.getElementById("<%=txtdttoamc1.ClientID %>").value = newdate;
                        document.getElementById("<%=HdDateTo1.ClientID %>").value = newdate;

                        document.getElementById("<%=Label8.ClientID %>").innerHTML = "";
                        document.getElementById("<%=Div2.ClientID %>").className = "";
                    }
                    else {
                        document.getElementById("<%=Label8.ClientID %>").innerHTML = "Please select AMC Plan Date From for product " + document.getElementById("<%=txtProName.ClientID %>").value;
                        document.getElementById("<%=Div2.ClientID %>").className = "alert_boxes_pink big_msg";
                    }
                }
            }
        }
        function FindNextDate12(dt) {
            var selectedDate = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)) - 1, dt.substring(0, 2));
            var today = new Date();
            today.setHours(0, 0, 0, 0);
            if (selectedDate < today) {
                document.getElementById("<%=Label8.ClientID %>").innerHTML = "Select current date or bigger than Current date!";
                document.getElementById("<%=txtdtfromamc1.ClientID %>").value = "";
                document.getElementById("<%=Div2.ClientID %>").className = "alert_boxes_pink big_msg";
                document.getElementById("<%=btnAmcRenewal.ClientID %>").disabled = true;
                document.getElementById("<%=btnAmcRenewal.ClientID %>").className = "button_all_Sec";
                return;
            }
            else {
                document.getElementById("<%=Label8.ClientID %>").innerHTML = "";
                document.getElementById("<%=Div2.ClientID %>").className = "";
                document.getElementById("<%=btnAmcRenewal.ClientID %>").disabled = false;
                document.getElementById("<%=btnAmcRenewal.ClientID %>").className = "button_all";
            }
            var p = document.getElementById("<%=HdValAMC1.ClientID %>").value;
            if (parseInt(p) >= 0) {
                var mydate1 = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)), dt.substring(0, 2));
                mon = p;  //mon = FinfMonth(p);alert(mon);
                var mydate = new Date(mydate1.setMonth(mydate1.getMonth() + parseInt(mon)));
                var dateObj = new Date(mydate);
                month = dateObj.getMonth();
                day = dateObj.getDate();
                year = dateObj.getFullYear();
                FindInfo();
                var newdate = FindVal(day).toString() + "/" + FindVal(month).toString() + "/" + year;
                document.getElementById("<%=txtdttoamc1.ClientID %>").value = newdate;
                document.getElementById("<%=HdDateTo1.ClientID %>").value = newdate;
            }
        }
    </script>

    <script type="text/javascript" language="javascript">

        function SelectSinglePromotional(rdbtnid, rdbtnval) {
            var p = 0; var mon = 0;
            var rdBtn = document.getElementById(rdbtnid);
            var rdBtnList = document.getElementsByName("rdPromotional");
            for (i = 0; i < rdBtnList.length; i++) {
                if (rdBtnList[i].type == "radio" && rdBtnList[i].id != rdBtn.id) {
                    rdBtnList[i].checked = false;
                }
                if (rdBtnList[i].checked == true) {
                    p = i;
                    document.getElementById("<%=HdValAMC2.ClientID %>").value = rdbtnval;
                    if (document.getElementById("<%=txtdtfromamc2.ClientID %>").value != "") {
                        var dt = document.getElementById("<%=txtdtfromamc2.ClientID %>").value;
                        var mydate = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)), dt.substring(0, 2));
                        mon = parseInt(rdbtnval);
                        mydate = new Date(mydate.setDate(mydate.getDate() + parseInt(mon)));
                        var dateObj = new Date(mydate);
                        month = dateObj.getMonth();
                        day = dateObj.getDate();
                        year = dateObj.getFullYear(); //1 3 5 7 8 10 12==31,4 6 9 11==30 2 = 28*
                        FindInfo();

                        var newdate = FindVal(day).toString() + "/" + FindVal(month).toString() + "/" + year;


                        var selectedDate = new Date(newdate.substring(6, 10), parseInt(newdate.substring(3, 5)) - 1, newdate.substring(0, 2));
                        var ddto = document.getElementById("<%=txtdtfromamc.ClientID %>").value;
                        var oldDatefrom = new Date(ddto.substring(6, 10), parseInt(ddto.substring(3, 5)) - 1, ddto.substring(0, 2));
                        var ddt1 = document.getElementById("<%=txtdttoamc.ClientID %>").value;
                        var oldDateto = new Date(ddt1.substring(6, 10), parseInt(ddt1.substring(3, 5)) - 1, ddt1.substring(0, 2));
                        if ((oldDatefrom > selectedDate) || (selectedDate > oldDateto)) {
                            document.getElementById("<%=Label9.ClientID %>").innerHTML = "Please select Offer period within AMC period only. First finalize AMC Period.";
                            document.getElementById("<%=txtdtfromamc2.ClientID %>").value = "";
                            document.getElementById("<%=txtdttoamc2.ClientID %>").value = "";
                            document.getElementById("<%=Div3.ClientID %>").className = "alert_boxes_pink big_msg";
                            document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                            document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";
                            return;
                        }
                        newdate = FindVal(day).toString() + "/" + FindVal(month).toString() + "/" + year;
                        document.getElementById("<%=txtdttoamc2.ClientID %>").value = newdate;
                        document.getElementById("<%=HdDateTo2.ClientID %>").value = newdate;

                        document.getElementById("<%=Label9.ClientID %>").innerHTML = "";
                        document.getElementById("<%=Div3.ClientID %>").className = "";
                    }
                    else {
                        document.getElementById("<%=Label9.ClientID %>").innerHTML = "Please select AMC Plan Date From for product " + document.getElementById("<%=txtProName.ClientID %>").value;
                        document.getElementById("<%=Div3.ClientID %>").className = "alert_boxes_pink big_msg";
                    }
                }
            }
        }
        function FindNextDatePromotional(dt) {
            var selectedDate = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)) - 1, dt.substring(0, 2));
            var ddt = document.getElementById("<%=txtdtfromamc.ClientID %>").value;
            var oldDatefrom = new Date(ddt.substring(6, 10), parseInt(ddt.substring(3, 5)) - 1, ddt.substring(0, 2));
            var ddt1 = document.getElementById("<%=txtdttoamc.ClientID %>").value;
            var oldDateto = new Date(ddt1.substring(6, 10), parseInt(ddt1.substring(3, 5)) - 1, ddt1.substring(0, 2));
            if ((oldDatefrom > selectedDate) || (selectedDate > oldDateto)) {
                document.getElementById("<%=Label9.ClientID %>").innerHTML = "Please select Offer period within AMC period only. First finalize AMC Period.";
                document.getElementById("<%=txtdtfromamc2.ClientID %>").value = "";
                document.getElementById("<%=Div3.ClientID %>").className = "alert_boxes_pink big_msg";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";
                return;
            }

            var today = new Date();
            today.setHours(0, 0, 0, 0);
            if (selectedDate < today) {
                document.getElementById("<%=Label9.ClientID %>").innerHTML = "Select current date or bigger than Current date!";
                document.getElementById("<%=txtdtfromamc2.ClientID %>").value = "";
                document.getElementById("<%=Div3.ClientID %>").className = "alert_boxes_pink big_msg";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";
                return;
            }
            else {
                document.getElementById("<%=Label9.ClientID %>").innerHTML = "";
                document.getElementById("<%=Div3.ClientID %>").className = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
            }
            var p = document.getElementById("<%=HdValAMC2.ClientID %>").value;
            if (parseInt(p) >= 0) {
                var mydate1 = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)), dt.substring(0, 2));
                var mon = parseInt(p);
                var mydate = new Date(mydate1.setDate(mydate1.getDate() + parseInt(mon)));
                var dateObj = new Date(mydate);
                month = dateObj.getMonth();
                day = dateObj.getDate();
                year = dateObj.getFullYear();
                FindInfo();
                var newdate = FindVal(day).toString() + "/" + FindVal(month).toString() + "/" + year;

                var selectedDate1 = new Date(newdate.substring(6, 10), parseInt(newdate.substring(3, 5)) - 1, newdate.substring(0, 2));
                var ddto1 = document.getElementById("<%=txtdtfromamc.ClientID %>").value;
                var oldDatefrom1 = new Date(ddto1.substring(6, 10), parseInt(ddto1.substring(3, 5)) - 1, ddto1.substring(0, 2));
                var ddt12 = document.getElementById("<%=txtdttoamc.ClientID %>").value;
                var oldDateto1 = new Date(ddt12.substring(6, 10), parseInt(ddt12.substring(3, 5)) - 1, ddt12.substring(0, 2));
                if ((oldDatefrom1 > selectedDate1) || (selectedDate1 > oldDateto1)) {
                    document.getElementById("<%=Label9.ClientID %>").innerHTML = "Please select Offer period within AMC period only. First finalize AMC Period.";
                    document.getElementById("<%=txtdtfromamc2.ClientID %>").value = "";
                    document.getElementById("<%=txtdttoamc2.ClientID %>").value = "";
                    document.getElementById("<%=Div3.ClientID %>").className = "alert_boxes_pink big_msg";
                    document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                    document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";
                    return;
                }
                newdate = FindVal(day).toString() + "/" + FindVal(month).toString() + "/" + year;
                document.getElementById("<%=txtdttoamc2.ClientID %>").value = newdate;
                document.getElementById("<%=HdDateTo2.ClientID %>").value = newdate;
            }
            ChkRegProVal();
        }
    </script>

    <script type="text/javascript" language="javascript">

        function SelectSinglePromotionalNew(rdbtnid, rdbtnval) {
            var p = 0; var mon = 0;
            var rdBtn = document.getElementById(rdbtnid);
            var rdBtnList = document.getElementsByName("rdPromo");
            for (i = 0; i < rdBtnList.length; i++) {
                if (rdBtnList[i].type == "radio" && rdBtnList[i].id != rdBtn.id) {
                    rdBtnList[i].checked = false;
                }
                if (rdBtnList[i].checked == true) {
                    p = i;
                    document.getElementById("<%=HdValAMC3.ClientID %>").value = rdbtnval;
                    if (document.getElementById("<%=txtdtfromamc3.ClientID %>").value != "") {
                        var dt = document.getElementById("<%=txtdtfromamc3.ClientID %>").value;
                        var mydate = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)), dt.substring(0, 2));
                        mon = parseInt(rdbtnval);
                        mydate = new Date(mydate.setDate(mydate.getDate() + parseInt(mon)));
                        var dateObj = new Date(mydate);
                        month = dateObj.getMonth();
                        day = dateObj.getDate();
                        year = dateObj.getFullYear();
                        FindInfo();
                        var newdate = FindVal(day).toString() + "/" + FindVal(month).toString() + "/" + year;

                        var selectedDate = new Date(newdate.substring(6, 10), parseInt(newdate.substring(3, 5)) - 1, newdate.substring(0, 2));
                        var ddto = document.getElementById("<%=lblCurrAmcStartDate.ClientID %>").innerHTML;
                        var oldDatefrom = new Date(ddto.substring(6, 10), parseInt(ddto.substring(3, 5)) - 1, ddto.substring(0, 2));
                        var ddt1 = document.getElementById("<%=lblCurrAmcEndDate.ClientID %>").innerHTML;
                        var oldDateto = new Date(ddt1.substring(6, 10), parseInt(ddt1.substring(3, 5)) - 1, ddt1.substring(0, 2));
                        if ((oldDatefrom > selectedDate) || (selectedDate > oldDateto)) {
                            document.getElementById("<%=Label8.ClientID %>").innerHTML = "Please select Offer period within AMC period only.Date between Start Date : " + ddto + " End Date : " + ddt1 + ".";
                            document.getElementById("<%=txtdtfromamc3.ClientID %>").value = "";
                            document.getElementById("<%=txtdttoamc3.ClientID %>").value = "";
                            document.getElementById("<%=Div2.ClientID %>").className = "alert_boxes_pink big_msg";
                            document.getElementById("<%=btnOfferRenewal.ClientID %>").disabled = true;
                            document.getElementById("<%=btnOfferRenewal.ClientID %>").className = "button_all_Sec";
                            return;
                        }

                        newdate = FindVal(day).toString() + "/" + FindVal(month).toString() + "/" + year;
                        document.getElementById("<%=txtdttoamc3.ClientID %>").value = newdate;
                        document.getElementById("<%=HdDateTo3.ClientID %>").value = newdate;

                        document.getElementById("<%=Label8.ClientID %>").innerHTML = "";
                        document.getElementById("<%=Div2.ClientID %>").className = "";
                    }
                    else {
                        document.getElementById("<%=Label8.ClientID %>").innerHTML = "Please select AMC Plan Date From for product " + document.getElementById("<%=txtProName.ClientID %>").value;
                        document.getElementById("<%=Div2.ClientID %>").className = "alert_boxes_pink big_msg";
                    }
                }
            }
        }
        function FindNextDatePromotionalNew(dt) {
            var selectedDate = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)) - 1, dt.substring(0, 2));
            var ddt = document.getElementById("<%=lblCurrAmcStartDate.ClientID %>").innerHTML;
            var oldDatefrom = new Date(ddt.substring(6, 10), parseInt(ddt.substring(3, 5)) - 1, ddt.substring(0, 2));
            var ddt1 = document.getElementById("<%=lblCurrAmcEndDate.ClientID %>").innerHTML;
            var oldDateto = new Date(ddt1.substring(6, 10), parseInt(ddt1.substring(3, 5)) - 1, ddt1.substring(0, 2));
            if ((oldDatefrom > selectedDate) || (selectedDate > oldDateto)) {
                document.getElementById("<%=Label8.ClientID %>").innerHTML = "Please select Offer period within AMC period only.Date between Start Date : " + ddt + " End Date : " + ddt1 + ".";
                document.getElementById("<%=txtdtfromamc3.ClientID %>").value = "";
                document.getElementById("<%=Div2.ClientID %>").className = "alert_boxes_pink big_msg";
                document.getElementById("<%=btnOfferRenewal.ClientID %>").disabled = true;
                document.getElementById("<%=btnOfferRenewal.ClientID %>").className = "button_all_Sec";
                return;
            }
            var today = new Date();
            today.setHours(0, 0, 0, 0);
            if (selectedDate < today) {
                document.getElementById("<%=Label8.ClientID %>").innerHTML = "Select current date or bigger than Current date!";
                document.getElementById("<%=txtdtfromamc3.ClientID %>").value = "";
                document.getElementById("<%=Div2.ClientID %>").className = "alert_boxes_pink big_msg";
                document.getElementById("<%=btnOfferRenewal.ClientID %>").disabled = true;
                document.getElementById("<%=btnOfferRenewal.ClientID %>").className = "button_all_Sec";
                return;
            }
            else {
                document.getElementById("<%=Label8.ClientID %>").innerHTML = "";
                document.getElementById("<%=Div2.ClientID %>").className = "";
                document.getElementById("<%=btnOfferRenewal.ClientID %>").disabled = false;
                document.getElementById("<%=btnOfferRenewal.ClientID %>").className = "button_all";
            }
            var p = document.getElementById("<%=HdValAMC3.ClientID %>").value; //alert(p);
            if (parseInt(p) >= 0) {
                var mydate1 = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)), dt.substring(0, 2));
                var mon = parseInt(p);
                var mydate = new Date(mydate1.setDate(mydate1.getDate() + parseInt(mon)));
                var dateObj = new Date(mydate);
                month = dateObj.getMonth();
                day = dateObj.getDate();
                year = dateObj.getFullYear();
                FindInfo();
                var newdate = FindVal(day).toString() + "/" + FindVal(month).toString() + "/" + year;

                var selectedDate1 = new Date(newdate.substring(6, 10), parseInt(newdate.substring(3, 5)) - 1, newdate.substring(0, 2));
                var ddto1 = document.getElementById("<%=lblCurrAmcStartDate.ClientID %>").innerHTML;
                var oldDatefrom1 = new Date(ddto1.substring(6, 10), parseInt(ddto1.substring(3, 5)) - 1, ddto1.substring(0, 2));
                var ddt12 = document.getElementById("<%=lblCurrAmcEndDate.ClientID %>").innerHTML;
                var oldDateto1 = new Date(ddt12.substring(6, 10), parseInt(ddt12.substring(3, 5)) - 1, ddt12.substring(0, 2));
                if ((oldDatefrom1 > selectedDate1) || (selectedDate1 > oldDateto1)) {
                    document.getElementById("<%=Label8.ClientID %>").innerHTML = "Please select Offer period within AMC period only.Date between Start Date : " + ddto1 + " End Date : " + ddt12 + ".";
                    document.getElementById("<%=txtdtfromamc3.ClientID %>").value = "";
                    document.getElementById("<%=txtdttoamc3.ClientID %>").value = "";
                    document.getElementById("<%=Div2.ClientID %>").className = "alert_boxes_pink big_msg";
                    document.getElementById("<%=btnOfferRenewal.ClientID %>").disabled = true;
                    document.getElementById("<%=btnOfferRenewal.ClientID %>").className = "button_all_Sec";
                    return;
                }
                newdate = FindVal(day).toString() + "/" + FindVal(month).toString() + "/" + year;
                document.getElementById("<%=txtdttoamc3.ClientID %>").value = newdate;
                document.getElementById("<%=HdDateTo3.ClientID %>").value = newdate;
            }
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">




    <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
    <asp:UpdateProgress ID="UpdateProgress1" runat="server"
        DisplayAfter="0">
        <ProgressTemplate>
            <div align="center" style="position: absolute; left: 0; height: 1230px; width: 100%; z-index: 100001; top: 0px;"
                class="NewmodalBackground">
                <div style="margin-top: 300px;" align="center">
                    <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                    <span style="color: White;">Please Wait.....<br />
                    </span>
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>
    <div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
                <div class="card card-admin form-wizard profile box_card">
                    <header class="card-header">
                        <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Register Products</h4>
                    </header>

                    <%--<div style="width: 100%; text-align: center;">
            </div>--%>
                    <div class="card-body-nopadding">
                        <asp:Label ID="Label3" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>

                    </div>
                    <div id="NewMsgpop" runat="server">
                        <p>
                            <asp:Label ID="Label2" runat="server"></asp:Label>
                        </p>
                    </div>
                    <div class="card-body card-body-nopadding">
                        <div class="form-row">
                            <div class="form-group col-lg-2">
                                <asp:Button ID="imgNew" ToolTip="Add New Product" OnClick="imgNew_Click1"
                                    CausesValidation="false" runat="server" Text="Add Product" class="btn btn-primary mb-0" />
                            </div>
                            <div class="form-group col-lg-7 offset-lg-1">
                                <asp:TextBox ID="txtProductName" class="form-control form-control-sm" placeholder="Product Name" runat="server" Text=""></asp:TextBox>
                                <asp:TextBox ID="txtDateFrom" runat="server" Text="" CssClass="reg_txt" Visible="false"></asp:TextBox>
                                <asp:TextBox ID="txtDateTo" runat="server" Text="" CssClass="reg_txt" Visible="false"></asp:TextBox>
                            </div>
                            <div class="form-group col-lg-2">
                                <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png"
                                    CausesValidation="false" ToolTip="Search" OnClick="ImgSearch_Click" />
                                <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                    CausesValidation="false" ToolTip="Reset" />
                            </div>
                        </div>
                        <div class="form-row">
                            

                        </div>
                        

                        <div class="form-row">
                        <div class="col-lg-12 card-admin form-wizard medias">
                    <asp:HiddenField ID="docflag" runat="server" />
                    <asp:HiddenField ID="HdFieldAmcId" runat="server" />
                    <asp:HiddenField ID="HdFieldOfferId" runat="server" />
                    <div class="row pb-2 pt-2 background-section-form">
                        <div class="col-lg-8">
                            <h4 class="mb-0">Total Products<span> (<asp:Label ID="lblcount" runat="server"></asp:Label>)</span></h4>
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
                                OnSelectedIndexChanged="ddlRowsShow_SelectedIndexChanged" Visible="false">
                                <asp:ListItem Value="25">25 Rows</asp:ListItem>
                                <asp:ListItem Value="50">50 Rows</asp:ListItem>
                                <asp:ListItem Value="100">100 Rows</asp:ListItem>
                                <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                <asp:ListItem Value="1000">1000 Rows</asp:ListItem>
                                <asp:ListItem Value="1001">All Rows</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>
                     <div class="table-responsive table_large">
                    <asp:GridView ID="GrdProductMaster" runat="server" AutoGenerateColumns="False" CssClass="table table-striped table-bordered Frm_Scrap"
                        DataKeyNames="Comp_type,CntDays,Loyalty"
                        BorderColor="transparent" OnRowCommand="GrdProductMaster_RowCommand"
                        OnPageIndexChanging="GrdProductMaster_PageIndexChanging1">
                        <Columns>
                            <asp:TemplateField HeaderText="S.No">
                                <ItemTemplate>
                                    <%=++c %>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="4%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Product Name">
                                <ItemTemplate>
                                    <asp:Label ID="lblactudate" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="13%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Label Name">
                                <ItemTemplate>
                                    <asp:Label ID="lbllblnamesize" runat="server" Text='<%# Bind("Label_Name") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Price/Label">
                                <ItemTemplate>
                                    <asp:Label ID="lblproprice" runat="server" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                        Text='<%# Bind("Rate_Per_Label") %>'></asp:Label>+(Applicable Tax)
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="15%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Description">
                                <ItemTemplate>
                                    <asp:Label ID="lbldiscrip" runat="server" Text='<%# Bind("Pro_Desc") %>'></asp:Label>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="15%" />
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="AMC">
                            <ItemTemplate>
                                <asp:Label ID="lblproamc" runat="server" Text='<%# Bind("Plan_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="8%" />
                        </asp:TemplateField>--%>
                            <asp:TemplateField HeaderText="Sound File">
                                <ItemTemplate>
                                    <ul class="graphic">
                                        <li><a href='<%# Eval("SoundPath") %>' class="sm2_link"></a></li>
                                    </ul>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed bord_left" HorizontalAlign="Center" />--%>
                                <ItemStyle HorizontalAlign="Center" Width="9%" />
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <asp:ImageButton ID="imgBtnEdit" runat="server" CausesValidation="false" CommandArgument='<%#Bind("Pro_ID") %>'
                                        CommandName="EditRow" ImageUrl="../Content/images/edit.png" ToolTip="Edit" />
                                    <asp:ImageButton ID="ImgBtnLoyalty" runat="server" CausesValidation="false" CommandArgument='<%#Bind("Pro_ID") %>'
                                        CommandName="Loyalty" ImageUrl="../Content/images/loyalty.png" ToolTip="Add / Update Loyalty" Visible="false" />
                                    <%
                                        try
                                        {
                                            Comptype = Convert.ToString(GrdProductMaster.DataKeys[index].Values["Comp_type"].ToString());
                                            CntDays = Convert.ToInt32(GrdProductMaster.DataKeys[index].Values["CntDays"].ToString());
                                            Loyalty = Convert.ToInt32(GrdProductMaster.DataKeys[index].Values["Loyalty"].ToString());
                                        }
                                        catch
                                        {
                                        }
                                        if (Comptype == "L")
                                        {
                                    %>
                                &nbsp;<asp:ImageButton ID="imgBtnSecDelete" runat="server" CausesValidation="false"
                                    Visible="false" CommandArgument='<%#Bind("Pro_ID") %>' CommandName="DeleteRow"
                                    ImageUrl="../Content/images/delete.png" ToolTip="Delete" />
                                    <% } %>
                                    <asp:ImageButton ID="ImgAmcRenewal" runat="server" CausesValidation="false" ImageUrl="../Content/images/upg.png"
                                        ToolTip="View/Renewal your Amc" CommandName="AmcRenewal" CommandArgument='<%#Bind("Pro_ID") %>'
                                        Height="12px" Width="12px" Visible="false" />
                                    <asp:ImageButton ID="ImgOfferRenewal" runat="server" CausesValidation="false" ImageUrl="../Content/images/upgrade.png"
                                        ToolTip="View/Renewal your Offer" CommandName="OfferRenewal" CommandArgument='<%#Bind("Pro_ID") %>'
                                        Height="12px" Width="12px" Visible="false" />
                                    <a href='<%# Eval("DocPath") %>' target="_blank" style="margin-top: 2px;">
                                        <img src="../Content/images/search.png" alt="dfgd" height="14px" width="14px" title="View product's legal document" />
                                    </a>
                                    <%if (Loyalty == 1)
                                        {%>
                                    <img src="../Content/images/payment-24.png" alt="dfgd" height="14px" width="14px" title="Alredy brand loyalty subscribe" style="display: none;" />
                                    <%}
                                        else
                                        {%>
                                    <a href="ServiceSubscription.aspx" target="_blank" style="margin-top: 2px;" style="display: none;">
                                        <img src="../Content/images/plus-24.png" alt="dfgd" height="14px" width="14px" title="Add brand loyalty" style="display: none;" />
                                    </a>
                                    <%} %>
                                    <%index++;%>
                                </ItemTemplate>
                                <%--<HeaderStyle CssClass="tr_haed bord_left" HorizontalAlign="Center" />--%>
                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                        </Columns>
                        <%-- <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                    <RowStyle CssClass="tr_line1" />
                    <AlternatingRowStyle CssClass="tr_line2" />--%>
                    </asp:GridView>
                         </div>
                </div>
                        </div>
                    </div>
                    

                </div>

                

            </div>
        </div>

    </div>
        </div>
    <div class="grid_container">
        <%-- <h4>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <img src="../Content/images/regis_pro.png" alt="products" />
                            </td>
                            <td class="bord_right">
                                Record(s) found <span class="small_font">()</span>
                            </td>
                            <td width="13%" align="center">
                                <div class="mainselection">
                                   
                                </div>
                            </td>
                        </tr>
                    </table>
                </h4>--%>





        <!--PopUp Starts-->
        <asp:UpdatePanel ID="UpdatePanelNNEW2" runat="server">
            <ContentTemplate>
                <asp:Panel ID="PanelProduct" runat="server" Width="55%" Style="display: none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="Button1" CssClass="popupClose" runat="server" />
                            </div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="lblheading" runat="server" Font-Bold="true"></asp:Label>
                                    </span><span class="right"><span class="astrics"><strong>*</strong></span> <em>indicates
                                                mandatory fields</em></span>
                                </p>
                            </div>
                            <div class="regis_popup">
                                <div id="newmsg" runat="server">
                                    <p>
                                        <asp:Label ID="lblmsgHeader" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <asp:HiddenField ID="lblproid" runat="server" />
                                <asp:UpdatePanel ID="UpdatePanel3" runat="server">
                                    <ContentTemplate>
                                        <cc1:TabContainer ID="tabmenu" ActiveTabIndex="0" runat="server">
                                            <cc1:TabPanel ID="tab1" runat="server">
                                                <HeaderTemplate>
                                                    Product Info
                                                </HeaderTemplate>
                                                <ContentTemplate>
                                                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                                        <tr>
                                                            <td align="center" colspan="2"></td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="chk94"
                                                                    ControlToValidate="txtProName"></asp:RequiredFieldValidator>
                                                                <strong><span class="astrics">*</span> Product Name :</strong>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtProName" Width="55%" MaxLength="15" onchange="checkproduct(this.value);"
                                                                    CssClass="reg_txt" runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'15');"></asp:TextBox>
                                                                <span class="astrics">Product Name should be in 15 character. </span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td>
                                                                <asp:Label ID="lblname" runat="server" CssClass="astrics"></asp:Label>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" valign="top">
                                                                <strong>Product Description :</strong>
                                                            </td>
                                                            <td valign="middle">
                                                                <asp:TextBox ID="txtprodDes" TextMode="MultiLine" Width="55%" CssClass="reg_txt"
                                                                    Height="35px" onkeyDown="return checkTextAreaMaxLength(this,event,'100');" runat="server"></asp:TextBox><span
                                                                        class="astrics">Product Description should be in 100 character. </span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right" valign="top">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ValidationGroup="chk94"
                                                                    ControlToValidate="txtdisatchLoc"></asp:RequiredFieldValidator>
                                                                <strong><span class="astrics">*</span>Dispatch Location :</strong>
                                                            </td>
                                                            <td valign="middle">
                                                                <asp:TextBox ID="txtdisatchLoc" TextMode="MultiLine" Width="55%" CssClass="reg_txt"
                                                                    Height="35px" onkeyDown="return checkTextAreaMaxLength(this,event,'250');" runat="server"></asp:TextBox><span
                                                                        class="astrics">Dispatch Location should be in 250 character. </span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td align="right">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ValidationGroup="chk94"
                                                                    ControlToValidate="txtBatchSize"></asp:RequiredFieldValidator>
                                                                <strong><span class="astrics">*</span>Batch Size :</strong>
                                                            </td>
                                                            <td>
                                                                <asp:TextBox ID="txtBatchSize" Width="10%" MaxLength="10" CssClass="reg_txt" OnKeyPress="return isNumberKey(this, event);"
                                                                    runat="server"></asp:TextBox><span class="astrics">Batch Size should be in 10 digits. </span>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td></td>
                                                            <td align="right">
                                                                <asp:Button ID="btnNext1" OnClick="btnNext1_Click" CssClass="button_all" runat="server"
                                                                    Text="Next" Visible="false" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </cc1:TabPanel>
                                            <cc1:TabPanel ID="TabPanelSound" runat="server">
                                                <HeaderTemplate>
                                                    Product Sound
                                                </HeaderTemplate>
                                                <ContentTemplate>
                                                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                                        <tr>
                                                            <td align="right">
                                                                <asp:RequiredFieldValidator ID="RequiredFieldValidator522" runat="server" ValidationGroup="chk94"
                                                                    ControlToValidate="flSound"></asp:RequiredFieldValidator>
                                                                <strong><span class="astrics">*</span>Product Name Audio (*.wav):</strong>
                                                            </td>
                                                            <td>
                                                                <asp:FileUpload ID="flSound" onchange="fileTypeCheckeng(this.value);" runat="server" />
                                                                &nbsp;<asp:Label ID="lblfile" runat="server" CssClass="astrics"></asp:Label>
                                                                <div style="width: 25px; float: right; padding-right: 15px;">
                                                                    <ul class="graphic">
                                                                        <li><a id="FileDown" runat="server" title="Play" class="sm2_link"></a></li>
                                                                    </ul>
                                                                </div>
                                                            </td>
                                                        </tr>
                                                        <tr>
                                                            <td colspan="2">
                                                                <%--<asp:Label ID="lblnoteSound" Style="font-family: Arial; font-size: 12px; color: red;"
                                                                                runat="server" Text="Note:- Audio file to be uploaded on the website should be in the prescribed format as below"></asp:Label>
                                                                            <br />--%>
                                                                <br />
                                                                <asp:Label ID="lblfiletype" Style="font-family: Arial; font-size: 12px; color: red;"
                                                                    runat="server" Text="File Type ---- .wav"></asp:Label>
                                                                <br />
                                                                <asp:Label ID="lblrecord" Style="font-family: Arial; font-size: 12px; color: Blue;"
                                                                    runat="server" Text="For record the audio file, Please click the link "></asp:Label>&nbsp;
                                                                        <a href="http://wavepad.en.softonic.com/" style="font-family: Arial; font-size: 12px; color: Blue;"
                                                                            target="_blank">Click</a>
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </cc1:TabPanel>
                                            <cc1:TabPanel ID="tab3" runat="server">
                                                <HeaderTemplate>
                                                    Legal Documents
                                                </HeaderTemplate>
                                                <ContentTemplate>
                                                    <asp:UpdatePanel ID="UpdatePanel2" runat="server">
                                                        <ContentTemplate>
                                                            <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                                                <tr>
                                                                    <td align="right">
                                                                        <asp:RequiredFieldValidator ID="RequiredFieldValidatorfile" runat="server" ForeColor="Red"
                                                                            ValidationGroup="chk94" ControlToValidate="ProDocFileUpload"></asp:RequiredFieldValidator>
                                                                        <strong><span class="astrics">*</span> Document File :</strong>
                                                                    </td>
                                                                    <td>
                                                                        <asp:FileUpload ID="ProDocFileUpload" runat="server" CssClass="reg_txt" Width="225px"
                                                                            onchange="fileTypeCheckeng11111(this.value);" />
                                                                        &nbsp;<asp:HyperLink ID="FileDownDoc" NavigateUrl="" Target="_blank" Text="View"
                                                                            runat="server" ToolTip="View"></asp:HyperLink><%--<a id="FileDownDoc" runat="server" title="Download">Download</a>--%>
                                                                        <asp:Label ID="FileDocDownPath" runat="server" Visible="false"></asp:Label>
                                                                        <asp:Label ID="lblInvalidFile" runat="server" CssClass="astrics"></asp:Label>
                                                                    </td>
                                                                </tr>
                                                                <tr>
                                                                    <td colspan="2">
                                                                        <asp:Label ID="Label7" Style="font-family: Arial; font-size: 12px; color: red;" runat="server"
                                                                            Text="<span style='color:blue;'>Please upload Legal Documents in support of Product ownership.</span>File Type ---- .zip,.png,.jpg,.jpeg,.pdf,.doc,.docx. Size should be less than 10MB. "></asp:Label>
                                                                        <br />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </ContentTemplate>
                                            </cc1:TabPanel>
                                            <cc1:TabPanel ID="tab2" runat="server">
                                                <HeaderTemplate>
                                                    Choose Label
                                                </HeaderTemplate>
                                                <ContentTemplate>
                                                    <asp:UpdatePanel ID="UpdatePanel22" runat="server">
                                                        <ContentTemplate>
                                                            <div>
                                                                <div style="overflow: auto; height: 150px;">
                                                                    <asp:GridView ID="GrdViewLabelDetails" runat="server" AutoGenerateColumns="False"
                                                                        DataKeyNames="Label_Code" CssClass="grid" EmptyDataText="Record Not Found" EnableModelValidation="True"
                                                                        PageSize="5" Width="100%" BorderStyle="None" BorderWidth="0px" BorderColor="Transparent">
                                                                        <Columns>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <%try
                                                                                        {
                                                                                            LCode = GrdViewLabelDetails.DataKeys[pindex].Values["Label_Code"].ToString();//LabelFlag                                                                                      
                                                                                        }
                                                                                        catch { }
                                                                                        if (Session["LabelCode"].ToString() == LCode)
                                                                                        {
                                                                                    %>
                                                                                    <input type="radio" id="rdlabel" name="rdlabel" checked="checked" value='<%# Eval("Label_Code") %>'
                                                                                        onclick="javascript: SelectSingleRadiobutton(this.id)" />
                                                                                    <%}
                                                                                        else
                                                                                        {%>
                                                                                    <input type="radio" id="Radio1" name="rdlabel" value='<%# Eval("Label_Code") %>'
                                                                                        onclick="javascript: SelectSingleRadiobutton(this.id)" />
                                                                                    <% }%>
                                                                                    <asp:Label ID="lblcode" runat="server" Text='<%# Bind("Label_Code") %>' Visible="false"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Name [Dimensions(in mm)]">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblnamedetwith" runat="server" Text='<%# Bind("Label_NameC") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                                <ItemStyle HorizontalAlign="Justify" Width="65%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Price">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblprisedet12new" runat="server" Text='<%# Bind("Label_Prise") %>'
                                                                                        Style="padding-left: 10px;" CssClass="txt_rupees rupees"></asp:Label>+(Applicable
                                                                                            Tax)
                                                                                </ItemTemplate>
                                                                                <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Label">
                                                                                <ItemTemplate>
                                                                                    <asp:HyperLink ID="HyperLink1" class="preview" ToolTip='<%#Bind("Label_Image") %>'
                                                                                        Target="_blank" NavigateUrl='<%# Bind("Label_Image", "~/Data/Sound/Label/{0}") %>'
                                                                                        runat="server">
                                                                                        <asp:Image Height="32px" Width="75px" ID="Image1" ImageUrl='<%# Bind("Label_Image", "~/Data/Sound/Label/{0}") %>'
                                                                                            runat="server" />
                                                                                    </asp:HyperLink>
                                                                                    <%pindex++;%>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                        <EmptyDataRowStyle HorizontalAlign="Center" />
                                                                        <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                                        <RowStyle CssClass="tr_line1" />
                                                                        <AlternatingRowStyle CssClass="tr_line2" />
                                                                    </asp:GridView>
                                                                </div>
                                                            </div>
                                                            <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                                                <tr>
                                                                    <td align="left">
                                                                        <asp:Button ID="btnPre1" OnClick="btnPre1_Click" CssClass="button_all" runat="server"
                                                                            Text="Pre" Visible="false" />
                                                                    </td>
                                                                    <td align="right">
                                                                        <asp:Button ID="btnNext2" OnClick="btnNext2_Click" CssClass="button_all" runat="server"
                                                                            Text="Next" Visible="false" /><asp:Button ID="btnUpdate" OnClick="btnUpdate_Click"
                                                                                ValidationGroup="chk94" CssClass="button_all" runat="server" Text="Update" />
                                                                        <asp:Button ID="btnResetNew" OnClick="btnResetNew_Click" CssClass="button_all" runat="server"
                                                                            CausesValidation="false" Text="Reset" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:PostBackTrigger ControlID="btnUpdate" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </ContentTemplate>
                                            </cc1:TabPanel>
                                            <cc1:TabPanel ID="TabPanelAMC" runat="server" Visible="false">
                                                <HeaderTemplate>
                                                    AMC Plan
                                                </HeaderTemplate>
                                                <ContentTemplate>
                                                    <div style="overflow: auto; height: 200px;">
                                                        <div id="Div1" runat="server">
                                                            <p>
                                                                <asp:Label ID="Label6" runat="server"></asp:Label>
                                                            </p>
                                                        </div>
                                                        <table style="width: 100%;" cellpadding="0px" cellspacing="0px">
                                                            <tr>
                                                                <td style="width: 25%; vertical-align: top;">
                                                                    <asp:HiddenField ID="HdValAMC" runat="server" />
                                                                    <asp:HiddenField ID="HdDateTo" runat="server" />
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="chk94"
                                                                        ControlToValidate="txtdtfromamc"></asp:RequiredFieldValidator>
                                                                    <strong><span class="astrics">*</span>Date From : -</strong><br />
                                                                    <asp:TextBox ID="txtdtfromamc" onchange="javascript:FindNextDate(this.value);" runat="server"
                                                                        onkeydown="return checkShortcut();" CssClass="reg_txt"></asp:TextBox><br />
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="txtdttoamc"></asp:RequiredFieldValidator>
                                                                    <strong><span class="astrics">*</span>Date To : -</strong><br />
                                                                    <asp:TextBox ID="txtdttoamc" Enabled="false" runat="server" CssClass="reg_txt"></asp:TextBox>
                                                                </td>
                                                                <td style="width: 75%; vertical-align: top;">
                                                                    <asp:GridView ID="GrdViewAMC" runat="server" AutoGenerateColumns="False" DataKeyNames="Plan_ID,Disp"
                                                                        CssClass="grid" EmptyDataText="Record Not Found" EnableModelValidation="True"
                                                                        PageSize="5" Width="100%" BorderStyle="None" BorderWidth="0px" BorderColor="Transparent">
                                                                        <Columns>
                                                                            <asp:TemplateField>
                                                                                <ItemTemplate>
                                                                                    <%try
                                                                                        {
                                                                                            PlanID = GrdViewAMC.DataKeys[planindex].Values["Plan_ID"].ToString();//LabelFlag  
                                                                                            Disp = Convert.ToInt32(GrdViewAMC.DataKeys[planindex].Values["Disp"].ToString());
                                                                                        }
                                                                                        catch { }
                                                                                        if (Session["Plan_ID"].ToString() == PlanID)
                                                                                        {
                                                                                            if (Disp == 0)
                                                                                            {
                                                                                    %>
                                                                                    <input type="radio" id="rdamc" name="rdamc" checked="checked" value='<%# Eval("PlanInfo") %>'
                                                                                        onclick="javascript: SelectSingleRadiobuttonNew(this.id)" />
                                                                                    <% }
                                                                                        else
                                                                                        {
                                                                                    %>
                                                                                    <input type="radio" id="Radio2" name="rdamc" checked="checked" disabled="disabled"
                                                                                        value='<%# Eval("PlanInfo") %>' onclick="javascript: SelectSingleRadiobuttonNew(this.id)" />
                                                                                    <%
                                                                                            }
                                                                                        }
                                                                                        else
                                                                                        {
                                                                                            if (Disp == 0)
                                                                                            {%>
                                                                                    <input type="radio" id="rdamc123" name="rdamc" value='<%# Eval("PlanInfo") %>' onclick="javascript: SelectSingleRadiobuttonNew(this.id)" />
                                                                                    <% }
                                                                                        else
                                                                                        {
                                                                                    %>
                                                                                    <input type="radio" id="Radio3" name="rdamc" disabled="disabled" value='<%# Eval("PlanInfo") %>'
                                                                                        onclick="javascript: SelectSingleRadiobuttonNew(this.id)" />
                                                                                    <%
                                                                                            }
                                                                                        }%>
                                                                                    <asp:Label ID="lblPlanID" runat="server" Text='<%# Bind("Plan_ID") %>' Visible="false"></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Plan Name">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblplanmanewith" runat="server" Text='<%# Bind("Plan_Name") %>'></asp:Label>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                                <ItemStyle HorizontalAlign="Justify" Width="10%" />
                                                                            </asp:TemplateField>
                                                                            <asp:TemplateField HeaderText="Amount">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblplanprice" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                                                        runat="server" Text='<%# Bind("Plan_Amount") %>'></asp:Label>
                                                                                    <%planindex++;%>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                                                                            </asp:TemplateField>
                                                                            <%--<asp:TemplateField HeaderText="Service Tax">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblplanserprice" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                                                                runat="server" Text='<%# Bind("STAX") %>'></asp:Label>
                                                                                            <%planindex++;%>
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                                                                                        <ItemStyle HorizontalAlign="Right" Width="15%" />
                                                                                    </asp:TemplateField>
                                                                                    <asp:TemplateField HeaderText="VAT">
                                                                                        <ItemTemplate>
                                                                                            <asp:Label ID="lblplanvatprice" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                                                                runat="server" Text='<%# Bind("VTAX") %>'></asp:Label>
                                                                                            <%planindex++;%>
                                                                                        </ItemTemplate>
                                                                                        <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                                                                                        <ItemStyle HorizontalAlign="Right" Width="15%" />
                                                                                    </asp:TemplateField>--%>
                                                                            <asp:TemplateField HeaderText="Net Amount">
                                                                                <ItemTemplate>
                                                                                    <asp:Label ID="lblplannetprice" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                                                        runat="server" Text='<%# Bind("Plan_AmountN") %>'></asp:Label>
                                                                                    <%planindex++;%>
                                                                                </ItemTemplate>
                                                                                <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                                                                                <ItemStyle HorizontalAlign="Center" Width="20%" />
                                                                            </asp:TemplateField>
                                                                        </Columns>
                                                                        <EmptyDataRowStyle HorizontalAlign="Center" />
                                                                        <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                                        <RowStyle CssClass="tr_line1" />
                                                                        <AlternatingRowStyle CssClass="tr_line2" />
                                                                    </asp:GridView>
                                                                    <cc1:CalendarExtender ID="CalendarExtender1" runat="server" TargetControlID="txtdtfromamc"
                                                                        Format="dd/MM/yyyy">
                                                                    </cc1:CalendarExtender>
                                                                    <%--<cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtdtfromamc"
                                                                                Mask="99/99/9999" MaskType="Date">
                                                                            </cc1:MaskedEditExtender>--%>
                                                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1" runat="server" TargetControlID="txtdtfromamc"
                                                                        WatermarkText="From..">
                                                                    </cc1:TextBoxWatermarkExtender>
                                                                    <cc1:CalendarExtender ID="CalendarExtender2" runat="server" TargetControlID="txtdttoamc"
                                                                        Format="dd/MM/yyyy">
                                                                    </cc1:CalendarExtender>
                                                                    <cc1:MaskedEditExtender ID="MaskedEditExtender2" runat="server" TargetControlID="txtdttoamc"
                                                                        Mask="99/99/9999" MaskType="Date">
                                                                    </cc1:MaskedEditExtender>
                                                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender2" runat="server" TargetControlID="txtdttoamc"
                                                                        WatermarkText="To..">
                                                                    </cc1:TextBoxWatermarkExtender>
                                                                </td>
                                                            </tr>
                                                        </table>
                                                    </div>
                                                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                                        <tr>
                                                            <td align="left">
                                                                <asp:Button ID="btnPre3" OnClick="btnPre3_Click" CssClass="button_all" runat="server"
                                                                    Text="Pre" Visible="false" />
                                                            </td>
                                                            <td align="right">
                                                                <asp:Button ID="btnNext4" OnClick="btnNext4_Click" CssClass="button_all" runat="server"
                                                                    Text="Next" Visible="false" />
                                                            </td>
                                                        </tr>
                                                    </table>
                                                </ContentTemplate>
                                            </cc1:TabPanel>
                                            <cc1:TabPanel ID="TabPanelMsg" runat="server" Visible="false">
                                                <HeaderTemplate>
                                                    Message for Buyer
                                                </HeaderTemplate>
                                                <ContentTemplate>
                                                    <asp:UpdatePanel ID="UpdatePanel5" runat="server">
                                                        <ContentTemplate>
                                                            <div id="Div3" runat="server" style="width: 89%;">
                                                                <p>
                                                                    <asp:Label ID="Label9" runat="server"></asp:Label>
                                                                </p>
                                                            </div>
                                                            <div>
                                                                <table>
                                                                    <tr>
                                                                        <td colspan="2" style="height: 10px;"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td style="text-align: right; width: 300px;">
                                                                            <strong><span class="astrics">*</span> Want to Send/Play Message to Buyers :</strong>
                                                                        </td>
                                                                        <td>
                                                                            <asp:RadioButton ID="RdYesMessage" runat="server" Checked="true" GroupName="MSG"
                                                                                Text="Yes" onchange="ShowDiv(1);" />&nbsp;&nbsp;&nbsp;&nbsp;<asp:RadioButton ID="RdNoMessage"
                                                                                    runat="server" GroupName="MSG" Text="No" onchange="ShowDiv(0);" />
                                                                            &nbsp;<asp:Label Visible="false" ID="Label4" Style="font-family: Arial; font-size: 12px; color: red; font-weight: normal;"
                                                                                runat="server" Text="Select Yes for playing audio file for Message for Buyers. Select No for No Message for Buyers."></asp:Label>
                                                                            <br />
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2" style="height: 10px;"></td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <div id="Promotional" runat="server" style="width: 100%; display: block;">
                                                                <div id="DivNewMsg2" runat="server" style="width: 89%;">
                                                                    <p>
                                                                        <asp:Label ID="LabelPromotionalmsg" runat="server"></asp:Label>
                                                                    </p>
                                                                </div>
                                                                <table cellpadding="0px" cellspacing="0px" width="100%">
                                                                    <tr>
                                                                        <td style="width: 25%; vertical-align: top;">
                                                                            <asp:HiddenField ID="HdValAMC2" runat="server" />
                                                                            <asp:HiddenField ID="HdDateTo2" runat="server" />
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator7" runat="server" ValidationGroup="chk94"
                                                                                ControlToValidate="txtdtfromamc2"></asp:RequiredFieldValidator>
                                                                            <strong><span class="astrics">*</span>Date From : -</strong><br />
                                                                            <asp:TextBox ID="txtdtfromamc2" onchange="FindNextDatePromotional(this.value);" runat="server"
                                                                                onkeydown="return checkShortcut();" CssClass="reg_txt"></asp:TextBox><br />
                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator8" runat="server" ControlToValidate="txtdttoamc2"></asp:RequiredFieldValidator>
                                                                            <strong><span class="astrics">*</span>Date To : -</strong><br />
                                                                            <asp:TextBox ID="txtdttoamc2" Enabled="false" runat="server" CssClass="reg_txt"></asp:TextBox><br />
                                                                            <span style="color: Red;">Please select Offer period within AMC period only. First finalize
                                                                                        AMC Period.</span>
                                                                            <br />
                                                                        </td>
                                                                        <td>
                                                                            <div style="overflow: auto; height: 150px;">
                                                                                <asp:GridView ID="GrdVwPromotional" runat="server" AutoGenerateColumns="False" DataKeyNames="Promo_ID,Disp"
                                                                                    CssClass="grid" EmptyDataText="Record Not Found" EnableModelValidation="True"
                                                                                    PageSize="5" Width="100%" BorderStyle="None" BorderWidth="0px" BorderColor="Transparent">
                                                                                    <Columns>
                                                                                        <asp:TemplateField>
                                                                                            <ItemTemplate>
                                                                                                <%try
                                                                                                    {
                                                                                                        PromoID = GrdVwPromotional.DataKeys[promoind].Values["Promo_ID"].ToString();//LabelFlag  
                                                                                                        promoDisp = Convert.ToInt32(GrdVwPromotional.DataKeys[promoind].Values["Disp"].ToString());
                                                                                                    }
                                                                                                    catch { }
                                                                                                    if (Session["PromoId"].ToString() == PromoID)
                                                                                                    {
                                                                                                        if (promoDisp == 0)
                                                                                                        {
                                                                                                %>
                                                                                                <input type="radio" id="rdPromotional" name="rdPromotional" checked="checked" title='<%# Eval("Time_Days") %>'
                                                                                                    value='<%# Eval("Promo_ID") %>' onclick="javascript: SelectSinglePromotional(this.id, this.title)" />
                                                                                                <% 
                                                                                                    }
                                                                                                    else
                                                                                                    {
                                                                                                %>
                                                                                                <input type="radio" id="rdPromotional1" name="rdPromotional" checked="checked" disabled="disabled"
                                                                                                    title='<%# Eval("Time_Days") %>' value='<%# Eval("Promo_ID") %>' onclick="javascript: SelectSinglePromotional(this.id, this.title)" />
                                                                                                <%
                                                                                                        }
                                                                                                    }
                                                                                                    else
                                                                                                    {
                                                                                                        if (promoDisp == 0)
                                                                                                        {
                                                                                                %>
                                                                                                <input type="radio" id="rdPromotional2" name="rdPromotional" title='<%# Eval("Time_Days") %>'
                                                                                                    value='<%# Eval("Promo_ID") %>' onclick="javascript: SelectSinglePromotional(this.id, this.title)" />
                                                                                                <% 
                                                                                                    }
                                                                                                    else
                                                                                                    {
                                                                                                %>
                                                                                                <input type="radio" id="rdPromotional3" name="rdPromotional" disabled="disabled"
                                                                                                    title='<%# Eval("Time_Days") %>' value='<%# Eval("Promo_ID") %>' onclick="javascript: SelectSinglePromotional(this.id, this.title)" />
                                                                                                <%
                                                                                                        }
                                                                                                    }%>
                                                                                                <%promoind++; %>
                                                                                                <asp:Label ID="lblPromotionalPlanID" runat="server" Text='<%# Bind("Promo_ID") %>'
                                                                                                    Visible="false"></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                                                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Promotional Plan Name">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblPromotionalplnNm" runat="server" Text='<%# Bind("Promo_Name") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                                            <ItemStyle HorizontalAlign="Justify" Width="35%" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Plan Time(In Days)">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblPromotionalplnNm" runat="server" Text='<%# Bind("Time_Days") %>'></asp:Label>
                                                                                            </ItemTemplate>
                                                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                                                            <ItemStyle HorizontalAlign="Justify" Width="20%" />
                                                                                        </asp:TemplateField>
                                                                                        <asp:TemplateField HeaderText="Amount">
                                                                                            <ItemTemplate>
                                                                                                <asp:Label ID="lblPromotionalAmt" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                                                                    runat="server" Text='<%# Bind("Amount") %>'></asp:Label>+(Applicable Tax)
                                                                                            </ItemTemplate>
                                                                                            <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                                                                                            <ItemStyle HorizontalAlign="Center" Width="25%" />
                                                                                        </asp:TemplateField>
                                                                                    </Columns>
                                                                                    <EmptyDataRowStyle HorizontalAlign="Center" />
                                                                                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                                                    <RowStyle CssClass="tr_line1" />
                                                                                    <AlternatingRowStyle CssClass="tr_line2" />
                                                                                </asp:GridView>
                                                                                <cc1:CalendarExtender ID="CalendarExtender3" runat="server" TargetControlID="txtdtfromamc2"
                                                                                    Format="dd/MM/yyyy">
                                                                                </cc1:CalendarExtender>
                                                                                <%-- <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="txtdtfromamc2"
                                                                                            Mask="99/99/9999" MaskType="Date">
                                                                                        </cc1:MaskedEditExtender>--%>
                                                                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender3" runat="server" TargetControlID="txtdtfromamc2"
                                                                                    WatermarkText="From..">
                                                                                </cc1:TextBoxWatermarkExtender>
                                                                                <cc1:CalendarExtender ID="CalendarExtender4" runat="server" TargetControlID="txtdttoamc2"
                                                                                    Format="dd/MM/yyyy">
                                                                                </cc1:CalendarExtender>
                                                                                <cc1:MaskedEditExtender ID="MaskedEditExtender4" runat="server" TargetControlID="txtdttoamc2"
                                                                                    Mask="99/99/9999" MaskType="Date">
                                                                                </cc1:MaskedEditExtender>
                                                                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender4" runat="server" TargetControlID="txtdttoamc2"
                                                                                    WatermarkText="To..">
                                                                                </cc1:TextBoxWatermarkExtender>
                                                                            </div>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <fieldset class="Newfield">
                                                                                <legend>Message</legend>
                                                                                <table width="100%">
                                                                                    <tr>
                                                                                        <td align="right" style="width: 23.5%;">
                                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator15Msg" runat="server" ForeColor="Red"
                                                                                                ValidationGroup="chk94" ControlToValidate="txtCommentsTxt"></asp:RequiredFieldValidator>
                                                                                            <strong><span class="astrics">*</span> Message :</strong>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:TextBox ID="txtCommentsTxt" MaxLength="100" TextMode="MultiLine" Width="95%"
                                                                                                Height="30px" CssClass="textbox_pop" onkeyDown="return checkTextAreaMaxLength(this,event,'25');"
                                                                                                runat="server"></asp:TextBox>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td></td>
                                                                                        <td class="astrics">Message should be in 25 character
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </fieldset>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <fieldset class="Newfield">
                                                                                <legend>Message Audio Files(*.wav)</legend>
                                                                                <table width="98%" cellpadding="0" cellspacing="2">
                                                                                    <tr>
                                                                                        <td></td>
                                                                                        <td></td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <asp:Label ID="Label10" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td align="right" style="width: 8%">
                                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorHindi" runat="server" ForeColor="Red"
                                                                                                ValidationGroup="chk94" ControlToValidate="flSoundH"></asp:RequiredFieldValidator>
                                                                                            <strong>
                                                                                                <asp:Label ID="L2" runat="server" CssClass="astrics" Text="*"></asp:Label>
                                                                                                Hindi :</strong>
                                                                                        </td>
                                                                                        <td style="width: 40%">
                                                                                            <asp:FileUpload ID="flSoundH" onchange="fileTypeCheckengH(this.value);" runat="server"
                                                                                                Style="width: 88%;" />
                                                                                        </td>
                                                                                        <td align="right" style="width: 10%">
                                                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6English" runat="server" ForeColor="Red"
                                                                                                ValidationGroup="chk94" ControlToValidate="flSoundE"></asp:RequiredFieldValidator>
                                                                                            <strong>
                                                                                                <asp:Label ID="L1" runat="server" CssClass="astrics" Text="*"></asp:Label>
                                                                                                English :</strong>
                                                                                        </td>
                                                                                        <td>
                                                                                            <asp:FileUpload ID="flSoundE" onchange="fileTypeCheckengE(this.value);" runat="server"
                                                                                                Style="width: 88%;" />
                                                                                        </td>
                                                                                    </tr>
                                                                                    <tr>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <asp:Label ID="lblfileH" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
                                                                                        </td>
                                                                                        <td></td>
                                                                                        <td>
                                                                                            <asp:Label ID="lblfileE" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
                                                                                        </td>
                                                                                    </tr>
                                                                                </table>
                                                                            </fieldset>
                                                                        </td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2" style="height: 10px;"></td>
                                                                    </tr>
                                                                    <tr>
                                                                        <td colspan="2">
                                                                            <asp:Label ID="lblnoteSound" Style="font-family: Arial; font-size: 12px; color: red;"
                                                                                runat="server" Text="Note:- Audio file to be uploaded on the website should be in the prescribed format as below"></asp:Label>
                                                                            <br />
                                                                            <asp:Label ID="Label11" Style="font-family: Arial; font-size: 12px; color: red;"
                                                                                runat="server" Text="File Type ---- .wav"></asp:Label>
                                                                            <br />
                                                                            <asp:Label ID="lblfileformat" Style="font-family: Arial; font-size: 12px; color: red;"
                                                                                runat="server" Text="Format ---- 8KHz, 16bit mono"></asp:Label>
                                                                            <br />
                                                                            <asp:Label ID="lblBitRate" Style="font-family: Arial; font-size: 12px; color: red;"
                                                                                runat="server" Text="Bit Rate ---- 128 kbps"></asp:Label>
                                                                            <br />
                                                                            <asp:Label ID="Label12" Style="font-family: Arial; font-size: 12px; color: Blue;"
                                                                                runat="server" Text="For record the audio file, Please click the link "></asp:Label>&nbsp;
                                                                                    <a href="http://wavepad.en.softonic.com/" style="font-family: Arial; font-size: 12px; color: Blue;" target="_blank">Click</a>
                                                                        </td>
                                                                    </tr>
                                                                </table>
                                                            </div>
                                                            <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                                                <tr>
                                                                    <td align="left">
                                                                        <asp:Button ID="btnPre2" OnClick="btnPre2_Click" CssClass="button_all" runat="server"
                                                                            Text="Pre" Visible="false" />
                                                                    </td>
                                                                    <td align="right">
                                                                        <asp:Button ID="btnNext3" OnClick="btnNext3_Click" CssClass="button_all" runat="server"
                                                                            Text="Next" Visible="false" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                            <table width="100%">
                                                                <tr>
                                                                    <td align="left">
                                                                        <asp:Button ID="btnPre4" OnClick="btnPre4_Click" CssClass="button_all" runat="server"
                                                                            Text="Pre" Visible="false" />
                                                                    </td>
                                                                    <td align="right" style="padding-right: 25px;" colspan="2">
                                                                        <asp:Button ID="btnSave" OnClick="btnSave_Click" ValidationGroup="chk94" CssClass="button_all"
                                                                            runat="server" Text="Save" />
                                                                        <asp:Button ID="btnReset" OnClick="btnReset_Click" CssClass="button_all" runat="server"
                                                                            CausesValidation="false" Text="Reset" />
                                                                    </td>
                                                                </tr>
                                                            </table>
                                                        </ContentTemplate>
                                                        <Triggers>
                                                            <asp:PostBackTrigger ControlID="btnSave" />
                                                        </Triggers>
                                                    </asp:UpdatePanel>
                                                </ContentTemplate>
                                            </cc1:TabPanel>
                                        </cc1:TabContainer>
                                    </ContentTemplate>
                                </asp:UpdatePanel>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
            </ContentTemplate>
        </asp:UpdatePanel>
        <cc1:ModalPopupExtender ID="ModalPopupExtender1" runat="server" BackgroundCssClass="NewmodalBackground"
            PopupControlID="PanelProduct" TargetControlID="Label1" CancelControlID="Button1">
        </cc1:ModalPopupExtender>
        <asp:Label ID="Label1" runat="server"></asp:Label>
        <!-- Pop Alert -->
        <asp:HiddenField ID="hdnoldAmcId" runat="server" />
        <asp:Label ID="lblproiddel" runat="server" ForeColor="White"></asp:Label>
        <asp:HiddenField ID="hhdnCompID" runat="server" />
        <asp:UpdatePanel ID="UpdatePanel4" runat="server">
            <ContentTemplate>
                <asp:Panel ID="PanelAlert" runat="server" Width="25%" Style="display: none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnclosealert" CssClass="popupClose" runat="server" />
                            </div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="LabelAlert" runat="server" Font-Bold="true" Text="Alert"></asp:Label>
                                    </span>
                                </p>
                            </div>
                            <div class="regis_popup">
                                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                                    <tr>
                                        <td align="center">
                                            <asp:Label ID="lblalert" runat="server" Font-Bold="true" Font-Size="10pt"></asp:Label>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td style="height: 7px;"></td>
                                    </tr>
                                    <tr align="center">
                                        <td>
                                            <asp:Button ID="btnYesAlert" runat="server" OnClick="btnYesAlert_Click" CssClass="button_all"
                                                CausesValidation="false" Text="Yes" />&nbsp;&nbsp;
                                                    <asp:Button ID="btnNoAlert" runat="server" OnClick="btnNoAlert_Click" CssClass="button_all"
                                                        Text="No" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupExtenderAlert" runat="server" BackgroundCssClass="NewmodalBackground"
                    PopupControlID="PanelAlert" TargetControlID="LabelAlertT" CancelControlID="btnclosealert">
                </cc1:ModalPopupExtender>
                <asp:Label ID="LabelAlertT" runat="server"></asp:Label>
                <asp:HiddenField ID="HdLabelCode" runat="server" />
                <asp:HiddenField ID="HdLabelCodeRequest" runat="server" />
                <asp:HiddenField ID="HdPro_ID" runat="server" />
                <asp:HiddenField ID="HdPromoId" runat="server" />
                <asp:Panel ID="PanelAmcRenewal" runat="server" Style="width: 60%; display: none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnAmcRenewalpopClose" CssClass="popupClose" runat="server" />
                            </div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="LblAmcRenewalHeader" runat="server" Font-Bold="true" Text="Amc Renewal"></asp:Label>
                                    </span>
                                </p>
                            </div>
                            <div class="regis_popup">
                                <div id="Div2" runat="server" style="width: 89%;">
                                    <p>
                                        <asp:Label ID="Label8" runat="server"></asp:Label>
                                    </p>
                                </div>
                                <div id="DivNewMsg1" runat="server" style="width: 89%;">
                                    <p>
                                        <asp:Label ID="LabelAmcRenewalmsg" runat="server"></asp:Label>
                                    </p>
                                    <asp:HiddenField ID="currindex" runat="server" />
                                </div>
                                <div id="MyAmcOfferDetails" runat="server">
                                    <asp:HiddenField ID="HdnUpdatePlanTime" runat="server" />
                                    <asp:HiddenField ID="HdnUpdatePlanStatus" runat="server" />
                                    <asp:HiddenField ID="HdnUpdatePlanID" runat="server" />
                                    <asp:HiddenField ID="HdnUpdatePlanType" runat="server" />
                                    <asp:HiddenField ID="HdnUpdatePlanTransID" runat="server" />
                                    <asp:HiddenField ID="HdnUpdatePlanAmount" runat="server" />
                                    <asp:HiddenField ID="hdnAmcDateFrom" runat="server" />
                                    <asp:HiddenField ID="hdnAmcDateTo" runat="server" />
                                    <asp:GridView ID="GrdProductsAmc" runat="server" AutoGenerateColumns="False" CssClass="grid"
                                        DataKeyNames="Trans_Type,IsCancel" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                                        EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                                        BorderColor="transparent" OnRowCommand="GrdProductsAmc_RowCommand">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Amc Name">
                                                <ItemTemplate>
                                                    <asp:Label ID="proAmcType" runat="server" Text='<%# Bind("Plan_Name") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                <ItemStyle HorizontalAlign="Left" CssClass="grd_pad" Width="15%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Plan Amount">
                                                <ItemTemplate>
                                                    <asp:Label ID="proplanAmt" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                        runat="server" Text='<%# Bind("Plan_Amount") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                <ItemStyle HorizontalAlign="Left" CssClass="grd_pad" Width="15%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="proplanvrstatus" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                <ItemStyle HorizontalAlign="Left" Width="12%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Start Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="proplanstdate" runat="server" Text='<%# Bind("Date_From") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                <ItemStyle HorizontalAlign="Left" Width="12%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="End Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="proplanenddate" runat="server" Text='<%# Bind("Date_To") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                <ItemStyle HorizontalAlign="Left" Width="12%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Discount">
                                                <ItemTemplate>
                                                    <asp:Label ID="LblAmcdisprices" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                        runat="server" Text='<%# Bind("Plan_Discount") %>'></asp:Label>
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                                            </asp:TemplateField>
                                            <%-- <asp:TemplateField HeaderText="Requested">
                                                        <ItemTemplate>
                                                            <asp:Label ID="proplandueAmt" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                                runat="server" Text='<%# Bind("Pending_Balance") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                        <ItemStyle HorizontalAlign="Center" Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Due Amount">
                                                        <ItemTemplate>
                                                            <asp:Label ID="proplandueAmtM" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                                runat="server" Text='<%# Bind("Manu_Balance") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                        <ItemStyle HorizontalAlign="Center" Width="15%" />
                                                    </asp:TemplateField>--%>
                                            <asp:TemplateField HeaderText="Action">
                                                <ItemTemplate>
                                                    <%try
                                                        {
                                                            IsCancel = Convert.ToInt32(GrdProductsAmc.DataKeys[upplanindex].Values["IsCancel"].ToString());
                                                        }
                                                        catch { }
                                                        if (IsCancel == 1)
                                                        {%>
                                                    <asp:ImageButton CausesValidation="false" runat="server" ID="imgupdateplan" CommandArgument='<%# Bind("Trans_ID") %>'
                                                        CommandName="UpgradePlan" ImageUrl="~/images/edit.png" />&nbsp;
                                                            <asp:ImageButton CausesValidation="false" runat="server" ID="imgupdateplancan" CommandArgument='<%# Bind("Trans_ID") %>'
                                                                CommandName="CancelPlan" ImageUrl="~/images/delete.png" ToolTip="Cancel" />
                                                    <%}
                                                        else
                                                        { %>
                                                    <asp:Label ID="lblccplancan" runat="server" Text="Cancelled"></asp:Label>
                                                    <%} %>
                                                    <%upplanindex++; %>
                                                </ItemTemplate>
                                                <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                <ItemStyle HorizontalAlign="Center" Width="7%" />
                                            </asp:TemplateField>
                                        </Columns>
                                        <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                        <RowStyle CssClass="tr_line1" />
                                        <AlternatingRowStyle CssClass="tr_line2" />
                                    </asp:GridView>
                                </div>
                                <hr />
                                <table id="MyAmcOfferGrdVw" runat="server" width="100%">
                                    <tr>
                                        <td style="width: 25%; vertical-align: top;">
                                            <asp:HiddenField ID="HdValAMC1" runat="server" />
                                            <asp:HiddenField ID="HdDateTo1" runat="server" />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator5" ValidationGroup="AMC" runat="server"
                                                ControlToValidate="txtdtfromamc1"></asp:RequiredFieldValidator>
                                            <strong><span class="astrics">*</span>Date From : -</strong><br />
                                            <asp:TextBox ID="txtdtfromamc1" onchange="FindNextDate12(this.value);" runat="server"
                                                onkeydown="return checkShortcut();" CssClass="reg_txt"></asp:TextBox><br />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="txtdttoamc1"></asp:RequiredFieldValidator>
                                            <strong><span class="astrics">*</span>Date To : -</strong><br />
                                            <asp:TextBox ID="txtdttoamc1" Enabled="false" runat="server" CssClass="reg_txt"></asp:TextBox><br />
                                            <br />
                                            <asp:Label ID="lblAmcText" runat="server" Style="font-size: 14px;">Old Amc End Date :</asp:Label>
                                            <br />
                                            <asp:Label ID="lblAmcenddate" runat="server" Font-Bold="true" Font-Size="12px" CssClass="astrics"
                                                Text=""></asp:Label>
                                        </td>
                                        <td style="width: 74%; vertical-align: top;">
                                            <asp:GridView ID="GrdVwAmcRenewal" runat="server" AutoGenerateColumns="False" DataKeyNames="Plan_ID,Disp"
                                                CssClass="grid" EmptyDataText="Record Not Found" EnableModelValidation="True"
                                                PageSize="5" Width="100%" BorderStyle="None" BorderWidth="0px" BorderColor="Transparent">
                                                <Columns>
                                                    <asp:TemplateField>
                                                        <ItemTemplate>
                                                            <%try
                                                                {
                                                                    PlanID = GrdVwAmcRenewal.DataKeys[upplanindex].Values["Plan_ID"].ToString();//LabelFlag 
                                                                    Disp = Convert.ToInt32(GrdVwAmcRenewal.DataKeys[upplanindex].Values["Disp"].ToString());
                                                                }
                                                                catch { }
                                                                if (Session["Plan_ID"].ToString() == PlanID)
                                                                {
                                                                    if (Disp == 0)
                                                                    {
                                                            %>
                                                            <input type="radio" id="Radio4" name="rdamcrew" checked="checked" value='<%# Eval("PlanInfo") %>'
                                                                onclick="javascript: SelectSingleRadiobuttonNew12(this.id)" />
                                                            <%}
                                                                else
                                                                { %>
                                                            <input type="radio" id="Radio5" name="rdamcrew" checked="checked" disabled="disabled"
                                                                value='<%# Eval("PlanInfo") %>' onclick="javascript: SelectSingleRadiobuttonNew12(this.id)" />
                                                            <%
                                                                    }
                                                                }
                                                                else
                                                                {
                                                                    if (Disp == 0)
                                                                    {%>
                                                            <input type="radio" id="rdamcrenewal123" name="rdamcrew" value='<%# Eval("PlanInfo") %>'
                                                                onclick="javascript: SelectSingleRadiobuttonNew12(this.id)" />
                                                            <% }
                                                                else
                                                                {%>
                                                            <input type="radio" id="Radio6" name="rdamcrew" disabled="disabled" value='<%# Eval("PlanInfo") %>'
                                                                onclick="javascript: SelectSingleRadiobuttonNew12(this.id)" />
                                                            <%}
                                                                }%>
                                                            <%upplanindex++; %>
                                                            <asp:Label ID="lblrenewalPlanID" runat="server" Text='<%# Bind("Plan_ID") %>' Visible="false"></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Plan Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblplanmanewithrenewal" runat="server" Text='<%# Bind("Plan_Name") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                        <ItemStyle HorizontalAlign="Justify" Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Amount">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblplanpricerenewal" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                                runat="server" Text='<%# Bind("Plan_Amount") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Right" Width="10%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Service Tax">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblplanrserprice" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                                runat="server" Text='<%# Bind("STAX") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Right" Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="VAT">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblplanrvatprice" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                                runat="server" Text='<%# Bind("VTAX") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Right" Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Net Amount">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblplanrnetprice" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                                runat="server" Text='<%# Bind("Plan_AmountN") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Right" Width="20%" />
                                                    </asp:TemplateField>
                                                </Columns>
                                                <EmptyDataRowStyle HorizontalAlign="Center" />
                                                <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                <RowStyle CssClass="tr_line1" />
                                                <AlternatingRowStyle CssClass="tr_line2" />
                                            </asp:GridView>
                                            <cc1:CalendarExtender ID="CalendarerExtender3" runat="server" TargetControlID="txtdtfromamc1"
                                                Format="dd/MM/yyyy">
                                            </cc1:CalendarExtender>
                                            <cc1:TextBoxWatermarkExtender ID="TextewrwBoxWatermarkExtender3" runat="server" TargetControlID="txtdtfromamc1"
                                                WatermarkText="From..">
                                            </cc1:TextBoxWatermarkExtender>
                                            <cc1:CalendarExtender ID="CalendarExerwtender4" runat="server" TargetControlID="txtdttoamc1"
                                                Format="dd/MM/yyyy">
                                            </cc1:CalendarExtender>
                                            <cc1:MaskedEditExtender ID="MaskedEditwerweExtender4" runat="server" TargetControlID="txtdttoamc1"
                                                Mask="99/99/9999" MaskType="Date">
                                            </cc1:MaskedEditExtender>
                                            <cc1:TextBoxWatermarkExtender ID="TextBowerxWatermarkExtender4" runat="server" TargetControlID="txtdttoamc1"
                                                WatermarkText="To..">
                                            </cc1:TextBoxWatermarkExtender>
                                        </td>
                                    </tr>
                                </table>
                                <table width="100%" id="MyOfferGrdVw" runat="server">
                                    <tr>
                                        <td style="width: 25%; vertical-align: top;">
                                            <asp:HiddenField ID="lblproidamc" runat="server" />
                                            <asp:HiddenField ID="HdValAMC3" runat="server" />
                                            <asp:HiddenField ID="HdDateTo3" runat="server" />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator3" ValidationGroup="promo"
                                                runat="server" ControlToValidate="txtdtfromamc3"></asp:RequiredFieldValidator>
                                            <strong><span class="astrics">*</span>Date From : -</strong><br />
                                            <asp:TextBox ID="txtdtfromamc3" onchange="FindNextDatePromotionalNew(this.value);"
                                                onkeydown="return checkShortcut();" runat="server" CssClass="reg_txt"></asp:TextBox><br />
                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator9" runat="server" ControlToValidate="txtdttoamc3"></asp:RequiredFieldValidator>
                                            <strong><span class="astrics">*</span>Date To : -</strong><br />
                                            <asp:TextBox ID="txtdttoamc3" Enabled="false" runat="server" CssClass="reg_txt"></asp:TextBox><br />
                                            <span style="color: Red; font-size: 11px;">Please select Offer period within AMC period
                                                        only. First finalize AMC Period.</span>
                                            <br />
                                            AMC Start Date :
                                                    <asp:Label ID="lblCurrAmcStartDate" runat="server" Style="color: Blue; font-size: 12px;" />
                                            <br />
                                            AMC End Date :
                                                    <asp:Label ID="lblCurrAmcEndDate" runat="server" Style="color: Blue; font-size: 12px;" />
                                        </td>
                                        <td>
                                            <div style="overflow: auto; height: 150px;">
                                                <asp:GridView ID="GrdVwOfferDetails" runat="server" AutoGenerateColumns="False" DataKeyNames="Promo_ID,Disp"
                                                    CssClass="grid" EmptyDataText="Record Not Found" EnableModelValidation="True"
                                                    PageSize="5" Width="100%" BorderStyle="None" BorderWidth="0px" BorderColor="Transparent">
                                                    <Columns>
                                                        <asp:TemplateField>
                                                            <ItemTemplate>
                                                                <%try
                                                                    {
                                                                        PromoID = GrdVwOfferDetails.DataKeys[promoind].Values["Promo_ID"].ToString();
                                                                        Disp = Convert.ToInt32(GrdVwOfferDetails.DataKeys[promoind].Values["Disp"].ToString());
                                                                    }
                                                                    catch { }
                                                                    if (Session["PromoId"].ToString() == PromoID)
                                                                    {
                                                                        if (Disp == 0)
                                                                        {
                                                                %>
                                                                <input type="radio" id="rdPromo" name="rdPromo" checked="checked" title='<%# Eval("Time_Days") %>'
                                                                    value='<%# Eval("Promo_ID") %>' onclick="javascript: SelectSinglePromotionalNew(this.id, this.title)" />
                                                                <%                                                                            
                                                                    }
                                                                    else
                                                                    {%>
                                                                <input type="radio" id="rdPromon1" name="rdPromo" disabled="disabled" checked="checked"
                                                                    title='<%# Eval("Time_Days") %>' value='<%# Eval("Promo_ID") %>' onclick="javascript: SelectSinglePromotionalNew(this.id, this.title)" />
                                                                <%}
                                                                    }
                                                                    else
                                                                    {
                                                                        if (Disp == 0)
                                                                        {
                                                                %>
                                                                <input type="radio" id="rdPromo2" name="rdPromo" title='<%# Eval("Time_Days") %>'
                                                                    value='<%# Eval("Promo_ID") %>' onclick="javascript: SelectSinglePromotionalNew(this.id, this.title)" />
                                                                <%
                                                                    }
                                                                    else
                                                                    {
                                                                %>
                                                                <input type="radio" id="rdPromon2" name="rdPromo" title='<%# Eval("Time_Days") %>'
                                                                    disabled="disabled" value='<%# Eval("Promo_ID") %>' onclick="javascript: SelectSinglePromotionalNew(this.id, this.title)" />
                                                                <%
                                                                        }
                                                                    } %>
                                                                <%promoind++; %>
                                                                <asp:Label ID="lblPromoPlanID" runat="server" Text='<%# Bind("Promo_ID") %>' Visible="false"></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                            <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Promotional Plan Name">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPromoplnNm" runat="server" Text='<%# Bind("Promo_Name") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                            <ItemStyle HorizontalAlign="Justify" Width="35%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Time(In Days)">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPromoplnNm" runat="server" Text='<%# Bind("Time_Days") %>'></asp:Label>
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                            <ItemStyle HorizontalAlign="Justify" Width="15%" />
                                                        </asp:TemplateField>
                                                        <asp:TemplateField HeaderText="Amount">
                                                            <ItemTemplate>
                                                                <asp:Label ID="lblPromoAmt" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                                    runat="server" Text='<%# Bind("Amount") %>'></asp:Label>+(Applicable Tax)
                                                            </ItemTemplate>
                                                            <HeaderStyle CssClass="tr_haed" Font-Size="12px" HorizontalAlign="Center" />
                                                            <ItemStyle HorizontalAlign="Center" Width="25%" />
                                                        </asp:TemplateField>
                                                    </Columns>
                                                    <EmptyDataRowStyle HorizontalAlign="Center" />
                                                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                    <RowStyle CssClass="tr_line1" />
                                                    <AlternatingRowStyle CssClass="tr_line2" />
                                                </asp:GridView>
                                                <cc1:CalendarExtender ID="CalendarExtender5" runat="server" TargetControlID="txtdtfromamc3"
                                                    Format="dd/MM/yyyy">
                                                </cc1:CalendarExtender>
                                                <%-- <cc1:MaskedEditExtender ID="MaskedEditExtender5" runat="server" TargetControlID="txtdtfromamc3"
                                                            Mask="99/99/9999" MaskType="Date">
                                                        </cc1:MaskedEditExtender>--%>
                                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender5" runat="server" TargetControlID="txtdtfromamc3"
                                                    WatermarkText="From..">
                                                </cc1:TextBoxWatermarkExtender>
                                                <cc1:CalendarExtender ID="CalendarExtender6" runat="server" TargetControlID="txtdttoamc3"
                                                    Format="dd/MM/yyyy">
                                                </cc1:CalendarExtender>
                                                <cc1:MaskedEditExtender ID="MaskedEditExtender6" runat="server" TargetControlID="txtdttoamc3"
                                                    Mask="99/99/9999" MaskType="Date">
                                                </cc1:MaskedEditExtender>
                                                <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender6" runat="server" TargetControlID="txtdttoamc3"
                                                    WatermarkText="To..">
                                                </cc1:TextBoxWatermarkExtender>
                                            </div>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <fieldset class="Newfield">
                                                <legend>Message</legend>
                                                <table width="100%">
                                                    <tr>
                                                        <td align="right" style="width: 25%;">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator12" runat="server" ForeColor="Red"
                                                                ValidationGroup="promo" ControlToValidate="txtComment"></asp:RequiredFieldValidator>
                                                            <asp:CheckBox ID="chkComments" runat="server" Text="  Use Old" onchange="javascript:chkuseoldcomments();" />
                                                            <strong><span class="astrics">*</span> Message :</strong>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtComment" MaxLength="100" TextMode="MultiLine" Width="95%" Height="30px"
                                                                CssClass="textbox_pop" onkeyDown="return checkTextAreaMaxLength(this,event,'25');"
                                                                runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td class="astrics">Comment should be in 25 character
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <fieldset class="Newfield">
                                                <legend>Message Audio Files(*.wav)</legend>
                                                <table width="98%" cellpadding="0" cellspacing="2">
                                                    <tr>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label13" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr style="display: none;">
                                                        <td colspan="3" align="left">
                                                            <asp:CheckBox ID="CheckBox1" runat="server" Text="  Use Old" onchange="chkuseoldsoundh();" />
                                                        </td>
                                                        <td colspan="3" align="left">
                                                            <asp:CheckBox ID="CheckBox2" Text="   Use Old" runat="server" onchange="chkuseoldsounde();" />
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" style="width: 8%">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator10" runat="server" ForeColor="Red"
                                                                ValidationGroup="promo" ControlToValidate="flSoundPH"></asp:RequiredFieldValidator>
                                                            <strong><span class="astrics">*</span> Hindi :</strong>
                                                        </td>
                                                        <td style="width: 35%">
                                                            <asp:FileUpload ID="flSoundPH" onchange="fileTypeCheckengH(this.value);" runat="server"
                                                                Style="width: 88%;" />
                                                        </td>
                                                        <td align="right" style="width: 5%">
                                                            <ul class="graphic">
                                                                <li><a id="A1" runat="server" class="sm2_link" target="_blank" title="Hindi File play"
                                                                    style="cursor: pointer; display: none;"></a></li>
                                                            </ul>
                                                        </td>
                                                        <td align="right" style="width: 10%">
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator11" runat="server" ForeColor="Red"
                                                                ValidationGroup="promo" ControlToValidate="flSoundPE"></asp:RequiredFieldValidator>
                                                            <strong><span class="astrics">*</span> English :</strong>
                                                        </td>
                                                        <td style="width: 35%">
                                                            <asp:FileUpload ID="flSoundPE" onchange="fileTypeCheckengE(this.value);" runat="server"
                                                                Style="width: 88%;" />
                                                        </td>
                                                        <td>
                                                            <ul class="graphic">
                                                                <li><a id="A2" runat="server" target="_blank" class="sm2_link" title="English File play"
                                                                    style="cursor: pointer; display: none;"></a></li>
                                                            </ul>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label16" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
                                                        </td>
                                                        <td></td>
                                                        <td>
                                                            <asp:Label ID="Label17" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2" style="height: 10px;"></td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Label ID="Label18" Style="font-family: Arial; font-size: 12px; color: red;"
                                                runat="server" Text="Note:- Audio file to be uploaded on the website should be in the prescribed format as below"></asp:Label>
                                            <br />
                                            <asp:Label ID="Label19" Style="font-family: Arial; font-size: 12px; color: red;"
                                                runat="server" Text="File Type ---- .wav"></asp:Label>
                                            <br />
                                            <asp:Label ID="Label20" Style="font-family: Arial; font-size: 12px; color: red;"
                                                runat="server" Text="Format ---- 8KHz, 16bit mono"></asp:Label>
                                            <br />
                                            <asp:Label ID="Label21" Style="font-family: Arial; font-size: 12px; color: red;"
                                                runat="server" Text="Bit Rate ---- 128 kbps"></asp:Label>
                                            <br />
                                            <asp:Label ID="Label22" Style="font-family: Arial; font-size: 12px; color: Blue;"
                                                runat="server" Text="For record the audio file, Please click the link "></asp:Label>&nbsp;
                                                    <a href="http://wavepad.en.softonic.com/" style="font-family: Arial; font-size: 12px; color: Blue;"
                                                        target="_blank">Click</a>
                                        </td>
                                    </tr>
                                </table>
                                <table style="text-align: right !important; width: 100%;">
                                    <tr>
                                        <td style="text-align: right !important;">
                                            <asp:Button ID="btnAmcRenewal" ValidationGroup="AMC" runat="server" OnClick="btnAmcRenewal_Click"
                                                CssClass="button_all" Text="Save" />
                                            <asp:Button ID="btnOfferRenewal" runat="server" OnClick="btnOfferRenewal_Click" CssClass="button_all"
                                                Text="Save" ValidationGroup="promo" Visible="false" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupAmcRenewal" runat="server" BackgroundCssClass="NewmodalBackground"
                    PopupControlID="PanelAmcRenewal" TargetControlID="LabelAmcRenewalT" CancelControlID="btnAmcRenewalpopClose">
                </cc1:ModalPopupExtender>
                <asp:Label ID="LabelAmcRenewalT" runat="server"></asp:Label>
                <asp:Panel ID="PanelPopupCancelRequest" runat="server" Width="25%" Style="display: none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="BtnClosePopupRequest" CssClass="popupClose" runat="server" />
                            </div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="Label5" runat="server" Font-Bold="true" Text="Confirmmation"></asp:Label>
                                    </span>
                                </p>
                            </div>
                            <div class="regis_popup">
                                <table>
                                    <tr>
                                        <td style="width: 25%; vertical-align: top;">
                                            <asp:Label ID="lblTextAlert" runat="server"></asp:Label>
                                            <br />
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center">
                                            <asp:Button ID="btnYesConfirm" runat="server" CssClass="button_all" OnClick="btnYesConfirm_Click"
                                                CausesValidation="false" Text="Yes" />&nbsp;&nbsp;&nbsp;<asp:Button CssClass="button_all"
                                                    ID="btnNoConfirm" runat="server" Text="No" CausesValidation="false" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupCancelRequest" runat="server" BackgroundCssClass="NewmodalBackground"
                    BehaviorID="CancelPendingRequest" PopupControlID="PanelPopupCancelRequest" TargetControlID="Label12Request"
                    CancelControlID="BtnClosePopupRequest" OkControlID="btnNoConfirm">
                </cc1:ModalPopupExtender>
                <asp:Label ID="Label12Request" runat="server"></asp:Label>
                <!---**************Start popup fot Offer Cancel**************** -->
                <asp:Panel ID="PanelPopupCancelOffer" runat="server" Width="25%" Style="display: none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="BtnClosePopupOffer" CssClass="popupClose" runat="server" />
                            </div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="lblBeyondOffer" runat="server" Font-Bold="true" Text="Confirmmation"></asp:Label>
                                    </span>
                                </p>
                            </div>
                            <div class="regis_popup">
                                <asp:GridView ID="GrdVwBeyondOffer" runat="server" AutoGenerateColumns="False" CssClass="grid"
                                    DataKeyNames="Trans_Type" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                                    EnableModelValidation="True" Width="100%" BorderStyle="None" BorderWidth="0"
                                    BorderColor="transparent" OnRowCommand="GrdProductsAmc_RowCommand">
                                    <Columns>
                                        <asp:TemplateField HeaderText="Amc Name">
                                            <ItemTemplate>
                                                <asp:Label ID="proAmcType" runat="server" Text='<%# Bind("Plan_Name") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                            <ItemStyle HorizontalAlign="Left" CssClass="grd_pad" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Plan Amount">
                                            <ItemTemplate>
                                                <asp:Label ID="proplanAmt" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                    runat="server" Text='<%# Bind("Plan_Amount") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                            <ItemStyle HorizontalAlign="Left" CssClass="grd_pad" Width="15%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Status">
                                            <ItemTemplate>
                                                <asp:Label ID="proplanvrstatus" runat="server" Text='<%# Bind("Status") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                            <ItemStyle HorizontalAlign="Left" Width="12%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Start Date">
                                            <ItemTemplate>
                                                <asp:Label ID="proplanstdate" runat="server" Text='<%# Bind("Date_From") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                            <ItemStyle HorizontalAlign="Left" Width="12%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="End Date">
                                            <ItemTemplate>
                                                <asp:Label ID="proplanenddate" runat="server" Text='<%# Bind("Date_To") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                            <ItemStyle HorizontalAlign="Left" Width="12%" />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Discount">
                                            <ItemTemplate>
                                                <asp:Label ID="LblAmcdisprices" Style="padding-left: 10px;" CssClass="txt_rupees rupees"
                                                    runat="server" Text='<%# Bind("Plan_Discount") %>'></asp:Label>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" Width="10%" />
                                        </asp:TemplateField>
                                    </Columns>
                                    <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                    <RowStyle CssClass="tr_line1" />
                                    <AlternatingRowStyle CssClass="tr_line2" />
                                </asp:GridView>
                                <div>
                                    <asp:Button ID="btnbeyondoffer" runat="server" CssClass="button_all" OnClick="btnbeyondoffer_Click"
                                        CausesValidation="false" Text="Cancelled All Offer" />
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupCancelOffer" runat="server" BackgroundCssClass="NewmodalBackground"
                    BehaviorID="CancelBeyondOffer" PopupControlID="PanelPopupCancelOffer" TargetControlID="Label12CancelOffer"
                    CancelControlID="BtnClosePopupOffer" OkControlID="BtnClosePopupOffer">
                </cc1:ModalPopupExtender>
                <asp:Label ID="Label12CancelOffer" runat="server"></asp:Label>
                <!---**************End popup fot Offer Cancel**************** -->
            </ContentTemplate>
        </asp:UpdatePanel>
        <!--PopUp Close-->
        <!-------------------Start Popup--------------->
        <asp:Panel ID="GivenGracePanel" runat="server" Width="25%" Style="display: none;">
            <div class="popupContent" style="width: 100%;">
                <div class="pop_log_bg">
                    <div>
                        <asp:Button ID="btnpopplancan" CssClass="popupClose" runat="server" />
                    </div>
                    <div class="service_head_p">
                        <p>
                            <span class="left">
                                <asp:Label ID="GPHeadLabel" runat="server" Font-Bold="true"></asp:Label>
                            </span>
                        </p>
                    </div>
                    <div class="regis_popup">
                        <table id="details" runat="server">
                            <tr>
                                <td style="width: 30%; text-align: right;">
                                    <strong>Start Date : </strong>
                                </td>
                                <td style="width: 25%; vertical-align: top;">
                                    <asp:Label ID="lblstdate" runat="server"></asp:Label>
                                    <br />
                                </td>
                                <td style="width: 30%; text-align: right;">
                                    <strong>End Date : </strong>
                                </td>
                                <td>
                                    <asp:Label ID="lblenddate" runat="server"></asp:Label>&nbsp;
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;" id="Table1" runat="server">
                            <tr>
                                <td colspan="4" align="center">
                                    <asp:Label ID="lblMsgAlert" runat="server" />
                                </td>
                            </tr>
                            <tr id="remarks" runat="server">
                                <td style="width: 30%; vertical-align: top; text-align: right;">
                                    <strong>Remarks : </strong>
                                </td>
                                <td colspan="3">
                                    <asp:TextBox ID="txtremarks" TextMode="MultiLine" Width="98%" runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'150');"></asp:TextBox>
                                </td>
                            </tr>
                        </table>
                        <table style="width: 100%;">
                            <tr>
                                <td align="center" colspan="4">
                                    <asp:Button ID="btnYes" runat="server" CssClass="button_all" OnClick="btnYes_Click"
                                        CausesValidation="false" Text="OK" />
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </asp:Panel>
        <cc1:ModalPopupExtender ID="ModalPopupForGp" runat="server" BackgroundCssClass="NewmodalBackground"
            PopupControlID="GivenGracePanel" TargetControlID="Label15" CancelControlID="btnpopplancan">
        </cc1:ModalPopupExtender>
        <asp:Label ID="Label15" runat="server"></asp:Label>
        <asp:Label ID="LabelExectute" runat="server" Visible="false"></asp:Label>
        <!-------------------End Popup--------------->
        <!-------------------Start Loyalty Popup--------------->
        <asp:Panel ID="AddLoyaltyPanel" runat="server" Width="30%" Style="display: none;">
            <div class="popupContent" style="width: 100%;">
                <div class="pop_log_bg">
                    <div>
                        <asp:Button ID="btncloseloyalty" CssClass="popupClose" runat="server" />
                    </div>
                    <div class="service_head_p">
                        <p>
                            <span class="left">
                                <asp:Label ID="Lblloyaltyhead" runat="server" Font-Bold="true"></asp:Label>
                            </span>
                        </p>
                    </div>
                    <div class="regis_popup">
                        <table cellpadding="0px" cellspacing="10px" width="100%" class="grid" style="line-height: 25px; padding: 10px;">
                            <tr style="display: none;">
                                <td style="width: 30%; text-align: right;">
                                    <strong>Loyalty : </strong><span class="astrics">*</span>
                                </td>
                                <td style="vertical-align: top;">
                                    <asp:CheckBox runat="server" ValidationGroup="LOY" ID="chkloyalty" Text="    Loyalty Required"
                                        Checked="true" />
                                    <br />
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30%; text-align: right;">
                                    <strong>Points : </strong><span class="astrics">*</span>
                                </td>
                                <td>
                                    <asp:TextBox ID="txtloyaltypoints" Width="75px" CssClass="reg_txt" runat="server"
                                        onkeyDown="return checkTextAreaMaxLength(this,event,'5');"></asp:TextBox>
                                    &nbsp;&nbsp;<asp:CheckBox runat="server" ValidationGroup="LOY" ID="chkconvert" Text="     Convert to Cash" />
                                </td>
                            </tr>
                            <tr>
                                <td style="text-align: right;">
                                    <strong>Date From : </strong>
                                    <%--<span class="astrics">*</span>--%>&nbsp;&nbsp;
                                </td>
                                <td>
                                    <asp:TextBox ID="txtloyaltydtfrom" Width="120px" CssClass="reg_txt" runat="server"
                                        onkeyDown="return checkTextAreaMaxLength(this,event,'5');"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30%; text-align: right;">
                                    <strong>Date To : </strong>
                                    <%--<span class="astrics">*</span>--%>&nbsp;&nbsp;
                                </td>
                                <td>
                                    <asp:TextBox ID="txtloyaltydtto" Width="120px" CssClass="reg_txt" runat="server"
                                        onkeyDown="return checkTextAreaMaxLength(this,event,'5');"></asp:TextBox>
                                </td>
                            </tr>
                            <tr>
                                <td style="width: 30%; text-align: right;">
                                    <strong>Status : </strong>&nbsp;&nbsp;
                                </td>
                                <td>
                                    <asp:CheckBox ID="chkIsActive" runat="server" Text="  IsActive" />&nbsp;&nbsp;&nbsp;&nbsp;<asp:CheckBox
                                        ID="chkIsDelete" runat="server" Text="  IsDelete" />
                                </td>
                            </tr>
                            <tr>
                                <td align="center" colspan="2">
                                    <asp:Button ID="btnloyaltysaveupdate" runat="server" CssClass="button_all" OnClick="btnLoyalty_Click"
                                        CausesValidation="false" Text="OK" />
                                </td>
                            </tr>
                            <tr>
                                <td colspan="2">
                                    <cc1:CalendarExtender ID="CalendarExtender7" runat="server" TargetControlID="txtloyaltydtfrom"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender1" runat="server" TargetControlID="txtloyaltydtfrom"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender7" runat="server" TargetControlID="txtloyaltydtfrom"
                                        WatermarkText="Date From..">
                                    </cc1:TextBoxWatermarkExtender>
                                    <cc1:CalendarExtender ID="CalendarExtender8" runat="server" TargetControlID="txtloyaltydtto"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender3" runat="server" TargetControlID="txtloyaltydtto"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender8" runat="server" TargetControlID="txtloyaltydtto"
                                        WatermarkText="Date To..">
                                    </cc1:TextBoxWatermarkExtender>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
        </asp:Panel>
        <cc1:ModalPopupExtender ID="ModalPopupLoyalty" runat="server" BackgroundCssClass="NewmodalBackground"
            PopupControlID="AddLoyaltyPanel" TargetControlID="LblTargetLoyalty" CancelControlID="btncloseloyalty">
        </cc1:ModalPopupExtender>
        <asp:Label ID="LblTargetLoyalty" runat="server"></asp:Label>
        <asp:HiddenField ID="hdnloyalty" runat="server" />
        <!-------------------End Loyalty Popup--------------->
    </div>
    <%--</ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnOfferRenewal" />
        </Triggers>
    </asp:UpdatePanel>--%>
</asp:Content>
