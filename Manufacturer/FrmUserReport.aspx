<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="FrmUserReport.aspx.cs" Inherits="Manufacturer_FrmUserReport" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type="text/javascript">
        $(document).ready(function () {

            $(".accordion2 p").eq(28).addClass("active");
            $(".accordion2 div.open").eq(26).show();

            $(".accordion2 p").click(function () {
                $(this).next("div.open").slideToggle("slow")
                    .siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });

        });

    </script>
    <style>
        .roundedcorners {
            -webkit - border - radius: 30px;
            -khtml - border - radius: 30px;
            -moz - border - radius: 30px;
            border - radius: 30px;
        }
        .aadhar{
             align-content: center; margin-top: 10px;
        }
     
        .verifyimghide{
             width:20px;height:20px;
            display:none
        }
        .verifyimgshow{
            width: 20px !important;
            height: 20px !important;
            display: block;
            position: absolute;
            right:15px;
        }
        .box-data{
            padding: 10px;
            border: 1px solid #ececec;
            border-radius: 10px;
            background: #f5f5f5;
            position:relative;
        }
        .box-data img{
            height: 322px;
            width: 100%;
            border-width: 0px;
            border-radius: 10px;

        }
        .foot-box{
            padding-left:66px;
            position:relative;
            margin-top:15px;
        }
        .foot-box .roundedcorners{
            position:absolute;
           left:0;
        }
        .foot-box span, .foot-box strong{
               font-size: 14px !important;
        }
        .foot-box strong{
            font-weight:600 !important;
        }
    </style>

    <%--<script src="js/jquery-1.7.2.min.js"></script>--%>

    <script type="text/javascript">
        var pageIndex = 2;
        var pageCount;
        var cnt = 1;
        var yy="start";
        $(window).scroll(function () {
            if ($(window).scrollTop() == $(document).height() - $(window).height()) {
                GetRecords();
            }
        }); 
        function GetRecords() {
            debugger;
          
            //if (pageIndex == 2 || pageIndex <= pageCount) {
            var obj = {};
            obj.pageIndex = pageIndex++;
            obj.service = $.trim($('#ctl00_ContentPlaceHolder1_ddlService').val());
            obj.document = $.trim($('#ctl00_ContentPlaceHolder1_ddlDocuments').val());
            obj.mobile = $.trim($('#ctl00_ContentPlaceHolder1_txtMobile').val());
            obj.datefrom = $.trim($('#ctl00_ContentPlaceHolder1_txtdatefrom').val());
            obj.dateto = $.trim($('#ctl00_ContentPlaceHolder1_txtdateto').val());
            if (yy != "true") {
                if (!(yy = "start" && cnt > 1)) {
                    cnt++
                    $("#loader").show();
                    debugger;
                    $.ajax({
                        type: "POST",
                        url: "FrmUserReport.aspx/GetCustomers",
                        data: JSON.stringify(obj),
                        //data: '{pageIndex: ' + pageIndex + '}',
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnSuccess,
                        failure: function (response) {
                            alert(response.d);
                        },
                        error: function (response) {
                            alert(response.d);
                        }
                    });
                }
                else if (yy = "false")
                {
                    cnt++
                    $("#loader").show();
                    yy = "true";
                    debugger;
                    $.ajax({
                        type: "POST",
                        url: "FrmUserReport.aspx/GetCustomers",
                        data: JSON.stringify(obj),
                        contentType: "application/json; charset=utf-8",
                        dataType: "json",
                        success: OnSuccess,
                        failure: function (response) {
                            alert(response.d);
                        },
                        error: function (response) {
                            alert(response.d);
                        }
                    });
                }
        }
        }
        function OnSuccess(response) {
            debugger;
            var xmlDoc = $.parseXML(response.d);
            var xml = $(xmlDoc);
            pageCount = parseInt(xml.find("PageCount").eq(0).find("PageCount").text());
            var customers = xml.find("Customers");
           
            customers.each(function () {
                var customer = $(this);
              
                var table = $("#dvCustomers #table").eq(0).clone(true);
                //$(".name", table).html(customer.find("ContactName").text());
                yy = "false";
                $(".roundedcorners", table).attr("src",customer.find("profile_image").text());
                $(".lblcodescan", table).html(customer.find("code_scan").text());
                $(".aadhar", table).attr("src",customer.find("aadhar").text());
                $(".lblentry_date", table).html(customer.find("entry_date").text());
                $(".lblnm", table).html(customer.find("ConsumerName").text());
                $(".lblmobile", table).html(customer.find("MobileNo").text());
                //$("class^=verify", table).addClass(customer.find("Call_Status").text());
                
                $("#dvCustomers").append(table).append("<br />");
            });
            $("#loader").hide();
        }
    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

   <%-- <asp:UpdateProgress ID="UpdateProgress1" runat="server"
        DisplayAfter="0">
        <ProgressTemplate>
            <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%; top: 0px; z-index: 100001;"
                class="NewmodalBackground">
                <div style="margin-top: 300px;" align="center">
                    <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                    <span style="color: White;">Please Wait.....<br />
                    </span>
                </div>
            </div>
        </ProgressTemplate>
    </asp:UpdateProgress>--%>

 <div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                <div class="card card-admin form-wizard profile box_card">
                    <header class="card-header">
                        <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>User Data Report</h4>
                    </header>


                  <div class="card-body card-body-nopadding">
                        <div class="form-row">
                            <div class="col-lg-12">
                                <asp:Label ID="lblMsg1" runat="server"></asp:Label>
                            </div>
                            </div>
                            <div class="form-wizard medias">
                                
                                    <div class="col-lg-6">
                                       <%-- <h4 class="mb-0">Record(s) found<span> (<asp:Label ID="lblcount" runat="server"></asp:Label>)
                                                        <asp:Label ID="lblC" Text="0" runat="server" Visible="false"></asp:Label>
                                        </span></h4>--%>
                                    </div>
                                    <div class="col-lg-4">
                                        <asp:Label ID="LblMsg" CssClass="small_font" runat="server"></asp:Label>
                                    </div>

                               
                               <%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                                    <ContentTemplate>--%>
                                        <div class="form-row" style="font-size:larger">
                        <div class="form-group col-lg-6">
                              <asp:Label ID="txtTotal" runat="server" Text ="Total Users"/>&nbsp;&nbsp;&nbsp;<asp:Label ID="txttlcnt" runat="server" Text="0"/>
                               <%-- <label>From</label>--%>
                             
                        </div>
                             <div class="form-group col-lg-6">
                                  <asp:Label ID="txtdocument" runat="server" Text="Documents Available"/>&nbsp;&nbsp;&nbsp;<asp:Label ID="txtdocumentcount" runat="server" Text=""/>
                                 <%--<label>To</label>--%>
                             </div>
                        </div>
                                             <div class="form-row">
                        <div class="form-group col-lg-3">
                               <%-- <label>From</label>--%>
                             <asp:TextBox ID="txtDateFrom" runat="server"  CssClass="form-control form-control-sm"></asp:TextBox>
                             <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateFrom" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                               ErrorMessage="Please enter valid date."  ValidationGroup="servss" />
                        </div>
                             <div class="form-group col-lg-3">
                                 <asp:TextBox ID="txtDateto" runat="server" CssClass="form-control form-control-sm"></asp:TextBox>
                                   <asp:RegularExpressionValidator runat="server" ControlToValidate="txtDateto" ValidationExpression="(((0|1)[0-9]|2[0-9]|3[0-1])\/(0[1-9]|1[0-2])\/((19|20)\d\d))$"
                               ErrorMessage="Please enter valid date."  ValidationGroup="servss" />
                                 <%--<label>To</label>--%>
                             </div>
                                                 <div class="form-group col-lg-3">
                                        <asp:DropDownList ID="ddlService" runat="server" CssClass="form-control form-control-sm"></asp:DropDownList>
                                            </div>
                                            <div class="form-group col-lg-3">
                                        <asp:DropDownList ID="ddlDocuments" runat="server" CssClass="form-control form-control-sm">
                                             <asp:ListItem>All</asp:ListItem>
                                            <asp:ListItem Value="upload">Document Uploaded</asp:ListItem>
                                            <asp:ListItem Value="notupload">Document Not Uploaded</asp:ListItem>
                                            <asp:ListItem Value="verified">Verified</asp:ListItem>
                                               </asp:DropDownList>
                                            </div>
                        </div>
                                         
                                
                                             <div class="form-row">
                                          <div class="form-group col-lg-3">
                                             <asp:TextBox ID="txtMobile" runat="server" placeholder="Enter Mobile No for Search" MaxLength="10" CssClass="form-control form-control-sm" ></asp:TextBox>
                                             <asp:RegularExpressionValidator ID="REFmoblie" runat="server"
    ErrorMessage="Please enter valid phone no" ControlToValidate="txtMobile"   ForeColor="Red" style="font-size: small" ValidationExpression="^[7-9][0-9]{9}$"></asp:RegularExpressionValidator>
                                            
                                         </div>
                                                 
                                          
                                                 <div class="form-group col-lg-6">
                                <asp:ImageButton ID="ImgSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png" ValidationGroup="servss"
                                    ToolTip="Search"  />
                                <asp:ImageButton ID="ImgRefresh" CssClass="btn btn-success refreses_field" runat="server" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                        ToolTip="Reset" />
                            </div>
                                </div>           
                                        
                                       <%-- <div>
                                            <asp:Label ID="txtTotal" runat="server" Text ="Total Users"/>&nbsp;&nbsp;&nbsp;<asp:Label ID="txttlcnt" runat="server" Text="0"/>

                                        </div> --%>
                                                
                                <div class="form-group col-lg-6">
                                 <cc1:calendarextender ID="CalendarExtenderdatefrom" runat="server" TargetControlID="txtDateFrom" 
                                        Format="dd/MM/yyyy">
                                    </cc1:calendarextender>
                                    <cc1:maskededitextender ID="MaskedEditExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:maskededitextender>
                                    <cc1:textboxwatermarkextender ID="TextBoxWatermarkExtenderdatefrom" runat="server"
                                        TargetControlID="txtDateFrom" WatermarkText="Date From....">
                                    </cc1:textboxwatermarkextender>
                                    <cc1:calendarextender ID="CalendarExtender1to" runat="server" TargetControlID="txtDateto"
                                        Format="dd/MM/yyyy">
                                    </cc1:calendarextender>
                                    <cc1:maskededitextender ID="MaskedEditExtender1to" runat="server" TargetControlID="txtDateto"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:maskededitextender>
                                    <cc1:textboxwatermarkextender ID="TextBoxWatermarkExtender1to" runat="server" TargetControlID="txtDateto"
                                        WatermarkText="Date To....">
                                    </cc1:textboxwatermarkextender>
                            </div>
                                        <%--<div>
                                            <asp:Label ID="txtdocument" runat="server" Text="Documents Available"/>&nbsp;&nbsp;&nbsp;<asp:Label ID="txtdocumentcount" runat="server" Text="Search"/>

                                        </div>--%>
                                                </div>
                                        <div id="dvCustomers" class="row">
        <asp:Repeater ID="rptCustomers" runat="server">
    
            <ItemTemplate>
                <div id="table" class="col-md-6 mt-4">
                    <div class="box-data">
                                                                         
                                                            <div id="divadh" runat="server">
                                                                <asp:Image ID="imgadh" CssClass="aadhar" runat="server" ImageUrl='<%#Bind("aadhar") %>' onerror="this.src='../img/no-adhar.jpg'"  />
                                                            </div>
                                                    <%--    </td>
                                                    </tr>

                                                    <tr>
                                                       
                                                         <td>--%> 
                <div class="foot-box">
                                                            <asp:Image ID="imgpro" runat="server" Width="50px" Height="50px" AlternateText="No Image" ImageUrl='<%#Bind("profile_image") %>' CssClass="roundedcorners" Style="border-radius: 25px;" />
                                                            <strong>Consumer Name:</strong> <span class="lblnm"><%#Eval("ConsumerName") %></span>(<span class="lblmobile"><%#Eval("MobileNo") %></span>)&nbsp;<asp:Image src="../img/checkmark.png" class='<%#Eval("Call_Status") %>' id="verifiy" runat="server"/><br />
                                                             <strong>Document Uploaded Date:</strong>  <span class="lblentry_date"><%#Eval("Entry_Date") %></span>&nbsp;<br />
                                                              <strong>Total Code Scan:</strong> <span class="lblcodescan"><%#Eval("code_scan") %></span>
                                                      </div>
                    </div>
                    </div>
                                                  <%--      </td>
                                                    </tr>--%>
             <%--   <tr>
                    <td>
                        <b><u><span class="name">
                            <%# Eval("RowNumber") %></span></u></b>
                    </td>
                </tr>
                <tr>
                    <td>
                        <b>profile_image: </b><span class="city"><%# Eval("profile_image") %></span><br />
                        <b>code_scan: </b><span class="postal"><%# Eval("code_scan") %></span><br />
                        <b>aadhar: </b><span class="country"><%# Eval("aadhar")%></span><br />
                        <b>entry_date: </b><span class="phone" ><%# Eval("entry_date")%></span><br />
                        <%--<b>Fax: </b><span class="fax"><%# Eval("Fax")%></span><br />--%>
                   <%-- </td>
                </tr>--%>
        <%--    </table>--%>
           
            </ItemTemplate>
                <%--</asp:DataList>--%>
        </asp:Repeater>
    </div>
                              <%--      </ContentTemplate>
                                </asp:UpdatePanel>--%>

    


     
                       </div>
                          
                            </div>
                        </div>
              
                    </div>
                </div>
            
    </div>
        <div style="text-align: -webkit-center;">
            <img id="loader" alt="" src="../Content/images/ajax-loader.gif" style="display: none; position:fixed; bottom: 10%" />
        </div>

</asp:Content>

