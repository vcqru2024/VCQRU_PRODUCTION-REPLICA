<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Amrutanwinner.aspx.cs" Inherits="Amrutanwinner" %>

<!DOCTYPE html>
<html lang="en">
<head>
  <title>Bootstrap 5 Example</title>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/css/bootstrap.min.css" rel="stylesheet">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.1/dist/js/bootstrap.bundle.min.js"></script>
</head>
<body>
<section>
  <div class="container">
    <div class="row">
      <div class="col-md-2">
          <figure class="logo"><img src="images/Amrutanjan/image/logo-new.png" class="img-fluid"></figure>
      </div>
      <div class="col-md-9 img1-center">
          <figure><img src="images/Amrutanjan/image/1.png" style="width:60%" class="img-fluid"></figure>
      </div>

    </div>

    
    <div class="row">
      <div class="col-md-12">
              <figure class="prize"><img src="images/Amrutanjan/image/2.png" style="width:100%;margin-top:-25%;" class="img-fluid "></figure>
      </div>

    </div>

    <div class="row text-center">
      <div class="col-12">
          <figure><img src="images/Amrutanjan/image/3.png" style="width: 100%;margin-top:-45%;" class="img-fluid"></figure>

       
      </div>
     
    

    </div>
  </div>
</section>

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
 


}
</style>

</body>
</html>
