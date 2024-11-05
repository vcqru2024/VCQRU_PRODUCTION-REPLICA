<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="GalleryNew.aspx.cs" Inherits="Admin_GalleryNew" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>
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
        function imagepreview2(input) {
            if (input.files && input.files[0]) {
                var fildr = new FileReader();
                fildr.onload = function (e) {
                    $('#imgprw2').attr('src', e.target.result);
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
    <div class="breadcrumbs" id="breadcrumbs">
        <script type="text/javascript">
            try { ace.settings.check('breadcrumbs', 'fixed') } catch (e) { }
        </script>

        <ul class="breadcrumb">
            <li>
                <i class="ace-icon fa fa-home home-icon"></i>
                <a href="#">Home</a>
            </li>
            <li class="active">Add Gallery</li>
        </ul>
    </div>

    <div class="page-content">
       
        <div class="panel panel-primary">
                

      <div class="panel-heading">
       <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#myModalGalleryEvent">Add Event</button>
      <button type="button" class="btn btn-secondary" data-toggle="modal" data-target="#myModalGallery">Add Event Gallery</button> 
          </div>
      <div class="panel-body">
           <div id="NewMsgpop" class="alert_boxes_green big_msg text-center" runat="server">
                                <p>
                                    <asp:Label ID="LblMsgUpdate" runat="server" style="font-size:18px;color:red;"></asp:Label>
                                </p>
                            </div>
        <div class="table-responsive table_large">
                <asp:GridView ID="grd1"  runat="server" AutoGenerateColumns="False" CssClass="table table-striped tblSorting table-bordered"
                    EmptyDataText="Record Not Found" 
                    BorderColor="transparent"
                    allowpaging="false" >
                <Columns>
                        <asp:TemplateField HeaderText="Image">
                        <ItemTemplate>
         
                        <asp:Image Height="150px" Width="150px" ID="Image1" ImageUrl='<%# Bind("imgpath") %>' runat="server" style="padding:5px;margin-left:0px;" />
                            
                        <asp:Image Height="150px" Width="150px" ID="Image2" ImageUrl='<%# Bind("img_1") %>' runat="server" style="padding:5px;margin-left:0px;" />
                        <asp:Image Height="150px" Width="150px" ID="Image3" ImageUrl='<%# Bind("img_2") %>' runat="server" style="padding:5px;margin-left:0px;" />
                        <asp:Image Height="150px" Width="150px" ID="Image4" ImageUrl='<%# Bind("img_3") %>' runat="server" style="padding:5px;margin-left:0px;" />
                        <asp:Image Height="150px" Width="150px" ID="Image5" ImageUrl='<%# Bind("img_4") %>' runat="server" style="padding:5px;margin-left:0px;" />
                        <asp:Image Height="150px" Width="150px" ID="Image6" ImageUrl='<%# Bind("img_5") %>' runat="server" style="padding:5px;margin-left:5px;" />
                           
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="30%" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Title">
                        <ItemTemplate>
                            <asp:Label ID="lblactudate12" runat="server" Text='<%# Bind("event_name") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="20%" />
                    </asp:TemplateField>
                        <asp:TemplateField HeaderText="City">
                        <ItemTemplate>
                            <asp:Label ID="lblactudate12" runat="server" Text='<%# Bind("event_city") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                    </asp:TemplateField>
                    <asp:TemplateField HeaderText="Address">
                        <ItemTemplate>
                            <asp:Label ID="lblactudate12" runat="server" Text='<%# Bind("event_address") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                    </asp:TemplateField>

                    <asp:TemplateField HeaderText="Date">
                        <ItemTemplate>
                            <asp:Label ID="lblactudate12" runat="server" Text='<%# Bind("event_date") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad"  Width="10%" />
                    </asp:TemplateField>

                     <asp:TemplateField HeaderText="Status">
                        <ItemTemplate>
                            <asp:Label ID="lblactudate12" runat="server" Text='<%# Bind("EventStatus") %>'></asp:Label>
                        </ItemTemplate>
                        <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad"  Width="10%" />
                    </asp:TemplateField>


                        
                    <asp:TemplateField HeaderText="Update status">
                    <itemtemplate>
                 <%--   <asp:ImageButton ID="imgBtnDelete" runat="server" CommandArgument='<%# Eval("id") %>' ImageUrl="~/Images/buttondelete.png" OnClick="imgBtnDelete_Click" OnClientClick="return confirm('Are you sure to delete this Record.')"/>--%>
                       
                       <a href='?evid=<%# Eval("id") %>'><img src="../Content/images/edit.png" onclientclick="javascript:return confirm('Are you sure to activate or deactivate event?')" data-toggle="tooltip" data-placement="top" title="Active/ De Active Event"></a>
                      &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;  <a href='UpdateEventgallery.aspx?evid=<%# Eval("id") %>'><img src="../Content/images/edit.png" data-toggle="tooltip" data-placement="top" title="Update Event"></a>
                    
                    &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;   <a href='?delid=<%# Eval("id") %>'><img src="../images/delete.png" onclick="return confirm('Are you sure to delete event?')" onclientclick="javascript:return confirm('Are you sure to delete event?')" data-toggle="tooltip" data-placement="top" title="Delete"></a>
                    </ItemTemplate>
                        <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="10%" />
                    </asp:TemplateField>
                                        
                                       
                    </Columns>
                </asp:GridView>
            </div>

          </div>
             </div>
             

    </div>
    <!-- upload-model-->
         <div class="modal fade" id="myModalGallery" role="dialog">
    <div class="modal-dialog">    
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Upload Gallery Image</h4>
        </div>
        <div class="modal-body">
                    <div id="Div1" runat="server">
                        <p>
                            <asp:Label ID="Label1" runat="server"></asp:Label></p>
                    </div>
                    <div id="Div2" runat="server">
                        <p>
                            <asp:Label ID="Label3" runat="server"></asp:Label>
                        </p>
               
                    </div>
            <form action="#" method="post" >     
               
                    <div class="row" style="margin:10px;">
                         <div class="col-4 form-group">
                        <label class="form-label" for="field-1">Select Event *</label>
                            <span class="desc"></span>
                                 <asp:DropDownList ID="DropDownList1" runat="server" class="form-control" AutoPostBack="False"></asp:DropDownList>
                        </div>
                      <div class="col-4 form-group">
                          <label for="example-text-input" class="col-2 col-form-label">Gallery Image (Size:750px X 500 Px)*</label>
                        <asp:FileUpload  id="blgimg" runat="server"  class="form-control" onchange="imagepreview(this)" accept="image/*" required="required" />
                      </div>
                    <div class="col-3 form-group">
                    <asp:LinkButton ID="add_blog" class="btn btn-default" runat="server" OnClick="add_gallery_Click1">Add Gallery</asp:LinkButton>
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
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  
<!-- close model -->
     <!-- upload-model-->
         <div class="modal fade" id="myModalGalleryEvent" role="dialog">
    <div class="modal-dialog modal-lg">    
      <div class="modal-content">
        <div class="modal-header">
          <button type="button" class="close" data-dismiss="modal">&times;</button>
          <h4 class="modal-title">Add Event</h4>
        </div>
        <div class="modal-body">
                   
                
               
                    <div class="row" style="margin:10px;">
                      
                      
                         <div class="col-lg-4 form-group">
                          <label for="example-text-input" class="col-2 col-form-label">Event Name *</label>
                        <asp:TextBox ID="event_nameGallery"   CssClass="form-control" runat="server" required="required"></asp:TextBox>
                          <%--   <input type="text" name="event_name" id="event_name" runat="server" value=""/>--%>
                      </div>
                        
                        <div class="col-lg-4 form-group">
                          <label for="example-text-input" class="col-2 col-form-label">Event City *</label>
                        <asp:TextBox ID="event_city"   CssClass="form-control" runat="server" required="required"></asp:TextBox>
                         
                      </div>
                        <div class="col-lg-4 form-group">
                          <label for="example-text-input" class="col-2 col-form-label">Event Address *</label>
                        <asp:TextBox ID="event_address"   CssClass="form-control" runat="server" required="required"></asp:TextBox>
                        
                      </div>
                       
                      <div class="col-lg-4 form-group">
                        <label for="example-text-input" class="col-2 col-form-label">Event  Date *</label>
                       <asp:TextBox ID="txtDate" Visible="true" runat="server"  CssClass="form-control form-control-sm"></asp:TextBox>   
                      </div>
                         <div class="col-lg-4 form-group">
                        <label for="example-text-input" class="col-2 col-form-label">From Date *</label>
                       <asp:TextBox ID="from_date" Visible="true" runat="server" type="Date" CssClass="form-control form-control-sm"></asp:TextBox>   
                      </div>
                         <div class="col-lg-4 form-group">
                        <label for="example-text-input" class="col-2 col-form-label"> To Date *</label>
                       <asp:TextBox ID="to_date" Visible="true" runat="server" type="Date" CssClass="form-control form-control-sm"></asp:TextBox>   
                      </div>
                         <div class="col-lg-4 form-group">
                          <label for="example-text-input" class="col-2 col-form-label">Event Image (Size:750px X 500 Px)*</label>
                        <asp:FileUpload  id="eventimg" runat="server"  class="form-control" onchange="imagepreview2(this)" accept="image/*" />
                      </div>
                        </div>
                   
                        <div class="col-12 form-group">
                        <label for="txtContent">Event Content</label>
                        <%--<asp:TextBox ID="txtContent" TextMode="MultiLine" Rows="5" ClientIDMode="Static" CssClass="form-control" runat="server"></asp:TextBox>--%>
                          
                        <CKEditor:CKEditorControl ID="txtContent" BasePath="/ckeditor/" runat="server">
                        </CKEditor:CKEditorControl>

                    </div>

                    <div class="col-3 form-group">
                    <asp:LinkButton ID="LinkButton2" class="btn btn-default" runat="server" Onclick="LinkButton2_Click">Add Gallery Event</asp:LinkButton>
               </div>
                        </div>
                                   <div class="form-group">
                            <label class="form-label" for="field-1"></label>
                            <span class="desc"></span>
                            <div class="controls">
                               <img src='' id="imgprw2" class="img-responsive img-rounded"/>
                               
                            </div>
                        </div>
          
        
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
        </div>
      </div>
      
    </div>
  </div>
  
<!-- close model -->
 
</asp:Content>

 