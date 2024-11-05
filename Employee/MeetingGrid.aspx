<%@ Page Title="" Language="C#" MasterPageFile="~/Employee/Employee.master" AutoEventWireup="true" CodeFile="MeetingGrid.aspx.cs" 
    Inherits="Employee_MeetingGrid" %>
<%--<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>--%>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script src="http://code.jquery.com/jquery-1.9.1.js"></script>
<%--<script src="ttp://code.jquery.com/ui/1.11.0/jquery-ui.js"></script>--%>
         <%--<script src="../vendor/bootstrap/js/bootstrap.min.js"></script>--%>
    	<%--<script src="../vendor/jquery/jquery.min.js"></script>--%>
    <%-- <link rel="stylesheet" href="../Admin/assets/css/jquery-ui.min.css" />
    <script src="../Admin/js/bootstrap-datepicker.js" type="text/javascript"></script>
    <link href="../Admin/assets/css/datepicker.css" rel="stylesheet" />--%>
        <link href="../vendor/bootstrap-datepicker/css/bootstrap-datepicker.css" rel="stylesheet" />
    <%--<link href="../vendor/bootstrap-datepicker/css/bootstrap-datepicker3.standalone.css" rel="stylesheet" />--%>
    <script src="../vendor/bootstrap-datepicker/js/bootstrap-datepicker.js"></script>
    <script>
        $(document).ready(function () {
            $("#txtDateFrom1").datepicker();
        });
    </script>
    
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    <div class="col-lg-9">

        <div class="sort-destination-loader sort-destination-loader-showing">
            <div class="row portfolio-list sort-destination" data-sort-id="portfolio">
                <div class="col-lg-12 card card-admin form-wizard profile">

                    <header class="card-header">
                        <h4 class="card-title"><i class="fa fa-pencil-square-o">Meeting Details</i></h4>
                        <asp:Label ID="Label3" runat="server" CssClass="astrics"></asp:Label>

                    </header>

                    <div id="newMsg" runat="server" style="width: 91%;">
                        <p>
                            <asp:Label ID="Label2" runat="server"></asp:Label>
                        </p>
                    </div>
                 
                    <div class="card-body card-body-nopadding" >
                        <%--<h6>Search</h6>--%>
                        <div class="form-row">
                              <div class="form-group col-lg-3"> 
                                  
                            <label>Company/Client Name</label>
                                       <asp:TextBox ID="txtCompClientName" runat="server" class="form-control form-control-sm"></asp:TextBox>
                              </div>
                                  <div class="form-group col-lg-3">
                                       <label>Mobile No</label>
                                       <asp:TextBox ID="txtMobileNo" runat="server" class="form-control form-control-sm"></asp:TextBox>
                              </div>
                            <div class="form-group col-lg-3">
                                 <label>Employee Names</label>
                                <asp:DropDownList ID="ddlEmployeeName" runat="server" class="form-control form-control-sm">
                                </asp:DropDownList>                               
                            </div>
                            </div>
                       
                             <div class="form-row">
                               <div class="form-group col-lg-3">
                                    <label>Date From </label>
                                   <input type="text" id="txtDateFrom1" class="input-sm" name="start" /> fgfdg
                                 <asp:TextBox ID="txtDateFrom"   runat="server" class="form-control form-control-sm"></asp:TextBox>
                            </div>
                            <div class="form-group col-lg-3">
                                 <label>Date To </label>
                                <asp:TextBox ID="txtDateto" runat="server" class="form-control form-control-sm"></asp:TextBox>
                            </div>
                                  <div class="form-group col-lg-3">
                                 <label>Meeting Time (hh:mm)</label>
                                                  <asp:TextBox ID="txtMeetingTime"  runat="server" class="form-control form-control-sm"></asp:TextBox>          
                            </div>
                            
                        </div>
                         <div class="form-row">
                           <div class="form-group col-lg-2">
                                 <asp:ImageButton ID="ImgSearch" runat="server" ImageUrl="~/Content/images/search_rec.png"
                                        OnClick="ImgSearch_Click" ToolTip="Search" />
                                    <asp:ImageButton ID="ImgRefresh" runat="server" ImageUrl="~/Content/images/reset.png" OnClick="ImgRefresh_Click"
                                        ToolTip="Reset" />
                            <%--    <cc1:CalendarExtender ID="CalendarExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtenderdatefrom" runat="server" TargetControlID="txtDateFrom"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtenderdatefrom" runat="server"
                                        TargetControlID="txtDateFrom" WatermarkText="Date From....">
                                    </cc1:TextBoxWatermarkExtender>--%>
                                   <%-- <cc1:CalendarExtender ID="CalendarExtender1to" runat="server" TargetControlID="txtDateto"
                                        Format="dd/MM/yyyy">
                                    </cc1:CalendarExtender>
                                    <cc1:MaskedEditExtender ID="MaskedEditExtender1to" runat="server" TargetControlID="txtDateto"
                                        Mask="99/99/9999" MaskType="Date">
                                    </cc1:MaskedEditExtender>
                                    <cc1:TextBoxWatermarkExtender ID="TextBoxWatermarkExtender1to" runat="server" TargetControlID="txtDateto"
                                        WatermarkText="Date To....">
                                    </cc1:TextBoxWatermarkExtender>--%>
                            </div>
                              <div class="form-group col-lg-10">
                                     <asp:Button Text="Add Meeting Details" runat="server" ID="btnAddEmp"  OnClick="btnAddEmp_Click" 
                                         class="btn btn-primary float-right mb-0" />
                              </div>
                            </div>
                    </div>

                      <%--<div class="form-row">
                        <div class="form-group col-lg-12">
                         
                            </div>
                        </div>--%>
                </div>

               
                 <div class="col-lg-12 card card-admin form-wizard medias">
										<div class="">
                                            <div class="row pb-2 pt-2 background-section-form">
												<div class="col-lg-10">
													<h4 class="mb-0">Record(s) found<span>
                                                         (<asp:Label ID="lblcount" runat="server"></asp:Label>)</span></h4>
												</div>
                                               <%-- <div class="col-lg-2">
                                                     <asp:Label ID="lblToatalCashPoints" runat="server">
                                                     </asp:Label>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<asp:Label
                                    ID="lblToatalPoints" runat="server"></asp:Label>
                                                </div>
												<div class="col-lg-2">
  
												</div>--%>
											</div>



                                            <asp:GridView ID="GrdLabel" runat="server" AutoGenerateColumns="false"  CssClass="table table-striped"
                           EmptyDataText="Record Not Found"  OnRowDataBound="GrdLabel_RowDataBound" DataKeyNames="IsActive"
                            OnRowCommand="GrdLabel_RowCommand" BorderColor="transparent" OnPageIndexChanging="GrdLabel_PageIndexChanging"
                            AllowPaging="True" PageSize="50">
                            <Columns>
                                <asp:TemplateField HeaderText="Actions">
                                    <ItemTemplate>
                                         <asp:Label ID="MeetingID" runat="server" Text='<%# Bind("[MeetingID]") %>' Visible="false"></asp:Label>
                                         <asp:ImageButton ID="ImgBtnLoyalty" runat="server" CausesValidation="false" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    CommandName="EditRows" ImageUrl="~/Content/images/edit.png" ToolTip="Edit" />
                                       
                                         <asp:ImageButton ID="ImgDeActivated"  runat="server"  Visible="false" CausesValidation="false" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    CommandName="IsActive" ImageUrl="~/Content/images/check_gr.png" 
                                    OnClientClick="return confirm('Activate ?')" />

                                        <asp:ImageButton ID="ImgImgIsActive" runat="server" Visible="false" CausesValidation="false" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                     CommandName="De-Activated" ImageUrl="~/Content/images/check_act.png"
                                    ToolTip="De-Activated" OnClientClick="return confirm('De-Activate?')" />

                                        <asp:ImageButton ID="imgBtnSecDelete" runat="server" CommandArgument="<%# ((GridViewRow) Container).RowIndex %>"
                                    CommandName="DeleteRow" ImageUrl="~/Content/images/delete.png" ToolTip="Delete"
                                    OnClientClick="return confirm('Sure to delete?')" />

                                        </ItemTemplate>
                                    </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Title">
                                    <ItemTemplate>
                                        <asp:Label ID="lblTitle" runat="server" Text='<%# Bind("Title") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                  <asp:TemplateField HeaderText="Created By">
                                    <ItemTemplate>
                                        <asp:Label ID="lblempname" runat="server" Text='<%# Bind("empname") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                <asp:TemplateField HeaderText="Company">
                                    <ItemTemplate>
                                        <asp:Label ID="CompanyName" runat="server" Text='<%# Bind("CompanyName") %>'></asp:Label>
                                        </ItemTemplate>
                                    </asp:TemplateField>
                                                                
                                <asp:TemplateField HeaderText="Email">
                                    <ItemTemplate>
                                        <asp:Label ID="lblentrydate" runat="server" Text='<%# Bind("Email") %>'></asp:Label>
                                    </ItemTemplate>
                                
                                    <ItemStyle HorizontalAlign="Left" Width="12%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Mobile No">
                                    <ItemTemplate>
                                        <asp:Label ID="lblname" runat="server" Text='<%# Bind("MobileNo") %>'></asp:Label>
                                    </ItemTemplate>
                                
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Date">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMeetingDate" runat="server" Text='<%#string.Format("{0:MM/dd/yyyy}",Eval("MeetingDate")) %>'></asp:Label>
                                    </ItemTemplate>
                                
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />
                                </asp:TemplateField>
                                <asp:TemplateField HeaderText="Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMeetingTime" runat="server" Text='<%# Bind("MeetingTime") %>'></asp:Label>
                                    </ItemTemplate>                                
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />
                                </asp:TemplateField>
                                  <asp:TemplateField HeaderText="Comments">
                                    <ItemTemplate>
                                        <asp:Label ID="lblVisitStatus" runat="server" Text='<%# Bind("VisitStatus") %>'></asp:Label>
                                    </ItemTemplate>                                
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="Status">
                                    <ItemTemplate>
                                        <asp:Label ID="lblMeetingStatus" runat="server" Text='<%# Bind("MeetingStatus1") %>'></asp:Label>
                                    </ItemTemplate>                                
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />
                                </asp:TemplateField>
                                 <asp:TemplateField HeaderText="FollowUp Date&Time">
                                    <ItemTemplate>
                                        <asp:Label ID="lblFollowUpdate" runat="server" Text='<%# string.Format("{0:dd-MMM-yyyy}",Eval("FollowUpdate")) + " " +Eval("FollowupTime")%>'></asp:Label>
                                    </ItemTemplate>                                
                                    <ItemStyle HorizontalAlign="Left" Width="15%" />
                                </asp:TemplateField>
                            </Columns>
                          
                        </asp:GridView>


                                            </div>
                     </div>

                </div>
            </div>
        </div>
</asp:Content>

