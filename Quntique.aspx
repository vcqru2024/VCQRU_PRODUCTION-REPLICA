<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Quntique.aspx.cs" Inherits="Quntique" %>

<%@ Import Namespace="System.Data" %>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Registration Form</title>
    <!-- css -->
    <link rel="stylesheet" href="quantique/assets/css/css.css" />
    <link rel="stylesheet" href="quantique/assets/css/responsive.css" />
    <link rel="stylesheet" href="quantique/assets/css/style.css" />
    <!-- css-end -->
    <!-- font-family -->
    <link rel="preconnect" href="https://fonts.googleapis.com" />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin />
    <link href="https://fonts.googleapis.com/css2?family=Jost:ital,wght@0,100..900;1,100..900&display=swap"
        rel="stylesheet" />
    <!-- font-family-end -->
    <!-- Boxicons CSS -->
    <link href='https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css' rel='stylesheet' />
    <!-- Boxicons CSS-end -->
    <%-- Datatable Css --%>
    <link rel="stylesheet" href="https://cdn.datatables.net/1.11.5/css/dataTables.bootstrap5.min.css" />
    <link rel="stylesheet" href="https://cdn.datatables.net/buttons/2.2.9/css/buttons.bootstrap5.min.css" />
    <%-- Datatable Css --%>
    <!-- jQuery -->
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

    <script type="text/javascript" src="https://cdn.datatables.net/1.11.4/js/jquery.dataTables.min.js"></script>
    <script src="https://cdn.datatables.net/1.11.5/js/dataTables.bootstrap5.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/2.2.2/js/dataTables.buttons.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jszip/3.1.3/jszip.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/pdfmake.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/pdfmake/0.1.53/vfs_fonts.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.html5.min.js"></script>
    <script type="text/javascript" src="https://cdn.datatables.net/buttons/2.2.2/js/buttons.print.min.js"></script>
    <!--sweet alert-->
    <!-- Add this to the head section of your HTML file -->
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
    <script>
        function showAlert(title, text, icon) {
            Swal.fire({
                title: title,
                text: text,
                icon: icon,
                confirmButtonText: 'OK'
            });
        }
    </script>
</head>
<body>
    <!-- navbar -->
    <div class="app-navbar">
        <div class="container">
            <nav class="navbar navbar-expand-lg">
                <div class="container-fluid">
                    <a class="navbar-brand" href="#">
                        <img src="quantique/assets/img/logo.png" alt="logo">
                    </a>
                    <button class="navbar-toggler bg-white shadow-none" type="button" data-bs-toggle="collapse"
                        data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent"
                        aria-expanded="false" aria-label="Toggle navigation">
                        <span class="navbar-toggler-icon"></span>
                    </button>
                    <div class="collapse navbar-collapse" id="navbarSupportedContent">
                        <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                            <li class="nav-item">
                                <a class="nav-link" href="tel:9967015695">
                                    <i class='bx bxs-phone-call'></i>
                                    +91 99670 15695
                                </a>
                            </li>
                            <li class="nav-item">
                                <a class="nav-link" href="mailto:contactus@quantique.ai">
                                    <i class='bx bxs-envelope'></i>
                                    contactus@quantique.ai
                                </a>
                            </li>
                            <li class="nav-item">
                                <i class='bx bx-log-out-circle'></i>
                            </li>
                        </ul>
                    </div>
                </div>
            </nav>
        </div>
    </div>
    <!-- app-navbar-end -->
    <!-- form -->
    <section class="user-form">
        <div class="container">
            <div class="web-heading">
                <h1>Dealer Registration Form</h1>
            </div>
            <div class="card">
                <div class="card-body">
                    <form action="" class="" runat="server">
                        <div class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-3">
                            <div class="col-xxl-6 col-xl-6 col-lg-6 col-md-6 col-6">
                                <h5 class="card-title text-white">Basic Details</h5>
                            </div>
                            <div class="col-xxl-6 col-xl-6 col-lg-6 col-md-6 col-6 text-end">
                                <asp:Button ID="Button2" runat="server" Text="Logout" CssClass="btn bg-danger btn-sm" OnClick="btnLogout_Click" />
                            </div>

                            <!-- Add radio buttons here -->
                            <div class="col-xxl-12 col-xl-12 col-lg-12 col-md-12 col-12 text-white">
                                <label class="form-label">Site Type<span>*</span></label><br />
                                <asp:RadioButton ID="radioMicrosite" GroupName="siteType" Text="Microsite" runat="server" OnClientClick="ToggleSiteType()" />
                                <asp:RadioButton ID="radioWebsite" GroupName="siteType" Text="Website" runat="server" OnClientClick="ToggleSiteType()" />
                            </div>

                            <!-- Basic Details Section -->
                            <div class="col">
                                <label for="text1" class="form-label">Name<span>*</span></label>
                                <asp:TextBox ID="text1" runat="server" CssClass="form-control form-control-lg" MaxLength="50" onkeypress="return validateName(event)"></asp:TextBox>
                                <span id="error_text1" class="text-danger"></span>
                            </div>
                            <div class="col">
                                <label for="text2" class="form-label">Email Address<span>*</span></label>
                                <asp:TextBox ID="text2" runat="server" CssClass="form-control form-control-lg" MaxLength="50"></asp:TextBox>
                                <span id="error_text2" class="text-danger"></span>
                            </div>
                            <div class="col">
                                <label for="text3" class="form-label">Mobile<span>*</span></label>
                                <asp:TextBox ID="text3" runat="server" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" TextMode="Phone" CssClass="form-control form-control-lg" MaxLength="13"></asp:TextBox>
                                <span id="error_text3" class="text-danger"></span>
                            </div>
                            <div class="col">
                                <label for="textAddress1" class="form-label">Address 1<span>*</span></label>
                                <asp:TextBox ID="textAddress1" runat="server" CssClass="form-control form-control-lg"></asp:TextBox>
                                <span id="error_textAddress1" class="text-danger"></span>
                            </div>
                            <div class="col">
                                <label for="textPinCode" class="form-label">Pin Code<span>*</span></label>
                                <asp:TextBox ID="textPinCode" runat="server" CssClass="form-control form-control-lg" TextMode="SingleLine" onkeyup="validatePin()" minlength="6" MaxLength="6"></asp:TextBox>
                                <span id="error_textPinCode" class="text-danger"></span>
                            </div>
                            <div class="col">
                                <label for="text1" class="form-label">City<span>*</span></label>
                                <asp:TextBox ID="dropdownCity" runat="server" CssClass="form-control form-control-lg" MaxLength="50" onkeypress="return validateCity(event)"></asp:TextBox>
                                <span id="error_dropdownCity" class="text-danger"></span>
                            </div>
                            <div class="col">
                                <label for="textstate" class="form-label">State<span>*</span></label>
                                <asp:TextBox ID="textstate" runat="server" CssClass="form-control form-control-lg" MaxLength="50" onkeypress="return validateState(event)"></asp:TextBox>
                                <span id="error_textstate" class="text-danger"></span>
                            </div>
                            <%--<div class="col">
                                <label for="dropdownCity" class="form-label">City<span>*</span></label>
                                <asp:DropDownList ID="dropdownCity" runat="server" CssClass="form-select form-select-lg">
                                    <asp:ListItem Text="-- Select City --" Value="" />
                                    <asp:ListItem Text="Mumbai" Value="Mumbai" />
                                    <asp:ListItem Text="Delhi" Value="Delhi" />
                                    <asp:ListItem Text="Bangalore" Value="Bangalore" />
                                    <asp:ListItem Text="Kolkata" Value="Kolkata" />
                                    <asp:ListItem Text="Chennai" Value="Chennai" />
                                    <asp:ListItem Text="Hyderabad" Value="Hyderabad" />
                                    <asp:ListItem Text="Ahmedabad" Value="Ahmedabad" />
                                    <asp:ListItem Text="Pune" Value="Pune" />
                                    <asp:ListItem Text="Surat" Value="Surat" />
                                    <asp:ListItem Text="Jaipur" Value="Jaipur" />
                                </asp:DropDownList>
                                <span id="error_dropdownCity" class="text-danger"></span>
                            </div>--%>
                            <div class="col-xxl-12 col-xl-12 col-lg-12 col-md-12 col-12">
                                <!-- Microsite Section -->
                                <div id="micrositeSection" style="display: none;">
                                    <h5 class="card-title text-white">Product and Service Details</h5>
                                    <div class="row mb-3">
                                        <div class="col">
                                            <label for="txtProductName" class="form-label">Product name<span>*</span></label>
                                            <asp:TextBox ID="txtProductName" runat="server" CssClass="form-control"></asp:TextBox>
                                            <span id="error_txtProductName" class="text-danger"></span>
                                        </div>
                                        <div class="col">
                                            <label for="txtProductUrl" class="form-label">Product Url<span>*</span></label>
                                            <asp:TextBox ID="txtProductUrl" TextMode="Url" runat="server" CssClass="form-control"></asp:TextBox>
                                            <span id="error_txtProductUrl" class="text-danger"></span>
                                        </div>
                                    </div>
                                    <div class="row g-3 mb-3">
                                        <div class="col">
                                            <label for="txtServiceName" class="form-label">Service name<span>*</span></label>
                                            <asp:TextBox ID="txtServiceName" runat="server" CssClass="form-control"></asp:TextBox>
                                            <span id="error_txtServiceName" class="text-danger"></span>
                                        </div>
                                        <div class="col">
                                            <label for="txtServiceUrl" class="form-label">Service Url<span>*</span></label>
                                            <asp:TextBox ID="txtServiceUrl" TextMode="Url" runat="server" CssClass="form-control"></asp:TextBox>
                                            <span id="error_txtServiceUrl" class="text-danger"></span>
                                        </div>
                                    </div>
                                </div>
                                <!-- Website Section -->
                                <div id="websiteSection" style="display: none;">
                                    <h5 class="card-title text-white">Website URL</h5>
                                    <div class="col">
                                        <label for="txtWebsiteUrl" class="form-label">Website Url<span>*</span></label>
                                        <asp:TextBox ID="txtWebsiteUrl" TextMode="Url" runat="server" CssClass="form-control"></asp:TextBox>
                                        <span id="error_txtWebsiteUrl" class="text-danger"></span>
                                    </div>
                                </div>
                            </div>

                            <div class="col">
                                <asp:Button ID="Button1" class="btn submitData" ValidationGroup="basicDetails" OnClientClick="return validateForm();" runat="server" Text="Save" OnClick="SaveData" />
                                <asp:Button ID="Button3" class="btn bg-secondary text-white" runat="server" Text="Reset" OnClientClick="resetForm();" />
                                <script>

                                    function resetForm() {
                                        // Clear all input fields
                                        $('#text1, #text2, #text3, #textAddress1, #textPinCode, #dropdownCity, #txtProductName, #txtProductUrl, #txtServiceName, #txtServiceUrl, #txtWebsiteUrl').val('');
                                        // Uncheck radio buttons
                                        $('#radioMicrosite, #radioWebsite').prop('checked', false);
                                        // Hide microsite and website sections
                                        $('#micrositeSection, #websiteSection').hide();
                                        // Clear error messages
                                        $('.text-danger').text('');
                                        return false; // Prevent default form submission
                                    }
                                    document.addEventListener("DOMContentLoaded", function () {
                                        // Wait for the DOM to fully load before registering event handlers
                                        var radioMicrosite = document.getElementById('radioMicrosite');
                                        var radioWebsite = document.getElementById('radioWebsite');

                                        radioMicrosite.addEventListener('click', ToggleSiteType);
                                        radioWebsite.addEventListener('click', ToggleSiteType);
                                    });
                                    function validateName(event) {
                                        var charCode = event.charCode;
                                        var input = event.target;
                                        var currentValue = input.value;

                                        // Allow alphabets (A-Z, a-z) and space (charCode 32)
                                        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || (charCode == 32 && currentValue.length > 0 && !currentValue.endsWith(' '))) {
                                            return true;
                                            $("#error_text1").text("");
                                        }
                                        else {
                                            $("#error_text1").text("Invalid character."); // Display error message for invalid character
                                            return false;
                                        }
                                    }
                                    function validateCity(event) {
                                        var charCode = event.charCode;
                                        var input = event.target;
                                        var currentValue = input.value;

                                        // Allow alphabets (A-Z, a-z) and space (charCode 32)
                                        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || (charCode == 32 && currentValue.length > 0 && !currentValue.endsWith(' '))) {
                                            return true;
                                            $("#error_dropdownCity").text("");
                                        }
                                        else {
                                            $("#error_dropdownCity").text("Invalid character."); // Display error message for invalid character
                                            return false;
                                        }
                                    }
                                    function validateState(event) {
                                        var charCode = event.charCode;
                                        var input = event.target;
                                        var currentValue = input.value;

                                        // Allow alphabets (A-Z, a-z) and space (charCode 32)
                                        if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || (charCode == 32 && currentValue.length > 0 && !currentValue.endsWith(' '))) {
                                            return true;
                                            $("#error_textstate").text("");
                                        }
                                        else {
                                            $("#error_textstate").text("Invalid character."); // Display error message for invalid character
                                            return false;
                                        }
                                    }
                                    function validatePin() {
                                        var pinInput = document.getElementById("textPinCode");
                                        var pinError = document.getElementById("error_textPinCode");
                                        var pin = pinInput.value;

                                        // Check if the pin is numeric
                                        if (!/^\d+$/.test(pin)) {
                                            pinError.textContent = "Please enter a numeric value for Pin Code.";
                                            pinInput.value = pin.replace(/[^0-9]/g, ''); // Remove non-numeric characters
                                        } else {
                                            pinError.textContent = "";
                                        }

                                        // Trigger getaddress function if the pin length is 6 and valid
                                        if (pin.length === 6) {
                                            getaddress();
                                        }
                                    }
                                    function getaddress() {
                                        let pin = document.getElementById("textPinCode").value;
                                        if (pin.length == 6) {
                                            $.getJSON(
                                                "https://api.postalpincode.in/pincode/" + pin,
                                                function (data) {
                                                    createHTML(data);
                                                }
                                            ).fail(function () {
                                                // In case of an error, allow manual entry
                                                enableManualEntry();
                                            });

                                            function createHTML(data) {
                                                if (data[0].Status == "Success") {
                                                    let city = data[0].PostOffice[0]["District"];
                                                    let state = data[0].PostOffice[0]["State"];
                                                    debugger;
                                                    $("#dropdownCity").val(city);
                                                    $("#textstate").val(state);
                                                    /* $("#btnsubmit").attr("disabled", false);*/
                                                    $("#error_textPinCode").text("");
                                                    $("#error_dropdownCity").text("");
                                                    $("#error_textstate").text("");
                                                    // Clear any previous error message
                                                } else {
                                                    $("#error_textPinCode").text("Please enter a valid pin.");
                                                    /*$("#btnsubmit").attr("disabled", true);*/
                                                    enableManualEntry();
                                                }
                                            }

                                            function enableManualEntry() {
                                                $("#error_textPinCode").text("Unable to fetch data. Please enter the details manually.");
                                                $("#dropdownCity").val("").prop("disabled", false);
                                                $("#textstate").val("").prop("disabled", false);
                                                $("#btnsubmit").attr("disabled", false);
                                            }
                                        }
                                    }
                                    function ToggleSiteType() {
                                        console.log("ToggleSiteType function called");
                                        var radioMicrosite = document.getElementById('radioMicrosite');
                                        var micrositeSection = document.getElementById('micrositeSection');
                                        var websiteSection = document.getElementById('websiteSection');

                                        if (radioMicrosite.checked) {
                                            micrositeSection.style.display = 'block';
                                            websiteSection.style.display = 'none';
                                        } else {
                                            micrositeSection.style.display = 'none';
                                            websiteSection.style.display = 'block';
                                        }
                                    }
                                    function validateForm() {
                                        // Regular expressions for email, URL, name, mobile, address, and city validation
                                        var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                                        var urlPattern = /^(ftp|http|https):\/\/[^ "]+$/;
                                        var namePattern = /^[a-zA-Z][a-zA-Z\s]*[a-zA-Z]$/;
                                        var mobilePattern = /^[0-9]{10}$/;  // Example: 10 digit mobile number
                                        var addressPattern = /^[a-zA-Z0-9\s,'-]*$/;  // Example: Alphanumeric characters and some special chars
                                        var cityPattern = /^[a-zA-Z\s]*$/;  // Example: Only letters and spaces

                                        // Clear previous error messages
                                        document.getElementById('error_text1').innerText = '';
                                        document.getElementById('error_text2').innerText = '';
                                        document.getElementById('error_text3').innerText = '';
                                        document.getElementById('error_textAddress1').innerText = '';
                                        document.getElementById('error_dropdownCity').innerText = '';
                                        document.getElementById('error_textstate').innerText = '';
                                        document.getElementById('error_textPinCode').innerText = '';
                                        document.getElementById('error_txtProductName').innerText = '';
                                        document.getElementById('error_txtProductUrl').innerText = '';
                                        document.getElementById('error_txtServiceName').innerText = '';
                                        document.getElementById('error_txtServiceUrl').innerText = '';
                                        document.getElementById('error_txtWebsiteUrl').innerText = '';

                                        // Validate regular fields
                                        var name = document.getElementById('text1').value.trim();
                                        var email = document.getElementById('text2').value.trim();
                                        var mobile = document.getElementById('text3').value.trim();
                                        var address1 = document.getElementById('textAddress1').value.trim();
                                        var city = document.getElementById('dropdownCity').value.trim();
                                        var state = document.getElementById('textstate').value.trim();
                                        var pinCode = document.getElementById('textPinCode').value.trim();

                                        var isValid = true;

                                        if (name === '' || !namePattern.test(name)) {
                                            document.getElementById('error_text1').innerText = 'Please enter a valid name. Name should not contain special characters, numbers, leading or trailing spaces.';
                                            isValid = false;
                                        }
                                        if (email === '' || !emailPattern.test(email)) {
                                            document.getElementById('error_text2').innerText = 'Please enter a valid email address.';
                                            isValid = false;
                                        }
                                        if (mobile === '' || !mobilePattern.test(mobile)) {
                                            document.getElementById('error_text3').innerText = 'Please enter a valid mobile number. Mobile number should be 10 digits.';
                                            isValid = false;
                                        }
                                        if (address1 === '' || !addressPattern.test(address1)) {
                                            document.getElementById('error_textAddress1').innerText = 'Please enter a valid address. Address should not contain special characters except comma, hyphen and apostrophe.';
                                            isValid = false;
                                        }
                                        if (city === '') {
                                            document.getElementById('error_dropdownCity').innerText = 'Please select a city.';
                                            isValid = false;
                                        }
                                        if (state === '') {
                                            document.getElementById('error_textstate').innerText = 'Please Enter a state.';
                                            isValid = false;
                                        }

                                        if (pinCode === '') {
                                            document.getElementById('error_textPinCode').innerText = 'Please enter a pin code.';
                                            isValid = false;
                                        }
                                        if (pinCode.length < 6) {
                                            $("#error_textPinCode").text("Please Enter valid Pin Code");
                                            validate = false;
                                        }

                                        // Check if neither "Website" nor "Microsite" is selected
                                        var radioMicrosite = document.getElementById('radioMicrosite');
                                        var radioWebsite = document.getElementById('radioWebsite');

                                        if (!radioMicrosite.checked && !radioWebsite.checked) {
                                            showAlert('Oops!', 'Please select either "Website" or "Microsite".', 'warning');
                                            //alert('Please select either "Website" or "Microsite".');
                                            isValid = false;
                                        }
                                        if (radioMicrosite.checked) {
                                            // Validate microsite fields
                                            var productName = document.getElementById('txtProductName').value.trim();
                                            var productUrl = document.getElementById('txtProductUrl').value.trim();
                                            var serviceName = document.getElementById('txtServiceName').value.trim();
                                            var serviceUrl = document.getElementById('txtServiceUrl').value.trim();

                                            if (productName === '') {
                                                document.getElementById('error_txtProductName').innerText = 'Please enter product name for microsite.';
                                                isValid = false;
                                            }
                                            if (productUrl === '' || !urlPattern.test(productUrl)) {
                                                document.getElementById('error_txtProductUrl').innerText = 'Please enter a valid product URL for microsite.';
                                                isValid = false;
                                            }
                                            if (serviceName === '') {
                                                document.getElementById('error_txtServiceName').innerText = 'Please enter service name for microsite.';
                                                isValid = false;
                                            }
                                            if (serviceUrl === '' || !urlPattern.test(serviceUrl)) {
                                                document.getElementById('error_txtServiceUrl').innerText = 'Please enter a valid service URL for microsite.';
                                                isValid = false;
                                            }
                                        } else {
                                            // Validate website fields
                                            var websiteUrl = document.getElementById('txtWebsiteUrl').value.trim();
                                            if (websiteUrl === '' || !urlPattern.test(websiteUrl)) {
                                                document.getElementById('error_txtWebsiteUrl').innerText = 'Please enter a valid website URL.';
                                                isValid = false;
                                            }
                                        }

                                        return isValid;
                                    }

                                    // Hide error messages on input
                                    $(document).ready(function () {
                                        $('#text1, #text2, #text3, #textAddress1, #textPinCode, #dropdownCity, #txtProductName, #txtProductUrl, #txtServiceName, #txtServiceUrl, #txtWebsiteUrl,#editNamemodal,#editStatemodal,#editCitymodal,#textstate').on('input change', function () {
                                            var errorId = 'error_' + this.id;
                                            $('#' + errorId).text('');
                                        });
                                    });
                                </script>
                            </div>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </section>
    <!-- form-end -->
    <!-- app-navbar-end -->
    <!-- table -->
    <section class="view-data">
        <div class="container">
            <div class="text-center">
                <button runat="server" id="lblCount" class="btn btn-warning"></button>
            </div>
            <h5 class="text-white">Genrated QR Codes</h5>
            <div class="card">
                <div class="card-body">
                    <div class="app-table">
                        <table id='dataTable' class='table'>
                            <thead>
                                <tr>
                                    <th>Dealer Id</th>
                                    <th>Created Date</th>
                                    <th>Updated Date</th>
                                    <th>QR code</th>
                                    <th>Name</th>
                                    <th>Email</th>
                                    <th>Mobile No.</th>
                                    <th>Location</th>
                                    <th>Product</th>
                                    <th>Service</th>
                                    <th>Website URL</th>
                                    <th>Download</th>
                                    <th>Edit</th>
                                </tr>
                            </thead>
                            <tbody>
                                <%
                                    // Assuming you have a method in your code-behind to fetch dealer data from the database
                                    DataTable dealerData = GetDealerDataFromDatabase(); // You need to implement this method in your code-behind

                                    if (dealerData != null && dealerData.Rows.Count > 0)
                                    {
                                        foreach (DataRow row in dealerData.Rows)
                                        {
                                            Response.Write("<tr>");
                                            Response.Write("<td>" + row["DealerId"] + "</td>");
                                            Response.Write("<td>" + row["CreatedDate"] + "</td>");
                                            Response.Write("<td>" + row["UpdatedDate"] + "</td>");
                                            Response.Write("<td><img src='" + ResolveUrl("~/" + row["QRCodePath"].ToString()) + "' alt='QR Code' height='50' width='50'></td>");
                                            Response.Write("<td>" + row["Name"] + "</td>");
                                            Response.Write("<td>" + row["Email"] + "</td>");
                                            Response.Write("<td>" + row["Mobile"] + "</td>");
                                            Response.Write("<td>" + row["City"] + ", " + row["State"] + " " + row["PinCode"] + "</td>");

                                            if ((bool)row["IsMicrosite"])
                                            {
                                                Response.Write("<td>" + row["ProductName"] + "</td>");
                                                Response.Write("<td>" + row["ServiceName"] + "</td>");
                                                Response.Write("<td></td>"); // No website URL for microsite
                                            }
                                            else
                                            {
                                                Response.Write("<td></td>"); // No product info for website
                                                Response.Write("<td></td>"); // No service info for website
                                                Response.Write("<td>" + row["WebsiteUrl"] + "</td>");
                                            }

                                            // Add a column for Download QR Code
                                            Response.Write("<td><a href='" + ResolveUrl(row["QRCodePath"].ToString()) + "' download>Download QR Code</a></td>");
                                            // Add Edit button
                                            Response.Write("<td><button type='button' class='btn btn-primary editDealer' data-bs-toggle='modal' data-bs-target='#editModal' data-id='" + row["DealerId"] + "'>Edit</button></td>");
                                            Response.Write("</tr>");
                                        }
                                    }
                                    else
                                    {
                                        Response.Write("<tr><td colspan='11'>No data available</td></tr>");
                                    }
                                %>
                            </tbody>

                        </table>
                        <script>
                            $(document).ready(function () {
                                $('#dataTable').DataTable({
                                    dom: 'Blfrtip',
                                    buttons: [], // Remove the buttons configuration
                                    lengthMenu: [
                                        [10, 25, 50, -1],
                                        ['10   ', '25   ', '50   ', 'Show all']
                                    ],
                                    pageLength: 25,
                                    scrollY: 400, // Set the height for vertical scrolling (adjust as needed)
                                    scrollX: true, // Enable horizontal scrolling
                                    scrollCollapse: true, // Enable collapsing of the table when scrolling
                                    scroller: true // Enable the Scroller extension
                                });
                            });
                        </script>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <!-- footer -->
    <footer class="footer">
        <div class="container">
            <p>Copyright © 2024 QUANTIQUE METADATA PRIVATE LIMITED</p>
        </div>
    </footer>
    <!-- footer-end -->

    <script>
        if (window.history.replaceState) {
            window.history.replaceState(null, null, window.location.href);
        }
    </script>
    <!-- validation -->
    <%-- <script>

        // Example starter JavaScript for disabling form submissions if there are invalid fields
        (() => {
            'use strict'

            // Fetch all the forms we want to apply custom Bootstrap validation styles to
            const forms = document.querySelectorAll('.needs-validation')

            // Loop over them and prevent submission
            Array.from(forms).forEach(form => {
                form.addEventListener('submit', event => {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }

                    form.classList.add('was-validated')
                }, false)
            })
        })()
    </script>--%>
    <div>
        <asp:Image ID="qrCodeImageView" runat="server" Visible="false" />
    </div>
    <!-- Add Edit Modal -->

    <div class="modal fade" id="editModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
        <div class="modal-dialog modal-dialog-scrollable modal-dialog-centered">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title" id="editModalLabel">Edit Dealer Data</h5>
                    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                </div>
                <div class="modal-body">
                    <input type="hidden" id="editDealerId" />
                    <div class="mb-3">
                        <label for="editName" class="form-label">Name</label>
                        <input type="text" class="form-control" id="editNamemodal" onkeypress="return validateNamemodal(event)" />
                        <span id="error_editNamemodal" class="text-danger"></span>
                    </div>
                    <div class="mb-3">
                        <label for="editEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="editEmailmodal" />
                    </div>
                    <div class="mb-3">
                        <label for="editMobile" class="form-label">Mobile</label>
                        <input type="text" class="form-control" id="editMobilemodal" />
                    </div>
                    <div class="mb-3">
                        <label for="editAddress1" class="form-label">Address 1</label>
                        <input type="text" class="form-control" id="editAddress1modal" />
                    </div>
                    <div class="mb-3">
                        <label for="editPinCode" class="form-label">Pin Code</label>
                        <input type="text" class="form-control" id="editPinCodemodal" onkeyup="validatePinmodal()" />
                        <span id="error_textPinCodemodal" class="text-danger"></span>
                    </div>
                    <div class="mb-3">
                        <label for="editCity" class="form-label">City</label>
                        <input type="text" class="form-control" id="editCitymodal" onkeypress="return validateCitymodal(event)" />
                        <span id="error_editCitymodal" class="text-danger"></span>
                    </div>
                    <div class="mb-3">
                        <label for="editState" class="form-label">State</label>
                        <input type="text" class="form-control" id="editStatemodal" onkeypress="return validateStatemodal(event)" />
                        <span id="error_editStatemodal" class="text-danger"></span>
                    </div>
                    <%-- <div class="mb-3">
                        <label for="editCity" class="form-label">City</label>
                        <select id="editCitymodal" class="form-select">
                            <!-- Same cities as in the registration form -->
                            <option value="">-- Select City --</option>
                            <option value="Mumbai">Mumbai</option>
                            <option value="Delhi">Delhi</option>
                            <option value="Bangalore">Bangalore</option>
                            <option value="Kolkata">Kolkata</option>
                            <option value="Chennai">Chennai</option>
                            <option value="Hyderabad">Hyderabad</option>
                            <option value="Ahmedabad">Ahmedabad</option>
                            <option value="Pune">Pune</option>
                            <option value="Surat">Surat</option>
                            <option value="Jaipur">Jaipur</option>
                        </select>
                    </div>--%>
                    <div class="mb-3">
                        <label class="form-label">Site Type</label><br />
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="editSiteType" id="editMicrosite" value="microsite" />
                            <label class="form-check-label" for="editMicrosite">Microsite</label>
                        </div>
                        <div class="form-check form-check-inline">
                            <input class="form-check-input" type="radio" name="editSiteType" id="editWebsiteModal" value="website" />
                            <label class="form-check-label" for="editWebsite">Website</label>
                        </div>
                    </div>
                    <div id="editProduct" class="mb-3" style="display: none;">
                        <label for="editProductName" class="form-label">Product Name</label>
                        <input type="text" class="form-control" id="editProductNamemodal" />
                    </div>
                    <div id="editProductUrl" class="mb-3" style="display: none;">
                        <label for="editProductUrl" class="form-label">Product Url</label>
                        <input type="url" class="form-control" id="editProductUrlmodal" />
                    </div>
                    <div id="editService" class="mb-3" style="display: none;">
                        <label for="editServiceName" class="form-label">Service Name</label>
                        <input type="text" class="form-control" id="editServiceNamemodal" />
                    </div>
                    <div id="editServiceUrl" class="mb-3" style="display: none;">
                        <label for="editServiceUrl" class="form-label">Service Url</label>
                        <input type="url" class="form-control" id="editServiceUrlmodal" />
                    </div>
                    <div id="editWebsite" class="mb-3" style="display: none;">
                        <label for="editWebsiteUrl" class="form-label">Website Url</label>
                        <input type="url" class="form-control" id="editWebsiteUrlmodal" />
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                    <button type="button" id="saveEdit" class="btn btn-primary">Save changes</button>
                </div>
            </div>
        </div>
    </div>

    <script>
        function validateNamemodal(event) {
            var charCode = event.charCode;
            var input = event.target;
            var currentValue = input.value;

            // Allow alphabets (A-Z, a-z) and space (charCode 32)
            if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || (charCode == 32 && currentValue.length > 0 && !currentValue.endsWith(' '))) {
                return true;
                $("#error_editNamemodal").text("");
            }
            else {
                $("#error_editNamemodal").text("Invalid character."); // Display error message for invalid character
                return false;
            }
        }
        function validateStatemodal(event) {
            var charCode = event.charCode;
            var input = event.target;
            var currentValue = input.value;

            // Allow alphabets (A-Z, a-z) and space (charCode 32)
            if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || (charCode == 32 && currentValue.length > 0 && !currentValue.endsWith(' '))) {
                return true;
                $("#error_editStatemodal").text("");
            }
            else {
                $("#error_editStatemodal").text("Invalid character."); // Display error message for invalid character
                return false;
            }
        }
        function validateCitymodal(event) {
            var charCode = event.charCode;
            var input = event.target;
            var currentValue = input.value;

            // Allow alphabets (A-Z, a-z) and space (charCode 32)
            if ((charCode > 64 && charCode < 91) || (charCode > 96 && charCode < 123) || (charCode == 32 && currentValue.length > 0 && !currentValue.endsWith(' '))) {
                return true;
                $("#error_editCitymodal").text("");
            }
            else {
                $("#error_editCitymodal").text("Invalid character."); // Display error message for invalid character
                return false;
            }
        }
        function validatePinmodal() {
            var pinInput = document.getElementById("editPinCodemodal");
            var pinError = document.getElementById("error_textPinCodemodal");
            var pin = pinInput.value;

            // Check if the pin is numeric
            if (!/^\d+$/.test(pin)) {
                pinError.textContent = "Please enter a numeric value for Pin Code.";
                pinInput.value = pin.replace(/[^0-9]/g, ''); // Remove non-numeric characters
            } else {
                pinError.textContent = "";
            }

            // Trigger getaddress function if the pin length is 6 and valid
            if (pin.length === 6) {
                getaddressmodal();
            }
        }
        function getaddressmodal() {
            let pin = document.getElementById("editPinCodemodal").value;
            if (pin.length == 6) {
                $.getJSON(
                    "https://api.postalpincode.in/pincode/" + pin,
                    function (data) {
                        createHTML(data);
                    }
                ).fail(function () {
                    // In case of an error, allow manual entry
                    enableManualEntry();
                });

                function createHTML(data) {
                    if (data[0].Status == "Success") {
                        let city = data[0].PostOffice[0]["District"];
                        let state = data[0].PostOffice[0]["State"];
                        debugger;
                        $("#editCitymodal").val(city);
                        $("#editStatemodal").val(state);
                        /* $("#btnsubmit").attr("disabled", false);*/
                        $("#error_textPinCodemodal").text(""); // Clear any previous error message
                    } else {
                        $("#error_textPinCodemodal").text("Please enter a valid pin.");
                        /*$("#btnsubmit").attr("disabled", true);*/
                        enableManualEntry();
                    }
                }

                function enableManualEntry() {
                    $("#error_textPinCodemodal").text("Unable to fetch data. Please enter the details manually.");
                    $("#editCitymodal").val("").prop("disabled", false);
                    $("#editStatemodal").val("").prop("disabled", false);
                    $("#btnsubmit").attr("disabled", false);
                }
            }
        }
        $(document).ready(function () {
            // Function to show microsite fields
            function showMicrositeFields() {
                $('#editProduct').show();
                $('#editProductUrl').show();
                $('#editService').show();
                $('#editServiceUrl').show();
                $('#editWebsite').hide();
                $('#editWebsiteUrl').hide();
            }

            // Function to show website field
            function showWebsiteField() {
                $('#editProduct').hide();
                $('#editProductUrl').hide();
                $('#editService').hide();
                $('#editServiceUrl').hide();
                $('#editWebsite').show();
                $('#editWebsiteUrl').show();
            }

            // Event handler for radio button change
            $('input[name="editSiteType"]').change(function () {
                var selectedValue = $(this).val();
                if (selectedValue === 'microsite') {
                    showMicrositeFields();
                } else if (selectedValue === 'website') {
                    showWebsiteField();
                }
            });

            // Show Edit Modal with dealer data
            $(document).on("click", ".editDealer", function () {
                var dealerId = $(this).data('id');
                $.ajax({
                    type: "POST",
                    url: "Quntique.aspx/GetDealerData",
                    data: JSON.stringify({ dealerId: dealerId }),
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        // Populate modal with dealer data
                        var dealer = response.d;
                        debugger;
                        $("#editDealerId").val(dealer.DealerId);
                        $("#editNamemodal").val(dealer.Name);
                        $("#editEmailmodal").val(dealer.Email);
                        $("#editMobilemodal").val(dealer.Mobile);
                        $("#editAddress1modal").val(dealer.Address1);
                        $("#editCitymodal").val(dealer.City);
                        $("#editStatemodal").val(dealer.State);
                        $("#editPinCodemodal").val(dealer.PinCode);
                        // Populate product and service fields
                        $("#editProductNamemodal").val(dealer.ProductName);
                        $("#editProductUrlmodal").val(dealer.ProductUrl);
                        $("#editServiceNamemodal").val(dealer.ServiceName);
                        $("#editServiceUrlmodal").val(dealer.ServiceUrl);
                        // Show appropriate fields based on site type
                        if (dealer.IsMicrosite) {
                            $('#editMicrosite').prop('checked', true);
                            showMicrositeFields();
                        } else {
                            $('#editWebsiteModal').prop('checked', true);
                            showWebsiteField();
                            $("#editWebsiteUrlmodal").val(dealer.WebsiteUrl);
                        }
                        $("#editModal").modal('show');
                    },
                    error: function (response) {
                        showAlert("Error!", "Failed to load dealer data. Please try again later.", "error");
                    }
                });
            });

            // Submit edited data
            $("#saveEdit").click(function () {
                // Gather data from the edit modal
                var dealerData = {
                    DealerId: $("#editDealerId").val(),
                    Name: $("#editNamemodal").val(),
                    Email: $("#editEmailmodal").val(),
                    Mobile: $("#editMobilemodal").val(),
                    Address1: $("#editAddress1modal").val(),
                    City: $("#editCitymodal").val(),
                    State: $("#editStatemodal").val(),
                    PinCode: $("#editPinCodemodal").val(),
                    WebsiteUrl: $("#editWebsiteUrlmodal").val(),
                    IsMicrosite: $("#editMicrosite").prop("checked"),  // Ensure this is a boolean
                    ProductName: $("#editProductNamemodal").val(),
                    ProductUrl: $("#editProductUrlmodal").val(),
                    ServiceName: $("#editServiceNamemodal").val(),
                    ServiceUrl: $("#editServiceUrlmodal").val()
                };

                // Regular expressions for email, URL, name, mobile, address, and city validation
                var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
                var urlPattern = /^(https?:\/\/)?([\da-z.-]+)\.([a-z.]{2,6})([\/\w .-]*)*\/?(\?.*)?$/;
                var namePattern = /^[a-zA-Z][a-zA-Z\s]*[a-zA-Z]$/;
                var mobilePattern = /^[0-9]{10}$/;  // Example: 10 digit mobile number
                var addressPattern = /^[a-zA-Z0-9\s,'-]*$/;  // Example: Alphanumeric characters and some special chars
                var cityPattern = /^[a-zA-Z\s]*$/;  // Example: Only letters and spaces

                // Validate regular fields are not empty
                if (!dealerData.Name) {
                    showAlert("Validation Error", "Name is required.", "error");
                    return;
                }
                if (!dealerData.Email) {
                    showAlert("Validation Error", "Email is required.", "error");
                    return;
                }
                if (!dealerData.Mobile) {
                    showAlert("Validation Error", "Mobile number is required.", "error");
                    return;
                }
                if (!dealerData.Address1) {
                    showAlert("Validation Error", "Address is required.", "error");
                    return;
                }
                if (!dealerData.City) {
                    showAlert("Validation Error", "City is required.", "error");
                    return;
                }
                if (!dealerData.State) {
                    showAlert("Validation Error", "State is required.", "error");
                    return;
                }
                if (!dealerData.PinCode) {
                    showAlert("Validation Error", "Pin Code is required.", "error");
                    return;
                }

                // Validate name format
                if (dealerData.Name && !namePattern.test(dealerData.Name.trim())) {
                    showAlert("Validation Error", "Invalid name format. Name should not contain special characters, numbers, leading or trailing spaces.", "error");
                    return;
                }

                // Validate email format
                if (dealerData.Email && !emailPattern.test(dealerData.Email)) {
                    showAlert("Validation Error", "Invalid email format.", "error");
                    return;
                }

                // Validate mobile format
                if (dealerData.Mobile && !mobilePattern.test(dealerData.Mobile.trim())) {
                    showAlert("Validation Error", "Invalid mobile number format. Mobile number should be 10 digits.", "error");
                    return;
                }

                // Validate address format
                if (dealerData.Address1 && !addressPattern.test(dealerData.Address1.trim())) {
                    showAlert("Validation Error", "Invalid address format. Address should not contain special characters except comma, hyphen and apostrophe.", "error");
                    return;
                }

                // Validate city format
                if (dealerData.City && !cityPattern.test(dealerData.City.trim())) {
                    showAlert("Validation Error", "Invalid city format. City should contain only letters and spaces.", "error");
                    return;
                }

                // Validate based on microsite checkbox
                if (dealerData.IsMicrosite) {
                    // Microsite validation
                    if (!dealerData.ProductName) {
                        showAlert("Validation Error", "Product Name is required for a microsite.", "error");
                        return;
                    }
                    if (dealerData.ProductUrl && !urlPattern.test(dealerData.ProductUrl)) {
                        showAlert("Validation Error", "Invalid product URL format.", "error");
                        return;
                    }
                    if (!dealerData.ServiceName) {
                        showAlert("Validation Error", "Service Name is required for a microsite.", "error");
                        return;
                    }
                    if (dealerData.ServiceUrl && !urlPattern.test(dealerData.ServiceUrl)) {
                        showAlert("Validation Error", "Invalid service URL format.", "error");
                        return;
                    }
                } else {
                    // Website validation
                    if (!dealerData.WebsiteUrl) {
                        showAlert("Validation Error", "Website URL is required.", "error");
                        return;
                    }
                    if (dealerData.WebsiteUrl && !urlPattern.test(dealerData.WebsiteUrl)) {
                        showAlert("Validation Error", "Invalid website URL format.", "error");
                        return;
                    }
                }

                // Proceed with AJAX call if validation passed
                $.ajax({
                    type: "POST",
                    url: "Quntique.aspx/UpdateDealerData",
                    data: JSON.stringify({ dealerData: dealerData }),  // Wrap dealerData in an object
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        // Handle success
                        if (response.d.status === "Success") {
                            showAlert("Success!", "Dealer data submitted successfully.", "success");
                            // Reload the page
                            location.reload();
                        } else {
                            showAlert("Error!", "Failed to submit dealer data. Please try again later.", "error");
                        }
                    },
                    error: function (xhr, status, error) {
                        // Handle error
                        showAlert("Error!", "Failed to submit dealer data. Please try again later.", "error");
                    }
                });
            });


        });

    </script>

    <%-- <script>
        document.addEventListener("DOMContentLoaded", function () {
            // Wait for the DOM to fully load before registering event handlers
            var radioMicrosite = document.getElementById('radioMicrosite');
            var radioWebsite = document.getElementById('radioWebsite');

            radioMicrosite.addEventListener('click', ToggleSiteType);
            radioWebsite.addEventListener('click', ToggleSiteType);
        });

        function ToggleSiteType() {
            var micrositeSection = document.getElementById('micrositeSection');
            var websiteSection = document.getElementById('websiteSection');

            if (document.getElementById('radioMicrosite').checked) {
                micrositeSection.style.display = 'block';
                websiteSection.style.display = 'none';
            } else if (document.getElementById('radioWebsite').checked) {
                micrositeSection.style.display = 'none';
                websiteSection.style.display = 'block';
            }
        }

        function validateForm() {
            // Regular expressions for email, URL, name, mobile, address, and city validation
            var emailPattern = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
            var urlPattern = /^(ftp|http|https):\/\/[^ "]+$/;
            var namePattern = /^[a-zA-Z][a-zA-Z\s]*[a-zA-Z]$/;
            var mobilePattern = /^[0-9]{10}$/;  // Example: 10 digit mobile number
            var addressPattern = /^[a-zA-Z0-9\s,'-]*$/;  // Example: Alphanumeric characters and some special chars
            var cityPattern = /^[a-zA-Z\s]*$/;  // Example: Only letters and spaces

            // Validate regular fields
            var name = document.getElementById('editNamemodal').value.trim();
            var email = document.getElementById('editEmailmodal').value.trim();
            var mobile = document.getElementById('editMobilemodal').value.trim();
            var address1 = document.getElementById('editAddress1modal').value.trim();
            var city = document.getElementById('editCitymodal').value.trim();
            var pinCode = document.getElementById('editPinCodemodal').value.trim();

            if (name === '' || !namePattern.test(name)) {
                alert('Please enter a valid name. Name should not contain special characters, numbers, leading or trailing spaces.');
                return false;
            }
            if (email === '' || !emailPattern.test(email)) {
                alert('Please enter a valid email address.');
                return false;
            }
            if (mobile === '' || !mobilePattern.test(mobile)) {
                alert('Please enter a valid mobile number. Mobile number should be 10 digits.');
                return false;
            }
            if (address1 === '' || !addressPattern.test(address1)) {
                alert('Please enter a valid address. Address should not contain special characters except comma, hyphen and apostrophe.');
                return false;
            }
            if (city === '' || !cityPattern.test(city)) {
                alert('Please enter a valid city. City should contain only letters and spaces.');
                return false;
            }
            if (pinCode === '') {
                alert('Please enter a pin code.');
                return false;
            }

            var radioMicrosite = document.getElementById('editMicrosite');

            if (radioMicrosite.checked) {
                // Validate microsite fields
                var productName = document.getElementById('editProductNamemodal').value.trim();
                var productUrl = document.getElementById('editProductUrlmodal').value.trim();
                var serviceName = document.getElementById('editServiceNamemodal').value.trim();
                var serviceUrl = document.getElementById('editServiceUrlmodal').value.trim();

                if (productName === '') {
                    alert('Please enter product name for microsite.');
                    return false;
                }
                if (productUrl === '' || !urlPattern.test(productUrl)) {
                    alert('Please enter a valid product URL for microsite.');
                    return false;
                }
                if (serviceName === '') {
                    alert('Please enter service name for microsite.');
                    return false;
                }
                if (serviceUrl === '' || !urlPattern.test(serviceUrl)) {
                    alert('Please enter a valid service URL for microsite.');
                    return false;
                }
            } else {
                // Validate website fields
                var websiteUrl = document.getElementById('editWebsiteUrlmodal').value.trim();
                if (websiteUrl === '' || !urlPattern.test(websiteUrl)) {
                    alert('Please enter a valid website URL.');
                    return false;
                }
            }

            // If all validations pass, return true to allow form submission
            return true;
        }

        $("#saveEdit").click(function () {
            if (validateForm()) {
                // Gather data from the edit modal
                var dealerData = {
                    DealerId: $("#editDealerId").val(),
                    Name: $("#editNamemodal").val().trim(),
                    Email: $("#editEmailmodal").val().trim(),
                    Mobile: $("#editMobilemodal").val().trim(),
                    Address1: $("#editAddress1modal").val().trim(),
                    City: $("#editCitymodal").val().trim(),
                    PinCode: $("#editPinCodemodal").val().trim(),
                    WebsiteUrl: $("#editWebsiteUrlmodal").val().trim(),
                    IsMicrosite: $("#editMicrosite").prop("checked"),  // Ensure this is a boolean
                    ProductName: $("#editProductNamemodal").val().trim(),
                    ProductUrl: $("#editProductUrlmodal").val().trim(),
                    ServiceName: $("#editServiceNamemodal").val().trim(),
                    ServiceUrl: $("#editServiceUrlmodal").val().trim()
                };

                // Proceed with AJAX call if validation passed
                $.ajax({
                    type: "POST",
                    url: "Quntique.aspx/UpdateDealerData",
                    data: JSON.stringify({ dealerData: dealerData }),  // Wrap dealerData in an object
                    contentType: "application/json; charset=utf-8",
                    dataType: "json",
                    success: function (response) {
                        // Handle success
                        if (response.d.status === "Success") {
                            showAlert("Success!", "Dealer data submitted successfully.", "success");
                            // Reload the page
                            location.reload();
                        } else {
                            showAlert("Error!", "Failed to submit dealer data. Please try again later.", "error");
                        }
                    },
                    error: function (xhr, status, error) {
                        // Handle error
                        showAlert("Error!", "Failed to submit dealer data. Please try again later.", "error");
                    }
                });
            }
        });



    </script>--%>



    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
