<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true"
    CodeFile="ServicesSubcription.aspx.cs" Inherits="ServicesSubcription" Title="Service Subscription" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">
        $(document).ready(function() {

            $(".accordion2 p").eq(9).addClass("active");
            $(".accordion2 div.open").eq(8).show();

            $(".accordion2 p").click(function() {
                $(this).next("div.open").slideToggle("slow")
		.siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        }); 
    </script>

    <script type="text/javascript" language="javascript">
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
        function CheckZero(val) {
            if (parseFloat(val) == 0)
                document.getElementById("<%=txtfrequency.ClientID %>").value = "";
        }
        function CheckDate(val) {
            //alert(val);
            var today = new Date();
            var dd = today.getDate();
            var mm = today.getMonth() + 1; //January is 0!
            var yyyy = today.getFullYear();

            if (dd < 10) {
                dd = '0' + dd
            }

            if (mm < 10) {
                mm = '0' + mm
            }

            today = dd + '/' + mm + '/' + yyyy;
            //alert(today);
            var diff = daydiff(parseDate(val), parseDate(today));
            //alert(diff);
            //alert(daydiff(parseDate(val), parseDate(today)));
            if (parseFloat(diff) > 0)
                document.getElementById("<%=txtloyaltydtfrom.ClientID %>").value = "";
        }
        function parseDate(str) {
            //alert(str);
            var mdy = str.split('/'); //alert(mdy[0]);alert(mdy[1]); alert(mdy[2]); alert(mdy[2] + '/' + mdy[1] + '/' + mdy[0]);
            return new Date(mdy[2], mdy[1], mdy[0]);
        }

        function daydiff(first, second) {
            //alert(first); alert(second);
            return Math.round((second - first) / (1000 * 60 * 60 * 24));
        }

        
    </script>

    <%--<style>
        #ctl00_ContentPlaceHolder1_chkconvert
        {
            margin-top: 10px !important;
        }
    </style>--%>

    <script type="text/javascript" language="javascript">
        function GetService(vl) {
           // alert('dd');
            document.getElementById('ContentPlaceHolder1_selsrvid').value = vl; //selsrvid
            //document.getElementById('#<%= selsrvid.ClientID  %>').value = vl;
        }
    </script>

    <style>
        .redeem
        {
            /*border-radius: 16px;*/
            font-size: 12px;
            padding: 2px 5px 2px 5px;
            background-color: #110017;
            color: white;
            cursor: pointer;
        }
    </style>

    <script type="text/javascript" language="javascript">
        function SelectSingleRadiobuttonAmc(rdbtnid, PlanTime) {
            debugger;
            var p = 0; var mon = 0;
            var rdBtn = document.getElementById(rdbtnid);
            var rdBtnList = document.getElementsByName("rdamcrewaut");
            for (i = 0; i < rdBtnList.length; i++) {
                if (rdBtnList[i].type == "radio" && rdBtnList[i].id != rdBtn.id) {
                    rdBtnList[i].checked = false;
                }
                if (rdBtnList[i].checked == true) {
                    p = i;
                    document.getElementById("<%=HdValAMC1.ClientID %>").value = PlanTime;
                    if (document.getElementById("<%=txtdtfromamc1.ClientID %>").value != "") {
                        var dt = document.getElementById("<%=txtdtfromamc1.ClientID %>").value;
                        var mydate = new Date(dt.substring(6, 10), (parseInt(dt.substring(3, 5)) == 12 ? 11 : parseInt(dt.substring(3, 5))), dt.substring(0, 2));
                        mon = PlanTime;
                        mydate = new Date(mydate.setMonth(mydate.getMonth() + parseInt(mon)));
                        var dateObj = new Date(mydate);
                        month = dateObj.getMonth();
                        day = dateObj.getDate();
                        year = dateObj.getFullYear();
                        FindInfo();
                        //if (day > 1) {
                        //    day = day - 1;
                        //}
                        //if (month == 11)
                        //{
                        //    month = 12;
                        //}
                        //else {
                        //    day = day;
                        //}
                        var newdate = FindVal((day > 1 ? day - 1 : day)).toString() + "/" + FindVal((month == 11 ? 12 : month)).toString() + "/" + year;
                       // var newdate =  day.toString() + "/" + month.toString() + "/" + year;
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
            CheckValidation();
        }
        function FindNextDateAmc(dt) {
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
                mon = p;  //mon = FinfMonth(p);
                var mydate = new Date(mydate1.setMonth(mydate1.getMonth() + parseInt(mon)));
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
            CheckValidation();
        }        
    </script>

    <script type="text/javascript" language="javascript">
        var month; //1 3 5 7 8 10 12==31,4 6 9 11==30 2 = 28*
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
            if (month == 0)
                month = 12;
        }
        function CheckValidation() {
            var plan = document.getElementById("<%=HdValAMC1.ClientID %>").value;
            var pro = document.getElementById("<%=ddlProSelect.ClientID %>").value;
            var terms = document.getElementById("<%=chkterms.ClientID %>").checked;
            if (pro == "--Select--") {
                document.getElementById("<%=Label8.ClientID %>").innerHTML = "Please select Product!";
                document.getElementById("<%=Div2.ClientID %>").className = "alert_boxes_pink big_msg";
                document.getElementById("<%=btnAmcRenewal.ClientID %>").disabled = true;
                document.getElementById("<%=btnAmcRenewal.ClientID %>").className = "button_all_Sec";
            }
            else if (plan == "") {
                document.getElementById("<%=Label8.ClientID %>").innerHTML = "Please select Plan!";
                document.getElementById("<%=Div2.ClientID %>").className = "alert_boxes_pink big_msg";
                document.getElementById("<%=btnAmcRenewal.ClientID %>").disabled = true;
                document.getElementById("<%=btnAmcRenewal.ClientID %>").className = "button_all_Sec";
            }
            else if (terms == false) {
                document.getElementById("<%=Label8.ClientID %>").innerHTML = "Accept Terms & Conditions!";
                document.getElementById("<%=Div2.ClientID %>").className = "alert_boxes_pink big_msg";
                document.getElementById("<%=btnAmcRenewal.ClientID %>").disabled = true;
                document.getElementById("<%=btnAmcRenewal.ClientID %>").className = "button_all_Sec";
            }
            else {
                document.getElementById("<%=Label8.ClientID %>").innerHTML = "";
                document.getElementById("<%=Div2.ClientID %>").className = "";
                document.getElementById("<%=btnAmcRenewal.ClientID %>").disabled = false;
                document.getElementById("<%=btnAmcRenewal.ClientID %>").className = "button_all";
            }
        }
    </script>

    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <%--<link rel="stylesheet" type="text/css" media="screen" href="../Content/css/bootstrap/bootstrap.css" />--%>
    <%--<link rel="stylesheet" href="../Content/css/bootstrap/font-awesome.css"/>
    <link rel="stylesheet" href="../Content/css/bootstrap/animate.css"/>--%>
    <%--<link rel="stylesheet" href="../Content/css/bootstrap/theme.css" />--%>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <%--<asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
            <asp:UpdateProgress ID="UpdateProgress1"  runat="server"
                DisplayAfter="0">
                <ProgressTemplate>
                    <div align="center" style="position: absolute; left: 0; height: 1230px; width: 100%;
                        z-index: 100001; top: 0px;" class="NewmodalBackground">
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
                                <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Master Service Subscription</h4>
                            </header>

                            <div id="NewMsgpop" runat="server">
                                <p>
                                    <asp:Label ID="Label2" runat="server"></asp:Label>
                                </p>
                            </div>

                            
                            <div class="card-body card-body-nopadding">
                                <div class="form-row">
                                    <div class="form-group col-lg-2">
                                        <asp:Button ID="imgNew" ToolTip="Add New Product" OnClick="imgNew_Click1"
                                            CausesValidation="false" runat="server" Text="Add/Subscribe Service" class="btn btn-primary btn-block mb-0" />
                                    </div>
                                    <div class="form-group col-lg-4">
                                        <asp:TextBox ID="txtDateTo" runat="server" Text="" CssClass="reg_txt" Visible="false"></asp:TextBox>
                                        <asp:TextBox ID="txtDateFrom" runat="server" Text="" CssClass="reg_txt" Visible="false"></asp:TextBox>
                                        <asp:DropDownList ID="ddlsearchSrervice" CssClass="form-control form-control-sm" runat="server">
                                        </asp:DropDownList>
                                    </div>
                                    <div class="form-group col-lg-4">

                                        <asp:DropDownList ID="ddlsearchPro" CssClass="form-control form-control-sm" runat="server">
                                        </asp:DropDownList>
                                        <asp:TextBox ID="txtProductName" placeholder="Product Name" runat="server" Text=""
                                            CssClass="reg_txt" Visible="false"></asp:TextBox>
                                    </div>
                                    <div class="form-group col-lg-2">
                                        <asp:ImageButton ID="ImgSearch" CssClass="btn btn-primary" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                            CausesValidation="false" ToolTip="Search" OnClick="ImgSearch_Click" />
                                        <asp:ImageButton ID="ImgRefresh" runat="server" CssClass="btn btn-success refreses_field" ImageUrl="~/Content/images/reset.png"
                                            OnClick="ImgRefresh_Click" CausesValidation="false" ToolTip="Reset" />
                                    </div>
                                </div>
                                
                                <div class="card-admin form-wizard medias">
                              <div class="row pb-2 pt-2 background-section-form">
                                    <div class="col-lg-8">
                                        <h4 class="mb-0">Record's Found :<span> <asp:Label ID="lblcount" runat="server"></asp:Label></span></h4>
                                    </div>
                                    <div class="col-lg-2">
                                        <asp:Label ID="lblToatalCashPoints" runat="server"></asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label
                                            ID="lblToatalPoints" runat="server"></asp:Label>
                                    </div>
                                    <div class="col-lg-2">
                                      <asp:DropDownList ID="ddlRowProductCnt" runat="server" Visible="false" AutoPostBack="true" OnSelectedIndexChanged="ddlRowsShow_SelectedIndexChanged">
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
                             <asp:GridView ID="GrdProductMaster" runat="server" AutoGenerateColumns="False"  CssClass="table table-striped table-bordered Frm_Scrap" style="margin-bottom: 0"
                    EmptyDataText="Record Not Found"  DataKeyNames="IsAdminVerify"  OnRowCommand="GrdProductMaster_RowCommand"           
                    BorderColor="transparent">
                    <Columns>
                        <asp:TemplateField HeaderText="S.No">
                            <ItemTemplate>
                                <%=++c %>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center"  Width="4%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Product Name">
                            <ItemTemplate>
                                <asp:Label ID="lblpronamesrv" runat="server" Text='<%# Bind("Pro_Name") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                            <ItemStyle HorizontalAlign="Justify"  Width="17%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Service Name">
                            <ItemTemplate>
                                <asp:Label ID="lbladdsrvnamesrv" runat="server" Text='<%# Bind("ServiceName") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                            <ItemStyle HorizontalAlign="Justify"  Width="17%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Plan Name">
                            <ItemTemplate>
                                <asp:Label ID="lblsrvplanname" runat="server" Text='<%# Bind("PlanName") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                            <ItemStyle HorizontalAlign="Justify" Width="17%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date From">
                            <ItemTemplate>
                                <asp:Label ID="lbldtfrmsrv" runat="server" Text='<%# Bind("DateFrom","{0:ddd, MMM d, yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                            <ItemStyle HorizontalAlign="Justify"  Width="17%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Date To">
                            <ItemTemplate>
                                <asp:Label ID="lbldtttosrv" runat="server" Text='<%# Bind("DateTo","{0:ddd, MMM d, yyyy}") %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                            <ItemStyle HorizontalAlign="Justify"  Width="17%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Status">
                            <ItemTemplate>
                                <asp:Label ID="lblsrvstst" runat="server" Text='<%# Convert.ToInt32(Eval("IsAdminVerify")) == 0 ? "Pending" : Convert.ToInt32(Eval("IsActive")) == 1 ? "Activated" : "De-Activated"  %>'></asp:Label>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                        </asp:TemplateField>
                        <asp:TemplateField HeaderText="Action">
                            <ItemTemplate>
                                <asp:ImageButton ID="ImgBtnLoyalty" runat="server" CausesValidation="false" CommandArgument='<%#Bind("Subscribe_Id") %>'
                                    CommandName="ServiceEdit" ImageUrl="~/Content/images/edit.png" ToolTip="Add / Update Loyalty" />
                                &nbsp;
                                <%
                                    try
                                    {
                                        vl = Convert.ToInt32(GrdProductMaster.DataKeys[index].Values["IsAdminVerify"].ToString());
                                    }
                                    catch
                                    {
                                    } if (vl == 0)
                                    {
                                %>
                                <asp:ImageButton ID="imgBtnSecDelete" runat="server" CommandArgument='<%#Bind("Subscribe_Id") %>'
                                    CommandName="DeleteRow" ImageUrl="~/Content/images/delete.png" ToolTip="Delete"
                                    OnClientClick="return confirm('Are you sure to delete?')" />
                                <%} %>
                                <%index++;%>
                            </ItemTemplate>
                            <%--<HeaderStyle CssClass="tr_haed bord_left" HorizontalAlign="Center" />--%>
                            <ItemStyle HorizontalAlign="Center" Width="5%" />
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
                            <%-- <div class="head_cont">
                <h2 class="brand_loyalty">
                    <table width="99%">
                        <tr>
                            <td width="85%">
                                
                            </td>
                            <td align="right">
                                <asp:ImageButton ID="imgNew" ToolTip="Add New Brand Loyalty Product" OnClick="imgNew_Click"
                                    ImageUrl="~/Content/images/add_new.png" CausesValidation="false" runat="server" />
                            </td>
                        </tr>
                    </table>
                </h2>
            </div>--%>
            <%--<div style="width: 100%; text-align: center;">
            </div>
            <div style="width: 100%; text-align: center;">
                <asp:Label ID="Label3" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
            </div>--%>
           
           <%-- <fieldset class="field_profile">
                <legend>Search</legend>
                <asp:Panel ID="DefaultButton" runat="server" DefaultButton="ImgSearch">
                    <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                        <tr>
                            <td align="right" width="18%">
                                
                            </td>
                            <td align="right" width="18%">
                               
                            </td>
                            <td width="18%" style="display: none;">
                               
                            </td>
                            <td>
                                <div class="merg_btn">
                                   
                                </div>
                            </td>
                            <td align="right" width="10%" style="visibility: hidden;">
                                <strong>MFG Date:</strong>
                            </td>
                            <td width="18%" style="visibility: hidden;">
                               
                            </td>
                            <td align="right" width="10%" style="visibility: hidden;">
                                <strong>EXP Date:</strong>
                            </td>
                            <td width="18%" style="visibility: hidden;">
                               
                            </td>
                        </tr>
                    </table>
                </asp:Panel>
            </fieldset>--%>
           <%-- <div id="allhidden">
               
            </div>
            <fieldset class="Newfield" style="width: 98%">
                <legend>Icon Meaning</legend>
                <table width="98%" cellpadding="0" cellspacing="2" class="tab_regis">
                    <tr>
                        <td colspan="12" style="width: 100%;">
                            <table style="width: 100%;">
                                <tr>
                                    <td style="width: 2%;">
                                       
                                    </td>
                                    <td style="width: 2%;">
                                       
                                    </td>
                                    <td width="2%">
                                       
                                    </td>
                                    <td width="2%">
                                        
                                    </td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                </table>
            </fieldset>--%>
            <div class="grid_container">
                 <asp:HiddenField ID="ActionText" runat="server" />
                <asp:HiddenField ID="IsAct" runat="server" />
                <asp:Label ID="lblproiddel" runat="server" Visible="false"></asp:Label>
                <asp:HiddenField ID="currindex" runat="server" />
                <asp:HiddenField ID="lblproidamc" runat="server" />
                <asp:HiddenField ID="hhdnCompID" runat="server" />
                <asp:HiddenField ID="selsrvid" runat="server"  />
                <asp:HiddenField ID="selsrvplanid" runat="server" />

                              <asp:HiddenField ID="docflag" runat="server" />
                <asp:HiddenField ID="HdFieldAmcId" runat="server" />
                <asp:HiddenField ID="HdFieldOfferId" runat="server" />
                <asp:HiddenField ID="hdnpointsval" runat="server" />
               <%-- <h4>
                    <table width="100%" cellpadding="0" cellspacing="0">
                        <tr>
                            <td width="6%" align="center">
                                <img src="../Content/images/regis_pro.png" alt="products" />
                            </td>
                            <td class="bord_right">
                                Record(s) found <span class="small_font">(<asp:Label ID="" runat="server"></asp:Label>)</span>
                            </td>
                            <td width="13%" align="center">
                                <div class="mainselection">
                                   
                                </div>
                            </td>
                        </tr>
                    </table>
                </h4>--%>
               
                
                <!-------------------Start Loyalty Popup--------------->
                <asp:Panel ID="AddLoyaltyPanel" runat="server" Width="40%" Style="display: none;">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btncloseloyalty" CssClass="popupClose" runat="server" /></div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="Lblloyaltyhead" runat="server" Font-Bold="true"></asp:Label>
                                    </span>
                                </p>
                            </div>
                            <div class="regis_popup">
                                <div id="DivMsg" runat="server">
                                    <p>
                                        <asp:Label ID="LblMsgBody" runat="server"></asp:Label></p>
                                </div>
                                <table cellpadding="0px" cellspacing="10px" width="100%" class="grid" style="line-height: 25px;">
                                    <tr>
                                        <td style="width: 30%; text-align: right;">
                                            <strong>Product : </strong><span class="astrics">*</span>&nbsp;&nbsp;
                                        </td>
                                        <td colspan="3">
                                            <asp:DropDownList ID="ddlProduct" CssClass="drp" runat="server" Width="65%">
                                            </asp:DropDownList>
                                            &nbsp;<a href="RegisteredProduct.aspx?Parm=New" title="Add New Brand Loyalty Product"><img
                                                alt="" src="../Content/images/add_new.png" style="height: 17px; width: 17px;" /></a>
                                            <asp:RequiredFieldValidator ID="RFVPro" runat="server" ForeColor="Red" ValidationGroup="SRVS"
                                                InitialValue="--Select--" ControlToValidate="ddlProduct">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                    </tr>
                                    <tr id="divispoints" runat="server">
                                        <td style="width: 30%; text-align: right;">
                                            <strong>Points : </strong><span class="astrics">*</span>&nbsp;&nbsp;
                                            <asp:RequiredFieldValidator ID="RFVIsPoints" runat="server" ForeColor="Red" ValidationGroup="NN"
                                                ControlToValidate="txtloyaltypoints">
                                            </asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtloyaltypoints" Width="120px" CssClass="reg_txt" runat="server"
                                                onkeyDown="return checkTextAreaMaxLength(this,event,'5');"></asp:TextBox>&nbsp;&nbsp;<asp:CheckBox
                                                    runat="server" ID="chkconvert" />
                                            <span id="lbliscash">Convert to Cash</span>
                                        </td>
                                    </tr>
                                    <tr id="divisfrequency" runat="server">
                                        <td style="width: 30%; text-align: right; vertical-align: top;">
                                            <strong>Frequency : </strong>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtfrequency" Width="120px" CssClass="reg_txt" runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'2');"
                                                ToolTip="Enter Frequency to win alternet rewards points" onchange="javascript:CheckZero(this.value);"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr id="divisdaterange" runat="server">
                                        <td style="width: 30%; text-align: right;">
                                            <strong>Date Range : </strong>&nbsp;&nbsp;
                                        </td>
                                        <td>
                                            <asp:TextBox ID="txtloyaltydtfrom" Width="120px" CssClass="reg_txt" runat="server"
                                                placeholder="Date From.." onchange="javascript:CheckDate(this.value);"></asp:TextBox>
                                            <asp:RequiredFieldValidator ID="RFVIsDateFrom" runat="server" ForeColor="Red" ValidationGroup="NN"
                                                ControlToValidate="txtloyaltydtfrom">
                                            </asp:RequiredFieldValidator>
                                            &nbsp;&nbsp;
                                            <asp:TextBox ID="txtloyaltydtto" Width="120px" CssClass="reg_txt" runat="server"
                                                placeholder="Date To.."></asp:TextBox><br />
                                            <asp:CompareValidator ID="CompareValidator1" runat="server" ValidationGroup="LOY"
                                                ControlToCompare="txtloyaltydtfrom" ControlToValidate="txtloyaltydtto" ForeColor="Red"
                                                Type="Date" Operator="GreaterThan" Text="Date To is Less Than Date From"></asp:CompareValidator>
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
                                    <tr id="divissoundComments" runat="server">
                                        <td colspan="2">
                                            <fieldset class="Newfield">
                                                <legend>Message</legend>
                                                <table width="100%">
                                                    <tr>
                                                        <td align="right" style="width: 27%;">
                                                            <asp:RequiredFieldValidator ID="RFVIsMessage" runat="server" ForeColor="Red" ValidationGroup="NN"
                                                                ControlToValidate="txtCommentsTxt"></asp:RequiredFieldValidator>
                                                            <strong><span class="astrics">*</span> Message :</strong>
                                                        </td>
                                                        <td>
                                                            <asp:TextBox ID="txtCommentsTxt" MaxLength="100" TextMode="MultiLine" Width="95%"
                                                                Height="30px" CssClass="textbox_pop" onkeyDown="return checkTextAreaMaxLength(this,event,'25');"
                                                                runat="server"></asp:TextBox>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td>
                                                        </td>
                                                        <td class="astrics">
                                                            Message should be in 25 character
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td style="width: 23%; text-align: right;">
                                                            <asp:RequiredFieldValidator ID="RFVIsSoundH" runat="server" ForeColor="Red" ValidationGroup="NN"
                                                                ControlToValidate="flSoundH"></asp:RequiredFieldValidator>
                                                            <strong>
                                                                <asp:Label ID="L2" runat="server" CssClass="astrics" Text="*"></asp:Label>
                                                                Hindi : </strong>
                                                        </td>
                                                        <td style="width: 40%">
                                                            <asp:FileUpload ID="flSoundH" onchange="fileTypeCheckengH(this.value);" runat="server"
                                                                Style="width: 88%;" />
                                                        </td>
                                                        <td style="width: 15%;">
                                                            <div style="width: 25px; float: right; padding-right: 15px;">
                                                                <ul class="graphic">
                                                                    <li><a id="FileDownHindi" runat="server" title="Play" class="sm2_link"></a></li>
                                                                </ul>
                                                            </div>
                                                            <asp:Label ID="lblfileH" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
                                                        </td>
                                                    </tr>
                                                    <tr>
                                                        <td align="right" style="width: 10%">
                                                            <asp:RequiredFieldValidator ID="RFVIsSoundE" runat="server" ForeColor="Red" ValidationGroup="NN"
                                                                ControlToValidate="flSoundE"></asp:RequiredFieldValidator>
                                                            <strong>
                                                                <asp:Label ID="L1" runat="server" CssClass="astrics" Text="*"></asp:Label>
                                                                English : </strong>
                                                        </td>
                                                        <td>
                                                            <asp:FileUpload ID="flSoundE" onchange="fileTypeCheckengE(this.value);" runat="server"
                                                                Style="width: 88%;" />
                                                        </td>
                                                        <td>
                                                            <div style="width: 25px; float: right; padding-right: 15px;">
                                                                <ul class="graphic">
                                                                    <li><a id="FileDownEnglish" runat="server" title="Play" class="sm2_link"></a></li>
                                                                </ul>
                                                            </div>
                                                            <asp:Label ID="lblfileE" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
                                                        </td>
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
                                                                runat="server" Text="For record the audio file, Please click the link "></asp:Label>
                                                            &nbsp; <a href="http://wavepad.en.softonic.com/" style="font-family: Arial; font-size: 12px;
                                                                color: Blue;" target="_blank">Click</a>
                                                        </td>
                                                    </tr>
                                                </table>
                                            </fieldset>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td align="center" colspan="4">
                                            <asp:Button ID="btnSave" runat="server" CssClass="button_all" OnClick="btnAddServices_Click"
                                                ValidationGroup="SRVS" Text="OK" />
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
                <!-------------------Start Service Popup--------------->
                <asp:Panel ID="PanelServices" runat="server" Width="55%">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnclosesrv" CssClass="popupClose" runat="server" /></div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="LabelAlertHeadsrv" runat="server" Font-Bold="true" Text="Our Services"></asp:Label>
                                    </span>
                                </p>
                            </div>
                            <div class="regis_popup">
                                <div class="wrapper" id="wrapper">
                                    <div class="specialties" id="specialties">
                                        <div class="container">
                                            <div class="heading text-center">
                                                <h2>
                                                    Our Services</h2>
                                            </div>
                                            <div class="row">
                                                <asp:Panel ID="pnlTextBox" runat="server">
                                                </asp:Panel>
                                                <asp:Panel ID="pnlDropDownList" runat="server">
                                                </asp:Panel>
                                                <asp:Literal ID="srvlitral" runat="server"></asp:Literal>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupExtenderServices" runat="server" BackgroundCssClass="NewmodalBackground"
                    PopupControlID="PanelServices" TargetControlID="lblsrvcontrol" CancelControlID="btnclosesrv">
                </cc1:ModalPopupExtender>
                <asp:Label ID="lblsrvcontrol" runat="server"></asp:Label>
                <!-------------------End Start Service Popup--------------->
                <!-------------------Start Alert Popup--------------->
                <asp:Panel ID="PanelAlert" runat="server" Width="25%">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnclosealerttest" CssClass="popupClose" runat="server" /></div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="LabelAlertHead" runat="server" Font-Bold="true" Text="Alert"></asp:Label>
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
                                        <td style="height: 7px;">
                                        </td>
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
                    PopupControlID="PanelAlert" TargetControlID="lbltestcontrol" CancelControlID="btnclosealerttest">
                </cc1:ModalPopupExtender>
                <asp:Label ID="lbltestcontrol" runat="server"></asp:Label>
                <!-------------------End Alert Popup--------------->
                <!-------------------Start Plan Grid Popup--------------->
                <asp:Panel ID="PlanGridView" runat="server" Width="30%">
                    <div class="popupContent" style="width: 100%;">
                        <div class="pop_log_bg">
                            <div>
                                <asp:Button ID="btnplgrw" CssClass="popupClose" runat="server" /></div>
                            <div class="service_head_p">
                                <p>
                                    <span class="left">
                                        <asp:Label ID="lblplgrw" runat="server" Font-Bold="true" Text="Plan Details"></asp:Label>
                                    </span>
                                </p>
                            </div>
                            <div class="regis_popup">
                                <div id="Div2" runat="server" style="width: 87% !important;">
                                    <p>
                                        <asp:Label ID="Label8" runat="server"></asp:Label></p>
                                </div>
                                <table width="100%" cellpadding="0px" cellspacing="5px">
                                    <tr>
                                        <td width="30%">
                                            <strong>Select Product</strong>
                                            <asp:RequiredFieldValidator ID="ReqFielValidator1" ErrorMessage="*" ForeColor="Red"
                                                runat="server" ControlToValidate="ddlProSelect" ValidationGroup="SSP" InitialValue="--Select--"></asp:RequiredFieldValidator>
                                        </td>
                                        <td>
                                            <asp:DropDownList ID="ddlProSelect" runat="server" CssClass="dropdown" onchange="javascript:CheckValidation()">
                                            </asp:DropDownList>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <strong>Select Plan</strong>
                                        </td>
                                        <td>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:GridView ID="PlanGridViewDetails" runat="server" AutoGenerateColumns="False"
                                                DataKeyNames="Plan_ID,Disp"  CssClass="table table-striped" EmptyDataText="Record Not Found"
                                                EmptyDataRowStyle-HorizontalAlign="Center" EnableModelValidation="True" Width="100%"
                                                BorderStyle="None" BorderWidth="0" BorderColor="transparent" AllowPaging="True"
                                                OnRowCommand="PlanGridViewDetails_RowCommand" PageSize="15">
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Action">
                                                        <ItemTemplate>
                                                            <%try
                                                              {
                                                                  PlanID = PlanGridViewDetails.DataKeys[upplanindex].Values["Plan_ID"].ToString();//LabelFlag 
                                                                  Disp = Convert.ToInt32(PlanGridViewDetails.DataKeys[upplanindex].Values["Disp"].ToString());
                                                              }
                                                              catch { }
                                                              if (Session["Plan_ID"].ToString() == PlanID)
                                                              {
                                                                  Disp = 1;
                                                                  if (Disp == 0)
                                                                  {
                                                            %>
                                                            <input type="radio" id="rdamcrenewalautasd" name="rdamcrewaut" checked="checked"
                                                                value='<%# Eval("PlanPeriod") %>' onclick="javascript:SelectSingleRadiobuttonAmc(this.id,this.value)" />
                                                            <%
                                                                }
                                                                  else
                                                                  {%>
                                                            <input type="radio" id="Radio1" name="rdamcrewaut" checked="checked" disabled="disabled"
                                                                value='<%# Eval("PlanPeriod") %>' onclick="javascript:SelectSingleRadiobuttonAmc(this.id,this.value)" />
                                                            <%
                                                                }
                                                              }
                                                              else
                                                              {
                                                                  if (Disp == 0)
                                                                  {%>
                                                            <input type="radio" id="Rrdamcrenewalaut" name="rdamcrewaut" value='<%# Eval("PlanPeriod") %>'
                                                                onclick="javascript:SelectSingleRadiobuttonAmc(this.id,this.value)" />
                                                            <% }
                                                                  else
                                                                  {%>
                                                            <input type="radio" id="Radio2" name="rdamcrewaut" disabled="disabled" value='<%# Eval("PlanPeriod") %>'
                                                                onclick="javascript:SelectSingleRadiobuttonAmc(this.id,this.value)" />
                                                            <%}
                                                              }%>
                                                            <%upplanindex++; %>
                                                            <asp:Label ID="lblrenewalPlanIDasd" runat="server" Text='<%# Bind("Plan_ID") %>'
                                                                Visible="false"></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                    </asp:TemplateField>
                                                    <%--<asp:TemplateField HeaderText="S.No">
                                            <ItemTemplate>
                                                <%=++sno %>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="4%" />
                                        </asp:TemplateField>--%>
                                                    <asp:TemplateField HeaderText="Plan Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbladdsrvtitleasd" runat="server" Text='<%# Bind("PlanName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                        <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Plan Time(In Months)">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblplntime" runat="server" Text='<%# Bind("PlanPeriod") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                                        <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Price">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblplnprice" runat="server" Text='<%# Bind("PlanPrice") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                                        <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="7%" />
                                                    </asp:TemplateField>
                                                    <%--<asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:Button ID="ImgbtnRedeem" runat="server" CommandArgument='<%# Bind("Plan_ID") %>'
                                                    CausesValidation="false" CommandName="BuyService" ToolTip="Redeem Awards" Text="Buy Now"
                                                    CssClass="redeem" />&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="7%" />
                                        </asp:TemplateField>--%>
                                                </Columns>
                                                <PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                <RowStyle CssClass="tr_line1" />
                                                <AlternatingRowStyle CssClass="tr_line2" />
                                            </asp:GridView>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td>
                                            <strong>Plan Period</strong>
                                        </td>
                                        <td>
                                            <asp:HiddenField ID="HdValAMC1" runat="server" />
                                            <asp:HiddenField ID="HdDateTo1" runat="server" />
                                            <asp:TextBox ID="txtdtfromamc1" onchange="FindNextDateAmc(this.value);" runat="server"
                                                Width="120px" onkeydown="return checkShortcut();" CssClass="reg_txt"></asp:TextBox>
                                            <strong>To </strong>
                                            <asp:TextBox ID="txtdttoamc1" Enabled="false" runat="server" CssClass="reg_txt" Width="120px"></asp:TextBox><br />
                                            <asp:TextBox ID="txtProName" runat="server" Style="display: none;"></asp:TextBox>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:CheckBox ID="chkterms" runat="server" Text="Terms & Conditions " onchange="javascript:CheckValidation()" /><a
                                                href="#"> Terms &amp; Condiions</a>
                                        </td>
                                    </tr>
                                    <tr>
                                        <td colspan="2">
                                            <asp:Button ID="btnAmcRenewal" ValidationGroup="SSP" runat="server" Text="Submit"
                                                OnClick="Submit_Click" CssClass="button_all_Sec" />
                                        </td>
                                    </tr>
                                </table>
                            </div>
                        </div>
                    </div>
                </asp:Panel>
                <cc1:ModalPopupExtender ID="ModalPopupExtenderGridView" runat="server" BackgroundCssClass="NewmodalBackground"
                    PopupControlID="PlanGridView" TargetControlID="lblctrlplgrw" CancelControlID="btnplgrw">
                </cc1:ModalPopupExtender>
                <asp:Label ID="lblctrlplgrw" runat="server"></asp:Label>
                <!-------------------End Plan Grid Popup--------------->
            </div>
       <%-- </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
        </Triggers>
    </asp:UpdatePanel>--%>
</asp:Content>
