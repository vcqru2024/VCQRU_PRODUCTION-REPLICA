function SelectSingleRd(rdbtnid) {
    var rdBtnList = document.getElementsByName("rdlabel");
    for (i = 0; i < rdBtnList.length; i++) {
        if (rdBtnList[i].type == "radio" && rdBtnList[i].id != rdBtn.id) {
            rdBtnList[i].checked = false;
        }
    }
}


function FinfMonth(p) {
    var mon = 0;
    if (parseInt(p) == 0)
        mon = 3;
    else if (parseInt(p) == 1)
        mon = 6;
    else if (parseInt(p) == 2)
        mon = 12;
    else if (parseInt(p) == 3)
        mon = 24;
    else if (parseInt(p) == 4)
        mon = 36;
    return mon;
}




function FindVal(val) {
    if (val.toString().length == 1)
        val = "0" + val;
    return val;
}




function mathRoundForTaxes(source) {
    var txtBox = document.getElementById(source);
    var txt = txtBox.value;
    if (!isNaN(txt) && isFinite(txt) && txt.length != 0) {
        var rounded = Math.round(txt * 100) / 100;
        txtBox.value = rounded.toFixed(2);
    }
}
function isNumberKey(sender, evt) {
    var txt = sender.value;
    var dotcontainer = txt.split('.');
    var charCode = (evt.which) ? evt.which : event.keyCode;
    if (!(dotcontainer.length == 1 && charCode == 46) && charCode > 31 && (charCode < 48 || charCode > 57))
        return false;

    return true;
}



function checkShortcut() {
    if (event.keyCode != 13) {
        //alert("Enter key is not allowed");
        return false;
    }
}



function UpperVal(val, id) {
    val = val.toUpperCase();
    document.getElementById(id).value = val;
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