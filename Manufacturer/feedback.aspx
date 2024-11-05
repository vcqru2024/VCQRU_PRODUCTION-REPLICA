<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="Feedback.aspx.cs" Inherits="Manufacturer_Feedback" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
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

            $(".btnUpload").click(function () {
                debugger;
                const attr = $(this).attr('href');

                // attribute exists?
                if (typeof attr !== 'undefined' && attr !== false) {
                    var id = $(this).closest("tr").find("input[type=hidden][id*=key]").val();
                    var mobile = $(this).closest("tr").find("input[type=hidden][id*=gmobileno]").val();
                    var gName = $(this).closest("tr").find("input[type=hidden][id*=gName]").val();
                    $("#billId").val(id);
                    $("#hmobileno").val(mobile);
                    $("#hamount").val(gName);
                    $('#wrr_Comments_id').val(gName);
                    $('#popModalWar').modal();
                    $(this).closest("tr").find("input[type=hidden][id*=wrr_Comments_id]").val(gName);

                }
            });

        });

      

        function ShowPopup() {
            $("#popModalImages").modal();
        };

        function save() {
            debugger;
            /*var wrecomment = $(this).closest("tr").find("input[type=hidden][id*=wrr_Comments_id]").val();*/
            var wrecomment = $('#wrr_Comments_id').val();
            var data = new FormData();
            var company = '<%= Session["CompanyId"].ToString() %>';
             data.append("id", $("#billId").val());
             // data.append("comment", wrecomment);
             data.append("mobileno", $("#hmobileno").val());
             data.append("Name", wrecomment);


             data.append("Action", $('#<%=ddlStatus .ClientID %> option:selected').val());

        $.ajax({
            type: "POST",
            url: '<%=ProjectSession.absoluteSiteBrowseUrl%>Info/MasterHandler.ashx?method=DealerNameUpdate',
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
        })
        }

      </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">

          <div id="page-content-wrapper">
        <div class="container-fluid xyz">
            <div class="row">
                <div class="col-lg-12">
                    <div class="card card-admin form-wizard profile box_card">
                        <header class="card-header">
                            <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Feedback Details</h4>
                        </header>

                        <div class="card-body card-body-nopadding">
                            <div class="row">
                                <div class="col-lg-4">
                                    <asp:Label ID="LblMsg" Style="display: none;" CssClass="small_font" runat="server"></asp:Label>
                                </div>
                            </div>

                            <div class="row">
                                <div class="col-md-12" style="overflow: scroll;">
                                    <div class="table-responsive table_large">
                                    <asp:GridView ID="GridView1" runat="server" CssClass="table table-striped tblSorting table-bordered"
                                        EmptyDataText="Record Not Found" AutoGenerateColumns="false" BorderColor="transparent">
                                        <HeaderStyle CssClass="tab-header" />
                                        <Columns>

                                            <asp:TemplateField HeaderText="Name">
                                        <ItemTemplate>
                                            
                                            <asp:Label ID="lblM_Consumerid" runat="server" Text='<%# Bind("ConsumerName") %>'></asp:Label>
                                        </ItemTemplate>
                                       
                                        <ItemStyle HorizontalAlign="left" Width="7%" />
                                    </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Mobile No">
                                        <ItemTemplate>
                                            
                                            <asp:Label ID="lblMobileNo" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                                        </ItemTemplate>
                                       
                                        <ItemStyle HorizontalAlign="left" Width="7%" />
                                    </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Suggestion">
                                        <ItemTemplate>
                                            
                                            <asp:Label ID="lblName" runat="server" Text='<%# Bind("[Suggestion]") %>'></asp:Label>
                                        </ItemTemplate>
                                       
                                        <ItemStyle HorizontalAlign="left" Width="7%" />
                                    </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Rating">
                                        <ItemTemplate>
                                            
                                            <asp:Label ID="lblAddress" runat="server" Text='<%# Bind("[Rating]") %>'></asp:Label>
                                        </ItemTemplate>
                                       
                                        <ItemStyle HorizontalAlign="left" Width="7%" />
                                    </asp:TemplateField>

                                             <asp:TemplateField HeaderText="Interacted Persion">
                                        <ItemTemplate>
                                            
                                            <asp:Label ID="lblAddress" runat="server" Text='<%# Bind("[Interacted Persion]") %>'></asp:Label>
                                        </ItemTemplate>
                                       
                                        <ItemStyle HorizontalAlign="left" Width="7%" />
                                    </asp:TemplateField>

                                            <asp:TemplateField HeaderText="Date">
                                        <ItemTemplate>
                                            
                                            <asp:Label ID="lblPermanentAddress" runat="server" Text='<%# Bind("Date") %>'></asp:Label>
                                        </ItemTemplate>
                                       
                                        <ItemStyle HorizontalAlign="left" Width="7%" />
                                    </asp:TemplateField>



                                         

                                        </Columns>
                                    </asp:GridView>
                                </div>
                                    </div>

                            </div>
                        </div>
                    </div>

                </div>
            </div>
        </div>
    </div>


    <div class="modal fade" id="popModalWar" tabindex="-1" role="alert" aria-labelledby="smallModalLabel" aria-hidden="true" style="">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header" style="background-color:dodgerblue; color:white;">
                <h4 class="modal-title" id="smallModalLabel">Edit / Delete Retailer Details</h4>
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">&times;</button>
            </div>
            <div class="modal-body">

                <div class="col-md-12">
                <p id="pbrowse1">

                    <input type="hidden" id="billId" value="0">
                    <input type="hidden" id="hmobileno" value="0">
                    <input type="hidden" id="hamount" value="0">
                    <b style="color: black">Name</b>&nbsp;&nbsp;&nbsp;&nbsp;<span id="spanEmail" style="color: black;"></span>
                    <input type="text" id="wrr_Comments_id" placeholder="Name" name="Comments" data-msg-required="Please enter name." class="form-control"><br />
                    <b style="color: black">Action:</b>&nbsp;
                            <asp:DropDownList ID="ddlStatus" runat="server"
                                class="form-control mb-0">
                                 <asp:ListItem Value="0">--Select--</asp:ListItem>
                                <asp:ListItem Value="1">Update</asp:ListItem>
                                <asp:ListItem Value="2">Delete</asp:ListItem>

                            </asp:DropDownList>

                    <br />
                    

                </p>
               
                    </div>
                <div class="clearfix"></div>
                 <div class="col-md-12">
                    
                     <p style="text-align:center;">   <input type="button" name="name22" class="btn btn-default" style="background-color:dodgerblue;color:white;" id="btnbrowsesave" value="Submit" data-dismiss="modal" onclick="save();" /></p>
                    
                    
                </div>
            </div>
            
            <%--<div class="modal-footer">

                <button type="button" class="btn btn-light" style="background-color:linear-gradient(180deg, rgb(73 141 247) 0%, rgb(167 105 224) 100%);;" data-dismiss="modal">Close</button>
            </div>--%>
        </div>
    </div>
</div>

</asp:Content>

