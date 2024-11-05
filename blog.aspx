<%@ Page Title="VCQRU | Our Blogs" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true"
    CodeFile="blog.aspx.cs" Inherits="blog" %>

    <asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
        <script type="application/ld+json">
        {
            "@context": "https://schema.org",
            "@type": "BlogPosting",
            "mainEntityOfPage": {
                "@type": "WebPage",
                "@id": "https://www.vcqru.com/blog.aspx"
            },
            "headline": "Our Blogs",
            "description": "Test11 GIT Welcome to VCQRU, your trusted partner for protecting your brand from the risks of counterfeiting and duplication.",
            "image": "https://www.vcqru.com/NewContent/front-assets/img/blogs.png",
            "publisher": {
                "@type": "Organization",
                "name": "VCQRU",
                "logo": {
                    "@type": "ImageObject",
                    "url": "https://www.vcqru.com/"
                }
            },
            "datePublished": "2023-03-15",
            "dateModified": "2023-12-14"
        }
    </script>
        <title>Our Blogs</title>
        <meta name="title" content="Our Blogs" />
        <meta name="description"
            content="Welcome to VCQRU, your trusted partner for protecting your brand from the risks of counterfeiting and duplication." />
         <link rel="canonical" href="https://www.vcqru.com/blog.aspx"/>
    </asp:Content>

    <asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
        <section class="services-details-header">
            <div class="container">
                <!-- breadcrumb -->
                <div class="app-breadcrumb">
                    <nav style="--bs-breadcrumb-divider: '>';" aria-label="breadcrumb">
                        <ol class="breadcrumb">
                            <li class="breadcrumb-item"><a href="Default.aspx">Home</a></li>
                            <li class="breadcrumb-item active" aria-current="page">Our blogs</li>
                        </ol>
                    </nav>
                </div>
                <!-- end -->
                <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-1 row-cols-1 g-4">
                    <div class="col order-lg-1 order-2">
                        <h1>Our Blogs</h1>
                        <p>
                            Welcome to VCQRU, your trusted partner for protecting your brand from the risks of
                            counterfeiting
                            and duplication.
                        </p>
                        <a href="contact-us.aspx" class="btn btn-primary">Get connect with us</a>
                    </div>
                    <div class="col order-lg-2 order-1 text-lg-end text-center">
                        <img src="NewContent/front-assets/img/blogs.png" alt="Anti Counterfeiting Solution"
                            class="img-fluid">
                    </div>
                </div>
            </div>
        </section>
        <!-- blog header end -->
        <!-- blog listing -->
        <section class="our-blog-listing">
            <div class="container">
                <div
                    class="row row-cols-xxl-3 row-cols-xl-3 row-cols-lg-3 row-cols-md-2 row-cols-1 g-xl-5 g-lg-4 g-md-4 g-3 justify-content-center">
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
                                        <span>
                                            <%# string.Format("{0:MMM dd, yyyy}", Eval("StartDateUtc")) %>
                                        </span>
                                    </div>
                                </div>
                            </div>
                        </ItemTemplate>
                    </asp:Repeater>

                </div>
                <div class="text-center">
                    <!-- start page -->
                    <nav aria-label="Page navigation example">
                        <ul class="pagination">
                            <li class="page-item">
                                <asp:Button ID="btnPrevious" CssClass="page-link" runat="server" Text="&laquo;"
                                OnClick="btnPrevious_Click" />
                            </li>
                            <li class="page-item">
                                <a class="page-link active" href="#">
                                    <asp:Label ID="lblPageNumber" runat="server" Text="1" />
                                </a>
                            </li>
                            <li class="page-item">
                                <asp:Button ID="btnNext" runat="server" CssClass="page-link" Text="&raquo;" OnClick="btnNext_Click" />
                            </li>
                        </ul>
                    </nav>
                </div>
            </div>
        </section>
    </asp:Content>