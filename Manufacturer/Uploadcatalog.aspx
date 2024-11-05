﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="Uploadcatalog.aspx.cs" Inherits="Manufacturer_Uploadcatalog" %>

<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
    <script>
        function imagepreview(input) {
            if (input.files && input.files[0]) {
                var fildr = new FileReader();
                fildr.onload = function (e) {
                    $('#imgprw').attr('src', e.target.result);
                }
                fildr.readAsDataURL(input.files[0]);
            }
        }

    </script>
    <style>
        .btn-success.btn-border:hover{
            color:white;
            background-color:#4CAF50;
        }
    </style>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">


    <div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
                <div class="card card-admin form-wizard profile box_card">
                    <header class="card-header">
                        <h4 class="card-title"><i class="fa fa-pencil-square-o"></i><asp:Label ID="lblheading" runat="server" Text="Add Catalog" Font-Bold="true"></asp:Label></h4>
                    </header>
                     <div id="newmsg" runat="server">
                                           
                                        </div>
                    <div id="NewMsgpop" runat="server">
                         <p>
                                                <asp:Label ID="lblmsgHeader" ForeColor="Red" Font-Bold="true" runat="server"></asp:Label></p>
                        <p>
                            <asp:Label ID="Label2" runat="server"></asp:Label>
                        </p>
               
                    </div>
                    <div  class="card-body card-body-nopadding">
                    <h6> Catalog Info</h6>
                             <form method="post">         
               
                
                  
        
                
                    <div class="form-group row">
                      <label for="example-text-input" class="col-2 col-form-label">Catalog </label>
                      <div class="col-4">
                        <asp:FileUpload  id="blgimg" runat="server"  class="form-control" onchange="imagepreview(this)"/>
                      </div>
                    <div class="col-2">
                    <asp:LinkButton ID="add_blog" class="col-sm-12 btn btn-success btn-border center-block" runat="server" OnClick="add_blog_Click1">Add Catalog</asp:LinkButton>
               </div>
                        </div>
                                   <div class="form-group">
                            <label class="form-label" for="field-1"></label>
                            <span class="desc"></span>
                            <div class="controls">
                                <iframe src="" id="imgprw" width="300" height="300" class="img-responsive img-rounded"></iframe>
                               <%--<img src='' id="imgprw" class="img-responsive img-rounded"/>--%>
                               
                            </div>
                        </div>
            </form>

                    </div>

                   
            </div>
        </div>
        </div>

    </div>
             </div>

    
</asp:Content>


