<%@ Page Title="VCQRU | The Boon of Brand Loyalty and top 5 ways to Build it" Language="C#" MasterPageFile="~/blog/BlogLayout.master.master" AutoEventWireup="true" CodeFile="brand-loyalty.aspx.cs" Inherits="blog_brand_loyalty" %>


<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <script type='application/ld+json'></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <section class="blog-details">
        <div class="container">
            <div class="app-breadcrumb">
                <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item"><a href="/Default.aspx">Home</a></li>
                        <li class="breadcrumb-item"><a href="/blog.aspx">Blogs</a></li>
                        <li class="breadcrumb-item active text-transform-unset" aria-current="page">
                            <asp:Literal ID="breadcrum" runat="server"></asp:Literal></li>
                    </ol>
                </nav>
            </div>
            <div class="row g-4">
                <div class="col-xxl-8 col-xl-8 col-lg-8">
                    <div class="card">
                        <div class="card-body p-5">
                            <h3 class="card-title">
                                <asp:Literal runat="server" ID="lblHeader" /></h3>
                            <span class="blog-date">
                                <asp:Label ID="lbldate" runat="server" Text="Label"></asp:Label></span>
                            <asp:Image ID="imgPost" runat="server" AlternateText="Blog Image" />
                            <asp:Literal runat="server" ID="lblPost" />
                        </div>
                    </div>
                </div>
                <div class="col-xxl-4 col-xl-4 col-lg-4">
                    <div class="left-blog-details">
                        <div class="card mb-4">
                            <div class="card-body">
                                <h5 class="card-title">Follow Us On</h5>
                                <ul class="follow-us-icons">
                                    <li>
                                        <a href="https://www.facebook.com/vcqru/" target="_blank">
                                            <i class="fa-brands fa-square-facebook"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="https://www.linkedin.com/company/vcqru-wesecureyou/" target="_blank">
                                            <i class="fa-brands fa-linkedin"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="https://www.instagram.com/vcqru_wesecureyou/" target="_blank">
                                            <i class="fa-brands fa-square-instagram"></i>
                                        </a>
                                    </li>
                                    <li>
                                        <a href="https://twitter.com/Vcqru_Official" target="_blank">
                                            <i class="fa-brands fa-square-x-twitter"></i>
                                        </a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <div class="card mb-4">
                            <div class="card-body">
                                <h5 class="card-title">Get in touch with our experts.</h5>
                                <p class="card-text">
                                    For any queries feel free to contact us and our expert support team
                                    will get back to you as soon as possible!
                                </p>
                                <img src="/NewContent/front-assets/img/blog-contact-us.png" alt="Contact us img">
                                <div class="text-center">
                                    <a href="/contact-us.aspx" class="btn btn-primary btn-sm px-5">contact us</a>
                                </div>
                            </div>
                        </div>
                        <div class="card">
                            <div class="card-body">
                                <h5 class="card-title">Industry Usecases</h5>
                                <ul class="list-group list-group-flush">
                                    <li class="list-group-item">
                                        <a href="/anti-counterfeit-solution-for-fmcg-industry.aspx">FMCG</a>
                                    </li>
                                    <li class="list-group-item">
                                        <a href="/anti-counterfeit-solution-for-ecommerce-industry.aspx">E-Commerce</a>
                                    </li>
                                    <li class="list-group-item">
                                        <a href="/anti-counterfeit-solutions-for-apparel-and-fashion-industry.aspx">Apparels & Fashion</a>
                                    </li>
                                    <li class="list-group-item">
                                        <a href="/anti-counterfeit-solutions-for-electronic-and-electricals-industry.aspx">Electronics & Electricals</a>
                                    </li>
                                    <li class="list-group-item">
                                        <a href="/anti-counterfeit-solution-for-consumer-electronics-industry.aspx">Consumer Electronics</a>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
    <!-- blog read end -->
    <!-- like -->
    <section class="our-blog-listing">
        <div class="container">
            <div class="web-heading">
                <h1>Explore other blogs</h1>
            </div>
            <div
                class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-xl-5 g-lg-4 g-md-4 g-3">
                <asp:Repeater ID="blogRepeater" runat="server">
                    <ItemTemplate>
                        <div class="col d-flex">
                            <div class="card">
                                <div class="blog-img">
                                    <asp:HyperLink ID="HyperLink1" runat="server"
                                      NavigateUrl='<%# string.Format("~/blog/{0}.aspx",string.IsNullOrWhiteSpace(Eval("Slugs").ToString()) ? "default-slug" : Eval("Slugs")) %>'>
                                            <asp:Image ID="imgPost" runat="server" ImageUrl='<%# Eval("ImagePath") %>'
                                                AlternateText="Blog Image" CssClass="card-img-top" />
                                    </asp:HyperLink>
                                </div>
                                <div class="card-body">
                                    <h5 class="card-title">
                                       <asp:HyperLink ID="HyperLink12" runat="server"
                                                NavigateUrl='<%# string.Format("~/blog/{0}.aspx",string.IsNullOrWhiteSpace(Eval("Slugs").ToString()) ? "default-slug" : Eval("Slugs")) %>'>
                                                <%# Eval("Title") %>
                                            </asp:HyperLink>
                                    </h5>
                                    <p class="card-text">
                                        <%# Eval("BodyOverview") %>
                                    </p>
                                    <span><%# string.Format("{0:MMM dd, yyyy}", Eval("StartDateUtc")) %></span>
                                </div>
                            </div>
                        </div>
                    </ItemTemplate>
                </asp:Repeater>
            </div>
        </div>
    </section>
</asp:Content>

