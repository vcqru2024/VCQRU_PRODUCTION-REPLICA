using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class Manufacturer_VendorCodeStatus : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (Session["CompanyId"] == null)
            Response.Redirect("/Login.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }

        //textcodeone.Text = "";
        //textcodeTwo.Text = "";

        //GrdCodeEnquiry.DataSource = "";
        //GrdCodeEnquiry.DataBind();
    }

    //private void fillData()
    //{


    //    if (ds.Tables[0].Rows.Count > 0)
    //        GrdEnquiry.DataSource = ds.Tables[0];
    //    GrdEnquiry.DataBind();
    //    lblcount.Text = GrdEnquiry.Rows.Count.ToString();
    //    //if (GrdEnquiry.Rows.Count > 0)
    //    //    GrdEnquiry.HeaderRow.TableSection = TableRowSection.TableHeader;

    //}
    protected void ImgSearch_Click(object sender, ImageClickEventArgs e)
    {

        string Code1 = textcodeone.Text.Trim();
        string Code2 = textcodeTwo.Text.Trim();

        if (Code1 != "" && Code2 != "")
        {
 #region //** LexisNexis
            DataTable dtdealer = new DataTable();
            if (Convert.ToString(Session["CompanyId"]) == "Comp-1595")
                 dtdealer = SQL_DB.ExecuteDataTable("select CONVERT(VARCHAR(20), Enq_Date, 113) as EnqDate,MobileNo='',Comp_Reg.Comp_Name,Pro_Name,Dial_Mode, Received_Code1, Received_Code2, case when Is_Success= 1 then 'Success' when Is_Success= 2 then 'UnSuccess'  else 'Failed' end as Is_Success from Pro_Enq(Nolock) left join M_Code on M_Code.Code1 = Pro_Enq.Received_Code1 and M_Code.Code2 = Pro_Enq.Received_Code2 left join Pro_Reg on Pro_Reg.Pro_ID = M_Code.Pro_ID left join Comp_Reg on Comp_Reg.Comp_ID = Pro_Reg.Comp_ID where pro_enq.Received_Code1 = '" + Code1 + "' and Pro_Enq.Received_Code2 = '" + Code2 + "' order by Enq_Date desc");
            #endregion
            else
            dtdealer = SQL_DB.ExecuteDataTable("select CONVERT(VARCHAR(20), Enq_Date, 113) as EnqDate,MobileNo,Comp_Reg.Comp_Name,Pro_Name,Dial_Mode, Received_Code1, Received_Code2, case when Is_Success= 1 then 'Success' when Is_Success= 2 then 'UnSuccess'  else 'Failed' end as Is_Success from Pro_Enq(Nolock) left join M_Code on M_Code.Code1 = Pro_Enq.Received_Code1 and M_Code.Code2 = Pro_Enq.Received_Code2 left join Pro_Reg on Pro_Reg.Pro_ID = M_Code.Pro_ID left join Comp_Reg on Comp_Reg.Comp_ID = Pro_Reg.Comp_ID where pro_enq.Received_Code1 = '" + Code1 + "' and Pro_Enq.Received_Code2 = '" + Code2 + "' order by Enq_Date desc");

            if (dtdealer.Rows.Count != 0)
            {
                GrdCodeEnquiry.DataSource = dtdealer;
                GrdCodeEnquiry.DataBind();

            }

            if (GrdCodeEnquiry.Rows.Count > 0)
                GrdCodeEnquiry.HeaderRow.TableSection = TableRowSection.TableHeader;
        }
        else
        {
            LblMsg.Text = "Please Fill Code 1 and Code 2 Both";
            LblMsg.Visible = true;
            GrdCodeEnquiry.DataSource = "";
            GrdCodeEnquiry.DataBind();
        }




    }

    protected void ImgRefresh_Click(object sender, ImageClickEventArgs e)
    {
        textcodeone.Text = "";
        textcodeTwo.Text = "";
        GrdCodeEnquiry.DataSource = "";
        GrdCodeEnquiry.DataBind();
    }
}