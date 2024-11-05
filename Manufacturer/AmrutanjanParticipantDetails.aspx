<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="AmrutanjanParticipantDetails.aspx.cs" Inherits="Manufacturer_AmrutanjanParticipantDetails" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script type="text/javascript">


        $(document).ready(function () {
            $(".accordion2 p").eq(13).addClass("active");
            $(".accordion2 div.open").eq(11).show();
        <%--var company = '<%= Session["CompanyId"].ToString() %>';--%>

        $(".accordion2 p").click(function () {
            $(this).next("div.open").slideToggle("slow")
                .siblings("div.open:visible").slideUp("slow");
            $(this).toggleClass("active");
            $(this).siblings("p").removeClass("active");
        });



            $(function () {
                $("[id*=btnSearch]").click(function () {
                    var isdoc = $("#path");
                    var th = $("[id*=GridView1] th:contains('Country')");
                    th.css("display", isChecked ? "" : "none");
                    $("[id*=GridView1] tr").each(function () {
                        $(this).find("td").eq(th.index()).css("display", isChecked ? "" : "none");
                    });
                });
            });



            $(".btnedit").click(function () {
                debugger;
                const attr = $('#lblMode').val();
                if (attr == "QR Code") {
                    alert('You Can not edit this!');
                    return false;

                }
                else {
                    $('#lblMode').attr('disabled', false);
                }

            });




            $(".proofp").click(function () {
                debugger;
                const attr = $(this).attr('href');
                if (attr == "https://www.vcqru.com/") {
                    alert('Upload Doc first!');
                    return false;

                }
                else {
                    $(this).attr('disabled', false);
                }

            });

            //proofp

        $(".btnUpload").click(function () {
            debugger;
            const attr = $(this).attr('href');

            // attribute exists?
            if (typeof attr !== 'undefined' && attr !== false) {
                var id = $(this).closest("tr").find("input[type=hidden][id*=key]").val();
                var mobile = $(this).closest("tr").find("input[type=hidden][id*=gmobileno]").val();
                var amount = $(this).closest("tr").find("input[type=hidden][id*=gamount]").val();
                //alert(mobile);
                $("#billId").val(id);
                $("#ctl00_ContentPlaceHolder1_hfidnew1").val(mobile);
                $(".hfidnew").val(mobile);
                $('#popModalWar').modal();

            }
        })

        //

    });

        function ShowPopup() {
            debugger;
            $("#popModalImages").modal();
        };

    </script>

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Participant Details</h4>
                        </header>



                        <div class="card-body card-body-nopadding">

                            <div class="form-row">

                                <div class="form-group col-lg-3">
                                    <asp:TextBox ID="txtfromdate" CssClass="form-control" runat="server" TextMode="Date"></asp:TextBox>
                                </div>

                                <div class="form-group col-lg-3">
                                    <asp:TextBox ID="txttodate" CssClass="form-control" runat="server" TextMode="Date"></asp:TextBox>
                                </div>


                                <div class="form-group col-lg-3">
                                    <asp:DropDownList ID="ddlmode" runat="server" CssClass="form-control">
                                        <asp:ListItem disabled="disabled" Selected="Selected">--Select Mode--</asp:ListItem>
                                        <asp:ListItem>QR Code</asp:ListItem>
                                        <asp:ListItem>Missed Call</asp:ListItem>
                                    </asp:DropDownList>

                                </div>

                                <div class="form-group col-lg-3">
                                    <asp:TextBox ID="txtstate" CssClass="form-control" runat="server" placeholder="Enter State Name"></asp:TextBox>
                                </div>

                                <div class="form-group col-lg-3">

                                    <asp:DropDownList ID="txtproduct" runat="server" CssClass="form-control">
                                        <asp:ListItem Selected="selected" disabled="disabled">--Select Product--</asp:ListItem>
                                        <asp:ListItem Text="New Amrutanjan Pain Balm Extra Power - 8ml" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Amrutanjan New Maha Strong Pain Balm - 8ml" Value="2"></asp:ListItem>
                                        <asp:ListItem Text="Amrutanjan Strong Pain Balm - 8ml" Value="3"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                              <div class="form-group col-lg-3">
                                    <asp:DropDownList ID="ddlkyc" runat="server" CssClass="form-control">
                                        <asp:ListItem Selected="selected" disabled="disabled">--Select Kyc--</asp:ListItem>
                                        <asp:ListItem Text="Kyc Not Completed" Value="0"></asp:ListItem>
                                        <asp:ListItem Text="Completed" Value="1"></asp:ListItem>
                                        <asp:ListItem Text="Rejected" Value="2"></asp:ListItem>
                                    </asp:DropDownList>
                                </div>


                                <div class="form-group col-lg-1">
                                    <asp:ImageButton ID="btnSearch" runat="server" CssClass="btn btn-primary" ImageUrl="~/Content/images/search_rec.png"
                                        OnClick="btnSearch_Click" ToolTip="Search(Amount)" />
                                </div>


                                <div class="col-lg-2">

                                    <asp:Button ID="btnDownloadExcel" runat="server" Text="Download" CausesValidation="false" OnClick="btnDownloadExcel_Click" ValidationGroup="false" Width="190" CssClass="btn btn-primary" Style="margin-left: 35px;" />
                                </div>

                            </div>
                        



                            <br />
                            <hr />
                            <div class="clearfix"></div>

                            <asp:UpdatePanel ID="up1" runat="server">
                                <ContentTemplate>

                                    <div class="form-row">

                                        <div class="table-responsive">
                                            <asp:GridView ID="GridView1" PageSize="15" AllowPaging="false" AllowSorting="true" OnRowCommand="GridView1_RowCommand" OnPageIndexChanging="GridView1_PageIndexChanging" AutoGenerateColumns="false" runat="server" CssClass="table table-bordered table-hover table-condenced">
                                                <HeaderStyle CssClass="tab-header" />
                                                <Columns>

                                                    <asp:TemplateField HeaderText="S.No.">
                                                        <ItemTemplate>
                                                            <%#Container.DataItemIndex+1 %>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Product Name">
                                                        <ItemTemplate>

                                                            <asp:Label ID="lblProductName" runat="server" Text='<%# Bind("ProductName") %>'></asp:Label>
                                                        </ItemTemplate>

                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Participant Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblParticipantName" runat="server" Text='<%# Bind("ParticipantName") %>'></asp:Label>
                                                        </ItemTemplate>

                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Phone Number">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblPhoneNumber" runat="server" Text='<%# Bind("PhoneNumber") %>'></asp:Label>
                                                        </ItemTemplate>

                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Gender">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblGender" runat="server" Text='<%# Bind("Gender") %>'></asp:Label>
                                                        </ItemTemplate>

                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Age">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblAge" runat="server" Text='<%# Bind("Age") %>'></asp:Label>
                                                        </ItemTemplate>

                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Address">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblAddress" runat="server" Text='<%# Bind("Address") %>'></asp:Label>
                                                        </ItemTemplate>

                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="City">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblCity" runat="server" Text='<%# Bind("City") %>'></asp:Label>
                                                        </ItemTemplate>

                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="State">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblState" runat="server" Text='<%# Bind("State") %>'></asp:Label>
                                                        </ItemTemplate>

                                                    </asp:TemplateField>



                                                    <asp:TemplateField HeaderText="Proof for Purchase">
                                                        <ItemTemplate>
                                                            <a href='https://www.vcqru.com/<%# Eval("ProofforPurchase") %>'  class="proofp" target="_blank" id="path"><span class="icon-docs"></span></a>
                                                            <asp:HiddenField ID="hdpop" runat="server" />
                                                            <%--  <asp:Label ID="lblProofforPurchase" runat="server" Text='<%# Bind("ProofforPurchase") %>' Visible="false"></asp:Label>--%>
                                                            
                                                        </ItemTemplate>

                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="Mode">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblMode" runat="server" Text='<%# Bind("Mode") %>'></asp:Label>
                                                        </ItemTemplate>

                                                    </asp:TemplateField>


                                                    <asp:TemplateField HeaderText="KYC STATUS">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblkyc" runat="server" Text='<%# Bind("IsKycCompleted") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="COMMENT">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblcmt" runat="server" Text='<%# Bind("Comment") %>'></asp:Label>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="KYC UPDATE">
                                                        <ItemTemplate>
                                                            <a href="#" runat="server" id="btn" class="btnUpload">Approve</a>
                                                            <asp:HiddenField ID="gmobileno" runat="server" Value='<%#Eval("Id") %>' />
                                                            <%--<asp:linkbutton ID="btnaccept" CommandName="Accept" CommandArgument='<%#Eval("PhoneNumber")%>'   Text="Accept" runat="server" />--%>
                                                        </ItemTemplate>
                                                    </asp:TemplateField>

                                                    <asp:TemplateField HeaderText="EDIT">
                                                        <ItemTemplate>
                                                            <asp:LinkButton ID="btnedit" CssClass="btnedit" CommandName="Editt" CommandArgument='<%#Eval("Id")%>' Text="Edit" runat="server" />
                                                            <asp:HiddenField ID="hdnmode" runat="server" Value='<%#Eval("Mode") %>' />
                                                        </ItemTemplate>
                                                    </asp:TemplateField>



                                                </Columns>

                                            </asp:GridView>
                                        </div>




                                    </div>


                                </ContentTemplate>
                            </asp:UpdatePanel>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <div class="modal fade" id="popModalWar" tabindex="-1" role="alert" aria-labelledby="smallModalLabel" aria-hidden="true" style="">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <h4 class="modal-title" id="smallModalLabel">Approve/Reject KYC </h4>
                    <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
                </div>
                <div class="modal-body">

                    <p id="pbrowse1">
                        <asp:HiddenField ID="hfidnew1" runat="server" />
                        <%--<asp:TextBox ID="hfidnew1" runat="server"></asp:TextBox>--%>

                        <b style="color: black">Action:</b>&nbsp;
                        
                    
                            <asp:DropDownList ID="ddlStatus" runat="server"
                                class="form-control mb-0">
                                <asp:ListItem Value="1">Approved</asp:ListItem>
                                <asp:ListItem Value="2">Reject</asp:ListItem>

                            </asp:DropDownList>
                        <br />
                        <b style="color: black">Comments</b>&nbsp;&nbsp;&nbsp;&nbsp;<span id="spanEmail" style="color: black;"></span>
                        <asp:TextBox ID="txtcomment" runat="server" placeholder="Comments" CssClass="form-control"></asp:TextBox>
                        <%--<input type="text" id="wrr_Comments_id"  placeholder="Comments" name="Comments" data-msg-required="Please enter your comments." class="form-control">--%>
                        <br />
                        <br />
                        <input type="button" name="name22" id="btnbrowsesave" runat="server" onserverclick="btnbrowsesave_ServerClick" value="submit" data-dismiss="modal" />

                    </p>
                </div>
                <div class="modal-footer">

                    <button type="button" class="btn btn-light" data-dismiss="modal">Close</button>
                </div>
            </div>
        </div>
    </div>
</asp:Content>

