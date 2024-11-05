<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="claimreport.aspx.cs" Inherits="SagarPetro_claimreport" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">


    <script type="text/javascript">

        $(document).ready(function () {

            $('#popModalWar .modal-footer button[data-dismiss="modal"]').click(function () {
                $('#popModalWar').modal('hide');
            });

            // Close modal when clicking on Close button in modal header
            $('#popModalWar .modal-header button.close').click(function () {
                $('#popModalWar').modal('hide');
            });


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

                const attr = $(this).attr('href');


                if (typeof attr !== 'undefined' && attr !== false) {
                    var id = $(this).closest("tr").find("input[type=hidden][id*=key]").val();
                    var mobile = $(this).closest("tr").find("input[type=hidden][id*=gmobileno]").val();
                    var amount = $(this).closest("tr").find("input[type=hidden][id*=gamount]").val();
                    $("#billId").val(id);
                    $("#hmobileno").val(mobile);
                    $("#hamount").val(amount);
                    $('#popModalWar').modal('show');

                }
            })

            //

        });

        function ShowPopup() {
            $("#popModalImages").modal();
        };
        function save() {
            debugger;
            var wrecomment = $('#wrr_Comments_id').val();
            var data = new FormData();
            var company = '<%= Session["CompanyId"].ToString() %>';
            data.append("id", $("#billId").val());
            data.append("comment", wrecomment);
            data.append("mobileno", $("#hmobileno").val());
            data.append("amount", $("#hamount").val());
            data.append("company", company);
            data.append("approveStatus", $('#<%=ddlStatus .ClientID %> option:selected').val());
            //alert($('#<%=ddlStatus .ClientID %> option:selected').val());
            var updatstStr = "succesfully updated!";
            if ($('#<%=ddlStatus .ClientID %> option:selected').val() == "1") {

                var updatstStr = "Claim Approved succesfully!";
            } else {
                var updatstStr = "Claim Rejected succesfully!";
            }
            $.ajax({
                type: "POST",
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=updateclaimVendor',
            data: data,
            contentType: false,
            processData: false,
            datatype: 'json',
            success: function (data) {
                alert(updatstStr);
                $('#p1msgWarranty').html(data);
                $('#smallModalWarranty').modal();
                window.location.reload();
            },
            error: function (err) {
                alert(err.statusText);
            }
        })
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
    </style>

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
                        <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Loyalty Claim Report (Bank Details)</h4>
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
                    <div class="form-row" style="margin-top: 10px;">
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

                    <div style="overflow: scroll;">
                        <div class="table-responsive">
                            <asp:GridView ID="GrdAwards" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                                DataKeyNames="Claim_id,Mobileno,Amount" EmptyDataText="Record Not Found"
                                BorderColor="transparent" AllowPaging="false" PageSize="15" Font-Size="Smaller"
                                OnRowDataBound="GrdAwards_RowDataBound">
                                <Columns>
                                    <asp:TemplateField HeaderText="Claim ID">
                                        <ItemTemplate>
                                            <asp:Label ID="lblclaimid" runat="server" Text='<%# Bind("Claim_id") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="left" Width="7%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Claim Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblcdate" runat="server" Text='<%# Bind("Claim_date", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="justify" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Mobile No">
                                        <ItemTemplate>
                                            <asp:Label ID="lblmobile" runat="server" Text='<%# Bind("Mobileno") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="justify" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Points">
                                        <ItemTemplate>
                                            <asp:Label ID="lblpname" runat="server" Text='<%# Bind("Amount") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="justify" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Points Value">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPointsValue" runat="server" Text='<%# Bind("PointsValue") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="justify" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="User Name">
                                        <ItemTemplate>
                                            <asp:Label ID="UserName" runat="server" Text='<%# Bind("ConsumerName") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="justify" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="City">
                                        <ItemTemplate>
                                            <asp:Label ID="City" runat="server" Text='<%# Bind("City") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="justify" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Documents Status">
                                        <ItemTemplate>
                                            <asp:Label ID="lblWarPeriod" runat="server" Text='<%# Bind("document_status") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Vendor Comment">
                                        <ItemTemplate>
                                            <asp:Label ID="lblcomment" runat="server" Text='<%# Bind("vendor_comment") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Account No">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAccount_No" runat="server" Text='<%# Bind("Account_No") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Account Holder Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblAccount_HolderNm" runat="server" Text='<%# Bind("Account_HolderNm") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Bank Name">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBank_Name" runat="server" Text='<%# Bind("Bank_Name") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="IFSC Code">
                                        <ItemTemplate>
                                            <asp:Label ID="lblIFSC_Code" runat="server" Text='<%# Bind("IFSC_Code") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Payment Status">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPaymentStatus" runat="server" Text='<%# Bind("PaymentStatus") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Bank RefID">
                                        <ItemTemplate>
                                            <asp:Label ID="lblBankRefID" runat="server" Text='<%# Bind("BankRefID") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Transaction Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblTransactionDate" runat="server" Text='<%# Bind("TransactionDate") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Payment Remarks">
                                        <ItemTemplate>
                                            <asp:Label ID="lblPaymentRemarks" runat="server" Text='<%# Bind("PaymentRemarks") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Claim Status">
                                        <ItemTemplate>
                                            <asp:Label ID="lblExpDate" runat="server" Text='<%# Bind("vendor_Status") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Action Date">
                                        <ItemTemplate>
                                            <asp:Label ID="lblRemDays" runat="server" Text='<%# Bind("action_date", "{0:dd/MM/yyyy}") %>'></asp:Label>
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" Width="10%" />
                                    </asp:TemplateField>

                                    <asp:TemplateField HeaderText="Action">
                                        <ItemTemplate>
                                            <a href="#" runat="server" id="btn" class="btnUpload">Approve/Reject</a>
                                            <asp:HiddenField ID="key" runat="server" Value='<%# Bind("Claim_id") %>' />
                                            <asp:HiddenField ID="gmobileno" runat="server" Value='<%# Eval("Mobileno") %>' />
                                            <asp:HiddenField ID="gamount" runat="server" Value='<%# Eval("Amount") %>' />
                                        </ItemTemplate>
                                        <ItemStyle HorizontalAlign="center" Width="10%" />
                                    </asp:TemplateField>
                                </Columns>
                            </asp:GridView>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>
    <div>
    </div>

    <div class="modal fade" id="popModalWar" tabindex="-1" role="alert" aria-labelledby="smallModalLabel" aria-hidden="true" style="">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="smallModalLabel">Approve/Reject Claim (VCQRU)</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">
                    <p id="pbrowse1">
                        <input type="hidden" id="billId" value="0">
                        <input type="hidden" id="hmobileno" value="0">
                        <input type="hidden" id="hamount" value="0">
                        <b style="color: black">Comments</b>&nbsp;&nbsp;&nbsp;&nbsp;<span id="spanEmail" style="color: black;"></span>
                        <input type="text" id="wrr_Comments_id" placeholder="Comments" name="Comments" data-msg-required="Please enter your comments." class="form-control"><br />
                        <b style="color: black">Action:</b>&nbsp;
                            <asp:DropDownList ID="ddlStatus" runat="server"
                                class="form-control mb-0">
                                <asp:ListItem Value="1">Approved</asp:ListItem>
                                <asp:ListItem Value="2">Reject</asp:ListItem>
                            </asp:DropDownList>
                        <br />
                        <input type="button" name="name22" id="btnbrowsesave" value="submit" data-dismiss="modal" onclick="save();" />
                    </p>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-light" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>

    <!-- Bootstrap CSS CDN -->
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">

    <!-- jQuery CDN -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <!-- Bootstrap JS CDN (Optional: Needed only if you use JavaScript features of Bootstrap like modals) -->
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</asp:Content>

