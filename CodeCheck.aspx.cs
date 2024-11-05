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
            if (result.Split('&')[1] == "PRINCIPLE ADHESIVES PRIVATE LIMITED")
            {
                Response.Redirect(string.Format("https://princecol.com/loyaltyprinciple.php?ID=PRINCIPLEADHESIVESPRIVATELIMITED&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
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
            //max paints redirection
            if (result.Split('&')[1] == "DURGA COLOUR AND CHEM.P LTD.")
            {
                Response.Redirect(string.Format("~/MaxPaints.html?ID=MaxPaint&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "OCI Wires and Cables")
            {
                Response.Redirect(string.Format("~/Oci.html?ID=OCI Wires and Cables&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "MANGAL DASS TRADING CO")
            {
                Response.Redirect(string.Format("https://nikoltnutrition.com/authenticate?ID=Nikolt&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "Cosmo Tech Expo")
            {
                Response.Redirect(string.Format("~/PackPlus.aspx?ID=Cosmo&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
                //Response.Redirect(string.Format("~/Cosmo.aspx?ID=Cosmo&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
                // Response.Redirect(string.Format("~/ihff-event.aspx?ID=Cosmo&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "Cosmo Tech Expo")
            {
                Response.Redirect(string.Format("~/PackPlus.aspx?ID=Cosmo&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
                // Response.Redirect(string.Format("~/ihff-event.aspx?ID=Cosmo&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "Ram Gopal and Sons")
            {
                Response.Redirect(string.Format("~/ramgopal.html?ID=ramgopal&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "MIDAS TOUCH METALLOYS PRIVATE LIMITED")
            {
                Response.Redirect(string.Format("~/scotts.html?ID=MIDAS TOUCH&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "The Kolorado  Paints")
            {
                Response.Redirect(string.Format("~/Kolorado.aspx?ID=Kolorado&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "SHERKOTTI INDUSTRIES PRIVATE LIMITED")
            {
                Response.Redirect(string.Format("~/sherkotti.aspx?ID=SHERKOTTI INDUSTRIES PRIVATE LIMITED&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "Oltimo Lubes")
            {
                Response.Redirect(string.Format("~/Oltimo.aspx?ID=Oltimo&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            else if (result.Split('&')[1] == "VCQRU")
            {
                Response.Redirect(string.Format("~/UPI-cashback.aspx?ID=VCQRU&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "BAGHLA SANITARYWARE")
            {
                Response.Redirect(string.Format("~/Baghla.aspx?ID=Bhagla&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "Indian Plywood Company")
            {
                Response.Redirect(string.Format("https://www.indianplywoodcompany.com/authenticate.html?ID=Indianplywood&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "Helix")
            {
                Response.Redirect(string.Format("~/Helix.aspx?ID=Helix&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "PROQUEST NUTRITION PRIVATE LIMITED")
            {
                Response.Redirect(string.Format("https://www.proquest.fit/check-authenticity?ID=ProquestNutritionPvtLtd&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "CHERYL CHEMICAL AND POLYMERS")
            {
                Response.Redirect(string.Format("~/hiffix.aspx?ID=CHERYL CHEMICAL AND POLYMERS&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "Muscle Garage")
            {
                Response.Redirect(string.Format("~/musclegarage.aspx?ID=musclegarage&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "FITSIQUE")
            {
                Response.Redirect(string.Format("https://fitsique.in/authenticate?ID=FITSIQUE?ID=FITSIQUE&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "TRUE NUTRITION PERFORMANCE PRIVATE LIMITED")
            {
                Response.Redirect(string.Format("~/TrueNutrition.aspx?ID=TRUE NUTRITION PERFORMANCE PRIVATE LIMITED&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "MAHAVIR PAINTS AND ADHESIVES")
            {
                Response.Redirect(string.Format("~/mahavirpaint.html?ID=Mahavirpaint&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
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
            if (result.Split('&')[1] == "Muscle Fighter Nutrition")
            {
                Response.Redirect(string.Format("https://musclefighternutrition.com/authenticity?ID=musclefighter&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "MITHILA PAINTS PRIVATE LIMITED")
            {
                Response.Redirect(string.Format("https://mithilapaints.com/loyality?ID=Mithala&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "SAMSOIL PETROLEUM INDIA LTD")
            {
                Response.Redirect(string.Format("~/Samsoils.aspx?ID=Samsoil&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "SAFFRO MELLOW COATINGS AND RESINS")
            {
                Response.Redirect(string.Format("https://saffromellow.com/loyalty/?ID=saffro mellow&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "Big Daddy Overseas")
            {
                Response.Redirect(string.Format("~/bigdaddy.html?ID=BigDaddy&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            else if (result.Split('&')[1] == "HANNOVER CHEMIKALIEN PRIVATE LIMITED")
            {
                Response.Redirect(string.Format("~/hannover.aspx?ID=hanover&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            if (result.Split('&')[1] == "SRI ANANTHA PADMANABHA SWAMY ENTERPRISES")
            {
                Response.Redirect(string.Format("~/vscpaint.html?ID=VSCPaint&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            else if (result.Split('&')[1] == "BENITTON BATHWARE")
            {
                Response.Redirect(string.Format("https://benittonbathware.com/loyalty/?ID=benittion&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            else if (result.Split('&')[1] == "RANDHAWA SWEETS")
            {
                Response.Redirect(string.Format("https://www.randhawasweets.com/authenticity/?ID=Randhawasweets&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            else if (result.Split('&')[1] == "YAMUNA INTERIORS PRIVATE LIMITED")
            {
                Response.Redirect(string.Format("~/blackcobraretail.aspx?ID=blackcobraretail&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            else if (result.Split('&')[1] == "Yamuna Interiors Pvt Ltd G")
            {
                Response.Redirect(string.Format("~/blackcobragov.aspx?ID=blackcobragov&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            else if (result.Split('&')[1] == "TESLA POWER INDIA PRIVATE LIMITED")
            {
                Response.Redirect(string.Format("https://autoz365.com/scheme/tesla1.html?ID=Tesla&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }
            else if (result.Split('&')[1] == "Fit Fleet")
            {
                Response.Redirect(string.Format("~/fit-fleet.aspx?ID=FitFleet&codeone={0}&codetwo={1}&Comp={2}", allcodes[0], allcodes[1], result.Split('&')[1]));
            }


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