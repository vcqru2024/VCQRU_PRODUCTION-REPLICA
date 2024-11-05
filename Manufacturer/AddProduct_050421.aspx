<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="AddProduct.aspx.cs" Inherits="Manufacturer_AddProduct" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script language="javascript" type="text/javascript">
        function ChkRegProVal() {
            var con = true; // document.getElementById('<=RdYesMessage.ClientID %>').checked;
            if (con == true) {
                if ((document.getElementById("<%=lblname.ClientID %>").innerHTML == "") && (document.getElementById("<%=lblfile.ClientID %>").innerHTML == "")
                    && (document.getElementById("<%=lblInvalidFile.ClientID %>").innerHTML == "")
                    && (document.getElementById("<%=lblfileH.ClientID %>").innerHTML == "")
                    && (document.getElementById("<%=lblfileE.ClientID %>").innerHTML == "")
                    && (document.getElementById("<%=Label6.ClientID %>").innerHTML == "")
                    && (document.getElementById("<%=Label9.ClientID %>").innerHTML == "")) {

                    document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                    document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";
                }
                else {
                    document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                    document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";
                }
            }
            else {
                if ((document.getElementById("<%=lblname.ClientID %>").innerHTML == "") && (document.getElementById("<%=lblfile.ClientID %>").innerHTML == "") && (document.getElementById("<%=lblInvalidFile.ClientID %>").innerHTML == "") && (document.getElementById("<%=Label6.ClientID %>").innerHTML == "")) {
                    document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                    document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";
                }
                else {
                    document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                    document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";
                }
            }
        }
        function ChkRegProValNew() {
          if ((document.getElementById("<%=lblname.ClientID %>").innerHTML == "") && (document.getElementById("<%=lblfile.ClientID %>").innerHTML == "") && (document.getElementById("<%=lblInvalidFile.ClientID %>").innerHTML == "")) {
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";
            }
            else {
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";
            }
        }
        function fileTypeCheckengNew(mm) {
           // alert('fileTypeCheckengNew');
            PageMethods.checkFile(mm, onengcheckNew)
        }
        function onengcheckNew(Result) {
            if (Result == false) {
                
                document.getElementById("<%=lblfile.ClientID %>").innerHTML = "Invalid File.";
       document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";

            }
            else {
                document.getElementById("<%=lblfile.ClientID %>").innerHTML = "";
             document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";
            }
            ChkRegProValNew();
        }
        function fileTypeCheckeng(mm) {
            //alert('fileTypeCheckeng');
            PageMethods.checkFile(mm, onengcheck)
        }
        function onengcheck(Result) {

            if (Result == true) {
                document.getElementById("<%=lblfile.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";

            }
            else {
                document.getElementById("<%=lblfile.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";
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
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";

            }
            else {
                if (size > 10240000) {
                    document.getElementById("<%=lblInvalidFile.ClientID %>").innerHTML = "FileSize should not exceed 10MB";
                    document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                    document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";
                }
                else {
                    document.getElementById("<%=lblInvalidFile.ClientID %>").innerHTML = "";
                    document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                    document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";
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
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
          document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";

            }
            else {
                if (size > 10240000) {
                    document.getElementById("<%=lblInvalidFile.ClientID %>").innerHTML = "FileSize should not exceed 10MB";
                    document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                    document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";
                }
                else {
                    document.getElementById("<%=lblInvalidFile.ClientID %>").innerHTML = "";
                    document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                    document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";
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
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";

            }
            else {
                document.getElementById("<%=lblfileH.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";
            }
            ChkRegProVal();
        }

        function fileTypeCheckengE(mm) {
           // alert('fileTypeCheckengE');
            PageMethods.checkFile(mm, onengcheckE)
        }
        function onengcheckE(Result) {
            if (Result == true) {
                document.getElementById("<%=lblfileE.ClientID %>").innerHTML = "Invalid File.";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";

            }
            else {
                document.getElementById("<%=lblfileE.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";
            }
            ChkRegProVal();
        }
        function CheckProductNew(vl) {
            //alert('CheckProductNew');
            PageMethods.checkNewProduct(vl, onCompleteProductNew)
        }
        function onCompleteProductNew(Result) {
       if (Result == true) {
                document.getElementById("<%=lblname.ClientID %>").innerHTML = "Product Name Already exist.";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
           document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";

            }
            else {
                document.getElementById("<%=lblname.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
           document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";

            }
            ChkRegProValNew();
        }
        function checkproduct(vl) {
           // alert('checkproduct');
            PageMethods.checkNewProduct(vl, onCompleteProduct)
        }
        function onCompleteProduct(Result) {
       if (Result == true) {
                document.getElementById("<%=lblname.ClientID %>").innerHTML = "Product Name Already exist.";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
           document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";

            }
            else {
                document.getElementById("<%=lblname.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
           document.getElementById("<%=btnSave.ClientID %>").className = "btn btn-primary float-right mb-0";

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
            alert('chkuseoldcomments');
          //  var vl = document.getElementById("<=lblproiddel.ClientID %>").innerHTML;
         //   PageMethods.checkOldRemarks(vl, oncheckOldRemarks)
        }
        function oncheckOldRemarks(Result) {
           <%-- var Arr = Result.toString().split(',');
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
            }--%>
        }
        function chkuseoldsoundh() {
          //  var vl = document.getElementById("<=lblproiddel.ClientID %>").innerHTML;
           // vl += "-_H";
          //  PageMethods.checkOldSound(vl, oncheckOldSoundH)
        }
        function oncheckOldSoundH(Result) {
           <%-- var con = document.getElementById('<%=CheckBox1.ClientID %>').checked;
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
            }--%>
        }
        function chkuseoldsounde() {
           // var vl = document.getElementById("<=lblproiddel.ClientID %>").innerHTML;
           // vl += "-_E";
           // PageMethods.checkOldSound(vl, oncheckOldSoundE)
        }
        function oncheckOldSoundE(Result) {
           <%-- var con = document.getElementById('<%=CheckBox2.ClientID %>').checked;
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
            }--%>
        }
    </script>

    <style type="text/css">
        /*tab class*/.ajax__tab_xp .ajax__tab_tab, .ajax__tab_xp .ajax__tab_outer, .ajax__tab_xp .ajax__tab_inner
        {
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
        .ajax__tab_xp .ajax__tab_inner
        {
            /*background: url(images/menu_over.png) repeat-x !important;*/
            height: 20px !important;
            -webkit-border-radius: 10px 10px 0px 0px !important;
            -moz-border-radius: 10px 10px 0px 0px !important;
            border-radius: 10px 10px 0px 0px !important;
            margin: 0;
            color: #ffffff;
        }
        .ajax__tab_xp .ajax__tab_outer
        {
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
        /*tab class close*//*tab activ class*/.ajax__tab_xp .ajax__tab_active .ajax__tab_inner
        {
            -webkit-border-radius: 5px 5px 0px 0px !important;
            -moz-border-radius: 5px 5px 0px 0px !important;
            border-radius: 5px 5px 0px 0px !important;
        }
        .ajax__tab_xp .ajax__tab_active .ajax__tab_outer
        {
            -webkit-border-radius: 5px 5px 0px 0px !important;
            -moz-border-radius: 5px 5px 0px 0px !important;
            border-radius: 5px 5px 0px 0px !important;
        }
        .ajax__tab_xp .ajax__tab_active .ajax__tab_tab, .ajax__tab_xp .ajax__tab_active .ajax__tab_inner, .ajax__tab_xp .ajax__tab_active .ajax__tab_outer
        {
            background: #ffffff !important;
            height: 20px;
            padding: 0px;
            margin: 0;
            color: #333333;
        }
        .ajax__tab_xp .ajax__tab_active .ajax__tab_outer
        {
            margin-right: 5px;
            border: 1px solid #999;
            border-bottom: none;
        }
        /*tab activ class Close*/</style>

    <script type="text/javascript" language="javascript">
        $(document).ready(function() {
            ShowImagePreview();
        });
        // Configuration of the x and y offsets
        function ShowImagePreview() {
            xOffset = -20;
            yOffset = 40;

            $("a.preview").hover(function(e) {
                this.t = this.title;
                this.title = "";
                var c = (this.t != "") ? "<br/>" + this.t : "";
                $("body").append("<p id='preview'><img src='" + this.href + "' alt='Image preview' />" + c + "</p>");
                $("#preview")
            .css("top", (e.pageY - xOffset) + "px")
            .css("left", (e.pageX + yOffset) + "px")
            .fadeIn("slow");
            },

    function() {
        this.title = this.t;
        $("#preview").remove();
    });

            $("a.preview").mousemove(function(e) {
                $("#preview")
            .css("top", (e.pageY - xOffset) + "px")
            .css("left", (e.pageX + yOffset) + "px");
            });
        };

    </script>

    <style type="text/css">
        #preview
        {
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
            <%--var dv = document.getElementById("<%=Promotional.ClientID %>"); //Promotional Div4
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
            }--%>
            ChkRegProVal();
        }
        function SelectSingleRadiobutton(rdbtnid) {

            var vl = document.getElementById('<%=lblproid.ClientID %>').value;
            PageMethods.checkcheckproLabel(vl, onCompletecheckproLabel)
        }
        function onCompletecheckproLabel(Result) {
            var Arr = Result.toString().split('-');
            if (Arr[2] == "True") {
                alert("There is <span style='color:blue;'>" + Arr[0] + "</span> request still pending for cancel <span style='color:blue;'>" + Arr[1] + "</span>, Do you want to cancel these request before changing Label Type.");
                //document.getElementById("<=lblTextAlert.ClientID %>").innerHTML = "There is <span style='color:blue;'>" + Arr[0] + "</span> request still pending for cancel <span style='color:blue;'>" + Arr[1] + "</span>, Do you want to cancel these request before changing Label Type.";
                //$find("CancelPendingRequest").show();
            }
        }
        function SelectSingleRadiobuttonNew(rdbtnid) {
            <%--var p = 0; var mon = 0;
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
            }--%>
        }
        function FindNextDate(dt) {
            <%--var selectedDate = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)) - 1, dt.substring(0, 2));
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
            ChkRegProVal();--%>
        }
       
    </script>

    <script type="text/javascript" language="javascript">

        function SelectSingleRadiobuttonNew12(rdbtnid) {
           <%-- var p = 0; var mon = 0;
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
            }--%>
        }
        function FindNextDate12(dt) {
          <%--  var selectedDate = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)) - 1, dt.substring(0, 2));
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
            }--%>
        }  
    </script>

    <script type="text/javascript" language="javascript">

        function SelectSinglePromotional(rdbtnid, rdbtnval) {
            <%--var p = 0; var mon = 0;
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
            }--%>
        }
        function FindNextDatePromotional(dt) {
           <%-- var selectedDate = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)) - 1, dt.substring(0, 2));
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
            }--%>
            ChkRegProVal();
        }  
    </script>

    <script type="text/javascript" language="javascript">

        function SelectSinglePromotionalNew(rdbtnid, rdbtnval) {
           <%-- var p = 0; var mon = 0;
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
            }--%>
        }
        function FindNextDatePromotionalNew(dt) {
            <%--var selectedDate = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)) - 1, dt.substring(0, 2));
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
            }--%>
        }  
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <asp:Label ID="Label6" runat="server"></asp:Label>
     <asp:Label ID="Label9" runat="server"></asp:Label>
     <asp:Label ID="Label3" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
    <div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
                <div class="card card-admin form-wizard profile box_card">
                    <header class="card-header">
                        <h4 class="card-title"><i class="fa fa-pencil-square-o"></i><asp:Label ID="lblheading" runat="server" Text="Add Product" Font-Bold="true"></asp:Label></h4>
                    </header>
                     <div id="newmsg" runat="server">
                                            <p>
                                                <asp:Label ID="lblmsgHeader" runat="server"></asp:Label></p>
                                        </div>
                    <div id="NewMsgpop" runat="server">
                        <p>
                            <asp:Label ID="Label2" runat="server"></asp:Label>
                        </p>
                        <asp:HiddenField ID="lblproid" runat="server" />
                    </div>
                    <div  class="card-body card-body-nopadding">
                    <h6> Product Info</h6>
                  
                    <div class="form-row">
                        <div class="form-group col-lg-3">
                            <span class="req">*</span><label>Product Name</label>
                            <asp:TextBox ID="txtProName" MaxLength="50" onchange="checkproduct(this.value);"
                                class="form-control form-control-sm" runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'50');"></asp:TextBox>
                            <%--<span class="astrics">Product Name should be in 15 character. </span>--%>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator1" runat="server" ValidationGroup="chk94"
                                ControlToValidate="txtProName"  ErrorMessage="Please enter product name" ></asp:RequiredFieldValidator>
                            <asp:Label ID="lblname" runat="server" ForeColor="Red" CssClass="astrics"></asp:Label>
                        </div>
                        <div class="form-group col-lg-3">
                            <span class="req"></span>
                            <label>Product Description</label>
                            <asp:TextBox ID="txtprodDes" TextMode="MultiLine" class="form-control form-control-sm" MaxLength="100"
                                Height="40px" onkeyDown="return checkTextAreaMaxLength(this,event,'100');" runat="server"></asp:TextBox>
                            <%--<span class="astrics">Product Description should be in 100 character. </span>--%>
                             <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ValidationGroup="chk94"
                               ControlToValidate="txtprodDes" ErrorMessage="Please enter product discription"></asp:RequiredFieldValidator>

                        </div>
                        <div class="form-group col-lg-3">
                            <span class="req">*</span><label>Dispatch Location</label>
                            <asp:TextBox ID="txtdisatchLoc" TextMode="MultiLine" class="form-control form-control-sm" MaxLength="250"
                                Height="40px" onkeyDown="return checkTextAreaMaxLength(this,event,'250');" runat="server"></asp:TextBox>
                            <%--<span class="astrics">Dispatch Location should be in 250 character. </span>--%>
                           <asp:RequiredFieldValidator ID="RequiredFieldValidator13" runat="server" ValidationGroup="chk94"
                               ControlToValidate="txtdisatchLoc" ErrorMessage="Please enter dispatch location"></asp:RequiredFieldValidator>
                              
                            
                        </div>
                        <div class="form-group col-lg-3">
                            <span class="req"></span>
                            <label>Batch Size</label>
                            <asp:TextBox ID="txtBatchSize" MaxLength="10" class="form-control form-control-sm" OnKeyPress="return isNumberKey(this, event);"
                                runat="server"></asp:TextBox>
                            <%--<span class="astrics">Batch Size should be in 10 digits. </span>--%>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidator14" runat="server" ValidationGroup="chk94"
                                ControlToValidate="txtBatchSize" ErrorMessage="Please enter batch size"></asp:RequiredFieldValidator>

                        </div>
                    </div>

                         
                    
                    <div class="form-row file_box mb-4">
                        <div class="col-lg-6">
                        <div class="form-group">
                            <h6> Product Sound</h6>
                     <span class="req">*</span><label>Product Name Audio (*.mp3)</label>
                             <asp:FileUpload ID="flSound" onchange="fileTypeCheckeng(this.value);" runat="server" />
                                                                       <asp:Label ID="lblfile" runat="server" CssClass="astrics"></asp:Label>

                              <asp:RequiredFieldValidator ID="RequiredFieldValidator522" runat="server" ValidationGroup="chk94"
                                                                            ControlToValidate="flSound" ErrorMessage="*"></asp:RequiredFieldValidator>
                             </div>
                        <div class="form-group">
                                <asp:Label ID="lblfiletype" Style="font-family: Arial; font-size: 12px; color: red;"
                                    runat="server" Text="File Type ---- .mp3"></asp:Label>
                                <br />
                                <asp:Label ID="lblrecord" Style="font-family: Arial; font-size: 12px; color: Blue;"
                                    runat="server" Text="For record the audio file  (save file as '.mp3'), Please click the link"></asp:Label>&nbsp;
                                                                        <a href="http://wavepad.en.softonic.com/" style="font-family: Arial; font-size: 12px; color: Blue;"
                                                                            target="_blank">Click</a>
                            </div>
                        <div class="form-group">
                                  <ul class="graphic">
                                      <li>
                                            <a id="FileDown" runat="server" title="Play" class="sm2_link"></a>
                                      </li>
                                  </ul>
                          
                             <asp:Label ID="lblfileE" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
                            <asp:Label ID="lblfileH" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
                        </div>
                        </div>
                        <div class="col-lg-6">
                            <div class="form-group">
                            <h6>Legal Documents</h6>
                            <span class="req">*</span><label>Document File</label>
                            <asp:FileUpload ID="ProDocFileUpload" runat="server" CssClass="reg_txt" Width="225px"
                                onchange="fileTypeCheckeng11111(this.value);" />
                            &nbsp;<asp:HyperLink ID="FileDownDoc" NavigateUrl="" Target="_blank" Text="View"
                                runat="server" ToolTip="View"></asp:HyperLink><%--<a id="FileDownDoc" runat="server" title="Download">Download</a>--%>
                            <asp:Label ID="FileDocDownPath" runat="server" Visible="false"></asp:Label>
                            <asp:Label ID="lblInvalidFile" runat="server" CssClass="astrics"></asp:Label>
                            <asp:RequiredFieldValidator ID="RequiredFieldValidatorfile" runat="server" ForeColor="Red"
                                ValidationGroup="chk94" ControlToValidate="ProDocFileUpload" ErrorMessage="*"></asp:RequiredFieldValidator>
                            <br />
                             <asp:Label ID="Label7" Style="font-family: Arial; font-size: 12px; color: red;" runat="server"
                                                                                    Text="<span style='color:blue;'>Please upload Legal Documents in support of Product ownership.</span><br/>File Type ---- .zip,.png,.jpg,.jpeg,.pdf,.doc,.docx. Size should be less than 10MB. "></asp:Label>
                            </div>
                        </div>
                         </div>
                        
                    
                  
                     
                   
                    <div class="form-row">
                        <div class="form-group col-lg-12">
                             <h6>Choose Labels</h6>
                            <div class="table-responsive">
                            <asp:GridView ID="GrdViewLabelDetails" runat="server" AutoGenerateColumns="False"
                                                                                DataKeyNames="Label_Code"  CssClass="table table-striped table-bordered" EmptyDataText="Record Not Found" EnableModelValidation="True"
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
                                                                                                onclick="javascript:SelectSingleRadiobutton(this.id)" />
                                                                                            <%}
                                                                                              else
                                                                                              {%>
                                                                                            <input type="radio" id="Radio1" name="rdlabel" value='<%# Eval("Label_Code") %>'
                                                                                                onclick="javascript:SelectSingleRadiobutton(this.id)" />
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
                                                                                        <ItemStyle HorizontalAlign="Justify" Width="45%" />
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
                     
                </div>
                        <div class="form-row">
                       
                        <div class="form-group col-lg-2 offset-lg-8">   
                            <asp:Button ID="btnSave" OnClick="btnSave_Click" ValidationGroup="chk94" class="btn btn-primary float-right mb-5 btn-block"
                                runat="server" Text="Save" /></div>
                            <div class="form-group col-lg-2">
                             <asp:Button ID="Button3" OnClick="btnReset_Click" class="btn btn-success float-left mb-5 btn-block" runat="server"
                                CausesValidation="false" Text="Cancel" />
                         
                        </div>
                    </div>
            </div>
        </div>
        </div>
        <asp:HiddenField ID="hhdnCompID" runat="server" />
         <asp:HiddenField ID="HdLabelCode" runat="server" />
          <asp:HiddenField ID="HdLabelCodeRequest" runat="server" />
         <asp:HiddenField ID="HdPro_ID" runat="server" />
                        <asp:HiddenField ID="HdPromoId" runat="server" />
         <asp:HiddenField ID="docflag" runat="server" />
    </div>
             </div>
        </div>
</asp:Content>
