<%@ Page Title="" Language="C#" MasterPageFile="~/Layout.master" AutoEventWireup="true" CodeFile="event_feedback_form.aspx.cs" Inherits="event_feedback_form" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
      
       <style>

    #lbl{
        color:red;
    }

    .event-feedback-1 {
    background-color: #fff;
    box-shadow: 0px 0px 3px #d3cccc;
    padding: 20px;
    border-radius: 6px;
}

 .emoji-1 {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
    /* margin: auto 20px; */
    text-align: center;
}
  .emoji-1 a {
    /* padding: 17px 30px; */
    background: #fff;
    box-shadow: 0px 0px 1px gray;
    width: 23%;
    transition: transform .5s;
    transition: .5;
    border:none;
    cursor:pointer;
}

  .emoji-1 a:hover {
    transform: scale(1.1);
   
   
}
  .emoji-1 label {
    display: inline-block;
    font-size: 15px !important;
}


 .butons-feddback a:nth-child(2)
 {
     background: #de0a12;
    color: #fff;
 }

  .emoji-1 a i {
    font-size: 24px;
    margin: 8px;
    color: #ffc107;
}

       .event-feedback-1 input
       {
           border: 1px solid #ced4da;
       }

       .event-feedback-1 input:focus
       {
          box-shadow: none;
       }

       .butons-feddback
       {
               margin-top: 30px;
                margin-bottom: 30px;
       }


       i.far:hover {
    color: #ffc107 !important;
}

  .butons-feddback button {
    text-decoration: none;
    padding: 11px;
    background: #18beb7;
    color: #fff;
    border-radius: 4px;
    margin-right: 10px;
}

       .butons-feddback button:hover {
    color: #fff;
    background: #004c8e;
}

        @media screen and (width: 280px) {

            .emoji-1 label {
    
    font-size: 11px !important;
}
        }

       @media screen and (min-width: 767px) {

            .emoji-1 label {
    display: inline-block;
    font-size: 12px;
}
  
}

       a.selected{
  color:#fff;
  background:#18beb7;
}
         i.selected{
  color:#fff;
  
}

    a:not(.cta-btn):hover {
    color:#ffc107;
}
    </style>


   
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


     <main class="body-container-wrapper" ">

         <div class="container">
             <div class="row">

                 <div class="col-sm-6 offset-sm-3">

                  <form>
                      <div class="event-feedback-1 my-5" id="divfeedback">
                          <h3 class="mt-3">Give feedback</h3>
                          <p>How was your experience with the demo</p>
                         <div class="emoji-1">
                        <a ><i class='far fa-frown'></i><br /><label value="1">Not Satisfied</label></a   >
                       
                        <a ><i class='far fa-meh'></i><br /><label value="2">Satisfied</label></a>
                        <a ><i class='far fa-grin'></i><br /><label value="3">Good</label></a>
                       <a ><i class='far fa-laugh'></i><br /><label value="4">Amazing</label></a>
                             <label id="hdnval" style="display:none"></label>
                         </div>
                          
                          <div class="mb-3 mt-3">
    
                             <input type="text" class="form-control" id="txtname" placeholder="Enter Name" maxlength="100" aria-describedby="emailHelp">
    
                                </div>

                                    <div class="mb-3 ">
    
                                <input type="text" class="form-control" id="txtmobile" maxlength="10" placeholder="Enter Number" aria-describedby="emailHelp">
    
                                </div>
                           <div class="mb-3">
  
                            
                         <select class="form-control" name="bd" id="ddlbdlist">
                              <option value="">--Select Interacted Persion--</option>
                          <option value="Madan Gopal Mishra">Madan Gopal Mishra</option>
                          <option value="Ravi Kumar">Ravi Kumar</option>
                          <option value="Monika Shekhawat">Monika Shekhawat</option>
                          <option value="Palak  Chauhan">Palak  Chauhan</option>
                             <option value="Ajay Kumar">Ajay Kumar</option>
                             <option value="Damini Dheeman">Damini Dheeman</option>
                             <option value="Vaibhav Johar">Vaibhav Johar</option>
                             <option value="Subhadip Rakshit">Subhadip Rakshit</option>
                             <option value="Murugudu Harish">Murugudu Harish</option>
                             <option value="Dewashish Pant">Dewashish Pant</option>
                             <option value="Shrestha Mishra">Shrestha Mishra</option>
                             <option value="Hitesh Kumar">Hitesh Kumar</option>
                        </select>
                        </div>

                              <div class="mb-3">
  
                             <textarea class="form-control" id="txtsuggestion" placeholder="Suggestion" rows="3"></textarea>
                        </div>

                         

                          <label id="lbl"></label>
                          <div class="butons-feddback">
                              <button id="fbtnsubmit">Submit</button>
                              <%--<a href="#" id="fbtnsubmit">Submit</a>--%>
                              <button id="fbtncancel">Clear</button>
                              <%--<a href="#" id="fbtncancel">Clear</a>--%>
                          </div>
        
                      </div>
                       <div id="divsuccessfeedback" style="display:none">
                                                        <div class="text-center">
                                                            <i class="fa fa-thumbs-up" aria-hidden="true" style="font-size: 40px; color: #18BEB7;"></i>
                                                            <h2 class="mt-3" style="color: #8d9cbe; font-size:18px;">Thanks you for your feedback!</h2>
                                                            <%--<p class="mt-2" style="font-size:18px;">Our team experts will get in touch with you within 48 hours.</p>--%>


                                                        </div>
                                                    </div>
          </form>

                    

                 


                   
                 </div>
             </div>


         </div>

         </main>
    
    <script>
        $('a').on('click', function () {
            debugger;
            $('a').removeClass('selected');
            $(this).addClass('selected');
           var a= $(this).text();
            //alert(a);
            if (a == "Not Satisfied") {
                $('#hdnval').text('1')
            }
            if (a == "Satisfied") {
                $('#hdnval').text('2')
            }
            if (a == "Good") {
                $('#hdnval').text('3')
            }
            if (a == "Amazing") {
                $('#hdnval').text('4')
            }
            //alert($('#hdnval').text());
        });

        $('#fbtncancel').on('click', function () {

            $('#txtname').val('');
            $('#txtmobile').val('');
            $('#txtsuggestion').val('');
        });


        /* //Feedback//*/
        $(document).ready(function () {
            $("#fbtnsubmit").on('click', function (e) {
                e.preventDefault();

                if ($('#hdnval').text() == "") {
                    $('#lbl').text('Please Select Your Rating*');
                    return false;
                }
                else {
                    $('#lbl').text('');
                }

                if ($('#txtname').val() == "" || $('#txtname').val() == undefined) {
                    $('#txtname').val(' ')
                }

                //if ($('#txtname').val().replace(/\s+/g, '').length == 0) {
                //    $('#lbl').text('Please Enter Your Name*');
                //    $('#txtname').focus();
                //    $('#txtname').val('');
                //    return false;
                //}
                //var matches = $('#txtname').val().match(/\d+/g);
                //if (matches != null) {
                //    $('#lbl').text('Name should be alphabet only*');
                //    $('#txtname').focus();
                //    $('#txtname').val('');
                //    return false;
                //}
                //var matches1 = $('#txtname').val();
                //if (matches1.includes('~') || matches1.includes('!') || matches1.includes('@') || matches1.includes('#') || matches1.includes(')') || matches1.includes('_') || matches1.includes('-') || matches1.includes('>') || matches1.includes(',') || matches1.includes('?')
                //    || matches1.includes('$') || matches1.includes('%') || matches1.includes('^') || matches1.includes('&') || matches1.includes('*') || matches1.includes('(') || matches1.includes('+') || matches1.includes('<') || matches1.includes('.')
                //    || matches1.includes('=') || matches1.includes('{') || matches1.includes('}') || matches1.includes('[') || matches1.includes(']') || matches1.includes(':') || matches1.includes(';') || matches1.includes('"') || matches1.includes('/')
                //) {
                //    $('#lbl').text('Name should not contain any special char*');
                //    $('#txtname').focus();
                //    $('#btnsubmit').attr('disabled', false);
                //    $('#Name').val('');
                //    return false;
                //}


                var mobilenumber = $('#txtmobile').val();
                var d = mobilenumber.slice(0, 1);
                var c = parseInt(d);
                if (mobilenumber.match(/[^$,.\d]/)) {
                    $('#lbl').text("Mobile numbers should be numeric only*");
                    $('#txtmobile').focus();
                    $('#txtmobile').val('');
                    return false;
                }
                if (mobilenumber.length == 10 && c <= 5) {
                    $('#lbl').text("Please Enter a valid mobile number*");
                    $('#txtmobile').val('');
                    return false;
                }
                if (mobilenumber.length != 10) {
                    $('#lbl').text("Please enter the last 10 digits of your mobile phone number*");
                    $('#txtmobile').focus();
                    return false;
                }

                if ($('#txtsuggestion').val() == "" || $('#txtsuggestion').val() == undefined) {
                    $('#txtsuggestion').val(' ')
                }

                //if (mobilenumber.includes('~') || mobilenumber.includes('!') || mobilenumber.includes('@') || mobilenumber.includes('#') || mobilenumber.includes(')') || mobilenumber.includes('_') || mobilenumber.includes('-') || mobilenumber.includes('>') || mobilenumber.includes(',') || mobilenumber.includes('?')
                //    || mobilenumber.includes('$') || mobilenumber.includes('%') || mobilenumber.includes('^') || mobilenumber.includes('&') || mobilenumber.includes('*') || mobilenumber.includes('(') || mobilenumber.includes('+') || mobilenumber.includes('<') || mobilenumber.includes('.')
                //    || mobilenumber.includes('=') || mobilenumber.includes('{') || mobilenumber.includes('}') || mobilenumber.includes('[') || mobilenumber.includes(']') || mobilenumber.includes(':') || mobilenumber.includes(';') || mobilenumber.includes('"') || mobilenumber.includes('/')
                //) {
                //    $('#lbl').text('Name should not contain any special char*');
                //    $('#txtsuggestion').focus();
                //    $('#btnsubmit').attr('disabled', false);
                //    $('#txtsuggestion').val('');
                //    return false;
                //}

                //if ($('#ddlbdlist').val() == "") {
                //    $('#lbl').text('Please Select Interact Persion*');
                //}

                //if ($('#txtsuggestion').val().replace(/\s+/g, '').length == 0) {
                //    $('#lbl').text('Please Enter Suggestion*');
                //    $('#txtsuggestion').focus();
                //    $('#txtsuggestion').val('');
                //    return false;
                //}



                if ($('#txtname').val() != "" && mobilenumber != "" && $('#txtsuggestion').val() != "") {
                    $.ajax({
                        type: "POST",
                        contentType: false,
                        processData: false,

                        url: '../Info/MasterHandler.ashx?method=Feedback&Mobile=' + $('#txtmobile').val() + '&Name=' + $('#txtname').val() + '&Suggestion=' + $('#txtsuggestion').val() + '&Rateing=' + $('#hdnval').text() + '&Interactedper=' + $('#ddlbdlist').val(),
                        success: function (data) {
                            if (data == "Success") {
                                $('#divfeedback').hide();
                                $('#divsuccessfeedback').show();
                            }
                        }
                    });
                }


            });
        });
           <%-- //Feedback//--%>


    </script>

</asp:Content>

