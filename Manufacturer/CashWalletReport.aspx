<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="CashWalletReport.aspx.cs" Inherits="Manufacturer_CashWalletReport" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">

<script type="text/javascript">
    function isNumber(evt) {
        //alert(evt);
        evt = (evt) ? evt : window.event;
        var charCode = (evt.which) ? evt.which : evt.keyCode;
        if (charCode > 31 && (charCode < 48 || charCode > 57)) {
            return false;
        }
        return true;
    }

    $(document).ready(function () {
        $(".accordion2 p").eq(13).addClass("active");
        $(".accordion2 div.open").eq(11).show();
        var company = '<%= Session["CompanyId"].ToString() %>';

        $(".accordion2 p").click(function () {
            $(this).next("div.open").slideToggle("slow")
                .siblings("div.open:visible").slideUp("slow");
            $(this).toggleClass("active");
            $(this).siblings("p").removeClass("active");
        });

        $(".btnUpload").click(function () {
            debugger;
            const attr = $(this).attr('href');

            // attribute exists?
            if (typeof attr !== 'undefined' && attr !== false) {
                var UPIID = $(this).closest("tr").find("input[type=hidden][id*=gUPIID]").val();
                var mobile = $(this).closest("tr").find("input[type=hidden][id*=gmobileno]").val();
                var Balance = $(this).closest("tr").find("input[type=hidden][id*=gBalance]").val();
                var ConsumerName = $(this).closest("tr").find("input[type=hidden][id*=gConsumerName]").val();

                $("#hUPIID").val(UPIID);
                $("#hmobileno").val(mobile);
                $("#hBalance").val(Balance);
                $("#hConsumerName").val(ConsumerName);
                $('#popModalWar').modal();
            }
        })

    });

    function ShowPopup() {
        $("#popModalImages").modal();
    };
    function save() {
        debugger;
        //var wrecomment = $('#wrr_Comments_id').val();
        var wrecomment = "NA";
        var data = new FormData();
        var company = '<%= Session["CompanyId"].ToString() %>';
        if ($("#hConsumerName").val().length < 2) {
            $('#Errmsg').html("**Please enter Consumer Name");
            //alert('Please enter Consumer Name!');
            $('#popModalWar').modal('show');
            return false;
        } if ($("#hBalance").val().length < 1) {
            //alert('Please enter Balance!');
            $('#Errmsg').html("**Please enter Balance!");
            document.getElementById('popModalWar').modal('show');
            //$('#popModalWar').modal('show');
            return false;
        } if ($("#hUPIID").val().length < 2) {
            //alert('Please enter UPIID!');
            $('#Errmsg').html("**Please enter UPIID!");
            $('#popModalWar').modal('show');
            return false;
        } if ($("#hTransactionDate").val().length < 2) {
            $('#popModalWar').modal('show');
            document.getElementById('popModalWar').modal('show');
            //alert('Please select Transaction Date!');
            $('#Errmsg').html("**Please select Transaction Date!");
            
            return false;
        } else {
            data.append("UPIID", $("#hUPIID").val());
            data.append("comment", wrecomment);
            data.append("mobileno", $("#hmobileno").val());
            data.append("Balance", $("#hBalance").val());
            data.append("ConsumerName", $("#hConsumerName").val());
            data.append("TransactionID", $("#hTransactionID").val());
            data.append("TransactionDate", $("#hTransactionDate").val());
            data.append("PaymentRemarks", $("#hPaymentRemarks").val());

            data.append("company", company);
            data.append("approveStatus", $('#<%=ddlStatus .ClientID %> option:selected').val());
            var updatstStr = "Update succesfully!";

            $.ajax({
                type: "POST",
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=updateclaimVendorMidas',
                data: data,
                contentType: false,
                processData: false,
                datatype: 'json',
                success: function (data) {
		//alert(data);
                    alert(updatstStr);
                    $('#p1msgWarranty').html(data);
                    $('#smallModalWarranty').modal();
                    window.location.reload();
                },
                error: function (err) {
                    //$('#divLoader').hide();
                    alert(err.statusText);
                }
            })
        }
        }

</script>
<style>
    .hiddencol {
        display: none;
    }

    .ajax__calendar_today {
        padding: 0px 0px 0px 0px;
    }

    .ajax__calendar_dayname {
        padding: 0px 0px 0px 0px;
    }

    .text-wrap {
        word-wrap: break-word;
    
}
</style>
<script type="text/javascript">
    function checklabel(vl) {
        //  PageMethods.checkNewLabel(vl, onCompleteLaebl)
    }

</script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
        
<div class="col-lg-12">

    <div class="sort-destination-loader sort-destination-loader-showing">
        <div class="row portfolio-list sort-destination" data-sort-id="portfolio">
            <div class="col-lg-12 card card-admin form-wizard profile">
                <asp:UpdateProgress ID="UpdateProgress1" runat="server"
                    DisplayAfter="0">
                    <ProgressTemplate>
                        <div align="center" style="position: absolute; left: 0; height: 907px; width: 100%; z-index: 100001; top: 0px;"
                            class="NewmodalBackground">
                            <div style="margin-top: 300px;" align="center">
                                <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                                <span style="color: White;">Please Wait.....<br />
                                </span>
                            </div>
                        </div>
                    </ProgressTemplate>
                </asp:UpdateProgress>
                <header class="card-header">
                    <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Loyalty Claim Report</h4>
                    <asp:Label ID="Label3" runat="server" CssClass="astrics"></asp:Label>
                </header>


                <div id="newMsg" runat="server" style="width: 91%;">
                    <p>
                        <asp:Label ID="Label2" runat="server"></asp:Label>
                    </p>
                </div>
                <div class="card-body card-body-nopadding" style="display: none;">
                    <h6>Search</h6>
                    <div class="form-row">
                        <div class="form-group col-lg-6">
                            <span class="req">*</span><label>Award Name</label>
                            <asp:TextBox ID="txtsearchlblname" runat="server" class="form-control form-control-sm" placeholder="Award Name"></asp:TextBox>
                        </div>

                        <div class="form-group col-lg-6">
                            <asp:ImageButton ID="ImgSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                OnClick="ImgSearch_Click" ToolTip="Search" />
                            <asp:ImageButton ID="ImgRefresh" runat="server" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                ToolTip="Reset" />
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-lg-12 card card-admin form-wizard medias">
               <div class="form-row" style="margin-top: 10px;display:none">
                            <div class="form-group col-lg-3">
                                <asp:Button ID="btnDownloadExcel" runat="server" Text="Download Report" CausesValidation="false" OnClick="btnDownloadExcel_Click" ValidationGroup="false" CssClass="btn btn-primary btn-block" />
                                </div>
                            </div>
                    <div class="row pb-2 pt-2 background-section-form">
                        <div class="col-lg-10">
                            <h4 class="mb-0">Record(s) found<span> (<asp:Label ID="lblcount" runat="server">kjhkjh</asp:Label>)</span></h4>
                        </div>
                        <div class="col-lg-2">
                            <asp:DropDownList ID="ddlRowProductCnt" runat="server"
                                class="form-control mb-0">
                                <asp:ListItem Value="5">25 Rows</asp:ListItem>
                                <asp:ListItem Value="6">50 Rows</asp:ListItem>
                                <asp:ListItem Value="100">100 Rows</asp:ListItem>
                                <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                <asp:ListItem Value="1000">1000 Rows</asp:ListItem>
                                <asp:ListItem Value="1001">All Rows</asp:ListItem>
                            </asp:DropDownList>
                        </div>
                    </div>

                    <div style="overflow: scroll;height:60vh;">
                        <asp:GridView ID="GrdAwards" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                            DataKeyNames="UPIID,ConsumerName,Mobileno,Balance" EmptyDataText="Record Not Found"
                            BorderColor="transparent"
                            AllowPaging="false" PageSize="15" Font-Size="Smaller" OnRowDataBound="GrdAwards_RowDataBound">
                            <Columns>                               


                            <%--    <asp:TemplateField HeaderText="Sr No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblclaimid" runat="server" Text='<%# Bind("[Claim_id]") %>'></asp:Label>
                                    </ItemTemplate>
                                   
                                    <ItemStyle HorizontalAlign="left" Width="7%" />
                                </asp:TemplateField>  --%>    

                                <asp:TemplateField HeaderText="UserName">
                                    <ItemTemplate>
                                        <asp:Label ID="UserName" runat="server" Text='<%# Bind("ConsumerName") %>'></asp:Label>
                                    </ItemTemplate>                                    
                                    <ItemStyle HorizontalAlign="Justify" Width="10%" />
                                </asp:TemplateField>

                                    <asp:TemplateField HeaderText=" Mobile No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblmobile" runat="server" Text='<%# Bind("[Mobileno]") %>'></asp:Label>
                                    </ItemTemplate>                                    
                                    <ItemStyle HorizontalAlign="Justify" Width="10%" />
                                </asp:TemplateField>

								<asp:TemplateField HeaderText="Balance">
                                    <ItemTemplate>
                                        <asp:Label ID="lblpname" runat="server" Text='<%# Bind("Balance") %>'></asp:Label>
                                    </ItemTemplate>                                   
                                    <ItemStyle HorizontalAlign="Justify" Width="10%" />
                                </asp:TemplateField>

                                <%-- <asp:TemplateField HeaderText="City">
                                    <ItemTemplate>
                                        <asp:Label ID="City" runat="server" Text='<%# Bind("City") %>'></asp:Label>
                                    </ItemTemplate>                                   
                                    <ItemStyle HorizontalAlign="Justify" Width="10%" />
                                </asp:TemplateField>--%>

                                  <asp:TemplateField HeaderText="UPI ID">
                                    <ItemTemplate>
                                        <asp:Label ID="lblAccount_No" runat="server" Text='<%# Bind("[UPIID]") %>'></asp:Label>
                                    </ItemTemplate>                                
                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                 </asp:TemplateField>

                               <%-- <asp:TemplateField HeaderText="Claim Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblExpDate" runat="server" Text='<%# Bind("[vendor_Status]") %>'></asp:Label>
                                    </ItemTemplate>                                    
                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                </asp:TemplateField>--%>

                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        
                                        <a href="javascript:void(0);" runat="server" id="btn" class="btnUpload" >Update Transaction</a>
                                        <asp:HiddenField ID="gConsumerName" runat="server" Value='<%# Bind("[ConsumerName]") %>' />
                                        <asp:HiddenField ID="gUPIID" runat="server" Value='<%# Bind("[UPIID]") %>' />
                                        <asp:HiddenField ID="gmobileno" runat="server" Value='<%#Eval("Mobileno") %>' />
                                        <asp:HiddenField ID="gBalance" runat="server" Value='<%#Eval("Balance") %>' />                                        
                                    </ItemTemplate>
                                </asp:TemplateField>
                            </Columns>
                        </asp:GridView>
                    </div>
                

            </div>
        </div>
    </div>
</div>
<div>
</div>
      
<div class="modal fade" id="popModalWar" tabindex="-1" role="alert" aria-labelledby="smallModalLabel" aria-hidden="true" style="">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="smallModalLabel">Update Transaction</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">

                <p id="pbrowse1">
                           <b id="Errmsg" class="invalid-feedback d-block"></b>
                    <%--<input type="hidden" id="hUPIID" value="0" />--%>
                    <input type="hidden" id="hmobileno" value="0" />

                 <%--   <input type="hidden" id="hBalance" value="0" />--%>
                     <span>Consumer Name *</span> 
                    <input type="text" id="hConsumerName"  name="hConsumerName" data-msg-required="Please enter Name." class="form-control" value="" required="" maxlength="30" readonly="" /><br />
                   
                   <span>Balance *</span> 
                    <input type="number"  id="hBalance"  name="hBalance" data-msg-required="Please enter Balance." class="form-control" value="0"  required="" onkeypress="return isNumber(event)" maxlength="6"  /><br />
                    <span>UPI ID</span>
                     <input type="text" id="hUPIID"  name="hUPIID" data-msg-required="Please enter UPI ID." class="form-control" value="" readonly="" /><br />
                    
                     <span>Transaction ID</span>
                    <input type="text" id="hTransactionID"  name="hTransactionID" data-msg-required="Please enter TransactionID." class="form-control" value=""  maxlength="50"  /><br />
                    <span>Transaction Date *</span>
                    <input type="date" id="hTransactionDate"  name="hTransactionDate" data-msg-required="Please enter Transaction Date." class="form-control" value="" required="" maxlength="30" /><br />
                    <span>Payment Remarks</span>
                    <input type="text" id="hPaymentRemarks"  name="hPaymentRemarks" data-msg-required="Please enter Payment Remarks." class="form-control" value="" maxlength="80" /><br />
                   <%--  <span>Comments</span>
                    <input type="text" id="wrr_Comments_id" placeholder="Comments" name="Comments" data-msg-required="Please enter your comments." class="form-control" /><br />
                   --%>
                    
                    <span>Payment Status:</span>&nbsp;
                            <asp:DropDownList ID="ddlStatus" runat="server"
                                class="form-control mb-0">
                                <asp:ListItem Value="Success">Success</asp:ListItem>
                          <%--      <asp:ListItem Value="2">Failed</asp:ListItem>--%>
                                <%--<asp:ListItem Value="0">Pending</asp:ListItem>--%>
                            </asp:DropDownList>

                    <br />
                    <button type="submit" name="name22" id="btnbrowsesave" onclick="return save();" >Submit</button>

                </p>
            </div>
            <div class="modal-footer">

                <button type="button" class="btn btn-light" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

</asp:Content>



