<%@ Page Title="" Language="C#" MasterPageFile="~/Adminstatus/orderstatus.master" AutoEventWireup="true" CodeFile="AddBlogPost.aspx.cs" Inherits="Admin_Default" %>


<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="Server">

    <script>
        $(document).ready(function () {
            $('[data-bs-toggle="tooltip"]').tooltip();
        });
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="Server">
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
        <asp:HiddenField ID="hdnPostId" runat="server" />

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
                        <i class="fa fa-info-circle" data-bs-toggle="tooltip" title="Enter the header for the blog post."></i>
                        <asp:TextBox ID="txtHeader" ClientIDMode="Static" AutoComplete="off" CssClass="form-control" runat="server"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvHeader" ControlToValidate="txtHeader" ValidationGroup="blogform" runat="server" ErrorMessage="Header is required." Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                    </div>
                    <div class="row">
                        <label for="txtMetaTitle">Meta Title</label>
                        <i class="fa fa-info-circle" data-bs-toggle="tooltip" title="Enter the meta title for SEO."></i>
                        <asp:TextBox ID="txtMetaTitle" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="row">
                        <label for="txtMetaKeywords">Meta Keywords</label>
                        <i class="fa fa-info-circle" data-bs-toggle="tooltip" title="Enter meta keywords for SEO, separated by commas."></i>
                        <asp:TextBox ID="txtMetaKeywords" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="row">
                        <label for="txtMetaDescription">Meta Description</label>
                        <i class="fa fa-info-circle" data-bs-toggle="tooltip" title="Enter a meta description for SEO."></i>
                        <asp:TextBox ID="txtMetaDescription" TextMode="MultiLine" Rows="5" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <div class="row">
                        <label for="txtSEO">Search Engine Optimization</label>
                        <i class="fa fa-info-circle" data-bs-toggle="tooltip" title="Enter any additional SEO information. This will be shown in the page URL."></i>
                        <asp:TextBox ID="txtseo" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <%--   <div class="row">
                        <label for="txtLanguageId">Language Id</label>
                        <i class="fa fa-info-circle" data-bs-toggle="tooltip" title="Enter the language ID for the blog post."></i>
                        <asp:TextBox ID="txtLanguageId" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>                         
                        <asp:RequiredFieldValidator ID="rfvLanguageId" ControlToValidate="txtLanguageId" ValidationGroup="blogform" runat="server" ErrorMessage="Language ID is required." Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                    </div>--%>
                    <%--  <div class="row">
                        <label for="chkIncludeInSitemap">Include In Sitemap</label>
                        <i class="fa fa-info-circle" data-bs-toggle="tooltip" title="Check this box to include the blog post in the sitemap."></i>
                        <asp:CheckBox ID="chkIncludeInSitemap" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:CheckBox>
                    </div>--%>
                    <div class="row">
                        <label for="txtStartDate">Published/Start Date</label>
                        <i class="fa fa-info-circle" data-bs-toggle="tooltip" title="Enter the Published/Start date for the blog post."></i>
                        <asp:TextBox ID="txtStartDate" runat="server" CssClass="form-control datepicker" ClientIDMode="Static" data-date-format="yyyy-mm-dd"></asp:TextBox>
                        <asp:RequiredFieldValidator ID="rfvStartDate" ControlToValidate="txtStartDate" ValidationGroup="blogform" runat="server" ErrorMessage="Start Date is required." Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                    </div>
                    <div class="row">
                        <label for="txtEndDate">End Date</label>
                        <i class="fa fa-info-circle" data-bs-toggle="tooltip" title="Enter the end date for the blog post. Leave empty if the blog post does not expire."></i>
                        <asp:TextBox ID="txtEndDate" runat="server" CssClass="form-control datepicker" ClientIDMode="Static" data-date-format="yyyy-mm-dd"></asp:TextBox>
                    </div>
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/fine-uploader/5.16.2/fine-uploader-new.min.css" rel="stylesheet">
                    <link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/css/bootstrap-datepicker.min.css" rel="stylesheet" />
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.9.0/js/bootstrap-datepicker.min.js"></script>
                    <script src="https://cdnjs.cloudflare.com/ajax/libs/fine-uploader/5.16.2/fine-uploader.min.js"></script>
                    <script>
                        $(document).ready(function () {
                            $('.datepicker').datepicker({
                                autoclose: true,
                                todayHighlight: true
                            });
                        });
                    </script>

                    <div class="row">
                        <label for="txtContent">Content</label>
                        <i class="fa fa-info-circle" data-bs-toggle="tooltip" title="Enter the content for the blog post."></i>
                        <%--<asp:TextBox ID="txtContent" TextMode="MultiLine" Rows="5" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>--%>
                        <CKEditor:CKEditorControl ID="txtContent" BasePath="/ckeditor/" runat="server"></CKEditor:CKEditorControl>
                        <asp:RequiredFieldValidator ID="rfvContent" ControlToValidate="txtContent" ValidationGroup="blogform" runat="server" ErrorMessage="Content is required." Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>
                    </div>
                    <div class="row">
                        <label for="txtBodyOverview">Body Overview</label>
                        <i class="fa fa-info-circle" data-bs-toggle="tooltip" title="Enter a short overview of the blog post."></i>
                        <asp:TextBox ID="txtBodyOverview" TextMode="MultiLine" Rows="5" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <%--    <div class="row">
                        <label for="chkAllowComments">Allow Comments</label>
                        <i class="fa fa-info-circle" data-bs-toggle="tooltip" title="Check this box to allow comments on the blog post."></i>
                        <asp:CheckBox ID="chkAllowComments" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:CheckBox>
                    </div>--%>
                    <div class="row">
                        <label for="txtMetaTags">Meta Tags</label>
                        <i class="fa fa-info-circle" data-bs-toggle="tooltip" title="Enter meta tags for SEO, separated by commas."></i>
                        <asp:TextBox ID="txtMetaTags" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>
                    </div>
                    <%--   <div class="row">
                        <label for="chkLimitedToStore">Limited To Store</label>
                        <i class="fa fa-info-circle" data-bs-toggle="tooltip" title="Check this box to limit the blog post to a specific store."></i>
                        <asp:CheckBox ID="chkLimitedToStore" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:CheckBox>
                    </div>--%>
                    <div class="row">
                        <%--  <label for="fileUpload">Image/Video</label>
                        <i class="fa fa-info-circle" data-bs-toggle="tooltip" title="Upload an image or video for the blog post. Only Image (jpg/jpeg/png/gif/tiff) and Video (mp4/webm/ogg) are allowed. mp4 file size must not exceed 20 MB. Image file size must not exceed 400 KB."></i>
                        <asp:FileUpload onchange="ValidateFile(this)" ID="fileUpload" ClientIDMode="Static" runat="server" />--%>
                        <asp:FileUpload  ID="fileUpload" runat="server" />
                        <%-- <i class="fa fa-info-circle" data-bs-toggle="tooltip" title="Upload an image or video for the blog post. Only Image (jpg/jpeg/png/gif/tiff) and Video (mp4/webm/ogg) are allowed. mp4 file size must not exceed 20 MB. Image file size must not exceed 400 KB."></i>--%>
                          
                        <br />
                         <br />
                          <asp:Label ID="Label1" runat="server" Text=""></asp:Label>
                        <asp:Image ID="UploadedImageView" runat="server" Visible="true" CssClass="height-20 width-20" />
                        <asp:RequiredFieldValidator ID="rfvFileUpload" ControlToValidate="fileUpload" ValidationGroup="blogform" runat="server" ErrorMessage="File upload is required." Display="Dynamic" CssClass="text-danger"></asp:RequiredFieldValidator>

                    </div>
                    <div class="row" style="margin-bottom: 10px; margin-top: 10px;">
                        <asp:Button ID="btnSave" OnClick="btnsave_Clicked" Text="Save" CssClass="btn btn-primary" ValidationGroup="blogform" runat="server" />
                    </div>
                </div>
            </div>
        </div>
        <div class="col-lg-12">
            <asp:GridView class="table table-striped table-bordered table-hover" runat="server" AutoGenerateColumns="false" ID="grdBlogs" Style="margin-top: 10px" EmptyDataText="Record Not Found" EmptyDataRowStyle-HorizontalAlign="Center"
                Width="100%" orderStyle="None" BorderWidth="0" OnRowDataBound="grdBlogs_RowDataBound"
                BorderColor="transparent" AllowPaging="true" OnPageIndexChanging="grdBlogs_PageIndexChanging" OnRowCommand="grdBlogs_RowCommand" PageSize="10">
                <Columns>
                    <asp:BoundField DataField="Id" HeaderText="Blog ID" ItemStyle-Width="5%" />
                    <asp:BoundField DataField="Title" HeaderText="Title" />
                    <asp:BoundField DataField="BodyOverview" HeaderText="Body Overview" />
                    <asp:BoundField DataField="CreatedOnUtc" HeaderText="Creation Date" />
                    <asp:TemplateField>
                        <HeaderTemplate>
                            Actions
                        </HeaderTemplate>
                        <ItemTemplate>
                            <asp:ImageButton ImageUrl="../images/delete.png" runat="server" OnClientClick="return ConfirmDelete();" OnClick="RemoveBtnClicked" RowIndex='1' />
                            &nbsp;
                            <asp:Button ID="edittbn" CommandName="EditRow" CommandArgument='<%# Eval("id") %>' runat="server" CssClass="btn btn-primary" Text="Edit" data-toggle="collapse" data-target="#collapseExample" aria-expanded="false" aria-controls="collapseExample"  />
                        </ItemTemplate>


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

            if (ext.toLowerCase() != 'jpg' && ext.toLowerCase() != 'jpeg' && ext.toLowerCase() != 'png' && ext.toLowerCase() != 'gif' && ext.toLowerCase() != 'tiff' && ext.toLowerCase() != 'mp4' && ext.toLowerCase() != 'webm' && ext.toLowerCase() != 'ogg') {
                alert('Only Image(jpg/jpeg/png/gif/tiff) and Video (mp4/webm/ogg) are allowed');
                $(file).val('');
            }
            else if (FileSize > 20 && (ext.toLowerCase() == 'mp4' || ext.toLowerCase() == 'webm' || ext.toLowerCase() == 'ogg')) {
                alert('File size exceeds 20 MB');
                $(file).val(''); //for clearing with Jquery
            }
            else if (FileSize > 0.4 && (ext.toLowerCase() == 'jpg' || ext.toLowerCase() == 'jpeg' || ext.toLowerCase() == 'png' || ext.toLowerCase() == 'gif' || ext.toLowerCase() == 'tiff')) {
                alert('File size exceeds 400 KB');
                $(file).val(''); //for clearing with Jquery
            }
            else {

            }
        }
    </script>
  
</asp:Content>

