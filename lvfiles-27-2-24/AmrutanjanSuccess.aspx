<%@ Page Language="C#" AutoEventWireup="true" CodeFile="AmrutanjanSuccess.aspx.cs" Inherits="AmrutanjanSuccess" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Success</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
   <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/css/bootstrap.min.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
</head>
<body>

    <form id="form1" runat="server">

        <section>
  <div class="container">
    <div class="row">
      <div class="col-md-2">
          <figure class="logo"><img src="images/Amrutanjan/image/logo.png" class="img-fluid"></figure>
      </div>
      
        <asp:HiddenField ID="hfproductId" runat="server" />
    </div>
</div>

<div class="container">
<div class="row">
<div class="col">
<underline>
<h1 style="text-align: center;font-weight: 600;font-size: 373%;padding-top:100px;color: #ff0030;"><underline>Thanks for participating in the contest!!</underline></h1>
</underline>
<h3 style="text-align:center; color:#079001;">Congratulations You’re in queue to Win exciting Prizes,<br/> will update you soon about the results.</h3>
<h2 style="text-align: center;font-weight: 600;font-size: 200%;padding-top:15px;color: #ff0030;">“Amrutanjan 8ml Contest”</h2>

</div>
</div>



</div>

 <!--div id="wrapper" class="animated zoomIn">
  <!-- We make a wrap around all of the content so that we can simply animate all of the content at the same time. I wanted a zoomIn effect and instead of placing the same class on all tags, I wrapped them into one div! -->
<!--h1>
  <!-- The <h1> tag is the reason why the text is big! -->
  <underline></underline>
  <!-- The underline makes a border on the top and on the bottom of the text -->
<!--/h1>
<h3>
  For being such an awesome person. The &lt;h3&gt; tag can hold quite a lot of text inside itself before it makes a new line. Also, try hovering over the Thank you-text!
  <!-- The <h3> take is the description text which appear under the <h1> tag. It's there so you can display some nice message to your visitors! -->
<!--/h3>
</div-->
    

</section>

    </form>





<style type="text/css">

  .logo
  {
    width: 79%;
    margin-top: 20%;

  }
  
section
{
 background-image: url("images/Amrutanjan/image/1.jpg");
 height:100vh;
 width: 100%;
 margin: auto;
 background-repeat: no-repeat;
 background-size: cover;
 display: table;
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
  font-size:19px;
  box-shadow: 0px 6px 4px 0px #443f3f;
  margin-bottom:20px;
  margin-top:20px;
}

@media screen and (max-width:768px){

   .logo
   {
    text-align: center;
    margin-left: 12%;
    margin-bottom: 40px; 
	width:70%;
	}

	
h1 {
  font-size: 38px !important;
    padding-top: -1% !important;
    margin-bottom: -5px;
   /* padding-bottom: 19px; */
    margin-top: -30%;
}


h2 {
  color: black;
  text-shadow: -1px -2px 3px rgba(17, 17, 17, 0.3);
  text-align: center;
  font-family: "Monsterrat", sans-serif;
  font-weight: 900;
  text-transform: uppercase;
  font-size: 80px;
  margin-bottom: -5px;
}

h3 {
  font-family: "Lato", sans-serif;
  font-weight: 600;
  color: red;
  text-shadow: -1px -2px 3px rgba(17, 17, 17, 0.3);
  padding-top:15px;
}
}

@media screen and (max-width: 851px) and (min-width: 393px){  


h1 {
  font-size: 38px !important;
    padding-top: -1% !important;
    margin-bottom: -5px;
   /* padding-bottom: 19px; */
    margin-top: -25%;
}

}

@media screen and (max-width: 1180px) and (min-width: 820px){  


h1 {
  font-size: 38px !important;
    padding-top: -1% !important;
    margin-bottom: -5px;
   /* padding-bottom: 19px; */
    margin-top: 25%;
}
}


 h1 {
  color: #EEE;
  text-shadow: -1px -2px 3px rgba(17, 17, 17, 0.3);
  text-align: center;
  font-family: "Monsterrat", sans-serif;
  font-weight: 900;
  text-transform: uppercase;
  font-size: 80px;
  margin-bottom: -5px;
}

h3 {
  font-family: "Lato", sans-serif;
  font-weight: 600;
  color: red;
  text-shadow: -1px -2px 3px rgba(17, 17, 17, 0.3);
  padding-top:15px;
}

h2 {
  color: #EEE;
  text-shadow: -1px -2px 3px rgba(17, 17, 17, 0.3);
  text-align: center;
  font-family: "Monsterrat", sans-serif;
  font-weight: 900;
  text-transform: uppercase;
  font-size: 80px;
  margin-bottom: -5px;
}

</style>

</body>
</html>
