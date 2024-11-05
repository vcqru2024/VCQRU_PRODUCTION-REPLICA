<%@ Page Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="Faqs.aspx.cs"
    Inherits="Faqs" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
    <style type="text/css">
        /*.list_text > li {
    list-style: outside none square;
    margin-left: 16px;
    line-height:30px;
}*/
        ul.list_text li {
            background: rgba(0, 0, 0, 0) url("/images/arrow_black.png") no-repeat scroll left 7px;
            border: medium none;
            color: #333;
            font-family: Arial,Helvetica,sans-serif;
            font-size: 15px;
            line-height: 25px;
            margin-bottom: 5px;
            padding: 0 0 0 15px;
            text-align: justify;
            text-shadow: none !important;
        }

        .panel-title {
        color:#fff;
        }
        
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
     <div class="col-lg-9">

        <div class="sort-destination-loader sort-destination-loader-showing">
            <div class="row portfolio-list sort-destination" data-sort-id="portfolio">
                <div class="col-lg-12 card card-admin form-wizard profile">
                     <header class="card-header">
                                <h4 class="card-title"><i class="fa fa-FAQ-square-o"> Frequently Asked Questions (FAQ's)</i></h4>
                            </header>
                    <div class="card-body card-body-nopadding">
                         <div class="form-row">
                                    <div class="form-group col-lg-12">
                                      Q.1) What is counterfieting?
                                        <br />
                                       A.1) Counterfeiting means replicating/duplicating the original product by unauthorized means to take the price advantage of the original product.
                                        </div>
                             </div>
                         <div class="form-row">
                                    <div class="form-group col-lg-12">
                                        Q.2)What kind of goods can be counterfeited?
                                        <br />
                                        A.2)Counterfeiting can span across many business segments like clothing,  medicines, electronics, footwear and even the food what we eat.
                                        </div>
                             </div>
                         <div class="form-row">
                                    <div class="form-group col-lg-12">
                                        Q.3)What are the consequences of counterfeiting?
                                        <br />
                                        A.3)It is not merely the financial loss to the company but due to duplicity in food and medicines, it’s a loss of health and sometimes life.
                                        </div>
                             </div>
                         <div class="form-row">
                                    <div class="form-group col-lg-12">
                                       Q.4) As a brand owner, why should you care?
                                        <br />
                                       A.4)Counterfeiting is a threat to all business segments, creating a major impact on their profits, reputation and importantly the safety of their customers.


                                        </div>
                             </div>
                        <div class="form-row">
                                    <div class="form-group col-lg-12">
                                       Q.4)How can VCQRU help protect my business?
                                        <br />
                                       A.4)VCQRU is a comprehensive brand protection solutions provider for companies facing loss in revenues due to the presence of counterfeiters. Our expertise lies in detecting and providing the most accurate, concise and brand threat intelligence services with a uniquely personal service approach.


                                        </div>
                             </div>
                        <div class="form-row">
                                    <div class="form-group col-lg-12">
                                       Q.4)How can I integrate your solution with my existing product labels?
                                        <br />
                                       A.4)Our printing experts can help you to embed our alga generated codes with your existing product labels.
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
                <p>
                    Frequently Asked Questions (FAQ's)
                </p>
            </h4>
            <div class="inner_text">
                <div class="blog">
                    <div class="blog_top">
                        <h3>Manufacturer</h3>
                    </div>
                </div>


                <div class="panel-group" id="accordion" role="tablist" aria-multiselectable="true">

                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingOne">
                            <h4 class="panel-title">
                                <a role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseOne" aria-expanded="true" aria-controls="collapseOne">
                                    <i class="more-less glyphicon glyphicon-plus"></i>
                                    What is counterfeit / forged / duplicate /fake / spurious/ pirated product?
                                </a>
                            </h4>
                        </div>
                        <div id="collapseOne" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingOne">
                            <div class="panel-body">
                                <div class="blog">
                                    <div class="blog_top">
                                        <p>
                                            A counterfeit/forged/duplicate/fake/spurious/pirated product in everyday language
                                is the one which has not been manufactured by the authentic manufacturer, but is
                                produced by unscrupulous /dubious manufacturers. These products do not necessarily
                                match with the expected qualities of the original product.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingTwo">
                            <h4 class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseTwo" aria-expanded="false" aria-controls="collapseTwo">
                                    <i class="more-less glyphicon glyphicon-plus"></i>
                                    Why people do counterfeiting / forgery / duplication / faking / spuriousing
                        /piracy ?
                                </a>
                            </h4>
                        </div>
                        <div id="collapseTwo" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingTwo">
                            <div class="panel-body">
                                <div class="blog">
                                    <div class="blog_top">
                                        <p>
                                            A counterfeit/forged/duplicate/fake/spurious/pirated product is made for earning
                                quick illegal profit by illegally selling of popular / hot selling products due
                                to some or all of the following reasons-
                                        </p>
                                        <ul class="list_text">
                                            <li>Saving in production cost due to use of substandard raw materials and substandard
                                    production/manufacturing process.</li>
                                            <li>Saving due to theft of Government taxes and levies.</li>
                                            <li>Saving in cost of transportation and logistics (as these duplicate/fake products
                                    are made generally locally and not in any centralized plant).</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingthree">
                            <h4 class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapsethree" aria-expanded="false" aria-controls="collapseTwo">
                                    <i class="more-less glyphicon glyphicon-plus"></i>
                                    Why people do counterfeiting / forgery / duplication / faking / spuriousing
                        /piracy ?
                                </a>
                            </h4>
                        </div>
                        <div id="collapsethree" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingthree">
                            <div class="panel-body">
                                <div class="blog">
                                    <div class="blog_top">
                                        <p>
                                            A counterfeit/forged/duplicate/fake/spurious/pirated product is made for earning
                                quick illegal profit by illegally selling of popular / hot selling products due
                                to some or all of the following reasons-
                                        </p>
                                        <ul class="list_text">
                                            <li>Saving in production cost due to use of substandard raw materials and substandard
                                    production/manufacturing process.</li>
                                            <li>Saving due to theft of Government taxes and levies.</li>
                                            <li>Saving in cost of transportation and logistics (as these duplicate/fake products
                                    are made generally locally and not in any centralized plant).</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingfour">
                            <h4 class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapsefour" aria-expanded="false" aria-controls="collapseTwo">
                                    <i class="more-less glyphicon glyphicon-plus"></i>
                                    What are the modes or methods of counterfeiting / forgery / duplication
                        / faking / spuriousing /piracy ?
                                </a>
                            </h4>
                        </div>
                        <div id="collapsefour" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingfour">
                            <div class="panel-body">
                                <div class="blog">
                                    <div class="blog_top">
                                        <p>
                                            The modes/methods generally found to be adopted by the manufacturers of fake/duplicate
                                products are as under -
                                        </p>
                                        <ul class="list_text">
                                            <li>Copy the size and shape of the original product.</li>
                                            <li>Copy the size and shape of the original product.</li>
                                            <li>Copy the visible design and pattern of the product packaging by color photocopy/digital
                                    scanning etc.</li>
                                            <li>Copy the distinguishing mark/hologram if any of original product.</li>
                                        </ul>
                                        <p>
                                            With the advancement in digital scanning and copying technology, any type of product
                                packaging design is easy to copy. The fake producers only have to make product containers
                                of similar shape and size or buy the used containers of the same product and paste
                                on it the color copied product label.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingfive">
                            <h4 class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapsefive" aria-expanded="false" aria-controls="collapseTwo">
                                    <i class="more-less glyphicon glyphicon-plus"></i>
                                    What are the strategies adopted so far for tackling this problem so
                        far in India and their limitations?
                                </a>
                            </h4>
                        </div>
                        <div id="collapsefive" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingfive">
                            <div class="panel-body">
                                <div class="blog">
                                    <div class="blog_top">
                                        <p>
                                            <strong>Existing strategies adopted so far-</strong>
                                        </p>
                                        <ul class="list_text">
                                            <li>Frequent change in Product packaging.</li>
                                            <li>Placing /printing distinctive design/mark on product/packaging.</li>
                                            <li>Placing hologram stickers on the product/packaging.</li>
                                            <li>Use of RFID tags on product /packaging.</li>
                                            <li>Random raids in suspected localities to catch sellers / production units of counterfeit
                                    products.</li>
                                        </ul>
                                        <p>
                                            <strong>Limitations of frequent changes in Product packaging-</strong>
                                        </p>
                                        <ul class="list_text">
                                            <li>The additional cost of production due to change in product shape/size/design or
                                    its packaging.</li>
                                            <li>Additional cost in advertisement to inform the consumers about changed packaging.</li>
                                            <li>Consumers can get confused by these frequent changes.</li>
                                        </ul>
                                        <p>
                                            <strong>Placing /printing distinctive design/mark on product/packaging-</strong>
                                        </p>
                                        <ul class="list_text">
                                            <li>It is similar to the first strategy except that it preserves the basic 'picture'
                                    of the product packaging and adds to it additional distinctive marks like changing
                                    the logo , geometrical shapes etc.</li>
                                            <li>It is cheaper and easier in implementation.</li>
                                            <li>Preserves the mental 'picture' of the product in the consumer's mind and hence protects
                                    the brand loyalty.</li>
                                            <li>However it is equally easy for counterfeiters to add these changes in their products/packaging.</li>
                                        </ul>
                                        <p>
                                            <strong>Placing Hologram on product packaging-</strong>
                                        </p>
                                        <ul class="list_text">
                                            <li>Holograms are 3D stickers which are impossible to be exactly replicated.</li>
                                            <li>However, anyone can get similar looking holograms from the market and paste it one
                                    counterfeit product.</li>
                                            <li>The hologram stickers can easily be removed from the used items and pasted on the
                                    new product of the same company.</li>
                                        </ul>
                                        <p>
                                            <strong>Use of RFID tags or other electronically coded /encrypted tags-</strong>
                                        </p>
                                        <ul class="list_text">
                                            <li>This method involves attaching an electronically coded infrared chip in the form
                                    of the tag to the product/ package at the manufacturing units.</li>
                                            <li>The tag needs an appropriate infrared reader to decipher the code.</li>
                                            <li>The RFID reader will not be available to the ordinary purchaser . Hence the purchaser
                                    has to depend upon the sales person for authenticity check of the product.</li>
                                            <li>As the most of counterfeit product sale takes place through the connivance of the
                                    shop owner, this method is not helpful to the ordinary consumer.</li>
                                            <li>These tags are very costly and require an infrared reader at each sales point.</li>
                                            <li>Ordinary layman may find the method too sophisticated to use.</li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingsix">
                            <h4 class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapsesix" aria-expanded="false" aria-controls="collapseTwo">
                                    <i class="more-less glyphicon glyphicon-plus"></i>
                                    What are the industries which will benefit from VCQRU.COM ?
                                </a>
                            </h4>
                        </div>
                        <div id="collapsesix" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingsix">
                            <div class="panel-body">
                                <div class="blog">
                                    <div class="blog_top">
                                        <p>
                                            Whether its consumer goods like medicines, confectioneries, packaged food, soaps,
                                detergents, electrical appliances, switches, cables, electronic goods , laptops,
                                mobile phones, software, hardware, automobiles or industrial goods like machineries,
                                tools, fuel, lubricants and many other things. Whatever your product you can easily
                                use the VCQRU to protect your brand image from the counterfeit products and
                                can maximise the revenue and organisational profit.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingseven">
                            <h4 class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseseven" aria-expanded="false" aria-controls="collapseTwo">
                                    <i class="more-less glyphicon glyphicon-plus"></i>
                                    What are the limitations of VCQRU.COM ?
                                </a>
                            </h4>
                        </div>
                        <div id="collapseseven" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingseven">
                            <div class="panel-body">
                                <div class="blog">
                                    <div class="blog_top">
                                        <p>
                                            In a hypothetical case where a person buys a genuine product and then replaces its
                                content with spurious material without tampering the VCQRU stickers, it may
                                not be fully effective. However, this is not commercially viable as the cost of
                                production of one product will be more than the cost of the actual genuine product.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingeight">
                            <h4 class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapseeight" aria-expanded="false" aria-controls="collapseTwo">
                                    <i class="more-less glyphicon glyphicon-plus"></i>
                                    What are the charges of using VCQRU.COM?
                                </a>
                            </h4>
                        </div>
                        <div id="collapseeight" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingeight">
                            <div class="panel-body">
                                <div class="blog">
                                    <div class="blog_top">
                                        <p>
                                            The charges are very nominal and are a fraction of your production cost. For exact
                                cost for your specific product , kindly contact on our customer service cell.
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="panel panel-default">
                        <div class="panel-heading" role="tab" id="headingnine">
                            <h4 class="panel-title">
                                <a class="collapsed" role="button" data-toggle="collapse" data-parent="#accordion" href="#collapsenine" aria-expanded="false" aria-controls="collapseTwo">
                                    <i class="more-less glyphicon glyphicon-plus"></i>
                                    How to become a member of VCQRU clubs?
                                </a>
                            </h4>
                        </div>
                        <div id="collapsenine" class="panel-collapse collapse" role="tabpanel" aria-labelledby="headingnine">
                            <div class="panel-body">
                                <div class="blog">
                                    <div class="blog_top">
                                        <p>
                                            Simply fill the registration form on www.VCQRU.com
                                        </p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                  
                </div>

            </div>
        </div>
    </div>--%>
</asp:Content>
