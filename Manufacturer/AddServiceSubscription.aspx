<%@ Page Title="" Language="C#" MasterPageFile="~/Manufacturer/VendorMaster.master" AutoEventWireup="true" 
    CodeFile="AddServiceSubscription.aspx.cs" Inherits="Manufacturer_AddServiceSubscription" %>
<%@ Register Assembly="AjaxControlToolkit" Namespace="AjaxControlToolkit" TagPrefix="cc1" %>

<asp:Content ID="Content1" ContentPlaceHolderID="head" Runat="Server">
    <script type="text/javascript" >
        var month; //1 3 5 7 8 10 12==31,4 6 9 11==30 2 = 28*
        var day;
        var year;
        function FindInfo() {
            var lep = (parseInt(year) % 4);
            switch (parseInt(month)) {
                case 1: // January
                    {
                        if (day > 31) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 31;
                        }
                    }
                    break;
                case 2: // Febuary
                    {
                        if (parseInt(lep) > 0) {
                            if (day > 28) {
                                month = parseInt(month) + 1;
                                day = parseInt(day) - 28;
                            }
                        }
                        else {
                            if (day > 29) {
                                month = parseInt(month) + 1;
                                day = parseInt(day) - 29;
                            }
                        }
                    }
                    break;
                case 3: // March
                    {
                        if (day > 31) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 31;
                        }
                    }
                    break;
                case 4: // April
                    {
                        if (day > 30) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 30;
                        }
                    }
                    break;
                case 5: // May
                    {
                        if (day > 31) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 31;
                        }
                    }
                    break;
                case 6: // Jun
                    {
                        if (day > 30) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 30;
                        }
                    }
                    break;
                case 7: // July
                    {
                        if (day > 31) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 31;
                        }
                    }
                    break;
                case 8: // August
                    {
                        if (day > 31) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 31;
                        }
                    }
                    break;
                case 9: // September
                    {
                        if (day > 30) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 30;
                        }
                    }
                    break;
                case 10: // October
                    {
                        if (day > 31) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 31;
                        }
                    }
                    break;
                case 11: // November
                    {
                        if (day > 30) {
                            month = parseInt(month) + 1;
                            day = parseInt(day) - 30;
                        }
                    }
                    break;
                default: // December
                    {
                        if (day > 31) {
                            month = parseInt(month) + 1;
                            if (parseInt(month) > 12) {
                                year = parseInt(year) + 1;
                                month = 1;
                            }
                            day = parseInt(day) - 31;
                        }
                    }
            }
            if (month == 0)
                month = 12;
        }
        
    </script>
    <script>
         function SelectSingleRadiobuttonAmc(rdbtnid, PlanTime) {
           
            var p = 0; var mon = 0;
            var rdBtn = document.getElementById(rdbtnid);
            var rdBtnList = document.getElementsByName("rdamcrewaut");
            for (i = 0; i < rdBtnList.length; i++) {
                if (rdBtnList[i].type == "radio" && rdBtnList[i].id != rdBtn.id) {
                    rdBtnList[i].checked = false;
                }
                if (rdBtnList[i].checked == true) {
                    p = i;
                    document.getElementById("<%=HdValAMC1.ClientID %>").value = PlanTime;
                    if (document.getElementById("<%=txtdtfromamc1.ClientID %>").value != "") {
                        var dt = document.getElementById("<%=txtdtfromamc1.ClientID %>").value;
                        var mydate = new Date(dt.substring(6, 10), (parseInt(dt.substring(3, 5)) == 12 ? 11 : parseInt(dt.substring(3, 5))), dt.substring(0, 2));
                        mon = PlanTime;
                        mydate = new Date(mydate.setMonth(mydate.getMonth() + parseInt(mon)));
                        var dateObj = new Date(mydate);
                        month = dateObj.getMonth();
                        day = dateObj.getDate();
                        year = dateObj.getFullYear();
                        FindInfo();
                        if (day > 1) {
                            day = day - 1;
                        }
                        if (month == 11)
                        {
                            month = 12;
                        }
                        else {
                            day = day;
                        }
                       // var newdate = FindVal((day > 1 ? day - 1 : day)).toString() + "/" + FindVal((month == 11 ? 12 : month)).toString() + "/" + year;
                       var newdate =  day.toString() + "/" + month.toString() + "/" + year;
                        document.getElementById("<%=txtdttoamc1.ClientID %>").value = newdate;
                        document.getElementById("<%=HdDateTo1.ClientID %>").value = newdate;

                        document.getElementById("<%=Label8.ClientID %>").innerHTML = "";
                        document.getElementById("<%=Div2.ClientID %>").className = "";
                    }
                    else {
                        document.getElementById("<%=Label8.ClientID %>").innerHTML = "Please select AMC Plan Date From for product " + document.getElementById("<%=txtProName.ClientID %>").value;
                        document.getElementById("<%=Div2.ClientID %>").className = "alert_boxes_pink big_msg";
                    }
                }
            }
            CheckValidation();
         }

        function CheckValidation() {
            var plan = document.getElementById("<%=HdValAMC1.ClientID %>").value;
            var pro = document.getElementById("<%=ddlProSelect.ClientID %>").value;
            var terms = document.getElementById("<%=chkterms.ClientID %>").checked;
            if (pro == "--Select--") {
                document.getElementById("<%=Label8.ClientID %>").innerHTML = "Please select Product!";
                document.getElementById("<%=Div2.ClientID %>").className = "alert_boxes_pink big_msg alert_boxes_green";
                document.getElementById("<%=btnAmcRenewal.ClientID %>").disabled = true;
                document.getElementById("<%=btnAmcRenewal.ClientID %>").className = "btn btn-primary mr-2";
            }
            else if (plan == "") {
                document.getElementById("<%=Label8.ClientID %>").innerHTML = "Please select Plan!";
                document.getElementById("<%=Div2.ClientID %>").className = "alert_boxes_pink big_msg";
                document.getElementById("<%=btnAmcRenewal.ClientID %>").disabled = true;
                document.getElementById("<%=btnAmcRenewal.ClientID %>").className = "btn btn-primary mr-2";
            }
            else if (terms == false) {
                document.getElementById("<%=Label8.ClientID %>").innerHTML = "Accept Terms & Conditions!";
                document.getElementById("<%=Div2.ClientID %>").className = "alert_boxes_pink big_msg alert_boxes_magenta";
                document.getElementById("<%=btnAmcRenewal.ClientID %>").disabled = true;
                document.getElementById("<%=btnAmcRenewal.ClientID %>").className = "btn btn-primary mr-2";
            }
            else {
                document.getElementById("<%=Label8.ClientID %>").innerHTML = "";
                document.getElementById("<%=Div2.ClientID %>").className = "";
                document.getElementById("<%=btnAmcRenewal.ClientID %>").disabled = false;
                document.getElementById("<%=btnAmcRenewal.ClientID %>").className = "btn btn-primary mr-2";
            }
        }
        function FindNextDateAmc(dt) {
            debugger;
            var selectedDate = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)) - 1, dt.substring(0, 2));
            var today = new Date();
            today.setHours(0, 0, 0, 0);
            if (selectedDate < today) {
                document.getElementById("<%=Label8.ClientID %>").innerHTML = "Select current date or bigger than Current date!";
                document.getElementById("<%=txtdtfromamc1.ClientID %>").value = "";
                document.getElementById("<%=Div2.ClientID %>").className = "alert_boxes_pink big_msg";
                document.getElementById("<%=btnAmcRenewal.ClientID %>").disabled = true;
                document.getElementById("<%=btnAmcRenewal.ClientID %>").className = "btn btn-primary mr-2";
                return;
            }
            else {
                document.getElementById("<%=Label8.ClientID %>").innerHTML = "";
                document.getElementById("<%=Div2.ClientID %>").className = "";
                document.getElementById("<%=btnAmcRenewal.ClientID %>").disabled = false;
                document.getElementById("<%=btnAmcRenewal.ClientID %>").className = "btn btn-primary mr-2";
            }
            var p = document.getElementById("<%=HdValAMC1.ClientID %>").value;
            if (parseInt(p) >= 0) {
                var mydate1 = new Date(dt.substring(6, 10), parseInt(dt.substring(3, 5)), dt.substring(0, 2));
                mon = p;  //mon = FinfMonth(p);
                var mydate = new Date(mydate1.setMonth(mydate1.getMonth() + parseInt(mon)));
                var dateObj = new Date(mydate);
                month = dateObj.getMonth();
                day = dateObj.getDate();
                year = dateObj.getFullYear();
                FindInfo();
                
                var newdate =  FindVal(day).toString() + "/" + FindVal(month).toString() + "/" + year;
                document.getElementById("<%=txtdttoamc1.ClientID %>").value = newdate;
                document.getElementById("<%=HdDateTo1.ClientID %>").value = newdate;

                document.getElementById("<%=Label8.ClientID %>").innerHTML = "";
                document.getElementById("<%=Div2.ClientID %>").className = "";
            }
            CheckValidation();
        }    
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" Runat="Server">
    
   
      
          
        <div id="page-content-wrapper">
         <div class="container-fluid xyz">
            <div class="row">
               <div class="col-lg-12">
                   <asp:label id="lbltestcontrol" runat="server"></asp:label>
          <asp:label id="lblctrlplgrw" runat="server"></asp:label>
                <div class="card card-admin form-wizard profile box_card">


                      <header class="card-header">
                        <h4 class="card-title"><i class="fa fa-pencil-square-o"></i>Add/Subscribe Service</h4>
                    </header>
                     <div id="NewMsgpop" runat="server">
                                <p>
                                    <asp:Label ID="lblplgrw" runat="server"></asp:Label>
                                </p>
                            </div>
                      
                       <div  class="card-body card-body-nopadding">
                            <%--<div class="form-row">
                              <div class="form-group col-lg-12">
                                  <asp:Label ID="lblplgrw" runat="server" Font-Bold="true" Text="Plan Details"></asp:Label>
                                  <asp:Label ID="Label8" runat="server"></asp:Label>
                                  </div>
                                </div>--%>
                           <div id="Div2" runat="server">
                                    <p>
                                        <asp:Label ID="Label8" runat="server"></asp:Label></p>
                                </div>
                            <div class="form-row">
                               <div class="form-group col-lg-6">
                                    <span class="req">*</span><label>Select Service</label>
                                   <asp:DropDownList ID="ddlService" runat="server" class="form-control form-control-sm"  AutoPostBack="true" OnSelectedIndexChanged="ddlService_SelectedIndexChanged">
                                   </asp:DropDownList>
                                   <asp:RequiredFieldValidator ID="RequiredFieldValidator1" ErrorMessage="*" ForeColor="Red"
                                       runat="server" ControlToValidate="ddlService"
                                       ValidationGroup="SSP" InitialValue="0"></asp:RequiredFieldValidator>
                                   </div>
                                <div class="form-group col-lg-6">
                                   <span class="req">*</span><label>Product</label>
                                   <asp:DropDownList ID="ddlProSelect" runat="server" class="form-control form-control-sm" onchange="javascript:CheckValidation()">
                                   </asp:DropDownList>
                                   <asp:RequiredFieldValidator ID="ReqFielValidator1" ErrorMessage="*" ForeColor="Red"
                                       runat="server" ControlToValidate="ddlProSelect"
                                       ValidationGroup="SSP" InitialValue="--Select--"></asp:RequiredFieldValidator>
                               </div>
                                </div>

                           <div class="table-responsive">
                 <h5>Select Plan</h5>
                 <%-- <div class="col-lg-12 card card-admin form-wizard medias">--%>
                     <asp:GridView ID="PlanGridViewDetails" runat="server" AutoGenerateColumns="False"
                                                DataKeyNames="Plan_ID,Disp"  CssClass="table table-striped table-bordered" EmptyDataText="Record Not Found"
                                               BorderColor="transparent" 
                                                OnRowCommand="PlanGridViewDetails_RowCommand" >
                                                <Columns>
                                                    <asp:TemplateField HeaderText="Action">
                                                        <ItemTemplate>
                                                            <%try
                                                              {
                                                                  PlanID = PlanGridViewDetails.DataKeys[upplanindex].Values["Plan_ID"].ToString();//LabelFlag 
                                                                  Disp = Convert.ToInt32(PlanGridViewDetails.DataKeys[upplanindex].Values["Disp"].ToString());
                                                              }
                                                              catch { }
                                                              if (Session["Plan_ID"].ToString() == PlanID)
                                                              {
                                                                  Disp = 1;
                                                                  if (Disp == 0)
                                                                  {
                                                            %>
                                                            <input type="radio" id="rdamcrenewalautasd" name="rdamcrewaut" checked="checked"
                                                                value='<%# Eval("PlanPeriod") %>' onclick="javascript: SelectSingleRadiobuttonAmc(this.id, this.value)" />
                                                            <%
                                                                }
                                                                  else
                                                                  {%>
                                                            <input type="radio" id="Radio1" name="rdamcrewaut" checked="checked" disabled="disabled"
                                                                value='<%# Eval("PlanPeriod") %>' onclick="javascript:SelectSingleRadiobuttonAmc(this.id,this.value)" />
                                                            <%
                                                                }
                                                              }
                                                              else
                                                              {
                                                                  if (Disp == 0)
                                                                  {%>
                                                            <input type="radio" id="Rrdamcrenewalaut" name="rdamcrewaut" value='<%# Eval("PlanPeriod") %>'
                                                                onclick="javascript:SelectSingleRadiobuttonAmc(this.id,this.value)" />
                                                            <% }
                                                                  else
                                                                  {%>
                                                            <input type="radio" id="Radio2" name="rdamcrewaut" disabled="disabled" value='<%# Eval("PlanPeriod") %>'
                                                                onclick="javascript: SelectSingleRadiobuttonAmc(this.id, this.value)" />
                                                            <%}
                                                              }%>
                                                            <%upplanindex++; %>
                                                            <asp:Label ID="lblrenewalPlanIDasd" runat="server" Text='<%# Bind("Plan_ID") %>'
                                                                Visible="false"></asp:Label>
                                                        </ItemTemplate>
                                                        <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                        <ItemStyle HorizontalAlign="Center" Width="5%" />
                                                    </asp:TemplateField>
                                                    <%--<asp:TemplateField HeaderText="S.No">
                                            <ItemTemplate>
                                                <%=++sno %>
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />
                                            <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="4%" />
                                        </asp:TemplateField>--%>
                                                    <asp:TemplateField HeaderText="Plan Name">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lbladdsrvtitleasd" runat="server" Text='<%# Bind("PlanName") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                                        <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Plan Time(In Months)">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblplntime" runat="server" Text='<%# Bind("PlanPeriod") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Center" />--%>
                                                        <ItemStyle HorizontalAlign="Center" CssClass="grd_pad" Width="15%" />
                                                    </asp:TemplateField>
                                                    <asp:TemplateField HeaderText="Price">
                                                        <ItemTemplate>
                                                            <asp:Label ID="lblplnprice" runat="server" Text='<%# Bind("PlanPrice") %>'></asp:Label>
                                                        </ItemTemplate>
                                                        <%--<HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />--%>
                                                        <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="7%" />
                                                    </asp:TemplateField>
                                                    <%--<asp:TemplateField HeaderText="Action">
                                            <ItemTemplate>
                                                <asp:Button ID="ImgbtnRedeem" runat="server" CommandArgument='<%# Bind("Plan_ID") %>'
                                                    CausesValidation="false" CommandName="BuyService" ToolTip="Redeem Awards" Text="Buy Now"
                                                    CssClass="redeem" />&nbsp;
                                            </ItemTemplate>
                                            <HeaderStyle CssClass="tr_haed" HorizontalAlign="Justify" />
                                            <ItemStyle HorizontalAlign="Justify" CssClass="grd_pad" Width="7%" />
                                        </asp:TemplateField>--%>
                                                </Columns>
                                                <%--<PagerStyle HorizontalAlign="Center" CssClass="pagination" />
                                                <RowStyle CssClass="tr_line1" />
                                                <AlternatingRowStyle CssClass="tr_line2" />--%>
                                            </asp:GridView>
                      <%--</div>

                 <div class="col-lg-12 card card-admin form-wizard profile">--%>
                   </div>


                           <div  class="card-body-nopadding">
                           <div class="form-row">
                              <div class="col-lg-2">
                                 <span class="req"></span><label>Plan Period</label>
                                  </div>
                                   <div class="form-group col-lg-4">
                                    <asp:TextBox ID="txtdtfromamc1" onchange="FindNextDateAmc(this.value);" runat="server"
                                                onkeydown="return checkShortcut();" class="form-control form-control-sm"></asp:TextBox>
                                       </div> 
                                       <div class="form-group col-lg-1 text-center">
                                           To </div>
                                             <div class="form-group col-lg-4">
                                            <asp:TextBox ID="txtdttoamc1"  runat="server" class="form-control form-control-sm"></asp:TextBox>
                                           </div>
                                             <div class="form-group col-lg-1">
                                           
                                    <asp:HiddenField ID="HdValAMC1" runat="server" />
                                                 
                                            <asp:HiddenField ID="HdDateTo1" runat="server" />
                                  <asp:TextBox ID="txtProName" runat="server" Style="display: none;"></asp:TextBox>
                                  </div>
                                </div>
                            <div class="form-row">
                              <div class="form-group col-lg-6">
                                   <asp:CheckBox ID="chkterms" runat="server"  onchange="javascript:CheckValidation()" /><a
                                                href="#"> Terms &amp; Condiions</a>
                                            
                                  </div>
                                <div class="col-lg-6 text-right">
                                <div class="form-group">
                                  <asp:Button ID="btnAmcRenewal" ValidationGroup="SSP" runat="server" Text="Submit"
                                                OnClick="Submit_Click" class="btn btn-primary mr-2"  />
                                    <asp:Button ID="btnCancel"  runat="server" Text="Cancel"
                                                OnClick="btnCancel_Click" class="btn btn-success"  />
                                  </div>
                              
                                </div>
                            </div>
                       </div>
                          
                       </div>

                    <%--</div>--%>

                
                       
                 </div>
                </div>
            </div>
          </div>
            </div>
               <asp:HiddenField ID="ActionText" runat="server" />
                <asp:HiddenField ID="IsAct" runat="server" />
                <asp:Label ID="lblproiddel" runat="server" Visible="false"></asp:Label>
                <asp:HiddenField ID="currindex" runat="server" />
                <asp:HiddenField ID="lblproidamc" runat="server" />
                <asp:HiddenField ID="hhdnCompID" runat="server" />
                <asp:HiddenField ID="selsrvid" runat="server"  />
                <asp:HiddenField ID="selsrvplanid" runat="server" />

                              <asp:HiddenField ID="docflag" runat="server" />
                <asp:HiddenField ID="HdFieldAmcId" runat="server" />
                <asp:HiddenField ID="HdFieldOfferId" runat="server" />
                <asp:HiddenField ID="hdnpointsval" runat="server" />        

                    
</asp:Content>

