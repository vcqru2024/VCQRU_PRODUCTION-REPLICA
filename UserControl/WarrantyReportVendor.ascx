<%@ Control Language="C#" AutoEventWireup="true" CodeFile="WarrantyReportVendor.ascx.cs" Inherits="UserControl_Wrv" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<style>
    .dnld {
    }
</style>
<script type="text/javascript">

    $(document).ready(function () {
        $(".accordion2 p").eq(13).addClass("active");
        $(".accordion2 div.open").eq(11).show();
        var company = '<%= Session["CompanyId"].ToString() %>';
        if (company == "Comp-1249")
            $('.dnld').hide()
        else
            $('.dnld').show()
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
                var id = $(this).closest("tr").find("input[type=hidden][id*=key]").val();
                $("#billId").val(id)
;
                $('#popModalWar').modal();
            }

        });

        //

    });

    function ShowPopup() {
        $("#popModalImages").modal();
    };
    function save() {
        var wrecomment = $('#wrr_Comments_id').val();
        var data = new FormData();
        data.append("id", $("#billId").val());
        data.append("comment", wrecomment);
        data.append("approveStatus", $('#<%=ddlStatus .ClientID %> option:selected').text());

        $.ajax({
            type: "POST",
            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=updatewarrantyVendor',
                data: data,
                contentType: false,
                processData: false,
                datatype: 'json',
                success: function (data) {
                    $('#p1msgWarranty').html(data);
                    $('#smallModalWarranty').modal();
                    window.location.reload();
                },
                error: function (err) {
                    //$('#divLoader').hide();
                    alert(err.statusText);
                }
            });
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
<script type="text/javascript">
    function checklabel(vl) {
        //  PageMethods.checkNewLabel(vl, onCompleteLaebl)
    }

</script>
<%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
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
                    <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Claim Report</h4>
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
                            <%--<select class="form-control mb-0">
														<option>25 Rows</option>
														<option>20 Rows</option>
														<option>15 Rows</option>
													</select>--%>
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
                        <asp:GridView ID="GrdAwards" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                            DataKeyNames="ImagePathBill,ImagePath,ID" EmptyDataText="Record Not Found"
                            BorderColor="transparent" OnRowDataBound="GrdAwards_RowDataBound1"
                            AllowPaging="false" PageSize="15" Font-Size="Smaller">
                            <Columns>
                                <%--<asp:TemplateField>
   <ItemTemplate>
     <asp:HiddenField ID="key" runat="server" Value='<%#Eval("ID") %>' />
   </ItemTemplate>
</asp:TemplateField>--%>


                                <asp:TemplateField HeaderText="Bill.No.">
                                    <ItemTemplate>
                                        <%--<%=++str %>ImagePathBill--%>
                                        <asp:Label ID="lblbillno" runat="server" Text='<%# Bind("BillNo") %>'></asp:Label>
                                    </ItemTemplate>
                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                    <ItemStyle HorizontalAlign="left" Width="7%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText=" Purchase on">
                                    <ItemTemplate>
                                        <asp:Label ID="lblpdate" runat="server" Text='<%# Bind("PurchaseDate","{0:dd/MM/yyyy}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                    <ItemStyle HorizontalAlign="Justify" Width="10%" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Complete Code">
                                    <ItemTemplate>
                                        <asp:Label ID="lblccode" runat="server" Text='<%# Bind("Code") %>'></asp:Label>
                                    </ItemTemplate>
                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                    <ItemStyle HorizontalAlign="Justify" Width="10%" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText=" Mobile No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblmobile" runat="server" Text='<%# Bind("Mobile") %>'></asp:Label>
                                    </ItemTemplate>
                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                    <ItemStyle HorizontalAlign="Justify" Width="10%" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Product Name">
                                    <ItemTemplate>
                                        <asp:Label ID="lblpname" runat="server" Text='<%# Bind("Product_Name") %>'></asp:Label>
                                    </ItemTemplate>
                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                    <ItemStyle HorizontalAlign="Justify" Width="10%" />
                                </asp:TemplateField>


                                <asp:TemplateField HeaderText="Warranty Period(In Months)">
                                    <ItemTemplate>
                                        <asp:Label ID="lblWarPeriod" runat="server" Text='<%# Bind("WarrantyPeriod") %>'></asp:Label>
                                    </ItemTemplate>
                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Expiration Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblExpDate" runat="server" Text='<%# Bind("ExpirationDate","{0:dd/MM/yyyy}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Remaining Days">
                                    <ItemTemplate>
                                        <asp:Label ID="lblRemDays" runat="server" Text='<%# Bind("NumberofDays") %>'></asp:Label>
                                    </ItemTemplate>
                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Product Image">
                                    <ItemTemplate>
                                        <%--<asp:Label ID="lblBillPdf" runat="server"  ></asp:Label>--%>
                                        <asp:LinkButton ID="btnDownloadProduct" runat="server" ToolTip="Download Product Images" OnClick="lnkDownloadProduct_Click"><img src="../images/download.png" /></asp:LinkButton>
                                    </ItemTemplate>

                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Bill pdf">
                                    <ItemTemplate>
                                        <%--<asp:Label ID="lblBillPdf" runat="server"  ></asp:Label>--%>
                                        <asp:LinkButton ID="btnDownloadBill" class="dnld" runat="server" ToolTip="Download Bill" OnClick="lnkDownload_Click"><img src="../images/download.png" /></asp:LinkButton>

                                    </ItemTemplate>

                                    <ItemStyle HorizontalAlign="Center" Width="10%" />
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Vendor Status">
                                    <ItemTemplate>

                                        <asp:Label ID="lblVendorClaimStatus" runat="server" Text='<%# Bind("VendorClaimStatus") %>'></asp:Label>

                                    </ItemTemplate>

                                    <%-- <ItemStyle HorizontalAlign="Center" Width="10%" />--%>
                                </asp:TemplateField>

                                 <asp:TemplateField HeaderText=" Claim Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblcdate" runat="server" Text='<%# Bind("claimdate","{0:dd/MM/yyyy}") %>'></asp:Label>
                                    </ItemTemplate>
                                    <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                    <ItemStyle HorizontalAlign="Justify" Width="10%" />
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Vehicle Number">
                                    <ItemTemplate>
                                        <asp:Label ID="lblOther" runat="server" Text='<%# Bind("State") %>'></asp:Label>
                                    </ItemTemplate>
                                    <ItemStyle HorizontalAlign="Justify" Width="10%" />
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Comments">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVendorComment" runat="server" Text='<%# Bind("Comment") %>'></asp:Label>
                                    </ItemTemplate>
                                </asp:TemplateField>

                                <asp:TemplateField HeaderText="Action">
                                    <ItemTemplate>
                                        <a href="#" runat="server" id="btn" class="btnUpload">Approve</a>
                                        <asp:HiddenField ID="key" runat="server" Value='<%#Eval("ID") %>' />
                                        <%--<asp:ImageButton CausesValidation="false" ID="ImgbtnEdit" runat="server" ImageUrl="~/Content/images/edit.png" ToolTip="Upload Photo" OnClientClick="showDialog(this);" />--%>
                                    </ItemTemplate>


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

<div class="modal fade" id="popModalImages" tabindex="-1" role="alert" aria-labelledby="smallModalLabel" aria-hidden="true" style="">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title" id="smallModalLabel">Download Images (VCQRU)</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">

                <p id="pbrowse1">

                    <asp:GridView ID="gvImage" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                        DataKeyNames="FilePath" EmptyDataText="Record Not Found"
                        BorderColor="transparent"
                        AllowPaging="false" PageSize="15" Font-Size="Smaller">
                        <Columns>

                            <asp:TemplateField HeaderText="Image">
                                <ItemTemplate>
                                    <%-- <asp:Label ID="lblImageName" runat="server"    Text='<%# Bind("FilePath") %>'></asp:Label>--%>
                                    <asp:Image ID="Image1" runat="server" ImageUrl='<%# Eval("FilePath") %>' Height="25px" Width="25px" />

                                </ItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Download">
                                <ItemTemplate>
                                    <%--<asp:Label ID="lblBillPdf" runat="server"  ></asp:Label>--%>
                                    <asp:LinkButton ID="btnDownloadProductImage" runat="server" ToolTip="Download Product Images" OnClick="lnkDownloadProduct1_Click"><img src="../images/download.png" /></asp:LinkButton>

                                </ItemTemplate>

                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                            </asp:TemplateField>
                        </Columns>
                    </asp:GridView>

                </p>
            </div>
            <div class="modal-footer">

                <button type="button" class="btn btn-light" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>




<%-- </ContentTemplate>
        <Triggers>
            <asp:PostBackTrigger ControlID="btnSave" />
        </Triggers>
    </asp:UpdatePanel>--%>