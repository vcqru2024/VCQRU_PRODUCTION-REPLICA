using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Data;
using Business9420;
using System.Web.Services;
using System.Web.Script.Services;
using System.IO;
using Business_Logic_Layer;
using System.Xml;
using System.Data.OleDb;
using System.Collections;

public partial class TrackTraceUserType : System.Web.UI.Page
{
    public OleDbConnection oledbCon = new OleDbConnection();
    public OleDbCommand oledbCmd = new OleDbCommand();
    private string _prop_Referral;
    public string Prop_ReferralLimit
    {
        get { return (string)ViewState["_prop_Referral"]; }
        set { ViewState["_prop_Referral"] = value; }
    }
    private int _prop_Referralid;
    public int Prop_Referralid
    {
        //get { return _prop_Referralid; }
        //set { _prop_Referralid = value; }
        get {
            if (ViewState["_prop_Referralid"] != null)
                return (int)ViewState["_prop_Referralid"];
            else
                return 0;
        }
        set { ViewState["_prop_Referralid"] = value; }
    }
    public int str = 0, strr = 0,lflag =0; public int index = 0;
    protected void Page_Load(object sender, EventArgs e)
    {  
        if (Session["CompanyId"] == null)
            Response.Redirect("../Info/Login.aspx?Page=RegisteredProduct.aspx");
        else
        {
            if (Session["User_Type"].ToString() == "Admin")
                Response.Redirect("Login.aspx");
        }
        
        if (!Page.IsPostBack)
        {
            
            newMsg.Visible = false;
            BindList();
            BindListboxchannels();
        }        
        Label2.Text = "";
    }
    public void BindList()
    {
        DataTable dt = SQL_DB.ExecuteDataTable("select * from UserType_TrackTrace");
        if (dt.Rows.Count > 0)
        {
            ddlUT.DataSource = dt;
            ddlUT.DataTextField = "type";
            ddlUT.DataValueField = "TTUserTypeid";
            ddlUT.DataBind();
            ddlUT.Items.Insert(0, new ListItem("Select","0"));
        }
    }
    public void BindListboxchannels()
    {

        //DataTable dt2 = SQL_DB.ExecuteDataTable("select * from channels where compid='" + ProjectSession.strCompanyid + "'");
        //if (dt2.Rows.Count > 0)
        //{
        //    lstChannels.DataSource = dt2;
        //    lstChannels.DataTextField = "name";
        //    lstChannels.DataValueField = "ChannelsID";
        //    lstChannels.DataBind();
        //}

    }
    protected void imgNew_Click(object sender, ImageClickEventArgs e)
    {
        
    }
  
    [WebMethod]
    [ScriptMethod]
    public static bool checkNewLabel(string res)
    {
        DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Label_Name] FROM [M_Label] where [Label_Name] = '" + res + "'");
        if (ds.Tables[0].Rows.Count > 0)
            return true;
        else
            return false;
    }
    private void ProductionUnit_XMl(ListBox lst,string strType)
    {
        XmlDocument xmldoc = new XmlDocument();
        XmlElement xmlrootelement = xmldoc.CreateElement("Tab");
        xmldoc.AppendChild(xmlrootelement);

        for (int i = 0; i < lst.Items.Count; i++)
        {
            //   if (lstProfileItemId.Split(',')[i].Length > 0)
            {
                XmlElement child = xmldoc.CreateElement("id");
                child.SetAttribute("name", lst.Items[i].Text);
                if (lst.Items[i].Value.All(char.IsDigit))
                {
                    child.SetAttribute("ProductionOrChannelsID", lst.Items[i].Value);
                }
                else
                {
                    child.SetAttribute("ProductionOrChannelsID", "0");
                }
                             
                child.SetAttribute("index", (i + 1).ToString());
                xmlrootelement.AppendChild(child);
            }

        }

        string xmlLibraryList = xmldoc.OuterXml;
        DateTime Createddate = Convert.ToDateTime(DataProvider.LocalDateTime.Now);//.ToString("yyyy/MM/dd hh:mm:ss tt");
        DataSet ds = ExecuteNonQueryAndDatatable.ProductioOrChannelsInsert(Createddate, ProjectSession.strCompanyid, xmlLibraryList,strType);
        //  if (lstProfileItemId.Split(',').Length >= 1)
        //   {
        //       objTabProfileItemBAL.Insert(xmlLibraryList);
        //    }
    }
    private void UploadExcel(string strFilename,string strType)
    {
        string DbPath = Server.MapPath("~/TrackTrace/" + strFilename);
        //DbPath += "\\" + strFilename;
        //  string DbPath = Server.MapPath("../Data"); //DbPath += "D:\\test\\Data\\" + FileName;
        //DbPath = "D:\\test\\Data\\" + FileName;
        //D:\test\Data\
        //Response.Write(Server.MapPath("../Data"));
        //Response.Write("\\" + FileName);
        //string DbPath = ProjectSession.absoluteSiteBrowseUrl + "/Data" + "/" + FileName;
        // Response.Write(DbPath);
        string ext = Path.GetExtension(DbPath);
        if (ext == ".xlsx")
        {
            oledbCon.ConnectionString = @"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + DbPath + ";Extended Properties=Excel 12.0;";
            //  Response.Write(@"Provider=Microsoft.ACE.OLEDB.12.0;Data Source=" + DbPath + ";Extended Properties=Excel 12.0;");
        }
        if (ext == ".xls")
        {
            oledbCon.ConnectionString = @"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DbPath + ";Extended Properties=Excel 8.0;";
            //  Response.Write(@"Provider=Microsoft.Jet.OLEDB.4.0;Data Source=" + DbPath + ";Extended Properties=Excel 8.0;");
        }
       // SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[Test] ([Remak]) VALUES   ('" + oledbCon.ConnectionString + "')");
        oledbCmd.Connection = oledbCon;
        // DataTable dt = new DataTable();
        try
        {
            if (oledbCon.State == ConnectionState.Open)
                oledbCon.Close();
            oledbCon.Open();
            oledbCmd.CommandText = "Select srno,name,email,mobileno,password,location from [Sheet1$]";
            OleDbDataAdapter objDatAdap = new OleDbDataAdapter();
            objDatAdap.SelectCommand = oledbCmd;
            DataTable dt = new DataTable();
            objDatAdap.Fill(dt);
            oledbCon.Close();

            XmlDocument xmldoc = new XmlDocument();
            XmlElement xmlrootelement = xmldoc.CreateElement("Tab");
            xmldoc.AppendChild(xmlrootelement);

            for (int i = 0; i < dt.Rows.Count; i++)
            {
                if (!string.IsNullOrEmpty(dt.Rows[i]["mobileno"].ToString()))
                //   if (lstProfileItemId.Split(',')[i].Length > 0)
                {
                    XmlElement child = xmldoc.CreateElement("id");
                    child.SetAttribute("name", dt.Rows[i]["name"].ToString());
                    child.SetAttribute("email", dt.Rows[i]["email"].ToString());
                    child.SetAttribute("mobileno", dt.Rows[i]["mobileno"].ToString());
                    child.SetAttribute("password", dt.Rows[i]["password"].ToString());
                    child.SetAttribute("location", dt.Rows[i]["location"].ToString());

                    child.SetAttribute("index", (i + 1).ToString());
                    xmlrootelement.AppendChild(child);
                }

            }

            string xmlLibraryList = xmldoc.OuterXml;
            DateTime Createddate = Convert.ToDateTime(DataProvider.LocalDateTime.Now);//.ToString("yyyy/MM/dd hh:mm:ss tt");
            DataSet ds = ExecuteNonQueryAndDatatable.DistributorRetailerInsert(Createddate, ProjectSession.strCompanyid, xmlLibraryList, Convert.ToInt16(strType));
            //SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[Test] ([Remak]) VALUES   ('Fill Data successfully.')");
        }
        catch (Exception ex)
        {
            throw ex;
           // SQL_DB.ExecuteNonQuery("INSERT INTO [dbo].[Test] ([Remak]) VALUES   ('" + ex.Message.ToString() + "')");
        }
    }
    protected void btnSave_Click(object sender, EventArgs e)
    {
        Loyalty_Settings Reg = new Loyalty_Settings();
        Reg.Comp_ID = Session["CompanyId"].ToString();
        //if (!string.IsNullOrEmpty(txtNoofItems.Text))
        //{
        //    DataTable dt = SQL_DB.ExecuteDataTable("select * from noofitemcartoon where compid='" + ProjectSession.strCompanyid + "'");
        //    if (dt.Rows.Count > 0)
        //    {
        //        SQL_DB.ExecuteDataTable("update noofitemcartoon set NoofItemsPerCartoon = " + txtNoofItems.Text + " where compid='" + ProjectSession.strCompanyid + "' ");
        //    }
        //    else
        //    {
        //        SQL_DB.ExecuteDataTable("insert into noofitemcartoon(compid,NoofItemsPerCartoon) values('" + ProjectSession.strCompanyid + "'," + txtNoofItems.Text + ")");
        //    }
        //}
        //Request.Form[lstProdUnit.UniqueID]
        //if (lstProdUnit.Items.Count > 0)
        //{
        //    ProductionUnit_XMl(lstProdUnit, "production");
        //}
        //if (lstChannels.Items.Count > 0)
        //{
        //    ProductionUnit_XMl(lstChannels, "channels");
        //}
        if (FileUploadDistributor.HasFile)
        {
            string strFilename = FileUploadDistributor.PostedFile.FileName.Replace(" ", "");
            strFilename = Path.GetFileNameWithoutExtension(strFilename) + DateTime.Now.ToString("MMddyyyyhhmmss") + Path.GetExtension(strFilename);
            FileUploadDistributor.SaveAs(Server.MapPath("~/TrackTrace/" + strFilename));
            UploadExcel(strFilename, ddlUT.SelectedItem.Value);//"distributor"
        }
        Response.Redirect("FrmUserTypeTrackTrace.aspx");
        //if (FileUploadRetailer.HasFile)
        //{
        //    string strFilename2 = FileUploadRetailer.PostedFile.FileName.Replace(" ", "");
        //    strFilename2 = Path.GetFileNameWithoutExtension(strFilename2) + DateTime.Now.ToString("MMddyyyyhhmmss") + Path.GetExtension(strFilename2);
        //    FileUploadRetailer.SaveAs(Server.MapPath("~/TrackTrace/" + strFilename2));
        //    UploadExcel(strFilename2, "3");//"retailer"
        //}
        //Label2.Text = "Saved Successfully";
        //newMsg.Visible = true;
        //newMsg.Attributes.Add("class", "alert_boxes_green");
        //string script = @"setTimeout(function(){document.getElementById('" + newMsg.ClientID + "').style.display='none';},5000);";
        //Page.ClientScript.RegisterStartupScript(this.GetType(), "somekey", script, true);
        //BindListboxproductionunit();
        //BindListboxchannels();

    }         
    protected void btnReset_Click(object sender, EventArgs e)
    {
        newMsg.Visible = false;
        //FillGrdLabel(Prop_ReferralLimit);        
    }

    protected void btnAddProduction_Click(object sender, EventArgs e)
    {
    }

    protected void Button1_Click(object sender, EventArgs e)
    {
       
    }

    protected void btnChannels_Click(object sender, EventArgs e)
    {
       
    }

    protected void Button2_Click(object sender, EventArgs e)
    {
        
    }

    protected void ddlUT_SelectedIndexChanged(object sender, EventArgs e)
    {

    }
    protected void btnReset_Click2(object sender, EventArgs e)
    {
        Response.Redirect("FrmUserTypeTrackTrace.aspx");
    }
}