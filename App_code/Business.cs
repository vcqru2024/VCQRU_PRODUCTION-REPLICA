using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

/// <summary>
/// Summary description for Business
/// </summary>
public class Business
{
    private string _tbl_id;

    public string Tbl_id
    {
        get { return _tbl_id; }
        set { _tbl_id = value; }
    }
    private string _ImageName;

    public string ImageName
    {
        get { return _ImageName; }
        set { _ImageName = value; }
    }
    private string _Pro_Name;

    public string Pro_Name
    {
        get { return _Pro_Name; }
        set { _Pro_Name = value; }
    }
    private string _Pro_ID;

    public string Pro_ID
    {
        get { return _Pro_ID; }
        set { _Pro_ID = value; }
    }
    private int _Pro_Qty;

    public int Pro_Qty
    {
        get { return _Pro_Qty; }
        set { _Pro_Qty = value; }
    }
    private double _Pro_One_Price;

    public double Pro_One_Price
    {
        get { return _Pro_One_Price; }
        set { _Pro_One_Price = value; }
    }
    private double _Sub_Total;

    public double Sub_Total
    {
        get { return _Sub_Total; }
        set { _Sub_Total = value; }
    }
    private double _SaveProfit;

    public double SaveProfit
    {
        get { return _SaveProfit; }
        set { _SaveProfit = value; }
    }

    private string _Category;

    public string Category
    {
        get { return _Category; }
        set { _Category = value; }
    }

    public static void FillProductDetailDemo(Business9420.Object9420 Reg)
    {
        throw new NotImplementedException();
    }
}