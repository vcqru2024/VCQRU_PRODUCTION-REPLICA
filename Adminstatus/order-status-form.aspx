<%@ Page Language="C#" AutoEventWireup="true" CodeFile="order-status-form.aspx.cs" Inherits="order_status_form" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Order Tracking  </title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css">
</head>
  <style>
        /* Loader styles */
        #loader {
            display: none;
            position: fixed;
            left: 50%;
            top: 50%;
            width: 50px;
            height: 50px;
            z-index: 1000;
            border: 5px solid #f3f3f3;
            border-top: 5px solid #3498db;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            transform: translate(-50%, -50%);
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
    
   <body>
       <div >

    </div>
         <form id="form1" runat="server" class="needs-validation" novalidate>
             <div id="loader"></div>
          <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
              <asp:UpdatePanel ID="UpdatePanel1" runat="server">
                  <ContentTemplate>
             <div class="container">
                <div class="row">
                    <div class="col-lg-8 mx-auto">
                        <div class="card my-5 border-0 shadow-sm">
                            <div class="card-body">
                                <h3>Fill details Order Status</h3>
        
                     
                                <div class="row row-cols-xxl-2 row-cols-xl-2 row-cols-lg-2 row-cols-md-2 row-cols-1 g-4">
                                    <div class="col">
                                        <asp:Label runat="server" AssociatedControlID="ponumber" Text="PO Number" CssClass="control-label" />
                                        <asp:TextBox ID="ponumber" runat="server" CssClass="form-control" required />
                                          <div>
                                               <asp:RequiredFieldValidator ID="RequiredFieldValidator1" CssClass="invalid-feedback d-block" runat="server" ControlToValidate="ponumber" ErrorMessage="PONumber is required." />
                                          </div>
                                    </div>
                                    <div class="col">
                                        <asp:Label runat="server" AssociatedControlID="projectname" Text="Project Name" CssClass="control-label" />
                                        <asp:TextBox ID="projectname" runat="server" CssClass="form-control"  required/>
                                         <asp:RequiredFieldValidator ID="RequiredFieldValidator2" runat="server" ControlToValidate="projectname" ErrorMessage="Project Name is required." ForeColor="Red" />
                                    </div>
                                    <div class="col">
                                        <asp:Label runat="server" AssociatedControlID="ownerofpro" Text="Owner of Project" CssClass="control-label" />
                                        <asp:TextBox ID="ownerofpro" runat="server" CssClass="form-control" required  />
                                        <asp:RequiredFieldValidator ID="RequiredFieldValidator3" runat="server" ControlToValidate="ownerofpro" ErrorMessage="Owner of Project is required." ForeColor="Red" />
                                    </div>
                                    <div class="col">
                                        <asp:Label runat="server" AssociatedControlID="servicename" Text="Service Name" CssClass="control-label" />
                                        <asp:TextBox ID="servicename" runat="server" CssClass="form-control" required />
                                                            <asp:RequiredFieldValidator ID="RequiredFieldValidator4" runat="server" ControlToValidate="servicename" ErrorMessage="Service Name is required." ForeColor="Red" />

                                    </div>
                                      <div class="col">
                                        <asp:Label runat="server" AssociatedControlID="accountapproval" Text="Account Approval" CssClass="control-label" />
                                        <asp:TextBox ID="accountapproval" runat="server" CssClass="form-control" required />
                                                              <asp:RequiredFieldValidator ID="RequiredFieldValidator5" runat="server" ControlToValidate="accountapproval" ErrorMessage="Account Status is required." ForeColor="Red" />

                                    </div>
                                      <div class="col">
                                        <asp:Label runat="server" AssociatedControlID="remarks" Text="Remarks" CssClass="control-label" />
                                      <asp:TextBox ID="remarks" runat="server" TextMode="MultiLine" Rows="1" CssClass="form-control" required/>
                                                              <asp:RequiredFieldValidator ID="RequiredFieldValidator6" runat="server" ControlToValidate="remarks" ErrorMessage="Remarks are required." ForeColor="Red" />

                                    </div>
                                    <div class="col-xxl-12 col-xl-12 col-lg-12 col-md-12 col-12">
                                          <asp:Button  ID="SubmitButton" runat="server" type="submit" class="btn btn-primary w-100" Text="Submit" OnClick="Unnamed_Click" OnClientClick="showLoader()"  />
                        
                                    </div>
                        
                                  
                                </div>
                            </div>
                        </div> 
                    </div>
                </div>   
            </div>
                       </ContentTemplate>
        </asp:UpdatePanel>
    </form>
     
   
  
</body> 
</html>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script>
  
<script>
    function showAlert(title, text, icon) {
        Swal.fire({
            title: title,
            text: text,
            icon: icon,
            confirmButtonText: 'OK'
        }).then((result) => {
            if (result.isConfirmed) {
                window.location.reload();
            }
        });
    }
    function showErrorAlert(message) {
        hideLoader(); // Hide loader before showing alert
        Swal.fire({
            title: 'Error!',
            text: message,
            icon: 'error',
            confirmButtonText: 'OK'
        });
    }
</script>

<script>
    // Example starter JavaScript for disabling form submissions if there are invalid fields
    (function () {
        'use strict'

        // Fetch all the forms we want to apply custom Bootstrap validation styles to
        var forms = document.querySelectorAll('.needs-validation')

        // Loop over them and prevent submission
        Array.prototype.slice.call(forms)
            .forEach(function (form) {
                form.addEventListener('submit', function (event) {
                    if (!form.checkValidity()) {
                        event.preventDefault()
                        event.stopPropagation()
                    }

                    form.classList.add('was-validated')
                }, false)
            })
    })()
</script>
  <script type="text/javascript">
      function showLoader() {
          document.getElementById("loader-overlay").style.display = "block";
      }
    </script>
