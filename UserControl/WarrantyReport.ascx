<%@ Control Language="C#" AutoEventWireup="true" CodeFile="WarrantyReport.ascx.cs" Inherits="UserControl_BrandLoyaltyAwards" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<style>
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
      <%--  function onCompleteLaebl(Result) {
            if (Result == true) {
                document.getElementById("<%=lblLabelChk.ClientID %>").innerHTML = "Label Name Already exist.";
                document.getElementById("<%=btnSave.ClientID %>").disabled = true;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";
            }
            else {
                document.getElementById("<%=lblLabelChk.ClientID %>").innerHTML = "";
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
            }
            ChkSaveBtn();
        }
        function ChkSaveBtn() {
            var vl = document.getElementById("<%=lblLabelChk.ClientID %>").innerHTML;           
            if (vl == "") {                
                document.getElementById("<%=btnSave.ClientID %>").disabled = false;
                document.getElementById("<%=btnSave.ClientID %>").className = "button_all";
            }
            else {
                //document.getElementById("<%=btnSave.ClientID %>").disabled = true;
               //document.getElementById("<%=btnSave.ClientID %>").className = "button_all_Sec";
            }
        }   --%>

    $(document).ready(function () {
        $("#btnbrowsesave").on('click', function () {
            //var fData = new FormData();
            //var files = $("#productupload_warr").get(0).files;

            var fd = new FormData();
            var files = $('#productupload_warr')[0].files;

            for (var i = 0; i < files.length; i++) {
                fd.append(files[i].name, files[i]);
            }

            $.ajax({
                type: "POST",
                url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=updatewarranty&comment=' + $('#wrr_Comments_id').val() + '&id=' + $("#billId").val(),
                data: fd,
                contentType: false,
                processData: false,
                datatype: 'json',
                success: function (data) {
                    $('#wrr_Comments_id').val('');
                    $('#productupload_warr').val('');
                    $('#pClaimMessage').html('');
                    $('#pClaimMessage').html('Warranty claimed for the product, wait for the vendor approval.');
                    $('#pClaimModal').modal();
                    window.location.reload();
                },
                error: function (err) {
                    //$('#divLoader').hide();
                    alert(err.statusText);
                }
            });
        });
    });
</script>
<%-- <asp:UpdatePanel ID="UpdatePanel1" runat="server">
        <ContentTemplate>--%>
<div class="col-lg-9">
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
                    <h4 class="card-title"><i class="fa fa-pencil-square-o">Warrenty Report</i></h4>
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
                <div class="">
                    <div class="row pb-2 pt-2 background-section-form">
                        <div class="col-lg-10">
                            <h4 class="mb-0">Record(s) found<span> (<asp:Label ID="lblcount" runat="server"></asp:Label>)</span></h4>
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
                    <asp:GridView ID="GrdAwards" runat="server" AutoGenerateColumns="False" CssClass="table table-striped"
                        DataKeyNames="ImagePathBill" EmptyDataText="Record Not Found"
                        BorderColor="transparent"
                        AllowPaging="false" PageSize="15" Font-Size="Smaller">
                        <Columns>
                            <%--<asp:TemplateField>
   <ItemTemplate>
     <asp:HiddenField ID="key" runat="server" Value='<%#Eval("ID") %>' />
   </ItemTemplate>
</asp:TemplateField>
                            --%>

                            <asp:TemplateField HeaderText="Bill.No.">
                                <ItemTemplate>
                                    <%--<%=++str %>ImagePathBill--%>
                                    <asp:Label ID="lblbillno" runat="server" Text='<%# Bind("BillNo") %>'></asp:Label>
                                </ItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText=" Purchase on">
                                <ItemTemplate>
                                    <asp:Label ID="lblname" runat="server" Text='<%# Bind("PurchaseDate","{0:dd/MM/yyyy}") %>'></asp:Label>
                                </ItemTemplate>

                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Warranty (Months)">
                                <ItemTemplate>
                                    <asp:Label ID="lblWarPeriod" runat="server" Text='<%# Bind("WarrantyPeriod") %>'></asp:Label>
                                </ItemTemplate>

                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Expiration Date">
                                <ItemTemplate>
                                    <asp:Label ID="lblExpDate" runat="server" Text='<%# Bind("ExpirationDate","{0:dd/MM/yyyy}") %>'></asp:Label>
                                </ItemTemplate>

                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Remaining Days">
                                <ItemTemplate>
                                    <asp:Label ID="lblRemDays" runat="server" Text='<%# Bind("NumberofDays") %>'></asp:Label>
                                </ItemTemplate>

                            </asp:TemplateField>

                            <asp:TemplateField HeaderText="Bill pdf">
                                <ItemTemplate>
                                    <%--<asp:Label ID="lblBillPdf" runat="server"  ></asp:Label>--%>
                                    <asp:LinkButton ID="btnDownloadBill" runat="server" OnClick="lnkDownload_Click" ToolTip="Download Bill"><img src="../images/download.png" /></asp:LinkButton>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Claimed Status">
                                <ItemTemplate>
                                    <asp:CheckBox ID="chkID" runat="server" Checked='<%#Eval("IsWarrantyClaimed") %>' Enabled="false" />

                                </ItemTemplate>

                                <%--<ItemStyle HorizontalAlign="Center" Width="10%" />--%>
                            </asp:TemplateField>
                            <asp:TemplateField HeaderText="Vendor Status">
                                <ItemTemplate>
                                    <asp:Label ID="lblVendorClaimStatus" runat="server" Text='<%# Bind("VendorClaimStatus") %>'></asp:Label>
                                </ItemTemplate>
                            </asp:TemplateField>
                            <%--<asp:TemplateField HeaderText="Vendor Comments">
                            <ItemTemplate>
                                
                                <asp:Label ID="lblVendorComment" runat="server"  ToolTip='<%# Bind("Comment") %>' Text="Comments"></asp:Label>
                               
                            </ItemTemplate>
                                               
                        </asp:TemplateField>--%>

                            <asp:TemplateField HeaderText="Action">
                                <ItemTemplate>
                                    <a href="#" id="btn" class="btnUpload">Claim</a>
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

<div class="modal fade" id="popModalWar" tabindex="-1" role="alert" aria-labelledby="smallModalLabel" aria-hidden="true" style="">
    <div class="modal-dialog modal-sm">
        <div class="modal-content" style="width: 500px">
            <div class="modal-header">
                <h4 class="modal-title" id="smallModalLabel">Upload Product Image (VCQRU)</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <%--<p class="about-section-text1" id="p1msg">Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur pellentesque neque eget diam posuere porta. Quisque ut nulla at nunc vehicula lacinia. Proin adipiscing porta tellus, ut feugiat nibh adipiscing sit amet. In eu justo a felis faucibus ornare vel id metus. Vestibulum ante ipsum primis in faucibus.</p>--%>
                <p id="pbrowse1">
                    <%--<asp:HiddenField id="billId" Value="0" runat="server"/>--%>
                    <input type="hidden" id="billId" value="0">
                    <b style="color: black">Comments</b>&nbsp;&nbsp;&nbsp;&nbsp;<span id="spanEmail" style="color: black;"></span>
                    <input type="text" id="wrr_Comments_id" placeholder="Comments" name="Comments" data-msg-required="Please enter your comments." class="form-control"><br />
                    <b style="color: black">Product Upload:</b>&nbsp;<br />
                    <input type="file" name="name" id="productupload_warr" value="" multiple accept="" />
                    <br />
                    <br />
                    <input type="button" name="name22" id="btnbrowsesave" value="submit" class="btn btn-primary float-right" data-dismiss="modal" />

                </p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" data-dismiss="modal">Close</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="pClaimModal" tabindex="-1" role="alert" aria-labelledby="smallModalLabel" aria-hidden="true" style="">
    <div class="modal-dialog modal-sm">
        <div class="modal-content" style="width: 500px">
            <div class="modal-header">
                <h4 class="modal-title">Claim</h4>
                <button type="button" id="btnHeadClose" class="close" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">
                <p id="pClaimMessage"></p>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-light" id="btnFooterClose">Close</button>
            </div>
        </div>
    </div>
</div>
