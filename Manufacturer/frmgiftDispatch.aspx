<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="frmgiftDispatch.aspx.cs" Inherits="Manufacturer_frmgiftDispatch" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">


    <script src="../Content/js/toastr.min.js"></script>
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />

    <style>
        .astrics {
            color: red;
        }
    </style>

    <script type="text/javascript">
        $(document).ready(function () {

            $(".accordion2 p").eq(36).addClass("active");
            $(".accordion2 div.open").eq(30).show();

            $(".accordion2 p").click(function () {
                $(this).next("div.open").slideToggle("slow")
                    .siblings("div.open:visible").slideUp("slow");
                $(this).toggleClass("active");
                $(this).siblings("p").removeClass("active");
            });


        });

        function showModal() {
            toastr.error("Please Fill all Required Fields!");
        }


        function showAgainModal() {
            debugger;

            $("[id*=frmcourier]").modal('show');
        }


        function ChkDate(dt) {
            if ((parseInt(dt.substring(3, 5)) > 12) || (dt.substring(0, 2) > 31)) {
                toastr.error("Invalid date");
                document.getElementById("<%=txtDispatchDate.ClientID %>").value = "";

                return;
            }
            var selectedDate = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)) - 1, dt.substring(0, 2));
            var today = new Date();
            today.setHours(0, 0, 0, 0);
            if (selectedDate < today) {
                toastr.error("Select today or a date bigger than that!");
                document.getElementById("<%=txtDispatchDate.ClientID %>").value = "";

            }

        }

        function ShowPopup() {

            $("#frmcourier").modal("show");
        }

    </script>

</asp:Content>


<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

    <div id="page-content-wrapper">
        <div class="container-fluid xyz">

            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Gift Dispatched Report</h4>
                        </header>

                        <div class="card-body card-body-nopadding">

                            <div class="row">
                                <div class="col-lg-4">
                                    <asp:Label ID="LblMsg" Visible="false" CssClass="small_font" runat="server"></asp:Label>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-lg-6">
                                </div>
                                <div class="col-lg-3">
                                    <asp:Button ID="btnDownloadExcel" runat="server" Text="Download Report" CausesValidation="false" OnClick="button_export" ValidationGroup="false" CssClass="btn btn-primary btn-block" />
                                </div>
                                <div class="col-lg-3">

                                    <asp:Button ID="btnShowPopup" runat="server" Text="Add Courier Details" OnClick="ShowPopup"
                                        CssClass="btn btn-primary btn-block"  />
                                </div>

                            </div>

                            <div class="row" style="margin-top:2%;">
                                <div class="col-md-12">
                                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped tblSorting table-bordered"
                                        EmptyDataText="Record Not Found" BorderColor="transparent">
                                        <HeaderStyle CssClass="tab-header" />

                                    </asp:GridView>
                                </div>


                            </div>


                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>

    <div class="modal fade bs-example-modal-new" tabindex="-1" role="dialog" aria-labelledby="myLargeModalLabel" aria-hidden="true" id="frmcourier">

        <div class="modal-dialog modal-lg modal-dialog-centered">

            <!-- Modal Content: begins -->
            <div class="modal-content">
                <!-- Modal Body -->
                <div class="modal-body p-0">
                    <div class="page-body full_cosw">
                        <div class="row">
                            <div class="col-lg-12">
                                <div class="head_topbg">
                                    <div class="profile-bg-img">
                                        <div class="card-block user-info">
                                            <h2>
                                                <asp:Label Style="color: #fd7e58;" runat="server" Text=""></asp:Label><span>Dispatch Details</span></h2>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-lg-12">


                                <div class="card-header custom-card-header mb-0 bt-0">
                                    <h5 class="card-header-text"><i class="fa fa-user-o mr-2"></i>Add New Courier Dispatch Details</h5>
                                    <asp:Image runat="server" ID="tick" Style="width: 40px" ImageUrl="~/assetsfrui/images/tick.gif" Visible="false" />

                                    <asp:Label ID="lblsuccess" runat="server" Text="Submitted Successfully" Style="color: #04a529; font: 15px" Visible="false"></asp:Label>
                                </div>
                                <div id="UpdatePanel1" class="mt-3">


                                    <div class="card-block pl-3 pr-3">

                                        <div class="view-info">
                                            <div class="profile_form">

                                                <asp:UpdatePanel ID="UpdatePanel4" runat="server">
                                                    <ContentTemplate>

                                                        <div class="row no-gutters">
                                                            <div class="col-md-6 px-2">
                                                                <div class="form-group">
                                                                    <lable class="col-form-label"><span class="astrics">*</span>Mobile No</lable>

                                                                    <asp:DropDownList class="form-control" ID="ddlMobileNo" runat="server"
                                                                        AutoPostBack="true">
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorF_3" runat="server" ForeColor="Red"
                                                                        ValidationGroup="PR1" ControlToValidate="txtDispatchDate" ErrorMessage="Mobile No is required " Display="Dynamic">
                                                                    </asp:RequiredFieldValidator>


                                                                </div>
                                                            </div>
                                                            <div class="col-md-6 px-2">
                                                                <div class="form-group">
                                                                    <lable class="col-form-label"><span class="astrics">*</span>Gift Name</lable>

                                                                    <asp:DropDownList class="form-control" ID="ddlGiftName" runat="server"
                                                                        AutoPostBack="true">
                                                                    </asp:DropDownList>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorF_2" runat="server" ForeColor="Red"
                                                                        ValidationGroup="PR1" ControlToValidate="txtDispatchDate" ErrorMessage="Gift Name is required " Display="Dynamic">
                                                                    </asp:RequiredFieldValidator>

                                                                </div>
                                                            </div>
                                                            <div class="col-md-6 px-2">
                                                                <div class="form-group">
                                                                    <label class="col-form-label"><span class="astrics">*</span>Dispatch Date</label>

                                                                    <asp:TextBox TextMode="Date" class="form-control" ID="txtDispatchDate" runat="server"></asp:TextBox>

                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorF_1" runat="server" ForeColor="Red"
                                                                        ValidationGroup="PR1" ControlToValidate="txtDispatchDate" ErrorMessage="Dispatch Date is required " Display="Dynamic">
                                                                    </asp:RequiredFieldValidator>

                                                                </div>
                                                            </div>
                                                            <div class="col-md-6 px-2">
                                                                <div class="form-group">
                                                                    <label class="col-form-label"><span class="astrics">*</span>Tracking No.</label>

                                                                    <asp:TextBox ID="txtTrackingNo" class="form-control" runat="server"
                                                                        Text=""></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ForeColor="Red"
                                                                        ValidationGroup="PR1" ControlToValidate="txtTrackingNo" ErrorMessage="Tracking No is required " Display="Dynamic">
                                                                    </asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-6 px-2">
                                                                <div class="form-group">
                                                                    <label class="col-form-label"><span class="astrics">*</span>Dispatch Location</label>

                                                                    <asp:TextBox ID="txtlocation" class="form-control" runat="server"
                                                                        Text=""></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorF_6" runat="server" ForeColor="Red"
                                                                        ValidationGroup="PR1" ControlToValidate="txtlocation" ErrorMessage="Dispatch Location is required " Display="Dynamic">
                                                                    </asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="col-md-6 px-2">
                                                                <div class="form-group">
                                                                    <label class="col-form-label"><span class="astrics">*</span>Courier Company</label>

                                                                    <asp:TextBox ID="txtCourierCom" class="form-control" runat="server"
                                                                        Text=""></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorF_7" runat="server" ForeColor="Red"
                                                                        ValidationGroup="PR1" ControlToValidate="txtCourierCom" ErrorMessage="Courier Company is required " Display="Dynamic">
                                                                    </asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>
                                                            <div class="col-md-12 px-2">
                                                                <div class="form-group">
                                                                    <label class="col-form-label"><span class="astrics">*</span>Comments</label>

                                                                    <asp:TextBox Style="height: 80px;" ID="txtComments" class="form-control" runat="server"
                                                                        Text=""></asp:TextBox>
                                                                    <asp:RequiredFieldValidator ID="RequiredFieldValidatorF_8" runat="server" ForeColor="Red"
                                                                        ValidationGroup="PR1" ControlToValidate="txtComments" ErrorMessage="Comments is required " Display="Dynamic">
                                                                    </asp:RequiredFieldValidator>
                                                                </div>
                                                            </div>

                                                            <div class="text-right col-md-12 px-2 mb-3">
                                                                <div class="form-group">

                                                                    <%--<button type="button" class="btn btn-primary mr-2">Submit</button>--%>
                                                                    <asp:Button ID="btnsavecourier" OnClick="btnsavecourier_Click" ValidationGroup="PR1"
                                                                        class="btn btn-primary mr-2" runat="server" Text="Save" />
                                                                    <asp:Button ID="Button1" OnClick="Button1_Click" class="btn btn-default"
                                                                        runat="server" Text="Close" data-dismiss="modal" CausesValidation="false" />
                                                                    <%--<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>--%>
                                                                </div>
                                                            </div>
                                                        </div>


                                                    </ContentTemplate>
                                                    <Triggers>
                                                        <asp:PostBackTrigger ControlID="btnsavecourier" />

                                                    </Triggers>
                                                </asp:UpdatePanel>


                                            </div>
                                        </div>

                                    </div>

                                </div>
                            </div>

                        </div>


                    </div>

                </div>

                <!-- Modal Footer -->


            </div>
            <!-- Modal Content: ends -->

        </div>

    </div>


</asp:Content>

