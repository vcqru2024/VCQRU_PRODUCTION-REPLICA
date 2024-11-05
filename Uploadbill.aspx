<%@ Page Language="C#" AutoEventWireup="true" CodeFile="Uploadbill.aspx.cs" Inherits="Uploadbill" %>

    <!DOCTYPE html>

    <html xmlns="http://www.w3.org/1999/xhtml">

    <head runat="server">
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Upload Image</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.bundle.min.js"></script>

<script type="text/javascript" language="javascript">

function DisableBackButton() {
window.history.forward()
}
DisableBackButton();
window.onload = DisableBackButton;
window.onpageshow = function(evt) { if (evt.persisted) DisableBackButton() }
window.onunload = function() { void (0) }
        </script>
        <style>
            .bill-logo {
                height: 3rem;
                border-radius: var(--bs-border-radius-pill);
            }

            .bill-page .card {
                /* margin: 3rem 0; */
                border: 0;
                /* background: #cce92c; */
                border-radius: var(--bs-border-radius-lg)
                    /* box-shadow: var(--bs-box-shadow-sm); */
            }

            .bill-page .card .card-body {
                padding: 2rem;
            }

            .form-label {
                font-size: 14px;
                font-weight: 500;
            }

            .form-control {
                border-radius: 2px;
            }

            body {
               
             /*   background: red;*/
             background-image: url("../assets/images/hypersonic/bg_upload.png");
               min-height: 100vh;
                
                background-size: cover;
                background-repeat: no-repeat;
            }
        </style>
    </head>

    <body>
        <div class="container">
            <div class="row">
                <div class="col-md-4 mx-auto my-5">
                    <div class="card">
                        <div class="card-body">
                            <div class="mb-3 text-center">
                                <img src="https://hypersonic.club/wp-content/themes/twentyseventeen/assets/images/imgpsh_fullsize_anim.png"
                                    alt="Logo" class="bill-logo bg-black px-3">
                            </div>
                            <form id="form1" runat="server" enctype="multipart/form-data">
                                <div class="mb-3" runat="server" id="uploadfile">
                                    <label for="" class="form-label">Upload Bill Image</label>
                                    <asp:FileUpload ID="fileupload" CssClass="form-control" runat="server" />
                                </div>
                                <div class="mb-3">
                                    <asp:Button ID="btnUpload" runat="server" BackColor="#cce92c"
                                        CssClass="btn btn-primary form-control text-dark border-0" Font-Bold="true" Text="Upload"
                                        OnClick="btnUpload_Click" />
                                </div>
                                <div style="text-align:center;">
                                    <asp:Label ID="lblMessage" Font-Size="Larger" CssClass="invalid-feedback d-block" runat="server"
                                        ForeColor="Black" Text="">
                                    </asp:Label>
                                </div>

                                <div>
                                    
                                    <p style="color:#cce92c"><b>Note: </b> After uploading the image, please follow the process on your device.


                                                        </p>
                                     </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>

    </html>