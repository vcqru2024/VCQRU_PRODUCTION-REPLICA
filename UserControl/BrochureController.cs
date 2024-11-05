using System;
using Newtonsoft.Json.Linq;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using VcqruApi.Models;
using System.Data;

namespace VcqruApi.Controllers
{
    public class BrochureController : ApiController
    {
        Dbstring db = new Dbstring();

        public class RResponse
        {
            public bool Status { get; set; }
            public string Message { get; set; }
            public Object Data { get; set; }
        }


        RResponse Res = new RResponse();

        [HttpPost]
        public RResponse Brochure(JObject obj)
        {
            try
            {
                // string msg = "";
                string Compid = obj["compid"].ToString();
                // Brochure^Unique Key
                //*******************Checksum******************************************************************* 

                string Input = Checksum.MakeChecksumString("Brochure", Checksum.checksumKey);
                string EncData = db.ConvertStringToSCH512Hash(Input);
                if (obj["EncData"].ToString().Trim() != EncData)
                {
                    Res.Status = false;
                    Res.Message = "Invalid Request";
                    return Res;
                }
                //************************************************************************************************
                DataTable dt = new DataTable();
                dt = db.SelectTableData("Brochure", "*", "Comp_Id='" + Compid + "'");
                if (dt.Rows.Count > 0)
                {
                    Res.Status = true;
                    Res.Message = "Success";
                    Res.Data = dt;
                    // return Res;
                }
                else
                {
                    Res.Status = false;
                    Res.Message = "Record not available";

                }



                return Res;

            }
            catch (Exception ex)
            {
                Dbstring.ExceptionLogs("Find Error in  PointChart api with | " + ex.Message.ToString());
                Res.Status = false;
                Res.Message = ex.Message;
                Res.Data = ex.StackTrace;
                return Res;
            }
        }
    }
}