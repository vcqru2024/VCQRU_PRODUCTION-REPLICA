<%@ Page Title="" Language="C#" MasterPageFile="~/SagarPetro/pfl.master" AutoEventWireup="true" CodeFile="uploadbanner.aspx.cs" Inherits="SagarPetro_uploadbanner" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
    <div class="container-fluid xyz">
        <div class="row">
            <div class="col-lg-12">
                <div class="card card-admin form-wizard profile box_card">
                    <header class="card-header">
                        <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>
                            <asp:Label ID="lblheading" runat="server" Text="Add Banner" Font-Bold="true"></asp:Label>
                        </h4>
                    </header>
                    <div id="newmsg" runat="server">
                        <p>
                            <asp:Label ID="lblmsgHeader" runat="server"></asp:Label>
                        </p>
                    </div>
                    <div id="NewMsgpop" runat="server">
                        <p>
                            <asp:Label ID="Label2" runat="server"></asp:Label>
                        </p>

                    </div>
                    <div class="card-body card-body-nopadding">
                        <h6>Banner Info</h6>
                        <form method="post">





                            <div class="form-group row">
                                <label for="example-text-input" class="col-2 col-form-label">Banner Image</label>
                                <div class="col-4">
                                    <asp:FileUpload id="blgimg" runat="server" class="form-control" onchange="imagepreview(this)" />
                                </div>
                                <div class="col-2">
                                    <asp:LinkButton ID="add_blog" class="col-sm-12 btn btn-success btn-border center-block" runat="server" OnClick="add_blog_Click1">Add Banner</asp:LinkButton>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="form-label" for="field-1"></label>
                                <span class="desc"></span>
                                <div class="controls">
                                    <img src='' id="imgprw" class="img-responsive img-rounded" />

                                </div>
                            </div>
                        </form>

                    </div>


                </div>
            </div>
        </div>

    </div>
</asp:Content>

