using Business9420;
using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class CodeCheck : System.Web.UI.Page
{
    public static string[] allcodes = new string[2];
    protected void Page_Load(object sender, EventArgs e)
    {

        hdndate1.Value = DateTime.Now.ToString("dd/MM/yyyy");
        bool hasKeys = Request.QueryString.HasKeys();
        if (hasKeys)
        {
            HttpContext.Current.Session["mode"] = "Barcode";
        }
        else
        {
            HttpContext.Current.Session["mode"] = "Website";
        }


        string Code = Request.QueryString["codeone"];
        if (Code != null)
        {


            if (Code.Contains("-"))
                allcodes[0] = Code.Split(new char[] { '-' })[0];
            allcodes[1] = Code.Split(new char[] { '-' })[1];

            HttpContext.Current.Session["Code1"] = null;
            HttpContext.Current.Session["Code2"] = null;
            HttpContext.Current.Session["Code1"] = allcodes[0];
            HttpContext.Current.Session["Code2"] = allcodes[1];

            string result = checkWarranty(allcodes[0], allcodes[1]);

            if (result.Split('&')[1] == "SHRI BALAJI PUBLICATIONS")
            {
                Response.Redirect(string.Format("~/balaji.aspx?Pub_Code=shribalaji&codeone={0}&codetwo={1}", allcodes[0], allcodes[1]));
            }
            if (result.Split('&')[1] == "A TO Z PHARMACEUTICALS")
            {
                Response.Redirect(string.Format("~/fharmaceticals.aspx?ID=fharmaceticals&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "FB Nutrition")
            {
                Response.Redirect(string.Format("~/codeverify.aspx?ID=FBNutrition&codeone={0}&codetwo={1}", allcodes[0], allcodes[1]));
            }
            if (result.Split('&')[1] == "Guru Kripa Enterprises")
            {
                Response.Redirect(string.Format("~/codeverify.aspx?ID=GuruKripaEnterprises&codeone={0}&codetwo={1}", allcodes[0], allcodes[1]));
            }
            if (result.Split('&')[1] == "ROYAL MANUFACTURER")
            {
                Response.Redirect(string.Format("~/codeverify.aspx?ID=ROYALMANUFACTURER&codeone={0}&codetwo={1}", allcodes[0], allcodes[1]));
            }

            if (result.Split('&')[1] == "PARAG MILK FOODS")
            {
                Response.Redirect(string.Format("~/codeverify.aspx?ID=PARAG&codeone={0}&codetwo={1}", allcodes[0], allcodes[1]));
            }

            if (result.Split('&')[1] == "BSC Paints Pvt Ltd")
            {
                Response.Redirect(string.Format("~/BscPaint.aspx?ID=BSC&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "SPORTECH SOLUTIONS")
            {
                Response.Redirect(string.Format("https://thevitamin.co/pages/authenticate?ID=Vitamin&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "RAUNAQ PAINT INDUSTRY")
            {
                Response.Redirect(string.Format("~/Raunak.aspx?ID=raunaq&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            /*
            if (result.Split('&')[1] == "FOREVER NUTRITION")
            {
                Response.Redirect(string.Format("~/Trueforma.html?ID=Truefarma&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
			*/
            if (result.Split('&')[1] == "FOREVER NUTRITION")
            {
                Response.Redirect(string.Format("https://trueforma.in/authenticate?ID=Truefarma&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }

            if (result.Split('&')[1] == "RSR Resource")
            {
                Response.Redirect(string.Format("https://musclemountain.com/pages/authenticity?ID=MuscleMountain&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "ORBIT ELECTRODOMESTICS INDIA")
            {
                Response.Redirect(string.Format("https://www.indiaorbit.in/e-warranty?ID=Orbitindia&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "TECHNICAL MINDS PRIVATE LIMITED")
            {
                Response.Redirect(string.Format("https://hypersonic.club/e-warranty?ID=Hypersonic&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }

            /*if (result.Split('&')[1] == "RSR Resource")
            {
                Response.Redirect(string.Format("~/MuscleMountain.html?ID=MuscleMountain&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            } */


            if (result.Split('&')[1] == "Veena Polymers")
            {
                Response.Redirect(string.Format("~/veena-polymers.aspx?ID=Veena&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }

            if (result.Split('&')[1] == "R.S Industries")
            {
                Response.Redirect(string.Format("~/polytuf_new.aspx?ID=polytuf&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "Jupiter Aqua Lines Ltd")
            {
                Response.Redirect(string.Format("~/JALBATH.aspx?ID=JALBATH&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }

            if (result.Split('&')[1] == "Ankerite Health Care Pvt. Ltd")
            {
                Response.Redirect(string.Format("~/codeverify.aspx?ID=AnkeriteHealth&codeone={0}&codetwo={1}", allcodes[0], allcodes[1]));
            }
            if (result.Split('&')[1] == "Chase2Fit")
            {
                Response.Redirect(string.Format("~/codeverify.aspx?ID=Chase2&codeone={0}&codetwo={1}", allcodes[0], allcodes[1]));
            }

            if (result.Split('&')[1] == "Wudchem Industries Private Limited")
            {
                Response.Redirect(string.Format("~/ChemInd.aspx?ID=WUD&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "Color Valley Coatings")
            {
                Response.Redirect(string.Format("~/colorvalley.aspx?ID=Color&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "SWARAJ")
            {
                Response.Redirect(string.Format("~/Swaraj.aspx?ID=SWARAJ&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "MANGAL DASS TRADING CO")
            {
                Response.Redirect(string.Format("https://nikoltnutrition.com/authenticate?ID=Nikolt&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "Cosmo Tech Expo")
            {
                Response.Redirect(string.Format("~/Cosmo.aspx?ID=Cosmo&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "Pack Plus")
            {
                Response.Redirect(string.Format("~/event/code-check.html?ID=expo&codeone={0}&codetwo={1}", allcodes[0], allcodes[1], result.Split('&')[1]));
                //Response.Redirect(string.Format("~/PackPlus.aspx?ID=PackPlus&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "Ram Gopal and Sons")
            {
                Response.Redirect(string.Format("~/ramgopal.html?ID=ramgopal&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "The Kolorado  Paints")
            {
                Response.Redirect(string.Format("~/Kolorado.aspx?ID=Kolorado&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "Oltimo Lubes")
            {
                Response.Redirect(string.Format("~/Oltimo.aspx?ID=Oltimo&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "BAGHLA SANITARYWARE")
            {
                Response.Redirect(string.Format("~/Baghla.aspx?ID=Bhagla&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "BLUEGEM PAINTS")
            {
                Response.Redirect(string.Format("https://bluegem.in/authenticate?ID=Bluegem&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "1 STOP NUTRITION")
            {
                Response.Redirect(string.Format("~/1stop.aspx?ID=1Stop&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "RELX INDIA PRIVATE LIMITED")
            {
                Response.Redirect(string.Format("https://www.lexisnexis.in/authenticity/?ID=RELX&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "Yava Paints Pvt. Ltd.")
            {
                //Response.Redirect(string.Format("~/yuva-paints.html?ID=YAVA&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
                Response.Redirect(string.Format("http://yavapaints.com/yuva-paints.html?ID=YAVA&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }

            if (result.Split('&')[1] == "Girish Chemical Industries")
            {
                Response.Redirect(string.Format("https://www.gcipaints.com/loyalty?ID=GCI Paint&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "HERBAL AYURVEDA AND RESEARCH CENTER")
            {
                Response.Redirect(string.Format("~/herbal.aspx?ID=Canada_Herbels&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "Wellversed Health Pvt Ltd")
            {
                Response.Redirect(string.Format("https://wellversed.in/pages/authenticator?ID=Wellverse&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "Shree Durga Traders")
            {
                Response.Redirect(string.Format("~/durga.aspx?ID=Durga&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "Gupta edutech Delhi")
            {
                Response.Redirect(string.Format("https://verify.qmaths.in/?ID=Blackbook&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "Paras cosmetics private limited")
            {
                Response.Redirect(string.Format("~/aromacare.aspx?ID=Paras&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            //if (result.Split('&')[1] == "Ram Gopal and Sons")
            //{
            //    Response.Redirect(string.Format("https://www.eagleshenna.com/authenticate?ID=Ramgopal&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            //}


        }
    }


    public static string checkWarranty(string C1, string C2)
    {
        Object9420 Reg = new Object9420();
        Reg.Received_Code1 = (C1.Trim().Replace("'", "''"));
        Reg.Received_Code2 = (C2.Trim().Replace("'", "''"));

        DataSet ds = ServiceLogic.FindCheckedCode_2(Reg);
        DataTable MsgTempdt = Business9420.function9420.GetMessageTemplete(Reg);
        if (ds.Tables[0].Rows.Count == 0)
        {
            Reg.Is_Success = 0;
            //Business9420.function9420.InsertCodeChecked(Reg);
            return ServiceLogic.GetMessageFromM_TemplateMSg(MsgTempdt, C1, C1, "Service_ID='InvalidCode'");
            // result = "Authenticity of the product with Code1- " + Reg.Received_Code1 + " and Code2- " + Reg.Received_Code2 + " can not be guaranteed.";
            // return result; // it should if not graranted shweta

        }
        else
        {
            if (!string.IsNullOrEmpty(C1) && !string.IsNullOrEmpty(C2))
            {
                ds = ExecuteNonQueryAndDatatable.CheckWarranty(C1, C2);
                if (ds.Tables.Count > 0)
                {
                    DataTable dt = ds.Tables[0];
                    if (dt.Rows.Count > 0)
                    {
                        if (dt.Columns.Contains("PlanName"))
                        {
                            string strval = Convert.ToString(dt.Rows[0]["PlanName"]);
                            if (!string.IsNullOrEmpty(strval))
                                return strval;
                            else
                                return "";
                        }
                        else
                        {
                            //string strval = Convert.ToString(dt.Rows[0][1]);
                            string strval = Convert.ToString(dt.Rows[0][0]);
                            if (strval.Split('&').Length > 3)
                                HttpContext.Current.Session["service"] = strval.Split('&')[3];
                            if (!string.IsNullOrEmpty(strval))
                            {
                                if (strval.Split('&').Length > 0)
                                    HttpContext.Current.Session["companyname"] = strval.Split('&')[1];
                                return strval;
                            }
                            else
                                return "";
                        }
                    }
                    else
                    {
                        return "";
                    }
                }
            }
            return "";
        }
    }
}