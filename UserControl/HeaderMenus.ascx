<%@ Control Language="C#" AutoEventWireup="true" CodeFile="HeaderMenus.ascx.cs" Inherits="UserControl_HeaderMenus" %>
<script>
    //$('#mainNav li a').removeClass('nav-link active');
   
</script>
 
                                    <div class="header-row pt-3" >
								
									<nav class="header-nav-top" >
										<ul class="nav nav-pills" id="menuone">
											<%--<li class="nav-item d-none d-sm-block">
												<span class="ws-nowrap"><i class="fa fa-phone icon-header-class"></i> Helpline- (+91)-9711809420</span>
											</li>
											<li class="nav-item d-none d-sm-block">
												<span class="ws-nowrap"><i class="fa fa-envelope icon-header-class"></i> SMS/IVR- (+91)-9243029420</span>
											</li>--%>
                                            <%if (Session["User_Type"] == null)
                                                { %>


<%--                                           <li class="nav-item d-none d-sm-block">
                                                <a class="nav-link ws-nowrap" href="Consumerregister.aspx#trylogin" title="User Login"><i class="fa fa-user icon-header-class1"></i>Login</a>
                                                <a class="nav-link ws-nowrap" href="Login.aspx#login" title="Company/Vendor Login">
                                                    <i class="fa fa-user icon-header-class1" ></i>Vendor Login</a><b>/</b><a  title="Company/Vendor Signup" href="register.aspx#register">Signup</a>
											</li>--%>
                                            <%}
                                                else
                                                {%>

                                            <%
                                                if (Session["User_Type"] != null)
                                                {
                                                    if (Session["User_Type"].ToString() == "Consumer")
                                                    {   %>
                                              <li class="nav-item d-none d-sm-block">
                                                <a class="nav-link ws-nowrap" href="../Consumer/UpdateProfile.aspx">
                                                    <i class="fa fa-user icon-header-class1"></i>Welcome Consumer</a>
                                                 <a href="Javascript:;" class="nav-link ws-nowrap" onclick="logout();">
                                                    <i class="fa fa-user icon-header-class1"></i>Sign Out</a>
											</li>
                                          
                                            <% }
                                                else
                                                {
                                                    if (Session["User_Type"].ToString() == "Company")
                                                    {%>
                                             <li class="nav-item d-none d-sm-block">
                                                <a class="nav-link ws-nowrap" href="../Manufacturer/UpDateCompanyProfile.aspx">
                                                    <i class="fa fa-user icon-header-class1"></i>
                                                    <%if (Session["User_Type"] != null)
                                                        {%>
                                                         Welcome <%=Session["Comp_Name"].ToString()%>
                                                    <%} %>
                                                </a>
                                                 <a href="Javascript:;" class="nav-link ws-nowrap" onclick="logout();">
                                                    <i class="fa fa-user icon-header-class1"></i>Sign Out</a>
											    </li>
                                                <%}%>
                                          
                                            <%
                                                        }

                                                    }
                                                }
                                            %>
                                            </ul>
                                        	
									</nav>
									
								</div>
                                 
<div class="header-row" id="menurow" style="margin-top:30px;">
									<div class="header-nav">
										<div class="header-nav-main header-nav-main-effect-1 header-nav-main-sub-effect-1">
											<nav class="collapse">
												<ul class="nav nav-pills" id="mainNav">
													<li class="">
														<a class="nav-link active" href="../default.aspx#maindiv" onclick="showclose();">
															Home
														</a>
													</li>
													<li class="">
                                                        <a class="nav-link" href="../default.aspx#Abouts" onclick="showclose();">
															About Us
														</a>														
													</li>
                                                    <li class="">
														<a class="" href="../default.aspx#services" onclick="showclose();"> 
															Our Services
														</a>
                                                        </li>
													<%--<li class="dropdown">
														<a class="dropdown-item dropdown-toggle" href="#">
															Concept VCQRU.COM
														</a>
														<ul class="dropdown-menu">
															<li><a class="dropdown-item" href="../Info/Basic_Concept.aspx">Basic Concept</a></li>
															<li><a class="dropdown-item" href="../Content/includes/VCQRU.ppt">Presentation</a></li>
															<li><a class="dropdown-item" href="../Info/Ppi.aspx#bottom">Product Patent Inforamation</a></li>
														</ul>
													</li>--%>
													<%--<li class="">
														<a class="nav-link" href="Brand_Promotion/Loyalty_Program.html">
															Brand Loyalty
														</a>
													</li>--%>
													<%--<li class="dropdown">
														<a class="dropdown-item dropdown-toggle" href="#">
															Manufacturer
														</a>
														<ul class="dropdown-menu">
															<li><a class="dropdown-item" href="../Info/M_Movie.aspx">Manufacturer Movie</a></li>
														<%--	<li><a class="dropdown-item" href="../Content/includes/m_brochure.pdf">Brochure</a></li>-%>
															<li><a class="dropdown-item" href="../Info/Advantages_Manufacturer.aspx">Benefits of basic membership</a></li>
															<li><a class="dropdown-item" href="../Info/Benefits_Premium.aspx">Benefits of Premium membership</a></li>
															<li><a class="dropdown-item" href="../Info/EULA_Manufacturer.aspx">Terms & Conditions</a></li>
															<li><a class="dropdown-item" href="../Info/Faqs.aspx">FAQ's</a></li>

														</ul>
													</li>--%>
													<%--<li class="dropdown">
														<a class="dropdown-item dropdown-toggle" href="#">
															Buyer
														</a>
														<ul class="dropdown-menu">
															<li><a class="dropdown-item" href="../Info/RequirementForSignup_Consumer.aspx">Requirement for signup</a></li>
															<li><a class="dropdown-item" href="../Info/Benefits_Consumer.aspx">Benefits</a></li>
															<li><a class="dropdown-item" href="../Info/C_Movie.aspx">Buyer movie</a></li>
															<li><a class="dropdown-item" href="../Info/EULA_Manufacturer.aspx">Terms and conditions</a></li>
															<li><a class="dropdown-item" href="../Info/Faqs_Consumer.aspx">FAQ's</a></li>
														</ul>
													</li>--%>
												<%--	<li class="">
														<a class="nav-link" href="../Info/FrmInvestors.aspx">
															Investors
														</a>
													</li>--%>
													<%--<li class="">
														<a  href="../default.aspx#blog" onclick="showclose();">
															Blogs
														</a>
														<ul class="dropdown-menu">
															<li><a class="dropdown-item" href="../Info/News_Blogs.aspx">News Blog</a></li>
															<li><a class="dropdown-item" href="../Info/Ppi.aspx">Product patent information</a></li>
															<li><a class="dropdown-item" href="../Info/FrmSendQuery.aspx">Send your query</a></li>
														</ul>
													</li>--%>
													<li class="dropdown">
														<a class="dropdown-item dropdown-toggle" href="../default.aspx#contact" onclick="showclose();">
															Contact Us
														</a>
                                                        <ul class="dropdown-menu">
                                                             <li>  <a class="dropdown-item" href="../default.aspx#contact" title="send your query" onclick="showclose();">Contact Us</a></li>
                                                           <li>   <a class="dropdown-item" href="#" title="Call us for query">Helpline- (+91)-9711809420</a></li>
                                                            <li>   <a class="dropdown-item" href="#" title="Check your product is genuine or not.">SMS/IVR- (+91)-9243029420</a></li>
                                                        </ul>
													</li>
                                                     <li class="dropdown">
														<a  href="../default.aspx#logsign" onclick="showclose();">
															Login / Signup
														</a>
                                                         <%--<ul class="dropdown-menu">
															
                                                            <li>  <a class="dropdown-item" href="../info/Consumerregister.aspx#trylogin" title="User Login"><i class="fa fa-user icon-header-class1"></i> &nbsp;&nbsp;Login</a></li>
                                                            <li>  <a class="dropdown-item" href="../info/Login.aspx#login" title="Company/Vendor Login"><i class="fa fa-user icon-header-class1"></i> &nbsp;&nbsp;Vendor Login</a></li>
                                                            <li>  <a class="dropdown-item" title="Company/Vendor Signup" href="../info/register.aspx#register"><i class="fa fa-user icon-header-class1"></i> &nbsp;&nbsp;Vendor Signup</a></li>
														</ul>--%>
													</li>
												</ul>
											</nav>
										</div>
										<!--ul class="header-social-icons social-icons d-none d-sm-block">
											<li class="social-icons-facebook"><a href="http://www.facebook.com/" target="_blank" title="Facebook"><i class="fa fa-facebook"></i></a></li>
											<li class="social-icons-twitter"><a href="http://www.twitter.com/" target="_blank" title="Twitter"><i class="fa fa-twitter"></i></a></li>
											<li class="social-icons-linkedin"><a href="http://www.linkedin.com/" target="_blank" title="Linkedin"><i class="fa fa-linkedin"></i></a></li>
										</ul-->
										<button class="btn header-btn-collapse-nav" id="btnmenu" data-toggle="collapse" data-target=".header-nav-main nav">
											<i class="fa fa-bars"></i>
										</button>
									</div>
								</div>