﻿<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="NotificationVR.aspx.cs" Inherits="Manufacturer_NotificationVR" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <asp:Label ID="Label6" runat="server"></asp:Label>
     <asp:Label ID="Label9" runat="server"></asp:Label>
     <asp:Label ID="Label3" runat="server" Style="color: Red; font-family: Arial; font-size: 12px;"></asp:Label>
    <div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
                <div class="card card-admin form-wizard profile box_card">
                    <header class="card-header">
                        <h4 class="card-title"><i class="fa fa-pencil-square-o"></i><asp:Label ID="lblheading" runat="server" Text="Notification" Font-Bold="true"></asp:Label></h4>
                    </header>
                     <div id="newmsg" runat="server">
                        <p>
                            <asp:Label ID="lblmsgHeader" runat="server"></asp:Label></p>
                    </div>
                    <div id="NewMsgpop" class="alert_boxes_green big_msg" runat="server">
                                <p>
                                    <asp:Label ID="LblMsgUpdate" runat="server"></asp:Label>
                                </p>
                            </div>
                    <div  class="card-body card-body-nopadding">                 
                      

                      <div class="col-lg-12" style="margin-top:20px;">
                                
                          <div class="change_psw1">
            <div class="card-body card-body-nopadding text-center">
              <h2  style="color: #0088cc;"  >Update Notification Message </h2><br /><br />
             
                  <div class="form-row">
        
                                   
                         <div class="form-group col-lg-12">                         
                            <asp:TextBox ID="notificationMsg" MaxLength="300"
                                class="form-control form-control-sm" runat="server" onkeyDown="return checkTextAreaMaxLength(this,event,'300');" placeholder="Notification Message"></asp:TextBox>
                         </div>
                        

                                 
                          
                </div>
                            <div class="form-row">
                       
                            <div class="form-group col-lg-3">
                     
                            <asp:Button ID="Button1"  OnClick="ImgSearch_Click" ValidationGroup="servss" class="btn float-right btn-primary btn-block" style="color: #0088cc;"    runat="server" Text="Submit" />
                      					
                            </div>
                            </div>
                             
                 

            </div>
            </div>
                                                 
 
            </div>
        </div>
        </div>
   
    </div>
             </div>
        </div>
        </div>
</asp:Content>


