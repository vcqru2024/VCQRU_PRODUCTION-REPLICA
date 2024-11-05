<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="~/Admin/CodeGeneration.aspx.cs" Inherits="Admin_CodeGeneration" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
   
    <script type="text/javascript">


        $(function () {
            bindData();
        });

	 $(function () {
            $("#ctl00_ContentPlaceHolder1_ddlcompany").change(function () {
                bindData();
            });
        });

        //function startRefresh() {
        //    setTimeout(bindData, 1000);
        //    //$.get('pagelink.php', function (data) {
        //    //    $('#content_div_id').html(data);
        //    //});
        //}
        $(document).ready(function () {
            
           // setInterval(bindData(), 50000);
           
            //if (username = "Company") {
            //    window.location.href = "../Info/Login.aspx?Page=CodeGeneration.aspx&usertype=Admin";;
            //}
            //else {
            //    if (username == "Company")
            //        window.location.href = "Index.aspx";
            //}
           // bindData();
        });
        function generatecode() {
            
            var code = $('#txtcodes').val();

 var Comp_ID = $('#ctl00_ContentPlaceHolder1_ddlcompany').find('option:selected').val();
            var Comp = $('#ctl00_ContentPlaceHolder1_ddlcompany').find('option:selected').text();
            if (Comp_ID == "VCQRU PRIVATE LIMITED")
                Comp_ID = null;

            if (code != "") {
                if (parseInt(code) > 100000)
                {
                    $.alert("Please enter value not exceeding 100000 (1 lakh)");
                    return;
                }
            }
            if (code != "") {
                $.confirm({
                    title: 'Confirm!',
                    content: 'Are you sure to generate code of : <span style="color:blue;" > ' + code + '</span> !',
                    buttons: {
                        confirm: function () {
                            $('#divprogress').css("display", "block")
                            $.ajax({
                                type: "POST",
                                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/generatecode",
                                data: "{'code':'" + code + "','Comp_ID':'" + Comp_ID + "'}",
                                contentType: "application/json; charset=utf-8",
                                dataType: "json",
                                success: function (data) {
                                   
                                    if (data.d != "") {
                                        $('#divprogress').css("display", "none")
                                        $('#txtcodes').val('');
                                        $.alert(data.d);
                                    }
                                }
                            });
                            
                        },
                        cancel: function () {
                            $.alert('Canceled!');
                        }
                    }
                });
            }
            else {
                $.alert("Please don\'t keep the code field empty");

            }
        }
        function bindData() {
            setTimeout(bindData, 20000);
           
            var objdata1 = "";

var Comp_ID = $('#ctl00_ContentPlaceHolder1_ddlcompany').find('option:selected').val();
            if (Comp_ID == "VCQRU PRIVATE LIMITED")
                Comp_ID = null;

            $.ajax({
                type: "POST",
                url: "<%=ProjectSession.absoluteSiteBrowseUrl%>/Admin/adminhandeler.asmx/bindcodeData",
                data: "{'Comp_ID':'" + Comp_ID + "'}",
                contentType: "application/json; charset=utf-8",
                dataType: "json",
                success: function (data) {
                   // debugger;
                    if (data != "") {
                        var codedata = data.d.split("$");
                        if (codedata.length > 0) {
                            $('#lbltotal').text(codedata[0]);
                            $('#lblused').text(codedata[1]);
                            $('#lbldemouse').text(codedata[2]);
                            $('#lblava').text(codedata[3]);
                          //  alert('');
                        }
                    }
                }
            });
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
                <img src="../images/generate_code_.png" />Code Bank
            </h3>

            <div id="accordion" class="accordion-style2">

  <div class="group" style="text-align:center;">

                    <asp:DropDownList class="form-control" style="text-align:center;" ID="ddlcompany" runat="server">
                        <asp:ListItem Value="VCQRU PRIVATE LIMITED">VCQRU PRIVATE LIMITED</asp:ListItem>
                        <asp:ListItem Value="Comp-1693">PATANJALI AYURVED LIMITED</asp:ListItem>
                    </asp:DropDownList>

            </div>

                <div class="group">
                    <h3 class="accordion-header">Code Statistics</h3>

                    <div>
                        <div style="font-size: 25px;">
                            <table width="100%" cellpadding="0" cellspacing="0" class="code_tab">
                                <tr>
                                    <td align="right" width="60%" style="color: gray">Total Generated Codes :
                                    </td>
                                    <td class="grd_pad">
                                        <strong>
                                            <label id="lbltotal" style="font-size: 20px; font-weight: bold; padding: 0 0 0 26px;"></label>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="color: gray">License Codes :
                                    </td>
                                    <td class="grd_pad">
                                        <strong>
                                            <label id="lblused" style="font-size: 20px; font-weight: bold; padding: 0 0 0 26px;"></label>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="color: gray">Demo Codes :
                                    </td>
                                    <td class="grd_pad">
                                        <strong>
                                            <label id="lbldemouse" style="font-size: 20px; font-weight: bold; padding: 0 0 0 26px;"></label>
                                        </strong>
                                    </td>
                                </tr>
                                <tr>
                                    <td align="right" style="color: gray">Balance Codes :
                                    </td>
                                    <td class="grd_pad">
                                        <strong>
                                            <label id="lblava" style="font-size: 20px; font-weight: bold; padding: 0 0 0 26px;"></label>
                                        </strong>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                </div>

                <div class="group">
                    <h3 class="accordion-header">Generate new codes</h3>

                    <div>
                        <table width="80%" cellpadding="0" cellspacing="0" style="margin: 0 auto;">
                            <tr height="45" valign="middle">
                                <td align="center" width="70%">
                                    <input type="text" id="txtcodes" class="form-control ui-autocomplete-input" maxlength="7" style="text-align: center; height: 42px; margin-top: 12px;" />
                                </td>
                                <td>
                                    <input id="btnGenerate" onclick="return generatecode();" class="btn btn-send-message" type="button"  value="Submit" style="text-align: center; height: 42px; margin-top: 12px;" />
                                </td>
                            </tr>
                        </table>
                        <br />
                        <p>
                            <span class="astrics" style="color: red">* <b>Note</b></span><br />
                            Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem
                            Ipsum has been the industry's standard dummy text ever since the 1500s, when an
                            unknown printer took a galley.
                        </p>
                    </div>
                </div>


            </div>
            <!-- #accordion -->
        </div>

    </div>
</asp:Content>

