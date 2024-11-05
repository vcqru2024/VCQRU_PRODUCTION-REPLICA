<%@ Page Title="" Language="C#" MasterPageFile="~/Admin/NewAdminMaster.master" AutoEventWireup="true" CodeFile="UpdateEventgallery.aspx.cs" Inherits="Admin_UpdateEventgallery" %>


<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>
<%@ Register Assembly="CKEditor.NET" Namespace="CKEditor.NET" TagPrefix="CKEditor" %>

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
            <li class="active">Add Gallery</li>
        </ul>
    </div>

    <div class="page-content">
        
        <div class="panel panel-primary">
      <div class="panel-heading">
          <asp:Button ID="Button2" CssClass="btn btn-secondary" runat="server" Text="Cancel" CausesValidation="false" OnClick="btnReset_Click" ValidationGroup="false" />
        </div>
        <div id="NewMsgpop" class="alert_boxes_green big_msg" runat="server">
                                <p>
                                    <asp:Label ID="LblMsgUpdate" runat="server"></asp:Label>
                                </p>
                            </div>
      <div class="panel-body">
         
           

          
                 <asp:HiddenField id="HiddenField1" runat="server" />
                      
                    <div class="col-lg-4 form-group">
                          <label for="example-text-input" class="col-2 col-form-label">Event Name *</label>
                        <asp:TextBox ID="event_nameGallery"   CssClass="form-control" runat="server" required="required"></asp:TextBox>
                         
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
                          <label for="example-text-input" class="col-2 col-form-label">Event Image 1 (Size:750px X 500 Px)*</label>
                        <asp:FileUpload  id="eventimg" runat="server"  class="form-control" onchange="imagepreview2(this)" accept="image/*" />
                      
                         <br />
                          <asp:Image runat="server" ID="eventimg_1" style="width: 150px;height: 110px; display:block" />
                     
                        </div>

                        <div class="col-lg-4 form-group">
                          <label for="example-text-input" class="col-2 col-form-label">Event Image (Size:750px X 500 Px)*</label>
                        <asp:FileUpload  id="img_2" runat="server"  class="form-control" onchange="imagepreview2(this)" accept="image/*" />
                      
                         <br />
                          <asp:Image runat="server" ID="eventimg_2" style="width: 150px;height: 110px; display:block" />
                     
                        </div>
           <div class="col-lg-4 form-group">
                          <label for="example-text-input" class="col-2 col-form-label">Event Image (Size:750px X 500 Px)*</label>
                        <asp:FileUpload  id="img_3" runat="server"  class="form-control" onchange="imagepreview2(this)" accept="image/*" />
                      
                         <br />
                          <asp:Image runat="server" ID="eventimg_3" style="width: 150px;height: 110px; display:block" />
                     
                        </div>
           <div class="col-lg-4 form-group">
                          <label for="example-text-input" class="col-2 col-form-label">Event Image (Size:750px X 500 Px)*</label>
                        <asp:FileUpload  id="img_4" runat="server"  class="form-control" onchange="imagepreview2(this)" accept="image/*" />
                      
                         <br />
                          <asp:Image runat="server" ID="eventimg_4" style="width: 150px;height: 110px; display:block" />
                     
                        </div>
          <div class="col-lg-4 form-group">
                          <label for="example-text-input" class="col-2 col-form-label">Event Image (Size:750px X 500 Px)*</label>
                        <asp:FileUpload  id="img_5" runat="server"  class="form-control" onchange="imagepreview2(this)" accept="image/*" />
                      
                         <br />
                          <asp:Image runat="server" ID="eventimg_5" style="width: 150px;height: 110px; display:block" />
                     
                        </div>
          <div class="col-lg-4 form-group">
                          <label for="example-text-input" class="col-2 col-form-label">Event Image (Size:750px X 500 Px)*</label>
                        <asp:FileUpload  id="img_6" runat="server"  class="form-control" onchange="imagepreview2(this)" accept="image/*" />
                      
                         <br />
                          <asp:Image runat="server" ID="eventimg_6" style="width: 150px;height: 110px; display:block" />
                     
                        </div>









                         <div class="col-lg-12 form-group" >
                        <label for="txtContent">Event Content</label>
                  
                        <CKEditor:CKEditorControl ID="txtContent" BasePath="/ckeditor/" runat="server">
                        </CKEditor:CKEditorControl>

                    </div>
                   
              
                        

              <div class="col-lg-3 form-group">
                    <asp:LinkButton ID="LinkButton2" class="btn btn-default" runat="server" Onclick="LinkButton2_Click">Update</asp:LinkButton>
               </div>

          </div>
             </div>
             

    </div>


</asp:Content>


