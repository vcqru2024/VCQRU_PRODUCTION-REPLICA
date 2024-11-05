<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Amrutanjan.aspx.cs" Inherits="Amrutanjan" %>

<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
  <title>Amrutanjan</title>
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
      <div class="col-md-10">
          <figure><img src="images/Amrutanjan/image/profile.png" class="img-fluid"></figure>
      </div>

    </div>

    
    <div class="row">
      <div class="col-md-12">
              <figure class="prize"><img src="images/Amrutanjan/image/prize.png" class="img-fluid "></figure>
      </div>

    </div>

    <div class="row text-center mt-5">
      <div class="col-md-4 col-12">
          <figure><img src="images/Amrutanjan/image/scooter.png" class="img-fluid"></figure>

         <a href="Amrutanjantermsandcondation.aspx" class="scooter-button"> T & C </a>
      </div>
      <div class="col-md-4 col-12">
          <figure><img src="images/Amrutanjan/image/car.png" class="img-fluid"></figure>
                                <button type="button" class="btn btn-info btn-lg scooter-button" data-toggle="modal" data-target="#myModal">Win Prize</button>
      </div>
      <div class="col-md-4 col-12">
          <figure><img src="images/Amrutanjan/image/mobile.png" class="img-fluid"></figure>
                  <a href="AmrutanjanProcessflow.aspx" class="scooter-button"> How To Participate </a>
      </div>

    </div>
  </div>


  <div class="container pt-5 form-box">
       
        <!-- Trigger the modal with a button -->
        
      <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
     

               <div class="modal" id="myModal" runat="server" role="dialog">
            <div class="modal-dialog">

                <!-- Modal content-->
                <!--<button type="button" class="close" data-dismiss="modal">&times;</button>-->
                <div class="modal-content">

                    <div class="header">
                        <h4>PLEASE FILL THE FORM</h4>

                    </div>
                    <div class="modal-body">
                        <div class="row">
                            <div class="col-md-6">
                                
                                <asp:TextBox ID="txtParticipantName" runat="server" placeholder="Enter Your Name *" MaxLength="50" CssClass="form-control input-form"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                
                                <asp:TextBox ID="txtPhoneNumber" runat="server" TextMode="Number" placeholder="Enter Your Phone Number *" MaxLength="12" CssClass="form-control input-form"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                
                                <asp:TextBox ID="txtAddress" runat="server" placeholder="Enter Your Address *" MaxLength="50" CssClass="form-control input-form"></asp:TextBox>
                            </div>
                            <div class="col-md-6"> 
                                
                                 <asp:TextBox ID="txtCity" runat="server" placeholder="Enter Your City *" MaxLength="50" CssClass="form-control input-form"></asp:TextBox>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                
                                <asp:TextBox ID="txtState" runat="server" placeholder="Enter Your State *" MaxLength="50" CssClass="form-control input-form"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                
                                <asp:DropDownList ID="ddlgender" CssClass="form-control" runat="server">
                                    <asp:ListItem>--Select Gender--</asp:ListItem>                    
                                    <asp:ListItem>Male</asp:ListItem>
                                                        <asp:ListItem>Female</asp:ListItem>

                                                    </asp:DropDownList>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-6">
                                
                                <asp:TextBox ID="txtAge" runat="server" TextMode="Number" placeholder="Enter Your Age *" MaxLength="3" CssClass="form-control input-form"></asp:TextBox>
                            </div>
                            <div class="col-md-6">
                                
                                <label>Upload Proof of Purchase<em>*</em></label>
                                                    <asp:FileUpload ID="FileUpload1" runat="server" CssClass="file-box" />
                                                    <asp:HiddenField ID="hfuploadfile" runat="server" />
                                <asp:HiddenField ID="hfproductId" runat="server" />
                            </div>
                        </div>
                    </div>
                    <div class="footer ">
                       <div class="row">
                           <div class="col-12 text-center">
                               
                                <asp:Button ID="btnsubmit" OnClick="btnsubmit_Click" Text="Save" runat="server" CssClass="footer-btn" />
                           </div>
                            <div class="col-12 text-center">
                                <asp:Label ID="lblmessage" runat="server" ForeColor="Red"></asp:Label>
                                
                           </div>
                       </div>
                    </div>
                </div>

            </div>
        </div>

        
        <!-- Modal -->
       

    </div>

</section>

        </form>



<style type="text/css">

  .logo
  {
    width: 79%;
    margin-top: 25%;

  }
  
section
{
 background-image: url("./images/Amrutanjan/image/1.jpg");
 height: 100%;
 width: 100%;
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
  font-size:19px;
  box-shadow: 0px 6px 4px 0px #443f3f;
  margin-bottom:20px;
  margin-top:20px;
}

@media screen and (max-width:768px){

   .logo
   {
      text-align: center;
    margin-left: 10%;
    margin-bottom: 40px;   
	}
 


}


 .header {
            overflow: hidden;
        }
        .modal-content {
            background-color: #ffffff70 !important;
            border: 4px solid #ffffffb3;
            border-radius: 45px;
            padding: 0px 10px;
        }
        .header h4 {
            text-align: center;
            background-color: #00225fba;
            margin: 0px;
            padding: 153px 0px 46px;
            border-bottom-left-radius: 80%;
            border-bottom-right-radius: 80%;
            color: #fff;
            width: 58%;
            margin: -117px auto;
            margin-bottom: 10px;
        }
        .form-box .modal-body .input-form {
            margin-bottom: 10px;
            border-radius: 50px;
            background: #e3e8ec;
            border: 2px solid #ffffffa1;
            height: 45px;
        }
        .form-box .modal-body select {
            margin-bottom: 10px;
            border-radius: 50px;
            background: #e3e8ec;
            border: 2px solid #ffffffa1;
            height: 45px;
        }
        .form-box .footer {
            padding: 10px 10px;
        }
        .footer .footer-btn {
            background-color: #00225f;
            color: #fff;
            padding: 6px 42px;
        }




</style>

</body>
</html>
