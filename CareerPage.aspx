<%@ Page Title="Career, Job opportunity in Gurgaon | VCQRU" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="CareerPage.aspx.cs" Inherits="CareerPage" %>



<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
     <meta name="description" content="Looking for the next job opportunity? VCQRU company is hiring. Check the given link for more details about this job opening." />
<meta name="keywords" content="Job Opening, Carrer, Jobs in Gurgaon, Fresher jobs in Gurgaon, Jobs near gurgaon, jobs for fresher in gurgaon, Jobs in gurugram, IT jobs in Gurgaon" />

    <link href="assets/css/career-style.css" rel="stylesheet" />

   
   <%--  <script src="../vendor/jquery/jquery.min.js"></script>
     <script src="../Content/js/jquery.cookie.js" type="text/javascript"></script>--%>
     <script src="../Content/js/toastr.min.js"></script> 
    <link href="../Content/css/toastr.min.css" rel="stylesheet" />
    <style>
        section.career-section {
            padding-top: 14%;
        }
    </style>
    <script>
        function openFormModel() {
            $("#Lead").removeClass("show");
            $("#Support").removeClass("show");
            $("#BDM").removeClass("show");
            $("#Digital").removeClass("show");
            $("#DotNet").removeClass("show");
            $("#WebDesign").removeClass("show");
            $("Android-Dev").removeClass("show");
        }

        function sendcquery() {
            // debugger;
            toastr.clear();
            flag = true;

            if ($('.cname').val() == '') {
                toastr.error("Please enter Name"); msg = "no"; return false;
                alert();
            }
            if ($('.cemail').val() == '') {
                toastr.error("Please enter email"); msg = "no";
                return false;
            }

            var emailReg = new RegExp("^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
            var valid = emailReg.test($('.cemail').val());
            if (!valid) {
                toastr.error("Please enter the correct email.");
                return false;
            }

            if ($('.cmobile').val() == '') {
                toastr.error("Please enter your mobile no."); msg = "no"; return false;
            }
            var v = $('.cmobile').val().length;
            if (v < 10 || v > 12) {
                toastr.error("Please enter correct Mobile Number."); return false;
            }
            // var MobileReg = new RegExp("^[0-9_.+-]+$");
            var MobileReg = /[0-9]|\./;
            var valid = MobileReg.test($('.cmobile').val());
            if (!valid) {
                toastr.error("Please enter the correct mobile no.");
                return false;
            }
            if (!document.querySelector('.img_bill').checkValidity()) {
                toastr.error("Please upload reshume.");
                flag = false;
            }
            if (flag == true) {
                $('#lblNameProcess').text('Please be wait, Send data is in process!');
            }
            //  $('#progress').hide();
        }

        function alphanumeric(inputtxt) {
            var TCode = document.getElementById('cname').value;
            if (/[^a-zA-Z ]/.test(TCode)) {
                document.getElementById("cname").value = TCode.replace(/\d+/g, '');
                toastr.error('Input is not alphanumeric \n Enter Characters only between A to Z or a to z');
                return false;
            }
            return true;
        }

    </script>

    <style>
        .modal-header,.modal-body,.modal-footer{
            background-color:#fff;
        }
        .modal-content input[type=text]{
            border:1px solid #ccc;
        }
        .modal-content input[type=file]{
            background-color: #e9ecef;
            padding: 15px !important;
        }
        .modal-content input[type=file]:hover{
            background-color: #dde0e3;
            transition: color .5s;
        }
        .modal-header .close {
    padding: inherit;
    margin: inherit;
}
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <section class="career-section">
        <div class="container">
            <div class="row">
                <div class="col-sm-9">
                    <h1 class="">JOB OPENINGS</h1>
                </div>
                <div class="col-sm-3">
                    <img src="../assets/images/slider/career-img.png" class="responsive-img career-img" alt="career-img">
                </div>
            </div>
        </div>
    </section>
    <section class="">
        <div class="container">
            <div class="row pt-5 pb-5">
                <div class="col-sm-12">

                    <div class="row">

                       <%-- <div class="col-sm-4">
                            <div class="job-box">
                                <h5 class="text-uppercase">Cloud Admin</h5>
                                <label>Job Openings : <span>01</span></label>
                                <label>Experience : 4+ Year</label>
                                <label class="text-uppercase">Location : Gurgaon</label>
                               
                            <a class="btn-apply  data-bs-toggle" data-bs-toggle="modal" data-bs-target="#myModalCloudAdmin">
                                Apply
                            </a>
                            </div>
                        </div>--%>


                         <div class="col-sm-4">
                            <div class="job-box">
                                <h5 class="text-uppercase"> Email Marketing Executive </h5>
                                <label>Job Openings : <span>01</span></label>
                                <label>Experience : 4+ Year</label>
                                <label class="text-uppercase">Location : Gurgaon</label>
                               
                            <a class="btn-apply  data-bs-toggle" data-bs-toggle="modal" data-bs-target="#myModalEmailMarketing">
                                Apply
                            </a>
                            </div>
                        </div>

                        <div class="col-sm-4">
                            <div class="job-box">
                                <h5 class="text-uppercase">Customer Support</h5>
                                <label>Job Openings : <span>10</span></label>
                                <label>Experience : 0-3 Year</label>
                                <label class="text-uppercase">Location : Gurgaon</label>
                             
                            <a class="btn-apply  data-bs-toggle"  data-bs-toggle="modal" data-bs-target="#myModalSupport">
                                Apply
                            </a>
                            </div>
                        </div>

                        <div class="col-sm-4">
                            <div class="job-box">
                                <h5 class="text-uppercase">Content Writer</h5>
                                <label>Job Openings : <span>01</span></label>
                                <label>Experience : 0-4 Year</label>
                                <label class="text-uppercase">Location : Gurgaon</label>
                                
                                <a class="btn-apply  data-bs-toggle" data-bs-toggle="modal" data-bs-target="#myModalContentWriter">
                                    Apply
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="job-box">
                                <h5 class="text-uppercase">Dot Net Developer</h5>
                                <label>Job Openings : <span>01</span></label>
                                <label>Experience : 4+ Year</label>
                                <label class="text-uppercase">Location : Gurgaon</label>
                              
                                <a class="btn-apply  data-bs-toggle"  data-bs-toggle="modal" data-bs-target="#myModalDotNet">
                                    Apply
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="job-box">
                                <h5 class="text-uppercase">Lead/Demand Generation</h5>
                                <label>Job Openings : <span>04</span></label>
                                <label>Experience : 0-3 Year</label>
                                <label class="text-uppercase">Location : Gurgaon</label>
                           
                                <a class="btn-apply  data-bs-toggle" data-bs-toggle="modal" data-bs-target="#myModelLead">
                                    Apply
                                </a>
                            </div>
                        </div>
                        <div class="col-sm-4">
                            <div class="job-box">
                                <h5 class="text-uppercase">Business Development Manager</h5>
                                <label>Job Openings : <span>04</span></label>
                                <label>Experience : 1-5 Year</label>
                                <label class="text-uppercase">Location : Gurgaon</label>
                            
                                <a class="btn-apply  data-bs-toggle" data-bs-toggle="modal" data-bs-target="#myModalBDM">
                                    Apply
                                </a>
                            </div>
                        </div>








                        <!-------------------------- JOB DESCRIPTION -------------------------------->
                        <!-- Modal -->

                          <div class="modal fade" id="myModalEmailMarketing" role="dialog">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">

                                        <h3 class="modal-title ml-3"> Email Marketing Executive </h3>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class=" p-3 bg-color-box">
                                            <div class="">
                                                <div class="col-12 text-b">
                                                    <h4 class="pb-5 text-center text-uppercase">JOB DESCRIPTION</h4>
                                                    <label class="text-uppercase">ABOUT US</label>
                                                    <p>A foray to end forgery.</p>
                                                    <p>
                                                        An organization of young but experienced people with a clear mission and objectives, 
                                                       quality standards are an integral part of our business practices and we believe, that 
                                                       these quality standards contribute immensely in the overall performance of the organization.
                                                    </p>
                                                    <p>
                                                        Every person has the right to know whether the product they are buying is genuine or not. 
                                                        We use truly secure and encrypted codes printed on the labels of the product which are impossible to 
                                                        replicate. With the help of secure mobile/web tools, the authenticity of the product can be checked
                                                    </p>
                                                    <label class="text-uppercase">POSITION: Email Marketing Executive (4+ Years)</label><br />
                                                    <label class="text-uppercase">Location: Gurgaon Sector 74A</label><br />
                                                    <label class="text-uppercase">KEY RESPONSIBILITIES:</label>
                                                    <ul>
                                                        <li>Experimenting and tweaking email content as needed</li>
                                                        <li>Setting up different workflows</li>
                                                        <li>Segmenting email lists to optimize campaigns</li>
                                                        <li>Optimizing email sign-ups and opt-ins</li>
                                                        <li>Supporting digital marketing efforts</li>
                                                        <li>Conducting email research to understand prevalent customer behaviour</li>
                                                        <li>Analyze the previous campaigns to discover the areas of strength and weaknesses which could inform subsequent outputs</li>
                                                        <li>Developing a well-written copy that is free from errors</li>
                                                        <li>Maintaining a database of customers who have opted to receive correspondence</li>
                                                        <li>Guaranteeing the design and layouts of emails are optimized, mobile, and user friendly</li>
                                                        <li>Proofreading key messages in and out of email templates</li>
                                                        <li>Sending graphics requests to designers</li>
                                                        <li>Managing, Compiling & eliminating email lists</li>
                                                        <li>Securing email databases for future campaigns</li>
                                                        <li>Follow up on emails</li>
                                                        <li>Placing product orders</li>
                                                        <li>Creating digital ads</li>
                                                        <li>Tracking and analyzing campaign results</li>
                                                        <li>Aiding additional digital marketing efforts</li>
                                                        <li>Gathering insights into the audience</li>
                                                        <li>Conceptualizing marketing campaigns that speak directly to the main point of existing and potential clientele</li>


                                                    </ul>
                                                    <label class="text-uppercase">QUALIFICATION AND SKILLS REQUIRED:</label>
                                                    <ul>
                                                        <li>A bachelor’s degree in marketing management, Communication, Advertising, or a similar role</li>
                                                        <li>Proven experience in n creating impactful and unique marketing campaigns</li>
                                                        <li>Past database management experience, preferably in a similar role</li>
                                                        <li>Familiarity with pertinent automation and performance evaluation software</li>
                                                        <li>Excellent project management skills specific to marketing</li>
                                                        <li>Outstanding copyediting and copywriting skills</li>
                                                        <li>Ability to harness collaboration to produce a well-crafted content</li>
                                                        <li>Drive, ingenuity, and gumption</li>
                                                        <li>Willingness to work extended hours as the need arises</li>
                                                        <li>Knowledge of digital marketing and IT</li>
                                                        <li>Ability to multi-task</li>
                                                    </ul>

                                                    <label class="text-uppercase">EXPERIENCE REQUIRED:</label>
                                                    <ul>
                                                        <li>Learn the ways to stay updated with trends. </li>
                                                        <li>Work on real-time projects.</li>
                                                        <li>The candidates should be able to work & coordinate with teams.</li>
                                                    </ul>

                                                    <div class="row">
                                                        <div class="col-12 website">
                                                            <label>COMPANY’S WEBSITE:</label>
                                                            <a href="https://www.vcqru.com/" style="color:#333; font-size:18px; ">www.vcqru.com</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 mt-3">
                                         
                                            <a href="javascript:void(0);" class="btn-apply data-bs-toggle= oppeningApply" data-bs-toggle="modal" data-bs-target="#applyform" data-name="Email Marketing Executive">Apply</a>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                       
                                    </div>
                                </div>
                            </div>
                        </div>



                      <%--  <div class="modal fade" id="myModalCloudAdmin" role="dialog">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">

                                        <h3 class="modal-title m-auto">CLOUD ADMIN</h3>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class=" p-3 bg-color-box">
                                            <div class="">
                                                <div class="col-12 text-b">
                                                    <h4 class="pb-5 text-center text-uppercase">JOB DESCRIPTION</h4>
                                                    <label class="text-uppercase">POSITION: Cloud Admin (4+ Years)</label><br />
                                                    <label class="text-uppercase">Location: Gurgaon Sector 74A</label><br />
                                                    <label class="text-uppercase">KEY RESPONSIBILITIES:</label>
                                                    <ul>
                                                        <li>Good skills in Microsoft Azure.</li>
                                                        <li>Domain knowledge about Storage, Network, Compute, Hypervisor, Security etc. from Market leading vendors.</li>
                                                        <li>Demonstrated application of end-to-end architecture strategies, standards, processes, and tools in their solution designs.</li>
                                                        <li>Lead efforts to design and build automation in the areas of application deployment, configuration management, release operations, on demand resource adjustments etc.</li>


                                                    </ul>
                                                    <label class="text-uppercase">Technical Skills</label>
                                                    <ul>
                                                        <li>Azure Cloud Native Security Domain Skills.</li>
                                                        <li>Nice to have skills Technical Skills-, Azure Domain Skills.</li>
                                                        <li>Technology Infrastructure Services.</li>
                                                        <li>3 years’ project experience deploying cloud solutions: Microsoft Azure.</li>
                                                        <li>Practical experience sizing hardware and storage needs and other resources on cloud deployment.</li>
                                                        <li>Good written, verbal communication and presentation skills Proven knowledge of networking concepts and services for security, reliability and scalability.</li>
                                                        <li>Knowledge around security best practices and understanding of vulnerability assessments Ability to create, deploy and manage Azure VNET, Security groups, NSGs and AWS services such as EC2, Cloud Formations.</li>
                                                        <li>Ability to develop procedure documents and maintain detailed cloud deployments related.</li>
                                                        <li>Hands-on experience with a breadth of technologies across operating systems, application servers, database and middleware infrastructure.</li>
                                                        <li>Knowledge of .net framework with SQL and Visual Studio.</li>
                                                        <li>Knowledge of Version control e.g. github and bit bucket.</li>
                                                    </ul>

                                                    <div class="row">
                                                        <div class="col-12 website">
                                                            <label>COMPANY’S WEBSITE:</label>
                                                            <a href="https://www.vcqru.com/" style="color:#333; font-size:18px; ">www.vcqru.com</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-12 mt-3">
                                         
                                            <a href="javascript:void(0);" class="btn-apply data-bs-toggle= oppeningApply" data-bs-toggle="modal" data-bs-target="#applyform" data-name="Cloud Admin">Apply</a>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                       
                                    </div>
                                </div>
                            </div>
                        </div>--%>




                        <div class="modal fade" id="myModalSupport" role="dialog">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">

                                        <h3 class="modal-title m-auto">CUSTOMER SUPPORT</h3>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class=" p-3 bg-color-box" id="">
                                            <div class="col-12 text-b">
                                                <h4 class="pb-5 text-center text-uppercase">JOB DESCRIPTION</h4>
                                                <label class="text-uppercase">POSITION: Customer Support Executive (0-2 Years)</label><br />
                                                <label class="text-uppercase">Location: Gurgaon Sector 74A</label><br />
                                                <label class="text-uppercase">Language- Kannada, Tamil, Telugu, Odia, Marathi(2 Opening for Each Language)</label>
                                                <label class="text-uppercase">Responsibilities</label>
                                                <ul>
                                                    <li>Resolving customer complaints brought to your attention.</li>
                                                    <li>Possessing excellent product knowledge to enhance customer support.</li>
                                                    <li>Following up with customers for any further information.</li>
                                                    <li>Answer phone calls more professionally and provide information about products and services as required by the callers.</li>
                                                    <li>Keep records of interactions and transactions of customers; keep a record of details of customer complaints, inquiries, and comments.</li>

                                                </ul>
                                                <label class="text-uppercase">Requirements & Skills</label>
                                                <ul>
                                                    <li>A bachelor’s degree in administration or a related field.</li>
                                                    <li>Freshers can also apply.</li>
                                                    <li>Excellent interpersonal and written and oral communication skills.</li>
                                                    <li>Knowledge of CRM systems.</li>
                                                    <li>Basic word & excel knowledge is required.</li>

                                                </ul>

                                                <div class="row">
                                                    <div class="col-12 website">
                                                        <label>COMPANY’S WEBSITE:</label>
                                                        <a href="https://www.vcqru.com/" style="color:#333; font-size:18px; ">www.vcqru.com</a>
                                                    </div>

                                                </div>
                                            </div>


                                            <div class="row">
                                                <div class="col-12 mt-5">
                                                   
                                                    
                                                        <a href="javascript:void(0);" class="btn-apply data-bs-toggle= oppeningApply" data-bs-toggle="modal" data-bs-target="#applyform" data-name="Customer Support">Apply</a>
</div>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                       
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal fade" id="myModalContentWriter" role="dialog">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">

                                        <h3 class="modal-title m-auto">Content Writer</h3>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class=" p-3 bg-color-box" id="">
                                            <div class="col-12 text-b">
                                                <h4 class="pb-5 text-center text-uppercase">JOB DESCRIPTION</h4>
                                                <label class="text-uppercase">POSITION: Customer Support Executive (0-4 Years)</label><br />
                                                <label class="text-uppercase">Location: Gurgaon Sector 74A</label><br />
                                                <label class="text-uppercase">KEY RESPONSIBILITIES:</label>
                                                <ul>
                                                    <li>Conducting in-depth research on industry-related topics in order to develop original content.</li>
                                                    <li>Developing content for blogs, articles, product descriptions, social media, and the company website.</li>
                                                    <li>Assisting the marketing team in developing content for advertising campaigns.</li>
                                                    <li>Proofreading content for errors and inconsistencies.</li>
                                                    <li>Editing and polishing existing content to improve readability.</li>
                                                    <li>Creating compelling headlines and body copy that will capture the attention of the target audience.</li>
                                                    <li>Regularly produce various content types, including email, social media posts, blogs and white papers.</li>

                                                </ul>
                                                <label class="text-uppercase">QUALIFICATION AND SKILLS REQUIRED:</label>
                                                <ul>
                                                    <li>Bachelor's degree.</li>
                                                    <li>Proficient in all Microsoft Office applications.</li>
                                                    <li>A portfolio of published articles.</li>
                                                    <li>Excellent writing and editing skills.</li>
                                                    <li>The ability to work in a fast-paced environment.</li>
                                                    <li>The ability to handle multiple projects concurrently.</li>
                                                    <li>Effective communication skills.</li>

                                                </ul>

                                                <div class="row">
                                                    <div class="col-12 website">
                                                        <label>COMPANY’S WEBSITE:</label>
                                                        <a href="https://www.vcqru.com/" style="color:#333; font-size:18px; ">www.vcqru.com</a>
                                                    </div>

                                                </div>
                                            </div>


                                            <div class="row">
                                                <div class="col-12 mt-5">
                                                   
                                                    <a href="javascript:void(0);" class="btn-apply data-bs-toggle= oppeningApply" data-bs-toggle="modal" data-bs-target="#applyform" data-name="Content Writer"> Apply</a>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                       
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal fade" id="myModalDotNet" role="dialog">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">

                                        <h3 class="modal-title m-auto">DOT NET DEVELOPER</h3>
                                        <%--@*<button type="button" class="close" data-dismiss="modal">&times;</button>*@--%>
                                    </div>
                                    <div class="modal-body">
                                        <div class=" p-3 bg-color-box" id="">
                                            <div class="">
                                                <div class="col-12 text-b">
                                                    <h4 class="pb-5 text-center text-uppercase">JOB DESCRIPTION</h4>
                                                    <label class="text-uppercase">POSITION: Dot Net developer (4+ Years)</label><br />
                                                    <label class="text-uppercase">Location: Gurgaon Sector 74A</label><br />
                                                    <label class="text-uppercase">KEY RESPONSIBILITIES:</label>
                                                    <ul>
                                                        <li>Must have Strong OOPS (Object Oriented Programming Principles) in C# language.</li>
                                                        <li>Mandatory to have Experience in Asp.Net MVC, Entity framework.</li>
                                                        <li>Experience knowledge in LINQ queries.</li>
                                                        <li>Must know jQuery, and JavaScript language client-side programming.</li>
                                                        <li>Know about Responsive Application UI like bootstrap.</li>
                                                        <li>Knowledge of Microsoft SQL Server database.</li>


                                                    </ul>
                                                    <label class="text-uppercase">EXPERIENCE AND SKILLS REQUIRED</label>
                                                    <ul>
                                                        <li>Good knowledge of MVC Asp.net with C#.</li>
                                                        <li>Must have worked on MVC architecture.</li>
                                                        <li>Must have worked on LINQ, three-tier architecture.</li>
                                                        <li>Must have knowledge of the OOPS concept.</li>
                                                        <li>Good knowledge of SQL Server 2012 / 2014 / 2016.</li>
                                                        <li>Good knowledge of AJAX.</li>
                                                        <li>Knowledge of JavaScript, JQuery and Json/XML parsing.</li>
                                                        <li>Knowledge of API and web services will be preferred.</li>
                                                        <li>Knowledge of Microsoft SQL Server database.</li>
                                                        <li>A technical Certificate is mandatory.</li>

                                                    </ul>

                                                    <div class="row">
                                                        <div class="col-12 website">
                                                            <label>COMPANY’S WEBSITE:</label>
                                                            <a href="https://www.vcqru.com/" style="color:#333; font-size:18px; ">www.vcqru.com</a>
                                                        </div>
                                                    </div>
                                                </div>
                                            </div>
                                            <div class="col-12 mt-3">
                                               <%-- @* <a href="#" class="button align-center btn-apply oppeningApply" data-toggle="modal" data-target="#applyform" data-name="Dot Net Developer">Apply</a>*@--%>
                                                <a href="javascript:void(0);" class="btn-apply data-bs-toggle= oppeningApply" data-bs-toggle="modal" data-bs-target="#applyform" data-name="Dot Net Developer"> Apply</a>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                       <%--@* <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>*@--%>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal fade" id="myModelLead" role="dialog">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">

                                        <h3 class="modal-title m-auto">LEAD GENERATIOJN</h3>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class=" p-3 bg-color-box" id="">
                                            <div class="col-12 text-b">
                                                <h4 class="pb-5 text-center">JOB DESCRIPTION</h4>
                                                <label class="text-uppercase">POSITION: Lead Generation (0-3 Years)</label><br />
                                                <label class="text-uppercase">Location: Gurgaon Sector 74A</label>
                                                <label class="text-uppercase">KEY RESPONSIBILITIES:</label>
                                                <ul>
                                                    <li>Research, track, maintain and update leads.</li>
                                                    <li>Make outgoing calls to develop new business.</li>
                                                    <li>Contact prospects to qualify leads.</li>
                                                    <li>Direct email marketing to key clients and prospects.</li>
                                                    <li>Conduct customer research.</li>
                                                    <li>Conduct client or market surveys to obtain information about potential leads.</li>
                                                    <li>Participate in the preparation of proposals and/or sales presentations.</li>
                                                    <li>Provide accurate and timely information to management.</li>
                                                    <li>Develop a strong knowledge of the company’s products and services in order to facilitate the sales process.</li>

                                                </ul>
                                                <label class="text-uppercase">SKILLS REQUIRED:</label>
                                                <ul>
                                                    <li>Excellent English communication (verbal and written).</li>
                                                    <li>Experience with cold calling.</li>
                                                    <li>Experience with research and maintaining databases.</li>
                                                    <li>Proficient in MS Office including Word, Excel, and Outlook.</li>
                                                    <li>Experience in using CRM.</li>
                                                    <li>Strong project and time management skills.</li>
                                                </ul>
                                                <label class="text-uppercase">QUALIFICATIONS / EXPERIENCE REQUIRED: </label>
                                                <ul>
                                                    <li>Bachelor’s degree in any field.</li>
                                                    <li>Experience in sales or relevant field.</li>
                                                </ul>
                                                <div class="row">
                                                    <div class="col-12 website">
                                                        <label class="text-uppercase">COMPANY’S WEBSITE:</label>
                                                        <a href="https://www.vcqru.com/">www.vcqru.com</a>
                                                    </div>

                                                </div>
                                            </div>


                                            <div class="row">
                                                <div class="col-12 mt-5">
                                                   <%-- @* <a href="#" class="button btn-apply oppeningApply" data-toggle="modal" data-target="#applyform" data-name="Lead Generation">Apply</a>*@--%>
                                                    <a href="javascript:void(0);" class="btn-apply data-bs-toggle= oppeningApply" data-bs-toggle="modal" data-bs-target="#applyform" data-name="Lead Generation"> Apply</a>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                      <%--  @*<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>*@--%>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="modal fade" id="myModalBDM" role="dialog">
                            <div class="modal-dialog modal-lg">
                                <div class="modal-content">
                                    <div class="modal-header">

                                        <h3 class="modal-title m-auto">BUSINESS DEVELOPMENT MANAGER</h3>
                                        <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
                                    </div>
                                    <div class="modal-body">
                                        <div class=" p-3 bg-color-box" id="">
                                            <div class="col-12 text-b">
                                                <h4 class="pb-5 text-center text-uppercase">JOB DESCRIPTION</h4>
                                                <label class="text-uppercase">POSITION: BUSINESS DEVELOPMENT MANAGER (2-5 Years)</label><br />
                                                <label class="text-uppercase">Location: Gurgaon Sector 74A</label>
                                                <label class="text-uppercase">KEY RESPONSIBILITIES:</label>
                                                <ul>
                                                    <li>Develop a growth strategy focused both on financial gain and customer satisfaction.</li>
                                                    <li>Conduct research to identify new markets and customer needs.</li>
                                                    <li>Arrange business meetings with prospective clients.</li>
                                                    <li>Promote the company’s products/services addressing or predicting clients’ objectives.</li>
                                                    <li>Keep records of sales, revenue, invoices etc.</li>
                                                    <li>Provide trustworthy feedback and after-sales support.</li>
                                                    <li>Build long-term relationships with new and existing customers.</li>
                                                </ul>
                                                <label class="text-uppercase">Responsibilities</label>
                                                <ul>
                                                    <li>Identify company and contact information via LinkedIn, company websites, internet searches, and press articles using a variety of tools and technology.</li>
                                                    <li>Filter and clean lists of prospect data based on persona details.</li>
                                                    <li>Work on converting the right business opportunity/lead to an appointment for the client.</li>
                                                    <li>Call & follow up with leads who have been contacted in the past.</li>
                                                    <li>Work with other employees to get prospecting information.</li>
                                                    <li>Maintain and expand your database of prospects.</li>
                                                    <li>Continue to build, validate and maintain data on a periodic basis to refine outreach.</li>

                                                </ul>
                                                <label class="text-uppercase">Requirements and skills</label>
                                                <ul>
                                                    <li>Proven working experience as a business development manager, sales executive or a relevant role.</li>
                                                    <li>Proven sales track record.</li>
                                                    <li>Experience in customer support is a plus.</li>
                                                    <li>Proficiency in English.</li>
                                                    <li>Market knowledge.</li>
                                                    <li>Communication and negotiation skills.</li>
                                                    <li>Ability to build rapport.</li>
                                                    <li>Time management and planning skills.</li>

                                                </ul>
                                                <label class="text-uppercase">Qualifications / experience required:</label>
                                                <ul>
                                                    <li>Bachelor’s degree in any field.</li>
                                                    <li>2-5year(s) of experience in sales or relevant field.</li>
                                                </ul>
                                                <div class="row">
                                                    <div class="col-12 website">
                                                        <label>COMPANY’S WEBSITE:</label>
                                                        <a href="https://www.vcqru.com/" style="color:#333; font-size:18px; ">www.vcqru.com</a>
                                                    </div>
                                                </div>
                                            </div>



                                            <div class="row">
                                                <div class="col-12 mt-5">
                                                  <%--  @* <a href="#" class="button align-center btn-apply oppeningApply" data-toggle="modal" data-target="#applyform" data-name="BUSINESS DEVELOPMENT MANAGER">Apply</a>*@--%>
                                                    <a href="javascript:void(0);" class="btn-apply data-bs-toggle= oppeningApply" data-bs-toggle="modal" data-bs-target="#applyform" data-name="BUSINESS DEVELOPMENT MANAGER" > Apply</a>
                                                </div>
                                            </div>

                                        </div>
                                    </div>
                                    <div class="modal-footer">
                                        <%--@*<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>*@--%>
                                    </div>
                                </div>
                            </div>
                        </div>














                        <!-------------------------- JOB DESCRIPTION End -------------------------------->

                        <div class="modal fade" id="applyform" tabindex="-1" role="dialog" aria-labelledby="android-dev" aria-hidden="true">
                            <div class="modal-dialog" role="document">
                                <div class="modal-content">
                                    <div class="modal-header">
                                        <h3 class="modal-title" id="jobHeadding">Fill Form</h3>
                                    </div>
                                    <div class="modal-body p-3">
                                        <form method="post" class="career-submit">
                                            <div class="row pb-2">
                                                <div class="col-12">
                                                    <label>Candidate Name *</label>
                                                    <input type="hidden" name="" id="jobtype" runat="server" value="" class="jobtype" />
                                                    <input type="text" id="cname" runat="server" placeholder="Candidate Name" maxlength="50" minlength="3" class="form-control cname" required="required" oninput="this.value = this.value.replace(/[^a-zA-Z ]/g, '').replace(/(\..*)\./g, '$1');" />
                                                </div>
                                            </div>
                                            <div class="row pb-2">
                                                <div class="col-12">
                                                    <label>Email ID *</label>
                                                    <input type="text" id="cemail" runat="server" placeholder="Email ID" class="form-control cemail" required="required" />
                                                </div>
                                            </div>
                                            <div class="row pb-2">
                                                <div class="col-12">
                                                    <label>Contact Number *</label>
                                                    <input type="text" id="cmobile" runat="server" maxlength="10" minlength="10" pattern="[0-9]{10}" placeholder="Contact Number" class="form-control cmobile" required="required" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
                                                </div>
                                            </div>
                                            <div class="row pb-2">
                                                <div class="col-12">
                                                    <label>Upload Resume *</label>
                                                     <asp:FileUpload id="resumefile" runat="server" class="form-control img_bill" onchange="imagepreview(this)" required="required" />
                                                   <%-- <input type="file" id="resumefile" name="filename" class=" " onchange="imagepreview(this)" required="required">--%>

                                                </div>
                                            </div>
                                            <div class="row pb-2">
                                                <label id="lbl_carrer"></label>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="modal-footer">

                                        
                                        <button type="button" class=" btn btn-secondary" data-backdrop="false" data-bs-dismiss="modal">Close</button>
                                        <%--<button type="button" ID="btnSave" OnClick="sendcquery()" class=" btn btn-primary" data-dismiss="modal">Submit</button>--%>
                                         <asp:Button ID="btnSave" OnClientClick="sendcquery()" OnClick="btnSave_Click" Text="Submit" CssClass="btn btn-primary" runat="server" />
                                       

                                    </div>
                                    <label id="lblNameProcess" class="text-danger"></label>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
            </div>




            <div class="row pb-5">
                <div class="col-12">
                    <p>
                        <b>Flexible Work Arrangements:</b> Embrace flexible work hours or remote work options, 
                        allowing employees to have a better work-life balance and accommodate their personal needs while maintaining productivity.

                    </p>
                    <p>
                        <b>Employee Development and Growth:</b> Establish a culture of continuous learning and professional development by providing 
                        training programs, workshops, and opportunities for employees to enhance their skills and advance in their careers.

                    </p>
                    <p>
                        <b>Collaboration and Communication: </b>  Encourage open and transparent communication channels, fostering collaboration among team members, departments, and management levels. Utilize digital collaboration tools and platforms to enhance communication efficiency.

                    </p>
                    <p><b>Workload and Work-Life Balance:</b> Set realistic work expectations and ensure employees have manageable workloads. Promote a healthy work-life balance by discouraging excessive overtime and encouraging time off and vacation usage.</p>
                    <p><b>Diversity and Inclusion:</b> Emphasize the importance of diversity and inclusion in the workplace, promoting an environment where employees from different backgrounds feel respected, valued, and included.</p>
                    <p><b>Recognition and Rewards:</b> Implement a system for recognizing and rewarding employees' achievements and contributions, whether through monetary incentives, performance-based bonuses, or public acknowledgments.

                    </p>
                    <p><b>Health and Well-being:</b> 
                         Prioritize employee well-being by providing access to wellness programs, mental health resources, ergonomic workstations, and promoting a healthy lifestyle.
                    </p>
                    <p><b>Clear Policies and Guidelines:</b> Establish clear guidelines and policies regarding expected behavior, performance expectations, code of conduct, data security, and confidentiality to ensure a harmonious and secure work environment. 

                    </p>
                    <p>
                        <b>Regular Feedback and Performance Evaluations:</b> Implement a structured performance evaluation process that includes regular feedback sessions, goal-setting, and constructive feedback to help employees grow and improve.
                    </p>
                    <p>
                        <b>Workforce Engagement and Social Activities:</b>  Foster employee engagement through team-building activities, social events, and opportunities for employees to connect with one another beyond work tasks.
                    </p>
                </div>
            </div>


        </div>

    </section>

    <script>
        // Use event delegation to listen to events from the buttons
        $(document).on('click', 'button', handleClick)

        function handleClick() {

            // Grab the id from the button
            const id = $(this).data('id');

            // Remove all the `show` classes from the details elements
            $('.details').removeClass('show');

            // And then add that class back on to the details element
            // that corresponds to the id
            $(`.details[data-id=${id}]`).addClass('show');
        }



        $('.oppeningApply').click(function () {
            $("#myModal").modal('hide');
            //alert($(this).data('name'));
            // $('.hiddenid').val($(this).data('id'));           
            $('#jobHeadding').html($(this).data('name'));
            $('.jobtype').val($(this).data('name'));
            //$('.global_access').val($(this).data('global_access')); 
            //// $('.pull-left').html($(this).attr('data-globalaccess'));
            //$('.position').val($(this).data('position'));
            // $('.add_description').val($(this).data('description'));
            // $('.oldimgpth').val($(this).data('featureimg'));
            //  imgurl = $(this).attr('data-featureimg');
            //alert(imgurl);
            // imglogopath = "https://stickerscdn.ams3.cdn.digitaloceanspaces.com/uploadpack/" + imgurl;
            //  logofullpath = "<img src='" + imglogopath + "' width='100'>";
            // $('#PreviewSingleimg').html(logofullpath);
        });
    </script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.3.1/jquery.min.js"></script>
</asp:Content>