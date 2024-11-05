using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Query_responses
/// </summary>
public class Query_responses
{
    public string totalCode { get; set; }
	public string successCode { get; set; }
	public string totalCash { get; set; }
	public string transferredCash { get; set; }
	public string totalPoint { get; set; }
	public string reedemPoint { get; set; }
	public string totalWarranty { get; set; }
	public string underWarranty { get; set; }
	public string totalcounterfeit { get; set; }
	public string successcounterfeit { get; set; }
	public Query_responses()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}
public class bank_responses
{
	public string Bank_ID { get; set; }
	public string Bank_Name { get; set; }
	public string Account_HolderNm { get; set; }
	public string Account_No { get; set; }
	public string Branch { get; set; }
	public string IFSC_Code { get; set; }
	public string City { get; set; }
	public string RTGS_Code { get; set; }
	public string Address { get; set; }
	public string Account_Type { get; set; }
	public string chkpassbook { get; set; }
	public int M_ConsumeriD { get; set; }
	public string DML { get; set; }
	public bank_responses()
	{
		//
		// TODO: Add constructor logic here
		//
	}
	   

}
public class otp_response
{
	public int success { get; set; }
	public string otp { get; set; }
	
	public otp_response()
	{
		//
		// TODO: Add constructor logic here
		//
	}
}