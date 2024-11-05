<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="Banner.aspx.cs" Inherits="Admin_Banner" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
     <div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
                <div class="card card-admin form-wizard profile box_card">
                    <header class="card-header">
                        <h4 class="card-title"><i class="fa fa-plus-square-o"></i><asp:Label ID="lblheading" runat="server" Text="Add Banner" Font-Bold="true"></asp:Label></h4>
                    </header>
                    
                    <div id="NewMsgpop" runat="server">
                        <p>
                            <asp:Label ID="Label2" runat="server"></asp:Label>
                        </p>
               
                    </div>
                    <div  class="card-body card-body-nopadding"> <div id="newmsg" runat="server"> <p><br />
                        <a href="Uploadbannervcqru.aspx" class="btn btn-primary">Add Banner</a></p>
                    </div>
                    <h6> Banner Info</h6>
                        <div class="col-lg-12">
                         <div class="row">
                              <asp:Repeater ID="rewards" runat="server" OnItemCommand="rewards_ItemCommand">
                                 <ItemTemplate>
                                     <div class="col-md-4">                                            
                                     <img class="img-responsive img-thumbnail" src="/<%# Eval("ImagePath") %>" alt="" style="height:300px;width:280px;">
                                      
                                     </div>
                                      <div class="col-sm-8"> 
                                            <%--<asp:LinkButton ID="lnkRemove" EnableViewState="True" runat="server" class="label label-danger" CommandName="Delete" CommandArgument='<%#Eval("ID") %>' onclientclick="javascript:return confirm('Are you sure to delete record?')"> <i class="fa fa-trash" aria-hidden="false"></i>  </asp:LinkButton>--%>
                                            <asp:LinkButton ID="LinkButton1" runat="server"  CommandName="Delete" CommandArgument='<%# Eval("ID") %>' onclientclick="javascript:return confirm('Are you sure to delete record?')"><i class="fa fa-trash" aria-hidden="false" style="font-size:20px;color:red"> Delete</i> </asp:LinkButton>
                                        </div>                                                            

                                </ItemTemplate>
                        </asp:Repeater>

                    </div>
                            </div>

                   
            </div>
        </div>
        </div>

    </div>
             </div>
         </div>
</asp:Content>

