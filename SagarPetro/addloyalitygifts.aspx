<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true"
    CodeFile="addloyalitygifts.aspx.cs" Inherits="SagarPetro_addloyalitygifts" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    </asp:Content>
    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">

        <script>
            function Activeinactive(userId) {
                var companyId = '<%= Session["CompanyId"].ToString() %>';
                $.ajax({
                    type: "POST",
                    contentType: false,
                    processData: false,
                    url: '../Info/SagarHandler.ashx?method=ActiveInactiveUsergift&UserRoleId=' + userId + '&CompanyId=' + companyId,
                    success: function (data) {
                        if (data == "Status successfully update") {
                            Swal.fire('Success', data, 'success').then(() => {
                                location.reload();
                            });
                        }
                        else {
                            showAlert('Error', data, 'error');
                        }
                    }
                });

            }
            function downloaduserData(ReportName) {
                let table = document.getElementById('ctl00_ContentPlaceHolder1_grd1');
                let rows = table.rows;
                let csvContent = '';

                for (let i = 0; i < rows.length; i++) {
                    let row = rows[i];
                    let cols = row.cells;
                    let rowData = [];

                    // Only iterate through columns excluding the last three
                    for (let j = 0; j < cols.length - 1; j++) {
                        rowData.push(cols[j].innerText);
                    }

                    csvContent += rowData.join(',') + '\n';
                }

                let blob = new Blob([csvContent], { type: 'text/csv' });
                let link = document.createElement('a');
                link.href = URL.createObjectURL(blob);
                link.download = ReportName + '.csv';
                link.click();
            }
        </script>

        <div class="home-section">
            <div class="app-breadcrumb">
                <div class="row">
                    <div class="col">
                        <h5>Add Loyalty Gift</h5>
                    </div>
                    <div class="col">
                        <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                            <ol class="breadcrumb">
                                <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">Dashboard</a></li>
                                <li class="breadcrumb-item active" aria-current="page">New Gift</li>
                            </ol>
                        </nav>
                    </div>
                </div>
            </div>
            <div class="user-role-card">
                <div class="card">
                    <div class="card-body">
                        <div class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-3" id="regdiv">
                        <div class="col">
                            <label for="txtgiftname" class="form-label">Gift Name<span>*</span></label>
                            <asp:TextBox runat="server" ID="txtgiftname" CssClass="form-control"
                                pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" MaxLength="100" required></asp:TextBox>

                            <div class="invalid-feedback">Enter valid gift name</div>
                        </div>
                        <div class="col">
                            <label for="txtgiftvalue" class="form-label">Gift Value<span>*</span></label>
                            <asp:TextBox runat="server" ID="txtgiftvalue" CssClass="form-control" type="number"
                                oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength); if (this.value.length !== 10) this.setCustomValidity('Phone number must be exactly 10 digits.'); else this.setCustomValidity('');"
                                MaxLength="10" required></asp:TextBox>

                            <div class="invalid-feedback">Enter valid value</div>
                        </div>
                        <div class="col">
                            <label for="txtgiftdesc" class="form-label">Gift Description<span>*</span></label>
                            <asp:TextBox runat="server" ID="txtgiftdesc" CssClass="form-control"
                                pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" MaxLength="100" required></asp:TextBox>

                            <div class="invalid-feedback">Enter valid gift description</div>
                        </div>
                            <asp:HiddenField ID="hdngiftid" runat="server" />
                        <div class="col" id="imgdiv" runat="server">
                            <label for="FileUpload1" class="form-label">Upload Image<span>*</span></label>
                            <asp:FileUpload runat="server" ID="FileUpload1" CssClass="form-control"
                                required="required" />
                            <div class="invalid-feedback">Please upload an image file</div>
                        </div>
                        <div class="col">

                        </div>

                        <div class="col ms-auto text-end">
                          
                            <label for="" class="form-label text-white">*</label><br>
                               <button runat="server" onclick="downloaduserData('Loyalty_Gift')"
                                class="btn btn-primary">
                                <i class="fas fa-file-csv"></i>
                            </button>
                            <asp:Button runat="server" ID="btncancel" CssClass="btn btn-light px-3 border"
                                Text="Cancel" OnClick="btncancel_Click" />
                            <asp:Button runat="server" ID="btnSubmit" Text="Save" CssClass="btn btn-primary px-3"
                                OnClick="btnSubmit_Click"  OnClientClick="$('#myspindiv').show(); $('#regdiv').hide();" />
                        </div>
                    </div>
                     <div id="myspindiv" class="text-center" style="display: none">
                        <h5>Loading please wait</h5>
                        <img src="../SagarPetro/assets/img/wait2.gif" height="50" />
                    </div>
                        <div class="app-table mt-3">
                            <div class="table-responsive">
                                <asp:GridView ID="grd1" OnRowDataBound="grd1_RowDataBound" runat="server"
                                    CssClass="table table-striped table-bordered" EmptyDataText="Record Not Found"
                                    AllowPaging="false" AutoGenerateColumns="false" OnRowCommand="grd1_RowCommand">
                                    <Columns>
                                        <asp:BoundField DataField="Gift_name" HeaderText="Gift Name" />
                                        <asp:BoundField DataField="Gift_value" HeaderText="Gift Value" />
                                        <asp:BoundField DataField="Gift_desc" HeaderText="Gift Description" />
                                        <asp:TemplateField HeaderText="Gift Image">
                                            <ItemTemplate>
                                                <asp:Image runat="server" ImageUrl='<%# Eval("Gift_image", "~/{0}") %>' Width="100" Height="100"
                                                    AlternateText="Gift Image" />
                                            </ItemTemplate>
                                            <HeaderStyle />
                                            <ItemStyle />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Status">
                                            <ItemTemplate>
                                                <%# Eval("status").ToString()=="1" ? "Active" : "Inactive" %>
                                            </ItemTemplate>
                                            <HeaderStyle />
                                            <ItemStyle />
                                        </asp:TemplateField>
                                        <asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:Literal ID="ltToggleAction" runat="server"></asp:Literal>
                                                <%-- <asp:Button runat="server" CommandName="UpdateStatus"
                                                    CommandArgument='<%# Eval("gift_id") %>' Text="Update Status"
                                                    CssClass="btn btn-warning btn-sm" />--%>
                                                <asp:Button runat="server" CommandName="DeleteGift"
                                                    CommandArgument='<%# Eval("gift_id") %>' Text="Delete"
                                                    CssClass="btn btn-danger btn-sm"
                                                    OnClientClick="return confirm('Are you sure you want to delete this gift?');" />
                                                <asp:Button runat="server" CommandName="editgift" CommandArgument='<%# Eval("gift_id") %>' Text="Edit" CssClass="btn btn-info btn-sm" />
                                            </ItemTemplate>
                                            <HeaderStyle />
                                            <ItemStyle />
                                        </asp:TemplateField>
                                    </Columns>
                                </asp:GridView>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </asp:Content>