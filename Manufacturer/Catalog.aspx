<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" CodeFile="Catalog.aspx.cs" Inherits="Manufacturer_Catalog" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
        <script src="http://code.jquery.com/jquery-1.8.2.js"></script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
     <div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
                <div class="card card-admin form-wizard profile box_card">
                    <header class="card-header">
                        <h4 class="card-title"><i class="fa fa-plus-square-o"></i><asp:Label ID="lblheading" runat="server" Text="Add Catalog" Font-Bold="true"></asp:Label></h4>
                    </header>
                    
                    <div id="NewMsgpop" runat="server">
                        <p>
                            <asp:Label ID="Label2" runat="server"></asp:Label>
                        </p>
               
                    </div>
                    <div  class="card-body card-body-nopadding"> <div id="newmsg" runat="server"> <p><br />
                        <a href="Uploadcatalog.aspx" class="btn btn-primary">Add Catalog</a></p>
                    </div>
                    <h6> Catalog Info</h6>
                        <div class="col-lg-12">
                         <div class="row">
                              <asp:Repeater ID="rewards" runat="server" OnItemCommand="rewards_ItemCommand">
                                 <ItemTemplate>
                                     <div class="col-md-4">                                            
                                     <%--<img class="img-responsive img-thumbnail" src="/<%# Eval("ImagePath") %>" alt="" style="height:300px;width:280px;">--%>
                                      <iframe src="/<%# Eval("Path") %>" alt="" id="imgprw" width="300" height="300" class="img-responsive img-rounded"></iframe>
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



