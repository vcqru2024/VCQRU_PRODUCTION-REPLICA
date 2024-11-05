<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="AddBlogPost.aspx.cs" Inherits="Admin_Default" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
   
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="breadcrumbs" id="breadcrumbs">
        <script type="text/javascript">
            try { ace.settings.check('breadcrumbs', 'fixed') } catch (e) { }
        </script>

        <ul class="breadcrumb">
            <li>
                <i class="ace-icon fa fa-home home-icon"></i>
                <a href="#">Home</a>
            </li>
            <li class="active">Add Blog</li>
        </ul>
    </div>
    
     <div class="page-content">
         <div class="col-lg-12">
            <div>
                <p>
                  <button class="btn btn-secondary" type="button" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample">
                    Add Post
                  </button>
                </p>
            </div>
             <div class="collapse" id="collapseExample">
               <div class="container">
                   <div class="row">
                       <label for="txtHeader">Header</label>
                       <asp:TextBox ID="txtHeader" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                   </div>
                   <div class="row">
                       <label for="txtContent">Content</label>
                       <asp:TextBox ID="txtContent" TextMode="MultiLine" Rows="5" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                   </div>
                   <div class="row">
                       <label for="fileupload">Image/Video</label>
                       <asp:FileUpload onchange="ValidateFile(this)" ID="fileUpload" ClientIDMode="Static"  runat="server"/>
                   </div>
                   <div class="row" style="margin-bottom:10px;margin-top:10px;">
                       <asp:Button ID="btnSave" OnClick="btnsave_Clicked" Text="Save" CssClass="btn btn-primary" runat="server" />
                   </div>
               </div>
            </div>
        </div>
        <div class="col-lg-12">
            <asp:GridView class="table table-striped table-bordered table-hover"  runat="server" AutoGenerateColumns="false" ID="grdBlogs" style="margin-top:10px"  EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center" 
               Width="100%" orderStyle="None" BorderWidth="0" OnRowDataBound="grdBlogs_RowDataBound"
                        BorderColor="transparent" AllowPaging="true" OnPageIndexChanging="grdBlogs_PageIndexChanging" PageSize="10">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Row #" />
                    <asp:BoundField DataField="Header" HeaderText="Header" />
                    <asp:BoundField DataField="Post" HeaderText="Post" />
                    <asp:BoundField DataField="CreationDate" HeaderText="Creation Date" />
                    <asp:TemplateField>
                        <ItemTemplate>
                            <asp:ImageButton ImageUrl="../images/delete.png" runat="server" OnClientClick="return ConfirmDelete();" OnClick="RemoveBtnClicked" RowIndex='1' />
                        </ItemTemplate>
                        <HeaderTemplate>
                           Actions
                        </HeaderTemplate>
                    </asp:TemplateField>
                </Columns>

<EmptyDataRowStyle HorizontalAlign="Center"></EmptyDataRowStyle>
                <PagerSettings NextPageText="next" PreviousPageText="Prev" />
            </asp:GridView>
        </div>
     </div>

    <script type="text/javascript">
        function ConfirmDelete() {
            return confirm('Are sure you want to delete ?');
        }
        function ValidateFile(file) {
            debugger;
            var FileSize = file.files[0].size / 1024 / 1024; // in MiB
            //var lastdot = file.files[0].name.lastIndex('.');
            var ext = file.files[0].name.split('.')[1];
            
            if (ext.toLowerCase() != 'jpg' && ext.toLowerCase() != 'jpeg' && ext.toLowerCase() != 'png' && ext.toLowerCase() != 'gif' && ext.toLowerCase() != 'tiff' && ext.toLowerCase() != 'mp4' && ext.toLowerCase() != 'webm' && ext.toLowerCase() != 'ogg')
            {
                alert('Only Image(jpg/jpeg/png/gif/tiff) and Video (mp4/webm/ogg) are allowed');
                $(file).val('');
            }
            else if (FileSize > 20 && ( ext.toLowerCase() == 'mp4' || ext.toLowerCase() == 'webm' || ext.toLowerCase() == 'ogg')) {
                alert('File size exceeds 20 MB');
                $(file).val(''); //for clearing with Jquery
            }
            else if (FileSize > 0.4 && ( ext.toLowerCase() == 'jpg' || ext.toLowerCase() == 'jpeg' || ext.toLowerCase() == 'png' || ext.toLowerCase() == 'gif' || ext.toLowerCase() == 'tiff' ))
            {
                alert('File size exceeds 400 KB');
                $(file).val(''); //for clearing with Jquery
            }
            else {

            }
        }
    </script>
</asp:Content>

