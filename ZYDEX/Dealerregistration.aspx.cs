using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;

public partial class ZYDEX_Dealerregistration : System.Web.UI.Page
{
    cls_Zydex db = new cls_Zydex();
    cls_Validation _val = new cls_Validation();
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("~/ZYDEX/Login.aspx");
        if (!IsPostBack)
        {
            bindgrid();
            bindstate();
           // ddlcity.Enabled = false;
           // ddlcity.Items.Insert(0, new ListItem("--Select City--", "0"));
        }
    }
    public void bindgrid()
    {
        DataTable dtdealer = SQL_DB.ExecuteDataTable("select*from Dealerdetailssagar where  Isdelete=0 and Comp_ID='" + Session["CompanyId"].ToString() + "' order by id desc");
        if (dtdealer.Rows.Count > 0)
        {
            rptData.DataSource = dtdealer;
            rptData.DataBind();
        }
    }
    public void bindstate()
    {
        DataTable dtstate = SQL_DB.ExecuteDataTable(" select State_Id,StateName from StateMaster where Flag=1");
        if (dtstate.Rows.Count > 0)
        {
            ddlstate.DataSource = dtstate;
            ddlstate.DataTextField = "StateName";
            ddlstate.DataValueField = "State_Id";
            ddlstate.DataBind();
            ddlstate.Items.Insert(0, new ListItem("--Select State--", "0"));
            ddlstate.SelectedIndex = 0;
            ddlstate.Items[0].Attributes["disabled"] = "disabled";
        }
    }

    //public void bindcity(string Stateid)
    //{

    //    DataTable dtcity = SQL_DB.ExecuteDataTable(" select City_Id,CityName from CityMaster where Flag=1 and State_Id='" + Stateid + "'");
    //    if (dtcity.Rows.Count > 0)
    //    {
    //        ddlcity.DataSource = dtcity;
    //        ddlcity.DataTextField = "CityName";
    //        ddlcity.DataValueField = "City_Id";
    //        ddlcity.DataBind();
    //        ddlcity.Items.Insert(0, new ListItem("--Select City--", "0"));
    //        ddlcity.SelectedIndex = 0;
    //        ddlcity.Items[0].Attributes["disabled"] = "disabled";
    //        ddlcity.Enabled = true;
    //    }
    //}

    protected void btnsave_Click(object sender, EventArgs e)
    {
        if(txtgst.Text == "Invalid")
        {
            ClearForm();
            return;
        }
        string PanNO = txtgst.Text;
        string DealerName = txtDealer.Text;
        string MobileNo = txtMobile.Text;
        string State = ddlstate.SelectedItem.Text;
        // string City = ddlcity.SelectedItem.Text;
        string City = txtcity.Text.Trim();
        if (string.IsNullOrEmpty(PanNO))
        {
            db.ShowErrorMessage(this, "Please Enter SAP Dealer Code");
            return;
        }
        //else if (!_val.IsValidPAN(PanNO))
        //{
        //    db.ShowErrorMessage(this, "Please Enter Valid Pan Card Number");
        //    return;
        //}
        else if (string.IsNullOrEmpty(DealerName))
        {
            db.ShowErrorMessage(this, "Please Enter Dealer Name");
            return;
        }
        else if (!_val.IsValidUserName(DealerName))
        {
            db.ShowErrorMessage(this, "Please Enter Valid Dealer Name");
            return;
        }
        else if (string.IsNullOrEmpty(MobileNo))
        {
            db.ShowErrorMessage(this, "Please Enter Mobile Number");
            return;
        }
        else if (!_val.IsMobileNumberValid(MobileNo))
        {
            db.ShowErrorMessage(this, "Please Enter Valid Mobile Number");
            return;
        }
        if (string.IsNullOrEmpty(txtcluster.Text))
        {
            db.ShowErrorMessage(this, "Please Enter Cluster");
            return;
        }
        else if (State == "--Select State--")
        {
            db.ShowErrorMessage(this, "Please Select State");
            return;
        }
        else if (string.IsNullOrEmpty(City))
        {
            db.ShowErrorMessage(this, "Please Enter City Name");
            return;
        }
        else if (!_val.IsValidUserName(City))
        {
            db.ShowErrorMessage(this, "Please Enter Valid City Name");
            return;
        }
        else
        {
            if (Page.IsValid)
            {
                if (MobileNo.Length == 10)
                    MobileNo = "91" + MobileNo;
                DataTable dtchk = SQL_DB.ExecuteDataTable("exec USP_CHKDealder '" + MobileNo + "','" + PanNO + "','" + Session["CompanyId"].ToString() + "'");
                if (dtchk.Rows[0]["Result"].ToString() == "Valid")
                {
                    SQL_DB.ExecuteNonQuery("insert into Dealerdetailssagar ([Dealer Code],[Dealer Name],MOBILENO,State,City,Comp_ID,Location) values('" + PanNO + "','" + DealerName + "','" + MobileNo + "','" + State + "','" + City + "','" + Session["CompanyId"].ToString() + "','" + txtcluster.Text + "')");
                    ClearForm();
                    db.ShowSuccessMessagewithredirect(this, "Dealer Registration Successfully Completed", "../ZYDEX/Dealerregistration.aspx");
                }
                else
                {
                    db.ShowErrorMessage(this, dtchk.Rows[0]["Result"].ToString());
                }
                System.Threading.Thread.Sleep(3000);
            }
        }
    }


    private void ClearForm()
    {
        txtgst.Text = "";
        txtDealer.Text = "";
        txtMobile.Text = "";
        ddlstate.ClearSelection();
       // ddlcity.ClearSelection();
        txtcluster.Text = "";
        txtcity.Text = "";
    }
    protected void gvNewUser_ItemDataBound(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            var isActive = Convert.ToBoolean(DataBinder.Eval(e.Item.DataItem, "Isactive"));
            var userId = DataBinder.Eval(e.Item.DataItem, "Id").ToString();
            var ltToggleAction = e.Item.FindControl("ltToggleAction") as Literal;

            if (ltToggleAction != null)
            {
                var color = isActive ? "green" : "red";
                ltToggleAction.Text = string.Format(
                    "<button type='button' class='btn btn-toggle p-0 border-0 w-100 text-center' onclick='UpdateUserstatus(\"{0}\")' style='color: {1};'>" +
                    "<i class='{2} fs-1'></i></button>",
                    userId, color, isActive ? "bx bxs-toggle-right" : "bx bxs-toggle-left");
            }
        }
    }




    protected void gvNewUser_ItemDataBoundold(object sender, RepeaterItemEventArgs e)
    {
        if (e.Item.ItemType == ListItemType.Item || e.Item.ItemType == ListItemType.AlternatingItem)
        {
            var isActive = Convert.ToBoolean(DataBinder.Eval(e.Item.DataItem, "IsActive"));
            var userId = DataBinder.Eval(e.Item.DataItem, "ID").ToString();
            var ltToggleAction = e.Item.FindControl("ltToggleAction") as Literal;

            if (ltToggleAction != null)
            {
                var color = isActive ? "green" : "red";
                ltToggleAction.Text = string.Format("<a type='button' class='dropdown-item' href='javascript:void(0);' onclick='UpdateUserstatus(\"{1}\")' style='color: {4};'>" +
                                                    "<i class='fas {2}'></i> {3}</a>",
                                                    userId,
                                                    isActive.ToString().ToLower(),
                                                     isActive ? "fa-toggle-on" : "fa-toggle-off",
                                                    isActive ? "Deactivate" : "Activate",
                                                    color);
            }
        }
    }


    protected void ddlstate_SelectedIndexChanged(object sender, EventArgs e)
    {
        //bindcity(ddlstate.SelectedItem.Value);
    }
}