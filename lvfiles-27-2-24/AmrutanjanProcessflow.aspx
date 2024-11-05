<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AmrutanjanProcessflow.aspx.cs" Inherits="AmrutanjanProcessflow" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Process Flow</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
    <form id="form1" runat="server">

        <section>
  <div class="container">
    <div class="row">
      <div class="col-md-2">
          <figure class="logo"><img src="images/Amrutanjan/image/logo-new.png" class="img-fluid"></figure>
      </div>
       <div class="col-md-9 img1-center">
          <figure><img src="images/Amrutanjan/image/profile.png" style="width:70%" class="img-fluid"></figure>
      </div>

    </div>

    
    <div class="row">
      <div class="col-md-12">
         <h4 class="pera"><b>PROCESS FLOW</b> </h4></div>
         <div class="col-md-12 my-3">
          <!--<figure class="banner mt-5"><img src="image/heading.png" class="img-fluid banner"></figure>-->
          <hr class="line">

          <button class="banner-1"><a href=""><b>OBJECTIVE</b></a></button></div>
          <div class="col-md-12">
             <p class="pargraph text-justify">To run a customer loyalty program with existing QR codes, so that maximum people purchase the products and lucky consumers get exciting gifts.</p>
            </div>

            <div class="col-md-12 my-3">
          <!--<figure class="banner mt-5"><img src="image/heading.png" class="img-fluid banner"></figure>-->
          <hr class="line">
          <button class="banner-1"><a href=""><b>PROPOSED SOLUTION</b></a></button></div>
          <div class="col-md-12">
             <p class="pargraph text-justify">We will run the Amrutanjan 8ml contest by using two different ways through which users can take part in the contest : 
            • QR Code Scan      • Missed Call
</p>
            </div>
      
    </div>
	
	<div class="row">
   <div class="col-md-12 col-12">
        <h1 class="yellow" style="color: #ff6b00;padding-top: 20px;">Qr Code Scan</h1>
            <figure><img src="images/Amrutanjan/image/QR SCAN.png" style="margin-top:3%"class="img-fluid dextop-view"></figure>
           
        </div>

    </div>
	
	<div class="container">
        <div class="row">
            <h1 class="yellow">Missed Call</h1>
            
                
                <h3 class="call">Give a Missed call to <b>9798134134</b></h3>
        </div>

    </div>


    <div class="container">
        <div class="row">
            <div class="background-button my-5">
                    <h1>TOGETHER, LET' MAKE THE CONTEST A HUGE SUCCESS </h1>
            </div>
        </div>

    </div>
	
	

    <div class="row text-center">
      <!--div class="col-12">
          <figure><img src="image/3.png" style="width: 100%;margin-top:-45%;" class="img-fluid"></figure>
</div-->
     
    

    </div>
  </div>
</section>
    </form>


<style type="text/css">



 .img1-center
 {
   text-align:center;
 }


  .logo
  {
    width: 79%;
    margin-top: 25%;

  }
  
section
{
 background-image: url(./images/Amrutanjan/image/winnerpage.jpg);
 width:100%;
 height:100vh;
 display:table;
 margin: auto;
 background-repeat: no-repeat;
 background-size: cover;
}

.prize
{
  text-align: center;
}

.scooter-button
{
  width: 50%;
  border: none;
  background: #ede2e2;
  padding: 3px 7px;
  border-radius: 50px;
  color: #030e99;
  font-size: 30px;
  box-shadow: 0px 6px 4px 0px #443f3f;
}


@media screen and (max-width:768px){

   .logo
   {
      text-align: center;
    margin-left: 10%;
    margin-bottom: 40px;   
	}
	
	
	.pera
{
  
	margin-top:20px !important;;
}
	
}

.pera
{
  font-size: 37px;
    color: #ff6b00;
    padding-bottom: 20px;
	margin-top:-30px;
}
.heading
{
  font-size: 22px;
}

.pargraph
{
  font-size: 22px;
}

/* end flow chart css */

.line hr
{
    position: relative;
    
}

.banner-1
{
    position:relative;
    top: -43px;
    padding: 10px 20px;
    background: #ff6b00; 
    border: none;
    border-radius: 20px;
    font-size: 24px;
}

a {
    color: #fff;
    text-decoration: underline;
	}
 
  .background-button
  {
    text-align: center;
    background: #ff6b00;
    border-radius: 30px;
	color:#fff;
  }
 .call
{
    font-size: 21px;
}


.yellow
{ 
   color:#ff6b00;
}

</style>

</body>
</html>
