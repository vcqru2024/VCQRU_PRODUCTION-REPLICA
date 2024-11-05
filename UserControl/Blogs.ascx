<%@ Control Language="C#" AutoEventWireup="true" CodeFile="Blogs.ascx.cs" Inherits="UserControl_Blogs" %>

<link href="https://code.jquery.com/ui/1.10.4/themes/ui-lightness/jquery-ui.css"
        rel="stylesheet" />
    <%--<script src="https://code.jquery.com/jquery-1.10.2.js"></script>--%>
    <script src="https://code.jquery.com/ui/1.10.4/jquery-ui.js"></script>

   <%-- <script>
        $(function () {
            $("#accordion-1").accordion();
        });
    </script>

    <style>
        #accordion-1 {
            font-size: 14px;
        }

        a:focus, a:hover {
            text-decoration: none;
        }

        .ui-widget-content {
            background: #eeeeee url("images/ui-bg_highlight-soft_100_eeeeee_1x100.png") no-repeat scroll 50% top !important;
            border: 1px solid #dddddd;
            color: #333333;
        }

        .ui-accordion-accordionspan {
            float: right;
        }
    </style>--%>
<div class="about_grid" style="padding: 1em 0 !important;">
        <div class="container" id="accord">
          <%--  <h4 class="tz-title-4 tzcolor-blue">
                <p>
                    Frequently Asked Questions (FAQ's)
                </p>
            </h4>--%>
          <h2 class="font-weight-semibold mb-0">Blogs</h2>
           <hr />
            <div id="accordion-1">
                <%=sbnews.ToString() %>
            </div>


            
        </div>
        </div>