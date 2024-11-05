<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="registeruser.aspx.cs" Inherits="SagarPetro_registeruser" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    
   

    <div class="home-section">
        <div class="app-breadcrumb">
            <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1 g-3">
                <div class="col">
                    <h5>Add new user</h5>
                </div>
                <div class="col">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="../SagarPetro/dashboard.aspx">dashboard</a></li>
                            <li class="breadcrumb-item"><a href="../SagarPetro/newuser.aspx">Our user</a></li>
                            <li class="breadcrumb-item active" aria-current="page">add new user</li>
                        </ol>
                    </nav>
                </div>
            </div>
        </div>
        <div class="user-role-card">
            <div class="card">
                <div class="card-body">
                    <label for="ddlroletype" class="form-label">Select User<span>*</span></label>
                    <asp:DropDownList ID="ddlroletype" AutoPostBack="true" OnSelectedIndexChanged="ddlroletype_SelectedIndexChanged" CssClass="form-select" runat="server"></asp:DropDownList>
                    <div id="Registrationdiv" runat="server">
                        <div id="backendadminregistration" runat="server" visible="false">
                            <div class="my-4">
                                <div class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-3">
                                    <div class="col-xxl-12 col-xl-12 col-lg-12 col-md-12 col-12">
                                        <div class="card-title">
                                            <hr>
                                            <span>User Details</span>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <label for="txtbaname" class="form-label">user name<span>*</span></label>
                                        <asp:TextBox runat="server" ID="txtbaname" CssClass="form-control"
                                            pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" MaxLength="50" required></asp:TextBox>
                                        <div class="invalid-feedback">Enter valid user name</div>
                                    </div>
                                    <div class="col">
                                        <label for="txtbaemail" class="form-label">user email<span>*</span></label>
                                        <asp:TextBox runat="server" onkeypress="return restrictEnterKey(event)" ID="txtbaemail" CssClass="form-control" TextMode="Email" MaxLength="30"
                                            required></asp:TextBox>
                                        <div class="invalid-feedback">Enter valid email id</div>
                                    </div>
                                    <div class="col">
                                        <label for="txtbamobile" class="form-label">user mobile<span>*</span></label>
                                        <asp:TextBox runat="server" ID="txtbamobile" CssClass="form-control" type="number" onkeypress="return restrictEnterKey(event)"
                                            oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength); if (this.value.length !== 10) this.setCustomValidity('Phone number must be exactly 10 digits.'); else this.setCustomValidity('');"
                                            MaxLength="10" required></asp:TextBox>
                                        <div class="invalid-feedback">Enter valid mobile number.</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="managerregform" runat="server" visible="false">
                            <div class="my-4">
                                <div class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-3">
                                    <div class="col-xxl-12 col-xl-12 col-lg-12 col-md-12 col-12">
                                        <div class="card-title">
                                            <hr>
                                            <span>User Details</span>
                                        </div>
                                    </div>
                                    <div class="col">
                                        <label for="username" class="form-label">user name<span>*</span></label>
                                        <asp:TextBox runat="server" ID="username" CssClass="form-control"
                                            pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" MaxLength="50" required></asp:TextBox>

                                        <div class="invalid-feedback">Enter valid user name</div>
                                    </div>
                                    <div class="col">

                                        <label for="userEmail" class="form-label">user email<span>*</span></label>
                                        <asp:TextBox runat="server" ID="userEmail" CssClass="form-control" TextMode="Email" MaxLength="30"
                                            required></asp:TextBox>

                                        <div class="invalid-feedback">Enter valid email id</div>
                                    </div>
                                    <div class="col">
                                        <label for="userMobile" class="form-label">user mobile<span>*</span></label>
                                        <asp:TextBox runat="server" ID="userMobile" CssClass="form-control" type="number"
                                            oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength); if (this.value.length !== 10) this.setCustomValidity('Phone number must be exactly 10 digits.'); else this.setCustomValidity('');"
                                            MaxLength="10" required></asp:TextBox>

                                        <div class="invalid-feedback">Enter valid mobile number.</div>
                                    </div>
                                    <div class="col">
                                        <label for="m_txtstate" class="form-label">State<span>*</span></label>
                                        <%--<asp:TextBox runat="server" ID="m_txtstate" CssClass="form-control"
                                        pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" MaxLength="50" required></asp:TextBox>--%>
                                        <asp:DropDownList ID="m_ddlstate" runat="server" CssClass="form-control" AutoPostBack="true" OnSelectedIndexChanged="m_ddlstate_SelectedIndexChanged"></asp:DropDownList>
                                        <div class="invalid-feedback">Enter valid state name.</div>
                                    </div>
                                    <div class="col">
                                        <label for="m_txtdistrict" class="form-label">District<span>*</span></label>
                                        <%--  <asp:TextBox runat="server" ID="m_txtdistrict" CssClass="form-control"
                                        pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" MaxLength="50" required></asp:TextBox>--%>
                                        <asp:ListBox ID="ddldistrict" SelectionMode="Multiple" runat="server" CssClass="form-control"></asp:ListBox>
                                        <div class="invalid-feedback">Enter valid district name.</div>
                                    </div>
                                    <div class="col">
                                        <label for="m_txtdesignation" class="form-label">Designation<span>*</span></label>
                                        <asp:TextBox runat="server" ReadOnly="true" ID="m_txtdesignation" CssClass="form-control"
                                            pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" MaxLength="50" required></asp:TextBox>

                                        <div class="invalid-feedback">Enter valid Designation.</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="headmachanicform" runat="server" visible="false">
                            <div class="my-4">
                                <div class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-3">
                                    <div class="col">
                                        <label for="hm_txtname" class="form-label">user name<span>*</span></label>
                                        <asp:TextBox runat="server" ID="hm_txtname" CssClass="form-control"
                                            pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" MaxLength="50" required></asp:TextBox>

                                        <div class="invalid-feedback">Enter valid user name</div>
                                    </div>
                                    <div class="col" style="display: none">

                                        <label for="hm_Emailid" class="form-label">user email<span></span></label>
                                        <asp:TextBox runat="server" ID="hm_Emailid" CssClass="form-control" TextMode="Email" MaxLength="30"
                                            required></asp:TextBox>

                                        <div class="invalid-feedback">Enter valid email id</div>
                                    </div>
                                    <div class="col">
                                        <label for="hm_mobileno" class="form-label">user mobile<span>*</span></label>
                                        <asp:TextBox runat="server" ID="hm_mobileno" CssClass="form-control" type="number"
                                            oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength); if (this.value.length !== 10) this.setCustomValidity('Phone number must be exactly 10 digits.'); else this.setCustomValidity('');"
                                            MaxLength="10" required></asp:TextBox>

                                        <div class="invalid-feedback">Enter valid mobile number.</div>
                                    </div>
                                    <div class="col">
                                        <label for="hm_address" class="form-label">address<span>*</span></label>
                                        <asp:TextBox runat="server" ID="hm_address" CssClass="form-control" autocomplete="off"
                                            pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" MaxLength="50" required></asp:TextBox>

                                        <div class="invalid-feedback">Enter valid address</div>
                                    </div>
                                    <div class="col">
                                        <label for="hm_state" class="form-label">state<span>*</span></label>
                                        <%-- <asp:TextBox runat="server" ID="hm_state" CssClass="form-control"
                                        pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" MaxLength="50" required></asp:TextBox>--%>
                                        <asp:DropDownList ID="hm_ddlstate" AutoPostBack="true" OnSelectedIndexChanged="hm_ddlstate_SelectedIndexChanged" runat="server" CssClass="form-control"></asp:DropDownList>

                                        <div class="invalid-feedback">Enter valid state</div>
                                    </div>
                                    <div class="col">
                                        <label for="hm_district" class="form-label">district<span>*</span></label>
                                        <%-- <asp:TextBox runat="server" ID="hm_district" CssClass="form-control"
                                        pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" MaxLength="50" required></asp:TextBox>--%>
                                        <asp:DropDownList ID="hm_ddldistrict" runat="server" AutoPostBack="true" OnSelectedIndexChanged="hm_ddldistrict_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>
                                        <div class="invalid-feedback">Enter valid address</div>
                                    </div>
                                    <div class="col">
                                        <label for="hm_city" class="form-label">city<span>*</span></label>
                                        <%--<asp:TextBox runat="server" ID="hm_city" CssClass="form-control"
                                        pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" MaxLength="50" required></asp:TextBox>--%>
                                        <asp:DropDownList ID="ddlcity" runat="server" CssClass="form-control"></asp:DropDownList>

                                        <div class="invalid-feedback">Enter valid city</div>
                                    </div>

                                    <div class="col">
                                        <label for="hm_pincode" class="form-label">pin code<span>*</span></label>
                                        <asp:TextBox runat="server" ID="hm_pincode" CssClass="form-control"
                                            type="number"
                                            oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength); if (this.value.length !== 6) this.setCustomValidity('Phone number must be exactly 6 digits.'); else this.setCustomValidity('');"
                                            MaxLength="6" required></asp:TextBox>

                                        <div class="invalid-feedback">Enter valid pin code</div>
                                    </div>
                                    <div class="col">
                                        <label for="hm_pincode" class="form-label">Mechanic type<span>*</span></label>
                                        <asp:DropDownList ID="hm_ddlmachnictype" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <div class="invalid-feedback">Please Select Mechanic</div>
                                    </div>
                                  
                                      <div class="col">
                                           <label for="hm_dob" class="form-label">Date of Birth<span>*</span></label>
                                        <asp:TextBox ID="hm_dob" runat="server" autocomplete="off" placeholder="DD-MM-YYYY" CssClass="form-control"></asp:TextBox>
                                           <%--<asp:ImageButton runat="server" ID="imgCalendar" ImageUrl="~/Content/images/calender.png" AlternateText="Select Date" CssClass="calendar-button" />--%>
                                        <cc1:CalendarExtender runat="server" ID="txttodate_ce" Format="yyyy-MM-dd" Animated="False" PopupButtonID="imgCalendar" TargetControlID="hm_dob"> </cc1:CalendarExtender>
                                    </div>
                                    <div class="col">
                                        <label for="gender" class="form-label">Gender<span>*</span></label>
                                        <div>
                                            <asp:RadioButton ID="genderMale" runat="server" GroupName="gender" Text="Male" />
                                            <asp:RadioButton ID="genderFemale" runat="server" GroupName="gender" Text="Female" />
                                            <asp:RadioButton ID="genderOther" runat="server" GroupName="gender" Text="Other" />
                                        </div>
                                        <div class="invalid-feedback">Select your gender</div>
                                    </div>
                                    <div class="col">
                                        <label for="maritalstatus" class="form-label">Marital status<span>*</span></label>
                                        <div>
                                            <asp:RadioButton ID="rblmarried" runat="server" GroupName="maritalstatus" Text="Married" />
                                            <asp:RadioButton ID="rblunmarried" runat="server" GroupName="maritalstatus" Text="UnMaaried" />
                                        </div>
                                        <div class="invalid-feedback">Select your Marital status</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div id="assistantmachanic" runat="server" visible="false">
                            <div class="my-4">
                                <div class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-3">
                                    <div class="col">
                                        <label for="am_name" class="form-label">user name<span>*</span></label>
                                        <asp:TextBox runat="server" ID="am_name" CssClass="form-control"
                                            pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" MaxLength="50" required></asp:TextBox>

                                        <div class="invalid-feedback">Enter valid user name</div>
                                    </div>
                                    <div class="col" style="display: none">
                                        <label for="am_email" class="form-label">user email<span>*</span></label>
                                        <asp:TextBox runat="server" ID="am_email" CssClass="form-control" TextMode="Email" MaxLength="30"
                                            required></asp:TextBox>

                                        <div class="invalid-feedback">Enter valid email id</div>
                                    </div>
                                    <div class="col">
                                        <label for="am_mobileno" class="form-label">user mobile<span>*</span></label>
                                        <asp:TextBox runat="server" ID="am_mobileno" CssClass="form-control" type="number"
                                            oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength); if (this.value.length !== 10) this.setCustomValidity('Phone number must be exactly 10 digits.'); else this.setCustomValidity('');"
                                            MaxLength="10" required></asp:TextBox>

                                        <div class="invalid-feedback">Enter valid mobile number.</div>
                                    </div>
                                    <div class="col">
                                        <label for="am_address" class="form-label">address<span>*</span></label>
                                        <asp:TextBox runat="server" ID="am_address" CssClass="form-control" autocomplete="off"
                                            pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" MaxLength="50" required></asp:TextBox>
                                        <div class="invalid-feedback">Enter valid address</div>
                                    </div>
                                    <div class="col">
                                        <label for="am_state" class="form-label">state<span>*</span></label>
                                        <%-- <asp:TextBox runat="server" ID="am_state" CssClass="form-control"
                                        pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" MaxLength="50" required></asp:TextBox>--%>
                                        <asp:DropDownList ID="am_ddlstate" runat="server" AutoPostBack="true" OnSelectedIndexChanged="am_ddlstate_SelectedIndexChanged" CssClass="form-control"></asp:DropDownList>
                                        <div class="invalid-feedback">Enter valid state</div>
                                    </div>
                                    <div class="col">
                                        <label for="am_district" class="form-label">district<span>*</span></label>
                                        <%-- <asp:TextBox runat="server" ID="am_district" CssClass="form-control"
                                        pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" MaxLength="50" required></asp:TextBox>--%>
                                        <asp:DropDownList ID="am_ddldistrict" AutoPostBack="true" OnSelectedIndexChanged="am_ddldistrict_SelectedIndexChanged" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <div class="invalid-feedback">Enter valid address</div>
                                    </div>
                                    <div class="col">
                                        <label for="am_city" class="form-label">city<span>*</span></label>
                                        <%-- <asp:TextBox runat="server" ID="am_city" CssClass="form-control"
                                        pattern="^[A-Za-z]+(?: [A-Za-z]+)*$" MaxLength="50" required></asp:TextBox>--%>
                                        <asp:DropDownList ID="am_ddlcity" runat="server" CssClass="form-control"></asp:DropDownList>

                                        <div class="invalid-feedback">Enter valid city</div>
                                    </div>

                                    <div class="col">
                                        <label for="am_pincode" class="form-label">pin code<span>*</span></label>
                                        <asp:TextBox runat="server" ID="am_pincode" CssClass="form-control"
                                            type="number"
                                            oninput="javascript: if (this.value.length > this.maxLength) this.value = this.value.slice(0, this.maxLength); if (this.value.length !== 6) this.setCustomValidity('Phone number must be exactly 6 digits.'); else this.setCustomValidity('');"
                                            MaxLength="6" required></asp:TextBox>

                                        <div class="invalid-feedback">Enter valid pin code</div>
                                    </div>
                                    <div class="col">
                                        <label for="am_machinctype" class="form-label">Mechanic type<span>*</span></label>
                                        <asp:DropDownList ID="am_machinctype" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <div class="invalid-feedback">Please Select Mechanic</div>
                                    </div>
                              
                                     <div class="col">
                                         <label for="txtDate" class="form-label">Date of Birth<span>*</span></label>
                                        <asp:TextBox ID="txtDate" autocomplete="off" runat="server" placeholder="DD-MM-YYYY" CssClass="form-control"></asp:TextBox>
                                          <%--<asp:ImageButton runat="server" ID="ImageButton1" ImageUrl="~/Content/images/calender.png" AlternateText="Select Date" CssClass="calendar-button" />--%>
                                         <cc1:CalendarExtender runat="server" ID="txtfromdate_ce" Format="yyyy-MM-dd" PopupButtonID="ImageButton1" TargetControlID="txtDate" ></cc1:CalendarExtender>
                                    </div>
                                    <div class="col">
                                        <label for="gender" class="form-label">Gender<span>*</span></label>
                                        <div>
                                            <asp:RadioButton ID="rbl_amgendormale" runat="server" GroupName="gender" Text="Male" />
                                            <asp:RadioButton ID="rbl_amgendorfemale" runat="server" GroupName="gender" Text="Female" />
                                            <asp:RadioButton ID="rbl_amgendorother" runat="server" GroupName="gender" Text="Other" />
                                        </div>
                                        <div class="invalid-feedback">Select your gender</div>
                                    </div>
                                    <div class="col">
                                        <label for="maritalstatus" class="form-label">Marital status<span>*</span></label>
                                        <div>
                                            <asp:RadioButton ID="am_rblmarried" runat="server" GroupName="maritalstatus" Text="Married" />
                                            <asp:RadioButton ID="am_rblunmarried" runat="server" GroupName="maritalstatus" Text="UnMaaried" />
                                        </div>
                                        <div class="invalid-feedback">Select your Marital status</div>
                                    </div>
                                    <div class="col">
                                        <label for="am_headmachanicname" class="form-label">Head Mechanic Name<span>*</span></label>
                                        <asp:DropDownList ID="am_headmachanicname" runat="server" CssClass="form-control"></asp:DropDownList>
                                        <div class="invalid-feedback">Please Select Head mechanic</div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="menudiv" runat="server">
                        <div class="col-xxl-12 col-xl-12 col-lg-12 col-md-12 col-12" id="headtext" runat="server">
                            <div class="card-title">
                                <hr />
                                <span>Select User control setting</span>
                            </div>
                        </div>
                        <div class="col-xxl-12 col-xl-12 col-lg-12 col-md-12 col-12" id="dovmenuselection" runat="server">
                            <div class="user-select-options">
                                <div
                                    class="row row-cols-xxl-1 row-cols-xl-1 row-cols-lg-1 row-cols-md-1 row-cols-1 g-3">
                                    <%--<div class="col">
                                        <h6>CodeCheck</h6>
                                        <asp:CheckBoxList runat="server" ID="Chkcodecheck" />
                                    </div>--%>
                                    <div class="col">
                                        <h6>DashBoard</h6>
                                        <asp:CheckBoxList runat="server" ID="Chkdashboard" />
                                    </div>
                                    <%-- <div class="col">
                                        <h6>Company Profile</h6>
                                        <asp:CheckBoxList runat="server" ID="ChkCompprofile" />
                                    </div>--%>
                                    <div class="col">
                                        <h6>Users</h6>
                                        <asp:CheckBoxList runat="server" ID="ChkUsers" />
                                    </div>

                                    <div class="col">
                                        <h6>Product</h6>
                                        <asp:CheckBoxList runat="server" ID="ChkProduct" />
                                    </div>
                                    <div class="col">
                                        <h6>Services</h6>
                                        <asp:CheckBoxList runat="server" ID="ChkService" />
                                    </div>

                                    <div class="col">
                                        <h6>Lable</h6>
                                        <asp:CheckBoxList runat="server" ID="ChKLabel" />
                                    </div>
                                    <div class="col">
                                        <h6>Scrap</h6>
                                        <asp:CheckBoxList runat="server" ID="ChkScrap" />
                                    </div>
                                    <div class="col-xxl-12 col-xl-12 col-lg-12 col-md-12">
                                        <h6>Reports</h6>
                                        <asp:CheckBoxList runat="server" ID="ChkReport" />
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="col ms-auto text-end">
                            <a href="../SagarPetro/newuser.aspx" class="btn btn-light px-3 border">Cancel</a>
                            <asp:Button runat="server" ID="btnSubmit" Text="Send Invite" CssClass="btn btn-primary px-3"
                                OnClick="btnSubmit_Click" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <%-- <link href="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/css/select2.min.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/select2/4.0.13/js/select2.min.js"></script>
    <script>
        $(document).ready(function () {
            $('#<%= am_ddldistrict.ClientID %>').select2();
        });
    </script>--%>
</asp:Content>

