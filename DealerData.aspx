<%@ Page Language="C#" AutoEventWireup="true" CodeFile="DealerData.aspx.cs" Inherits="DealerData" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>Dealer Details</title>
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
</head>
<body class="bg-light">
    <form id="form1" runat="server">
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
                            </ul>
                        </div>
                    </div>
                </nav>
            </div>
        </div>
        <!-- app-navbar-end -->
        <!-- table -->
        <section class="dealer-detail">
            <div class="container">
                <div class="row">
                    <div class="col-xxl-8 col-xl-8 col-lg-6 col-md-12 d-flex mx-auto">
                        <div>
                            <div class="profile-card">
                                <div class="card mb-3">
                                    <div class="card-body">
                                        <div class="row g-3">
                                            <div class="col-lg-2 d-flex">
                                                <img src="quantique/assets/img/logo.jpeg" alt="logo" class="logo img-fluid"/>
                                            </div>
                                            <div class="col-lg-10 d-flex">
                                                <div class="w-100">
                                                    <div
                                                        class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-3">
                                                        <div class="col">
                                                            <ul class="profile-name">
                                                                <li>
                                                                    <i class='bx bxs-user-circle'></i>
                                                                </li>
                                                                <li>
                                                                    <p>full name</p>
                                                                    <h6 id="lblname" runat="server"></h6>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="col">
                                                             <ul class="profile-name">
                                                                <li>
                                                                    <i class='bx bxs-phone-call'></i>
                                                                </li>
                                                                <li>
                                                                    <p>Dealer Contact No.</p>
                                                                    <h6 id="lblcontact" runat="server"></h6>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="col">
                                                             <ul class="profile-name">
                                                                <li>
                                                                    <i class='bx bxs-envelope'></i>
                                                                </li>
                                                                <li>
                                                                    <p>Email Id</p>
                                                                    <h6 id="lblemail" runat="server"></h6>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                        <div class="col-xxl-12 col-xl-12 col-lg-12 col-md-12 col-12">
                                                            <hr class="m-0"/>
                                                        </div>
                                                        <div class="col-xxl-12 col-xl-12 col-lg-12 col-md-12 col-12">
                                                            <ul class="profile-name">
                                                                <li>
                                                                    <i class='bx bxs-map-pin'></i>
                                                                </li>
                                                                <li>
                                                                    <p>Dealer Office</p>
                                                                    <h6 id="lbldealerAdd" runat="server"></h6>
                                                                </li>
                                                            </ul>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="our-services mt-4">
                                <h5 class="mb-3">Our services</h5>
                                <div class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-1 row-cols-1 g-3">
                                    <asp:Repeater ID="serviceRepeater" runat="server">
                                        <ItemTemplate>
                                            <div class="col">
                                                <div class="card">
                                                    <div class="card-body">
                                                       <a href='<%# Eval("ServiceUrl") %>' class="stretched-link">
                                                            <img src="<%# GetServiceImageUrl(Container.ItemIndex) %>" />
                                                       </a>
                                                        <h5 class="card-title"><%# Eval("ServiceName") %></h5>
                                                        <hr />
                                                           <ul class="bottom-link">
                                                               <li>
                                                                   <span> View</span>
                                                               </li>
                                                               <li>
                                                                   <i class='bx bxs-right-arrow-circle'></i>
                                                               </li>
                                                           </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                    <div class="col-xxl-12 col-xl-12 col-lg-12 col-md-12 col-12">
                                        <h5 class="mb-3">Our Product</h5>
                                    </div>
                                    <asp:Repeater ID="productRepeater" runat="server">
                                        <ItemTemplate>
                                           <div class="col">
                                                <div class="card">
                                                    <div class="card-body">
                                                       <a href='<%# Eval("ProductUrl") %>' class="stretched-link">
                                                            <img src="<%# GetProductImageUrl(Container.ItemIndex) %>" />
                                                       </a>
                                                        <h5 class="card-title"><%# Eval("ProductName") %></h5>
                                                        <hr />
                                                           <ul class="bottom-link">
                                                               <li>
                                                                   <span> View</span>
                                                               </li>
                                                               <li>
                                                                   <i class='bx bxs-right-arrow-circle'></i>
                                                               </li>
                                                           </ul>
                                                    </div>
                                                </div>
                                            </div>
                                        </ItemTemplate>
                                    </asp:Repeater>
                                </div>
                            </div>
                        </div>
                    </div>
                    <%-- <div class="col-xxl-4 col-xl-4 col-lg-6 col-md-12 d-flex">
                         <iframe id="mapIframe" runat="server" width="100%" height="100%" style="border: 0;" allowfullscreen="" loading="lazy"></iframe>
                    </div>--%>
                </div>
            </div>
        </section>
        <!-- table-end -->
        <!-- footer -->
        <footer class="footer">
            <div class="container">
                <p>Copyright © 2024 QUANTIQUE METADATA PRIVATE LIMITED</p>
            </div>
        </footer>
        <!-- footer-end -->
        <!-- js -->
        <script src="quantique/assets/js/index.js"></script>
    </form>
</body>
</html>