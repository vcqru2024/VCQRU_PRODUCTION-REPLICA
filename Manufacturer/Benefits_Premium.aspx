<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="Benefits_Premium.aspx.cs"
    Inherits="Benefits_Premium" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
     <style type="text/css">
        /*.list_text > li {
    list-style: outside none square;
    margin-left: 16px;
    line-height:30px;
}*/
        ul.list_text li {
            background: rgba(0, 0, 0, 0) url("/images/arrow_black.png") no-repeat scroll left 17px;
            border: medium none;
            color: #333;
            font-family: Arial,Helvetica,sans-serif;
            font-size: 15px;
            line-height: 40px;
            margin-bottom: 5px;
            padding: 0 0 0 20px;
            text-align: justify;
            text-shadow: none !important;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <div class="col-lg-9">
        <div class="sort-destination-loader sort-destination-loader-showing">
            <div class="row portfolio-list sort-destination" data-sort-id="portfolio">
                <div class="col-lg-12 card card-admin form-wizard profile">
                     <header class="card-header">
                                <h4 class="card-title"><i class="fa fa-membership-square-o"> Premium Membership</i></h4>
                            </header>
                    <div class="card-body card-body-nopadding">
                         <div class="form-row">
                             <div class="form-group col-lg-12">
                                    <ul class="list_text">
                                         <li>Statistics related to customer's buying habits and loyalty of consumers shall be</li>
                            <li>You will receive authentic data regarding counterfeit products. </li>
                            <li>Saves to regain the brand image tarnished by negative words of mouth publicity.</li>
                            <li>Get help for taking action against closing it. </li>
                                        </ul>
                                 </div>
                             </div>
                        </div>
                    </div>
                </div>
            </div>
         </div>
    <%--<div class="about_grid" style="padding: 1em 0 !important;">
        <div class="container">
            <h4 class="tz-title-4 tzcolor-blue">
                <p class="tzweight_Bold">
                    Benefits for Premium Membership
                </p>
            </h4>
            <div class="blog">
                <div class="blog_top">
                    <p>
                        <ul class="list_text" >
                            <li>Statistics related to customer's buying habits and loyalty of consumers shall be
                    provided .</li>
                            <li>You will receive authentic data regarding counterfeit products.</li>
                            <li>Get help for taking action against closing it.</li>
                        </ul>
                    </p>
                </div>
            </div>
        </div>
    </div>--%>
</asp:Content>
