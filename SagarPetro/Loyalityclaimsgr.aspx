<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true"CodeFile="Loyalityclaimsgr.aspx.cs" Inherits="SagarPetro_Loyalityclaimsgr" %>

    <%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
        <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

        </asp:Content>
        <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

            <!-- <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> -->
            <!-- <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css" rel="stylesheet"> -->
            <!-- <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.3.1/js/bootstrap.min.js"></script> -->
            <script type="text/javascript">

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
                            //$('#divLoader').hide();
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

            <%-- Search --%>
             <script>
                 function performSearch(searchText) {
                     $('#ctl00_ContentPlaceHolder1_GrdAwards tbody tr').each(function () {
                         var row = $(this);
                         var found = false;

                         row.find('td').each(function () {
                             var cellText = $(this).text().toLowerCase();
                             if (cellText.includes(searchText.toLowerCase())) {
                                 found = true;
                                 return false; // Exit the loop if found
                             }
                         });

                         if (found) {
                             row.show();
                         } else {
                             row.hide();
                         }
                     });
                 }
             </script>
            <%-- Search End --%>

            <div class="home-section">
                <div class="app-breadcrumb">
                    <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1 g-3">
                        <div class="col">
                            <h5>Loyalty Claim</h5>
                        </div>
                        <div class="col">
                            <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a>
                                    </li>
                                    <li class="breadcrumb-item active" aria-current="page">User</li>
                                    <li class="breadcrumb-item active" aria-current="page">Loyalty Claim</li>
                                </ol>
                            </nav>
                        </div>
                    </div>
                </div>
                <div class="user-role-card">
                 <%--   <div class="card">
                    <div class="card-body">
                        <div class="row">
                            <div class="col-md-3">
                                 <label class="form-label">Status</label>
                                <asp:DropDownList ID="dropdownstatus" AutoPostBack="true" OnSelectedIndexChanged="dropdownstatus_SelectedIndexChanged" runat="server" CssClass="form-control">
                                    <asp:ListItem Text="Select Status" Value="-1"></asp:ListItem>
                                    <asp:ListItem Text="Pending" Value="0"></asp:ListItem>
                                    <asp:ListItem Text="Approved" Value="1"></asp:ListItem>
                                    <asp:ListItem Text="Rejected" Value="2"></asp:ListItem>
                                </asp:DropDownList>
                            </div>
                            <div class="col-md-3">
                                <label class="form-label">Mobile Number</label>
                                <asp:TextBox ID="txtMobilenumber" runat="server" placeholder="Mobile Number" MaxLength="10" CssClass="form-control"></asp:TextBox>
                            </div>
                              <div class="col">
                                    <label class="form-label">From Date</label>
                                    <div class="input-group date" data-provide="datepicker">
                                        <asp:TextBox ID="txtfromdate" AutoComplete="off" runat="server"
                                            CssClass="form-control" MaxLength="10" placeholder="MM/DD/YYYY">
                                        </asp:TextBox>
                                        <cc1:CalendarExtender runat="server" ID="txtfromdate_ce" Format="dd-MMM-yyyy"
                                            PopupButtonID="txtfromdate" TargetControlID="txtfromdate">
                                        </cc1:CalendarExtender>
                                    </div>
                                </div>
                                <div class="col">
                                    <label class="form-label">To Date</label>
                                    <div class="input-group date" data-provide="datepicker">
                                        <asp:TextBox ID="txttodate" AutoComplete="off" runat="server"
                                            CssClass="form-control" MaxLength="10" placeholder="MM/DD/YYYY">
                                        </asp:TextBox>
                                        <cc1:CalendarExtender runat="server" ID="txttodate_ce" Format="dd-MMM-yyyy"
                                            Animated="False" PopupButtonID="txttodate" TargetControlID="txttodate">
                                        </cc1:CalendarExtender>
                                    </div>
                                </div>
                            <div class="col" style="margin-top:32px">
                                <asp:Button ID="btnseach" runat="server" OnClick="btnseach_Click" CssClass="btn btn-primary" Text="Search" />
                            </div>
                        </div>
                    </div>
                    </div>--%>
                    <div class="card">
                        <div class="card-body">
                            <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1">
                                <div class="col-md-3">
                                    <h4>Record(s) found<span> (<asp:Label ID="lblcount" runat="server">
                                            </asp:Label>)</span></h4>
                                </div>
                                <div class="col-md-3">
                                        <div class="global-search">
                                        <div class="form-group">
                                            <input type="search" id="searchInput" onkeyup="performSearch(this.value)"
                                                class="form-control" placeholder="Search">
                                            <span><i class="fa fa-search"></i></span>
                                        </div>
                                    </div>
                                </div>
                                <div class="col-md-3">
                                    <asp:Button ID="btnDownloadExcel" runat="server" Text="Download Report"
                                        CausesValidation="false" OnClick="btnDownloadExcel_Click"
                                        ValidationGroup="false" CssClass="btn btn-primary" />
                                    <asp:DropDownList ID="ddlRowProductCnt" runat="server" class="form-select w-25">
                                        <asp:ListItem Value="25">25 Rows</asp:ListItem>
                                        <asp:ListItem Value="50">50 Rows</asp:ListItem>
                                        <asp:ListItem Value="100">100 Rows</asp:ListItem>
                                        <asp:ListItem Value="500">500 Rows</asp:ListItem>
                                        <asp:ListItem Value="1000">1000 Rows</asp:ListItem>
                                        <asp:ListItem Value="all">All Rows</asp:ListItem>
                                    </asp:DropDownList>
                                </div>
                            </div>
                            <div class="app-table mt-3">
                                <div class="table-responsive">
                                    <asp:GridView ID="GrdAwards" runat="server" AutoGenerateColumns="False"
                                        CssClass="table table-striped" DataKeyNames="Claim_id,Mobileno,PointsValue"
                                        EmptyDataText="Record Not Found" AllowPaging="false"
                                        PageSize="15" Font-Size="Smaller" OnRowDataBound="GrdAwards_RowDataBound">
                                        <Columns>
                                            <asp:TemplateField HeaderText="Claim ID">
                                                <ItemTemplate>

                                                    <asp:Label ID="lblclaimid" runat="server"
                                                        Text='<%# Bind("[Claim_id]") %>'>
                                                    </asp:Label>
                                                </ItemTemplate>

                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText=" Claim Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblcdate" runat="server"
                                                        Text='<%# Bind("[Claim_date]") %>'></asp:Label>
                                                </ItemTemplate>

                                                <ItemStyle />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Mobile No">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblmobile" runat="server"
                                                        Text='<%# Bind("[Mobileno]") %>'>
                                                    </asp:Label>
                                                </ItemTemplate>

                                                <ItemStyle />
                                            </asp:TemplateField>
                                                   <asp:TemplateField HeaderText="Gift">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblgift" runat="server"
                                                        Text='<%# Bind("[Gifts_Redeemed]") %>'>
                                                    </asp:Label>
                                                </ItemTemplate>

                                                <ItemStyle />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Points">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblpname" runat="server"
                                                        Text='<%# Bind("PointsValue") %>'>
                                                    </asp:Label>
                                                </ItemTemplate>

                                                <ItemStyle />
                                            </asp:TemplateField>

                                        

                                            <asp:TemplateField HeaderText="UserName">
                                                <ItemTemplate>
                                                    <asp:Label ID="UserName" runat="server"
                                                        Text='<%# Bind("ConsumerName") %>'>
                                                    </asp:Label>
                                                </ItemTemplate>

                                                <ItemStyle />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="City">
                                                <ItemTemplate>
                                                    <asp:Label ID="City" runat="server" Text='<%# Bind("City") %>'>
                                                    </asp:Label>
                                                </ItemTemplate>

                                                <ItemStyle />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Documents Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblWarPeriod" runat="server"
                                                        Text='<%# Bind("[document_status]") %>'></asp:Label>
                                                </ItemTemplate>

                                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                                            </asp:TemplateField>
                                            <asp:TemplateField HeaderText="Vendor Comment">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblcomment" runat="server"
                                                        Text='<%# Bind("[vendor_comment]") %>'></asp:Label>
                                                </ItemTemplate>

                                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Claim Status">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblExpDate" runat="server"
                                                        Text='<%# Bind("[vendor_Status]") %>'></asp:Label>
                                                </ItemTemplate>

                                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Action Date">
                                                <ItemTemplate>
                                                    <asp:Label ID="lblRemDays" runat="server"
                                                        Text='<%# Bind("[action_date]") %>'>
                                                    </asp:Label>
                                                </ItemTemplate>

                                                <ItemStyle HorizontalAlign="Center" Width="10%" />
                                            </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Action">
                                                <ItemTemplate>
                                                    <a href="#" runat="server" id="btn"
                                                        class="btnUpload">Approve/Reject</a>
                                                    <asp:HiddenField ID="key" runat="server"
                                                        Value='<%# Bind("[Claim_id]") %>' />
                                                    <asp:HiddenField ID="gmobileno" runat="server"
                                                        Value='<%#Eval("Mobileno") %>' />
                                                    <asp:HiddenField ID="gamount" runat="server"
                                                        Value='<%#Eval("PointsValue") %>' />
                                                </ItemTemplate>
                                            </asp:TemplateField>
                                        </Columns>
                                    </asp:GridView>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-lg-12">
                    <div class="sort-destination-loader sort-destination-loader-showing">
                        <div class="row portfolio-list sort-destination" data-sort-id="portfolio">
                            <div class="col-lg-12 card card-admin form-wizard profile">
                                <asp:UpdateProgress ID="UpdateProgress1" runat="server" DisplayAfter="0">
                                    <ProgressTemplate>
                                        <div align="center"
                                            style="position: absolute; left: 0; height: 907px; width: 100%; z-index: 100001; top: 0px;"
                                            class="NewmodalBackground">
                                            <div style="margin-top: 300px;" align="center">
                                                <img alt="" src="../Content/images/ajax-loader.gif" /><br />
                                                <span style="color: White;">Please Wait.....<br />
                                                </span>
                                            </div>
                                        </div>
                                    </ProgressTemplate>
                                </asp:UpdateProgress>
                                <!-- <header class="card-header">
                                    <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Loyalty Claim Report (Bank
                                        Details)</h4>
                                    <asp:Label ID="Label3" runat="server" CssClass="astrics"></asp:Label>
                                </header> -->
    
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
                                            <asp:TextBox ID="txtsearchlblname" runat="server"
                                                class="form-control form-control-sm" placeholder="Award Name"></asp:TextBox>
                                        </div>
    
                                        <div class="form-group col-lg-6">
                                            <asp:ImageButton ID="ImgSearch" runat="server"
                                                ImageUrl="~/Content/images/search_rec.png" OnClick="ImgSearch_Click"
                                                ToolTip="Search" />
                                            <asp:ImageButton ID="ImgRefresh" runat="server"
                                                ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                                ToolTip="Reset" />
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
              
    
                <div class="modal fade" id="popModalWar" tabindex="-1" role="alert" aria-labelledby="smallModalLabel"
                    aria-hidden="true">
                    <div class="modal-dialog">
                        <div class="modal-content">
                            <div class="modal-header">
                                <h5 class="modal-title" id="smallModalLabel">Approve/Reject Claim (Sagar Petrolium)</h5>
                                <button type="button" class="btn-close" data-dismiss="modal" aria-hidden="true"></button>
                            </div>
                            <div class="modal-body">
                                <p id="pbrowse1">
                                    <input type="hidden" id="billId" value="0">
                                    <input type="hidden" id="hmobileno" value="0">
                                    <input type="hidden" id="hamount" value="0">
                                    <b style="color: black">Comments</b>&nbsp;&nbsp;&nbsp;&nbsp;<span id="spanEmail"
                                        style="color: black;"></span>
                                    <input type="text" id="wrr_Comments_id" placeholder="Comments" name="Comments"
                                        data-msg-required="Please enter your comments." class="form-control"><br />
                                    <b style="color: black">Action:</b>&nbsp;
                                    <asp:DropDownList ID="ddlStatus" runat="server" class="form-control mb-0">
                                        <asp:ListItem Value="1">Approved</asp:ListItem>
                                        <asp:ListItem Value="2">Reject</asp:ListItem>
                                    </asp:DropDownList>
                                    <br />
                                    <input type="button" name="name22" id="btnbrowsesave" value="submit"
                                        data-dismiss="modal" onclick="save();" />
                                </p>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-light" data-dismiss="modal">Close</button>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            
        </asp:Content>