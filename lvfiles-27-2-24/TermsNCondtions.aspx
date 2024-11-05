<%@ Page Language="C#" AutoEventWireup="true" CodeFile="TermsNCondtions.aspx.cs" Inherits="TermsNCondtions" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Terms and Conditions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
     <script src="Content/js/jquery-1.11.1.min.js"></script>
    <script>
    $(document).ready(function(){
        $('#btnback').click(
        function ()
        {
		parent.history.back();
		return false;
	    });
    });
    </script>
</head>
<body>
    <div class="container pt-3 pb-4">
        <div class="row">
            <div class="col-12 text-center p-3">
                <h2>Terms and Conditions</h2>
            </div>
        </div>
        <p>Please read the following terms and conditions carefully before entering your bank account details for payout processing. 
            By providing your bank account information, you agree to be bound by these terms and conditions:
        </p>
        <p>
            <b>Accuracy of Information:</b> It is your responsibility to ensure the accuracy of the bank account details provided. 
            VCQRU shall not be held responsible for any losses or damages resulting from incorrect information entered during the payout processing. 
            Please enter the information carefully.
        </p>
        <p>
            <b>Transfer of Funds:</b> Once the bank account details are entered and submitted, VCQRU will initiate the transfer of funds to the provided account.
             If incorrect information is entered, the funds may be transferred to the wrong account, and VCQRU will not be responsible for any resulting loss.
              Therefore, it is crucial to double-check the accuracy of the bank account details before submitting them.
        </p>
        <p>
            <b>Data Storage:</b> The bank account details provided by you will be securely stored in our systems and associated with the entered mobile number.
             VCQRU will take all reasonable measures to protect the confidentiality and integrity of your information, 
             in accordance with applicable data protection laws and regulations.
        </p>
        <p>
           <b> Account Details Modification: </b> If you wish to make changes to the bank account details associated with your mobile number, please contact our customer 
            service team. We will assist you in updating the information after verifying your identity and following our standard security protocols.
        </p>
        <p>
            <b>Customer Support: </b> For any queries or concerns related to your bank account details, payout processing, or any other issues, please reach out to our customer
             service team. We are here to assist you and provide the necessary support.
        </p>
        <p>
            By proceeding with entering your bank account details, you acknowledge that you have read and understood these terms and conditions. 
            You agree to abide by them and release VCQRU from any liability arising from incorrect information entered during the payout processing.
        </p>
        <p>If you do not agree with these terms and conditions, please do not proceed with providing your bank account details.</p>
        <div class="row">
            <div class="col-12 text-center mt-3">
                <button class=" btn btn-success" id="btnback" type="button">Accept</button>
            </div>
        </div>
    </div>
</body>
</html>
