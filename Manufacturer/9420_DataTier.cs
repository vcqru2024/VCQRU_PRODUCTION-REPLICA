using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using Microsoft.Practices.EnterpriseLibrary.Data;
using System.Data.Common;
using System.Data;
using Business9420;
using System.Web.UI.MobileControls;
using DataProvider;
using Business_Logic_Layer;
using Newtonsoft.Json;
using System.Diagnostics;

/// <summary>
/// Summary description for _9420_DataTier
/// </summary>

namespace Data9420
{
    public class Data_9420
    {
        private static Database database = DatabaseFactory.CreateDatabase();
        private static DbCommand dbCommand;

        public static void SaveProductMaster(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("INSERT INTO [Pro_Reg] ([Comp_ID],[Pro_ID],[Pro_Entry_Date],[Pro_Name],[Update_Flag],Pro_Desc,[Comments],Doc_Flag,Sound_Flag)" +
            " VALUES ('" + obj.Comp_ID + "','" + obj.Pro_ID + "','" + obj.Pro_Entry_Date + "','" + obj.Pro_Name + "',0,'" + obj.Pro_Descri + "','" + obj.Comment_Txt + "',1,1)");
            database.ExecuteNonQuery(dbCommand);
        }
        public static void ProductMaster(Object9420 obj)
        {
            // Check for Duplicate Enrty Product
            if (obj.DML == "I")
            {
                DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' and [Pro_Name] = '" + obj.Pro_Name + "'");
                if (ds.Tables[0].Rows.Count > 0)
                    return;
            }
            dbCommand = database.GetStoredProcCommand("PROC_InsertUpdateProduct");
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, obj.Comp_ID);
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, obj.Pro_ID);
            database.AddInParameter(dbCommand, "Pro_Entry_Date", DbType.String, obj.Pro_Entry_Date);
            database.AddInParameter(dbCommand, "Pro_Name", DbType.String, obj.Pro_Name);
            database.AddInParameter(dbCommand, "Update_Flag", DbType.Int32, obj.Update_Flag);
            database.AddInParameter(dbCommand, "Pro_Desc", DbType.String, obj.Pro_Descri);
            database.AddInParameter(dbCommand, "Label_Code", DbType.String, obj.Label_Code);
            database.AddInParameter(dbCommand, "Pro_Doc", DbType.String, obj.Pro_Doc);
            database.AddInParameter(dbCommand, "Doc_Flag", DbType.String, obj.Doc_Flag);
            database.AddInParameter(dbCommand, "Comments", DbType.String, obj.Comment_Txt);
            database.AddInParameter(dbCommand, "BatchSize", DbType.Int64, obj.BatchSize);
            database.AddInParameter(dbCommand, "DispLoc", DbType.String, obj.Dispatch_Location);
            database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
            database.ExecuteNonQuery(dbCommand);
            if (obj.DML == "I")
                SetProID();
        }
        public static void SetProID()
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Code_Gen] SET [PrStart] = [PrStart] + 1 WHERE [Prfor] = 'Product' and [PrFlag] = 1");
            database.ExecuteNonQuery(dbCommand);
        }
        public static DataSet FetchData(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Pro_ID],[Pro_Name],'../Data/Sound/' + substring([Comp_ID],6,4) + '/' + [Pro_ID]+ '/' + [Pro_ID] + '.mp3' as SoundPath FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "'");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet UpdateData(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Pro_Name],(SELECT Comp_Name from Comp_Reg where Comp_ID = Pro_Reg.Comp_ID) as Comp_Name,'../Data/Sound/' + substring([Comp_ID],6,4) + '/' + [Pro_ID]+ '/' + [Pro_ID] + '.mp3' as SoundPath,'../Data/Sound/' + substring([Comp_ID],6,4) + '/' + [Pro_ID]+ '/' + Pro_Doc as ProDocPath,Pro_Doc,Pro_Desc,Label_Code,Doc_Flag,[BatchSize] as BtSize, Dispatch_Location FROM [Pro_Reg] where [Pro_ID] = '" + obj.Pro_ID + "'");
            return database.ExecuteDataSet(dbCommand);
        }
        public static void UpdateProductMaster(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Pro_Reg]" +
            " SET [Pro_Name] = '" + obj.Pro_Name + "'" +
            " ,Pro_Desc = '" + obj.Pro_Descri + "'" +
            " WHERE [Comp_ID] = '" + obj.Comp_ID + "'" +
            " and [Pro_ID] = '" + obj.Pro_ID + "'");
            database.ExecuteNonQuery(dbCommand);
        }
        public static void DeleteProductMaster(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("DELETE FROM [Pro_Reg] WHERE Pro_ID = '" + obj.Pro_ID + "'");
            database.ExecuteNonQuery(dbCommand);
        }
        public static DataSet fetchCategory()
        {
            dbCommand = database.GetSqlStringCommand("SELECT Category_ID as [Cat_Id], Category_Name as [Cat_Name] " +
            " FROM Category_Master WHERE Flag = 1 order by [Category_Name]");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet fetchCountry()
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Country_Id],[Country_Name] FROM [M_Country] order by [Country_Name]");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet fetchState()
        {
            dbCommand = database.GetSqlStringCommand("SELECT [STATE_ID],[stateName] FROM [StateMaster] where [COUNTRY_ID] = 1 order by [stateName]");
            return database.ExecuteDataSet(dbCommand);
        }
        public static void SavePartnerReg(Object9420 obj)
        {
            dbCommand = database.GetStoredProcCommand("PROC_InsertUpdatePartner");
            database.AddInParameter(dbCommand, "PartnerID", DbType.String, obj.PartmerID);
            database.AddInParameter(dbCommand, "Name", DbType.String, obj.Name);
            database.AddInParameter(dbCommand, "Mobile_No", DbType.String, obj.Mobile_No);
            database.AddInParameter(dbCommand, "Email", DbType.String, obj.Email);
            database.AddInParameter(dbCommand, "Address", DbType.String, obj.Address);
            database.AddInParameter(dbCommand, "PANNo", DbType.String, obj.PANNo);
            database.AddInParameter(dbCommand, "Photo", DbType.String, obj.Photo);
            database.AddInParameter(dbCommand, "PanDoc", DbType.String, obj.PANNoProof);
            database.AddInParameter(dbCommand, "IDProof", DbType.String, obj.IDProof);
            database.AddInParameter(dbCommand, "AddProof", DbType.String, obj.Addproof);
            database.AddInParameter(dbCommand, "AccountNo", DbType.String, obj.BankAccNo);
            database.AddInParameter(dbCommand, "Reg_Date", DbType.String, obj.Reg_Date);
            database.AddInParameter(dbCommand, "Flag", DbType.Int32, obj.Status);
            database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
            database.ExecuteNonQuery(dbCommand);
            SetPartnerId("Partner");
        }
        public static void SaveCompanyReg(Object9420 obj)
        {
            // Check for Duplicate Enrty Product
            if (obj.DML == "I")
            {
                DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Comp_Email] FROM [Comp_Reg] where [Comp_Email] = '" + obj.Comp_Email + "' and [Delete_Flag] = 1 ");
                if (ds.Tables[0].Rows.Count > 0)
                    return;
            }
            dbCommand = database.GetStoredProcCommand("PROC_CompanyRegistration");
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, obj.Comp_ID);
            database.AddInParameter(dbCommand, "Comp_Name", DbType.String, obj.Comp_Name);
            database.AddInParameter(dbCommand, "Comp_Cat_Id", DbType.String, obj.Comp_Cat_Id);
            database.AddInParameter(dbCommand, "Comp_Email", DbType.String, obj.Comp_Email);
            database.AddInParameter(dbCommand, "WebSite", DbType.String, obj.WebSite);
            database.AddInParameter(dbCommand, "Address", DbType.String, obj.Address);
            database.AddInParameter(dbCommand, "City_ID", DbType.String, obj.City_ID);
            database.AddInParameter(dbCommand, "Contact_Person", DbType.String, obj.Contact_Person);
            database.AddInParameter(dbCommand, "Mobile_No", DbType.String, obj.Mobile_No);
            database.AddInParameter(dbCommand, "Phone_No", DbType.String, obj.Phone_No);
            database.AddInParameter(dbCommand, "Fax", DbType.String, obj.Fax);
            database.AddInParameter(dbCommand, "Reg_Date", DbType.String, obj.Reg_Date);
            database.AddInParameter(dbCommand, "Status", DbType.String, obj.Status);
            database.AddInParameter(dbCommand, "Email_Vari_Flag", DbType.String, obj.Email_Vari_Flag);
            database.AddInParameter(dbCommand, "Update_Flag", DbType.String, obj.Update_Flag);
            database.AddInParameter(dbCommand, "Comp_Type", DbType.String, obj.Comp_type);
            database.AddInParameter(dbCommand, "Password", DbType.String, obj.Password);
            database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);

             #region //** to avoide blank or null data
                if (obj.logo_path != "" && obj.logo_path !=null)
                    database.AddInParameter(dbCommand, "logo_path", DbType.String, obj.logo_path);
                #endregion

            database.AddInParameter(dbCommand, "ResiAddress", DbType.String, obj.ResiAddress);
            database.AddInParameter(dbCommand, "DirectorName", DbType.String, obj.DirectorName);
            database.AddInParameter(dbCommand, "DirectorFatherName", DbType.String, obj.DirectorFatherName);
            database.AddInParameter(dbCommand, "AadharNumber", DbType.String, obj.AadharNumber);

            database.ExecuteNonQuery(dbCommand);
        }

        public static void MasterCodeGeneration(Object9420 obj)
        {
            Int64 a;
            Int64 b = obj.Norec;
            Int64 c;
        q:
            try
            {
                a = Convert.ToInt64(SQL_DB.ExecuteScalar("select count(row_id) from m_code"));
            }
            catch
            {
                goto q;
            }
            c = a + b;

            SQL_DB.ExecuteNonQuery("INSERT INTO [M_CodeGenStatus]([NoOfCode],[GenCode],[OldGenCode],[Status]) VALUES ('" + obj.Norec + "','0','" + a + "','FALSE') ");

        p: dbCommand = database.GetStoredProcCommand("GenerateCode");
            database.AddInParameter(dbCommand, "Upper", DbType.Int64, obj.u1);
            database.AddInParameter(dbCommand, "Lower", DbType.Int64, obj.l1);
            database.AddInParameter(dbCommand, "Upper1", DbType.Int64, obj.u2);
            database.AddInParameter(dbCommand, "Lower1", DbType.Int64, obj.l2);
            database.AddInParameter(dbCommand, "NoOfRec", DbType.Int64, b);
            database.AddInParameter(dbCommand, "intFlag", DbType.Int64, obj.intFlag);
            try
            {
                database.ExecuteNonQuery(dbCommand);
            }
            catch
            {
            t:
                try
                {
                    a = Convert.ToInt64(SQL_DB.ExecuteScalar("select count(row_id) from m_code"));
                }
                catch
                {
                    goto t;
                }
                if (a < c)
                {
                    b = c - a;
                    goto p;
                }
            }

        }

        public static DataSet fetchProductCodeDT(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Pro_Reg.Comp_ID, Pro_Reg.Pro_ID, Pro_Reg.Pro_Name, COUNT(Pro_Reg.Pro_ID) AS AllotedCodes, " +
            " (SELECT COUNT(Pro_ID) FROM M_Code WHERE (Pro_ID = Pro_Reg.Pro_ID) AND (Print_Status = 1)) AS PrintCodes, " +
            " (SELECT count([Pro_ID]) FROM [M_Code] " +
            " where [Pro_ID] = Pro_Reg.Pro_ID and [Batch_No] is not null) as FilledCode," +
            " (SELECT COUNT(Pro_ID) FROM M_Code AS M_Code_3 WHERE (Pro_ID = Pro_Reg.Pro_ID)" +
            " AND (Print_Status = 0)) AS BalanceForPrinting, " +
            " (((SELECT COUNT(Pro_ID) FROM M_Code WHERE (Pro_ID = Pro_Reg.Pro_ID) " +
            " AND (Print_Status = 1)))-((SELECT count([Pro_ID]) FROM [M_Code] " +
            " where [Pro_ID] = Pro_Reg.Pro_ID and [Batch_No] is not null))) AS BalanceForFilling," +
            " (SELECT count([Pro_ID]) FROM [M_Code] " +
            " where [Pro_ID] = Pro_Reg.Pro_ID and [Batch_No] is not null and Use_Count <> 0)  as checkCode," +
            " (SELECT count([Pro_ID]) FROM [M_Code] " +
            " where [Pro_ID] = Pro_Reg.Pro_ID and [Batch_No] is not null and Use_Count = 0)  as Uncheck," +
            " Comp_Reg.Comp_Name + ',' + Pro_Reg.Pro_ID + ',' + CONVERT(nvarchar, (SELECT COUNT(Pro_ID) FROM " +
            " M_Code AS M_Code_2 WHERE (Pro_ID = Pro_Reg.Pro_ID) AND (Print_Status = 0)))+','+ " +
            " Pro_Reg.Pro_Name +','+ Pro_Reg.Comp_ID AS combinedValueCode " +
            " FROM M_Code AS M_Code_1 " +
            " INNER JOIN Pro_Reg ON M_Code_1.Pro_ID = Pro_Reg.Pro_ID INNER JOIN Comp_Reg " +
            " ON Pro_Reg.Comp_ID = Comp_Reg.Comp_ID WHERE (Pro_Reg.Comp_ID = '" + obj.Comp_ID + "') " +
            " GROUP BY Pro_Reg.Comp_ID, Pro_Reg.Pro_ID, Pro_Reg.Pro_Name,  " +
            " Comp_Reg.Comp_Name");
            return database.ExecuteDataSet(dbCommand);
        }

        internal static bool CheckeReadyCodes(Object9420 Reg)
        {
            //dbCommand = database.GetSqlStringCommand("SELECT Row_ID FROM  M_IssueKey WHERE Sufix= '" + Reg.Received_Code2.ToString().Substring(6, 2) + "' AND IsPrint = 1 AND IsUsed = 1 AND IsIssue = 1 ");
            dbCommand = database.GetSqlStringCommand("SELECT Row_ID FROM  M_IssueKey WHERE Sufix= '" + Reg.Received_Code2.ToString().Substring(6, 2) + "' AND IsPrint = 1 AND IsUsed = 1 AND IsIssue = 1 ");
            DataTable dt = database.ExecuteDataSet(dbCommand).Tables[0];
            if (dt.Rows.Count > 0)
                return true;
            else
                return false;
        }

        public static DataSet FindCheckCodes(Object9420 Reg)
        {
            //string Suffix = Reg.Received_Code2.ToString().Substring(6, 2);
			
			
			string Suffix = "";
            dbCommand = database.GetSqlStringCommand("SELECT [Row_ID],[Code1],[Code2],ISNULL(Use_Count,0) AS Use_Count,[Pro_ID] FROM [M_Code" + Suffix + "] WHERE ([DispatchFlag] = 1) AND ([ReceiveFlag] = 1) AND (Batch_No IS NOT NULL) AND (ISNULL([ScrapeFlag],0) =  0) AND [Code1] = " + Reg.Received_Code1 + " and [Code2] = " + Reg.Received_Code2 + " ");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
                Reg.M_Code = "M_Code" + Suffix;
            else
                Reg.M_Code = "M_Code";
            return ds;
        }

        public static DataSet FindCodesUsesDataSearch(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_FindCodesUsesDataSearch");
            database.AddInParameter(dbCommand, "Comp_Name", DbType.String, Reg.Comp_Name);
            database.AddInParameter(dbCommand, "Comp_Type", DbType.String, Reg.Comp_type);
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FindCheckedCode(Object9420 Reg)
        {
            // this change is done by shweta  AND (Batch_No IS NOT NULL) , batch is a mandatory field for only counter fitting, for other services it is not mandatory.
            // And We ahve required field validator on Batch_No should not go null with Couter fitting service. 
            // dbCommand = database.GetSqlStringCommand("SELECT [Row_ID],[Code1],[Code2],ISNULL(Use_Count,0) AS Use_Count,[Pro_ID] FROM [M_Code] where ([DispatchFlag] = 1) AND ([ReceiveFlag] = 1) AND ([ScrapeFlag] =  0 OR [ScrapeFlag] IS NULL) AND convert(nvarchar,[Code1]) = '" + Reg.Received_Code1 + "' and convert(nvarchar,[Code2]) = '" + Reg.Received_Code2 + "'");
            dbCommand = database.GetSqlStringCommand("SELECT [Row_ID],[Code1],[Code2],ISNULL(Use_Count,0) AS Use_Count,[Pro_ID] FROM [M_Code] where ([DispatchFlag] = 1) AND ([ReceiveFlag] = 1) AND (Batch_No IS NOT NULL) AND ([ScrapeFlag] =  0 OR [ScrapeFlag] IS NULL) AND convert(nvarchar,[Code1]) = '" + Reg.Received_Code1 + "' and convert(nvarchar,[Code2]) = '" + Reg.Received_Code2 + "'");
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet FindCheckeCodes(Object9420 Reg)
        {
            //dbCommand = database.GetStoredProcCommand("PROC_GetCodesCheck");
            //database.AddInParameter(dbCommand, "Code1", DbType.String, Reg.Received_Code1);
            //database.AddInParameter(dbCommand, "Code2", DbType.String, Reg.Received_Code2);
            //return database.ExecuteDataSet(dbCommand); 
            // below line commented by shweta 
            //dbCommand = database.GetSqlStringCommand("SELECT [Row_ID],[Code1],[Code2],ISNULL(Use_Count,0) AS Use_Count,[Pro_ID] FROM [M_Code] where ([DispatchFlag] = 1) AND ([ReceiveFlag] = 1) AND (Batch_No IS NOT NULL) AND ([ScrapeFlag] =  0 OR [ScrapeFlag] IS NULL) AND convert(nvarchar,[Code1]) = '" + Reg.Received_Code1 + "' and convert(nvarchar,[Code2]) = '" + Reg.Received_Code2 + "'");
            dbCommand = database.GetSqlStringCommand("SELECT [Row_ID],[Code1],[Code2],ISNULL(Use_Count,0) AS Use_Count,[Pro_ID] FROM [M_Code] with (nolock) WHERE ([DispatchFlag] = 1) AND ([ReceiveFlag] = 1) AND (Batch_No IS NOT NULL) AND (ISNULL([ScrapeFlag],0) =  0) AND [Code1] = " + Reg.Received_Code1 + " and [Code2] = " + Reg.Received_Code2 + " ");
            return database.ExecuteDataSet(dbCommand);
        }


        #region Avadhesh

        public static DataSet FetchProductDetailsData(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Pro_ID],[Pro_Name],'../Data/Sound/' + substring([Comp_ID],6,4) + '/' + [Pro_ID]+ '/' + [Pro_ID] + '.mp3' as SoundPath FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "'");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FetchProduct_Id(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Pro_ID FROM  Pro_Reg WHERE [Comp_ID] = '" + obj.Comp_ID + "'");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FetchComanyProfileData()
        {
            dbCommand = database.GetSqlStringCommand("SELECT Comp_ID, Comp_Name, Comp_Cat_Id, Comp_Email, WebSite, Address, (SELECT Country_Name FROM M_Country WHERE Country_ID=Comp_Reg.Country_ID) AS Country_Name, Contact_Person, Mobile_No, Phone_No, Fax, Reg_Date, Password, Status, Email_Vari_Flag, Update_Flag,'../Data/Sound/' + SUBSTRING(Comp_ID, 6, 4) + '/' + SUBSTRING(Comp_ID, 6, 4) + '.mp3' AS SoundPath FROM   Comp_Reg");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FindData(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Comp_ID, Comp_Name, Comp_Email, Contact_Person, Mobile_No, Phone_No,Password, Status,Delete_Flag, Email_Vari_Flag,Comp_Type, Update_Flag FROM   Comp_Reg  WHERE [Comp_ID]='" + Reg.Comp_ID + "'");
            return database.ExecuteDataSet(dbCommand);
        }
        public static void CheckPaymentRec(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("select * from M_Generate_Bill where Comp_ID = '" + Reg.Comp_ID + "'");
            DataSet dsRel = database.ExecuteDataSet(dbCommand);
            if (dsRel.Tables[0].Rows.Count == 0)
            {
                dbCommand = database.GetSqlStringCommand("INSERT INTO [M_Generate_Bill]([Invoice_No],[Comp_ID],[Generate_Date],[G_Amount],[Tax],[N_Amount],[Pre_Bal]) VALUES ( " +
                   "'" + SQL_DB.ExecuteScalar("SELECT     MAX(Row_Id) + 1 AS Expr1 FROM M_Generate_Bill").ToString() + "' " +
                   " ,'" + Reg.Comp_ID + "'" +
                   " ,'" + DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd") + "'" +
                   " ," + 0.00 + "" +
                   " ," + 0.00 + "" +
                   " ," + 0.00 + "" +
                   " ," + 0.00 + ")");
                database.ExecuteNonQuery(dbCommand);
            }

        }

        public static void CompanyAutherntication(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Comp_Reg] SET [Status] = 1,[Password]='" + Reg.Password + "' WHERE [Comp_ID]='" + Reg.Comp_ID + "'");
            database.ExecuteNonQuery(dbCommand);
        }
        public static void CompanyAuthernticationEmailVeriFy(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Comp_Reg] SET [Password]='" + Reg.Password + "' WHERE [Comp_ID]='" + Reg.Comp_ID + "'");
            database.ExecuteNonQuery(dbCommand);
        }
        public static void CompanyAuthernticationNew(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Comp_Reg] SET [Status] = 1 WHERE [Comp_ID]='" + Reg.Comp_ID + "'");
            database.ExecuteNonQuery(dbCommand);
        }
        public static void CompanyAuthernticationBlock(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Comp_Reg] SET [Status] = 0 WHERE [Comp_ID]='" + Reg.Comp_ID + "'");
            database.ExecuteNonQuery(dbCommand);
        }
        public static void RegDeleteData(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Comp_Reg] SET Delete_Flag = " + Reg.Del_Flag + " WHERE [Comp_ID]='" + Reg.Comp_ID + "'");//database.GetSqlStringCommand("DELETE FROM  [Comp_Reg] WHERE [Comp_ID]='" + Reg.Comp_ID + "'");
            database.ExecuteNonQuery(dbCommand);
        }
        public static DataSet FillddlCat()
        {
            dbCommand = database.GetSqlStringCommand("SELECT Cat_Id, Cat_Name FROM M_Category order by Cat_Name");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FindDataOther(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT * FROM  Pro_Reg WHERE [Comp_ID]='" + Reg.Comp_ID + "'");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet CheckStatusForMan(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Status],[Comp_Type] FROM [Comp_Reg] where [Comp_ID] = '" + obj.Comp_ID + "'");
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet FetchSearchData(Object9420 obj)
        {
            string Qry = "SELECT (SELECT COUNT(*) FROM M_Loyalty WHERE M_Loyalty.IsActive =0 AND M_Loyalty.IsDelete =0 AND  M_Loyalty.Pro_ID = Pro_Reg.Pro_ID) as Loyalty, dbo.Pro_Reg.Row_ID, dbo.Pro_Reg.Comp_ID, dbo.Pro_Reg.Pro_ID, dbo.Pro_Reg.Pro_Entry_Date, dbo.Pro_Reg.Pro_Name, dbo.Pro_Reg.Update_Flag ," +
            " (SELECT Comp_type FROM Comp_Reg WHERE  Comp_ID = Pro_Reg.Comp_ID) AS Comp_type,(convert(varchar,dbo.M_Label.Label_Name) + ' ( ' + dbo.M_Label.Label_Size + ' ) ') as Label_Name ," +
            " '../Data/Sound/' + SUBSTRING(dbo.Pro_Reg.Comp_ID, 6, 4) + '/' + dbo.Pro_Reg.Pro_ID + '/' + dbo.Pro_Reg.Pro_ID + '.mp3' AS SoundPath, (CASE WHEN isnull(Pro_Desc, '---') " +
            " = '' THEN '---' ELSE isnull(Pro_Desc, '---') END) AS Pro_Desc, dbo.M_Label.Label_Prise as Rate_Per_Label" +
            " ,'../Data/Sound/' + SUBSTRING(dbo.Pro_Reg.Comp_ID, 6, 4) + '/' + dbo.Pro_Reg.Pro_ID + '/' + Pro_Reg.Pro_Doc AS DocPath " +
            " ,(SELECT m.Plan_Name FROM  M_Amc_Offer AS t INNER JOIN  M_Plan AS m ON t.Plan_ID = m.Plan_ID WHERE (t.Pro_ID = dbo.Pro_Reg.Pro_ID) AND (t.Amc_Offer_ID = (SELECT max(mt.Amc_Offer_ID) FROM M_Amc_Offer as mt WHERE (mt.Status = 1) AND (mt.Pro_ID = dbo.Pro_Reg.Pro_ID)))) as Plan_Name " +
            " ,ISNULL((SELECT DATEDIFF(DAY,GETDATE(),Date_To) FROM M_Amc_Offer WHERE Amc_Offer_ID = (SELECT MAX(Amc_Offer_ID) FROM M_Amc_Offer WHERE (Status = 1) AND (Pro_ID = dbo.Pro_Reg.Pro_ID))),0) AS  CntDays " +
            " FROM dbo.Pro_Reg LEFT OUTER JOIN" +
            " dbo.M_Label ON dbo.Pro_Reg.Label_Code = dbo.M_Label.Label_Code" +
            " WHERE ('' = '" + obj.Comp_ID + "' or dbo.Pro_Reg.Comp_ID = '" + obj.Comp_ID + "') AND (dbo.Pro_Reg.Pro_Name LIKE '%" + obj.Pro_Name + "%') AND ('' = '" + obj.Pro_ID + "' or dbo.Pro_Reg.Pro_ID = '" + obj.Pro_ID + "') ORDER BY  dbo.Pro_Reg.Pro_Entry_Date DESC";

            dbCommand = database.GetSqlStringCommand(Qry);
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet FetchDataForManDashBoard(Object9420 obj)
        {
            string Qry = "SELECT   convert(nvarchar,Pro_Reg.Pro_Entry_Date,107) as regDate,convert(nvarchar,M_Label_Request.Entry_Date,107) as Entry_Date, Pro_Reg.Pro_Name, (CASE WHEN isnull(Pro_Desc, '---')= '' THEN '---' ELSE isnull(Pro_Desc, '---') END) AS Pro_Desc," +
            " CONVERT(varchar, M_Label.Label_Name) + ' ( ' + M_Label.Label_Size + ' ) ' AS Label_Type, M_Label.Label_Prise AS Rate_Per_Label," +
            " '../Data/Sound/' + SUBSTRING(Pro_Reg.Comp_ID, 6, 4) + '/' + Pro_Reg.Pro_ID + '/' + Pro_Reg.Pro_ID + '.mp3' AS SoundPath, " +
            " '../Data/Sound/' + SUBSTRING(Pro_Reg.Comp_ID, 6, 4) + '/' + Pro_Reg.Pro_ID + '/' + Pro_Reg.Pro_Doc AS DocPath," +
            " M_Label_Request.Qty AS Label_Request, " +
            " (case when M_Label_Request.Flag = '0' then 'Pending' when M_Label_Request.Flag = '-1' then 'Reject' when M_Label_Request.Flag = '1' then 'Label Print' when M_Label_Request.Flag = '2' then 'Canceled' end) as RequestStatusFlag, " +
            " (case when Pro_Reg.Doc_Flag = 0 then 'Unverified' else 'Verified' end) as DocVerifyFlag" +
            " FROM Pro_Reg INNER JOIN M_Label_Request ON Pro_Reg.Pro_ID = M_Label_Request.Pro_ID LEFT OUTER JOIN" +
            " M_Label ON Pro_Reg.Label_Code = M_Label.Label_Code WHERE (''= '" + obj.Comp_ID + "' OR Pro_Reg.Comp_ID = '" + obj.Comp_ID + "')" +
            " order by M_Label_Request.Entry_Date desc";
            dbCommand = database.GetSqlStringCommand(Qry);
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet FetchRequestLabel(Object9420 obj)
        {
            string Qry = "SELECT M_Label_Request.Row_ID , CONVERT(nvarchar, M_Label_Request.Entry_Date, 107) AS RequestDate,  Pro_Reg.Pro_Name, M_Label.Label_Name as LabelType, M_Label.Label_Size, M_Label.Label_Prise,M_Label_Request.Qty as RequestedLabels," +
            " (CASE WHEN M_Label_Request.Flag = '0' THEN 'Pending' WHEN M_Label_Request.Flag = '-1' THEN 'Rejected' WHEN M_Label_Request.Flag = '1' THEN 'Printed' WHEN M_Label_Request.Flag = '-2' THEN 'Canceled' END) AS RequestStatusFlag,Tracking_No,M_Label_Request.Flag FROM M_Label_Request INNER JOIN" +
            " M_Label ON M_Label_Request.Label_Code = M_Label.Label_Code INNER JOIN Pro_Reg ON M_Label_Request.Pro_ID = Pro_Reg.Pro_ID where  Pro_Reg.Comp_ID = '" + obj.Comp_ID + "' AND M_Label_Request.Tracking_No LIKE '%" + obj.Tracking_No + "%' AND ('' = '" + obj.Pro_ID + "' or Pro_Reg.Pro_ID = '" + obj.Pro_ID + "') " + obj.chkstr + " ORDER BY M_Label_Request.Entry_Date DESC";
            dbCommand = database.GetSqlStringCommand(Qry);
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet FetchRequestProductList(Object9420 obj)
        {
            string Qry = "SELECT [Pro_ID],[Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' AND [Doc_Flag] = 1 AND [Sound_Flag] = 1 ";
            dbCommand = database.GetSqlStringCommand(Qry);
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FetchRequestPro(Object9420 obj)
        {
            string Qry = "SELECT [Pro_ID],[Pro_Name] FROM [Pro_Reg] where [Comp_ID] = '" + obj.Comp_ID + "' AND [Doc_Flag] = 1 AND [Sound_Flag] = 1 AND Pro_ID IN (SELECT t.Pro_ID FROM M_ServiceSubscription AS t WHERE t.Comp_ID =  '" + obj.Comp_ID + "') ";
            dbCommand = database.GetSqlStringCommand(Qry);
            return database.ExecuteDataSet(dbCommand);
        }
        #endregion



        #region NewCode
        public static void FillUpDateProfile(Object9420 Reg)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetStoredProcCommand("PROC_UpDateCompanyProFile");
            database.AddInParameter(dbCommand, "Comp_Id", DbType.String, Reg.Comp_ID);
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Comp_Name = ds.Tables[0].Rows[0]["Comp_Name"].ToString();
                Reg.Comp_Cat_Id = Convert.ToInt32(ds.Tables[0].Rows[0]["Comp_Cat_Id"].ToString());
                Reg.Comp_Email = ds.Tables[0].Rows[0]["Comp_Email"].ToString();
                Reg.WebSite = ds.Tables[0].Rows[0]["WebSite"].ToString();
                Reg.Address = ds.Tables[0].Rows[0]["Address"].ToString();
                Reg.City_ID = Convert.ToInt32(ds.Tables[0].Rows[0]["City_ID"].ToString());
                Reg.Contact_Person = ds.Tables[0].Rows[0]["Contact_Person"].ToString();
                Reg.Mobile_No = ds.Tables[0].Rows[0]["Mobile_No"].ToString();
                Reg.Phone_No = ds.Tables[0].Rows[0]["Phone_No"].ToString();
                Reg.Fax = ds.Tables[0].Rows[0]["Fax"].ToString();
                Reg.Password = ds.Tables[0].Rows[0]["SoundPath"].ToString();
                Reg.IsRetailer = Convert.ToInt32(ds.Tables[0].Rows[0]["IsRetailer"]);

                if (ds.Tables[0].Rows[0]["Logo_Path"].ToString() != "")
                    Reg.logo_path = ds.Tables[0].Rows[0]["Logo_Path"].ToString();

                Reg.ResiAddress = ds.Tables[0].Rows[0]["ResiAddress"].ToString();
                Reg.DirectorName = ds.Tables[0].Rows[0]["DirectorName"].ToString();
                Reg.DirectorFatherName = ds.Tables[0].Rows[0]["DirectorFatherName"].ToString();
                Reg.AadharNumber = ds.Tables[0].Rows[0]["AadharNumber"].ToString();
            }
        }
        public static void FindAvilableCodesNew(Object9420 Reg)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetStoredProcCommand("PROC_FindAvilableCodesNew");
            database.AddInParameter(dbCommand, "Comp_Id", DbType.String, Reg.Comp_ID);
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
                Reg.Password = ds.Tables[0].Rows[0]["PrintCode"].ToString();
        }
        public static void FindAvilableCodes(Object9420 Reg)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetStoredProcCommand("PROC_FindAvilableCodes");
            database.AddInParameter(dbCommand, "Pro_Id", DbType.String, Reg.Pro_ID);
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
                Reg.Password = ds.Tables[0].Rows[0]["PrintCode"].ToString();
        }
        public static DataSet BatchProductDetails(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_SelectBatchProjectDetails");
            database.AddInParameter(dbCommand, "Comp_Id", DbType.String, Reg.Comp_ID);
            return database.ExecuteDataSet(dbCommand);
        }
        public static void UpdBatchProductDetails(Object9420 Reg)
        {
            try
            {
                dbCommand = database.GetStoredProcCommand("PROC_UpdBatchProductDetials");
                database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID);
                database.AddInParameter(dbCommand, "Warranty", DbType.Int32, Reg.Warranty);
                database.AddInParameter(dbCommand, "MRP", DbType.Double, Reg.MRP);
                if (Reg.DemoMfd_Date != null)
                    database.AddInParameter(dbCommand, "Mfd_Date", DbType.String, Convert.ToDateTime(Reg.DemoMfd_Date).ToString("yyyy/MM/dd"));
                else
                    database.AddInParameter(dbCommand, "Mfd_Date", DbType.String, Reg.DemoMfd_Date);
                if (Reg.Exp_Date != null)
                    database.AddInParameter(dbCommand, "Exp_Date", DbType.String, Convert.ToDateTime(Reg.Exp_Date).ToString("yyyy/MM/dd"));
                else
                    database.AddInParameter(dbCommand, "Exp_Date", DbType.String, Reg.Exp_Date);
                database.AddInParameter(dbCommand, "Batch_No", DbType.String, Reg.Batch_No);
                database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, Convert.ToDateTime(Reg.Entry_Date).ToString("yyyy/MM/dd"));
                database.AddInParameter(dbCommand, "RowId", DbType.String, Reg.Row_ID);
                database.ExecuteNonQuery(dbCommand);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static void SaveBatchProductDetails(Object9420 Reg)
        {
            try
            {
                dbCommand = database.GetStoredProcCommand("PROC_InsertBatchProductDetials");
                database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID);
                database.AddInParameter(dbCommand, "MRP", DbType.Double, Reg.MRP);
                if (Reg.DemoMfd_Date != null)
                    database.AddInParameter(dbCommand, "Mfd_Date", DbType.String, Convert.ToDateTime(Reg.DemoMfd_Date).ToString("yyyy/MM/dd"));
                else
                    database.AddInParameter(dbCommand, "Mfd_Date", DbType.String, Reg.DemoMfd_Date);
                //database.AddInParameter(dbCommand, "Mfd_Date", DbType.String, Convert.ToDateTime(Reg.DemoMfd_Date).ToString("yyyy/MM/dd"));
                if (Reg.Exp_Date != null)
                    database.AddInParameter(dbCommand, "Exp_Date", DbType.String, Convert.ToDateTime(Reg.Exp_Date).ToString("yyyy/MM/dd"));
                else
                    database.AddInParameter(dbCommand, "Exp_Date", DbType.String, Reg.Exp_Date);
                database.AddInParameter(dbCommand, "Batch_No", DbType.String, Reg.Batch_No);
                database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, Convert.ToDateTime(Reg.Entry_Date).ToString("yyyy/MM/dd"));
                //database.AddInParameter(dbCommand, "Update_Flag_H", DbType.String, Reg.Update_Flag);
                //database.AddInParameter(dbCommand, "Update_Flag_E", DbType.String, Reg.Update_Flag);
                database.AddInParameter(dbCommand, "Comments", DbType.String, Reg.Comments);
                database.ExecuteNonQuery(dbCommand);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }
        public static void UpDateBatchProductDetailsInM_Code(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_UpdateBatchProductDetialsInsert");
            database.AddInParameter(dbCommand, "Batch_No", DbType.String, Reg.Batch_No);
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID);
            database.AddInParameter(dbCommand, "NoofCodes", DbType.Int32, Reg.NoofCodes);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void UpDateBatchProductDetailsInM_CodeDemo(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_UpdateBatchProductDetialsInsertDemo");
            database.AddInParameter(dbCommand, "Batch_No", DbType.String, Reg.Batch_No);
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID);
            database.AddInParameter(dbCommand, "Use_Type", DbType.String, Reg.Use_Type);
            database.AddInParameter(dbCommand, "NoofCodes", DbType.Int32, Reg.NoofCodes);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void UpDateBatchProductDetailsInM_CodeNew(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_UpdateBatchProductDetials");
            database.AddInParameter(dbCommand, "Row_ID", DbType.String, Reg.Row_ID);
            database.AddInParameter(dbCommand, "Batch_No", DbType.String, Reg.Batch_No);
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID);
            database.AddInParameter(dbCommand, "NoofCodes", DbType.Int32, Reg.NoofCodes);
            database.ExecuteNonQuery(dbCommand);
        }
        public static string GetRow_ID()
        {
            dbCommand = database.GetSqlStringCommand("SELECT ISNULL(MAX(Row_ID),1) AS Row_ID FROM T_Pro");
            return Convert.ToString(database.ExecuteScalar(dbCommand));
        }
        public static void FetchDataUpdateBatchProductDetails(Object9420 Reg)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT T_Pro.WarrantyDurationMonth,T_Pro.Series_Limit,T_Pro.Comments,T_Pro.Row_ID, T_Pro.Pro_ID, T_Pro.MRP, T_Pro.Mfd_Date, T_Pro.Exp_Date, T_Pro.Batch_No, T_Pro.Entry_Date, T_Pro.Update_Flag_H, T_Pro.Update_Flag_E,  " +
            " Comp_Reg.Comp_ID, " +
            " (SELECT COUNT(Row_ID) AS Expr1 " +
            " FROM M_Code " +
            " WHERE (Batch_No =CONVERT(VARCHAR,T_Pro.Row_ID))) AS NoofCodes,  " +
            " 'Sound/' + SUBSTRING(Comp_Reg.Comp_ID, 6, 4) +'/'+ CONVERT(VARCHAR,T_Pro.Pro_ID)+'/'+ CONVERT(VARCHAR,T_Pro.Row_ID) +'/'+CONVERT(VARCHAR,T_Pro.Row_ID)+ '_H.mp3 ' AS SoundPath_H,  " +
            " 'Sound/' + SUBSTRING(Comp_Reg.Comp_ID, 6, 4) +'/'+ CONVERT(VARCHAR,T_Pro.Pro_ID)+'/'+ CONVERT(VARCHAR,T_Pro.Row_ID) +'/'+CONVERT(VARCHAR,T_Pro.Row_ID)+'_E.mp3' AS SoundPath_E,  " +
            " Pro_Reg.Pro_Name , Pro_Reg.BatchSize " +
            " FROM         Comp_Reg INNER JOIN " +
            " Pro_Reg ON Comp_Reg.Comp_ID = Pro_Reg.Comp_ID INNER JOIN " +
            " T_Pro ON Pro_Reg.Pro_ID = T_Pro.Pro_ID " +
            " WHERE T_Pro.Row_ID=" + Reg.Row_ID + "");
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["Mfd_Date"].ToString() != "")
                    Reg.Mfd_Date = Convert.ToDateTime(ds.Tables[0].Rows[0]["Mfd_Date"].ToString());
                else
                    Reg.Mfd_Date = Convert.ToDateTime("01/01/1900");
                if (ds.Tables[0].Rows[0]["Exp_Date"].ToString() != "")
                    Reg.Exp_Date = Convert.ToDateTime(ds.Tables[0].Rows[0]["Exp_Date"].ToString()).ToString();
                else
                    Reg.Exp_Date = "";
                Reg.Batch_No = ds.Tables[0].Rows[0]["Batch_No"].ToString();
                Reg.MRP = Convert.ToDouble(ds.Tables[0].Rows[0]["MRP"].ToString());
                if (ds.Tables[0].Rows[0]["Comments"].ToString() == "")
                    Reg.Comments = "";
                else
                    Reg.Comments = ds.Tables[0].Rows[0]["Comments"].ToString();
                Reg.BatchSize = Convert.ToInt64(ds.Tables[0].Rows[0]["BatchSize"]);
                Reg.Pro_ID = ds.Tables[0].Rows[0]["Pro_ID"].ToString();
                Reg.HindiFile = ds.Tables[0].Rows[0]["SoundPath_E"].ToString();
                Reg.EnglishFle = ds.Tables[0].Rows[0]["SoundPath_H"].ToString();
                Reg.statusstr = ds.Tables[0].Rows[0]["Series_Limit"].ToString();
                if (!string.IsNullOrEmpty(ds.Tables[0].Rows[0]["WarrantyDurationMonth"].ToString()))
                    Reg.Warranty = Convert.ToInt32(ds.Tables[0].Rows[0]["WarrantyDurationMonth"].ToString());
                else
                {
                    Reg.Warranty = 0;
                }
            }
        }
        public static void FindOldNoofCodes(Object9420 Reg)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetStoredProcCommand("PROC_SelectBatchProductDetailsNoofCodes");
            database.AddInParameter(dbCommand, "Row_ID", DbType.String, Reg.Row_ID);
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID);
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
                Reg.NoofCodes = Convert.ToInt32(ds.Tables[0].Rows[0]["NoofCodes"].ToString());
        }
        public static void UpdateBatchProductDetails(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_UpdateBatchProductDetialsNew");
            database.AddInParameter(dbCommand, "Row_ID", DbType.Int32, Reg.Row_ID);
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID);
            database.AddInParameter(dbCommand, "MRP", DbType.Double, Reg.MRP);
            database.AddInParameter(dbCommand, "Mfd_Date", DbType.DateTime, Convert.ToDateTime(Reg.Mfd_Date.ToString("yyyy/MM/dd")));
            if (Reg.Exp_Date != null)
                database.AddInParameter(dbCommand, "Exp_Date", DbType.String, Convert.ToDateTime(Reg.Exp_Date).ToString("yyyy/MM/dd"));
            else
                database.AddInParameter(dbCommand, "Exp_Date", DbType.String, Reg.Exp_Date);
            database.AddInParameter(dbCommand, "Batch_No", DbType.String, Reg.Batch_No);
            database.AddInParameter(dbCommand, "Comments", DbType.String, Reg.Comments);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void DeleteBatchProductDetailsCodes(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("DELETE FROM [T_Pro]  WHERE Row_ID=" + obj.Row_ID + "");
            database.ExecuteNonQuery(dbCommand);
        }
        public static int GetRowForPrintCodes(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("SELECT COUNT(Print_Status) FROM [M_Code] WHERE [Pro_ID] ='" + obj.Pro_ID + "' AND [Print_Status] = 1");
            return Convert.ToInt32(database.ExecuteScalar(dbCommand));
        }
        public static DataSet SelectProductDetailsNoofCodes(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_SelectProductDetailsNoofCodes");
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            dbCommand.CommandTimeout = 500000;
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet SelectProductDetailsNoofCodesChk(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_SelectProductDetailsNoofCodesChk");
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            dbCommand.CommandTimeout = 500000;
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet SelectProductDetailsNoofCodesPrint(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_SelectProductDetailsNoofCodesPrint");
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            dbCommand.CommandTimeout = 500000;
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet SelectProductDetailsLabelInfo(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_SelectProductDetailsLabelInfo"); dbCommand.CommandTimeout = 500;
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet SelectProductDetailsNoofCodesEdit(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_SelectProductDetailsNoofCodesEdit");
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet SearchBatchProductDetails(Object9420 Reg)
        {
            string exp = null;
            if (Reg.Exp_Date != null)
                exp = Convert.ToDateTime(Reg.Exp_Date).ToString("yyyy/MM/dd");
            else
                exp = null;
            dbCommand = database.GetSqlStringCommand("SELECT     T_Pro.Row_ID, T_Pro.Pro_ID, T_Pro.MRP, T_Pro.Mfd_Date, T_Pro.Exp_Date, T_Pro.Batch_No, T_Pro.Entry_Date, T_Pro.Update_Flag_H, T_Pro.Update_Flag_E,  " +
                      "Comp_Reg.Comp_ID,  " +
                       "   (SELECT     COUNT(Row_ID) AS Expr1  " +
                       "     FROM          M_Code  " +
                      "      WHERE      (Batch_No =CONVERT(VARCHAR,T_Pro.Row_ID))) AS NoofCodes,   " +
                     "				'Sound/' + SUBSTRING(Comp_Reg.Comp_ID, 6, 4) +'/'+ CONVERT(VARCHAR,T_Pro.Pro_ID)+'/'+ CONVERT(VARCHAR,T_Pro.Row_ID) +'/'+CONVERT(VARCHAR,T_Pro.Row_ID)+ '_H.mp3 ' AS SoundPath_H,   " +
                     "				'Sound/' + SUBSTRING(Comp_Reg.Comp_ID, 6, 4) +'/'+ CONVERT(VARCHAR,T_Pro.Pro_ID)+'/'+ CONVERT(VARCHAR,T_Pro.Row_ID) +'/'+CONVERT(VARCHAR,T_Pro.Row_ID)+'_E.mp3' AS SoundPath_E,   " +
                     " Pro_Reg.Pro_Name  " +
                     "FROM         Comp_Reg INNER JOIN  " +
                     "                      Pro_Reg ON Comp_Reg.Comp_ID = Pro_Reg.Comp_ID INNER JOIN  " +
                     "                      T_Pro ON Pro_Reg.Pro_ID = T_Pro.Pro_ID  " +
                     "WHERE     (Comp_Reg.Comp_ID = '" + Reg.Comp_ID + "') AND (Pro_Reg.Pro_Name LIKE '%" + Reg.Pro_Name + "%') AND (T_Pro.Mfd_Date >= '" + Reg.Mfd_Date.ToString("yyyy/MM/dd") + "') AND (T_Pro.Exp_Date <='" + exp + "')");
            return database.ExecuteDataSet(dbCommand);
        }
        public static string FetchDataForLoginFirst(Object9420 Reg)
        {
            DataSet ds = new DataSet(); DataSet ds1 = new DataSet(); string str = "";
            dbCommand = database.GetSqlStringCommand("SELECT  Row_ID, Comp_ID, Comp_Info, PAN_TAN, VAT, Comp_Addressproof, Owner_proof, Signature FROM  Comp_Document WHERE Comp_ID = (SELECT Comp_ID FROM Comp_Reg	WHERE Comp_Email='" + Reg.Comp_Email + "' AND Password='" + Reg.Password + "')");
            ds1 = database.ExecuteDataSet(dbCommand);
            if (ds1.Tables[0].Rows.Count > 0)
                str = "Yes,";
            else
                str = "No,";
            dbCommand = database.GetSqlStringCommand("SELECT Comp_ID, Comp_Name,Comp_Email,Password,Comp_Type,Status FROM Comp_Reg	WHERE Comp_Email='" + Reg.Comp_Email + "' AND Password='" + Reg.Password + "'");
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Comp_ID = ds.Tables[0].Rows[0]["Comp_ID"].ToString();
                Reg.Comp_Name = ds.Tables[0].Rows[0]["Comp_Name"].ToString();
                Reg.Comp_type = ds.Tables[0].Rows[0]["Comp_Type"].ToString();
                Reg.Status = Convert.ToInt32(ds.Tables[0].Rows[0]["Status"].ToString());
                if (Reg.Status == 0)
                    str += "0";
                else
                    str += "1";
            }
            else
                str += "2";
            if (CheckedVerifyFlag(Reg))
                str += ",1";
            else
                str += ",0";
            return str;
        }
        public static bool FetchDataForLogin(Object9420 Reg)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetStoredProcCommand("PROC_FetchLoginData");
            database.AddInParameter(dbCommand, "Comp_Email", DbType.String, Reg.Comp_Email);
            database.AddInParameter(dbCommand, "Password", DbType.String, Reg.Password);
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Comp_ID = ds.Tables[0].Rows[0]["Comp_ID"].ToString();
                Reg.Comp_Name = ds.Tables[0].Rows[0]["Comp_Name"].ToString();
                Reg.Comp_type = ds.Tables[0].Rows[0]["Comp_Type"].ToString();
                return true;
            }
            else
                return false;
        }
        public static string FilCodelInfo()
        {
            dbCommand = database.GetStoredProcCommand("proc_TotalUsedLic");
            dbCommand.CommandTimeout = 5000;
            return Convert.ToString(database.ExecuteScalar(dbCommand));
        }

        public static string FilCodelInfoDemo()
        {
            dbCommand = database.GetStoredProcCommand("proc_TotalUsedDemo");
            dbCommand.CommandTimeout = 5000;
            return Convert.ToString(database.ExecuteScalar(dbCommand));
        }

        public static string FilCodelInfoUsed()
        {
        l:
            try
            {
                dbCommand = database.GetStoredProcCommand("proc_TotalCode");
                dbCommand.CommandTimeout = 5000;
                return Convert.ToString(database.ExecuteScalar(dbCommand));
            }
            catch
            {
                goto l;
            }
        }
        public static void DeAllocateBatchProductDetailsInM_Code(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_DeAllocateProductDetials");
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID);
            database.AddInParameter(dbCommand, "NoofCodes", DbType.Int32, Reg.NoofCodes);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void InsertDeAllocatedCodes(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_InsertDeAllocatedCodes");
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID);
            database.AddInParameter(dbCommand, "NoofCodes", DbType.Int32, Reg.NoofCodes);
            database.AddInParameter(dbCommand, "Reasion", DbType.String, Reg.Password);
            database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, Convert.ToDateTime(Reg.Entry_Date).ToString("yyyy/MM/dd"));
            database.ExecuteNonQuery(dbCommand);
        }
        public static void FindSomeInfo(Object9420 Reg)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT     Comp_Reg.Comp_ID, Comp_Reg.Comp_Name " +
                        "FROM         Comp_Reg INNER JOIN " +
                         "Pro_Reg ON Comp_Reg.Comp_ID = Pro_Reg.Comp_ID " +
                            "WHERE Pro_Reg.Pro_ID='" + Reg.Pro_ID + "'");
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Comp_ID = ds.Tables[0].Rows[0]["Comp_ID"].ToString();
                Reg.Comp_Name = ds.Tables[0].Rows[0]["Comp_Name"].ToString();
            }
        }
        #endregion

        public static string FindAvlDemoCode()
        {
            dbCommand = database.GetSqlStringCommand("SELECT COUNT(Row_ID) FROM  M_Code WHERE (Pro_ID IS NULL) AND [Use_Type] IS NULL AND [Print_Date] IS NULL"); dbCommand.CommandTimeout = 99999999;
            return Convert.ToString(database.ExecuteScalar(dbCommand));
        }

        public static void PrintsInM_CodeUpdate(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_PrintsInM_CodeUpdate");
            database.AddInParameter(dbCommand, "Use_Type", DbType.Int32, Reg.Use_Type);
            database.AddInParameter(dbCommand, "Print_Date", DbType.DateTime, Convert.ToDateTime(Reg.Print_Date).ToString("yyyy/MM/dd"));
            database.AddInParameter(dbCommand, "NoofCodes", DbType.Int32, Reg.NoofCodes);
            database.ExecuteNonQuery(dbCommand);
        }

        public static DataSet FindRowCountPrintDemoCodes(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT TOP(" + Reg.NoofCodes + ")Row_ID FROM M_Code WHERE [Pro_ID] IS NULL AND [Print_Status] IS NULL");
            return database.ExecuteDataSet(dbCommand);
        }

        internal static bool CheckPacketNo(Object9420 Reg)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT [Row_ID]  FROM  M_Code WHERE ([Use_Type] = '" + Reg.Use_Type + "')");
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }

        public static DataSet FindPrintDemoCodesNoUnique()
        {
            dbCommand = database.GetSqlStringCommand("SELECT DISTINCT PrintBunchofCode AS NoCodes FROM SelectPrintDemoCodes");
            return database.ExecuteDataSet(dbCommand);

        }

        internal static void InsertMessageLog(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("INSERT INTO     M_Message( Send_To, Send_CC, Send_BCC, Subject, Message,Entry_Date,filename) VALUES " +
                " ('" + Reg.Send_To + "','" + Reg.Send_CC + "','" + Reg.Send_BCC + "','" + Reg.Send_Subject + "','" + Reg.Send_Message + "','" +
                Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd") + "','" + Reg.Send_AttachFile + "')");
            database.ExecuteNonQuery(dbCommand);
        }

        public static void FindInfo(Object9420 Reg)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT Contact_Person, Mobile_No FROM Comp_Reg WHERE     (Comp_ID = '" + Reg.Comp_ID + "')");
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Contact_Person = ds.Tables[0].Rows[0]["Contact_Person"].ToString();
                Reg.Mobile_No = ds.Tables[0].Rows[0]["Mobile_No"].ToString();
            }
        }

        public static void UpdateFileFlag(Object9420 obj)
        {
            dbCommand = database.GetStoredProcCommand("PROC_UpdateFileFlag");
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, obj.Comp_ID);
            database.ExecuteNonQuery(dbCommand);
        }

        public static void UpdateFileFlagProduct(Object9420 obj)
        {
            dbCommand = database.GetStoredProcCommand("PROC_UpdateFileFlagPro");
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, obj.Pro_ID);
            database.ExecuteNonQuery(dbCommand);
        }

        public static void UpdateFileFlagProDetH(Object9420 obj)
        {
            dbCommand = database.GetStoredProcCommand("PROC_UpdateFileFlagProDetH");
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, obj.Pro_ID);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void UpdateFileFlagProDetE(Object9420 obj)
        {
            dbCommand = database.GetStoredProcCommand("PROC_UpdateFileFlagProDetE");
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, obj.Pro_ID);
            database.ExecuteNonQuery(dbCommand);
        }

        public static void updatefuunction(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [M_Code] SET [Print_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("MM/dd/yyyy") + "',[Allot_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("MM/dd/yyyy") + "'" +
            " ,[Pro_ID] = '" + Reg.Pro_ID + "',[Use_Type] = '" + Reg.Use_Type + "',[Print_Status] = 1, Series_Order = " + Reg.Series_Order + ", Series_Serial = " + Reg.Series_Serial + ", LabelRequestId = '" + Reg.LabelRequestID + "' WHERE [Code1] = " + Reg.Code1 + "" +
            " and [Code2] = " + Reg.Code2 + "");
            database.ExecuteNonQuery(dbCommand);
        }

        public static string MyRegistrationExccel(Object9420 RegExccel)
        {
            string Qry = "SELECT row_number() OVER (ORDER BY Excel.Series_Order,Excel.Searies_Name) AS SNO,* from (SELECT Pro_ID +'-'+ (case when len(convert(nvarchar,Series_Order)) = 1 then '000'+convert(nvarchar,Series_Order) when len(convert(nvarchar,Series_Order)) = 2 then '00'+convert(nvarchar,Series_Order) when len(convert(nvarchar,Series_Order)) = 3 then '0'+convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end)+'-'+ " +
            " (case when len(convert(nvarchar,Series_Serial)) = 1 then '000'+convert(nvarchar,Series_Serial) when len(convert(nvarchar,Series_Serial)) = 2 then '00'+convert(nvarchar,Series_Serial) when len(convert(nvarchar,Series_Serial)) = 3 then '0'+convert(nvarchar,Series_Serial) else convert(nvarchar,Series_Serial) end) AS Searies_Name ,Code1, Code2 ,Series_Order FROM  M_Code " +
            " WHERE CONVERT(VARCHAR,Print_Date,111)='" + DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd") + "' AND Pro_ID='" + RegExccel.Pro_ID + "' and print_status = 1 AND (LabelRequestId = '" + RegExccel.LabelRequestID + "' ) " +
            " ) as Excel";
            return Qry;
        }
        public static string MyVirtualExccel(string ProId, string LabelRequestId)
        {
            string Qry = "SELECT row_number() OVER (ORDER BY Excel.Series_Order,Excel.Searies_Name) AS SNO,* from (SELECT Pro_ID +'-'+ (case when len(convert(nvarchar,Series_Order)) = 1 then '000'+convert(nvarchar,Series_Order) when len(convert(nvarchar,Series_Order)) = 2 then '00'+convert(nvarchar,Series_Order) when len(convert(nvarchar,Series_Order)) = 3 then '0'+convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end)+'-'+ " +
            " (case when len(convert(nvarchar,Series_Serial)) = 1 then '000'+convert(nvarchar,Series_Serial) when len(convert(nvarchar,Series_Serial)) = 2 then '00'+convert(nvarchar,Series_Serial) when len(convert(nvarchar,Series_Serial)) = 3 then '0'+convert(nvarchar,Series_Serial) else convert(nvarchar,Series_Serial) end) AS Searies_Name ,Code1, Code2 ,Series_Order FROM  M_Code " +
            " WHERE Pro_ID='" + ProId + "' and print_status = 1 AND (LabelRequestId = '" + LabelRequestId + "' ) " +
            " ) as Excel";
            return Qry;
        }

        public static string MyRegistrationExccelDemo(Object9420 Reg)
        {
            string Qry = "SELECT     row_number() OVER (ORDER BY M_Code.Row_ID) AS SNO,Use_Type AS Searies_Name, Code1, Code2 FROM  M_Code " +
                        " WHERE CONVERT(VARCHAR,Print_Date,111)='" + DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd") + "' AND Use_Type='" + Reg.Use_Type + "'";
            return Qry;
        }

        public static void FindLicenceData(Object9420 Reg)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT Comp_ID FROM Pro_Reg");
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
                Reg.Comp_ID = ds.Tables[0].Rows[0]["Comp_ID"].ToString();
        }
        #region Newcode For Customization
        public static DataSet CheckDemoPackageCodes(string PackageName)
        {
            dbCommand = database.GetSqlStringCommand("SELECT COUNT(Row_ID) AS Row_ID FROM M_Code where (Use_Type='" + PackageName + "') " +
            "AND  Print_Status=1 AND  Print_Date IS NOT NULL group by Use_Type");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet CheckDemoPackageCodesRows(string PackageName)
        {
            dbCommand = database.GetSqlStringCommand("SELECT   Row_ID FROM M_Code where (Use_Type='" + PackageName + "') AND  Print_Status=1 AND  Print_Date IS NOT NULL ");
            return database.ExecuteDataSet(dbCommand);
        }
        #endregion

        public static DataSet FillddlDemoAll()
        {
            dbCommand = database.GetStoredProcCommand("PROC_FillddlDemoAll"); dbCommand.CommandTimeout = 5000;
            return database.ExecuteDataSet(dbCommand);
        }

        public static string FindPack(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_FindPack");
            database.AddInParameter(dbCommand, "NoofCodes", DbType.Int32, Reg.NoofCodes);
            return Convert.ToString(database.ExecuteScalar(dbCommand));
        }

        public static void InsertAllocatedCodesForDemo(Object9420 Reg)
        {
            // Check for Duplicate Enrty Product
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Email_ID] FROM [Allcation_Demo] where [Email_ID] = '" + Reg.Comp_Email + "' ");
            if (ds.Tables[0].Rows.Count > 0)
                return;
            dbCommand = database.GetStoredProcCommand("PROC_InsertAllocatedCodesForDemo");
            database.AddInParameter(dbCommand, "Comp_Name", DbType.String, Reg.Comp_Name);
            database.AddInParameter(dbCommand, "Comp_Email", DbType.String, Reg.Comp_Email);
            database.AddInParameter(dbCommand, "Mobile_No", DbType.String, Reg.Mobile_No);
            database.AddInParameter(dbCommand, "Use_Type", DbType.String, Reg.Use_Type);
            database.AddInParameter(dbCommand, "Contact_Person", DbType.String, Reg.Contact_Person);
            database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, Convert.ToDateTime(Reg.Entry_Date).ToString("yyyy/MM/dd"));
            database.ExecuteNonQuery(dbCommand);
        }

        public static DataSet FillDataDemoGrid(string Qry)
        {
            dbCommand = database.GetStoredProcCommand("PROC_FillDataDemoGrid");
            database.AddInParameter(dbCommand, "Qry", DbType.String, Qry);
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet FetchMailDetail(string Mailtype)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Mail_SMTP],[User_Id],[MPassword],Mail_Type FROM [Mail_Details] where [Mail_Type] = '" + Mailtype + "'");
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet FetchMailingDetail(string purpose, string mtype)
        {
            dbCommand = database.GetSqlStringCommand("select md.tomail,md.ccmail,mlc.[subject],mlc.body from tblMailingDetails as md inner join tblMailingcontent as mlc on md.mtype=mlc.mtype and md.purpose=mlc.purpose where md.purpose= '" + purpose + "' and md.mtype='" + mtype + "'");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillDataDemoGridNew(string strAll, string CodePacket)
        {
            dbCommand = database.GetSqlStringCommand("SELECT COUNT(m.Row_ID) AS PrintBunchofCode, m.Use_Type, m.Use_Type+'*'+ convert(nvarchar,m.Print_Date,105) as DownFl," +
                      "m.Print_Date,m.[Pro_ID],(SELECT [Packet_Name] FROM [Allcation_Demo] where [Packet_Name] = m.Use_Type) as AllotDemo, " +
                      "(case when (SELECT [Packet_Name] FROM [Allcation_Demo] where [Packet_Name] = m.Use_Type) is null and m.[Pro_ID] is null then 'Not Alloted' " +
                      "when  " +
                      "(SELECT [Packet_Name] FROM [Allcation_Demo] where [Packet_Name] = m.Use_Type) is not null and m.[Pro_ID] is null then 'Alloted' " +
                      "when " +
                      "(SELECT [Packet_Name] FROM [Allcation_Demo] where [Packet_Name] = m.Use_Type) is not null and m.[Pro_ID] is not null then 'Used' " +
                      "end) as CodeStatus " +
                      "FROM dbo.M_Code m WHERE m.[Use_Type] != 'L'" + strAll + "GROUP BY m.Use_Type,m.Print_Date,m.[Pro_ID] " + CodePacket + " ORDER BY m.Print_Date,COUNT(m.Row_ID) DESC");
            return database.ExecuteDataSet(dbCommand);
        }

        public static string FindQry()
        {
            return "(case when (SELECT [Packet_Name] FROM [Allcation_Demo] where [Packet_Name] = m.Use_Type) " +
                        " is null and m.[Pro_ID] is null then 'Not Alloted' when  (SELECT [Packet_Name] " +
                        " FROM [Allcation_Demo] where [Packet_Name] = m.Use_Type) is not null and m.[Pro_ID] " +
                        " is null then 'Alloted' when (SELECT [Packet_Name] FROM [Allcation_Demo]" +
                         " where [Packet_Name] = m.Use_Type) is not null and m.[Pro_ID] is not null then 'Used' end)";
        }

        public static bool UpdateEmailFlag(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  Email_Vari_Flag FROM Comp_Reg where  Comp_ID  ='" + Reg.Comp_ID + "'");
            Int32 i = Convert.ToInt32(database.ExecuteScalar(dbCommand));
            if (i == 0)
                return true;
            else
                return false;
        }

        public static DataSet FindFillGridDataReports()
        {
            dbCommand = database.GetStoredProcCommand("PROC_SelectPrintAllocatedCodes");
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet FindFillGridDataSearch(string StrAll)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  aldt,Allot_Date, Comp_Name, Comp_ID,(Comp_ID +'_' +convert(varchar,row_number() over(order by Allot_Date))) as divID, NumberOfProduct, codeAllocation FROM    SelectPrintAllocatedCodes" + StrAll);
            return database.ExecuteDataSet(dbCommand);
        }

        //public static DataSet FindCodesUsesDataSearch(Object9420 Reg)
        //{
        //    dbCommand = database.GetStoredProcCommand("PROC_FindCodesUsesDataSearch");
        //    database.AddInParameter(dbCommand, "Comp_Name", DbType.String, Reg.Comp_Name);
        //    database.AddInParameter(dbCommand, "Comp_Type", DbType.String, Reg.Comp_type);
        //    return database.ExecuteDataSet(dbCommand);
        //}
        //public static DataSet FindCheckedCode(Object9420 Reg)
        //{
        //    dbCommand = database.GetSqlStringCommand("SELECT [Row_ID],[Code1],[Code2],ISNULL(Use_Count,0) AS Use_Count,[Pro_ID] FROM [M_Code] where ([DispatchFlag] = 1) AND ([ReceiveFlag] = 1) AND (Batch_No IS NOT NULL) AND ([ScrapeFlag] =  0 OR [ScrapeFlag] IS NULL) AND convert(nvarchar,[Code1]) = '" + Reg.Received_Code1 + "' and convert(nvarchar,[Code2]) = '" + Reg.Received_Code2 + "'");
        //    return database.ExecuteDataSet(dbCommand);
        //}
        //public static DataSet FindCheckeCodes(Object9420 Reg)
        //{
        //    //dbCommand = database.GetStoredProcCommand("PROC_GetCodesCheck");
        //    //database.AddInParameter(dbCommand, "Code1", DbType.String, Reg.Received_Code1);
        //    //database.AddInParameter(dbCommand, "Code2", DbType.String, Reg.Received_Code2);
        //    //return database.ExecuteDataSet(dbCommand); 
        //    dbCommand = database.GetSqlStringCommand("SELECT [Row_ID],[Code1],[Code2],ISNULL(Use_Count,0) AS Use_Count,[Pro_ID] FROM [M_Code] where ([DispatchFlag] = 1) AND ([ReceiveFlag] = 1) AND (Batch_No IS NOT NULL) AND ([ScrapeFlag] =  0 OR [ScrapeFlag] IS NULL) AND convert(nvarchar,[Code1]) = '" + Reg.Received_Code1 + "' and convert(nvarchar,[Code2]) = '" + Reg.Received_Code2 + "'");
        //    dbCommand = database.GetSqlStringCommand("SELECT [Row_ID],[Code1],[Code2],ISNULL(Use_Count,0) AS Use_Count,[Pro_ID] FROM [M_Code] WHERE ([DispatchFlag] = 1) AND ([ReceiveFlag] = 1) AND (Batch_No IS NOT NULL) AND (ISNULL([ScrapeFlag],0) =  0) AND [Code1] = " + Reg.Received_Code1 + " and [Code2] = " + Reg.Received_Code2 + " ");
        //    return database.ExecuteDataSet(dbCommand);
        //}

        public static int InsertCodeChecked(Object9420 Reg)
        {
            int n;

            if (int.TryParse(Reg.Received_Code1, out n) && int.TryParse(Reg.Received_Code2, out n))
            {
                dbCommand = database.GetStoredProcCommand("PROC_InsertProductInquery");
                database.AddInParameter(dbCommand, "Dial_Mode", DbType.String, Reg.Dial_Mode);
                database.AddInParameter(dbCommand, "Enq_Date", DbType.DateTime, Reg.Enq_Date);
                database.AddInParameter(dbCommand, "Mode_Detail", DbType.String, Reg.Mode_Detail);
                database.AddInParameter(dbCommand, "MobileNo", DbType.String, Reg.Mobile_No);
                database.AddInParameter(dbCommand, "Received_Code1", DbType.String, Reg.Received_Code1);
                database.AddInParameter(dbCommand, "Received_Code2", DbType.String, Reg.Received_Code2);
                database.AddInParameter(dbCommand, "Is_Success", DbType.Int32, Reg.Is_Success);
                database.AddInParameter(dbCommand, "IsDraw", DbType.Int32, 0);
                database.AddInParameter(dbCommand, "SST_ID", DbType.Int64, 0);
                database.AddInParameter(dbCommand, "City", DbType.String, Reg.City);
database.AddInParameter(dbCommand, "Retailer_Name", DbType.String, Reg.Retailer_Name);//added by bipin for raunak
database.AddInParameter(dbCommand, "Others", DbType.String, Reg.Others);
database.AddInParameter(dbCommand, "Image", DbType.String, Reg.Image);  //Added by bipin for Oltimo

                database.AddInParameter(dbCommand, "State", DbType.String, Reg.State);

                database.AddInParameter(dbCommand, "callercircle", DbType.String, Reg.callercircle);
                database.AddInParameter(dbCommand, "network", DbType.String, Reg.network);
                database.AddInParameter(dbCommand, "callerdate", DbType.DateTime, Reg.callerdate);
                database.AddInParameter(dbCommand, "callertime", DbType.String, Reg.callertime);
                database.AddInParameter(dbCommand, "M_Codeid", DbType.Int64, Reg.M_code_Row_ID);
                database.AddInParameter(dbCommand, "Proid", DbType.String, Reg.Pro_ID);
                database.AddInParameter(dbCommand, "Compid", DbType.String, Reg.Comp_ID);
                database.AddInParameter(dbCommand, "dealerid", DbType.String, Reg.dealerid);
                database.AddInParameter(dbCommand, "designation", DbType.String, Reg.designation);
                database.AddInParameter(dbCommand, "customername", DbType.String, Reg.consumer_name);
 database.AddInParameter(dbCommand, "dealer_mobile", DbType.String, Reg.dealer_mobile);
                //  database.ExecuteNonQuery(dbCommand);
                object i = database.ExecuteScalar(dbCommand);
                //DataProvider.LogManager.ErrorExceptionLog(Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy-MM-dd hh:mm:ss tt") + "          " + i.ToString());






                return Convert.ToInt32(i);
            }
            else
            {
                return 0;
            }

        }
        public static int appInsertCodeChecked(Object9420 Reg)
        {
            int n;

            if (int.TryParse(Reg.Received_Code1, out n) && int.TryParse(Reg.Received_Code2, out n))
            {
                dbCommand = database.GetStoredProcCommand("PROC_InsertProductInquery");
                database.AddInParameter(dbCommand, "Dial_Mode", DbType.String, Reg.Dial_Mode);
                database.AddInParameter(dbCommand, "Enq_Date", DbType.DateTime, Convert.ToDateTime(DateTime.Now).ToString("yyyy/MM/dd HH:mm:ss.fff"));
                database.AddInParameter(dbCommand, "Mode_Detail", DbType.String, Reg.Mode_Detail);
                database.AddInParameter(dbCommand, "MobileNo", DbType.String, Reg.Mobile_No);
                database.AddInParameter(dbCommand, "Received_Code1", DbType.String, Reg.Received_Code1);
                database.AddInParameter(dbCommand, "Received_Code2", DbType.String, Reg.Received_Code2);
                database.AddInParameter(dbCommand, "Is_Success", DbType.Int32, Reg.Is_Success);
                database.AddInParameter(dbCommand, "IsDraw", DbType.Int32, 0);
                database.AddInParameter(dbCommand, "SST_ID", DbType.Int64, 0);
                database.AddInParameter(dbCommand, "City", DbType.String, Reg.City);
                database.AddInParameter(dbCommand, "callercircle", DbType.String, Reg.callercircle);
                database.AddInParameter(dbCommand, "network", DbType.String, Reg.network);
                database.AddInParameter(dbCommand, "callerdate", DbType.DateTime, Convert.ToDateTime(DateTime.Today).ToString("yyyy/MM/dd"));
                database.AddInParameter(dbCommand, "callertime", DbType.String, Reg.callertime);
                database.AddInParameter(dbCommand, "M_Codeid", DbType.Int64, Reg.M_code_Row_ID);
                database.AddInParameter(dbCommand, "Proid", DbType.String, Reg.Pro_ID);
                database.AddInParameter(dbCommand, "Compid", DbType.String, Reg.Comp_ID);
                database.AddInParameter(dbCommand, "dealerid", DbType.String, Reg.dealerid);
                //  database.ExecuteNonQuery(dbCommand);
                object i = database.ExecuteScalar(dbCommand);
                return Convert.ToInt32(i);
            }
            else
            {
                return 0;
            }

        }
        public static void UpdateUse_CountM_Code(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_UpdateM_CodeUse_Count");
            database.AddInParameter(dbCommand, "Received_Code1", DbType.String, Reg.Received_Code1);
            database.AddInParameter(dbCommand, "Received_Code2", DbType.String, Reg.Received_Code2);
            database.AddInParameter(dbCommand, "Is_Success", DbType.Int32, Reg.Is_Success);
            database.ExecuteNonQuery(dbCommand);
        }

        public static DataSet FetchEnquiryData()
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Dial_Mode] as ModeOfInquiry,convert(nvarchar,[Enq_Date],109) as EnquiryDate," +
            " [Mode_Detail] as ContactDetails,[Received_Code1],[Received_Code2]" +
            " ,(case when [Is_Success] = '1' then 'Success' else 'Unsuccess' end) as Successstatus FROM [Pro_Enq]" +
            " order by [Enq_Date] desc");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FindBill()
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Comp_ID],[currentBill],[Pre_Amount],[Advance],[ActBill]" +
            " ,[TotalOutStand],[Comp_Name] FROM [NewViewForAdvance] where TotalOutStand <> 0.00");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FindBillParam(string Comp_Ids)
        {
            string SubQry = "";
            if (Comp_Ids.Length > 5)
                SubQry = " WHERE [Comp_ID] in (" + Comp_Ids + ") ";
            else
                SubQry = "";
            dbCommand = database.GetSqlStringCommand("SELECT [Comp_ID],[currentBill],[Pre_Amount],[Advance],[TotalOutStand],[Comp_Name] FROM [NewViewForAdvance] " + SubQry);
            return database.ExecuteDataSet(dbCommand);

        }
        public static DataSet FindBillNew(Object9420 Reg, string Qry)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Comp_ID],[currentBill],[Pre_Amount],[Advance]" +
            " ,[TotalOutStand],[Comp_Name] FROM [NewViewForAdvance] where [Comp_Name] like '%" + Reg.Comp_Name + "%'");
            return database.ExecuteDataSet(dbCommand);
        }
        public static void FindGenerateData(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_FetchGenerateData");
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    int CurrAmt = Convert.ToInt32(ds.Tables[0].Rows[i]["Qty"].ToString());
                    if (CurrAmt > 0)
                    {
                        Reg.Pro_ID = ds.Tables[0].Rows[i]["Pro_ID"].ToString();
                        Reg.Qty = Convert.ToInt32(ds.Tables[0].Rows[i]["Qty"].ToString());
                        Reg.Rate = Convert.ToDouble(ds.Tables[0].Rows[i]["Rate_Per_Label"].ToString());
                        Reg.G_Amount = Convert.ToDouble(ds.Tables[0].Rows[i]["G_Total"].ToString());
                        InsertGenerateBills(Reg);
                    }
                }
            }
        }
        public static void InsertGenerateBills(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_InsertT_Generate_Bill");
            database.AddInParameter(dbCommand, "Invoice_No", DbType.String, Reg.Invoice_No);
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID); // for Amc Pro_Id replace Plan_ID            
            database.AddInParameter(dbCommand, "Qty", DbType.Double, Reg.Qty); // for Amc Qty replace Recived amount for Amc and Offer Invoice
            database.AddInParameter(dbCommand, "Rate", DbType.Double, Reg.Rate); // for Amc Rate replace Requested amount for Amc and Offer Invoice
            database.AddInParameter(dbCommand, "G_Amount", DbType.Double, Reg.G_Amount);
            database.AddInParameter(dbCommand, "Plan_ID", DbType.String, Reg.Plan_ID); // plan id
            database.AddInParameter(dbCommand, "Amc_Offer_ID", DbType.Double, Reg.Amc_Offer_ID); // plan id
            database.AddInParameter(dbCommand, "Pre_Bal", DbType.Double, Reg.Pre_Bal); // plan id
            database.ExecuteNonQuery(dbCommand);
        }
        public static string GetInvoice_No()
        {
            dbCommand = database.GetSqlStringCommand("SELECT  PrPrefix + substring(convert(nvarchar,getdate(),111),3,2) + '-' +CONVERT(varchar, PrStart) AS Invoice_No FROM Code_Gen WHERE [Prfor] = 'Invoice'");
            return Convert.ToString(database.ExecuteScalar(dbCommand));
        }
        public static void SetInvoice_No()
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Code_Gen] SET[PrStart] = [PrStart]+1 WHERE [Prfor] = 'Invoice'");
            database.ExecuteNonQuery(dbCommand);
        }
        public static void FindBillData(Object9420 Reg, double Pre_Val)
        {
            dbCommand = database.GetStoredProcCommand("PROC_FetchGenerateDataNew");
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd"));
                Reg.G_Amount = Convert.ToDouble(ds.Tables[0].Rows[0]["G_Total"].ToString());
                Reg.Tax = Convert.ToDouble(ds.Tables[0].Rows[0]["Tax"].ToString());
                Reg.N_Amount = Convert.ToDouble(ds.Tables[0].Rows[0]["N_Amount"].ToString());
                Reg.Pre_Bal = Pre_Val;
                InsertM_Generate_Bill(Reg);
                FindGenerateData(Reg);
                SetInvoice_No();
            }
        }
        public static void FindBillDataNew(Object9420 Reg, double Pre_Val)
        {
            dbCommand = database.GetStoredProcCommand("PROC_FetchGenerateDataNew");
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                dbCommand = database.GetSqlStringCommand("SELECT     TOP (1) Pre_Bal FROM  M_Generate_Bill WHERE (Comp_ID = '" + Reg.Comp_ID + "') ORDER BY Row_Id DESC");
                if (Convert.ToDouble(database.ExecuteScalar(dbCommand)) != Pre_Val)
                {
                    Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd"));
                    Reg.G_Amount = 0.00;
                    Reg.Tax = 0.00;
                    Reg.N_Amount = 0.00;
                    Reg.Pre_Bal = Pre_Val;
                    InsertM_Generate_Bill(Reg);
                    FindGenerateData(Reg);
                    SetInvoice_No();
                }
            }
        }
        public static void InsertM_Generate_Bill(Object9420 Reg)
        {
            try
            {


                dbCommand = database.GetStoredProcCommand("PROC_InsertM_Generate_Bill");
                database.AddInParameter(dbCommand, "Invoice_No", DbType.String, Reg.Invoice_No);
                database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
                database.AddInParameter(dbCommand, "Generate_Date", DbType.DateTime, Convert.ToDateTime(Reg.Entry_Date).ToString("yyyy/MM/dd hh:mm:ss tt"));
                database.AddInParameter(dbCommand, "G_Amount", DbType.String, Reg.G_Amount);
                database.AddInParameter(dbCommand, "Tax", DbType.Double, Reg.Tax);
                database.AddInParameter(dbCommand, "N_Amount", DbType.Double, Reg.N_Amount);
                database.AddInParameter(dbCommand, "Trans_Type", DbType.String, Reg.Trans_Type);
                database.AddInParameter(dbCommand, "Pre_Bal", DbType.Double, Reg.Rec_Payment); // data will go in pre_bal column as a adjustment  
                database.ExecuteNonQuery(dbCommand);
            }
            catch (Exception ex)
            {

                throw ex;
            }
        }
        public static void FindAvlBal(string p)
        {

        }
        public static DataSet FillDataGridPayment(string str)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Row_Id, Rec_Date,(select Comp_Name from Comp_Reg Where Comp_ID=Payment_Received.Comp_ID) as Comp_Name, Rec_Amount, Remark,Trans_No as Request_No, Trans_No,[Details],[PayMode] FROM  Payment_Received where (" + str + ")");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillDataGridPaymentAmc(string str)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Row_Id, Rec_Date,(select Comp_Name from Comp_Reg Where Comp_ID=Payment_Receive.Comp_ID) as Comp_Name, Rec_Amount, Remark, Trans_No,[Details],[PayMode] FROM  Payment_Receive where (" + str + ")");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillDataGridPaymentRequest(string str, string Comp_ID)
        {
            string Qry = "";
            if (str != "")
                Qry = "AND " + str + " ";
            dbCommand = database.GetSqlStringCommand("SELECT Payment_For as PMT,CASE WHEN Flag = 0 then 'Pending' WHEN Flag = -1 then 'Rejected' WHEN Flag = 2 then 'Cancelled' else 'Received' end as ReqSt, (Comp_ID + ',' + convert(varchar,Row_Id)  + ',' + convert(varchar,Req_Amount)) as MyID, Row_Id as Row_Id,Flag as Flag, Comp_ID as Comp_ID,(SELECT Comp_Name FROM Comp_Reg where Comp_ID = Payment_Received.Comp_ID) as Comp_Name, Pro_ID,(SELECT Pro_Name FROM Pro_Reg where Pro_ID = Payment_Received.Pro_ID) as Pro_Name, Req_Date as Req_Date,(select Bank_Name from M_BankAccount Where  Bank_ID=Payment_Received.Bank_ID) as Bank_Name,Req_Amount as Req_Amount, isnull(Rec_Amount,0.00) as Rec_Amount, Manu_Remark as Remark,Admin_Remark as Admin_Remark, Request_No as Request_No,[Details] as Details,[PayMode] as PayMode " +
            " , (CASE WHEN Rec_Date IS NULL THEN 'Bill\\Receipt\\'+ replace(convert(varchar,Req_Date,103),'/','-')+'\\'+ Request_No + '.pdf' else 'Bill\\Receipt\\'+ replace(convert(varchar,Rec_Date,103),'/','-')+'\\'+ Request_No + '.pdf' end) as filepath FROM  Payment_Received where ('' = '" + Comp_ID + "' OR Payment_Received.Comp_ID = '" + Comp_ID + "')" + Qry + "  ORDER BY Row_ID DESC"); dbCommand.CommandTimeout = 5000;
            return database.ExecuteDataSet(dbCommand);
        }
        public static void FillDetailsPaymentRequest(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  (Comp_ID + ',' + convert(varchar,Row_Id)) as MyID, Row_Id,Flag, Comp_ID,(SELECT Comp_Name FROM Comp_Reg where Comp_ID = Payment_Received.Comp_ID) as Comp_Name, Req_Date,(select Bank_Name from M_BankAccount Where  Bank_ID=Payment_Received.Bank_ID) as Bank_Name, Req_Amount, Remark, Request_No,[Details],[PayMode],ISNULL([Amt_Type],0) AS Amt_Type FROM  Payment_Received where ('' = '" + Reg.Comp_ID + "' OR Payment_Received.Comp_ID = '" + Reg.Comp_ID + "') AND Row_Id = " + Reg.Row_ID + " ");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Comp_ID = ds.Tables[0].Rows[0]["Comp_ID"].ToString();
                Reg.Comp_Name = ds.Tables[0].Rows[0]["Comp_Name"].ToString();
                Reg.G_Amount = Convert.ToDouble(ds.Tables[0].Rows[0]["Req_Amount"].ToString());
                Reg.Remarks = ds.Tables[0].Rows[0]["Remark"].ToString();
                Reg.Details = ds.Tables[0].Rows[0]["Details"].ToString();
                Reg.PayMode = ds.Tables[0].Rows[0]["PayMode"].ToString();
                Reg.Invoice_No = ds.Tables[0].Rows[0]["Request_No"].ToString();
                Reg.Amt_Type = ds.Tables[0].Rows[0]["Amt_Type"].ToString();
            }
        }
        public static string FindAvaAmount(string str, string Pro_ID)
        {
            dbCommand = database.GetSqlStringCommand("SELECT case when Amount < 0.00 then 0.00 else  Amount end as Amount FROM (SELECT     isnull(SUM(N_Amount),0.00) - isnull((SELECT     SUM(Rec_Amount) FROM Payment_Received WHERE (Payment_For = 'Label') AND (Flag = 1)),0.00) AS Amount FROM M_Generate_Bill WHERE (Trans_Type = 'Label') AND (Comp_ID='" + str + "') AND ((SELECT Pro_ID FROM T_Generate_Bill  WHERE Invoice_No = M_Generate_Bill.Invoice_No)='" + Pro_ID + "') ) AS Reg ");
            return Convert.ToString(database.ExecuteScalar(dbCommand));
        }
        public static string FindAvaAmount(string str)
        {
            dbCommand = database.GetSqlStringCommand("SELECT case when Amount < 0.00 then 0.00 else  Amount end as Amount FROM (SELECT     isnull(SUM(N_Amount),0.00) - isnull((SELECT     SUM(Rec_Amount) FROM Payment_Received WHERE (Payment_For = 'Label') AND (Flag = 1)),0.00) AS Amount FROM M_Generate_Bill WHERE (Trans_Type = 'Label') AND (Comp_ID='" + str + "')) AS Reg ");
            return Convert.ToString(database.ExecuteScalar(dbCommand));
        }
        public static void UpdateReceivedPayment(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_UpdateReceivedPayment");
            database.AddInParameter(dbCommand, "Row_ID", DbType.String, Reg.Row_ID);
            database.AddInParameter(dbCommand, "Admin_Remark", DbType.String, Reg.Admin_Remark);
            database.AddInParameter(dbCommand, "Manu_Remark", DbType.String, Reg.Manu_Remark);
            database.AddInParameter(dbCommand, "Rec_Amount", DbType.String, Reg.Rec_Payment);
            database.AddInParameter(dbCommand, "Flag", DbType.String, Reg.Flag);
            database.AddInParameter(dbCommand, "User_Type", DbType.String, Reg.User_Type);
            database.AddInParameter(dbCommand, "Rec_Date", DbType.DateTime, Reg.Entry_Date);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void UpdateAmcOfferPayment(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_UpdateAmcOfferPayment");
            database.AddInParameter(dbCommand, "Row_ID", DbType.String, Reg.Amc_Offer_ID);
            database.AddInParameter(dbCommand, "Admin_Balance", DbType.String, Reg.Admin_Balance);
            database.AddInParameter(dbCommand, "Manu_Balance", DbType.String, Reg.Manu_Balance);
            database.AddInParameter(dbCommand, "Status", DbType.String, Reg.Status);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void InsertReceivedPayment(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_InsertReceivedPayment");
            database.AddInParameter(dbCommand, "Bank_ID", DbType.String, Reg.Bank_ID);
            database.AddInParameter(dbCommand, "Request_No", DbType.String, Reg.Request_No);
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID);
            database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, Convert.ToDateTime(Reg.Entry_Date).ToString("yyyy/MM/dd hh:mm:ss tt"));
            database.AddInParameter(dbCommand, "Rec_Amount", DbType.Double, Reg.Rec_Payment);
            database.AddInParameter(dbCommand, "Req_Amount", DbType.Double, Reg.Req_Payment);
            database.AddInParameter(dbCommand, "Manu_Remark", DbType.String, Reg.Remarks);
            database.AddInParameter(dbCommand, "Admin_Remark", DbType.String, Reg.Admin_Remarks);
            database.AddInParameter(dbCommand, "PayMode", DbType.String, Reg.PayMode);
            database.AddInParameter(dbCommand, "ModeofPayment", DbType.String, Reg.ModeofPayment);
            database.AddInParameter(dbCommand, "Details", DbType.String, Reg.Details);
            database.AddInParameter(dbCommand, "Payment_For", DbType.String, Reg.Amt_Type);
            database.AddInParameter(dbCommand, "Payment_By", DbType.String, Reg.User_Type);
            database.AddInParameter(dbCommand, "User_Type", DbType.String, Reg.User_Type);
            database.AddInParameter(dbCommand, "Flag", DbType.String, Reg.Flag);
            database.ExecuteNonQuery(dbCommand);
            SetRequest_No();
        }
        public static bool ChangePass(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT COUNT([Comp_ID]) FROM Comp_Reg where [Comp_ID]='" + Reg.Comp_ID + "' AND [Password]='" + Reg.oldPassword + "'");
            if (Convert.ToInt32(database.ExecuteScalar(dbCommand)) == 1)
                return true;
            else
                return false;
        }
        public static void ChangePasswordCompID(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE Comp_Reg SET [Password]='" + Reg.Password + "'  where [Comp_ID]='" + Reg.Comp_ID + "' AND [Password]='" + Reg.oldPassword + "'");
            database.ExecuteNonQuery(dbCommand);

        }
        public static bool ChangePassAdmin(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT count([Row_ID]) FROM [Admin_Login] where [User_Type]='" + Reg.User_Type + "' AND [Password]='" + Reg.oldPassword + "' AND [status]=1 AND [User_ID]='" + Reg.User_ID + "'");
            if (Convert.ToInt32(database.ExecuteScalar(dbCommand)) == 1)
                return true;
            else
                return false;
        }
        public static void ChangePasswordAdmin(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Admin_Login] SET [Password]='" + Reg.Password + "'  where [User_Type]='" + Reg.User_Type + "' AND [Password]='" + Reg.oldPassword + "' AND [status]=1 AND [User_ID]='" + Reg.User_ID + "'");
            database.ExecuteNonQuery(dbCommand);
        }
        public static bool FetchDataForCustonerLogin(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT count([Row_ID]) FROM [Customer_Care] where [User_Type]='" + Reg.User_Type + "' AND [Password]='" + Reg.Password + "' AND [status]=1 AND [Email]='" + Reg.User_ID + "'");
            if (Convert.ToInt32(database.ExecuteScalar(dbCommand)) == 1)
                return true;
            else
                return false;
        }
        public static bool FetchDataForAdminLogin(Object9420 Reg)
        {
            try
            {
                dbCommand = database.GetSqlStringCommand("SELECT count([Row_ID]) FROM [Admin_Login] where [User_Type]='" + Reg.User_Type + "' AND [Password]='" + Reg.Password + "' AND [status]=1 AND [User_ID]='" + Reg.User_ID + "'");
                if (Convert.ToInt32(database.ExecuteScalar(dbCommand)) == 1)
                    return true;
                else
                    return false;
            }
            catch (Exception)
            {

                throw;
            }

        }
        public static string GetTrans_No()
        {
            dbCommand = database.GetSqlStringCommand("SELECT     PrPrefix + '-' + CONVERT(varchar, PrStart) AS Trans_No FROM  Code_Gen WHERE  (Prfor = 'Payment')");
            return Convert.ToString(database.ExecuteScalar(dbCommand));
        }
        public static void SetTrans_No()
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Code_Gen] SET [PrStart] = PrStart + 1 WHERE (Prfor = 'Payment')");
            database.ExecuteNonQuery(dbCommand);
        }
        public static string GetRequest_No()
        {
            dbCommand = database.GetSqlStringCommand("SELECT     PrPrefix + '-' + CONVERT(varchar, PrStart) AS Trans_No FROM  Code_Gen WHERE  (Prfor = 'PayRequest')");
            return Convert.ToString(database.ExecuteScalar(dbCommand));
        }
        public static void SetRequest_No()
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Code_Gen] SET [PrStart] = PrStart + 1 WHERE (Prfor = 'PayRequest')");
            database.ExecuteNonQuery(dbCommand);
        }
        public static DataSet FillGidProductsPricesList(Object9420 Reg)
        {
            string Qry = "SELECT     ISNULL(Price_Master.Rate_Per_Label, 0) AS Rate_Per_Label, Pro_Reg_1.Comp_ID, Pro_Reg_1.Pro_Name, Pro_Reg_1.Pro_ID AS Pro_ID, " +
                       " Comp_Reg.Comp_Name FROM Price_Master RIGHT OUTER JOIN    Pro_Reg AS Pro_Reg_1 ON Price_Master.Pro_ID = Pro_Reg_1.Pro_ID FULL OUTER JOIN " +
                       "  Comp_Reg ON Pro_Reg_1.Comp_ID = Comp_Reg.Comp_ID " +
                "WHERE Comp_Reg.Comp_ID='" + Reg.Comp_ID + "' AND (''= '" + Reg.Pro_ID + "' or Pro_Reg_1.Pro_ID ='" + Reg.Pro_ID + "') AND Pro_Reg_1.Pro_Name <> 'NULL'";
            dbCommand = database.GetSqlStringCommand(Qry);
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID);
            return database.ExecuteDataSet(dbCommand);
        }
        public static void UpdateProductsPrices(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_UpdateProductsPrices");
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID);
            database.AddInParameter(dbCommand, "Rate", DbType.String, Reg.Rate);
            database.ExecuteNonQuery(dbCommand);
        }
        public static bool FindPro_IDInPriceMaster(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Pro_ID] FROM [Price_Master] where [Pro_ID]='" + Reg.Pro_ID + "'");
            string str = Convert.ToString(database.ExecuteScalar(dbCommand));
            if (str == Reg.Pro_ID)
                return true;
            else
                return false;
        }
        public static void InsertProductsPrices(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_InsertProductsPrices");
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID);
            database.AddInParameter(dbCommand, "Rate", DbType.String, Reg.Rate);
            database.ExecuteNonQuery(dbCommand);
        }
        public static bool CheckedPreiceMaster(string p)
        {
            dbCommand = database.GetSqlStringCommand("SELECT COUNT([Pro_ID]) FROM [Price_Master] WHERE [Pro_ID]='" + p + "'");
            if (Convert.ToInt32(database.ExecuteScalar(dbCommand)) == 1)
                return true;
            else
                return false;
        }
        public static void InsertCategoryMaster(string p)
        {
            dbCommand = database.GetSqlStringCommand("SELECT MAX([Cat_Id]+1) as Cat_ID FROM [M_Category]");
            Int32 i = Convert.ToInt32(database.ExecuteScalar(dbCommand));
            dbCommand = database.GetSqlStringCommand("INSERT INTO  [M_Category] ([Cat_Id],[Cat_Name]) VALUES (" + i + ",'" + p + "')");
            database.ExecuteNonQuery(dbCommand);
        }
        public static Int32 FindMaxCategoryMaster()
        {
            dbCommand = database.GetSqlStringCommand("SELECT MAX([Cat_Id]) FROM [M_Category]");
            return Convert.ToInt32(database.ExecuteScalar(dbCommand));
        }
        public static DataSet FindAllocationDataGrid(string p)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Comp_Reg.Comp_ID, Comp_Reg.Comp_Name,count(M_Code.Pro_ID) as AllotCode," +
         " (SELECT COUNT(M_Code.Pro_ID) FROM M_Code INNER JOIN Pro_Reg ON M_Code.Pro_ID = Pro_Reg.Pro_ID" +
         " WHERE (M_Code.Print_Status = 1) and Pro_Reg.Comp_ID = Comp_Reg.Comp_ID) as PrintCode," +
         " (SELECT COUNT(M_Code.Pro_ID) FROM M_Code INNER JOIN Pro_Reg ON M_Code.Pro_ID = Pro_Reg.Pro_ID" +
         " WHERE (M_Code.Print_Status = 0) and Pro_Reg.Comp_ID = Comp_Reg.Comp_ID) as BalanceCode" +
         " FROM M_Code INNER JOIN Pro_Reg ON M_Code.Pro_ID = Pro_Reg.Pro_ID INNER JOIN" +
         " Comp_Reg ON Pro_Reg.Comp_ID = Comp_Reg.Comp_ID  WHERE Comp_Reg.Comp_Name LIKE '%" + p.Replace("'", "''") + "%'" +
         " group by Comp_Reg.Comp_ID , Comp_Reg.Comp_Name");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FindAllocationDataGridNew(string str)
        {

            dbCommand = database.GetSqlStringCommand("SELECT DISTINCT CONVERT(nvarchar, M_Code.Allot_Date, 107) AS Allot_Date11, Comp_Reg.Comp_Name, " +
            " Comp_Reg.Comp_ID,(SELECT     COUNT(DISTINCT Pro_ID) AS Expr1" +
            " FROM M_Code AS mcd WHERE      (convert(nvarchar,Allot_Date,111) = convert(nvarchar,M_Code.Allot_Date,111))" +
             " AND (Pro_ID IS NOT NULL)) AS NumberOfProduct, " +
            " COUNT(M_Code.Pro_ID) AS codeAllocation, " +
            " M_Code.Ref_No, Pro_Reg.Pro_Name, M_Code.Pro_ID," +
            " isnull((SELECT sum([Deallot_Codes]) as dcd FROM [DeAllocateCodes_Log] " +
            " where convert(nvarchar,[Entry_Date],111) = convert(nvarchar, M_Code.Allot_Date,111) and [Pro_ID] = M_Code.Pro_ID" +
            " group by convert(nvarchar,[Entry_Date],111),[Pro_ID]),0) as Deallot,COUNT(M_Code.Pro_ID) + isnull((SELECT sum([Deallot_Codes]) as dcd FROM [DeAllocateCodes_Log] " +
            " where convert(nvarchar,[Entry_Date],111) = convert(nvarchar, M_Code.Allot_Date,111) and [Pro_ID] = M_Code.Pro_ID" +
            " group by convert(nvarchar,[Entry_Date],111),[Pro_ID]),0) as AllotedCodes" +
            " FROM         M_Code INNER JOIN" +
            " Pro_Reg ON M_Code.Pro_ID = Pro_Reg.Pro_ID INNER JOIN" +
            "   Comp_Reg ON Pro_Reg.Comp_ID = Comp_Reg.Comp_ID" +
            " WHERE   Comp_Reg.Comp_Type = 'L' and (M_Code.Allot_Date IS NOT NULL) AND (M_Code.Pro_ID IS NOT NULL) " + str + " " +
            " GROUP BY M_Code.Allot_Date, Comp_Reg.Comp_ID, Comp_Reg.Comp_Name, " +
            " M_Code.Ref_No, Pro_Reg.Pro_Name, M_Code.Pro_ID");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillDataDemoGridDemo(string s)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Email_ID],[Comp_Name],[Contact_No],[Contact_Name]" +
                        " ,[Packet_Name],convert(nvarchar, [Entry_Date],107) as SendDate" +
                        " FROM [Allcation_Demo] " + s + " order by [Entry_Date] desc");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillDataRetailerGrid(string s)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Comp_Email] Email_ID,[Comp_ID],[Comp_Name],[Mobile_No] Contact_No,[Contact_Person] Contact_Name ,'' [Packet_Name],convert(nvarchar, [Reg_Date],107) as SendDate FROM [Comp_Reg] " + s + "  AND IsRetailer = 1 order by [Reg_Date] desc");
            return database.ExecuteDataSet(dbCommand);
        }
        public static object ReturnQuery()
        {
            return Convert.ToString("CONVERT(NUMERIC(18,2),(((isnull(NewViewForAdvance.currentBill,0.00)) + (isnull(NewViewForAdvance.Pre_Amount,0.00))) " +
                                  " - (isnull((case when isnull(NewViewForAdvance.Advance,0.00) = 0.00 then  (SELECT sum([Rec_Amount]) " +
                                  " FROM [Payment_Received]  where ([Comp_ID] = Comp_Reg.Comp_ID) AND (Payment_Type='Label') group by [Comp_ID]) else  " +
                                  " isnull(NewViewForAdvance.Advance,0.00)  end),0.00))))");
        }
        public static DataSet fetchProductCodeDailyCodesUses(Object9420 obj, string Qry)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Pro_Reg.Comp_ID, Pro_Reg.Pro_ID, Pro_Reg.Pro_Name, COUNT(Pro_Reg.Pro_ID) AS AllotedCodes," +
            " (SELECT COUNT(Pro_ID) FROM M_Code WHERE (Pro_ID = Pro_Reg.Pro_ID) AND (Print_Status = 1)) AS PrintCodes," +
            " (SELECT COUNT(Pro_ID) FROM M_Code AS M_Code_3 WHERE (Pro_ID = Pro_Reg.Pro_ID) AND (Print_Status = 0)) AS BalanceCodes, Comp_Reg.Comp_Name + ',' + Pro_Reg.Pro_ID + ',' + CONVERT(nvarchar," +
            " (SELECT COUNT(Pro_ID) FROM M_Code AS M_Code_2 WHERE (Pro_ID = Pro_Reg.Pro_ID) AND (Print_Status = 0)))+','+ Pro_Reg.Pro_Name +','+ Pro_Reg.Comp_ID AS combinedValueCode" +
            " FROM M_Code AS M_Code_1 INNER JOIN Pro_Reg ON M_Code_1.Pro_ID = Pro_Reg.Pro_ID INNER JOIN" +
            " Comp_Reg ON Pro_Reg.Comp_ID = Comp_Reg.Comp_ID" +
            " WHERE (Pro_Reg.Comp_ID = '" + obj.Comp_ID + "') " + Qry + " GROUP BY Pro_Reg.Comp_ID, Pro_Reg.Pro_ID, Pro_Reg.Pro_Name, " +
            " Comp_Reg.Comp_Name");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FindFillGridGeneratedBills(string Qry)
        {
            //dbCommand = database.GetSqlStringCommand("SELECT    (Comp_ID +'_'+ CONVERT(VARCHAR,ROW_NUMBER() OVER(ORDER BY Generate_Date))) AS divID, Row_Id,(SELECT COUNT(Row_Id) FROM  T_Generate_Bill WHERE Invoice_No=M_Generate_Bill.Invoice_No) AS CountInvoiceNo, Invoice_No, Comp_ID,(SELECT Comp_Name FROM Comp_Reg WHERE Comp_ID=M_Generate_Bill.Comp_ID) AS Comp_Name, Generate_Date, G_Amount, Tax, N_Amount, Pre_Bal AS Adjustment,'Bill\\' + convert(nvarchar,Generate_Date,105) + '\\' + Invoice_No + '.pdf' as filepth " +
            //" ,(SELECT SUM(Offer) AS Offer FROM ( Select (SELECT Comp_ID FROM Pro_Reg WHERE Pro_ID = T_Generate_Bill.Pro_ID) AS Comp_ID, Qty * (convert(numeric(18,2),(case when (select Adv_Flag from Pro_Reg WHERE Pro_ID = dbo.T_Generate_Bill.Pro_ID) = 1 then (SELECT     Offer_Tax " +
            //" FROM          dbo.Tax_Master WHERE     (Row_Id = (SELECT     MAX(Row_Id) AS Expr1   FROM          Tax_Master AS Tax_Master_1))) else 0 End))) as Offer from T_Generate_Bill ) Reg WHERE Reg.Comp_ID = M_Generate_Bill.Comp_ID GROUP BY Reg.Comp_ID) AS Offer " +
            //" ,(N_Amount +(SELECT SUM(Offer) AS Offer FROM ( Select (SELECT Comp_ID FROM Pro_Reg WHERE Pro_ID = T_Generate_Bill.Pro_ID) AS Comp_ID, Qty * (convert(numeric(18,2),(case when (select Adv_Flag from Pro_Reg WHERE Pro_ID = dbo.T_Generate_Bill.Pro_ID) = 1 then (SELECT     Offer_Tax " +
            //" FROM dbo.Tax_Master WHERE     (Row_Id = (SELECT     MAX(Row_Id) AS Expr1   FROM          Tax_Master AS Tax_Master_1))) else 0 End))) as Offer from T_Generate_Bill ) Reg WHERE Reg.Comp_ID = M_Generate_Bill.Comp_ID GROUP BY Reg.Comp_ID)) as Bill_Amt" + 
            //" FROM M_Generate_Bill " + Qry + " --and (SELECT COUNT(Row_Id) FROM  T_Generate_Bill WHERE Invoice_No=M_Generate_Bill.Invoice_No) <> 0");
            //dbCommand = database.GetSqlStringCommand("SELECT     1 as CountInvoiceNo,CONVERT(varchar, T_Generate_Bill.Row_Id) + '_' + Comp_Reg.Comp_ID AS divID, T_Generate_Bill.Row_Id, T_Generate_Bill.Invoice_No, Comp_Reg.Comp_Name,  " +
            // " Pro_Reg.Comp_ID, M_Generate_Bill.Generate_Date, M_Generate_Bill.G_Amount, M_Generate_Bill.Tax, M_Generate_Bill.N_Amount,  M_Generate_Bill.Pre_Bal Adjustment,'Bill\' + convert(nvarchar,M_Generate_Bill.Generate_Date,105) + '\' + M_Generate_Bill.Invoice_No + '.pdf' as filepth  " +
            // ",(case when M_Generate_Bill.Pre_Bal > M_Generate_Bill.N_Amount then 0 else  M_Generate_Bill.N_Amount-M_Generate_Bill.Pre_Bal end) AS Bill_Amt, '' AS offer" +
            //" FROM  T_Generate_Bill INNER JOIN  Pro_Reg ON T_Generate_Bill.Pro_ID = Pro_Reg.Pro_ID INNER JOIN  M_Generate_Bill ON T_Generate_Bill.Invoice_No = M_Generate_Bill.Invoice_No INNER JOIN   Comp_Reg ON M_Generate_Bill.Comp_ID = Comp_Reg.Comp_ID " + Qry);
            dbCommand = database.GetSqlStringCommand("SELECT   CASE WHEN mg.Trans_Type IS NULL THEN 0 ELSE (SELECT COUNT(Row_Id) FROM T_Generate_Bill WHERE Invoice_No=mg.Invoice_No) END AS CountInvoiceNo, CONVERT(VARCHAR,mg.Row_Id) + '_' + mg.Comp_ID AS divID,  " +
            " mg.Row_Id, mg.Invoice_No,(SELECT Comp_Name FROM Comp_Reg WHERE Comp_ID = mg.Comp_ID) as Comp_Name, mg.Comp_ID, mg.Generate_Date, mg.G_Amount, mg.Tax, mg.N_Amount, mg.Pre_Bal as Adjustment, mg.Trans_Type, " +
            " 'Bill' + convert(nvarchar,mg.Generate_Date,105) + '' + mg.Invoice_No + '.pdf' as filepth, (case when mg.Pre_Bal > mg.N_Amount then 0 else  mg.N_Amount-mg.Pre_Bal end) AS Bill_Amt, '' as offer,(SELECT Pro_ID FROM T_Generate_Bill WHERE Invoice_No=mg.Invoice_No) AS Pro_ID FROM  M_Generate_Bill AS mg  " + Qry + " ORDER BY mg.Generate_Date DESC ");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FetchInvoiceNoWiseDetails(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Pro_ID,Pro_Name,Qty,Rate,G_Amount,Tax,CONVERT(NUMERIC(18,2),(G_Amount+Tax)) AS N_Amount,Tax1 FROM(SELECT  Pro_ID,(SELECT Pro_Name FROM Pro_Reg WHERE Pro_ID=T_Generate_Bill.Pro_ID) AS Pro_Name, Qty, Rate, G_Amount,convert(numeric(18,2),((G_Amount * (SELECT  Service_Tax FROM  Tax_Master WHERE Row_ID = (SELECT  max(Row_ID) FROM  Tax_Master)))/100)) as Tax, " +
            " G_Amount + convert(numeric(18,2),((G_Amount * (SELECT  Service_Tax FROM  Tax_Master WHERE Row_ID = (SELECT  max(Row_ID) FROM  Tax_Master)))/100)) N_Amount,(SELECT  Service_Tax FROM  Tax_Master WHERE Row_ID = (SELECT  max(Row_ID) FROM  Tax_Master))as Tax1 " +
            " ,Invoice_No FROM T_Generate_Bill) Reg WHERE Reg.Invoice_No='" + obj.Invoice_No + "'");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FetchInvoiceNoWiseAmcOfferDetails(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  t.Row_Id, t.Invoice_No, t.Pro_ID,(SELECT Pro_Name FROM Pro_Reg WHERE Pro_ID = t.Pro_ID) as Pro_Name, t.Plan_ID, m.Plan_Name, convert(varchar,m.Date_From,107) as [Start_Date], convert(varchar,m.Date_To,107) as End_Date, " +
            " convert(numeric(18,2),t.G_Amount / (1+((SELECT Service_Tax FROM Tax_Master where Row_Id = (SELECT max(Row_Id) FROM Tax_Master))/100))) as G_Amount, t.G_Amount-(convert(numeric(18,2),t.G_Amount / (1+((SELECT Service_Tax FROM Tax_Master where Row_Id = (SELECT max(Row_Id) FROM Tax_Master))/100)))) as Tax, " +
            " t.G_Amount as N_Amount, t.Qty, t.Rate,t.Pre_Bal FROM T_Generate_Bill AS t INNER JOIN M_Amc_Offer AS m ON t.Amc_Offer_ID = m.Row_ID  WHERE t.Invoice_No = '" + obj.Invoice_No + "'");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataTable FindProducts(Object9420 Reg)
        {
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT M_Code.Pro_ID, Pro_Reg.Pro_Name, COUNT(M_Code.Row_ID) AS Cnt" +
            " FROM M_Code INNER JOIN Pro_Reg ON M_Code.Pro_ID = Pro_Reg.Pro_ID" +
            " WHERE (Pro_Reg.Comp_ID = '" + Reg.Comp_ID + "') AND (M_Code.Use_Type IS NULL)" +
            " GROUP BY M_Code.Pro_ID, Pro_Reg.Pro_Name order by Pro_Reg.Pro_Name");
            DataView dv = ds.Tables[0].DefaultView;
            if (ds.Tables[0].Rows.Count > 0)
            {
                dv.RowFilter = "Cnt <> 0";
            }
            return dv.ToTable();
        }
        public static DataSet FillGidProductsWiseDetails(Object9420 Reg, bool flag)
        {
            if (flag == true)
            {
                dbCommand = database.GetSqlStringCommand("SELECT  Row_ID,Code1, Code2,(case when (Pro_ID+'-'+  convert(varchar,(case when len(convert(nvarchar,M_Code.Series_Order)) = 1  " +
                " then '0'+ convert(nvarchar,M_Code.Series_Order) else  " +
                " convert(nvarchar,M_Code.Series_Order) end))+'-'+ convert(varchar," +
                " (case when len(convert(varchar,M_Code.Series_Serial)) = 1 then '00' " +
                " +convert(varchar,M_Code.Series_Serial)   when len(convert(varchar,M_Code.Series_Serial)) = 2 " +
                " then '0'  +convert(varchar,M_Code.Series_Serial)  else convert(varchar,M_Code.Series_Serial) end ))) is null then use_type else (Pro_ID+'-'+  convert(varchar,(case when len(convert(nvarchar,M_Code.Series_Order)) = 1  " +
                " then '0'+ convert(nvarchar,M_Code.Series_Order) else  " +
                " convert(nvarchar,M_Code.Series_Order) end))+'-'+ convert(varchar," +
                " (case when len(convert(varchar,M_Code.Series_Serial)) = 1 then '00' " +
                " +convert(varchar,M_Code.Series_Serial)   when len(convert(varchar,M_Code.Series_Serial)) = 2 " +
                " then '0'  +convert(varchar,M_Code.Series_Serial)  else convert(varchar,M_Code.Series_Serial) end )))" +
                " end)" +
                " as Pro_ID,(select Pro_Name from Pro_Reg WHERE Pro_ID=M_Code.Pro_ID) AS Pro_Name, ISNULL(Use_Count,0) as Use_Count  " +
                                " FROM         M_Code WHERE Print_Status=1 AND Batch_No <> '' AND Pro_ID='" + Reg.Pro_ID + "'" + Reg.Password);
            }
            else if (flag == false)
            {
                dbCommand = database.GetSqlStringCommand("SELECT  Row_ID,Code1, Code2,(case when (Pro_ID+'-'+  convert(varchar,(case when len(convert(nvarchar,M_Code.Series_Order)) = 1  " +
                " then '0'+ convert(nvarchar,M_Code.Series_Order) else  " +
                " convert(nvarchar,M_Code.Series_Order) end))+'-'+ convert(varchar," +
                " (case when len(convert(varchar,M_Code.Series_Serial)) = 1 then '00' " +
                " +convert(varchar,M_Code.Series_Serial)   when len(convert(varchar,M_Code.Series_Serial)) = 2 " +
                " then '0'  +convert(varchar,M_Code.Series_Serial)  else convert(varchar,M_Code.Series_Serial) end ))) is null then use_type else (Pro_ID+'-'+  convert(varchar,(case when len(convert(nvarchar,M_Code.Series_Order)) = 1  " +
                " then '0'+ convert(nvarchar,M_Code.Series_Order) else  " +
                " convert(nvarchar,M_Code.Series_Order) end))+'-'+ convert(varchar," +
                " (case when len(convert(varchar,M_Code.Series_Serial)) = 1 then '00' " +
                " +convert(varchar,M_Code.Series_Serial)   when len(convert(varchar,M_Code.Series_Serial)) = 2 " +
                " then '0'  +convert(varchar,M_Code.Series_Serial)  else convert(varchar,M_Code.Series_Serial) end )))" +
                " end)" +
                " as Pro_ID,(select Pro_Name from Pro_Reg WHERE Pro_ID=M_Code.Pro_ID) AS Pro_Name,ISNULL(Use_Count,0) as Use_Count  " +
                                " FROM         M_Code WHERE Print_Status=1 AND Batch_No <> '' AND Pro_ID IN (SELECT Pro_ID FROM Pro_Reg where Comp_ID ='" + Reg.Comp_ID + "') " + Reg.Password + " order by Batch_No ASC");
            }
            return database.ExecuteDataSet(dbCommand);
        }
        public static void ResetDataAll(int keyval)
        {
            dbCommand = database.GetStoredProcCommand("proc_ResetDatabase"); dbCommand.CommandTimeout = 5000;
            database.AddInParameter(dbCommand, "KeyVal", DbType.String, keyval);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void ResetCodeBank(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_ResetCodeBank"); dbCommand.CommandTimeout = 5000;
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.ExecuteNonQuery(dbCommand);
            dbCommand = database.GetSqlStringCommand("SELECT Comp_ID FROM Courier_Dispatch_Master");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count == 0)
                SetPreFixStart(101, "Dispatch");
        }
        public static void ResetPrintAll(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_ResetPrint"); dbCommand.CommandTimeout = 5000;
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.ExecuteNonQuery(dbCommand);
            dbCommand = database.GetSqlStringCommand("SELECT Comp_ID FROM Courier_Dispatch_Master");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count == 0)
                SetPreFixStart(101, "Dispatch");
        }
        public static void ResetAllInvoice(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_ResetAllInvoice"); dbCommand.CommandTimeout = 5000;
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void RemoveCompany(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_RemoveCompany"); dbCommand.CommandTimeout = 5000;
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.ExecuteNonQuery(dbCommand);
            DataSet ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT Row_ID FROM  Pro_Reg");
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count == 0)
            {
                dbCommand = database.GetSqlStringCommand("UPDATE [Code_Gen] SET PrPrefix = 'AA' , [PrStart] = 100 WHERE [Prfor]= 'Product'");
                database.ExecuteNonQuery(dbCommand);
            }
            ds.Reset();
            dbCommand = database.GetSqlStringCommand("SELECT Comp_ID FROM  Comp_Reg");
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count == 0)
            {
                dbCommand = database.GetSqlStringCommand("UPDATE [Code_Gen] SET [PrStart] = 1001 WHERE [Prfor] = 'Company'");
                database.ExecuteNonQuery(dbCommand);
                dbCommand = database.GetSqlStringCommand("UPDATE [Code_Gen] SET PrPrefix = 'AA' , [PrStart] = 100 WHERE [Prfor]= 'Product'");
                database.ExecuteNonQuery(dbCommand);
            }
        }
        public static void ProductReset(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Pro_Name FROM  Pro_Reg WHERE Comp_ID = '" + Reg.Comp_ID + "' AND  Pro_ID = '" + Reg.Pro_ID + "'");
            Reg.Pro_Name = database.ExecuteScalar(dbCommand).ToString();
            dbCommand = database.GetStoredProcCommand("PROC_ProductReset");
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID);
            database.ExecuteNonQuery(dbCommand);
            DataSet ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT Row_ID FROM  Pro_Reg");
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count == 0)
            {
                dbCommand = database.GetSqlStringCommand("UPDATE [Code_Gen] SET PrPrefix = 'AA' , [PrStart] = 100 WHERE [Prfor]= 'Product'");
                database.ExecuteNonQuery(dbCommand);
            }
        }
        public static void ResetProducts(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_ResetProducts");
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.ExecuteNonQuery(dbCommand);
            DataSet ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT Row_ID FROM  Pro_Reg");
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count == 0)
            {
                dbCommand = database.GetSqlStringCommand("UPDATE [Code_Gen] SET PrPrefix = 'AA' , [PrStart] = 100 WHERE [Prfor]= 'Product'");
                database.ExecuteNonQuery(dbCommand);
            }
        }
        public static void UploadDocument(Object9420 Reg)
        {
            DataTable dt = SQL_DB.ExecuteDataTable("SELECT Comp_ID FROM Comp_Document WHERE Comp_ID = '" + Reg.Comp_ID + "'");
            // if (dt.Rows.Count > 0)
            //    return;
            dbCommand = database.GetStoredProcCommand("PROC_UploadDocuments"); dbCommand.CommandTimeout = 5000;
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.AddInParameter(dbCommand, "Comp_Info", DbType.String, Reg.Comp_Info);
            database.AddInParameter(dbCommand, "PAN_TAN", DbType.String, Reg.PAN_TAN);
            database.AddInParameter(dbCommand, "VAT", DbType.String, Reg.VAT);
            database.AddInParameter(dbCommand, "Comp_Addressproof", DbType.String, Reg.Comp_Addressproof);
            database.AddInParameter(dbCommand, "Owner_proof", DbType.String, Reg.Owner_proof);
            database.AddInParameter(dbCommand, "Signature", DbType.String, Reg.Signature);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void UploadDocuments(Object9420 Reg)
        {
            UploadDocument(Reg);
            if (Reg.DML == "I")
                FillDocInfo(Reg);
        }
        public static void UpdateDocForVerification(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_VerifyDoc");
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.AddInParameter(dbCommand, "Doc_Id", DbType.String, Reg.Doc_Id);
            database.AddInParameter(dbCommand, "Flag", DbType.String, Reg.DocFlag);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void FillDocInfo(Object9420 Reg)
        {
            string[] ArrInfo = { "_Info", "_PANTAN", "_VAT", "_Add", "_Own", "_Sign" };
            for (int i = 0; i < ArrInfo.Length; i++)
            {
                Reg.Doc_Id = Reg.Comp_ID.ToString().Substring(5, 4) + ArrInfo[i].ToString(); Reg.DocFlag = 0;
                dbCommand = database.GetStoredProcCommand("PROC_VerifyDoc");
                database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
                database.AddInParameter(dbCommand, "Doc_Id", DbType.String, Reg.Doc_Id);
                database.AddInParameter(dbCommand, "Flag", DbType.String, Reg.DocFlag);
                database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
                database.ExecuteNonQuery(dbCommand);
            }
        }
        /// <summary>
        /// Created by shweta, combing the 2 qry
        /// </summary>
        /// <param name="Reg"></param>
        /// <returns></returns>
        public static DataSet FindCompanyDocuments(Object9420 Reg)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetStoredProcCommand("PROC_GetCompUploadDocuments");
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
        public static DataSet FindDataForDocuments(Object9420 Reg)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetStoredProcCommand("PROC_FindUploadDocuments");
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
        public static DataSet FindVerifyData(Object9420 Reg)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT [Row_ID], [Comp_ID], [Doc_Id], [Flag],(case when Flag = 1 then 'Verified' when Flag = -1 then 'Rejected' else 'Approval pending from admin' end) as [DocSt],(case when Flag = 1 then 'Verified' when Flag = -1 then substring([Remarks],0,charindex('</h3>',[Remarks])+5) + ' document rejected due to ' + substring([Remarks],charindex('</h3>',[Remarks])+5,len([Remarks])-charindex('</h3>',[Remarks])) else 'Approval pending from admin' end) as [Docstremarks],[Remarks] FROM Comp_Doc_Flag where Comp_ID = '" + Reg.Comp_ID + "' order by  Doc_Id");
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
        public static void VerifyAll(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_Verify");
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.AddInParameter(dbCommand, "Remarks", DbType.String, Reg.Remarks);
            database.AddInParameter(dbCommand, "Row_Id", DbType.String, Reg.Row_ID);
            database.AddInParameter(dbCommand, "Flag", DbType.String, Reg.DocFlag);
            database.ExecuteNonQuery(dbCommand);
        }
        public static bool CheckedVerifyFlag(Object9420 Reg)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT Count(Flag) as Flag FROM Comp_Doc_Flag WHERE Comp_ID = '" + Reg.Comp_ID + "' GROUP BY Comp_ID, Flag ");
            ds = database.ExecuteDataSet(dbCommand); int p = 0;
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows.Count == 1)
                {
                    p = Convert.ToInt32(ds.Tables[0].Rows[0]["Flag"].ToString());
                    if (p == 7)
                        return true;
                }
                else
                    return false;
            }
            return false;
        }
        public static void UpdateDocFlag(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Comp_Reg] SET [Doc_Flag] =1  WHERE [Comp_ID]  = '" + Reg.Comp_ID + "'"); dbCommand.CommandTimeout = 5000;
            database.ExecuteNonQuery(dbCommand);
        }
        public static void UpdateDocFlagInActive(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Comp_Reg] SET [Doc_Flag] =0  WHERE [Comp_ID]  = '" + Reg.Comp_ID + "'"); dbCommand.CommandTimeout = 5000;
            database.ExecuteNonQuery(dbCommand);
        }
        #region Create Label Methods
        public static DataSet FillGridLabel(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_FillLabelDetails");
            database.AddInParameter(dbCommand, "Label_Name", DbType.String, Reg.Label_Name);
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillGridPlan(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_FillAmcDetails");
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID);
            database.AddInParameter(dbCommand, "Amount", DbType.String, Reg.PlanAmount);
            database.AddInParameter(dbCommand, "Disp", DbType.String, Reg.Disp);
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillGridPlan(int i)
        {
            dbCommand = database.GetSqlStringCommand("SELECT *, " + i + " as Disp  FROM M_Plan");
            return database.ExecuteDataSet(dbCommand);
        }
        public static string GetRequestLabelCode(string p)
        {
            dbCommand = database.GetSqlStringCommand("SELECT CONVERT(VARCHAR,[PrStart]) AS LblCode FROM Code_Gen WHERE [Prfor]='" + p + "'");
            return database.ExecuteScalar(dbCommand).ToString();
        }
        public static string GetCategoryCode(string p)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [PrStart] AS LblCode FROM Code_Gen WHERE [Prfor]='" + p + "'");
            return database.ExecuteScalar(dbCommand).ToString();
        }
        public static string GetLabelCode(string p)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [PrPrefix]+'_'+CONVERT(VARCHAR,[PrStart]) AS LblCode FROM Code_Gen WHERE [Prfor]='" + p + "'");
            return database.ExecuteScalar(dbCommand).ToString();
        }
        public static void UpdateLabelCode(string p)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE Code_Gen SET [PrStart]=[PrStart]+1 WHERE [Prfor]='" + p + "'");
            database.ExecuteNonQuery(dbCommand);
        }
        public static void SaveOfferPlan(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_SaveOfferPlan");
            database.AddInParameter(dbCommand, "Promo_ID", DbType.String, Reg.Promo_Id);
            database.AddInParameter(dbCommand, "Promo_Name", DbType.String, Reg.Promo_Name);
            database.AddInParameter(dbCommand, "Time_Days", DbType.Int32, Reg.Plan_Time);
            database.AddInParameter(dbCommand, "Plan_Amount", DbType.Double, Reg.Plan_Amount);
            database.AddInParameter(dbCommand, "Entry_Date", DbType.String, Reg.Entry_Date.ToString("yyyy/MM/dd hh:mm:ss tt"));
            database.AddInParameter(dbCommand, "Flag", DbType.Int32, Reg.Flag);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void SaveDiscountPlanMaster(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_SaveDiscount");
            database.AddInParameter(dbCommand, "Row_ID", DbType.String, Reg.Row_ID);
            database.AddInParameter(dbCommand, "Plan_ID", DbType.String, Reg.Plan_ID);
            database.AddInParameter(dbCommand, "Plan_Name", DbType.String, Reg.Plan_Name);
            database.AddInParameter(dbCommand, "Plan_Time", DbType.Int32, Reg.Plan_Time);
            database.AddInParameter(dbCommand, "Plan_Amount", DbType.Double, Reg.Plan_Amount);
            database.AddInParameter(dbCommand, "Plan_Discount", DbType.Double, Reg.Plan_Discount);
            database.AddInParameter(dbCommand, "Trans_Type", DbType.String, Reg.Trans_Type);
            database.AddInParameter(dbCommand, "Date_From", DbType.String, Reg.DateFrom.ToString("yyyy/MM/dd"));
            database.AddInParameter(dbCommand, "Date_To", DbType.String, Reg.DateTo.ToString("yyyy/MM/dd"));
            database.AddInParameter(dbCommand, "Entry_Date", DbType.String, Reg.Entry_Date.ToString("yyyy/MM/dd hh:mm:ss tt"));
            database.AddInParameter(dbCommand, "Flag", DbType.Int32, Reg.Flag);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void SaveAmcPlan(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_SaveAmcPlan");
            database.AddInParameter(dbCommand, "Plan_ID", DbType.String, Reg.Plan_ID);
            database.AddInParameter(dbCommand, "Plan_Name", DbType.String, Reg.Plan_Name);
            database.AddInParameter(dbCommand, "Plan_Time", DbType.Int32, Reg.Plan_Time);
            database.AddInParameter(dbCommand, "Plan_Amount", DbType.Double, Reg.Plan_Amount);
            database.AddInParameter(dbCommand, "Entry_Date", DbType.String, Reg.Entry_Date.ToString("yyyy/MM/dd hh:mm:ss tt"));
            database.AddInParameter(dbCommand, "Flag", DbType.Int32, Reg.Flag);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void SaveUploadLabelPastingReport(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_SaveUploadLabelPastingRpt");
            database.AddInParameter(dbCommand, "File_ID", DbType.String, Reg.LabelUploadRptID);
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID);
            database.AddInParameter(dbCommand, "Batch_No", DbType.String, Reg.Batch_No);
            database.AddInParameter(dbCommand, "FilePath", DbType.String, Reg.Label_Image);
            database.AddInParameter(dbCommand, "Entry_Date", DbType.String, Reg.Entry_Date.ToString("yyyy/MM/dd hh:mm:ss tt"));
            database.AddInParameter(dbCommand, "Flag", DbType.Int32, Reg.Flag);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void SaveLabel(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_SaveLabel");
            database.AddInParameter(dbCommand, "Label_Code", DbType.String, Reg.Label_Code);
            database.AddInParameter(dbCommand, "Label_Name", DbType.String, Reg.Label_Name);
            database.AddInParameter(dbCommand, "Label_Size", DbType.String, Reg.Label_Size);
            database.AddInParameter(dbCommand, "Label_Prise", DbType.String, Reg.Label_Prise);
            database.AddInParameter(dbCommand, "Label_Image", DbType.String, Reg.Label_Image);
            database.AddInParameter(dbCommand, "Entry_Date", DbType.String, Reg.Entry_Date.ToString("yyyy/MM/dd hh:mm:ss tt"));
            database.AddInParameter(dbCommand, "Flag", DbType.Int32, Reg.Flag);
            database.ExecuteNonQuery(dbCommand);
        }

        public static void UpdateLabel(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_UpdateLabel");
            database.AddInParameter(dbCommand, "Label_Code", DbType.String, Reg.Label_Code);
            database.AddInParameter(dbCommand, "Label_Prise", DbType.String, Reg.Label_Prise);
            database.AddInParameter(dbCommand, "Entry_Date", DbType.String, Reg.Entry_Date.ToString("yyyy/MM/dd hh:mm:ss tt"));
            database.ExecuteNonQuery(dbCommand);
            dbCommand = database.GetSqlStringCommand("INSERT INTO [T_LabelPriseLog]  ([Label_Code],[Label_Prise],[Entry_Date]) VALUES ('" + Reg.Label_Code + "','" + Reg.Label_Prise + "','" + Convert.ToDateTime(Reg.Entry_Date).ToString("yyyy/MM/dd hh:mm:ss tt") + "') "); dbCommand.CommandTimeout = 5000;
            database.ExecuteNonQuery(dbCommand);
        }
        public static DataSet FillPlanLog(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Plan_ID, Plan_Name, Plan_Time, Plan_Amount, Entry_Date FROM M_Plan_Log WHERE Plan_ID = '" + Reg.Plan_ID + "' ORDER BY Entry_Date DESC");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillofferInfo(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Promo_ID, Promo_Name, Time_Days, Amount,Entry_Date FROM M_Promotional_Log WHERE Promo_ID = '" + Reg.Promo_Id + "' ORDER BY Entry_Date DESC ");
            return database.ExecuteDataSet(dbCommand);
        }
        public static void FillofferPlanInfo(Object9420 Reg)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT Promo_ID, Promo_Name, Time_Days, Amount,Entry_Date, Flag,(CASE WHEN Flag = 1 then 'Activated' else 'De-Activated' end) as Status FROM M_Promotional WHERE Promo_ID = '" + Reg.Promo_Id + "' ");
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Promo_Id = ds.Tables[0].Rows[0]["Promo_ID"].ToString();
                Reg.Promo_Name = ds.Tables[0].Rows[0]["Promo_Name"].ToString();
                int TIME = Convert.ToInt32(ds.Tables[0].Rows[0]["Time_Days"].ToString());
                if (TIME > 0)
                {
                    if (TIME >= 360)
                    {
                        Reg.Plan_year = TIME / (30 * 12);
                        TIME = TIME - (Reg.Plan_year * 12 * 30);
                        if (TIME >= 30)
                        {
                            Reg.Plan_months = TIME / 30;
                            Reg.Plan_days = TIME - (Reg.Plan_months * 30);
                        }
                        else
                            Reg.Plan_days = TIME;
                    }
                    else
                    {
                        Reg.Plan_year = 0;
                        if (TIME >= 30)
                        {
                            Reg.Plan_months = TIME / 30;
                            Reg.Plan_days = TIME - (Reg.Plan_months * 30);
                        }
                        else
                            Reg.Plan_days = TIME;

                    }
                }
                Reg.Plan_Amount = Convert.ToDouble(ds.Tables[0].Rows[0]["Amount"].ToString());
                Reg.Flag = Convert.ToInt32(ds.Tables[0].Rows[0]["Flag"].ToString());
                Reg.Msg = ds.Tables[0].Rows[0]["Status"].ToString();
            }
        }
        public static void FillPlanInfo(Object9420 Reg)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT Plan_ID, Plan_Name, Plan_Time, Plan_Amount, Plan_Discount, Entry_Date, Flag,(CASE WHEN Flag = 1 then 'Activated' else 'De-Activated' end) as Status FROM M_Plan WHERE Plan_ID = '" + Reg.Plan_ID + "' ");
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Plan_ID = ds.Tables[0].Rows[0]["Plan_ID"].ToString();
                Reg.Plan_Name = ds.Tables[0].Rows[0]["Plan_Name"].ToString();
                int TIME = Convert.ToInt32(ds.Tables[0].Rows[0]["Plan_Time"].ToString());
                if (TIME > 0)
                {
                    if (TIME >= 12)
                    {
                        Reg.Plan_year = TIME / 12;
                        Reg.Plan_months = TIME - (Reg.Plan_year * 12);
                    }
                    else
                        Reg.Plan_months = TIME - (Reg.Plan_year * 12);
                }
                Reg.Plan_Amount = Convert.ToDouble(ds.Tables[0].Rows[0]["Plan_Amount"].ToString());
                Reg.Flag = Convert.ToInt32(ds.Tables[0].Rows[0]["Flag"].ToString());
                Reg.Msg = ds.Tables[0].Rows[0]["Status"].ToString();
            }
        }

        public static DataSet FillLabelInfo(string lblid)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetStoredProcCommand("PROC_LabelInfo");
            database.AddInParameter(dbCommand, "Label_Code", DbType.String, lblid);
            ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }
        public static void FillLabelInfo(Object9420 Reg)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetStoredProcCommand("PROC_LabelInfo");
            database.AddInParameter(dbCommand, "Label_Code", DbType.String, Reg.Label_Code);
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Label_Code = ds.Tables[0].Rows[0]["Label_Code"].ToString();
                Reg.Label_Name = ds.Tables[0].Rows[0]["Label_Name"].ToString();
                Reg.Label_Size = ds.Tables[0].Rows[0]["Label_Size"].ToString();
                string[] Arr = ds.Tables[0].Rows[0]["Label_Size"].ToString().Split('X');
                if (Arr.Length > 0)
                {
                    Reg.Label_Width = Arr[0].ToString();
                    Reg.Label_Height = Arr[1].ToString();
                }
                Reg.Label_Prise = Convert.ToDouble(ds.Tables[0].Rows[0]["Label_Prise"].ToString());
                Reg.Label_Image = ds.Tables[0].Rows[0]["Label_Image"].ToString();
                Reg.Entry_Date = Convert.ToDateTime(ds.Tables[0].Rows[0]["Entry_Date"].ToString());
                Reg.Flag = Convert.ToInt32(ds.Tables[0].Rows[0]["Flag"].ToString());
                Reg.Label_Msg = ds.Tables[0].Rows[0]["Tp"].ToString();
            }
        }

        public static DataSet FillLabelPriseInfo(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT T_LabelPriseLog.Row_Id, T_LabelPriseLog.Label_Code, T_LabelPriseLog.Label_Prise, T_LabelPriseLog.Entry_Date, M_Label.Label_Name,M_Label.Label_Size FROM T_LabelPriseLog LEFT OUTER JOIN  M_Label ON T_LabelPriseLog.Label_Code = M_Label.Label_Code WHERE T_LabelPriseLog.Label_Code = '" + Reg.Label_Code + "' ORDER BY T_LabelPriseLog.Entry_Date"); dbCommand.CommandTimeout = 5000;
            return database.ExecuteDataSet(dbCommand);
        }
        public static void UpdateOfferPlanFlag(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Flag] FROM [M_Promotional] WHERE [Promo_ID] = '" + Reg.Promo_Id + "'");
            Reg.Flag = Convert.ToInt32(database.ExecuteScalar(dbCommand));
            if (Reg.Flag == 1)
                Reg.Flag = 0;
            else
            {
                if (Reg.Flag == 0)
                    Reg.Flag = 1;
            }
            dbCommand = database.GetSqlStringCommand("UPDATE [M_Promotional]  SET [Flag] = " + Reg.Flag + " WHERE [Promo_ID] = '" + Reg.Promo_Id + "'");
            database.ExecuteNonQuery(dbCommand);
        }
        public static void UpdateDiscountFlag(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Flag] FROM [M_PlanDiscount] WHERE [Row_ID] = '" + Reg.Row_ID + "'");
            Reg.Flag = Convert.ToInt32(database.ExecuteScalar(dbCommand));
            if (Reg.Flag == 1)
                Reg.Flag = 0;
            else
            {
                if (Reg.Flag == 0)
                    Reg.Flag = 1;
            }
            dbCommand = database.GetSqlStringCommand("UPDATE [M_PlanDiscount]  SET [Flag] = " + Reg.Flag + " WHERE [Row_ID] = '" + Reg.Row_ID + "'");
            database.ExecuteNonQuery(dbCommand);
        }
        public static void UpdatePlanFlag(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Flag] FROM [M_Plan] WHERE [Plan_ID] = '" + Reg.Plan_ID + "'");
            Reg.Flag = Convert.ToInt32(database.ExecuteScalar(dbCommand));
            if (Reg.Flag == 1)
                Reg.Flag = 0;
            else
            {
                if (Reg.Flag == 0)
                    Reg.Flag = 1;
            }
            dbCommand = database.GetSqlStringCommand("UPDATE [M_Plan]  SET [Flag] = " + Reg.Flag + " WHERE [Plan_ID] = '" + Reg.Plan_ID + "'");
            database.ExecuteNonQuery(dbCommand);
        }
        public static void UpdateLabelFlag(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Flag] FROM [M_Label] WHERE [Label_Code] = '" + Reg.Label_Code + "'");
            Reg.Flag = Convert.ToInt32(database.ExecuteScalar(dbCommand));
            if (Reg.Flag == 1)
                Reg.Flag = 0;
            else
            {
                if (Reg.Flag == 0)
                    Reg.Flag = 1;
            }
            dbCommand = database.GetSqlStringCommand("UPDATE [M_Label]  SET [Flag] = " + Reg.Flag + " WHERE [Label_Code] = '" + Reg.Label_Code + "'");
            database.ExecuteNonQuery(dbCommand);
        }
        #endregion
        #region Category Master Methods
        public static DataSet FillGridCategory(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Category_ID, Category_Name,Entry_Date, Flag,(CASE WHEN Flag = 0 then 'Click for Activated' else 'Click for Un-Activated' end) AS TooTipMsg,(CASE WHEN Flag = 1 then 'Activated' else 'De-Activated' end) as Status FROM Category_Master WHERE Category_Name LIKE '%" + Reg.Category_Name + "%' AND (''= '" + Reg.Category_ID + "' or Category_ID = '" + Reg.Category_ID + "')");
            return database.ExecuteDataSet(dbCommand);
        }
        public static void SaveCategory(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_SaveCategory");
            database.AddInParameter(dbCommand, "Category_ID", DbType.String, Reg.Category_ID);
            database.AddInParameter(dbCommand, "Category_Name", DbType.String, Reg.Category_Name);
            database.AddInParameter(dbCommand, "Entry_Date", DbType.String, Reg.Entry_Date.ToString("yyyy/MM/dd hh:mm:ss tt"));
            database.AddInParameter(dbCommand, "Flag", DbType.Int32, Reg.Flag);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void UpdateCategoryFlag(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Flag] FROM [Category_Master] WHERE [Category_ID] = '" + Reg.Category_ID + "'");
            Reg.Flag = Convert.ToInt32(database.ExecuteScalar(dbCommand));
            if (Reg.Flag == 1)
                Reg.Flag = 0;
            else
            {
                if (Reg.Flag == 0)
                    Reg.Flag = 1;
            }
            dbCommand = database.GetSqlStringCommand("UPDATE [Category_Master]  SET [Flag] = " + Reg.Flag + " WHERE [Category_ID] = '" + Reg.Category_ID + "'");
            database.ExecuteNonQuery(dbCommand);
        }

        public static DataSet FillGridCustomer(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  Customer_Id, Customer_Name, Email,Mobile_No, Password,Address, Status as Flag, User_Type, Entry_Date,(CASE WHEN Status = 0 then 'Click for Activated' else 'Click for Un-Activated' end) AS TooTipMsg,(CASE WHEN Status = 1 then 'Activated' else 'De-Activated' end) as Status FROM Customer_Care WHERE Customer_Name LIKE '%" + Reg.Name + "%' AND (''= '" + Reg.Customer_ID + "' or Customer_ID = '" + Reg.Customer_ID + "')");
            return database.ExecuteDataSet(dbCommand);
        }
        public static void SaveCustomer(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_SaveCustomer");
            database.AddInParameter(dbCommand, "Customer_ID", DbType.String, Reg.Customer_ID);
            database.AddInParameter(dbCommand, "Customer_Name", DbType.String, Reg.Customer_Name);
            database.AddInParameter(dbCommand, "Email", DbType.String, Reg.Email);
            database.AddInParameter(dbCommand, "Address", DbType.String, Reg.Address);
            database.AddInParameter(dbCommand, "User_Type", DbType.String, Reg.User_Type);
            database.AddInParameter(dbCommand, "Mobile_No", DbType.String, Reg.Mobile_No);
            database.AddInParameter(dbCommand, "Password", DbType.String, Reg.Password);
            database.AddInParameter(dbCommand, "Entry_Date", DbType.String, Reg.Entry_Date.ToString("yyyy/MM/dd hh:mm:ss tt"));
            database.AddInParameter(dbCommand, "Flag", DbType.Int32, Reg.Flag);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void UpdateCustomerFlag(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Status] FROM [Customer_Care] WHERE [Customer_ID] = '" + Reg.Customer_ID + "'");
            Reg.Flag = Convert.ToInt32(database.ExecuteScalar(dbCommand));
            if (Reg.Flag == 1)
                Reg.Flag = 0;
            else
            {
                if (Reg.Flag == 0)
                    Reg.Flag = 1;
            }
            dbCommand = database.GetSqlStringCommand("UPDATE [Customer_Care]  SET [Status] = " + Reg.Flag + " WHERE [Customer_ID] = '" + Reg.Customer_ID + "'");
            database.ExecuteNonQuery(dbCommand);
        }
        #endregion
        #region AMC Plan Master Methods
        public static DataSet FillGridAMC(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Row_ID, Plan_ID, Plan_Name, Plan_Time, Plan_Amount,isnull((SELECT Plan_Discount FROM M_PlanDiscount WHERE (Plan_ID = M_Plan.Plan_ID) AND (Flag = 1) AND ( Convert(varchar,getdate(),111) BETWEEN CONVERT(VARCHAR, Date_From, 111) AND CONVERT(VARCHAR, Date_To, 111))),0.00) as Plan_Discount, Entry_Date, Flag,(CASE WHEN Flag = 0 then 'Click for Activated' else 'Click for Un-Activated' end) AS TooTipMsg FROM M_Plan WHERE Plan_Name LIKE '%" + Reg.Plan_Name + "%' ORDER BY Plan_Time ");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillGridVwDiscount(Object9420 Reg)
        {
            string Qry = "";
            if (Reg.Trans_Type == "AMC")
                Qry = "(SELECT Plan_Amount FROM M_Plan WHERE Plan_ID=M_PlanDiscount.Plan_ID) ";
            else
                Qry = "(SELECT Plan_Amount FROM M_Promotional WHERE Promo_ID=M_PlanDiscount.Plan_ID) ";
            dbCommand = database.GetSqlStringCommand("SELECT convert(varchar,Row_ID)+'-'+Plan_ID +'-'+Trans_Type as TransID,Row_ID, Plan_ID, Plan_Name," + Qry + " Plan_Amount, Plan_Discount, Date_From, Date_To, Trans_Type, Flag,(CASE WHEN Flag = 0 then 'Click for Activated' else 'Click for Un-Activated' end) AS TooTipMsg,(CASE WHEN Flag = 1 then 'Activated' else 'De-Activated' end) as Status FROM  M_PlanDiscount WHERE Trans_Type = '" + Reg.Trans_Type + "' AND Plan_Name LIKE '%" + Reg.Plan_Name + "%' AND ('' = '" + Reg.Row_ID + "' OR Row_ID = '" + Reg.Row_ID + "') AND CONVERT(VARCHAR,Date_To,111) >= CONVERT(VARCHAR,GETDATE(),111) ORDER BY Entry_Date DESC");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillGridVwOffer(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT ROW_NUMBER() OVER (ORDER BY Row_ID DESC) AS SNO, Row_ID, Promo_ID, Promo_Name, Time_Days, Amount,isnull((SELECT Plan_Discount FROM M_PlanDiscount WHERE (Plan_ID = M_Promotional.Promo_ID) AND (Flag = 1) AND ( Convert(varchar,getdate(),111) BETWEEN CONVERT(VARCHAR, Date_From, 111) AND CONVERT(VARCHAR, Date_To, 111))),0.00) as Plan_Discount, Entry_Date, Flag,(CASE WHEN Flag = 0 then 'Click for Activated' else 'Click for Un-Activated' end) AS TooTipMsg FROM M_Promotional WHERE Promo_Name LIKE '%" + Reg.Promo_Name + "%' ORDER BY Time_Days ");
            return database.ExecuteDataSet(dbCommand);
        }
        #endregion
        public static DataSet FillDataGridAccount(string StrAll)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Row_ID, Bank_ID, Bank_Name, Account_HolderNm, Account_No, Branch, IFSC_Code, City, RTGS_Code, Account_Type, Address, Entry_Date, Flag FROM   M_BankAccount " + StrAll);
            return database.ExecuteDataSet(dbCommand);
        }

        public static bool ChkDocFlag(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT (case when Comp_Type = 'D' then 8 else isnull((SELECT count(Flag) Flag FROM Comp_Doc_Flag WHERE (Comp_ID = Comp_Reg.Comp_ID) AND Flag = 1),0)end) as Doc_Flag FROM Comp_Reg WHERE  Comp_ID = '" + Reg.Comp_ID + "'");
            DataSet ds = database.ExecuteDataSet(dbCommand); int i = 0;
            if (ds.Tables[0].Rows.Count > 0)
                i = Convert.ToInt32(ds.Tables[0].Rows[0]["Doc_Flag"].ToString());
            if (i >= 7)
                return true;
            else
                return false;
        }

        public static string GetBankID()
        {
            dbCommand = database.GetSqlStringCommand("SELECT  PrPrefix + '_' + CONVERT(varchar, PrStart) AS BankID FROM Code_Gen WHERE (Prfor = 'Account')");
            return database.ExecuteScalar(dbCommand).ToString();
        }
        public static void SetBankID()
        {
            dbCommand = database.GetSqlStringCommand("UPDATE Code_Gen SET  PrStart=PrStart+1 WHERE (Prfor = 'Account')");
            database.ExecuteNonQuery(dbCommand);
        }
        public static void bankfileupload(string bankid,int consumerid,string dml,string chkbook)
        {
            dbCommand = database.GetStoredProcCommand("PROC_InsertUpdateBankfile");
            database.AddInParameter(dbCommand, "Bank_ID", DbType.String, bankid);
            database.AddInParameter(dbCommand, "M_Consumerid", DbType.Int32, consumerid);
            database.AddInParameter(dbCommand, "chkPassbook", DbType.String, chkbook);
            database.AddInParameter(dbCommand, "DML", DbType.String, dml);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void BankInfo(Object9420 obj)
        {
            // if (obj.DML == "I")
            // obj.Bank_ID = GetBankID();
            dbCommand = database.GetStoredProcCommand("PROC_InsertUpdateBankAccount");
            database.AddInParameter(dbCommand, "Bank_ID", DbType.String, obj.Bank_ID);
            database.AddInParameter(dbCommand, "Bank_Name", DbType.String, obj.Bank_Name);
            database.AddInParameter(dbCommand, "Account_HolderNm", DbType.String, obj.Account_HolderNm);
            database.AddInParameter(dbCommand, "Account_No", DbType.String, obj.Account_No);
            database.AddInParameter(dbCommand, "Branch", DbType.String, obj.Branch);
            database.AddInParameter(dbCommand, "IFSC_Code", DbType.String, obj.IFSC_Code);
            database.AddInParameter(dbCommand, "City", DbType.String, obj.City);
            database.AddInParameter(dbCommand, "RTGS_Code", DbType.String, obj.RTGS_Code);
            database.AddInParameter(dbCommand, "Account_Type", DbType.String, obj.Account_Type);
            database.AddInParameter(dbCommand, "Address", DbType.String, obj.Address);
            database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, Convert.ToDateTime(Convert.ToDateTime(obj.Entry_Date).ToString("yyyy/MM/dd")));
            database.AddInParameter(dbCommand, "Flag", DbType.Int32, obj.Flag);
            database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
            database.AddInParameter(dbCommand, "M_Consumerid", DbType.Int32, obj.M_ConsumerID);
            database.AddInParameter(dbCommand, "Comp_id", DbType.String, obj.Comp_ID);
            if (string.IsNullOrEmpty(obj.chkpassbook))
                obj.chkpassbook = "";
            if (obj.chkpassbook != "")
                //    obj.chkpassbook = obj.chkpassbook.Replace("\\", "").Replace("\"", "");
                database.AddInParameter(dbCommand, "chkPassbook", DbType.String, obj.chkpassbook);
            database.ExecuteNonQuery(dbCommand);
            //if (obj.DML == "I")
            // SetBankID();
        }
        public static string appBankInfo(Object9420 obj)
        {
            message_status msg = new message_status();
            try
            {
                // if (obj.DML == "I")
                // obj.Bank_ID = GetBankID();
                dbCommand = database.GetStoredProcCommand("PROC_InsertUpdateBankAccount");
                database.AddInParameter(dbCommand, "Bank_ID", DbType.String, obj.Bank_ID);
                database.AddInParameter(dbCommand, "Bank_Name", DbType.String, obj.Bank_Name);
                database.AddInParameter(dbCommand, "Account_HolderNm", DbType.String, obj.Account_HolderNm);
                database.AddInParameter(dbCommand, "Account_No", DbType.String, obj.Account_No);
                database.AddInParameter(dbCommand, "Branch", DbType.String, obj.Branch);
                database.AddInParameter(dbCommand, "IFSC_Code", DbType.String, obj.IFSC_Code);
                database.AddInParameter(dbCommand, "City", DbType.String, obj.City);
                database.AddInParameter(dbCommand, "RTGS_Code", DbType.String, obj.RTGS_Code);
                database.AddInParameter(dbCommand, "Account_Type", DbType.String, obj.Account_Type);
                database.AddInParameter(dbCommand, "Address", DbType.String, obj.Address);
                //database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, Convert.ToDateTime(Convert.ToDateTime(obj.Entry_Date).ToString("yyyy/MM/dd")));
                database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, Convert.ToDateTime(Convert.ToDateTime(DateTime.Today.ToShortDateString()).ToString("yyyy/MM/dd HH:mm:ss.fff")));
                database.AddInParameter(dbCommand, "Flag", DbType.Int32, obj.Flag);
                database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
                database.AddInParameter(dbCommand, "M_Consumerid", DbType.Int32, obj.M_ConsumerID);
                database.AddInParameter(dbCommand, "Comp_id", DbType.String, obj.Comp_ID);
                if (string.IsNullOrEmpty(obj.chkpassbook))
                    obj.chkpassbook = "";
                if (obj.chkpassbook != "")
                //    obj.chkpassbook = obj.chkpassbook.Replace("\\", "").Replace("\"", "");
                database.AddInParameter(dbCommand, "chkPassbook", DbType.String, obj.chkpassbook);
                database.ExecuteNonQuery(dbCommand);
                msg.status = "Success";

                return JsonConvert.SerializeObject(msg);

            }
            catch (Exception ex)
            {
                DataProvider.LogManager.WriteExe("Find Error in Procedure with " + ex.Message.ToString());

                msg.status = "Unsuccess";

                return JsonConvert.SerializeObject(msg);
            }
            //if (obj.DML == "I")
            // SetBankID();
        }
        public static void GetappBankInfo(bank_responses Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_GetBankAccount");
            database.AddInParameter(dbCommand, "Bank_ID", DbType.String, Reg.Bank_ID);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Bank_ID = ds.Tables[0].Rows[0]["Bank_ID"].ToString();
                Reg.Bank_Name = ds.Tables[0].Rows[0]["Bank_Name"].ToString();
                Reg.Account_HolderNm = ds.Tables[0].Rows[0]["Account_HolderNm"].ToString();
                Reg.Account_No = ds.Tables[0].Rows[0]["Account_No"].ToString();
                Reg.Branch = ds.Tables[0].Rows[0]["Branch"].ToString();
                Reg.IFSC_Code = ds.Tables[0].Rows[0]["IFSC_Code"].ToString();
                Reg.City = ds.Tables[0].Rows[0]["City"].ToString();
                Reg.RTGS_Code = ds.Tables[0].Rows[0]["RTGS_Code"].ToString();
                Reg.Address = ds.Tables[0].Rows[0]["Address"].ToString();
                Reg.Account_Type = ds.Tables[0].Rows[0]["Account_Type"].ToString();
                Reg.chkpassbook = ds.Tables[0].Rows[0]["chkpassbook"].ToString();


            }
        }
        public static void GetBankInfo(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_GetBankAccount");
            database.AddInParameter(dbCommand, "Bank_ID", DbType.String, Reg.Bank_ID);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Bank_ID = ds.Tables[0].Rows[0]["Bank_ID"].ToString();
                Reg.Bank_Name = ds.Tables[0].Rows[0]["Bank_Name"].ToString();
                Reg.Account_HolderNm = ds.Tables[0].Rows[0]["Account_HolderNm"].ToString();
                Reg.Account_No = ds.Tables[0].Rows[0]["Account_No"].ToString();
                Reg.Branch = ds.Tables[0].Rows[0]["Branch"].ToString();
                Reg.IFSC_Code = ds.Tables[0].Rows[0]["IFSC_Code"].ToString();
                Reg.City = ds.Tables[0].Rows[0]["City"].ToString();
                Reg.RTGS_Code = ds.Tables[0].Rows[0]["RTGS_Code"].ToString();
                Reg.Address = ds.Tables[0].Rows[0]["Address"].ToString();
                Reg.Account_Type = ds.Tables[0].Rows[0]["Account_Type"].ToString();
                Reg.chkpassbook= ds.Tables[0].Rows[0]["chkpassbook"].ToString().Replace("\"","");


            }
        }

        public static string UpdateActivationFlag(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  Bank_Name,Flag FROM M_BankAccount WHERE Bank_ID = '" + Reg.Bank_ID + "'");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            int PINT = Convert.ToInt32(ds.Tables[0].Rows[0]["Flag"].ToString());
            if (PINT == 0)
                PINT = 1;
            else
                PINT = 0;
            dbCommand = database.GetSqlStringCommand("UPDATE [M_BankAccount] SET [Flag] = " + PINT + "  WHERE Bank_ID = '" + Reg.Bank_ID + "'");
            database.ExecuteNonQuery(dbCommand);
            return PINT + "," + ds.Tables[0].Rows[0]["Bank_Name"].ToString();
        }

        #region Courier
        public static string GetCourierID()
        {
            dbCommand = database.GetSqlStringCommand("SELECT  PrPrefix + '_' + CONVERT(varchar, PrStart) AS CourierID FROM Code_Gen WHERE (Prfor = 'Courier')");
            return database.ExecuteScalar(dbCommand).ToString();
        }
        public static string GetCourierDispatchID()
        {
            dbCommand = database.GetSqlStringCommand("SELECT  PrPrefix + '_' + CONVERT(varchar, PrStart) AS CourierID FROM Code_Gen WHERE (Prfor = 'Dispatch')");
            return database.ExecuteScalar(dbCommand).ToString();
        }
        public static void SetCourierDispatchID()
        {
            dbCommand = database.GetSqlStringCommand("UPDATE Code_Gen  SET PrStart = PrStart + 1 WHERE (Prfor = 'Dispatch')");
            database.ExecuteNonQuery(dbCommand);
        }
        public static void SetCourierID()
        {
            dbCommand = database.GetSqlStringCommand("UPDATE Code_Gen SET  PrStart=PrStart+1 WHERE (Prfor = 'Courier')");
            database.ExecuteNonQuery(dbCommand);
        }
        public static string GetTrackingId(string Prfor)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  PrPrefix + CONVERT(VARCHAR,DATEPART(YEAR,GETDATE())) + CONVERT(varchar, PrStart) AS CourierID FROM Code_Gen WHERE (Prfor = '" + Prfor + "')");
            return database.ExecuteScalar(dbCommand).ToString();
        }

        public static string GetTrackingId_New(string Prfor)
        {
            dbCommand = database.GetStoredProcCommand("[GetCodeGenValue_Tracking]");
            return database.ExecuteScalar(dbCommand).ToString();
        }

        public static void SetTrackingId(string Prfor)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE Code_Gen SET  PrStart=PrStart+1 WHERE (Prfor = '" + Prfor + "')");
            database.ExecuteNonQuery(dbCommand);
        }

        public static void SaveCourierMasterDetail(Object9420 Obj)
        {
            // if (Obj.DML == "I")
            // Obj.Courier_ID = GetCourierID();
            dbCommand = database.GetStoredProcCommand("PROC_InsertUpdateCourier");
            database.AddInParameter(dbCommand, "@CourierPkid", DbType.String, Obj.CourierPkid);
            database.AddInParameter(dbCommand, "Courier_ID", DbType.String, Obj.Courier_ID);
            database.AddInParameter(dbCommand, "Courier_Name", DbType.String, Obj.Courier_Name);
            database.AddInParameter(dbCommand, "Courier_Email", DbType.String, Obj.Courier_Email);
            database.AddInParameter(dbCommand, "Courier_Mobile", DbType.String, Obj.Courier_Mobile);
            database.AddInParameter(dbCommand, "Courier_Address", DbType.String, Obj.Courier_Address);
            database.AddInParameter(dbCommand, "DML", DbType.String, Obj.DML);
            database.AddInParameter(dbCommand, "User_ID", DbType.String, Obj.User_ID);
            database.ExecuteNonQuery(dbCommand);
            // if (Obj.DML == "I")
            // SetCourierID();
        }

        public static void GetCourierInfo(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_GetCourierData");
            database.AddInParameter(dbCommand, "CourierPkid", DbType.String, Reg.@CourierPkid);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Courier_ID = ds.Tables[0].Rows[0]["Courier_ID"].ToString();
                Reg.Courier_Name = ds.Tables[0].Rows[0]["Courier_Name"].ToString();
                Reg.Courier_Email = ds.Tables[0].Rows[0]["Courier_Email"].ToString();
                Reg.Courier_Mobile = ds.Tables[0].Rows[0]["Courier_Mobile"].ToString();
                Reg.Courier_Address = ds.Tables[0].Rows[0]["Courier_Address"].ToString();
            }
        }

        public static DataSet FillCourierDataGrid(string Search, string User_ID)
        {
            // changed by shweta
            //  dbCommand = database.GetSqlStringCommand("SELECT CourierPkid,[Courier_ID],[Courier_Name],[Courier_Email],[Courier_Mobile],[Courier_Address],(SELECT Count(Courier_ID) from Courier_Dispatch_Master WHERE [Courier_ID] = Courier_Master.Courier_ID AND Courier_Status in (0,1)) as [Flag] FROM [Courier_Master] where Courier_Name like '%" + Search + "%' AND [Flag] = 1 AND [User_ID] = '" + User_ID + "' ");
            dbCommand = database.GetSqlStringCommand("SELECT CourierPkid,[Courier_ID],[Courier_Name],[Courier_Email],[Courier_Mobile],[Courier_Address], [Flag],[User_ID] FROM [Courier_Master] where Courier_Name like '%" + Search + "%' AND [Flag] = 1 AND [User_ID] = '" + User_ID + "' ");
            return database.ExecuteDataSet(dbCommand);
        }

        public static void DeleteCourierDetail(Object9420 Reg)
        {
            //            dbCommand = database.GetSqlStringCommand("DELETE FROM [Courier_Master]  WHERE Courier_ID='" + Reg.Courier_ID + "'");
            dbCommand = database.GetSqlStringCommand("DELETE FROM [Courier_Master]  WHERE CourierPkid='" + Reg.CourierPkid + "'");
            database.ExecuteNonQuery(dbCommand);
        }
        #endregion

        public static DataSet FillCompany()
        {
            dbCommand = database.GetSqlStringCommand("SELECT  Comp_ID, Comp_Name FROM  Comp_Reg where Comp_Type = 'L' ");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillCorierCompany()
        {
            dbCommand = database.GetSqlStringCommand("SELECT Courier_ID, Courier_Name FROM Courier_Master WHERE Flag = 1 AND User_ID = 'Admin' ");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillCorierCompanyM(string User_ID)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Courier_ID, Courier_Name FROM Courier_Master WHERE Flag = 1 AND User_ID = '" + User_ID + "' ");
            return database.ExecuteDataSet(dbCommand);
        }

        public static void CourierDispatchMaster(Object9420 Obj)
        {
            //if (Obj.DML == "I")
            //    Obj.Courier_Disp_ID = GetCourierDispatchID();
            dbCommand = database.GetStoredProcCommand("PROC_InsertUpdateCourierDispatch");
            database.AddInParameter(dbCommand, "Courier_Disp_ID", DbType.String, Obj.Courier_Disp_ID);
            database.AddInParameter(dbCommand, "Courier_ID", DbType.String, Obj.Courier_ID);
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Obj.Comp_ID);
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Obj.Pro_ID);
            database.AddInParameter(dbCommand, "Tracking_No", DbType.String, Obj.Tracking_No);
            database.AddInParameter(dbCommand, "Dispatch_Date", DbType.DateTime, Convert.ToDateTime(Obj.Dispatch_Date).ToString("yyyy/MM/dd"));
            database.AddInParameter(dbCommand, "Expected_Date", DbType.DateTime, Convert.ToDateTime(Obj.Expected_Date).ToString("yyyy/MM/dd"));
            database.AddInParameter(dbCommand, "Dispatch_Location", DbType.String, Obj.Dispatch_Location);
            database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, Convert.ToDateTime(Obj.Entry_Date).ToString("yyyy/MM/dd hh:mm:ss tt"));
            database.AddInParameter(dbCommand, "DML", DbType.String, Obj.DML);
            database.ExecuteNonQuery(dbCommand);
            if (Obj.DML == "I")
            {
                // comments by shweta 
                SetCourierDispatchID();
                function9420.SetTrackingId("Tracking No");
            }
        }

        public static DataSet FillGrdMainDispatchData(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_FillGrdMainDispatchData");
            database.AddInParameter(dbCommand, "@Courier_Disp_ID", DbType.String, Reg.Courier_Disp_ID);
            database.AddInParameter(dbCommand, "@Courier_Name", DbType.String, Reg.Courier_Name);
            database.AddInParameter(dbCommand, "@Comp_Name", DbType.String, Reg.Comp_Name);
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillGrdMainLabelDispatchData(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  Courier_Disp_ID, Courier_ID,(SELECT Courier_Name FROM Courier_Master where Courier_ID = Courier_Dispatch_Master.Courier_ID) as Courier_Name,(SELECT Courier_Mobile FROM Courier_Master where Courier_ID = Courier_Dispatch_Master.Courier_ID) as Courier_Mobile, Comp_ID,(select Comp_Name from Comp_Reg where Comp_ID = Courier_Dispatch_Master.Comp_ID) as Comp_Name, Tracking_No, Dispatch_Date, Expected_Date, Dispatch_Location,isnull(Received_Flag,0) AS Flag,(CASE WHEN isnull(Received_Flag,0) = 0 THEN '----' WHEN Received_Flag = 1 THEN 'Received' WHEN Received_Flag = 2 THEN 'Received with scrap' ELSE 'Not Received' END) AS Status, Entry_Date,(SELECT SUM(Qty) AS Qty FROM Courier_Disp_ProInfo WHERE Courier_Disp_ID = Courier_Dispatch_Master.Courier_Disp_ID GROUP BY Courier_Disp_ID) as Qty FROM   Courier_Dispatch_Master 	WHERE (''='" + Reg.Comp_ID + "' or Courier_Dispatch_Master.Comp_ID = '" + Reg.Comp_ID + "') AND (SELECT Courier_Name FROM Courier_Master where Courier_ID = Courier_Dispatch_Master.Courier_ID) LIKE '%" + Reg.Courier_Name + "%' ORDER BY Entry_Date DESC");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillGrdMainLabelDispatchDataDashBoard(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  Courier_Disp_ID, Courier_ID,(SELECT Courier_Name FROM Courier_Master where Courier_ID = Courier_Dispatch_Master.Courier_ID) as Courier_Name, Comp_ID,(select Comp_Name from Comp_Reg where Comp_ID = Courier_Dispatch_Master.Comp_ID) as Comp_Name, Tracking_No, Dispatch_Date, Expected_Date, Dispatch_Location,isnull(Received_Flag,0) AS Flag,(CASE WHEN isnull(Received_Flag,0) = 0 THEN 'Pending' WHEN Received_Flag = 1 THEN 'Received' WHEN Received_Flag = 2 THEN 'Received with scrap' ELSE 'Not Received' END) AS Status, Entry_Date,(SELECT SUM(Qty) AS Qty FROM Courier_Disp_ProInfo WHERE Courier_Disp_ID = Courier_Dispatch_Master.Courier_Disp_ID GROUP BY Courier_Disp_ID) as Qty FROM   Courier_Dispatch_Master 	WHERE (''='" + Reg.Comp_ID + "' or Courier_Dispatch_Master.Comp_ID = '" + Reg.Comp_ID + "') " + Reg.Msg + "  ORDER BY Entry_Date DESC");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillGrdVwPartner(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT PartnerID, Name, Mobile_No, Address, Email, PANNo, PanDoc, IDProof, AddProof, AccountNo, Photo, Flag, Entry_Date FROM  Partner_Reg 	WHERE (Name LIKE '%" + Reg.Name + "%') " + Reg.chkstr + " ORDER BY Entry_Date DESC");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillGrdMainLabelDispatchDataPending(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Courier_Disp_ID, Courier_ID,(SELECT Courier_Name FROM Courier_Master where Courier_ID = Courier_Dispatch_Master.Courier_ID) as Courier_Name, Comp_ID,(select Comp_Name from Comp_Reg where Comp_ID = Courier_Dispatch_Master.Comp_ID) as Comp_Name, Tracking_No, Dispatch_Date, Expected_Date, Dispatch_Location,isnull(Received_Flag,0) AS Flag,(CASE WHEN isnull(Received_Flag,0) = 0 THEN 'Pending' WHEN Received_Flag = 1 THEN 'Received' WHEN Received_Flag = 2 THEN 'Received with scrap' ELSE 'Rejected' END) AS Status, Entry_Date,(SELECT SUM(Qty) AS Qty FROM Courier_Disp_ProInfo WHERE Courier_Disp_ID = Courier_Dispatch_Master.Courier_Disp_ID GROUP BY Courier_Disp_ID) as Qty FROM   Courier_Dispatch_Master 	WHERE (''='" + Reg.Comp_ID + "' or Courier_Dispatch_Master.Comp_ID = '" + Reg.Comp_ID + "') AND (''='" + Reg.Courier_ID + "' or Courier_Dispatch_Master.Courier_ID = '" + Reg.Courier_ID + "') AND CONVERT(VARCHAR,DATEADD(DAY,6,Expected_Date),111) <= CONVERT(VARCHAR,GETDATE(),111) " + Reg.chkstr + " ORDER BY Entry_Date DESC");
            return database.ExecuteDataSet(dbCommand);
        }
        public static void GetCourierDispInfo(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_FillGrdMainDispatchData");
            database.AddInParameter(dbCommand, "@Courier_Disp_ID", DbType.String, Reg.Courier_Disp_ID);
            database.AddInParameter(dbCommand, "@Courier_Name", DbType.String, Reg.Courier_Name);
            database.AddInParameter(dbCommand, "@Comp_Name", DbType.String, Reg.Comp_Name);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Courier_Disp_ID = ds.Tables[0].Rows[0]["Courier_Disp_ID"].ToString();
                Reg.Comp_ID = ds.Tables[0].Rows[0]["Comp_ID"].ToString();
                Reg.Courier_ID = ds.Tables[0].Rows[0]["Courier_ID"].ToString();
                Reg.Tracking_No = ds.Tables[0].Rows[0]["Tracking_No"].ToString();
                Reg.Dispatch_Date = Convert.ToDateTime(ds.Tables[0].Rows[0]["Dispatch_Date"].ToString());
                Reg.Expected_Date = Convert.ToDateTime(ds.Tables[0].Rows[0]["Expected_Date"].ToString());
                Reg.Dispatch_Location = ds.Tables[0].Rows[0]["Dispatch_Location"].ToString();
                Reg.Courier_Name = ds.Tables[0].Rows[0]["Courier_Name"].ToString();
            }
        }
        public static DataSet GetCourierProDispInfo(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Courier_Disp_ID, Pro_ID,(SELECT Pro_Name FROM Pro_Reg WHERE Pro_ID = Courier_Disp_ProInfo.Pro_ID) as Pro_Name, Label_Code, Label_Name, Series_From, Series_To,Qty FROM  Courier_Disp_ProInfo WHERE Courier_Disp_ID = '" + Reg.Courier_Disp_ID + "' ");
            return database.ExecuteDataSet(dbCommand);
        }


        public static void DeleteCourierProDispInfo(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("DELETE FROM Courier_Disp_ProInfo WHERE Courier_Disp_ID = '" + Reg.Courier_Disp_ID + "' ");
            database.ExecuteNonQuery(dbCommand);
        }

        public static void DeleteCourierDispInfo(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("DELETE FROM Courier_Dispatch_Master WHERE Courier_Disp_ID = '" + Reg.Courier_Disp_ID + "' ");
            database.ExecuteNonQuery(dbCommand);
        }

        public static bool ChkSeries(Object9420 Reg, string str, int pcount)
        {
            dbCommand = database.GetSqlStringCommand("SELECT TOP(" + pcount + ")  DispatchFlag,isnull(ScrapeFlag,0) as ScrapeFlag, Pro_ID,(select Pro_Name from Pro_Reg where M_Code.Pro_ID =Pro_Reg.Pro_ID)as Pro_Name, Batch_No, Series_Order, (case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end) as SeriesOrder1," +
           "Series_Serial,(case when (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag)) ='0-0' then '1' when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-1' then '-1' else '0' end)as ff,Pro_ID+'-'+convert(varchar,(case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end))+'-'+convert(varchar,Series_Serial) as SerialCode FROM  M_Code  where (''='" + Reg.Pro_ID + "' OR Pro_ID='" + Reg.Pro_ID + "') and Print_Status=1  AND  (isnull([Use_Count],0)=0) AND (DispatchFlag IS NULL) AND (isnull(ScrapeFlag,0) = 0) " + str);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count == pcount)
                return true;
            else
                return false;
        }
        public static bool ChkSeries(Object9420 Reg, string str, int pcount, int kcount)
        {
            dbCommand = database.GetSqlStringCommand("SELECT TOP(" + pcount + ")  DispatchFlag,isnull(ScrapeFlag,0) as ScrapeFlag, Pro_ID,(select Pro_Name from Pro_Reg where M_Code.Pro_ID =Pro_Reg.Pro_ID)as Pro_Name, Batch_No, Series_Order, (case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end) as SeriesOrder1," +
           "Series_Serial,(case when (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag)) ='0-0' then '1' when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-1' then '-1' else '0' end)as ff,Pro_ID+'-'+convert(varchar,(case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end))+'-'+convert(varchar,Series_Serial) as SerialCode FROM  M_Code  where (''='" + Reg.Pro_ID + "' OR Pro_ID='" + Reg.Pro_ID + "') and Print_Status=1  AND  (isnull([Use_Count],0)=0) AND (DispatchFlag IS NULL) AND (isnull(ScrapeFlag,0) = 0)  " + str);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count + kcount == pcount)
                return true;
            else
                return false;
        }
        public static bool PrintChkSeries(Object9420 Reg, string str, int pcount)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  TOP(" + pcount + ") Pro_ID, Series_Order, Series_Serial FROM  dbo.M_Code where Pro_ID = '" + Reg.Pro_ID + "' and (ScrapeFlag is null or ScrapeFlag = 0) AND ReceiveFlag = 1 AND Batch_No IS NULL " + str);
            // dbCommand = database.GetSqlStringCommand("SELECT TOP(" + pcount + ")  DispatchFlag,isnull(ScrapeFlag,0) as ScrapeFlag, Pro_ID,(select Pro_Name from Pro_Reg where M_Code.Pro_ID =Pro_Reg.Pro_ID)as Pro_Name, Batch_No, Series_Order, (case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end) as SeriesOrder1," +
            //"Series_Serial,(case when (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag)) ='0-0' then '1' when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-1' then '-1' else '0' end)as ff,Pro_ID+'-'+convert(varchar,(case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end))+'-'+convert(varchar,Series_Serial) as SerialCode FROM  M_Code  where (''='" + Reg.Pro_ID + "' OR Pro_ID='" + Reg.Pro_ID + "') and Print_Status=1  AND  (isnull([Use_Count],0)=0) AND (DispatchFlag IS NULL) AND (isnull(ScrapeFlag,0) = 0) " + str);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count == pcount)
                return true;
            else
                return false;
        }
        public static bool PrintChkSeries(Object9420 Reg, string str, int pcount, int kcount)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  TOP(" + pcount + ") Pro_ID, Series_Order, Series_Serial FROM  dbo.M_Code where Pro_ID = '" + Reg.Pro_ID + "' and (ScrapeFlag is null or ScrapeFlag = 0) AND ReceiveFlag = 1 AND Batch_No IS NULL " + str);
            // dbCommand = database.GetSqlStringCommand("SELECT TOP(" + pcount + ")  DispatchFlag,isnull(ScrapeFlag,0) as ScrapeFlag, Pro_ID,(select Pro_Name from Pro_Reg where M_Code.Pro_ID =Pro_Reg.Pro_ID)as Pro_Name, Batch_No, Series_Order, (case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end) as SeriesOrder1," +
            //"Series_Serial,(case when (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag)) ='0-0' then '1' when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-1' then '-1' else '0' end)as ff,Pro_ID+'-'+convert(varchar,(case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end))+'-'+convert(varchar,Series_Serial) as SerialCode FROM  M_Code  where (''='" + Reg.Pro_ID + "' OR Pro_ID='" + Reg.Pro_ID + "') and Print_Status=1  AND  (isnull([Use_Count],0)=0) AND (DispatchFlag IS NULL) AND (isnull(ScrapeFlag,0) = 0)  " + str);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count + kcount == pcount)
                return true;
            else
                return false;
        }
        public static DataSet ChkSeriesForupdate(Object9420 Reg, string str, int pcount)
        {
            dbCommand = database.GetSqlStringCommand("SELECT TOP(" + pcount + ") Code1,Code2,DispatchFlag,isnull(ScrapeFlag,0) as ScrapeFlag, Pro_ID,(select Pro_Name from Pro_Reg where M_Code.Pro_ID =Pro_Reg.Pro_ID)as Pro_Name, Batch_No, Series_Order, (case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end) as SeriesOrder1," +
            "Series_Serial,(case when (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag)) ='0-0' then '1' when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-1' then '-1' else '0' end)as ff,Pro_ID+'-'+convert(varchar,(case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end))+'-'+convert(varchar,Series_Serial) as SerialCode FROM  M_Code  where (''='" + Reg.Pro_ID + "' OR Pro_ID='" + Reg.Pro_ID + "') and Print_Status=1  AND  (isnull([Use_Count],0)=0) AND (DispatchFlag IS NULL) " + str);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count == pcount)
                return ds;
            else
            {
                ds.Tables[0].Rows.Clear();
                return ds;
            }
        }
        public static DataSet ChkSeriesForupdateM_Code(Object9420 Reg, string str, int pcount)
        {
            dbCommand = database.GetSqlStringCommand("SELECT TOP(" + pcount + ") Code1,Code2,DispatchFlag,isnull(ScrapeFlag,0) as ScrapeFlag, Pro_ID,(select Pro_Name from Pro_Reg where M_Code.Pro_ID =Pro_Reg.Pro_ID)as Pro_Name, Batch_No, Series_Order, (case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end) as SeriesOrder1," +
            "Series_Serial,(case when (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag)) ='0-0' then '1' when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-1' then '-1' else '0' end)as ff,Pro_ID+'-'+convert(varchar,(case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end))+'-'+convert(varchar,Series_Serial) as SerialCode FROM  M_Code  where (''='" + Reg.Pro_ID + "' OR Pro_ID='" + Reg.Pro_ID + "') and Print_Status=1  AND  (isnull([Use_Count],0)=0) AND (DispatchFlag = 1) " + str);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count == pcount)
                return ds;
            else
            {
                ds.Tables[0].Rows.Clear();
                return ds;
            }
        }
        public static bool UpdateDispFlag(Object9420 Reg, string str, int pcount)
        {
            dbCommand = database.GetSqlStringCommand("SELECT TOP(" + pcount + ")  DispatchFlag,isnull(ScrapeFlag,0) as ScrapeFlag, Pro_ID,(select Pro_Name from Pro_Reg where M_Code.Pro_ID =Pro_Reg.Pro_ID)as Pro_Name, Batch_No, Series_Order, (case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end) as SeriesOrder1," +
           "Series_Serial,(case when (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag)) ='0-0' then '1' when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-1' then '-1' else '0' end)as ff,Pro_ID+'-'+convert(varchar,(case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end))+'-'+convert(varchar,Series_Serial) as SerialCode FROM  M_Code  where (''='" + Reg.Pro_ID + "' OR Pro_ID='" + Reg.Pro_ID + "') and Print_Status=1  AND  (isnull([Use_Count],0)=0) AND (DispatchFlag IS NULL) " + str);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count == pcount)
                return true;
            else
                return false;
        }

        public static DataSet GetCourierDispLabelInfoID(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT     Row_ID, Courier_Disp_ID, Pro_ID,(SELECT Pro_Name FROM Pro_Reg WHERE Pro_ID = Courier_Disp_ProInfo.Pro_ID) as Pro_Name, Label_Code, Label_Name, Series_From, Series_To, Entry_Date,Qty FROM Courier_Disp_ProInfo where Courier_Disp_ID ='" + Reg.Courier_Disp_ID + "'");
            return database.ExecuteDataSet(dbCommand);
        }

        public static bool UpdateM_Code(string p)
        {
            try
            {
                dbCommand = database.GetSqlStringCommand(p); //dbCommand.CommandTimeout = 5000;
                //dbCommand.CommandTimeout = 0;
                database.ExecuteNonQuery(dbCommand);
                return true;
            }
            catch (Exception ex)
            {
                LogManager.WriteExe(ex.Message);
                return false;
            }
        }

        public static void GetLabelInfo(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Label_Code,Label_Name, Label_Size, Label_Prise FROM M_Label WHERE (Label_Code IN (SELECT Label_Code FROM Pro_Reg WHERE (Pro_ID = '" + Reg.Pro_ID + "')))");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Label_Code = ds.Tables[0].Rows[0]["Label_Code"].ToString();
                Reg.Label_Name = ds.Tables[0].Rows[0]["Label_Name"].ToString();
                Reg.Label_Size = ds.Tables[0].Rows[0]["Label_Size"].ToString();
                Reg.Label_Prise = Convert.ToDouble(ds.Tables[0].Rows[0]["Label_Prise"].ToString());
            }
        }

        public static void LabelReceipt(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Courier_Dispatch_Master] SET [Received_Date] ='" + Convert.ToDateTime(Reg.Entry_Date).ToString("yyyy/MM/dd hh:mm:ss tt") + "',[Received_Flag] = " + Reg.Flag + ",[Man_Reason] = '" + Reg.Manu_Remark + "' WHERE [Courier_Disp_ID] = '" + Reg.Courier_Disp_ID + "'");
            database.ExecuteNonQuery(dbCommand);
        }
        public static bool LabelReceiptCheckedFlag(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  ISNULL(Received_Flag,0) AS Flag FROM [Courier_Dispatch_Master] WHERE [Courier_Disp_ID] = '" + Reg.Courier_Disp_ID + "'");
            DataSet ds = database.ExecuteDataSet(dbCommand); int i = 0;
            if (ds.Tables[0].Rows.Count > 0)
            {
                i = Convert.ToInt32(ds.Tables[0].Rows[0]["Flag"].ToString());
                if (i == 0)
                    return true;
                else
                    return false;
            }
            return false;
        }
        public static DataSet GetReason(object p)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Reason_ID, Reason FROM  M_Reason WHERE (Status = 1) AND ('' = '" + p + "' or Type = '" + p + "')");
            return database.ExecuteDataSet(dbCommand);
        }

        public static void UpdateMCodeScrapAdmin(string p)
        {
            dbCommand = database.GetSqlStringCommand(p); dbCommand.CommandTimeout = 5000;
            database.ExecuteNonQuery(dbCommand);
        }

        public static bool ChkSeriesScrap(Object9420 Reg, string str, int pcount)
        {
            dbCommand = database.GetSqlStringCommand("SELECT TOP(" + pcount + ")  DispatchFlag,isnull(ScrapeFlag,0) as ScrapeFlag, Pro_ID,(select Pro_Name from Pro_Reg where M_Code.Pro_ID =Pro_Reg.Pro_ID)as Pro_Name, Batch_No, Series_Order, (case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end) as SeriesOrder1," +
              "Series_Serial,(case when (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag)) ='0-0' then '1' when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-1' then '-1' else '0' end)as ff,Pro_ID+'-'+convert(varchar,(case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end))+'-'+convert(varchar,Series_Serial) as SerialCode FROM  M_Code  where (''='" + Reg.Pro_ID + "' OR Pro_ID='" + Reg.Pro_ID + "') and Print_Status=1  AND  (isnull([Use_Count],0)=0) AND (DispatchFlag IS NULL) AND (isnull(ScrapeFlag,0) = 0) " + str);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count == pcount)
                return true;
            else
                return false; throw new NotImplementedException();
        }
        public static bool ChkSeriesScrapM(Object9420 Reg, string str, int pcount)
        {
            dbCommand = database.GetSqlStringCommand("SELECT TOP(" + pcount + ")  DispatchFlag,isnull(ScrapeFlag,0) as ScrapeFlag, Pro_ID,(select Pro_Name from Pro_Reg where M_Code.Pro_ID =Pro_Reg.Pro_ID)as Pro_Name, Batch_No, Series_Order, (case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end) as SeriesOrder1," +
              "Series_Serial,(case when (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag)) ='0-0' then '1' when  (CONVERT(VARCHAR,ISNULL(Batch_No,0)) +'-'+CONVERT(VARCHAR,Scrapeflag))='0-1' then '-1' else '0' end)as ff,Pro_ID+'-'+convert(varchar,(case when len(convert(nvarchar,Series_Order)) = 1 then '0'+ convert(nvarchar,Series_Order) else convert(nvarchar,Series_Order) end))+'-'+convert(varchar,Series_Serial) as SerialCode FROM  M_Code  where (''='" + Reg.Pro_ID + "' OR Pro_ID='" + Reg.Pro_ID + "') and Print_Status=1  AND  (isnull([Use_Count],0)=0) AND (DispatchFlag = 1) AND (isnull(ScrapeFlag,0) = 0) " + str);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count == pcount)
                return true;
            else
                return false; throw new NotImplementedException();
        }
        public static string GetScrapID(string pro)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  PrPrefix + '_' + CONVERT(varchar, PrStart) AS BankID FROM Code_Gen WHERE (Prfor = '" + pro + "')");
            return database.ExecuteScalar(dbCommand).ToString();
        }
        public static void SetScrapID(string pro)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE Code_Gen SET  PrStart=PrStart+1 WHERE (Prfor = '" + pro + "')");
            database.ExecuteNonQuery(dbCommand);
        }

        public static DataSet FillScrapGrd(Object9420 Reg)
        {
            string Qty = "";
            if (Reg.User_Type == "Admin")
                Qty = "";
            else if (Reg.User_Type == "Company")
                Qty = "  AND M_Scrap.Resion_ID <> (SELECT Reason_ID  FROM M_Reason WHERE   Status = 1 AND (Type <> '" + Reg.User_Type + "')  AND  (Reason = 'Admin Scrap') )";
            dbCommand = database.GetSqlStringCommand("SELECT M_Scrap.Row_Id, M_Scrap.Scrap_ID, M_Scrap.Pro_ID, M_Scrap.Resion_ID, M_Scrap.Scrap_Details, M_Scrap.Remarks, M_Scrap.Entry_Date, Pro_Reg.Pro_Name, M_Reason.Reason " +
            " ,(CASE WHEN len(Scrap_Details) = 26 THEN (CONVERT(NUMERIC(18,0),(SUBSTRING(RTRIM(LTRIM(SUBSTRING(Scrap_Details,CHARINDEX('To',Scrap_Details)+2,len(Scrap_Details)-CHARINDEX('To',Scrap_Details)))),9,3))) -  " +
            " CONVERT(NUMERIC(18,0),(SUBSTRING(RTRIM(LTRIM(SUBSTRING(Scrap_Details,0,CHARINDEX('To',Scrap_Details)))),9,3))) + 1)  ELSE  1 END) AS Cnt,(SUBSTRING(RTRIM(LTRIM(SUBSTRING(Scrap_Details,0,CHARINDEX('To',Scrap_Details)))),9,3)) AS F " +
            " ,(SUBSTRING(RTRIM(LTRIM(SUBSTRING(Scrap_Details,CHARINDEX('To',Scrap_Details)+2,len(Scrap_Details)-CHARINDEX('To',Scrap_Details)))),9,3)) AS T,RTRIM(LTRIM(SUBSTRING(Scrap_Details,0,CHARINDEX('To',Scrap_Details)))) AS fR " +
            " ,RTRIM(LTRIM(SUBSTRING(Scrap_Details,CHARINDEX('To',Scrap_Details)+2,len(Scrap_Details)-CHARINDEX('To',Scrap_Details)))) AS fTO ,len(Scrap_Details) as Length " +
             "FROM M_Scrap INNER JOIN Pro_Reg ON M_Scrap.Pro_ID = Pro_Reg.Pro_ID INNER JOIN  M_Reason ON M_Scrap.Resion_ID = M_Reason.Reason_ID WHERE Pro_Reg.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg " +
            " WHERE Comp_ID IN(SELECT Comp_ID from Comp_Reg WHERE ('' = '" + Reg.Comp_ID + "' OR  Comp_ID = '" + Reg.Comp_ID + "'))) " + Qty);
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillScrapGrd1(Object9420 Reg)
        {
            string Qty = "";
            if (Reg.User_Type == "Admin")
                Qty = "";
            else if (Reg.User_Type == "Company")
                Qty = "  AND M_Scrap.Resion_ID <> (SELECT Reason_ID  FROM M_Reason WHERE   Status = 1 AND (Type <> '" + Reg.User_Type + "') AND  (Reason = 'Admin Scrap') )";
            dbCommand = database.GetSqlStringCommand("SELECT M_Scrap.Row_Id, M_Scrap.Scrap_ID, M_Scrap.Pro_ID, M_Scrap.Resion_ID, M_Scrap.Scrap_Details, M_Scrap.Remarks, M_Scrap.Entry_Date, Pro_Reg.Pro_Name, M_Reason.Reason " +
            " ,(CASE WHEN len(Scrap_Details) = 26 THEN (CONVERT(NUMERIC(18,0),(SUBSTRING(RTRIM(LTRIM(SUBSTRING(Scrap_Details,CHARINDEX('To',Scrap_Details)+2,len(Scrap_Details)-CHARINDEX('To',Scrap_Details)))),9,3))) -  " +
            " CONVERT(NUMERIC(18,0),(SUBSTRING(RTRIM(LTRIM(SUBSTRING(Scrap_Details,0,CHARINDEX('To',Scrap_Details)))),9,3))) + 1)  ELSE  1 END) AS Cnt,(SUBSTRING(RTRIM(LTRIM(SUBSTRING(Scrap_Details,0,CHARINDEX('To',Scrap_Details)))),9,3)) AS F " +
            " ,(SUBSTRING(RTRIM(LTRIM(SUBSTRING(Scrap_Details,CHARINDEX('To',Scrap_Details)+2,len(Scrap_Details)-CHARINDEX('To',Scrap_Details)))),9,3)) AS T,RTRIM(LTRIM(SUBSTRING(Scrap_Details,0,CHARINDEX('To',Scrap_Details)))) AS fR " +
            " ,RTRIM(LTRIM(SUBSTRING(Scrap_Details,CHARINDEX('To',Scrap_Details)+2,len(Scrap_Details)-CHARINDEX('To',Scrap_Details)))) AS fTO ,len(Scrap_Details) as Length " +
             " FROM M_Scrap INNER JOIN Pro_Reg ON M_Scrap.Pro_ID = Pro_Reg.Pro_ID INNER JOIN  M_Reason ON M_Scrap.Resion_ID = M_Reason.Reason_ID  " +
            " WHERE (''='" + Reg.Pro_ID + "' OR Pro_Reg.Pro_ID = '" + Reg.Pro_ID + "') " + Qty);
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet FillLabel()
        {
            dbCommand = database.GetSqlStringCommand("SELECT Row_Id, Label_Code,Label_Name as Label_Nm, Label_Name + ' ( ' + Label_Size + ' ) ' as Label_Name,Label_Size Label_Prise, Label_Image, Entry_Date, Flag FROM M_Label WHERE (Flag = 1)");
            return database.ExecuteDataSet(dbCommand);
        }

        public static void InsertPrintRequestLabels(Object9420 Reg)
        {
            Reg.Label_Prise = Convert.ToDouble(SQL_DB.ExecuteScalar("SELECT Label_Prise FROM  M_Label where  Label_Code = '" + Reg.Label_Code + "'"));
            dbCommand = database.GetSqlStringCommand("INSERT INTO [M_Label_Request]([Pro_ID],[Qty],[Label_Code],[Entry_Date],[Flag],[Tracking_No],[Request_Price],ProductioUnit,Channels) VALUES   ('" + Reg.Pro_ID + "','" + Reg.NoofCodes + "','" + Reg.Label_Code + "','" + Convert.ToDateTime(Reg.Entry_Date).ToString("yyyy/MM/dd hh:mm:ss tt") + "','" + Reg.Flag + "','" + Reg.Tracking_No + "'," + Reg.Label_Prise + "," + Reg.ProductionUnit + "," + Reg.Channels + ")");
            database.ExecuteNonQuery(dbCommand);
            UpdateLabelCode("LabelTracking");
        }

        internal static void UpdateLabelCode(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Pro_Reg] SET [Label_Code] ='" + Reg.Label_Code + "' WHERE [Pro_ID] = '" + Reg.Pro_ID + "'");
            database.ExecuteNonQuery(dbCommand);
        }

        internal static void GetCompanyForProID(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Comp_ID, Comp_Name, Comp_Email, WebSite, Address, Contact_Person, Mobile_No, Phone_No, Fax FROM Comp_Reg where Comp_ID = (SELECT Comp_ID from Pro_Reg where Pro_ID = '" + Reg.Pro_ID + "') ");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Comp_ID = ds.Tables[0].Rows[0]["Comp_ID"].ToString();
                Reg.Comp_Name = ds.Tables[0].Rows[0]["Comp_Name"].ToString();
                Reg.Comp_Email = ds.Tables[0].Rows[0]["Comp_Email"].ToString();
                Reg.WebSite = ds.Tables[0].Rows[0]["WebSite"].ToString();
                Reg.Address = ds.Tables[0].Rows[0]["Address"].ToString();
                Reg.Contact_Person = ds.Tables[0].Rows[0]["Contact_Person"].ToString();
                Reg.Mobile_No = ds.Tables[0].Rows[0]["Mobile_No"].ToString();
                Reg.Phone_No = ds.Tables[0].Rows[0]["Phone_No"].ToString();
                Reg.Fax = ds.Tables[0].Rows[0]["Fax"].ToString();
            }
        }

        public static DataSet FillGrdLabelsRequested(Object9420 Reg)
        {
            string Qry = "";
            if (Reg.Status == 0)
                Qry = "WHERE M_Label_Request.Flag = 0 ";
            dbCommand = database.GetSqlStringCommand("SELECT    (SELECT Comp_Name FROM Comp_Reg WHERE Comp_ID = Pro_Reg.Comp_ID) as Comp_Name ,Pro_Reg.Pro_Name AS Pro_Name, M_Label.Label_Name+'( ' + M_Label.Label_Size+ ' )' as Label_Name, M_Label_Request.Qty AS Labels, CONVERT(varchar,M_Label_Request.Entry_Date,103) AS Entry_Date,Pro_Reg.Comp_ID, M_Label.Label_Prise AS Label_Prise, M_Label_Request.Pro_ID AS Pro_ID, " +
            " (case when M_Label_Request.Flag = '0' then 'Pending' when M_Label_Request.Flag = '-1' then 'Reject' when M_Label_Request.Flag = '1' then 'Label Print' when M_Label_Request.Flag = '2' then 'Canceled' end) as RequestStatusFlag, " +
            " M_Label_Request.Row_ID AS Row_ID, M_Label_Request.Label_Code AS Label_Code,Tracking_No FROM  M_Label_Request INNER JOIN Pro_Reg ON M_Label_Request.Pro_ID = Pro_Reg.Pro_ID INNER JOIN  M_Label ON M_Label_Request.Label_Code = M_Label.Label_Code  " + Qry + " AND (''='" + Reg.Comp_ID + "' or Pro_Reg.Comp_ID = '" + Reg.Comp_ID + "') ORDER BY Entry_Date DESC"); dbCommand.CommandTimeout = 5000;
            return database.ExecuteDataSet(dbCommand);
        }

        public static void CancelLabelsRequest(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [M_Label_Request] SET [Flag] = -1 WHERE [Row_ID] = " + Reg.Row_ID + " ");
            database.ExecuteNonQuery(dbCommand);
        }

        public static DataSet FillLabelPastingSheet(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT * FROM vw_pastinglabel WHERE vw_pastinglabel.Comp_ID = '" + Reg.Comp_ID + "' " + Reg.Condition + " ");
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet FillLoginSummary(Object9420 obj)
        {
            string Qry = "";
            if (obj.Norec > 0)
                Qry = " TOP(" + obj.Norec + ") ";
            dbCommand = database.GetSqlStringCommand("SELECT " + Qry + " ROW_NUMBER() OVER (ORDER BY Row_ID DESC) AS sno, Row_ID, Dial_Mode, User_ID, Login_Date, Logout_Date, User_Type FROM Login_History WHERE User_ID = '" + obj.Comp_ID + "' ORDER BY Row_ID DESC");
            return database.ExecuteDataSet(dbCommand);
            //dbCommand = database.GetSqlStringCommand("SELECT Login_Date AS Login_Date1,User_ID,User_Type, SUBSTRING(DATENAME(MM, Login_Date),0,4) + ' ' + CAST(DAY(Login_Date) AS VARCHAR(2))+ ' , ' + CAST(YEAR(Login_Date) AS VARCHAR(4)) AS Login_Date,Invoice_No from(SELECT     User_ID, User_Type, CONVERT(VARCHAR, Login_Date, 111) AS Login_Date,ISNULL((SELECT [dbo].[GetAliasesInVoiceByDate] (CONVERT(VARCHAR, Login_Summary.Login_Date, 111),'" + obj.Comp_ID + "')),'-- --') AS Invoice_No " +
            //" FROM         Login_Summary WHERE  User_ID = '" + obj.Comp_ID + "'  GROUP BY CONVERT(VARCHAR, Login_Date, 111), User_ID, User_Type ) AS Reg order by Login_Date1 DESC");
            //return database.ExecuteDataSet(dbCommand);
        }

        public static void InsertAmcOfferPlan(Object9420 obj)
        {
            //obj.statusstr = "1"; // this only testing purpose
            dbCommand = database.GetStoredProcCommand("PROC_InsertAmcOfferPlan");
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, obj.Comp_ID);
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, obj.Pro_ID);
            if (obj.Trans_Type == "AMC")
            {
                database.AddInParameter(dbCommand, "Plan_ID", DbType.String, obj.Plan_ID);
                database.AddInParameter(dbCommand, "Plan_Name", DbType.String, obj.Plan_Name);
                database.AddInParameter(dbCommand, "Plan_Amount", DbType.String, obj.Plan_Amount);
                database.AddInParameter(dbCommand, "Date_From", DbType.String, Convert.ToDateTime(obj.DateFrom).ToString("yyyy/MM/dd"));
                database.AddInParameter(dbCommand, "Date_To", DbType.String, Convert.ToDateTime(obj.DateTo).ToString("yyyy/MM/dd"));
            }
            else
            {
                database.AddInParameter(dbCommand, "Plan_ID", DbType.String, obj.Promo_Id);
                database.AddInParameter(dbCommand, "Plan_Name", DbType.String, obj.Promo_Name);
                database.AddInParameter(dbCommand, "Plan_Amount", DbType.String, obj.Promo_Amount);
                database.AddInParameter(dbCommand, "Date_From", DbType.String, Convert.ToDateTime(obj.PromoDateFrom).ToString("yyyy/MM/dd"));
                database.AddInParameter(dbCommand, "Date_To", DbType.String, Convert.ToDateTime(obj.PromoDateTo).ToString("yyyy/MM/dd"));
            }
            database.AddInParameter(dbCommand, "Trans_Type", DbType.String, obj.Trans_Type);
            if (obj.TransType == "Upgrade")
                database.AddInParameter(dbCommand, "Status", DbType.String, obj.Status);
            else
                database.AddInParameter(dbCommand, "Status", DbType.String, obj.statusstr);
            database.AddInParameter(dbCommand, "Plan_Discount", DbType.String, obj.Plan_Discount);
            database.AddInParameter(dbCommand, "TransType", DbType.String, obj.TransType);
            database.AddInParameter(dbCommand, "Manage_By", DbType.String, obj.Manage_By);
            database.AddInParameter(dbCommand, "Remarks", DbType.String, obj.AmcOfferRemarks);
            database.AddInParameter(dbCommand, "Entry_Date", DbType.String, obj.Pro_Entry_Date);
            database.AddInParameter(dbCommand, "Comments", DbType.String, obj.Comment_Txt);
            database.AddInParameter(dbCommand, "Amc_Offer_ID", DbType.Int32, obj.Row_ID);
            database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
            database.ExecuteNonQuery(dbCommand);
        }
        public static DataSet FillGrdProDoc(Object9420 ob)
        {
            string Qry = "";
            if (ob.Comp_ID == "")
                Qry = "((isnull(Sound_Flag,0) = 0) OR (isnull(Sound_Flag,0) = -1) OR (isnull(Doc_Flag,0) = 0) OR (isnull(Doc_Flag,0) = -1)) AND";
            dbCommand = database.GetSqlStringCommand("SELECT Pro_Reg.Comp_ID, (SELECT Comp_Name FROM Comp_Reg WHERE Comp_ID = Pro_Reg.Comp_ID) as Comp_Name,(SELECT Contact_Person FROM Comp_Reg WHERE Comp_ID = Pro_Reg.Comp_ID) as Contact_Person,(SELECT Comp_Email FROM Comp_Reg WHERE Comp_ID = Pro_Reg.Comp_ID) as Comp_Email, Comp_ID, Pro_ID, CONVERT(varchar,Pro_Entry_Date,103) AS Entry_Date, Pro_Name, (CASE WHEN isnull(Sound_Flag,0) = 1 THEN 'Verified' WHEN isnull(Sound_Flag,0) = 0 THEN 'Pending' ELSE 'Rejected' END) AS WAVFILE_ST ,isnull((SELECT Row_Id FROM Tax_Master_Info WHERE Pro_ID = Pro_Reg.Pro_ID),0) as Tax,isnull(Sound_Flag,0) as Sound_Flag, Pro_Desc, Label_Code, Pro_Doc,'../Data/Sound/' + SUBSTRING(Comp_ID, 6, 4) + '/' + Pro_ID + '/' + Pro_Doc AS DocPath, (CASE WHEN isnull(Doc_Flag,0) = 1 THEN 'Verified' WHEN isnull(Doc_Flag,0) = -1 THEN 'Rejected' ELSE 'Pending' END) AS DOCST, isnull(Doc_Flag,0) as Doc_Flag,'../Data/Sound/' + SUBSTRING(Comp_ID, 6, 4) + '/' + Pro_ID + '/' + Pro_ID + '.mp3' AS SoundPath  FROM Pro_Reg WHERE  " + Qry + " (''='" + ob.Pro_ID + "' OR Pro_ID = '" + ob.Pro_ID + "')  AND (''='" + ob.Comp_ID + "' OR Comp_ID = '" + ob.Comp_ID + "') ORDER BY Entry_Date DESC");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillGrdProDocMan(Object9420 ob)
        {
            dbCommand = database.GetSqlStringCommand("SELECT (SELECT Comp_Name FROM Comp_Reg WHERE Comp_ID = Pro_Reg.Comp_ID) as Comp_Name, Comp_ID, Pro_ID, Pro_Entry_Date AS Entry_Date, Pro_Name, (CASE WHEN isnull(Sound_Flag,0) = 1 THEN 'Verified' WHEN isnull(Sound_Flag,0) = -1 THEN 'Canceled, Please upload again' ELSE 'Un-Verified' END) AS WAVFILE_ST ,isnull(Sound_Flag,0) as Sound_Flag, Pro_Desc, Label_Code, Pro_Doc,'../Data/Sound/' + SUBSTRING(Comp_ID, 6, 4) + '/' + Pro_ID + '/' + Pro_Doc AS DocPath, (CASE WHEN isnull(Doc_Flag,0) = 1 THEN 'Verified' WHEN isnull(Doc_Flag,0) = -1 THEN 'Canceled, Please upload again' ELSE 'Un-Verified' END) AS DOCST, isnull(Doc_Flag,0) as Doc_Flag,'../Data/Sound/' + SUBSTRING(Comp_ID, 6, 4) + '/' + Pro_ID + '/' + Pro_ID + '.mp3' AS SoundPath  FROM Pro_Reg WHERE  (''='" + ob.Pro_ID + "' OR Pro_ID = '" + ob.Pro_ID + "')  AND (''='" + ob.Comp_ID + "' OR Comp_ID = '" + ob.Comp_ID + "') ORDER BY Entry_Date DESC");
            return database.ExecuteDataSet(dbCommand);
        }
        public static bool chkVerifyDoc(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT (SELECT Comp_Name FROM Comp_Reg WHERE Comp_ID = Pro_Reg.Comp_ID) as Comp_Name, Comp_ID, Pro_ID, Pro_Entry_Date AS Entry_Date, Pro_Name, (CASE WHEN isnull(Sound_Flag,0) = 1 THEN 'Verified' ELSE 'Un-Verified' END) AS WAVFILE_ST ,isnull(Sound_Flag,0) as Sound_Flag, Pro_Desc, Label_Code, Pro_Doc,'../Data/Sound/' + SUBSTRING(Comp_ID, 6, 4) + '/' + Pro_ID + '/' + Pro_Doc AS DocPath, (CASE WHEN isnull(Doc_Flag,0) = 1 THEN 'Verified' ELSE 'Un-Verified' END) AS DOCST, isnull(Doc_Flag,0) as Doc_Flag,'../Data/Sound/' + SUBSTRING(Comp_ID, 6, 4) + '/' + Pro_ID + '/' + Pro_ID + '.mp3' AS SoundPath  FROM Pro_Reg WHERE  (''='" + Reg.Pro_ID + "' OR Pro_ID = '" + Reg.Pro_ID + "') AND (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "') ");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if ((Convert.ToInt32(ds.Tables[0].Rows[0]["Sound_Flag"].ToString()) == 1) && (Convert.ToInt32(ds.Tables[0].Rows[0]["Doc_Flag"].ToString()) == 1))
                    return true;
                else
                    return false;
            }
            return false;
        }

        public static bool GetAmcPlan(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  m.Amc_Offer_ID, m.Pro_ID, m.Plan_ID, m.Date_From, m.Date_To, m.Entry_Date FROM  M_Amc_Offer as m WHERE (m.Trans_Type = '" + obj.Trans_Type + "') AND (m.Pro_ID = '" + obj.Pro_ID + "') AND (m.Amc_Offer_ID = (SELECT MAX(mp.Amc_Offer_ID) FROM  M_Amc_Offer as mp WHERE (mp.Trans_Type = m.Trans_Type) AND mp.Pro_ID = m.Pro_ID))");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                obj.Row_ID = ds.Tables[0].Rows[0]["Amc_Offer_ID"].ToString();
                obj.Plan_ID = ds.Tables[0].Rows[0]["Plan_ID"].ToString();
                obj.DateFrom = Convert.ToDateTime(Convert.ToDateTime(ds.Tables[0].Rows[0]["Date_From"]).ToString("dd/MM/yyyy"));
                obj.DateTo = Convert.ToDateTime(Convert.ToDateTime(ds.Tables[0].Rows[0]["Date_To"]).ToString("dd/MM/yyyy"));
                return true;
            }
            else
                return false;

        }
        public static bool chkSendRequest(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  Row_ID, Pro_ID, Qty, Label_Code, Entry_Date, Flag  FROM   M_Label_Request WHERE Pro_ID = '" + obj.Pro_ID + "' AND Flag IN (0,1)");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }

        public static bool chkPrintCode(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  Row_ID, Pro_ID, Qty, Label_Code, Entry_Date, Flag  FROM  M_Label_Request WHERE Pro_ID = '" + obj.Pro_ID + "' AND Flag IN (1)");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }

        public static bool chkDetails(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Row_ID, Pro_ID, MRP, Mfd_Date, Exp_Date, Batch_No, Entry_Date, Update_Flag_H, Update_Flag_E, Series_Limit, Comments FROM T_Pro WHERE  Pro_ID = '" + obj.Pro_ID + "' ");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }

        public static void FillSecreteCode(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Email_ID],[Comp_Name],[Contact_No],[Contact_Name],[Packet_Name] FROM [Allcation_Demo] WHERE Email_ID = '" + Reg.Comp_Email + "'  order by [Entry_Date] desc");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.PacketCode = ds.Tables[0].Rows[0]["Packet_Name"].ToString();
                DataSet ds1 = new DataSet();
            g:
                try
                {
                    dbCommand = database.GetSqlStringCommand("SELECT [dbo].[GetAllottedRows] ('" + Reg.PacketCode + "') ");
                    ds1 = database.ExecuteDataSet(dbCommand);
                }
                catch
                {
                    goto g;
                }
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    Reg.NoofCodes = Convert.ToInt32(ds1.Tables[0].Rows[0]["Column1"].ToString());
                }
            }
        }

        public static void FillProductDetailDemo(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Row_ID, Comp_ID, Pro_ID, Pro_Entry_Date, Pro_Name, Update_Flag, Pro_Desc, Label_Code, Pro_Doc, Doc_Flag, Sound_Flag FROM  Pro_Reg WHERE Comp_ID  ='" + Reg.Comp_ID + "' ");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Pro_Name = ds.Tables[0].Rows[0]["Pro_Name"].ToString();
                Reg.Pro_ID = ds.Tables[0].Rows[0]["Pro_ID"].ToString();
                dbCommand = database.GetSqlStringCommand("SELECT  Row_ID, Pro_ID, MRP, Mfd_Date, Exp_Date, Batch_No, Entry_Date, Series_Limit, Comments FROM T_Pro WHERE Pro_ID = '" + Reg.Pro_ID + "' ");//, Update_Flag_H, Update_Flag_E
                DataSet ds1 = database.ExecuteDataSet(dbCommand);
                if (ds1.Tables[0].Rows.Count > 0)
                {
                    Reg.Row_ID = ds1.Tables[0].Rows[0]["Row_ID"].ToString();
                    Reg.MRP = Convert.ToDouble(ds1.Tables[0].Rows[0]["MRP"].ToString());
                    Reg.Batch_No = ds1.Tables[0].Rows[0]["Batch_No"].ToString();
                    if (ds1.Tables[0].Rows[0]["Mfd_Date"].ToString() != "")
                        Reg.Mfd_Date = Convert.ToDateTime(ds1.Tables[0].Rows[0]["Mfd_Date"].ToString());
                    Reg.Exp_Date = ds1.Tables[0].Rows[0]["Exp_Date"].ToString();
                    Reg.Comments = ds1.Tables[0].Rows[0]["Comments"].ToString();
                }
            }
        }

        internal static DataSet ChkUploadDocFlag(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  Row_ID, Comp_ID, Doc_Id, Flag FROM  Comp_Doc_Flag WHERE Comp_ID  ='" + Reg.Comp_ID + "' ");
            return database.ExecuteDataSet(dbCommand);
        }

        public static void FindFile(Object9420 Log)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  Row_ID, Comp_ID, Comp_Info, PAN_TAN, VAT, Comp_Addressproof, Owner_proof, Signature FROM Comp_Document WHERE Comp_ID = '" + Log.Comp_ID + "'");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Log.Comp_Info = ds.Tables[0].Rows[0]["Comp_Info"].ToString();
                Log.PAN_TAN = ds.Tables[0].Rows[0]["PAN_TAN"].ToString();
                Log.VAT = ds.Tables[0].Rows[0]["VAT"].ToString();
                Log.Comp_Addressproof = ds.Tables[0].Rows[0]["Comp_Addressproof"].ToString();
                Log.Owner_proof = ds.Tables[0].Rows[0]["Owner_proof"].ToString();
                Log.Signature = ds.Tables[0].Rows[0]["Signature"].ToString();
            }
        }

        public static bool FindVerifyFile(Object9420 Log)
        {
            dbCommand = database.GetSqlStringCommand("SELECT count(Row_ID) as Cnt  FROM Comp_Doc_Flag WHERE Comp_ID = '" + Log.Comp_ID + "' AND Flag = 1");
            int i = Convert.ToInt32(database.ExecuteScalar(dbCommand));
            if (i == 7) // shweta It should be 6 to compare
                return true;
            else
                return false;
        }
        public static void UpdateSoundFlagProduct(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Pro_Reg] SET [Sound_Flag] = 0 WHERE [Pro_ID]='" + obj.Pro_ID + "'");
            database.ExecuteNonQuery(dbCommand);
        }
        public static void UpdateDocFlagProduct(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Pro_Reg] SET [Doc_Flag] = 0 WHERE [Pro_ID]='" + obj.Pro_ID + "'");
            database.ExecuteNonQuery(dbCommand);
        }
        public static DataSet FillActiveCompForTax()
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Comp_ID],[Comp_Name] FROM (SELECT [Comp_ID],[Comp_Name],(select Count(Pro_ID) FROM Pro_Reg WHERE Comp_ID = Comp_Reg.Comp_ID) AS p FROM [Comp_Reg] where Comp_Type = 'L' AND Status = 1 ) r where r.p > 0 order by r.Comp_Name ");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillActiveComp()
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Comp_ID],[Comp_Name] FROM[Comp_Reg] where Comp_Type = 'L' AND Status = 1 order by [Comp_Name]");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillAllComp()
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Comp_ID],[Comp_Name] FROM[Comp_Reg] where Status = 1 order by [Comp_Name]");
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet FillScrapEntryCourier(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("SELECT * FROM [dbo].[getScrapLabel] ('" + obj.Courier_Disp_ID + "')");
            return database.ExecuteDataSet(dbCommand);
        }

        public static void FindAMCInfo(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  Row_ID, Plan_ID, Plan_Name, Plan_Time, Plan_Amount,isnull((SELECT Plan_Discount FROM M_PlanDiscount WHERE (Plan_ID = M_Plan.Plan_ID) AND (Flag = 1) AND ( Convert(varchar,getdate(),111) BETWEEN CONVERT(VARCHAR, Date_From, 111) AND CONVERT(VARCHAR, Date_To, 111))),0.00) as Plan_Discount,(SELECT Service_Tax  FROM  Tax_Master WHERE (Row_Id = (SELECT MAX(Row_Id) AS Expr1 FROM Tax_Master AS Tax_Master_1))) as Tax, Entry_Date, Flag FROM M_Plan WHERE Plan_ID = '" + Reg.Plan_ID + "' ");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Plan_ID = ds.Tables[0].Rows[0]["Plan_ID"].ToString();
                Reg.Plan_Name = ds.Tables[0].Rows[0]["Plan_Name"].ToString();
                Convert.ToDouble(ds.Tables[0].Rows[0]["Plan_Amount"].ToString());
                if (Reg.Plan_Amount == 0.0)
                    Reg.Plan_Amount = Convert.ToDouble(ds.Tables[0].Rows[0]["Plan_Amount"].ToString());
                Reg.Plan_Discount = Convert.ToDouble(ds.Tables[0].Rows[0]["Plan_Discount"].ToString());
                //Reg.Plan_Discount = Reg.Plan_Discount + Convert.ToDouble(FindDiscount(Reg));
                Reg.Plan_Discount = Math.Round(((Reg.Plan_Amount * Reg.Plan_Discount) / 100), 2);
                Reg.Plan_Discount += Reg.Plan_DiscountC; // Plan_DiscountC as Custom plan Discount
                Reg.Plan_AmountA = Reg.Plan_Amount - Reg.Plan_Discount;
                Reg.Tax = Convert.ToDouble(ds.Tables[0].Rows[0]["Tax"].ToString());
                Reg.Service_Tax = Math.Round(((Reg.Plan_AmountA * Reg.Tax) / 100), 2);
                Reg.PayAmt = Reg.Plan_AmountA + Reg.Service_Tax;
                Reg.Balance = Convert.ToDouble(Reg.PayAmt);
                Reg.Admin_Balance = Convert.ToDouble(Reg.PayAmt);
                Reg.Manu_Balance = Convert.ToDouble(Reg.PayAmt);
            }
        }
        public static void FindPromoInfo(Object9420 Promoobj)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Row_Id, Promo_ID, Promo_Name, Time_Days, Amount,isnull((SELECT Plan_Discount FROM M_PlanDiscount WHERE (Plan_ID = M_Promotional.Promo_ID) AND (Flag = 1) AND ( Convert(varchar,getdate(),111) BETWEEN CONVERT(VARCHAR, Date_From, 111) AND CONVERT(VARCHAR, Date_To, 111))),0) as Plan_Discount,(SELECT Service_Tax  FROM  Tax_Master WHERE (Row_Id = (SELECT MAX(Row_Id) AS Expr1 FROM Tax_Master AS Tax_Master_1))) as Tax, Flag FROM M_Promotional WHERE  Flag = 1 AND Promo_ID = '" + Promoobj.Promo_Id + "' ");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Promoobj.Promo_Name = ds.Tables[0].Rows[0]["Promo_Name"].ToString();
                Promoobj.Time_Days = Convert.ToInt32(ds.Tables[0].Rows[0]["Time_Days"].ToString());
                Promoobj.Promo_Amount = Convert.ToDouble(ds.Tables[0].Rows[0]["Amount"].ToString());
                Promoobj.Plan_Discount = Convert.ToDouble(ds.Tables[0].Rows[0]["Plan_Discount"].ToString());
                //Promoobj.Plan_Discount = Promoobj.Plan_Discount + Convert.ToDouble(FindDiscount(Promoobj));
                Promoobj.Plan_Discount = Math.Round(((Promoobj.Promo_Amount * Promoobj.Plan_Discount) / 100), 2);
                Promoobj.Promo_AmountA = Promoobj.Promo_Amount - Promoobj.Plan_Discount;
                Promoobj.Tax = Convert.ToDouble(ds.Tables[0].Rows[0]["Tax"].ToString());
                Promoobj.Service_Tax = Math.Round(((Promoobj.Promo_AmountA * Promoobj.Tax) / 100), 2);
                Promoobj.PayAmt = Promoobj.Promo_AmountA + Promoobj.Service_Tax;
                Promoobj.Balance = Convert.ToDouble(Promoobj.PayAmt);
                Promoobj.Admin_Balance = Convert.ToDouble(Promoobj.PayAmt);
                Promoobj.Manu_Balance = Convert.ToDouble(Promoobj.PayAmt);
            }
        }
        public static double FindDiscount(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Plan_Discount FROM M_PlanDiscount WHERE (Plan_ID = '" + Reg.Plan_ID + "') AND (Flag = 1) AND ( '" + Convert.ToDateTime(Reg.DateFromChk).ToString("yyyy/MM/dd") + "' BETWEEN CONVERT(VARCHAR, Date_From, 111) AND CONVERT(VARCHAR, Date_To, 111))");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
                return Convert.ToDouble(ds.Tables[0].Rows[0]["Plan_Discount"].ToString());
            else
                return 0.00;
        }
        //public static double FindAmcAmount(string Comp_ID)
        //{
        //    dbCommand = database.GetSqlStringCommand("	SELECT  sum(Plan_Amount) - (SELECT     SUM(Rec_Amount) Rec_Amount FROM Payment_Received WHERE (Comp_ID= Reg.Comp_ID) AND (Payment_Type='Label') group by Comp_ID) as Rec_Amount    from(SELECT  Pro_Reg.Comp_ID, Pro_Reg.Pro_ID,M_Plan.Plan_Name,M_Plan.Plan_Amount AS Plan_AmountA, CONVERT(NUMERIC(18,2),(M_Plan.Plan_Amount *  (1 +  (SELECT   Service_Tax " +
        //    "  FROM          dbo.Tax_Master WHERE     (Row_Id = (SELECT     MAX(Row_Id) AS Expr1  FROM          Tax_Master AS Tax_Master_1))) / 100))) AS Plan_Amount FROM         Pro_Reg INNER JOIN   M_TransactionPlan ON Pro_Reg.Pro_ID = M_TransactionPlan.Pro_ID INNER JOIN  M_Plan ON M_TransactionPlan.Plan_ID = M_Plan.Plan_ID) Reg WHERE Comp_ID = '"+ Comp_ID +"' group by Comp_ID " +
        //    " SELECT     SUM(Rec_Amount) Rec_Amount FROM  Payment_Received group by Comp_ID");
        //    DataSet ds = database.ExecuteDataSet(dbCommand);
        //    if (ds.Tables[0].Rows.Count > 0)
        //        return Convert.ToDouble(ds.Tables[0].Rows[0]["Rec_Amount"]);
        //    else
        //        return Convert.ToDouble("0.00");
        //}
        public static DataSet FilldllProAmcOffer(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT * FROM (SELECT Comp_ID,Pro_ID,(SELECT Pro_Name FROM Pro_Reg WHERE Pro_ID = M_Amc_Offer.Pro_ID) AS Pro_Name FROM M_Amc_Offer WHERE Comp_ID = '" + Reg.Comp_ID + "' AND Trans_Type = '" + Reg.Amt_Type + "' AND (''='" + Reg.Pro_ID + "' OR Pro_ID = '" + Reg.Pro_ID + "') AND  " + Reg.chkstr + " > 0.00 ) r group by r.Pro_ID,r.Comp_ID,r.Pro_Name ");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillProductAmcOffer(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT convert(varchar,Row_ID) + '-' + Plan_ID + '-' + Trans_Type as Trans_ID, Row_ID,(SELECT Comp_Name FROM Comp_Reg WHERE Comp_ID = M_Amc_Offer.Comp_ID) AS Comp_Name, Comp_ID,Pro_ID ,(SELECT Pro_Name FROM Pro_Reg WHERE Pro_ID = M_Amc_Offer.Pro_ID) AS Pro_Name, Plan_Name, Plan_Amount as Plan_AmountA,Plan_Discount " +
            " ,convert(numeric(18,2),((Plan_Amount-Plan_Discount) * (( 1 + (SELECT Service_Tax FROM Tax_Master WHERE  (Row_Id = (SELECT MAX(Row_Id) AS Expr1 FROM Tax_Master AS Tax_Master_1)))/100))+Plan_Discount) ,2) as Plan_Amount " +
            " , Plan_ID, convert(varchar,Date_From,107) as Date_From, convert(varchar,Date_To,107) as Date_To, Trans_Type,case when isnull(Status,0) = 0 then 'Pending' when isnull(Status,0) = 1 then 'Live' when isnull(Status,0) = 2 then 'Pre Payment' else 'Expire' end as Status,Admin_Balance,Manu_Balance,Admin_Balance-Manu_Balance as Pending_Balance, Entry_Date " +
            " FROM         M_Amc_Offer WHERE Comp_ID = '" + Reg.Comp_ID + "' AND Trans_Type = '" + Reg.Amt_Type + "' AND (''='" + Reg.Pro_ID + "' OR Pro_ID = '" + Reg.Pro_ID + "') AND  " + Reg.chkstr + " > 0.00");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillProductAmcAmount(Object9420 Reg)
        {
            string Qry = "";
            if (Reg.Amt_Type == "AMC")
                Qry = " AND Amc_Offer_ID = (SELECT MAX(Amc_Offer_ID) FROM M_Amc_Offer WHERE Comp_ID = '" + Reg.Comp_ID + "' AND Trans_Type = '" + Reg.Amt_Type + "' AND Pro_ID = '" + Reg.Pro_ID + "') ";
            dbCommand = database.GetSqlStringCommand("SELECT isnull(IsCancel,0) as IsCancel,convert(varchar,Amc_Offer_ID) + '-' + Plan_ID + '-' + Trans_Type as Trans_ID, Amc_Offer_ID,(SELECT Comp_Name FROM Comp_Reg WHERE Comp_ID = M_Amc_Offer.Comp_ID) AS Comp_Name, Comp_ID,Pro_ID ,(SELECT Pro_Name FROM Pro_Reg WHERE Pro_ID = M_Amc_Offer.Pro_ID) AS Pro_Name, Plan_Name, Plan_Amount as Plan_AmountA,Plan_Discount  ,convert(numeric(18,2),((Plan_Amount-Plan_Discount) * (( 1 + (SELECT  CONVERT(NUMERIC(18,2)," + Reg.Amt_Type + "_ServiceTax)+ CONVERT(NUMERIC(18,2)," + Reg.Amt_Type + "_Vat) FROM Tax_Master_Info WHERE Row_Id = (SELECT MAX(Row_Id) FROM Tax_Master_Info WHERE Pro_ID = M_Amc_Offer.Pro_ID))/100))+Plan_Discount) ,2) as Plan_Amount  , Plan_ID, convert(varchar,Date_From,107) as Date_From, convert(varchar,Date_To,107) as Date_To, Trans_Type,case when isnull(Status,0) = 0 then 'Pending' when isnull(Status,0) = 1 then 'Live' when isnull(Status,0) = 2 then 'Pre Payment' else 'Expire' end as Status, Entry_Date ,isnull(Status,0) as Flag   " +
            //"SELECT convert(varchar,Row_ID) + '-' + Plan_ID + '-' + Trans_Type as Trans_ID, Row_ID,(SELECT Comp_Name FROM Comp_Reg WHERE Comp_ID = M_Amc_Offer.Comp_ID) AS Comp_Name, Comp_ID,Pro_ID ,(SELECT Pro_Name FROM Pro_Reg WHERE Pro_ID = M_Amc_Offer.Pro_ID) AS Pro_Name, Plan_Name, Plan_Amount as Plan_AmountA,Plan_Discount " +
            //" ,convert(numeric(18,2),((Plan_Amount-Plan_Discount) * (( 1 + (SELECT Service_Tax FROM Tax_Master WHERE  (Row_Id = (SELECT MAX(Row_Id) AS Expr1 FROM Tax_Master AS Tax_Master_1)))/100))+Plan_Discount) ,2) as Plan_Amount " +
            //" , Plan_ID, convert(varchar,Date_From,107) as Date_From, convert(varchar,Date_To,107) as Date_To, Trans_Type,case when isnull(Status,0) = 0 then 'Pending' when isnull(Status,0) = 1 then 'Live' when isnull(Status,0) = 2 then 'Pre Payment' else 'Expire' end as Status,Admin_Balance,Manu_Balance,Admin_Balance-Manu_Balance as Pending_Balance, Entry_Date " +
            " FROM M_Amc_Offer WHERE Comp_ID = '" + Reg.Comp_ID + "' AND Trans_Type = '" + Reg.Amt_Type + "' AND Pro_ID = '" + Reg.Pro_ID + "' " + Qry + " ORDER BY Entry_Date DESC ");//AND  " + Reg.chkstr + " > 0.00");
            return database.ExecuteDataSet(dbCommand);
        }
        public static void InsertTransaction(Object9420 obj)
        {
            if (obj.Row_ID == null)
                obj.Row_ID = "0";
            dbCommand = database.GetStoredProcCommand("PROC_InsertTransction");
            database.AddInParameter(dbCommand, "Row_ID", DbType.Int32, obj.Row_ID);
            database.AddInParameter(dbCommand, "Amc_Offer_ID", DbType.Int32, obj.Amc_Offer_ID);
            database.AddInParameter(dbCommand, "Request_No", DbType.String, obj.Request_No);
            database.AddInParameter(dbCommand, "Rec_Amount", DbType.String, obj.TRec_Payment);
            database.AddInParameter(dbCommand, "Req_Amount", DbType.String, obj.TReq_Payment);
            database.AddInParameter(dbCommand, "Balance", DbType.String, obj.Balance);
            database.AddInParameter(dbCommand, "Admin_Remark", DbType.String, obj.Admin_Remark);
            database.AddInParameter(dbCommand, "Manu_Remark", DbType.String, obj.Manu_Remark);
            database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
            database.ExecuteNonQuery(dbCommand);
            if (obj.DML == "I")
            {
                if (obj.User_Type == "Admin")
                    UpdateAdminBalance(obj);
                else
                    UpdateManuBalance(obj);
            }
        }
        public static void UpdateAdminBalance(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [M_Amc_Offer] SET [Admin_Balance] = " + obj.Admin_Balance + ",[Manu_Balance] = " + obj.Manu_Balance + " WHERE [Row_ID] = " + obj.Amc_Offer_ID + "");
            database.ExecuteNonQuery(dbCommand);
        }
        public static void UpdateManuBalance(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [M_Amc_Offer] SET [Manu_Balance] = " + obj.Manu_Balance + " WHERE [Row_ID] = " + obj.Amc_Offer_ID + "");
            database.ExecuteNonQuery(dbCommand);
        }
        public static void SaveRequestTransaction(Object9420 Reg)
        {
            //dbCommand = database.GetSqlStringCommand("INSERT INTO [Payment_Transaction]([Request_No],[Pro_Id],[Plan_Name],[Plan_Amount],[Discount],[Pay_Amount],[Amt_Remarks],[Entry_Date],[AMCPlanID]) VALUES " +
            //" ('" + Reg.Request_No + "','" + Reg.Pro_ID + "','" + Reg.Plan_Name + "'," + Reg.AmcPlan_Amount + "," + Reg.Discount + "," + Reg.PayAmt + ",'" + Reg.Amt_Remark.Trim().Replace("'", "''") + "','" + Reg.Entry_Date.ToString("yyyy/MM/dd hh:mm:ss tt") + "','" + Reg.UniqueID + "')");
            //database.ExecuteNonQuery(dbCommand);
        }
        public static void SaveTransaction(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("INSERT INTO [Payment_Transaction]([Trans_No],[Pro_Id],[Plan_Name],[Plan_Amount],[Discount],[Pay_Amount],[Amt_Remarks],[Entry_Date],[AMCPlanID]) VALUES " +
            " ('" + Reg.Invoice_No + "','" + Reg.Pro_ID + "','" + Reg.Plan_Name + "'," + Reg.AmcPlan_Amount + "," + Reg.Discount + "," + Reg.PayAmt + ",'" + Reg.Amt_Remark.Trim().Replace("'", "''") + "','" + Reg.Entry_Date.ToString("yyyy/MM/dd hh:mm:ss tt") + "','" + Reg.UniqueID + "')");
            database.ExecuteNonQuery(dbCommand);
        }
        public static void VerifyRequestTransaction(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Payment_Transaction] SET [Trans_No] = '" + Reg.Invoice_No + "' WHERE  [Request_ID] = '" + Reg.Invoice_No + "'");
            database.ExecuteNonQuery(dbCommand);
        }

        public static void FillData(Object9420 Amc)
        {
            string Qry = "";
            if (Amc.Trans_Type == "Offer")
                Qry = " (SELECT Time_Days FROM M_Promotional WHERE Promo_ID = m.Plan_ID AND Flag = 1) as Plan_Time";
            else
                Qry = " (SELECT Plan_Time FROM M_Plan WHERE Plan_ID = m.Plan_ID AND Flag = 1) as Plan_Time";
            dbCommand = database.GetSqlStringCommand("SELECT 0 as Disp,m.Amc_Offer_ID,(select Pro_Name from Pro_Reg where Pro_ID = m.Pro_ID) as Pro_Name,(select Comp_ID from Pro_Reg where Pro_ID = m.Pro_ID) as Comp_ID, m.Pro_ID, m.Plan_ID, " + Qry + " , m.Date_From, m.Date_To, m.Entry_Date,isnull(m.Status,0) as Status,Comments  FROM M_Amc_Offer as m WHERE m.Amc_Offer_ID = '" + Amc.Row_ID + "' AND Pro_ID = '" + Amc.Pro_ID + "' ");//(SELECT MAX(a.Row_ID) FROM  M_Amc_Offer a WHERE  a.Pro_ID =m.Pro_ID) AND m.Row_ID =
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Amc.TransRow_ID = ds.Tables[0].Rows[0]["Amc_Offer_ID"].ToString();
                Amc.Plan_ID = ds.Tables[0].Rows[0]["Plan_ID"].ToString();
                Amc.Plan_Time = Convert.ToInt32(ds.Tables[0].Rows[0]["Plan_Time"].ToString());
                Amc.DateFromChk = Convert.ToDateTime(ds.Tables[0].Rows[0]["Date_From"].ToString());
                Amc.DateToChk = Convert.ToDateTime(ds.Tables[0].Rows[0]["Date_To"].ToString());
                Amc.Pro_Name = ds.Tables[0].Rows[0]["Pro_Name"].ToString();
                Amc.Comp_ID = ds.Tables[0].Rows[0]["Comp_ID"].ToString();
                Amc.Admin_Balance = 0.00; //Convert.ToDouble(ds.Tables[0].Rows[0]["Admin_Balance"].ToString());
                Amc.Manu_Balance = 0.00;//Convert.ToDouble(ds.Tables[0].Rows[0]["Manu_Balance"].ToString());
                Amc.Status = Convert.ToInt32(ds.Tables[0].Rows[0]["Status"].ToString());
                Amc.statusstr = Amc.Status.ToString();
                DataSet dds = SQL_DB.ExecuteDataSet("SELECT  * FROM Payment_Trans WHERE  Amc_Offer_ID='" + Amc.TransRow_ID + "'");
                if (dds.Tables[0].Rows.Count > 0)
                {
                    Amc.OldPayAmt = Convert.ToDouble(SQL_DB.ExecuteScalar("SELECT  ISNULL(SUM(Rec_Amount),0.00) FROM Payment_Trans WHERE  Amc_Offer_ID='" + Amc.TransRow_ID + "'"));
                    Amc.OldReqAmt = Convert.ToDouble(SQL_DB.ExecuteScalar("SELECT  ISNULL(SUM(Req_Amount),0.00) FROM Payment_Trans WHERE  Amc_Offer_ID='" + Amc.TransRow_ID + "'"));
                }
                else
                {
                    Amc.OldPayAmt = 0.00;
                    Amc.OldReqAmt = 0.00;
                }
                Amc.Comment_Txt = ds.Tables[0].Rows[0]["Comments"].ToString();
            }
        }
        public static DataSet FillTransDetailsData(Object9420 obj)
        {
            //dbCommand = database.GetSqlStringCommand("SELECT  (SELECT Pro_Name from Pro_Reg where Pro_Id=Payment_Transaction.Pro_Id) as Pro_Name, Request_No, Pro_Id, Plan_Name, Plan_Amount, Discount, Pay_Amount, Amt_Remarks, Entry_Date, AMCPlanID FROM Payment_Transaction WHERE Request_No = '" + obj.Request_No + "' ");
            dbCommand = database.GetSqlStringCommand("SELECT   (SELECT Pro_Name FROM Pro_Reg WHERE (Pro_ID = m.Pro_Id)) AS Pro_Name, p.Request_No,  m.Pro_ID, m.Plan_ID, m.Plan_Name, p.Rec_Amount, p.Req_Amount, p.Admin_Remark, p.Manu_Remark FROM M_Amc_Offer AS m RIGHT OUTER JOIN Payment_Trans AS p ON m.Amc_Offer_ID = p.Amc_Offer_ID WHERE p.Request_No = '" + obj.Request_No + "'");
            return database.ExecuteDataSet(dbCommand);
        }
        public static void ReceivedPaymentRequest(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Payment_Received] SET [Flag] = 1,Rec_Date = '" + Reg.Entry_Date.ToString("yyyy/MM/dd hh:mm:ss tt") + "' WHERE [Row_ID] = " + Reg.Row_ID + " ");
            database.ExecuteNonQuery(dbCommand);
            SetTrans_No();
        }
        public static void UpgradeAcc(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [M_Code] SET [Pro_ID] = NULL,[Batch_No] = NULL,Use_Count = NULL,[DispatchFlag] = NULL ,[ReceiveFlag] = NULL  WHERE [Use_Type] = (SELECT Allcation_Demo.Packet_Name FROM Allcation_Demo INNER JOIN Comp_Reg ON Allcation_Demo.Email_ID = Comp_Reg.Comp_Email where Comp_Reg.Comp_ID = '" + Reg.Comp_ID + "')");
            database.ExecuteNonQuery(dbCommand);
            dbCommand = database.GetSqlStringCommand("delete from T_Pro where Pro_ID = (SELECT T_Pro.Pro_ID FROM T_Pro INNER JOIN Pro_Reg ON T_Pro.Pro_ID = Pro_Reg.Pro_ID where Pro_Reg.Comp_ID = '" + Reg.Comp_ID + "')");
            database.ExecuteNonQuery(dbCommand);
            dbCommand = database.GetSqlStringCommand("DELETE FROM [Pro_Reg] WHERE Comp_ID = '" + Reg.Comp_ID + "'");
            database.ExecuteNonQuery(dbCommand);
            dbCommand = database.GetSqlStringCommand("DELETE FROM [M_Generate_Bill] where Comp_ID = '" + Reg.Comp_ID + "'");
            database.ExecuteNonQuery(dbCommand);
            dbCommand = database.GetSqlStringCommand("DELETE FROM [Allcation_Demo] where Packet_Name = (SELECT Allcation_Demo.Packet_Name FROM Allcation_Demo INNER JOIN Comp_Reg ON Allcation_Demo.Email_ID = Comp_Reg.Comp_Email where Comp_Reg.Comp_ID = '" + Reg.Comp_ID + "')");
            database.ExecuteNonQuery(dbCommand);
            dbCommand = database.GetSqlStringCommand("UPDATE [Comp_Reg] SET [Status] = 0,[Comp_Type] = 'L',[Upgrade_Date] = '" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd HH:mm:ss") + "' WHERE [Comp_ID] = '" + Reg.Comp_ID + "'");
            database.ExecuteNonQuery(dbCommand);
        }

        public static DataSet FindStateID(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT CityMaster.State_id,Comp_Reg.City_ID FROM Comp_Reg INNER JOIN CityMaster ON Comp_Reg.City_ID = CityMaster.CITY_ID WHERE Comp_Reg.Comp_ID = '" + Reg.Comp_ID + "'");
            return database.ExecuteDataSet(dbCommand);
        }

        public static int GetUploadDocStatus(Object9420 Log)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Row_ID as Doc_Flag FROM  Comp_Document WHERE Comp_ID = '" + Log.Comp_ID + "'");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
                return 1;
            else
                return 0;
        }
        public static int VerifyDocStatus(Object9420 Log)
        {
            dbCommand = database.GetSqlStringCommand("SELECT count([Flag]) as docverifyFlag FROM [Comp_Doc_Flag] where [Comp_ID] = '" + Log.Comp_ID + "' and [Flag] = 1");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
                return Convert.ToInt32(ds.Tables[0].Rows[0]["docverifyFlag"]);
            else
                return 0;
        }

        public static DataSet FillProddlSearch(Object9420 Reg)
        {
            string Qry = "";
            if (Reg.Status == 1)
                Qry = "  AND (M_Code.DispatchFlag = 1) ";
            dbCommand = database.GetSqlStringCommand("SELECT DISTINCT Pro_Reg.Pro_ID, Pro_Reg.Pro_Name, Pro_Reg.Comp_ID FROM M_Code FULL OUTER JOIN  Pro_Reg ON M_Code.Pro_ID = Pro_Reg.Pro_ID WHERE (M_Code.Print_Status = 1) " + Qry + "  AND (Pro_Reg.Comp_ID = '" + Reg.Comp_ID + "')");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillProddlDetails(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT DISTINCT Pro_Reg.Pro_ID, Pro_Reg.Pro_Name, Pro_Reg.Comp_ID FROM M_Code FULL OUTER JOIN  Pro_Reg ON M_Code.Pro_ID = Pro_Reg.Pro_ID WHERE (M_Code.Print_Status = 1) AND (M_Code.DispatchFlag = 1)  AND (M_Code.Batch_No IS NOT NULL)   AND (Pro_Reg.Comp_ID = '" + Reg.Comp_ID + "')");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillBatchddlDetails(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT distinct T_Pro.Row_ID, T_Pro.Batch_No FROM M_Code INNER JOIN T_Pro ON M_Code.Pro_ID = T_Pro.Pro_ID AND M_Code.Batch_No = T_Pro.Row_ID INNER JOIN  Pro_Reg ON T_Pro.Pro_ID = Pro_Reg.Pro_ID  WHERE (M_Code.Print_Status = 1) AND (M_Code.Batch_No IS NOT NULL) AND (Pro_Reg.Comp_ID = '" + Reg.Comp_ID + "') and T_Pro.Pro_ID ='" + Reg.Pro_ID + "'");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillSeriesDetails(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT tp.Row_ID, tp.[Batch_No],tp.[Series_Limit],isnull((SELECT [dbo].[GetAliasesById] ('" + Reg.Pro_ID + "',tp.Row_ID)),'---') as ScrapLabel FROM [T_Pro] tp where tp.[Pro_ID] = '" + Reg.Pro_ID + "'");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet GrdVwEnquiryDetails(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  M_Code.Pro_ID,(SELECT Comp_Name FROM Comp_Reg Where Comp_ID = (SELECT Comp_ID FROM Pro_Reg Where Pro_ID = M_Code.Pro_ID)) as Comp_Name,(SELECT Pro_Name FROM Pro_Reg Where Pro_ID = M_Code.Pro_ID) as Pro_Name, Pro_Enq.Dial_Mode AS ModeOfInquiry,convert(nvarchar,Pro_Enq.Enq_Date,109) as EnquiryDate , Pro_Enq.Mode_Detail AS ContactDetails, Pro_Enq.Received_Code1, " +
            " Pro_Enq.Received_Code2,(case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) as Successstatus,T_Pro.Batch_No,T_Pro.MRP,T_Pro.Mfd_Date,T_Pro.Exp_Date  FROM  M_Code INNER JOIN   Pro_Enq ON CONVERT(VARCHAR,M_Code.Code1) = Pro_Enq.Received_Code1 " +
            " AND CONVERT(VARCHAR,M_Code.Code2) = Pro_Enq.Received_Code2 INNER JOIN   T_Pro ON CONVERT(VARCHAR,M_Code.Batch_No) = T_Pro.Row_ID " +
            " where ('' = '" + Reg.Pro_ID + "' OR M_Code.Pro_ID = '" + Reg.Pro_ID + "') AND convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111)) >= " + Reg.datefromstr + "" +
            " and convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111)) <= " + Reg.datetostr + " and Pro_Enq.[Dial_Mode] = " + Reg.modestr + " and (case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) = " + Reg.statusstr + "" +
            " AND M_Code.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "')) order by Pro_Enq.Enq_Date desc");
            dbCommand.CommandTimeout = 5000000;
            return database.ExecuteDataSet(dbCommand);
        }


          public static DataSet FillFridForEnqDetails(Object9420 Reg)
        {
            //string strMsg = "and T_Pro.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "')) ";
            //dbCommand = database.GetSqlStringCommand("SELECT top 100 [M_Code].[Pro_ID],(SELECT [Pro_Name] FROM [Pro_Reg] Where [Pro_ID] = [M_Code].[Pro_ID]) as [Pro_Name], [vw_Pro_Enq].[Dial_Mode] AS ModeOfInquiry,CONVERT(varchar, [vw_Pro_Enq].[Enq_Date],3) as EnquiryDate, [vw_Pro_Enq].[Mode_Detail] AS ContactDetails, [vw_Pro_Enq].[Received_Code1], " + //cast(convert(nvarchar,Pro_Enq.Enq_Date,109) as datetime) as EnquiryDate 
            //" [vw_Pro_Enq].[Received_Code2],ISNULL([vw_Pro_Enq].MobileNo,'-- --') as MobileNo,(case when [vw_Pro_Enq].[Is_Success] = '1' then 'Success' else 'Unsuccess' end) as Successstatus,isnull([vw_Pro_Enq].Network,'-- --') as Network,isnull([vw_Pro_Enq].Circle,'-- --') as Circle, isnull(mc.employeeid,'-- --') as employeeid , isnull(mc.distributorid,'-- --') as distributorid FROM  [M_Code] (nolock) INNER JOIN  [vw_Pro_Enq] ON cast([M_Code].Code1 as nvarchar) = [vw_Pro_Enq].[Received_Code1] " +
            //" AND cast([M_Code].Code2 as nvarchar) = [vw_Pro_Enq].[Received_Code2] left join [T_Pro] on [M_code].[Batch_No] = [T_Pro].[Row_ID] left join [m_consumer] mc on mc.mobileno = [vw_Pro_Enq].MobileNo " + Reg.Msg + " order by [vw_Pro_Enq].[Enq_Date] desc");

            #region //* Query optimize due to higher time taken while execution , change M_code table with selected rows data and use count is grater than 0 and filter data from pro_enq table by creating a view as [vw_pro_enq_VendorReport] with date range filter '15-Dec-2022' and remove T_pro table
            // dbCommand = database.GetSqlStringCommand("SELECT top 100 [M_Code].[Pro_ID],(SELECT [Pro_Name] FROM [Pro_Reg] Where [Pro_ID] = [M_Code].[Pro_ID]) as [Pro_Name], [vw_Pro_Enq].[Dial_Mode] AS ModeOfInquiry,CONVERT(varchar, [vw_Pro_Enq].[Enq_Date],3) as EnquiryDate, [vw_Pro_Enq].[Mode_Detail] AS ContactDetails, [vw_Pro_Enq].[Received_Code1], " + //cast(convert(nvarchar,Pro_Enq.Enq_Date,109) as datetime) as EnquiryDate
            //" [vw_Pro_Enq].[Received_Code2],ISNULL([vw_Pro_Enq].MobileNo,'-- --') as MobileNo,(case when [vw_Pro_Enq].[Is_Success] = '1' then 'Success' when [vw_Pro_Enq].[Is_Success] = '0' then 'Invalid' else 'Unsuccess' end) as Successstatus,isnull([vw_Pro_Enq].Network,'-- --') as Network,isnull([vw_Pro_Enq].Circle,'-- --') as Circle, isnull(mc.employeeid,'-- --') as employeeid , isnull(mc.distributorid,'-- --') as distributorid FROM  [M_Code] (nolock) INNER JOIN  [vw_Pro_Enq] ON cast([M_Code].Code1 as nvarchar) = [vw_Pro_Enq].[Received_Code1] " +
            //" AND cast([M_Code].Code2 as nvarchar) = [vw_Pro_Enq].[Received_Code2] left join [T_Pro] on [M_code].[Batch_No] = [T_Pro].[Row_ID] left join [m_consumer] mc on mc.mobileno = [vw_Pro_Enq].MobileNo " + Reg.Msg + " order by [vw_Pro_Enq].[Enq_Date] desc");
            #endregion

            dbCommand = database.GetSqlStringCommand("SELECT top 100 [M_Code].[Pro_ID],(SELECT [Pro_Name] FROM [Pro_Reg] Where [Pro_ID] = [M_Code].[Pro_ID]) as [Pro_Name], [vw_Pro_Enq].[Dial_Mode] AS ModeOfInquiry,CONVERT(varchar, [vw_Pro_Enq].[Enq_Date]) as EnquiryDate, [vw_Pro_Enq].[Mode_Detail] AS ContactDetails, [vw_Pro_Enq].[Received_Code1], " + //cast(convert(nvarchar,Pro_Enq.Enq_Date,109) as datetime) as EnquiryDate
           " [vw_Pro_Enq].[Received_Code2],ISNULL([vw_Pro_Enq].MobileNo,'-- --') as MobileNo,(case when [vw_Pro_Enq].[Is_Success] = '1' then 'Success' when [vw_Pro_Enq].[Is_Success] = '0' then 'Invalid' else 'Unsuccess' end) as Successstatus,isnull([vw_Pro_Enq].Network,'-- --') as Network,isnull([vw_Pro_Enq].Circle,'-- --') as Circle, isnull(mc.employeeid,'-- --') as employeeid , isnull(mc.distributorid,'-- --') as distributorid FROM (select Pro_ID,Code1,Code2 from M_Code (nolock) where Use_Count >0) [M_Code] INNER JOIN [vw_pro_enq_VendorReport] [vw_Pro_Enq] ON cast([M_Code].Code1 as nvarchar) = [vw_Pro_Enq].[Received_Code1] " +
           " AND cast([M_Code].Code2 as nvarchar) = [vw_Pro_Enq].[Received_Code2]  left join [m_consumer] mc on mc.mobileno = [vw_Pro_Enq].MobileNo " + Reg.Msg + " and coalesce(mc.isdelete,0)=0 order by [vw_Pro_Enq].[Enq_Date] desc");

            dbCommand.CommandTimeout = 5000000;
            return database.ExecuteDataSet(dbCommand);
        }




        public static DataSet FillFridForEnqDetails_Warranty(Object9420 Reg)
        {
            //try
            //{

            //string str = "SELECT T_Pro.Exp_Date,isnull((select top 1 WarrantyPeriod from M_ServiceSubscriptionTrans  sst where Subscribe_Id in (select Subscribe_Id from M_ServiceSubscription where Pro_ID =  T_Pro.Pro_ID) " +
            //    " and isnull(sst.IsActive, 0) = 1 and isnull(sst.IsDelete, 0) = 0 and WarrantyPeriod is not null and CONVERT(nvarchar(10), GetUTCDate(), 101) between sst.DateFrom and sst.DateTo),0) as WarrantyDurationMonth, case when T_Pro.WarrantyDurationMonth > 0 then 'Yes' else 'No' end as IsWarranty,M_Code.Pro_ID,(SELECT Pro_Name FROM Pro_Reg Where Pro_ID = M_Code.Pro_ID) as Pro_Name, Pro_Enq.Dial_Mode AS ModeOfInquiry,convert(nvarchar,Pro_Enq.Enq_Date,109) as EnquiryDate , Pro_Enq.Mode_Detail AS ContactDetails, Pro_Enq.Received_Code1, " +
            //    " Pro_Enq.Received_Code2,ISNULL(Pro_Enq.MobileNo,'-- --') as MobileNo,(case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) as Successstatus," +
            //    "isnull(Pro_Enq.Network,'-- --') as Network,isnull(Pro_Enq.Circle,'-- --') as Circle FROM M_Code with (nolock) INNER JOIN  " +
            //    "Pro_Enq ON ( cast(M_Code.Code1 as nvarchar) = Pro_Enq.Received_Code1  " +
            //    " AND cast(M_Code.Code2 as nvarchar) = Pro_Enq.Received_Code2  )  inner join T_Pro on M_code.Batch_No = T_Pro.Row_ID " +
            ////" where ('' = '" + Reg.Pro_ID + "' OR M_Code.Pro_ID = '" + Reg.Pro_ID + "') AND convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111)) >= " + Reg.datefromstr + "" +
            ////" and convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111)) <= " + Reg.datetostr + " and Pro_Enq.[Dial_Mode] = " + Reg.modestr + " and (case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) = " + Reg.statusstr + "" +
            ////" AND M_Code.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "')) 
            ////Reg.Msg + "   and isnull(M_Code.Use_Count,0) > 0 order by Pro_Enq.Enq_Date desc";
            //" WHERE T_Pro.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg )  and isnull(M_Code.Use_Count,0) > 0 order by T_Pro.Exp_Date desc";//Pro_Enq.Enq_Date 
            ////DataProvider.LogManager.ErrorExceptionLog(str);


            //string str = "select purchasedate,C.Pro_Name +'('+ C.Pro_id + ')'  ProductName, C.Pro_id PrODUCT_ID,'Yes' IsWarranty ,ExpirationDate Exp_Date,concat(B.code1,B.code2) as 'Code',"
            //            + "datediff(month,Purchasedate,Expirationdate) WarrantyDurationMonth ,C.Pro_id,C.Pro_Name,'' ModeOfInquiry,'' EnquiryDate,'' ContactDetails," +
            //            "'' Received_Code1,'' Received_Code1,'' Received_Code2,MOBILE MobileNo,'' Successstatus,'' Network,'' Circle " +
            //           " ,BillNo as [Bill Number] ,State as [Vehicle Number],ImagePath as [Product Image], ImagePathBill as [Bill Invoice], Comment as [User Comment] " +
            //            " from [dbo].[WarrentyDetails] A inner join m_code B on cast(B.Code1 as varchar(20)) +'-'+ cast(B.code2 as varchar(20)) = A.Code " +
            //            " inner join pro_reg C on C.Pro_id = B.Pro_id where  C. Comp_ID = '" + Reg.Comp_ID + "' order by A.Purchasedate desc";

            string str = "select purchasedate,C.Pro_Name +'('+ C.Pro_id + ')'  ProductName, C.Pro_id PrODUCT_ID,'Yes' IsWarranty ,ExpirationDate Exp_Date,concat(B.code1,B.code2) as 'Code',"
                      + "datediff(month,Purchasedate,Expirationdate) WarrantyDurationMonth ,C.Pro_id,C.Pro_Name,'' ModeOfInquiry,'' EnquiryDate,'' ContactDetails," +
                      "'' Received_Code1,'' Received_Code1,'' Received_Code2,MOBILE MobileNo,'' Successstatus,'' Network,'' Circle " +
                     " ,BillNo as [Bill Number] ,State as [Vehicle Number],ImagePath as [Product Image], ImagePathBill as [Bill Invoice], Comment as [User Comment] " +
                      " from [dbo].[WarrentyDetails] A inner join m_code B on cast(B.Code1 as varchar(20)) +'-'+ cast(B.code2 as varchar(20)) = A.Code " +
                      " inner join pro_reg C on C.Pro_id = B.Pro_id where  C. Comp_ID = '" + Reg.Comp_ID + "' order by A.Purchasedate desc";

            dbCommand = database.GetSqlStringCommand(str);
            dbCommand.CommandTimeout = 5000000;
            return database.ExecuteDataSet(dbCommand);
            //}
            //catch (Exception ex)
            //{
            //    HttpContext.Current.Response.Write(ex.Message);
            //    throw ex;
            //}

        }
        public static DataSet FillFridForEnqDetails_Warranty_download(Object9420 Reg)
        {
            //try
            //{

            //string str = "SELECT T_Pro.Exp_Date,isnull((select top 1 WarrantyPeriod from M_ServiceSubscriptionTrans  sst where Subscribe_Id in (select Subscribe_Id from M_ServiceSubscription where Pro_ID =  T_Pro.Pro_ID) " +
            //    " and isnull(sst.IsActive, 0) = 1 and isnull(sst.IsDelete, 0) = 0 and WarrantyPeriod is not null and CONVERT(nvarchar(10), GetUTCDate(), 101) between sst.DateFrom and sst.DateTo),0) as WarrantyDurationMonth, case when T_Pro.WarrantyDurationMonth > 0 then 'Yes' else 'No' end as IsWarranty,M_Code.Pro_ID,(SELECT Pro_Name FROM Pro_Reg Where Pro_ID = M_Code.Pro_ID) as Pro_Name, Pro_Enq.Dial_Mode AS ModeOfInquiry,convert(nvarchar,Pro_Enq.Enq_Date,109) as EnquiryDate , Pro_Enq.Mode_Detail AS ContactDetails, Pro_Enq.Received_Code1, " +
            //    " Pro_Enq.Received_Code2,ISNULL(Pro_Enq.MobileNo,'-- --') as MobileNo,(case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) as Successstatus," +
            //    "isnull(Pro_Enq.Network,'-- --') as Network,isnull(Pro_Enq.Circle,'-- --') as Circle FROM M_Code with (nolock) INNER JOIN  " +
            //    "Pro_Enq ON ( cast(M_Code.Code1 as nvarchar) = Pro_Enq.Received_Code1  " +
            //    " AND cast(M_Code.Code2 as nvarchar) = Pro_Enq.Received_Code2  )  inner join T_Pro on M_code.Batch_No = T_Pro.Row_ID " +
            ////" where ('' = '" + Reg.Pro_ID + "' OR M_Code.Pro_ID = '" + Reg.Pro_ID + "') AND convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111)) >= " + Reg.datefromstr + "" +
            ////" and convert(datetime,convert(nvarchar,Pro_Enq.Enq_Date,111)) <= " + Reg.datetostr + " and Pro_Enq.[Dial_Mode] = " + Reg.modestr + " and (case when Pro_Enq.Is_Success = '1' then 'Success' else 'Unsuccess' end) = " + Reg.statusstr + "" +
            ////" AND M_Code.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg Where (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "')) 
            ////Reg.Msg + "   and isnull(M_Code.Use_Count,0) > 0 order by Pro_Enq.Enq_Date desc";
            //" WHERE T_Pro.Pro_ID IN (SELECT Pro_ID FROM Pro_Reg )  and isnull(M_Code.Use_Count,0) > 0 order by T_Pro.Exp_Date desc";//Pro_Enq.Enq_Date 
            ////DataProvider.LogManager.ErrorExceptionLog(str);
            ///

            //string str = "select purchasedate as 'Purchase Date',C.Pro_Name +'('+ C.Pro_id + ')'  [Product Name (Product Id)], concat(B.code1,B.code2) as 'Complete Code',MOBILE 'Mobile No',case when datediff(month,Purchasedate,Expirationdate) >0 then 'Yes' else 'No' end as 'Is Warranty' ,ExpirationDate as 'Warranty Expiration Date',"
            //            + "datediff(month,Purchasedate,Expirationdate) 'Warranty Period (months)'" +
            //            " from [dbo].[WarrentyDetails] A inner join m_code B on cast(B.Code1 as varchar(20)) +'-'+ cast(B.code2 as varchar(20)) = A.Code " +
            //            " inner join pro_reg C on C.Pro_id = B.Pro_id where  C. Comp_ID = '" + Reg.Comp_ID + "' order by Purchasedate desc";


            string str = "select purchasedate as 'Purchase Date',C.Pro_Name +'('+ C.Pro_id + ')'  [Product Name (Product Id)], concat(B.code1,B.code2) as 'Complete Code',MOBILE 'Mobile No',case when datediff(month,Purchasedate,Expirationdate) >0 then 'Yes' else 'No' end as 'Is Warranty' ,ExpirationDate as 'Warranty Expiration Date',"
                 + "datediff(month,Purchasedate,Expirationdate) 'Warranty Period (months)'" +
                 " ,BillNo as [Bill Number] ,State as [Device], Comment as [User Comment],replace(ImagePath,'~/','https://qa.vcqru.com/') as [Product Image], replace(ImagePathBill,'~/','https://qa.vcqru.com/') as [Bill Invoice]  " +
                 " from [dbo].[WarrentyDetails] A inner join m_code B on cast(B.Code1 as varchar(20)) +'-'+ cast(B.code2 as varchar(20)) = A.Code " +
                 " inner join pro_reg C on C.Pro_id = B.Pro_id where  C. Comp_ID = '" + Reg.Comp_ID + "' order by Purchasedate desc";



            dbCommand = database.GetSqlStringCommand(str);
            dbCommand.CommandTimeout = 5000000;
            return database.ExecuteDataSet(dbCommand);
            //}
            //catch (Exception ex)
            //{
            //    HttpContext.Current.Response.Write(ex.Message);
            //    throw ex;
            //}

        }
        public static DataSet FillGridForPrintedLabels(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT M_Code.Pro_ID AS SeriesName, M_Code.Code1, T_Pro.Batch_No, Pro_Reg.Comp_ID, convert(nvarchar,M_Code.Print_Date,107) as PrintDate ,(case when (M_Code.Pro_ID+'-'+ convert(varchar,(case when len(convert(nvarchar,M_Code.Series_Order)) = 1 then '0'+ convert(nvarchar,M_Code.Series_Order) else convert(nvarchar,M_Code.Series_Order) " +
             " end))+'-'+convert(varchar,(case when len(convert(varchar,M_Code.Series_Serial)) = 1 then '000' +convert(varchar,M_Code.Series_Serial)   when len(convert(varchar,M_Code.Series_Serial)) = 2 then '00' +convert(varchar,M_Code.Series_Serial) when len(convert(varchar,M_Code.Series_Serial)) = 3 then '0' +convert(varchar,M_Code.Series_Serial)  else convert(varchar,M_Code.Series_Serial) " +
             " end ))) is null then use_type else (M_Code.Pro_ID+'-'+ convert(varchar,(case when len(convert(nvarchar,M_Code.Series_Order)) = 1 then '0'+ convert(nvarchar,M_Code.Series_Order) else convert(nvarchar,M_Code.Series_Order) " +
             " end))+'-'+convert(varchar,(case when len(convert(varchar,M_Code.Series_Serial)) = 1 then '000' +convert(varchar,M_Code.Series_Serial)   when len(convert(varchar,M_Code.Series_Serial)) = 2 then '00' +convert(varchar,M_Code.Series_Serial) when len(convert(varchar,M_Code.Series_Serial)) = 3 then '0' +convert(varchar,M_Code.Series_Serial)  else convert(varchar,M_Code.Series_Serial) end ))) end)" +
             " as SerialCode  " +
             " FROM M_Code INNER JOIN T_Pro ON M_Code.Pro_ID = T_Pro.Pro_ID AND M_Code.Batch_No = T_Pro.Row_ID INNER JOIN" +
             " Pro_Reg ON T_Pro.Pro_ID = Pro_Reg.Pro_ID WHERE (M_Code.Print_Status = 1) " +
             " AND (M_Code.Batch_No IS NOT NULL) and Pro_Reg.Comp_ID = '" + Reg.Comp_ID + "' and M_Code.Pro_ID = " + Reg.Pro_ID + " and T_Pro.Row_ID = " + Reg.Row_ID + "");
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet FillGridDetails(Object9420 Reg)
        {
            string Qty = "SELECT T_Pro.Row_ID, T_Pro.Pro_ID, T_Pro.MRP, T_Pro.Mfd_Date,(case when T_Pro.WarrantyDurationMonth > 0 then 'Yes' else 'No' end) as IsWarranty,isnull(T_Pro.WarrantyDurationMonth,0) as WarrantyDurationMonth, (CASE WHEN CONVERT(NVARCHAR,T_Pro.Exp_Date,103) is null THEN  '----' ELSE  CONVERT(NVARCHAR,T_Pro.Exp_Date,103)  END ) AS Exp_Date, T_Pro.Batch_No, T_Pro.Entry_Date," + //" T_Pro.Update_Flag_H, T_Pro.Update_Flag_E,  " +
                " Comp_Reg.Comp_ID,  " +
                " (SELECT COUNT(Row_ID) AS Expr1  " +
                " FROM M_Code  " +
                " WHERE (Batch_No =CONVERT(VARCHAR,T_Pro.Row_ID))) AS NoofCodes,   " +
                "	'../Data/Sound/' + SUBSTRING(Comp_Reg.Comp_ID, 6, 4) +'/'+ CONVERT(VARCHAR,T_Pro.Pro_ID)+'/'+ CONVERT(VARCHAR,T_Pro.Row_ID) +'/'+CONVERT(VARCHAR,T_Pro.Row_ID)+ '_H.mp3 ' AS SoundPath_H,   " +
                "	'../Data/Sound/' + SUBSTRING(Comp_Reg.Comp_ID, 6, 4) +'/'+ CONVERT(VARCHAR,T_Pro.Pro_ID)+'/'+ CONVERT(VARCHAR,T_Pro.Row_ID) +'/'+CONVERT(VARCHAR,T_Pro.Row_ID)+'_E.mp3' AS SoundPath_E,   " +
                " Pro_Reg.Pro_Name  " +
                " FROM Comp_Reg INNER JOIN  " +
                " Pro_Reg ON Comp_Reg.Comp_ID = Pro_Reg.Comp_ID INNER JOIN  " +
                " T_Pro ON Pro_Reg.Pro_ID = T_Pro.Pro_ID  " +
                " WHERE (Comp_Reg.Comp_ID = '" + Reg.Comp_ID + "') AND (Pro_Reg.Pro_Name LIKE '%" + Reg.Pro_Name + "%')  " + Reg.chkstr + " ORDER BY T_Pro.Row_ID DESC,T_Pro.Entry_Date DESC";
            dbCommand = database.GetSqlStringCommand(Qty); dbCommand.CommandTimeout = 500000;
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet FillddlProForPrint(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  distinct   Pro_Reg.Pro_ID, Pro_Reg.Pro_Name FROM Pro_Reg INNER JOIN  M_Code ON Pro_Reg.Pro_ID = M_Code.Pro_ID WHERE (Pro_Reg.Comp_ID = '" + Reg.Comp_ID + "')  ORDER BY Pro_Reg.Pro_Name");
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet FillFridForAmcBills(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Comp_ID,Comp_Name,sum(Plan_Amount) as Plan_Amount FROM ( SELECT UniqueID,Comp_Name , Comp_ID, Pro_ID, Plan_Name, Plan_AmountA,Plan_Amount as Amount,Plan_Discount,isnull((SELECT sum(Pay_Amount) FROM Payment_Transaction WHERE AMCPlanID =  Amc.UniqueID group by Pro_ID),0.00) AS Paid,Plan_Amount-Plan_Discount-isnull((SELECT sum(Pay_Amount) FROM Payment_Transaction WHERE AMCPlanID =  Amc.UniqueID group by Pro_ID),0.00) as Plan_Amount   " +
             " ,Date_From,Date_To,Pro_Name,Tax FROM (SELECT  convert(varchar,M_TransactionPlan.Row_ID) + M_TransactionPlan.Plan_ID+M_TransactionPlan.Pro_ID as UniqueID,M_TransactionPlan.Row_ID, (select Comp_Name from Comp_Reg where Comp_Id=Pro_Reg.Comp_ID) as Comp_Name , Pro_Reg.Comp_ID, Pro_Reg.Pro_ID, M_Plan.Plan_Name, M_Plan.Plan_Amount AS Plan_AmountA,M_Plan.Plan_Discount, CONVERT(NUMERIC(18, 2), M_Plan.Plan_Amount * (1 +  " +
             " (SELECT     Service_Tax FROM Tax_Master  WHERE      (Row_Id = (SELECT     MAX(Row_Id) AS Expr1 FROM Tax_Master AS Tax_Master_1))) / 100)) AS Plan_Amount, M_TransactionPlan.Date_From, M_TransactionPlan.Date_To, Pro_Reg.Pro_Name,CONVERT(NUMERIC(18, 2),(M_Plan.Plan_Amount * (SELECT     Service_Tax  " +
             " FROM          Tax_Master WHERE      (Row_Id = (SELECT     MAX(Row_Id) AS Expr1 FROM          Tax_Master AS Tax_Master_1))))/100) as Tax FROM Pro_Reg INNER JOIN  M_TransactionPlan ON Pro_Reg.Pro_ID = M_TransactionPlan.Pro_ID INNER JOIN  M_Plan ON M_TransactionPlan.Plan_ID = M_Plan.Plan_ID  " +
             " WHERE (Pro_Reg.Comp_ID = 'Comp-1002') AND M_TransactionPlan.Row_ID = (SELECT MAX(Row_ID) FROM M_TransactionPlan WHERE Pro_ID = Pro_Reg.Pro_ID) " +
             " ) Amc ) Reg WHERE Reg.Plan_Amount > 0.00 GROUP BY Reg.Comp_ID,Reg.Comp_Name");
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet FillPromotional(int i)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Row_Id, Promo_ID, Promo_Name, Time_Days, Amount, Flag," + i + " AS Disp FROM M_Promotional WHERE Flag = 1 ORDER BY  CONVERT(int, Time_Days) ");
            return database.ExecuteDataSet(dbCommand);
        }
        public static void Generate_Invoice(Object9420 Reg)
        {
            Reg.Rate = Reg.Label_Prise;
            Reg.Tax = FindTax();
            Reg.Rec_Payment = Math.Round(Convert.ToDouble(FindPayAmcAmount(Reg)), 2);   //Adjustment            
            Reg.G_Amount = Math.Round((Reg.Qty * Reg.Label_Prise), 2);
            Reg.Service_Tax = Math.Round((Reg.G_Amount) * (Reg.Tax / 100), 2);
            Reg.N_Amount = Reg.G_Amount + Reg.Service_Tax;
            FindBillData(Reg);
        }
        public static void FindBillData(Object9420 Reg)
        {
            Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt"));
            Reg.Tax = Reg.Service_Tax;
            Reg.Invoice_No = GetInvoice_No();
            InsertM_Generate_Bill(Reg);
            InsertGenerateBills(Reg);
            //SetInvoice_No();
        }
        public static void Generate_InvoiceAmcOffer(Object9420 Reg)
        {
            Reg.TransRow_ID = Reg.Row_ID; // Row_Id from Payment Received where action applied 
            Reg.Flag = 1;
            DataSet ds = function9420.FindDetailsForRequestPayment(Reg);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.PayAmt = Reg.Rec_Payment;
                Reg.Rec_Payment = Math.Round(Convert.ToDouble(FindAmcOfferAmount(Reg)), 2);   //Adjustment //Reg.Rec_Payment = Math.Round(Convert.ToDouble(FindPayAmcAmount(Reg)), 2);   //Adjustment
                Reg.Tax = FindTax();
                Reg.G_Amount = Math.Round(Reg.PayAmt / (1 + ((Reg.Tax) / 100)), 2);
                Reg.Service_Tax = Math.Round((Reg.PayAmt - Reg.G_Amount), 2);
                Reg.N_Amount = Reg.PayAmt;
                GenerateInvoice(Reg);
            }
        }
        public static void Generate_InvoiceLabel(Object9420 Reg)
        {
            Reg.TransRow_ID = Reg.Row_ID; // Row_Id from Payment Received where action applied 
            Reg.Flag = 1;
            DataSet ds = function9420.FindDetailsForRequestPayment(Reg);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.PayAmt = Reg.Rec_Payment;
                Reg.Rec_Payment = Math.Round(Convert.ToDouble(FindLabelAmount(Reg)), 2);   //Adjustment //Reg.Rec_Payment = Math.Round(Convert.ToDouble(FindPayAmcAmount(Reg)), 2);   //Adjustment
                Reg.Tax = 0.00;
                Reg.G_Amount = 0.00;
                Reg.Service_Tax = 0.00;
                Reg.N_Amount = 0.00;
                GenerateInvoiceForLabel(Reg);
            }
        }
        private static double FindLabelAmount(Object9420 Reg)
        {
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT Comp_ID FROM Payment_Received WHERE Comp_ID = '" + Reg.Comp_ID + "' ");
            if (ds.Tables[0].Rows.Count > 0)
            {
                DataSet ds1 = SQL_DB.ExecuteDataSet("SELECT Comp_ID FROM M_Generate_Bill WHERE Comp_ID = '" + Reg.Comp_ID + "' ");
                if (ds1.Tables[0].Rows.Count > 0)
                    dbCommand = database.GetSqlStringCommand("SELECT isnull(SUM(N_Amount),0.00) - isnull((select sum(Rec_Amount) from Payment_Received WHERE Comp_ID='" + Reg.Comp_ID + "' AND Payment_For = '" + Reg.Trans_Type + "'),0.00) FROM M_Generate_Bill WHERE Trans_Type = '" + Reg.Trans_Type + "' AND Comp_ID = '" + Reg.Comp_ID + "' ");
                else
                    dbCommand = database.GetSqlStringCommand("select isnull(sum(Rec_Amount),0.00) as Paid from Payment_Received WHERE Comp_ID='" + Reg.Comp_ID + "' AND Payment_For = '" + Reg.Trans_Type + "'");
            }
            else
                dbCommand = database.GetSqlStringCommand("SELECT isnull(SUM(N_Amount),0.00) - isnull((select sum(Rec_Amount) from Payment_Received WHERE Comp_ID='" + Reg.Comp_ID + "' AND Payment_For = '" + Reg.Trans_Type + "'),0.00) FROM M_Generate_Bill WHERE Trans_Type = '" + Reg.Trans_Type + "' AND Comp_ID = '" + Reg.Comp_ID + "' ");
            return Convert.ToDouble(database.ExecuteScalar(dbCommand));
        }
        private static double FindAmcOfferAmount(Object9420 Reg)
        {
            //dbCommand = database.GetSqlStringCommand("SELECT isnull(SUM(Admin_Balance),0.00) - isnull((select sum(Rec_Amount) from Payment_Received WHERE Comp_ID='"+ Reg.Comp_ID +"'),0.00) FROM M_Amc_Offer WHERE Trans_Type = '"+ Reg.Trans_Type +"' AND Comp_ID = '"+ Reg.Comp_ID +"' "); 
            dbCommand = database.GetSqlStringCommand("SELECT isnull(SUM(Admin_Balance),0.00) AS Pre_Bal FROM M_Amc_Offer WHERE (Row_ID IN (SELECT     Amc_Offer_ID FROM Payment_Trans WHERE (Request_No = '" + Reg.Request_No + "')))");
            return Convert.ToDouble(database.ExecuteScalar(dbCommand));
        }
        public static void GenerateInvoiceForLabel(Object9420 Reg)
        {
            Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt"));
            Reg.Tax = Reg.Service_Tax;
            Reg.Invoice_No = GetInvoice_No();
            InsertM_Generate_Bill(Reg);
            //DataSet ds1 = function9420.FillAmcOfferDetails(Reg);
            //if (ds1.Tables[0].Rows.Count > 0)
            //{
            //    for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
            //    {
            //        Reg.Pro_ID = ds1.Tables[0].Rows[i]["Pro_ID"].ToString();
            //        Reg.Plan_ID = ds1.Tables[0].Rows[i]["Plan_ID"].ToString(); // just like Plan for Amc and Offer Invoice
            //        Reg.Rec_Payment = Convert.ToDouble(ds1.Tables[0].Rows[i]["Rec_Amount"].ToString());
            //        Reg.Rate = 0.00; // as requested amount 
            //        Reg.Qty = 0.00;// 0.00; // as received amount
            //        Reg.Pre_Bal = Convert.ToDouble(ds1.Tables[0].Rows[i]["Manu_Balance"].ToString());
            //        Reg.Amc_Offer_ID = Convert.ToInt32(ds1.Tables[0].Rows[i]["Amc_Offer_ID"].ToString());
            //        Reg.G_Amount = Reg.Rec_Payment;  // as n_amount
            //        InsertGenerateBills(Reg);
            //    }
            //}
            SetInvoice_No();
        }
        public static void GenerateInvoice(Object9420 Reg)
        {
            Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt"));
            Reg.Tax = Reg.Service_Tax;
            Reg.Invoice_No = GetInvoice_No();
            InsertM_Generate_Bill(Reg);
            DataSet ds1 = function9420.FillAmcOfferDetails(Reg);
            if (ds1.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
                {
                    Reg.Pro_ID = ds1.Tables[0].Rows[i]["Pro_ID"].ToString();
                    Reg.Plan_ID = ds1.Tables[0].Rows[i]["Plan_ID"].ToString(); // just like Plan for Amc and Offer Invoice
                    Reg.Rec_Payment = Convert.ToDouble(ds1.Tables[0].Rows[i]["Rec_Amount"].ToString());
                    Reg.Rate = 0.00; // as requested amount 
                    Reg.Qty = 0.00;// 0.00; // as received amount
                    Reg.Pre_Bal = Convert.ToDouble(ds1.Tables[0].Rows[i]["Admin_Balance"].ToString());
                    Reg.Amc_Offer_ID = Convert.ToInt32(ds1.Tables[0].Rows[i]["Amc_Offer_ID"].ToString());
                    Reg.G_Amount = Reg.Rec_Payment;  // as n_amount
                    InsertGenerateBills(Reg);
                }
            }
            SetInvoice_No();
        }

        public static double FindTax()
        {
            return Convert.ToDouble(SQL_DB.ExecuteScalar("SELECT Service_Tax FROM Tax_Master WHERE  (Row_Id = (SELECT MAX(Row_Id) AS Expr1  FROM Tax_Master AS Tax_Master_1))"));
        }
        public static double FindVat(Business9420.Object9420 Reg)
        {
            return Convert.ToDouble(SQL_DB.ExecuteScalar("SELECT Vat FROM Vat_Master WHERE Comp_ID = '" + Reg.Comp_ID + "' AND Flag = 1 AND (Row_Id = (SELECT MAX(Row_Id) AS Expr1  FROM Vat_Master AS Vat_Master_1 WHERE Comp_ID = '" + Reg.Comp_ID + "'))"));
        }
        public static void FindBillDataNew(Object9420 Reg)
        {
            Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt"));
            Reg.Tax = Reg.Service_Tax;
            Reg.Invoice_No = GetInvoice_No();
            InsertM_Generate_Bill(Reg);
            InsertGenerateBills(Reg);
            SetInvoice_No();
        }
        private static double FindPayAmcAmount(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT CONVERT(NUMERIC(18,2),((SELECT ISNULL(Sum(Rec_Amount),0.00) FROM Payment_Received WHERE  Payment_for= '" + Reg.Trans_Type + "' AND Flag = 1  AND Comp_ID = '" + Reg.Comp_ID + "'  AND Pro_ID = '" + Reg.Pro_ID + "' ) - ISNULL(SUM(N_Amount),0.00))) AS TotalAmt FROM M_Generate_Bill WHERE Comp_ID = '" + Reg.Comp_ID + "'  AND Trans_Type= '" + Reg.Trans_Type + "' AND (Invoice_No  IN (SELECT Invoice_No FROM T_Generate_Bill WHERE Pro_ID='" + Reg.Pro_ID + "' )) ");
            return Convert.ToDouble(database.ExecuteScalar(dbCommand));
        }

        public static DataSet FindDetailsForRequestPayment(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Row_Id, Rec_Date, Req_Date, Comp_ID, Bank_ID, Req_Amount, isnull(Rec_Amount,0.00) as Rec_Amount, Manu_Remark, Request_No, PayMode, Details, Payment_For, Admin_Remark,Payment_By,Payment_For, Flag FROM Payment_Received  WHERE Row_ID = " + Reg.Row_ID + " AND Comp_ID = '" + Reg.Comp_ID + "' AND Flag = " + Reg.Flag + " ");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.TotalReq_Payment = Convert.ToDouble(ds.Tables[0].Rows[0]["Req_Amount"].ToString());
                Reg.ManuReq_Payment = Convert.ToDouble(ds.Tables[0].Rows[0]["Req_Amount"].ToString());
                Reg.Request_No = ds.Tables[0].Rows[0]["Request_No"].ToString();
                Reg.Trans_Type = ds.Tables[0].Rows[0]["Payment_For"].ToString();
                Reg.Comp_ID = ds.Tables[0].Rows[0]["Comp_ID"].ToString();
                Reg.Rec_Payment = Convert.ToDouble(ds.Tables[0].Rows[0]["Rec_Amount"].ToString());
            }
            return ds;
        }

        public static DataSet FillAmcOfferDetails(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT m.Row_ID,m.Request_No,m.Req_Amount,m.Manu_Remark,(SELECT Pro_Name FROM PRO_Reg WHERE Pro_ID =m.Pro_ID) as  Pro_Name,m.Req_Date as Entry_Date , m.Comp_ID from Payment_Received as m  " +
            " WHERE (m.Request_No = '" + Reg.Request_No + "')");
            //dbCommand = database.GetSqlStringCommand("SELECT     t.Row_ID, t.Amc_Offer_ID, t.Request_No, t.Rec_Amount, t.Req_Amount, t.Manu_Remark, m.Pro_ID,(SELECT Pro_Name FROM PRO_Reg WHERE Pro_ID =m.Pro_ID) as  Pro_Name, m.Plan_Name, m.Plan_Amount,  " +
            //" m.Plan_Discount, m.Admin_Balance, m.Manu_Balance, m.Entry_Date, m.Plan_ID, m.Comp_ID FROM         Payment_Trans AS t INNER JOIN M_Amc_Offer AS m ON t.Amc_Offer_ID = m.Row_ID WHERE (t.Request_No = '" + Reg.Request_No + "') ");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillPaymentsDetails(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT     Row_Id, Rec_Date, Req_Date, Comp_ID, Pro_ID, Bank_ID, Req_Amount, Rec_Amount, Manu_Remark, Request_No, PayMode, Details, Payment_For, Admin_Remark, Payment_By, Flag, ModeofPayment " +
            " FROM Payment_Received WHERE Request_No = '" + Reg.Request_No + "' ");
            return database.ExecuteDataSet(dbCommand);
        }

        public static void CanceledRequest(Object9420 Reg)
        {
            DataSet ds = function9420.FillAmcOfferDetails(Reg);
            Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt"));
            #region Code For Account
            double payAmt = 0.0;
            for (int i = 0; i <= ds.Tables[0].Rows.Count - 1; i++)
            {
                Label lblRowID = new Label(); lblRowID.Text = ds.Tables[0].Rows[i]["Row_ID"].ToString(); // Used for Transction Table
                TextBox txtAmtremarks = new TextBox(); txtAmtremarks.Text = "Canceled by " + Reg.User_Type; // Used for Transction Table
                TextBox txtpayAmt = new TextBox(); txtpayAmt.Text = "0.00";  // Used for Transction Table
                Label lblManuReqAmt = new Label(); lblManuReqAmt.Text = ds.Tables[0].Rows[i]["Req_Amount"].ToString();
                Label lbluniqueID = new Label(); lbluniqueID.Text = ds.Tables[0].Rows[i]["Amc_Offer_ID"].ToString(); // Used for M_Amc_Offer
                Label txtAdminBalance = new Label(); txtAdminBalance.Text = ds.Tables[0].Rows[i]["Admin_Balance"].ToString();  // Used for M_Amc_Offer
                Label txtManuBalance = new Label(); txtManuBalance.Text = ds.Tables[0].Rows[i]["Manu_Balance"].ToString();   // Used for M_Amc_Offer

                Reg.ManuReq_Payment = Convert.ToDouble(lblManuReqAmt.Text);
                Reg.Row_ID = lblRowID.Text; // Row_ID transction table same used [TransRow_ID property]            
                Reg.AmcPlan_Amount = Convert.ToDouble(txtAdminBalance.Text);
                Reg.Amc_Offer_ID = Convert.ToInt32(lbluniqueID.Text);
                Reg.Admin_Remark = txtAmtremarks.Text;
                Reg.Admin_Balance = Convert.ToDouble(txtAdminBalance.Text);
                Reg.Manu_Balance = Convert.ToDouble(txtManuBalance.Text);
                Reg.TRec_Payment = 0.00;
                if (Reg.TRec_Payment <= Reg.TotalReq_Payment)
                {
                    Reg.TotalReq_Payment -= Reg.TRec_Payment;
                    if (Reg.TRec_Payment <= Reg.ManuReq_Payment)
                    {
                        Reg.Credit_Payment = Reg.ManuReq_Payment - Reg.TRec_Payment;
                        Reg.Debit_Payment = 0.00;
                        Reg.Manu_Balance += Reg.Credit_Payment;
                        Reg.Admin_Balance -= Reg.TRec_Payment;
                    }
                    else
                    {
                        Reg.Credit_Payment = 0.00;
                        Reg.Debit_Payment = Reg.TRec_Payment - Reg.ManuReq_Payment;
                        Reg.Manu_Balance -= Reg.Debit_Payment;
                        Reg.Admin_Balance -= Reg.TRec_Payment;
                    }
                }
                Reg.DML = "U";
                function9420.InsertTransaction(Reg); // Update Transction Table Data   
                payAmt += Convert.ToDouble(Reg.TRec_Payment);
                if ((Reg.Debit_Payment > 0.00) || (Reg.Credit_Payment > 0.00))
                {
                    Reg.DML = "Manu";
                    function9420.UpdateAmcOfferPayment(Reg); // Update M_Amc_Offer Table Data  manuf. balance
                    Reg.DML = "Admin";
                    function9420.UpdateAmcOfferPayment(Reg); // Update M_Amc_Offer Table Data  Admin balance
                }
            }
            Reg.Row_ID = Reg.TransRow_ID.ToString(); // Row_Id from Payment Received where action applied
            Reg.Rec_Payment = payAmt;
            Reg.Admin_Remark = Reg.Admin_Remarks;
            Reg.Manu_Remark = Reg.Admin_Remarks;
            function9420.UpdateReceivedPayment(Reg);  // Update Payment_Received Table Data
            #endregion
        }
        public static void CanceledPaymentRequest(Object9420 Reg)
        {
            //DataSet ds = function9420.FillAmcOfferDetails(Reg); // Old Function For checking
            DataSet ds = function9420.FillPaymentsDetails(Reg); // New Function For checking
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Entry_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt"));
                #region Code For Account
                double payAmt = 0.0;
                Reg.Row_ID = Reg.TransRow_ID.ToString(); // Row_Id from Payment Received where action applied
                Reg.Rec_Payment = payAmt;
                Reg.Admin_Remark = Reg.Admin_Remarks;
                Reg.Manu_Remark = Reg.Admin_Remarks;
                function9420.UpdateReceivedPayment(Reg);  // Update Payment_Received Table Data
            }
            #endregion
        }

        public static DataSet FillGenBillData(Object9420 Reg)
        {
            //dbCommand = database.GetSqlStringCommand("SELECT [Comp_ID],(SELECT [Comp_Name] FROM [Comp_Reg] where [Comp_ID]=[Payment_Received].[Comp_ID]) as Comp_Name, isnull(sum([Rec_Amount]),0) as Total_Paid, (SELECT isnull(sum([N_Amount]),0) FROM [M_Generate_Bill] where [Comp_ID]=[Payment_Received].[Comp_ID]) as Total_Purchase , " +
            //" (case when  (isnull(sum([Rec_Amount]),0)-(SELECT isnull(sum([N_Amount]),0) FROM [M_Generate_Bill] where [Comp_ID]=[Payment_Received].[Comp_ID]))<=0 then 0 else (isnull(sum([Rec_Amount]),0)-(SELECT isnull(sum([N_Amount]),0) FROM [M_Generate_Bill] where [Comp_ID]=[Payment_Received].[Comp_ID])) end) as Advance, " +
            //" (case when  (isnull(sum([Rec_Amount]),0)-(SELECT isnull(sum([N_Amount]),0) FROM [M_Generate_Bill] where [Comp_ID]=[Payment_Received].[Comp_ID]))<=0 then (isnull(sum([Rec_Amount]),0)-(SELECT isnull(sum([N_Amount]),0) FROM [M_Generate_Bill] where [Comp_ID]=[Payment_Received].[Comp_ID])) else 0 end) as TotalOutStand,    " +
            //" (SELECT [Rec_Date] FROM [Payment_Received] where [Flag]=1 and Row_Id=(Select max(Row_Id) from [Payment_Received] where [Comp_ID]=[Payment_Received].[Comp_ID] and [Flag]=1) and [Comp_ID]=[Payment_Received].[Comp_ID]) as Last_Payment_Date FROM [Payment_Received] where [Flag]=1 group by [Comp_ID]");
            //dbCommand = database.GetSqlStringCommand("SELECT [Comp_ID],(SELECT [Comp_Name] FROM [Comp_Reg] where [Comp_ID]=[M_Generate_Bill].[Comp_ID]) as Comp_Name , (SELECT isnull(sum([Rec_Amount]),0) FROM  [Payment_Received] where [Comp_ID]=[M_Generate_Bill].[Comp_ID]) as Total_Paid,  (SELECT isnull(sum([N_Amount]),0) FROM [M_Generate_Bill] group by [Comp_ID]) +  (SELECT isnull(sum([Admin_Balance]),0) FROM [M_Amc_Offer] group by [Comp_ID])  as Total_Purchase  " +
            //" ,(case when ((SELECT isnull(sum([Rec_Amount]),0) FROM  [Payment_Received] where [Comp_ID]=[M_Generate_Bill].[Comp_ID]))-((SELECT isnull(sum([N_Amount]),0) FROM [M_Generate_Bill] group by [Comp_ID]) +  (SELECT isnull(sum([Admin_Balance]),0) FROM [M_Amc_Offer] group by [Comp_ID])) <= 0 then 0.00 else ((SELECT isnull(sum([Rec_Amount]),0) FROM  [Payment_Received] where [Comp_ID]=[M_Generate_Bill].[Comp_ID]))-((SELECT isnull(sum([N_Amount]),0) FROM [M_Generate_Bill] group by [Comp_ID]) +  (SELECT isnull(sum([Admin_Balance]),0) FROM [M_Amc_Offer] group by [Comp_ID])) end) as Advance, " +
            //" (case when ((SELECT isnull(sum([N_Amount]),0) FROM [M_Generate_Bill] group by [Comp_ID]) +  (SELECT isnull(sum([Admin_Balance]),0) FROM [M_Amc_Offer] group by [Comp_ID])) - ((SELECT isnull(sum([Rec_Amount]),0) FROM  [Payment_Received] where [Comp_ID]=[M_Generate_Bill].[Comp_ID])) <= 0 then 0.00 else ((SELECT isnull(sum([N_Amount]),0) FROM [M_Generate_Bill] group by [Comp_ID]) +  (SELECT isnull(sum([Admin_Balance]),0) FROM [M_Amc_Offer] group by [Comp_ID])) - ((SELECT isnull(sum([Rec_Amount]),0) FROM  [Payment_Received] where [Comp_ID]=[M_Generate_Bill].[Comp_ID])) end) as TotalOutStand " +
            //" ,(SELECT [Rec_Date] FROM [Payment_Received] where [Flag]=1 and Row_Id = (Select max(Row_Id) from [Payment_Received] where [Comp_ID]=[Payment_Received].[Comp_ID] and [Flag]=1) and [Comp_ID]=[Payment_Received].[Comp_ID]) as Last_Payment_Date FROM [M_Generate_Bill]  WHERE  (SELECT [Comp_Name] FROM [Comp_Reg] where [Comp_ID]=[M_Generate_Bill].[Comp_ID]) LIKE '%" + Reg.Comp_Name + "%' AND ('' = '" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "')");
            dbCommand = database.GetSqlStringCommand("SELECT [Comp_ID],(SELECT [Comp_Name] FROM [Comp_Reg] where [Comp_ID]=[M_Generate_Bill].[Comp_ID]) as Comp_Name , (SELECT isnull(sum([Rec_Amount]),0) FROM  [Payment_Received] where [Comp_ID]=[M_Generate_Bill].[Comp_ID]) as Total_Paid,  " +
            " (isnull(sum([N_Amount]),0) +  (SELECT isnull(sum([Admin_Balance]),0) FROM [M_Amc_Offer] where [Comp_ID]=[M_Generate_Bill].[Comp_ID]))  as Total_Purchase,(case when ((SELECT isnull(sum([Rec_Amount]),0) FROM  " +
            " [Payment_Received] where [Comp_ID]=[M_Generate_Bill].[Comp_ID]))-(isnull(sum([N_Amount]),0) +  (SELECT isnull(sum([Admin_Balance]),0) FROM [M_Amc_Offer] where [Comp_ID]=[M_Generate_Bill].[Comp_ID])) <= 0 then 0.00 else ((SELECT isnull(sum([Rec_Amount]),0) " +
            " FROM  [Payment_Received] where [Comp_ID]=[M_Generate_Bill].[Comp_ID]))-(isnull(sum([N_Amount]),0) +  (SELECT isnull(sum([Admin_Balance]),0) FROM [M_Amc_Offer] where [Comp_ID]=[M_Generate_Bill].[Comp_ID])) end) as Advance," +
            " (case when (isnull(sum([N_Amount]),0) +  (SELECT isnull(sum([Admin_Balance]),0) FROM [M_Amc_Offer] where [Comp_ID]=[M_Generate_Bill].[Comp_ID])) - ((SELECT isnull(sum([Rec_Amount]),0) FROM  [Payment_Received] " +
            " where [Comp_ID]=[M_Generate_Bill].[Comp_ID])) <= 0 then 0.00 else (isnull(sum([N_Amount]),0) +  (SELECT isnull(sum([Admin_Balance]),0) FROM [M_Amc_Offer] where [Comp_ID]=[M_Generate_Bill].[Comp_ID])) " +
            " - ((SELECT isnull(sum([Rec_Amount]),0) FROM  [Payment_Received] where [Comp_ID]=[M_Generate_Bill].[Comp_ID])) end) as TotalOutStand,ISNULL(CONVERT(VARCHAR,(SELECT [Rec_Date] FROM [Payment_Received] where [Flag]=1 and Row_Id = (Select max(Row_Id) from [Payment_Received] where [Comp_ID]=[M_Generate_Bill].[Comp_ID] and [Flag]=1) " +
            " and [Comp_ID]=[M_Generate_Bill].[Comp_ID])),'-- --') as Last_Payment_Date FROM [M_Generate_Bill]  WHERE  (SELECT [Comp_Name] FROM [Comp_Reg] where [Comp_ID]=[M_Generate_Bill].[Comp_ID]) LIKE '%" + Reg.Comp_Name + "%' AND ('' = '" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "') group by [Comp_ID]");
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet Fill_Payment_Status(Object9420 obj)
        {
            string Qry = "SELECT   Trans_Type as Pay_Type,  Comp_ID,(select Comp_Name from Comp_Reg WHERE Comp_ID = M_Amc_Offer.Comp_ID) as Comp_Name,  (SELECT isnull(sum(Rec_Amount),0)  FROM Payment_Received where (Comp_ID = M_Amc_Offer.Comp_ID) AND (Payment_For = M_Amc_Offer.Trans_Type)) as Total_Paid, " +
            " CONVERT(NUMERIC(18,2),(SUM(Plan_Amount) - SUM(Plan_Discount))  * (1 + ((SELECT    Service_Tax FROM   Tax_Master WHERE  Row_Id = (SELECT    MAX(Row_Id) FROM   Tax_Master))/100))) as Total_Purchase , 0.00 as Advance ,CONVERT(NUMERIC(18,2),(SUM(Plan_Amount) - SUM(Plan_Discount))  * (1 + ((SELECT    Service_Tax FROM   Tax_Master WHERE  Row_Id = (SELECT    MAX(Row_Id) FROM   Tax_Master))/100)))- " +
            " (SELECT isnull(sum(N_Amount),0)  FROM M_Generate_Bill where (Comp_ID = M_Amc_Offer.Comp_ID) AND (Trans_Type = M_Amc_Offer.Trans_Type)) as Outstanding ,ISNULL(CONVERT(VARCHAR,(SELECT [Rec_Date] FROM [Payment_Received] where [Flag]=1  AND Payment_For = M_Amc_Offer.Trans_Type and Row_Id=(Select max(Row_Id) from [Payment_Received] where [Comp_ID] = M_Amc_Offer.[Comp_ID] and [Flag]=1 AND Payment_For = M_Amc_Offer.Trans_Type) and [Comp_ID]= M_Amc_Offer.[Comp_ID])),'-- --') as Last_Payment_Date " +
            " FROM  M_Amc_Offer WHERE Comp_ID = '" + obj.Comp_ID + "' GROUP BY Trans_Type, Comp_ID union ";
            if (chkLabelDetails(obj))
            {
                Qry += "SELECT p.Payment_For as Pay_Type,  p.Comp_ID,(SELECT Comp_Name FROM Comp_Reg where [Comp_ID]=p.Comp_ID) as Comp_Name, isnull(sum(p.Rec_Amount),0) as Total_Paid, (SELECT isnull(sum(t.N_Amount),0.00) FROM [M_Generate_Bill] as t where (t.Comp_ID = p.Comp_ID) AND (t.Trans_Type = p.Payment_For)) as Total_Purchase " +
                " ,abs((CASE WHEN (((SELECT isnull(sum(t.N_Amount),0.00) FROM [M_Generate_Bill] as t where (t.Comp_ID = p.Comp_ID) AND (t.Trans_Type = p.Payment_For)) - (isnull(sum(p.Rec_Amount),0)) )) > 0.00 THEN 0.00 ELSE ((SELECT isnull(sum(t.N_Amount),0.00) FROM [M_Generate_Bill] as t where (t.Comp_ID = p.Comp_ID) AND (t.Trans_Type = p.Payment_For)) - (isnull(sum(p.Rec_Amount),0)) ) END)) as Advance " +
                " ,(case when ((SELECT isnull(sum(t.N_Amount),0.00) FROM [M_Generate_Bill] as t where (t.Comp_ID = p.Comp_ID) AND (t.Trans_Type = p.Payment_For))- (isnull(sum(p.Rec_Amount),0))) < 0.00 then 0.00 else ((SELECT isnull(sum(t.N_Amount),0.00) FROM [M_Generate_Bill] as t where (t.Comp_ID = p.Comp_ID) AND (t.Trans_Type = p.Payment_For))- (isnull(sum(p.Rec_Amount),0))) end) as Outstanding  ,ISNULL(CONVERT(VARCHAR,(SELECT [Rec_Date] FROM [Payment_Received] where [Flag]=1  AND Payment_For = p.Payment_For and Row_Id=(Select max(Row_Id) from [Payment_Received] where [Comp_ID] = p.[Comp_ID] and [Flag]=1  AND Payment_For = p.Payment_For) and [Comp_ID]= p.[Comp_ID])),'-- --') as Last_Payment_Date " +
                " FROM [Payment_Received] AS p where p.Flag=1 AND p.Payment_For = 'Label' AND p.Comp_ID = '" + obj.Comp_ID + "' group by p.Payment_For,p.Comp_ID";
            }
            else
            {
                Qry += "SELECT p.Trans_Type as Pay_Type,  p.Comp_ID  ,(SELECT Comp_Name FROM Comp_Reg where [Comp_ID] = p.Comp_ID) as Comp_Name,  (SELECT isnull(sum([Rec_Amount]),0) FROM  [Payment_Received] where [Comp_ID] = p.[Comp_ID]  AND Flag = 1 AND Payment_By = 'Label') as Total_Paid , (SELECT isnull(sum(t.N_Amount),0.00) FROM [M_Generate_Bill] as t where  (t.Comp_ID = p.Comp_ID) AND (t.Trans_Type = p.Trans_Type)) as Total_Purchase " +
                " ,case when  (SELECT isnull(sum([Rec_Amount]),0) FROM  [Payment_Received] where [Comp_ID] = p.[Comp_ID]  AND Flag = 1  AND Payment_By = 'Label') -  (SELECT isnull(sum(t.N_Amount),0.00) FROM [M_Generate_Bill] as t where  (t.Comp_ID = p.Comp_ID) AND (t.Trans_Type = p.Trans_Type)) <= 0 then 0.000 else (SELECT isnull(sum([Rec_Amount]),0) FROM  [Payment_Received] where [Comp_ID] = p.[Comp_ID]  AND Flag = 1  AND Payment_By = 'Label') -  (SELECT isnull(sum(t.N_Amount),0.00) FROM [M_Generate_Bill] as t where  (t.Comp_ID = p.Comp_ID) AND (t.Trans_Type = p.Trans_Type)) " +
                " end as Advance , case when   (SELECT isnull(sum(t.N_Amount),0.00) FROM [M_Generate_Bill] as t where  (t.Comp_ID = p.Comp_ID) AND (t.Trans_Type = p.Trans_Type)) - (SELECT isnull(sum([Rec_Amount]),0) FROM  [Payment_Received] where [Comp_ID] = p.[Comp_ID]  AND Flag = 1  AND Payment_By = 'Label') <= 0 then 0.000 else (SELECT isnull(sum(t.N_Amount),0.00) FROM [M_Generate_Bill] as t where  (t.Comp_ID = p.Comp_ID) AND (t.Trans_Type = p.Trans_Type)) - (SELECT isnull(sum([Rec_Amount]),0) FROM  [Payment_Received] where [Comp_ID] = p.[Comp_ID]  AND Flag = 1  AND Payment_By = 'Label') " +
                " end as Outstanding ,ISNULL(CONVERT(VARCHAR,(SELECT [Rec_Date] FROM [Payment_Received] where [Flag]=1  AND Payment_For = p.Trans_Type and Row_Id=(Select max(Row_Id) from [Payment_Received] where  [Comp_ID] = p.[Comp_ID] and [Flag]=1  AND Payment_For = p.Trans_Type) and [Comp_ID]= p.[Comp_ID])),'-- --') as Last_Payment_Date   FROM [M_Generate_Bill]  AS p  where p.Trans_Type = 'Label' AND  p.Comp_ID = '" + obj.Comp_ID + "' ";
            }
            dbCommand = database.GetSqlStringCommand(Qry);
            return database.ExecuteDataSet(dbCommand);
        }

        private static bool chkLabelDetails(Object9420 obj)
        {
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Rec_Date] FROM [Payment_Received] WHERE Comp_ID = '" + obj.Comp_ID + "' AND Payment_For = 'Label' AND Flag = 1 ");
            if (ds.Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }

        public static string FindRowID()
        {
            dbCommand = database.GetSqlStringCommand("SELECT (ISNULL(MAX(Row_ID), 0) + 1) FROM M_Amc_Offer");
            return Convert.ToString(database.ExecuteScalar(dbCommand));
        }

        public static DataSet FillLabelPaymentDetails(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT     Row_Id, Rec_Date, Req_Date,(select Comp_Name from Comp_Reg where Comp_Id = Payment_Received.Comp_ID) as Comp_Name, Comp_ID,(select Bank_Name from M_BankAccount where Bank_Id = Payment_Received.Bank_ID) as Bank_Name, Bank_ID, Req_Amount, Rec_Amount, Manu_Remark, Request_No, PayMode, Details, Payment_For, Admin_Remark Payment_By, Flag FROM Payment_Received WHERE Request_No = '" + Reg.Request_No + "' ");
            return database.ExecuteDataSet(dbCommand);
        }

        public static bool CheckOffer(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Amc_Offer_ID FROM M_Amc_Offer WHERE (Trans_Type = '" + Reg.Amt_Type + "') AND (Pro_ID = '" + Reg.Pro_ID + "')");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }
        public static bool CheckDateFrom(Object9420 Amc)
        {
            string Qry = "";
            if (Amc.chkstr != "Update")
                Qry = "";
            else
            {
                if (Amc.Trans_Type == "AMC")
                    Qry = "  AND Amc_Offer_ID NOT IN ('" + Amc.Row_ID + "') "; //AND  Plan_ID NOT IN ('" + Amc.OldPlan_ID + "')
                else
                    Qry = " AND Amc_Offer_ID NOT IN ('" + Amc.Row_ID + "') "; //AND  Plan_ID NOT IN ('" + Amc.OldPromo_Id + "')
            }
            if (Amc.Trans_Type == "AMC")
                dbCommand = database.GetSqlStringCommand("SELECT * FROM  M_Amc_Offer WHERE (IsCancel = 1) AND ('" + Amc.DateFrom.ToString("yyyy/MM/dd") + "' BETWEEN Date_From AND Date_To) AND Pro_ID = '" + Amc.Pro_ID + "' AND Trans_Type = '" + Amc.Trans_Type + "'  " + Qry);
            else
                dbCommand = database.GetSqlStringCommand("SELECT * FROM  M_Amc_Offer WHERE (IsCancel = 1) AND ('" + Amc.PromoDateFrom.ToString("yyyy/MM/dd") + "' BETWEEN Date_From AND Date_To) AND Pro_ID = '" + Amc.Pro_ID + "' AND Trans_Type = '" + Amc.Trans_Type + "'  " + Qry);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }
        public static bool CheckDateTo(Object9420 Amc)
        {
            string Qry = "";
            if (Amc.chkstr != "Update")
                Qry = "";
            else
            {
                if (Amc.Trans_Type == "AMC")
                    Qry = " AND Amc_Offer_ID NOT IN ('" + Amc.Row_ID + "') "; // AND  Plan_ID NOT IN ('" + Amc.OldPlan_ID + "')
                else
                    Qry = " AND Amc_Offer_ID NOT IN ('" + Amc.Row_ID + "') "; //AND  Plan_ID NOT IN ('" + Amc.OldPromo_Id + "')
            }
            if (Amc.Trans_Type == "AMC")
                dbCommand = database.GetSqlStringCommand("SELECT * FROM  M_Amc_Offer WHERE (IsCancel = 1) AND ('" + Amc.DateTo.ToString("yyyy/MM/dd") + "' BETWEEN Date_From AND Date_To) AND Pro_ID = '" + Amc.Pro_ID + "' AND Trans_Type = '" + Amc.Trans_Type + "' " + Qry);
            else
                dbCommand = database.GetSqlStringCommand("SELECT * FROM  M_Amc_Offer WHERE (IsCancel = 1) AND ('" + Amc.PromoDateTo.ToString("yyyy/MM/dd") + "' BETWEEN Date_From AND Date_To) AND Pro_ID = '" + Amc.Pro_ID + "' AND Trans_Type = '" + Amc.Trans_Type + "' " + Qry);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }

        public static bool CheckDateFromDiscount(Object9420 Amc)
        {
            string Qry = "";
            if (Amc.chkstr != "Update")
                Qry = "";
            else
            {
                if (Amc.Trans_Type == "AMC")
                    Qry = " AND  Row_ID NOT IN ('" + Amc.Row_ID + "')";
                else
                    Qry = " AND  Row_ID NOT IN ('" + Amc.Row_ID + "')";
            }
            dbCommand = database.GetSqlStringCommand("SELECT * FROM  M_PlanDiscount WHERE ('" + Amc.DateFrom.ToString("yyyy/MM/dd") + "' BETWEEN Date_From AND Date_To) AND Plan_ID = '" + Amc.Plan_ID + "' AND Trans_Type = '" + Amc.Trans_Type + "'  " + Qry);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }
        public static bool CheckDateToDiscount(Object9420 Amc)
        {
            string Qry = "";
            if (Amc.chkstr != "Update")
                Qry = "";
            else
            {
                if (Amc.Trans_Type == "AMC")
                    Qry = " AND  Row_ID NOT IN ('" + Amc.Row_ID + "')";
                else
                    Qry = " AND  Row_ID NOT IN ('" + Amc.Row_ID + "')";
            }
            dbCommand = database.GetSqlStringCommand("SELECT * FROM  M_PlanDiscount WHERE ('" + Amc.DateTo.ToString("yyyy/MM/dd") + "' BETWEEN Date_From AND Date_To) AND Plan_ID = '" + Amc.Plan_ID + "' AND Trans_Type = '" + Amc.Trans_Type + "' " + Qry);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
                return true;
            else
                return false;
        }

        public static void UpdateProductComments(Object9420 Amc)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [Pro_Reg] SET [Comments] = '" + Amc.Comment_Txt + "'  WHERE [Pro_ID] = '" + Amc.Pro_ID + "'");
            DataSet ds = database.ExecuteDataSet(dbCommand);
        }
        public static void UpdateProductCommentsH(Object9420 Amc)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [M_Amc_Offer] SET [Update_Flag_H] = " + Amc.Doc_Flag + "  WHERE ([Pro_ID] = '" + Amc.Pro_ID + "') AND (Trans_Type = '" + Amc.Trans_Type + "') AND (Row_ID = '" + Amc.Row_ID + "') ");
            //dbCommand = database.GetSqlStringCommand("UPDATE [Pro_Reg] SET [Update_Flag_H] = " + Amc.Doc_Flag + "  WHERE [Pro_ID] = '" + Amc.Pro_ID + "'");
            DataSet ds = database.ExecuteDataSet(dbCommand);
        }
        public static void UpdateProductCommentsE(Object9420 Amc)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE [M_Amc_Offer] SET [Update_Flag_E] = " + Amc.Doc_Flag + "  WHERE [Pro_ID] = '" + Amc.Pro_ID + "' AND (Trans_Type = '" + Amc.Trans_Type + "') AND (Row_ID = '" + Amc.Row_ID + "') ");
            //dbCommand = database.GetSqlStringCommand("UPDATE [Pro_Reg] SET [Update_Flag_E] = " + Amc.Doc_Flag + "  WHERE [Pro_ID] = '" + Amc.Pro_ID + "'");
            DataSet ds = database.ExecuteDataSet(dbCommand);
        }

        public static void SetPrefixAndStart()
        {
            dbCommand = database.GetSqlStringCommand("SELECT Comp_ID FROM Courier_Dispatch_Master");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count == 0)
                SetPreFixStart(101, "Dispatch");
            ds.Reset();
            dbCommand = database.GetSqlStringCommand("SELECT Row_ID FROM M_Label_Request");
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count == 0)
                SetPreFixStart(101, "LabelTracking");
            ds.Reset();
            dbCommand = database.GetSqlStringCommand("SELECT Comp_ID FROM Payment_Received");
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count == 0)
                SetPreFixStart(101, "PayRequest");
            ds.Reset();
            dbCommand = database.GetSqlStringCommand("SELECT Comp_ID FROM M_Generate_Bill");
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count == 0)
                SetPreFixStart(1001, "Invoice");
            ds.Reset();
            dbCommand = database.GetSqlStringCommand("SELECT Row_ID FROM  Pro_Reg");
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count == 0)
            {
                dbCommand = database.GetSqlStringCommand("UPDATE [Code_Gen] SET PrPrefix = 'AA' , [PrStart] = 100 WHERE [Prfor]= 'Product'");
                database.ExecuteNonQuery(dbCommand);
            }
            ds.Reset();
            dbCommand = database.GetSqlStringCommand("SELECT Comp_ID FROM  Comp_Reg");
            ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count == 0)
                SetPreFixStart(1001, "Company");
        }
        public static void SetPreFixStart(int start, string Prefix)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE Code_Gen  SET PrStart = " + start + " WHERE (Prfor = '" + Prefix + "')");
            database.ExecuteNonQuery(dbCommand);
        }

        public static void FillDiscountInfo(Object9420 Reg)
        {
            if (Reg.Trans_Type == "AMC")
                dbCommand = database.GetSqlStringCommand("SELECT Plan_ID, Plan_Name,Plan_Amount,Plan_Time FROM M_Plan WHERE Flag = 1 AND (''='" + Reg.Plan_ID + "' OR Plan_ID = '" + Reg.Plan_ID + "')");
            else
                dbCommand = database.GetSqlStringCommand("SELECT Promo_ID as Plan_ID, Promo_Name as Plan_Name,Amount as Plan_Amount,Time_Days as Plan_Time  FROM M_Promotional WHERE Flag = 1 AND (''='" + Reg.Plan_ID + "' OR Promo_ID = '" + Reg.Plan_ID + "')");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Plan_Name = ds.Tables[0].Rows[0]["Plan_Name"].ToString();
                Reg.Plan_Amount = Convert.ToDouble(ds.Tables[0].Rows[0]["Plan_Amount"].ToString());
                Reg.Plan_Time = Convert.ToInt32(ds.Tables[0].Rows[0]["Plan_Time"].ToString());
            }
        }
        public static DataSet FillPlan(Object9420 Reg)
        {
            if (Reg.Trans_Type == "AMC")
                dbCommand = database.GetSqlStringCommand("SELECT Plan_ID, Plan_Name,Plan_Amount FROM M_Plan WHERE Flag = 1 AND (''='" + Reg.Plan_ID + "' OR Plan_ID = '" + Reg.Plan_ID + "')");
            else
                dbCommand = database.GetSqlStringCommand("SELECT Promo_ID as Plan_ID, Promo_Name as Plan_Name,Amount as Plan_Amount FROM M_Promotional WHERE Flag = 1 AND (''='" + Reg.Plan_ID + "' OR Promo_ID = '" + Reg.Plan_ID + "')");
            return database.ExecuteDataSet(dbCommand);
        }

        public static string GetPartnerId(string p)
        {
            dbCommand = database.GetSqlStringCommand("SELECT     PrPrefix + '-' + CONVERT(VARCHAR, PrStart) FROM  Code_Gen WHERE     (Prfor = '" + p + "')");
            return database.ExecuteScalar(dbCommand).ToString();
        }
        public static void SetPartnerId(string p)
        {
            dbCommand = database.GetSqlStringCommand("UPDATE Code_Gen  SET PrStart = PrStart + 1  WHERE (Prfor = '" + p + "')");
            database.ExecuteNonQuery(dbCommand);
        }

        public static void InsertSendQuery(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("INSERT INTO [SendQueryDetails]([Name],[Mobile_No],[Email],[Query_Txt]) VALUES ('" + obj.Name + "','" + obj.Mobile_No + "','" + obj.Email + "','" + obj.Message + "')");
            database.ExecuteNonQuery(dbCommand);
        }

        public static void SaveLetUsTalk(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("INSERT INTO [LetUsTalk_Reg]([Name],[Email],Mobileno,[Comments]) VALUES ('" + obj.Name + "','" + obj.Email + "','" + obj.cmobile + "','" + obj.Comments + "')");
            database.ExecuteNonQuery(dbCommand);
        }
        public static DataSet GetNewsLettersEmails(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Row_ID, Email, Status FROM NewsLetters_Subscription WHERE (''='" + Reg.Email + "' or Email = '" + Reg.Email + "') AND Staus = 1");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet GetNewsLettersEmail(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Row_ID, Email, Status,(case when Status = 1 then 'Subscribe' else 'Un-subscribe' end) as ST FROM NewsLetters_Subscription WHERE (''='" + Reg.Email + "' or Email = '" + Reg.Email + "')");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet GetNewsLettersEmailSearch(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Row_ID, Email, Status,(case when Status = 1 then 'Subscribe' else 'Un-subscribe' end) as ST FROM NewsLetters_Subscription WHERE Email like '%" + Reg.Email + "%' ");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet GetLetsTalkSearch(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT RowID, Name, Email, Comments, Entry_Date  FROM  LetUsTalk_Reg WHERE Email like '%" + Reg.Email + "%' AND Name like '%" + Reg.Name + "%' ");
            return database.ExecuteDataSet(dbCommand);
        }

        public static void InsertNewsLetterSubscription(Object9420 Reg)
        {
            if (Reg.DML == "I")
                dbCommand = database.GetSqlStringCommand("INSERT INTO NewsLetters_Subscription (Email, Status) VALUES ('" + Reg.Email + "'," + Reg.Status + ")");
            else
                dbCommand = database.GetSqlStringCommand("UPDATE NewsLetters_Subscription SET Status = " + Reg.Status + " where (Email = '" + Reg.Email + "')");
            database.ExecuteNonQuery(dbCommand);
        }

        public static DataSet GetNewsLetters(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT NewsLettersID, Subject+'  '+convert(varchar,Entry_Date) as SubjectNm,Subject, [Content], Entry_Date, Status FROM NewsLetters WHERE (''='" + Reg.NewsLetterID + "' or NewsLettersID = '" + Reg.NewsLetterID + "')");
            return database.ExecuteDataSet(dbCommand);
        }

        public static void SaveNewsLetters(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("INSERT INTO [NewsLetters] ([NewsLettersID],[Subject],[Content],[Entry_Date]) VALUES ('" + Reg.NewsLetterID + "','" + Reg.NewsSubject + "','" + Reg.NewsContent + "','" + Convert.ToDateTime(DataProvider.LocalDateTime.Now).ToString("yyyy/MM/dd hh:mm:ss tt") + "')");
            database.ExecuteNonQuery(dbCommand);
        }

        public static DataSet FillGrdVwNewsLetterDet(Object9420 Reg, string StrAll)
        {
            dbCommand = database.GetSqlStringCommand("SELECT   c.NewsLettersID, c.Email, c.Entry_Date, m.Subject, m.[Content] FROM NewsLetters_Subscription_Details AS c INNER JOIN NewsLetters AS m ON c.NewsLettersID = m.NewsLettersID  WHERE  c.Email LIKE '%" + Reg.Email + "%' " + StrAll);
            return database.ExecuteDataSet(dbCommand);
        }

        public static bool FindCheckedStatus(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Use_Type,Pro_ID FROM  M_Code with (nolock) WHERE Code1 = '" + Reg.Received_Code1 + "' AND Code2 =  '" + Reg.Received_Code2 + "'");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                if (ds.Tables[0].Rows[0]["Use_Type"].ToString() != "L")
                {
                    Reg.Comp_type = "D";
                    dbCommand = database.GetSqlStringCommand("SELECT Status FROM  Comp_Reg WHERE Comp_ID = (SELECT Comp_ID FROM Pro_Reg WHERE Pro_ID = '" + ds.Tables[0].Rows[0]["Pro_ID"].ToString() + "') ");
                    DataSet ds1 = database.ExecuteDataSet(dbCommand);
                    if (ds1.Tables[0].Rows.Count > 0)
                    {
                        if (ds1.Tables[0].Rows[0]["Status"].ToString() != "1")
                            return true;
                        else
                            return false;
                    }
                    else
                        return false;
                }
                else
                {
                    Reg.Comp_type = "L";
                    return false;
                }
            }
            else
                return false;
        }



        public static void FindAmcOfferId(Object9420 obj)
        {
            dbCommand = database.GetSqlStringCommand("SELECT MAX(Amc_Offer_ID) as Amc_Offer_ID FROM  M_Amc_Offer WHERE (Pro_ID = '" + obj.Pro_ID + "') AND (Trans_Type='" + obj.Trans_Type + "')");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
                obj.Amc_Offer_ID = Convert.ToInt32(ds.Tables[0].Rows[0]["Amc_Offer_ID"].ToString());
        }

        public static DataSet FillAmcOfferInvoiceDetails(string Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT     Row_ID, Comp_ID,(SELECT Comp_Name FROM Comp_Reg Where Comp_ID = M_Amc_Offer.Comp_ID) as Comp_Name, Pro_ID,(SELECT Pro_Name FROM Pro_Reg Where Pro_ID = M_Amc_Offer.Pro_ID) as Pro_Name, Plan_ID, Plan_Name, Plan_Amount, Date_From, Date_To, Trans_Type,Status as Flag, Status, Plan_Discount, Admin_Balance, Manu_Balance, Entry_Date,  " +
            " Comments,'Bill/Invoice/'+convert(varchar,Row_ID)+'.pdf' as FilePath FROM M_Amc_Offer " + Reg);
            DataSet ds = database.ExecuteDataSet(dbCommand);
            return ds;
        }

        public static void MasterPasteLabels(Object9420 obj)
        {
            Int64 ExecuteCounter;
            Int64 counter = obj.NoofCodes - 1;
            obj.ActNoofCodes = Convert.ToInt32(counter);
            //if (counter == 0)
            //    counter = 1;
            obj.intFlag = 0;
            obj.Series_SerialTo = obj.Series_Serial;
        p:
            dbCommand = database.GetStoredProcCommand("PasteLabel");//GenerateCode
            database.AddInParameter(dbCommand, "Batch_No", DbType.Int64, obj.Batch_No);
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, obj.Pro_ID);
            database.AddInParameter(dbCommand, "Series_Order", DbType.Int64, obj.Series_Order);
            database.AddInParameter(dbCommand, "Series_Serial", DbType.Int64, obj.Series_Serial);
            database.AddInParameter(dbCommand, "NoOfRec", DbType.Int64, counter);
            database.AddInParameter(dbCommand, "intFlag", DbType.Int64, obj.intFlag);
            try
            {
                database.ExecuteNonQuery(dbCommand);
            }
            catch
            {
                ExecuteCounter = Convert.ToInt64(SQL_DB.ExecuteScalar("select count(row_id) from m_code WHERE  Batch_No = '" + obj.Batch_No + "' AND (ISNULL(ScrapeFlag,0)=0)  "));
                if (ExecuteCounter < Convert.ToInt32(obj.ActNoofCodes))
                {
                    obj.ExcNoofCodes = Convert.ToInt32(ExecuteCounter);
                    obj.Series_Serial = obj.Series_SerialTo + Convert.ToInt32(ExecuteCounter);
                    counter = Convert.ToInt32(obj.ActNoofCodes) - ExecuteCounter;
                    goto p;
                }
            }
        }

        public static void TaxMasterSetting(Object9420 obj)
        {
            dbCommand = database.GetStoredProcCommand("PROC_InsertUpdateTaxMaster");
            database.AddInParameter(dbCommand, "TaxSet_ID", DbType.String, obj.TaxSet_ID);
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, obj.Comp_ID);
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, obj.Pro_ID);
            database.AddInParameter(dbCommand, "Label_ServiceTax", DbType.Double, obj.Label_ServiceTax);
            database.AddInParameter(dbCommand, "Label_Vat", DbType.Double, obj.Label_Vat);
            database.AddInParameter(dbCommand, "AMC_ServiceTax", DbType.Double, obj.AMC_ServiceTax);
            database.AddInParameter(dbCommand, "AMC_Vat", DbType.Double, obj.AMC_Vat);
            database.AddInParameter(dbCommand, "Offer_ServiceTax", DbType.Double, obj.Offer_ServiceTax);
            database.AddInParameter(dbCommand, "Offer_Vat", DbType.Double, obj.Offer_Vat);
            database.AddInParameter(dbCommand, "Date_From", DbType.DateTime, obj.DateFrom);
            database.AddInParameter(dbCommand, "Date_To", DbType.DateTime, obj.DateTo);
            database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, obj.Entry_Date);
            database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
            database.ExecuteNonQuery(dbCommand);
        }

        public static DataSet FillGridVwTaxMaster(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT tm.Row_Id, tm.TaxSet_ID,p.Dispatch_Location, tm.Comp_ID, tm.Pro_ID, tm.Label_ServiceTax, tm.Label_Vat, tm.AMC_ServiceTax, tm.AMC_Vat,tm.Offer_ServiceTax, tm.Offer_Vat, tm.Date_From, tm.Date_To, tm.Entry_Date,p.Pro_Name, r.Comp_Name, c.Category_Name FROM Tax_Master_Info AS tm INNER JOIN Comp_Reg AS r ON tm.Comp_ID = r.Comp_ID INNER JOIN Pro_Reg AS p ON tm.Pro_ID = p.Pro_ID INNER JOIN  Category_Master AS c ON r.Comp_Cat_Id = c.Category_ID WHERE r.Comp_Name LIKE '%" + Reg.Comp_Name + "%' AND (''='" + Reg.TaxSet_ID + "' OR tm.TaxSet_ID = '" + Reg.TaxSet_ID + "') ORDER BY tm.Row_Id "); dbCommand.CommandTimeout = 5000;
            return database.ExecuteDataSet(dbCommand);
        }

        public static void FillScrapInfo(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Series_From, Series_To,Pro_ID FROM (SELECT  Series_From, Series_To,Pro_ID ,substring(substring(Series_From,6,len(Series_From)-5),0,charindex('-',substring(Series_From,6,len(Series_From)-5))) as Sr_Order ,substring(substring(Series_From,6,len(Series_From)-5),charindex('-',substring(Series_From,6,len(Series_From)-5))+1,len(substring(Series_From,6,len(Series_From)-5))-charindex('-',substring(Series_From,6,len(Series_From)-5))) as Sr_Serial FROM Courier_Disp_ProInfo WHERE (Courier_Disp_ID = '" + Reg.Courier_Disp_ID + "')) AS Disp order by Sr_Order  ");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                Reg.Series_From = ds.Tables[0].Rows[0]["Series_From"].ToString();
                Reg.Series_To = ds.Tables[0].Rows[ds.Tables[0].Rows.Count - 1]["Series_To"].ToString();
                Reg.Pro_ID = ds.Tables[0].Rows[0]["Pro_ID"].ToString();
            }
        }

        public static bool CheckForGenerateInvoice(string p)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Pro_ID as cnt FROM Pro_Reg WHERE Pro_ID = '" + p + "' AND Doc_Flag = 1 AND Sound_Flag = 1");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            dbCommand = database.GetSqlStringCommand("SELECT Pro_ID FROM M_Invoice WHERE Pro_ID = '" + p + "' ");
            DataSet ds1 = database.ExecuteDataSet(dbCommand);
            if (ds1.Tables[0].Rows.Count > 0)
                return true;
            else
            {
                if (ds.Tables[0].Rows.Count > 0)
                    return true;
                else
                    return false;
            }

        }

        #region Generate Invoice For New Logic and Final Code
        public static void CreateInvoices(Object9420 Inv)
        {
            Inv.Invoice_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt"));
            if (Inv.Subscribe_Id != null)
            {
                DataSet ds = function9420.FindServiceInfo(Inv);
                Inv.Head_Name = "AMC";
                //********************** Generate Invoice Number ************************//
                Inv.Invoice_ID = GetInvoiceID(Inv);

                Inv.Comp_ID = ds.Tables[0].Rows[0]["Comp_ID"].ToString();
                Inv.Pro_ID = ds.Tables[0].Rows[0]["Pro_ID"].ToString();
                Inv.Plan_ID = ds.Tables[0].Rows[0]["Plan_ID"].ToString(); // just like Plan for Amc and Offer Invoice
                Inv.Head_ID = ds.Tables[0].Rows[0]["Subscribe_Id"].ToString(); // just like Plan for Amc and Offer Invoice

                Inv.G_Amount = Convert.ToDouble(ds.Tables[0].Rows[0]["PlanSalePrice"]);
                double p1 = Convert.ToDouble(ds.Tables[0].Rows[0]["PlanMasterPrice"]);
                if ((p1 - Inv.G_Amount) > 0)
                {
                    Inv.Discount = p1 - Inv.G_Amount;
                    Inv.G_Amount = p1;
                }
                else
                    Inv.Discount = 0;
                Inv.G_Amount = Inv.G_Amount - Inv.Discount; // Net G_Amount after plan_discount

                /********** For Select Tax Seting ************/
                DataSet dsn = GetTaxesDetails(Inv);
                Inv.Head_Name = ds.Tables[0].Rows[0]["Service_ID"].ToString();

                Inv.Service_Tax = Convert.ToDouble(dsn.Tables[0].Rows[0]["ServiceTax"]);
                Inv.Vat_Tax = Convert.ToDouble(dsn.Tables[0].Rows[0]["VAT"]);

                Inv.Service_Tax_Value = Math.Round(((Inv.G_Amount * Inv.Service_Tax) / 100), 2);
                Inv.Vat_Tax_Value = Math.Round(((Inv.G_Amount * Inv.Vat_Tax) / 100), 2);

                Inv.N_Amount = Inv.G_Amount + Inv.Service_Tax_Value + Inv.Vat_Tax_Value; // Net Amount after calculate service tax and vat tax(G_Amount + Service_Tax_Value + Vat_Tax_Value)

                DataSet dds = GetLastPaidDate(Inv);
                if (dds.Tables[0].Rows.Count > 0)
                {
                    Inv.Last_Payment_Receipt = dds.Tables[0].Rows[0]["Request_No"].ToString();
                    Inv.Last_Paid_Date = Convert.ToDateTime(dds.Tables[0].Rows[0]["Rec_Date"].ToString());
                    Inv.Last_Paid_Amount = Convert.ToDouble(dds.Tables[0].Rows[0]["Rec_Amount"].ToString());
                }
                Inv.Availabl_Balance = FindNetAvailablBalance(Inv); // Get over all available balance
                if (Inv.TransType == "Upgrade")
                {
                    DataTable dt = FindOldInvoiceValue(Inv).Tables[0];
                    Inv.Upgrade_Amount = Convert.ToDouble(dt.Rows[0]["N_Amount"]);
                    Inv.Upgrade_From = dt.Rows[0]["Plan_Name"].ToString() + "[" + dt.Rows[0]["Invoice_ID"].ToString() + "]";
                }
                else
                {
                    Inv.Upgrade_Amount = 0.00;
                    Inv.Upgrade_From = null;
                }
                Inv.OldUpgrade_Amount = FindNetUpgradeBalance(Inv); // Get over all available upgrade balance
                //if (Inv.Availabl_Balance >= 0.0)
                Inv.Balance = Inv.Availabl_Balance - (Inv.N_Amount - Inv.Upgrade_Amount); // Current Balance According to Product for credit balance
                if (Inv.Balance <= 0.0)
                    Inv.Net_Pay = Math.Abs(Inv.Balance); // net pay amount balance in this Invoice  
                Inv.Status = 1;
                // *********** Insert data In Invoice Master and Set Invoice ID ********************//
                InsertInvoiceMaster(Inv);

                // create invoice pdf
            }
        }
        public static void CreateRefundInvoice(Object9420 Inv)
        {
            Inv.Invoice_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt"));
            //************** Fill data for generate Invoice From M_Invoice ******************//                       
            DataSet ds1 = GetPlanInfo(Inv);
            if (ds1.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
                {
                    Inv.Head_Name = ds1.Tables[0].Rows[i]["Trans_Type"].ToString();

                    //********************** Generate Invoice Number ************************//
                    Inv.Invoice_ID = GetInvoiceID(Inv);

                    Inv.Comp_ID = ds1.Tables[0].Rows[i]["Comp_ID"].ToString();
                    Inv.Pro_ID = ds1.Tables[0].Rows[i]["Pro_ID"].ToString();
                    Inv.Plan_ID = ds1.Tables[0].Rows[i]["Plan_ID"].ToString(); // just like Plan for Amc and Offer Invoice
                    Inv.Head_ID = ds1.Tables[0].Rows[i]["Amc_Offer_ID"].ToString(); // just like Plan for Amc and Offer Invoice

                    Inv.G_Amount = Convert.ToDouble(ds1.Tables[0].Rows[i]["Plan_Amount"]) + Convert.ToDouble(ds1.Tables[0].Rows[i]["Plan_Discount"]);
                    Inv.Discount = Convert.ToDouble(ds1.Tables[0].Rows[i]["Plan_Discount"]);
                    Inv.CDiscount = Math.Round((Convert.ToDouble(ds1.Tables[0].Rows[i]["Plan_Discount"]) * 100 / Inv.G_Amount), 2);



                    Inv.G_Amount = Inv.G_Amount - Inv.Discount; // Net G_Amount after plan_discount
                    Inv.MG_Amount = Inv.G_Amount; // Main G_Amount;

                    if (Inv.Time_Days > 0)
                    {
                        Inv.G_Amount = Math.Round((Inv.G_Amount / Inv.TotalTime) * Inv.Time_Days, 2);
                        Inv.G_Amount = Inv.MG_Amount - Inv.G_Amount;
                    }
                    else
                        Inv.G_Amount = Inv.MG_Amount;

                    Inv.Discount = Math.Round(((Inv.MG_Amount * Inv.CDiscount) / 100), 2);

                    // Find Applied Service Tax and Vat                    
                    Inv.Service_Tax = (Convert.ToDouble(ds1.Tables[0].Rows[i]["Service_Tax"]) * 100) / Inv.MG_Amount;
                    Inv.Vat_Tax = (Convert.ToDouble(ds1.Tables[0].Rows[i]["VAT"]) * 100) / Inv.MG_Amount;


                    Inv.Service_Tax_Value = Math.Round(((Inv.G_Amount * Inv.Service_Tax) / 100), 2);
                    Inv.Vat_Tax_Value = Math.Round(((Inv.G_Amount * Inv.Vat_Tax) / 100), 2);

                    Inv.N_Amount = Inv.G_Amount + Inv.Service_Tax_Value + Inv.Vat_Tax_Value; // Net Amount after calculate service tax and vat tax(G_Amount + Service_Tax_Value + Vat_Tax_Value)


                    Inv.Refund_From = ds1.Tables[0].Rows[i]["Invoice_ID"].ToString();

                    DataSet dds = GetLastPaidDate(Inv);
                    if (dds.Tables[0].Rows.Count > 0)
                    {
                        Inv.Last_Payment_Receipt = dds.Tables[0].Rows[0]["Request_No"].ToString();
                        Inv.Last_Paid_Date = Convert.ToDateTime(dds.Tables[0].Rows[0]["Rec_Date"].ToString());
                        Inv.Last_Paid_Amount = Convert.ToDouble(dds.Tables[0].Rows[0]["Rec_Amount"].ToString());
                    }
                    Inv.Availabl_Balance = FindNetAvailablBalance(Inv); // Get over all available balance
                    if (Inv.TransType == "Upgrade")
                    {
                        DataTable dt = FindOldInvoiceValue(Inv).Tables[0];
                        Inv.Upgrade_Amount = Convert.ToDouble(dt.Rows[0]["N_Amount"]);
                        Inv.Upgrade_From = dt.Rows[0]["Plan_Name"].ToString() + "[" + dt.Rows[0]["Invoice_ID"].ToString() + "]";
                    }
                    else
                    {
                        Inv.Upgrade_Amount = 0.00;
                        Inv.Upgrade_From = null;
                    }
                    Inv.OldUpgrade_Amount = FindNetUpgradeBalance(Inv); // Get over all available upgrade balance

                    Inv.G_Amount = -Inv.G_Amount;
                    Inv.Discount = -Inv.Discount;
                    Inv.Service_Tax_Value = -Inv.Service_Tax_Value;
                    Inv.Vat_Tax_Value = -Inv.Vat_Tax_Value;
                    Inv.N_Amount = -Inv.N_Amount;

                    Inv.Balance = Inv.Availabl_Balance - (Inv.N_Amount - Inv.Upgrade_Amount); // Current Balance According to Product for credit balance
                    if (Inv.Balance <= 0.0)
                        Inv.Net_Pay = Math.Abs(Inv.Balance); // net pay amount balance in this Invoice                                         

                    Inv.Status = 1;
                    // *********** Insert data In Invoice Master and Set Invoice ID ********************//
                    InsertInvoiceMaster(Inv);

                }
            }

        }
        public static void CreateInvoice(Object9420 Inv)
        {
            Inv.Invoice_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt"));
            //************** Fill data for generate Invoice From M_Amc_Offer ******************//           
            DataSet ds1 = function9420.FindAmcOfferInfo(Inv);
            //DataSet ds1 = function9420.FillAmcOfferDetails(Reg);
            if (ds1.Tables[0].Rows.Count > 0)
            {
                for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
                {
                    Inv.Head_Name = ds1.Tables[0].Rows[i]["Trans_Type"].ToString();

                    //********************** Generate Invoice Number ************************//
                    Inv.Invoice_ID = GetInvoiceID(Inv);

                    Inv.Comp_ID = ds1.Tables[0].Rows[i]["Comp_ID"].ToString();
                    Inv.Pro_ID = ds1.Tables[0].Rows[i]["Pro_ID"].ToString();
                    Inv.Plan_ID = ds1.Tables[0].Rows[i]["Plan_ID"].ToString(); // just like Plan for Amc and Offer Invoice
                    Inv.Head_ID = ds1.Tables[0].Rows[i]["Amc_Offer_ID"].ToString(); // just like Plan for Amc and Offer Invoice

                    Inv.G_Amount = Convert.ToDouble(ds1.Tables[0].Rows[i]["Plan_Amount"]);
                    Inv.Discount = Convert.ToDouble(ds1.Tables[0].Rows[i]["Plan_Discount"]);

                    Inv.G_Amount = Inv.G_Amount - Inv.Discount; // Net G_Amount after plan_discount

                    DataSet dsn = GetTaxesDetails(Inv);
                    Inv.Service_Tax = Convert.ToDouble(dsn.Tables[0].Rows[0]["ServiceTax"]);
                    Inv.Vat_Tax = Convert.ToDouble(dsn.Tables[0].Rows[0]["VAT"]);

                    Inv.Service_Tax_Value = Math.Round(((Inv.G_Amount * Inv.Service_Tax) / 100), 2);
                    Inv.Vat_Tax_Value = Math.Round(((Inv.G_Amount * Inv.Vat_Tax) / 100), 2);

                    Inv.N_Amount = Inv.G_Amount + Inv.Service_Tax_Value + Inv.Vat_Tax_Value; // Net Amount after calculate service tax and vat tax(G_Amount + Service_Tax_Value + Vat_Tax_Value)

                    DataSet dds = GetLastPaidDate(Inv);
                    if (dds.Tables[0].Rows.Count > 0)
                    {
                        Inv.Last_Payment_Receipt = dds.Tables[0].Rows[0]["Request_No"].ToString();
                        Inv.Last_Paid_Date = Convert.ToDateTime(dds.Tables[0].Rows[0]["Rec_Date"].ToString());
                        Inv.Last_Paid_Amount = Convert.ToDouble(dds.Tables[0].Rows[0]["Rec_Amount"].ToString());
                    }
                    Inv.Availabl_Balance = FindNetAvailablBalance(Inv); // Get over all available balance
                    if (Inv.TransType == "Upgrade")
                    {
                        DataTable dt = FindOldInvoiceValue(Inv).Tables[0];
                        Inv.Upgrade_Amount = Convert.ToDouble(dt.Rows[0]["N_Amount"]);
                        Inv.Upgrade_From = dt.Rows[0]["Plan_Name"].ToString() + "[" + dt.Rows[0]["Invoice_ID"].ToString() + "]";
                    }
                    else
                    {
                        Inv.Upgrade_Amount = 0.00;
                        Inv.Upgrade_From = null;
                    }
                    Inv.OldUpgrade_Amount = FindNetUpgradeBalance(Inv); // Get over all available upgrade balance
                    //if (Inv.Availabl_Balance >= 0.0)
                    Inv.Balance = Inv.Availabl_Balance - (Inv.N_Amount - Inv.Upgrade_Amount); // Current Balance According to Product for credit balance
                    if (Inv.Balance <= 0.0)
                        Inv.Net_Pay = Math.Abs(Inv.Balance); // net pay amount balance in this Invoice  
                    Inv.Status = 1;
                    // *********** Insert data In Invoice Master and Set Invoice ID ********************//
                    InsertInvoiceMaster(Inv);

                }
            }
        }

        private static double FindNetUpgradeBalance(Object9420 Inv)
        {
            dbCommand = database.GetSqlStringCommand("SELECT ISNULL(SUM(Upgrade_Amount),0.00) as Upgrade_Amount FROM M_Invoice WHERE (Pro_ID = '" + Inv.Pro_ID + "') AND  Status = 1  ");
            return Convert.ToDouble(database.ExecuteScalar(dbCommand));
        }

        private static DataSet FindOldInvoiceValue(Object9420 Inv)
        {
            if (Inv.Subscribe_Id != "")
                dbCommand = database.GetSqlStringCommand("SELECT ISNULL(N_Amount,0.00) as N_Amount,Invoice_ID, Head_ID,,(SELECT PlanName FROM M_ServiceSubscription WHERE (Subscribe_Id = M_Invoice.Head_ID)) as Plan_Name FROM M_Invoice WHERE (Pro_ID = '" + Inv.Pro_ID + "') AND  Head_ID = '" + Inv.Subscribe_Id + "' AND Head_Name = '" + Inv.Head_Name + "' ");
            else
                dbCommand = database.GetSqlStringCommand("SELECT ISNULL(N_Amount,0.00) as N_Amount,Invoice_ID, Head_ID,(SELECT Plan_Name FROM M_Amc_Offer WHERE (Amc_Offer_ID = M_Invoice.Head_ID)) as Plan_Name FROM M_Invoice WHERE (Pro_ID = '" + Inv.Pro_ID + "') AND  Head_ID = '" + Inv.TransRow_ID + "' AND Head_Name = '" + Inv.Head_Name + "' ");
            return database.ExecuteDataSet(dbCommand);
        }

        private static void InsertInvoiceMaster(Object9420 Inv)
        {
            try
            {
                LogManager.WriteExe("invoice section passed 11A2 Loop ended nsert ended t1");
                dbCommand = database.GetStoredProcCommand("PROC_InsertMasterInvoice");
                database.AddInParameter(dbCommand, "Invoice_ID", DbType.String, Inv.Invoice_ID);
                database.AddInParameter(dbCommand, "Invoice_Date", DbType.DateTime, Convert.ToDateTime(Inv.Invoice_Date).ToString("yyyy/MM/dd hh:mm:ss tt"));
                database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Inv.Comp_ID);
                database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Inv.Pro_ID); // for Amc Pro_Id replace Plan_ID 
                database.AddInParameter(dbCommand, "Head_ID", DbType.String, Inv.Head_ID);
                database.AddInParameter(dbCommand, "Head_Name", DbType.String, Inv.Head_Name);
                database.AddInParameter(dbCommand, "G_Amount", DbType.Double, Inv.G_Amount);
                database.AddInParameter(dbCommand, "Discount", DbType.Double, Inv.Discount);
                database.AddInParameter(dbCommand, "Service_Tax", DbType.Double, Inv.Service_Tax_Value);
                database.AddInParameter(dbCommand, "VAT", DbType.Double, Inv.Vat_Tax_Value);
                database.AddInParameter(dbCommand, "N_Amount", DbType.Double, Inv.N_Amount);
                database.AddInParameter(dbCommand, "Refund_From", DbType.String, Inv.Refund_From);
                database.AddInParameter(dbCommand, "Upgrade_From", DbType.String, Inv.Upgrade_From);
                database.AddInParameter(dbCommand, "Upgrade_Amount", DbType.Double, Inv.Upgrade_Amount);
                database.AddInParameter(dbCommand, "Last_Payment_Receipt", DbType.String, Inv.Last_Payment_Receipt);
                database.AddInParameter(dbCommand, "Last_Paid_Amount", DbType.Double, Inv.Last_Paid_Amount);
                if (Inv.Last_Paid_Amount != 0.0)
                    database.AddInParameter(dbCommand, "Last_Paid_Date", DbType.DateTime, Convert.ToDateTime(Inv.Last_Paid_Date).ToString("yyyy/MM/dd hh:mm:ss tt"));
                else
                    database.AddInParameter(dbCommand, "Last_Paid_Date", DbType.String, null);
                database.AddInParameter(dbCommand, "Balance", DbType.Double, Inv.Balance);
                database.AddInParameter(dbCommand, "Net_Pay", DbType.Double, Inv.Net_Pay);
                database.AddInParameter(dbCommand, "Status", DbType.Int32, Inv.Status);
                database.ExecuteNonQuery(dbCommand);

                // GenerateCrystalInvoice.Invoice.showReport(Inv.Head_ID, Inv.Invoice_ID, Inv.Head_Name, Inv);

                LogManager.WriteExe("invoice section passed 11A2 Loop ended nsert ended t2");
            }
            catch (Exception ex)
            {
                LogManager.WriteExe("arb1111" + ex.Message);

            }
        }

        public static double FindNetAvailablBalance(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  ISNULL(SUM(Rec_Amount),0.00) AS Rec_Amount FROM Payment_Received WHERE Pro_ID = '" + Reg.Pro_ID + "' AND Flag = 1 ");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            dbCommand = database.GetSqlStringCommand("SELECT ISNULL(SUM(N_Amount),0.00) - ISNULL(SUM(Upgrade_Amount),0.00) AS N_Amount FROM  M_Invoice WHERE Pro_ID = '" + Reg.Pro_ID + "' AND Status = 1");
            DataSet ds1 = database.ExecuteDataSet(dbCommand);
            if ((ds1.Tables[0].Rows.Count == 0) && (ds.Tables[0].Rows.Count == 0))
                return 0.00;
            else
            {
                if (ds1.Tables[0].Rows.Count == 0)
                    return Convert.ToDouble(ds.Tables[0].Rows[0]["Rec_Amount"]);
                else
                {
                    if (ds.Tables[0].Rows.Count == 0)
                        return Convert.ToDouble(Convert.ToDouble(0.00) - Convert.ToDouble(ds1.Tables[0].Rows[0]["N_Amount"]));
                    else
                        return Convert.ToDouble(Convert.ToDouble(ds.Tables[0].Rows[0]["Rec_Amount"]) - Convert.ToDouble(ds1.Tables[0].Rows[0]["N_Amount"]));
                }
            }
        }

        private static DataSet GetLastPaidDate(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT  Rec_Date,Rec_Amount,Request_No FROM Payment_Received WHERE Rec_Date = (SELECT MAX(Rec_Date) FROM Payment_Received WHERE Pro_ID = '" + Reg.Pro_ID + "' AND Flag = 1) AND Pro_ID = '" + Reg.Pro_ID + "' AND Flag = 1");
            return database.ExecuteDataSet(dbCommand);
        }

        private static DataSet GetTaxesDetails(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT " + Reg.Head_Name + "_ServiceTax as ServiceTax, " + Reg.Head_Name + "_Vat as VAT FROM Tax_Master_Info with (nolock) WHERE Pro_ID = '" + Reg.Pro_ID + "' AND Row_ID = (SELECT MAX(Row_ID) FROM Tax_Master_Info WHERE Pro_ID = '" + Reg.Pro_ID + "' ) ");
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet FindAmcOfferInfo(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Amc_Offer_ID,Pro_ID,(SELECT Pro_Name FROM Pro_Reg WHERE  (Pro_ID = M_Amc_Offer.Pro_ID)) AS Pro_Name, Plan_Name, Plan_Amount, Plan_Discount, Entry_Date, Plan_ID, Comp_ID, Date_From, Date_To, Trans_Type, Status, IsCancel, Update_Flag_H, Update_Flag_E, Comments FROM M_Amc_Offer WHERE (Pro_ID = '" + Reg.Pro_ID + "') AND (''='" + Reg.Plan_ID + "' OR Amc_Offer_ID = '" + Reg.Plan_ID + "')  AND IsCancel = 1 ");
            return database.ExecuteDataSet(dbCommand);
        }

        public static string GetInvoiceID(Object9420 Inv)
        {
            if (Inv.Head_Name == "Label")
                dbCommand = database.GetSqlStringCommand("SELECT  PrPrefix + 'L' + substring(convert(nvarchar,getdate(),111),3,2) + '-' +CONVERT(varchar, PrStart) AS Invoice_No FROM Code_Gen WHERE [Prfor] = 'Invoices'");
            else if (Inv.Head_Name == "Offer")
                dbCommand = database.GetSqlStringCommand("SELECT  PrPrefix + 'O' + substring(convert(nvarchar,getdate(),111),3,2) + '-' +CONVERT(varchar, PrStart) AS Invoice_No FROM Code_Gen WHERE [Prfor] = 'Invoices'");
            else if (Inv.Head_Name == "AMC")
                dbCommand = database.GetSqlStringCommand("SELECT  PrPrefix + 'A' + substring(convert(nvarchar,getdate(),111),3,2) + '-' +CONVERT(varchar, PrStart) AS Invoice_No FROM Code_Gen WHERE [Prfor] = 'Invoices'");
            return Convert.ToString(database.ExecuteScalar(dbCommand));
        }


        public static DataSet FindFillGrdVwInvoicess(string StrAll)
        {
            dbCommand = database.GetSqlStringCommand("SELECT [Row_ID],[Invoice_ID],[Invoice_Date],(SELECT Comp_Name FROM Comp_Reg WHERE Comp_ID=M_Invoice.Comp_ID) as Comp_Name,(SELECT top 1 Comp_Email FROM Comp_Reg WHERE Comp_ID=M_Invoice.Comp_ID) as Comp_Email,[Comp_ID],[Pro_ID],[Head_ID],[Head_Name],[G_Amount],[Discount],[Service_Tax],[VAT],[N_Amount],[Last_Paid_Amount],[Last_Paid_Date],[Balance] " +
            " ,[Net_Pay],[Status],'Bill/Invoice/' + convert(nvarchar,M_Invoice.Invoice_Date,105) + '/' + M_Invoice.Invoice_ID + '.pdf' as filepth FROM [M_Invoice] " + StrAll + "ORDER BY Invoice_Date DESC");
            return database.ExecuteDataSet(dbCommand);
        }



        public static void CreateLabelInvoice(Object9420 Inv)
        {
            LogManager.WriteExe("invoice section passed 11A");
            GetDispatchRowID(Inv);
            Inv.Invoice_Date = Convert.ToDateTime(DataProvider.LocalDateTime.Now.ToString("yyyy/MM/dd hh:mm:ss tt"));
            //************** Fill data for generate Invoice From M_Amc_Offer ******************//   
            DataSet ds1 = FindDispatchInfo(Inv);
            LogManager.WriteExe("invoice section passed 11A11");
            //DataSet ds1 = function9420.FindAmcOfferInfo(Inv);
            if (ds1.Tables[0].Rows.Count > 0)
            {
                LogManager.WriteExe("invoice section passed 11A1");
                Inv.Head_Name = "Label";

                //********************** Generate Invoice Number ************************//
                Inv.Invoice_ID = GetInvoiceID(Inv);
                LogManager.WriteExe("invoice section passed 11A2");
                //******** this take this value to source code

                //Inv.Comp_ID = ds1.Tables[0].Rows[i]["Comp_ID"].ToString();
                //Inv.Pro_ID = ds1.Tables[0].Rows[i]["Pro_ID"].ToString();


                Inv.Plan_ID = Inv.Courier_Disp_ID;
                Inv.Head_ID = Inv.Row_ID; //Inv.Courier_Disp_ID; // just like Plan for Amc and Offer Invoice

                LogManager.WriteExe("invoice section passed 11A2 loop started");
                for (int i = 0; i < ds1.Tables[0].Rows.Count; i++)
                {
                    LogManager.WriteExe("invoice section passed 11A2 " + i.ToString());
                    Inv.Label_Code = ds1.Tables[0].Rows[i]["Label_Code"].ToString();
                    Inv.Label_Name = ds1.Tables[0].Rows[i]["Label_Name"].ToString();
                    #region New Logic For Checking according to label proce
                    string[] Arr = ds1.Tables[0].Rows[i]["Series_From"].ToString().Split('-');
                    Inv.Pro_ID = Arr[0].ToString();
                    Inv.Series_Order = Convert.ToInt32(Arr[1]);
                    Inv.Series_From = Arr[2].ToString();
                    string[] Arr1 = ds1.Tables[0].Rows[i]["Series_To"].ToString().Split('-');
                    Inv.Series_SerialTo = Convert.ToInt32(Arr1[2]);
                    #endregion
                    Inv.Series_DFrom = ds1.Tables[0].Rows[i]["Series_From"].ToString();
                    Inv.Series_To = ds1.Tables[0].Rows[i]["Series_To"].ToString();
                    Inv.Qty = Convert.ToDouble(ds1.Tables[0].Rows[i]["Qty"]);

                    DataSet Invds = new DataSet();
                    Invds = LabelDispDetails(Inv);


                    Inv.Label_Prise = Convert.ToDouble(Invds.Tables[0].Rows[0]["Price"]);


                    Inv.G_Amount = Math.Round(Convert.ToDouble(Invds.Tables[0].Rows[0]["Price"]) * Convert.ToInt32(ds1.Tables[0].Rows[i]["Qty"]), 2);
                    Inv.Discount = 0.00;// Convert.ToDouble(ds1.Tables[0].Rows[i]["Plan_Discount"]);

                    Inv.G_Amount = Inv.G_Amount - Inv.Discount; // Net G_Amount after plan_discount

                    // Get Invoice G_Amount
                    Inv.MG_Amount += Inv.G_Amount;

                    DataSet dsn = GetTaxesDetails(Inv);
                    Inv.Service_Tax = Convert.ToDouble(dsn.Tables[0].Rows[0]["ServiceTax"]);
                    Inv.Vat_Tax = Convert.ToDouble(dsn.Tables[0].Rows[0]["VAT"]);

                    Inv.Service_Tax_Value = Math.Round(((Inv.G_Amount * Inv.Service_Tax) / 100), 2);
                    Inv.Vat_Tax_Value = Math.Round(((Inv.G_Amount * Inv.Vat_Tax) / 100), 2);

                    // Get Service Tax Value
                    Inv.MService_Tax_Value += Inv.Service_Tax_Value;
                    Inv.MVat_Tax_Value += Inv.Vat_Tax_Value;


                    Inv.N_Amount = Inv.G_Amount + Inv.Service_Tax_Value + Inv.Vat_Tax_Value; // Net Amount after calculate service tax and vat tax(G_Amount + Service_Tax_Value + Vat_Tax_Value)                    

                    // Get Net Amount Value
                    Inv.MN_Amount += Inv.N_Amount;
                    InsertLabelDispatchInformation(Inv);
                    LogManager.WriteExe("invoice section passed 11A2 loop 3");
                }
                LogManager.WriteExe("invoice section passed 11A2 Loop ended");
                // Get Invoice G_Amount
                Inv.G_Amount = Inv.MG_Amount;
                // Get Service Tax Value
                Inv.Service_Tax_Value = Inv.MService_Tax_Value;
                Inv.Vat_Tax_Value = Inv.MVat_Tax_Value;
                // Get Net Amount Value
                Inv.N_Amount = Inv.MN_Amount;


                DataSet dds = GetLastPaidDate(Inv);
                if (dds.Tables[0].Rows.Count > 0)
                {
                    Inv.Last_Payment_Receipt = dds.Tables[0].Rows[0]["Request_No"].ToString();
                    Inv.Last_Paid_Date = Convert.ToDateTime(dds.Tables[0].Rows[0]["Rec_Date"].ToString());
                    Inv.Last_Paid_Amount = Convert.ToDouble(dds.Tables[0].Rows[0]["Rec_Amount"].ToString());
                }
                LogManager.WriteExe("invoice section passed 11A2 Loop ended find balance");
                Inv.Availabl_Balance = FindNetAvailablBalance(Inv); // Get over all available balance
                LogManager.WriteExe("invoice section passed 11A2 Loop ended find balance done");
                //if (Inv.Availabl_Balance >= 0.0)
                Inv.Balance = Inv.Availabl_Balance - Inv.N_Amount; // Current Balance According to Product for credit balance
                LogManager.WriteExe("invoice section passed 11A2 Loop ended current balance");
                if (Inv.Balance <= 0.0)
                    Inv.Net_Pay = Math.Abs(Inv.Balance); // net pay amount balance in this Invoice  
                Inv.Status = 1;
                // *********** Insert data In Invoice Master and Set Invoice ID ********************//
                LogManager.WriteExe("invoice section passed 11A2 Loop ended inser started to master");
                InsertInvoiceMaster(Inv);
                LogManager.WriteExe("invoice section passed 11A2 Loop ended nsert ended t");
            }

        }

        private static void GetDispatchRowID(Object9420 Inv)
        {
            LogManager.WriteExe("invoice section passed 11AINV " + Inv.Courier_Disp_ID);

            dbCommand = database.GetSqlStringCommand("SELECT Row_ID FROM Courier_Dispatch_Master where  Courier_Disp_ID='" + Inv.Courier_Disp_ID + "'");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                LogManager.WriteExe("11AINV");
                Inv.Row_ID = ds.Tables[0].Rows[0]["Row_ID"].ToString();
            }
        }

        private static void InsertLabelDispatchInformation(Object9420 Inv)
        {
            dbCommand = database.GetSqlStringCommand("INSERT INTO [LabelInvoiceInfo]([Invoice_ID],[Pro_ID],[Label_Code],[Label_Name],[Series_From],[Series_To] ,[Qty],[Price],[G_Amount] " +
            " ,[Service_Tax] ,[VAT] ,[N_Amount] ,[Entry_Date]) VALUES " +
            " ( '" + Inv.Invoice_ID + "' ,'" + Inv.Pro_ID + "','" + Inv.Label_Code + "' ,'" + Inv.Label_Name + "','" + Inv.Series_DFrom + "','" + Inv.Series_To + "','" + Inv.Qty + "' ,'" + Inv.Label_Prise + "' " +
            " , '" + Inv.G_Amount + "' , '" + Inv.Service_Tax_Value + "' , '" + Inv.Vat_Tax_Value + "','" + Inv.N_Amount + "' ,'" + Convert.ToDateTime(Inv.Invoice_Date).ToString("yyyy/MM/dd hh:mm:ss tt") + "')");
            database.ExecuteNonQuery(dbCommand);
        }

        private static DataSet LabelDispDetails(Object9420 Inv)
        {
            try
            {
                dbCommand = database.GetStoredProcCommand("Proc_LabelDispDetails");
                database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Inv.Pro_ID);
                database.AddInParameter(dbCommand, "Serial_Order", DbType.Int32, Inv.Series_Order);
                database.AddInParameter(dbCommand, "Serial_SeriesF", DbType.Int32, Inv.Series_From);
                database.AddInParameter(dbCommand, "Serial_SeriesT", DbType.Int32, Inv.Series_SerialTo);
                return database.ExecuteDataSet(dbCommand);
            }
            catch (Exception ex)
            {
                throw ex;
            }
        }

        private static DataSet FindDispatchInfo(Object9420 Inv)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Row_ID, Courier_Disp_ID, Pro_ID, Label_Code, Label_Name, Series_From, Series_To, Qty, Entry_Date FROM Courier_Disp_ProInfo WHERE Courier_Disp_ID = '" + Inv.Courier_Disp_ID + "' ");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet GetCurrentLabelInfo(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Tracking_No,Label_Code,(Select Label_Name from M_Label where Label_Code = M_Label_Request.Label_Code ) as Label_Name,(SELECT Label_Prise FROM M_Label WHERE  Label_Code = M_Label_Request.Label_Code) AS Price,(select Pro_Name from Pro_Reg where Pro_ID = M_Label_Request.Pro_Id) as Pro_Name, (select Comp_email from Comp_Reg where Comp_ID = '" + Reg.Comp_ID + "') as Comp_Email FROM  M_Label_Request where  Row_ID='" + Reg.Row_ID + "' ");
            return database.ExecuteDataSet(dbCommand);
        }
        #endregion

        public static double GetMaxPlanAmount()
        {
            dbCommand = database.GetSqlStringCommand("SELECT Max(Plan_Amount) FROM M_Plan WHERE  Flag = 1 ");
            return Convert.ToDouble(database.ExecuteScalar(dbCommand));
        }
        public static string GetPlanTime(Object9420 Amc)
        {
            if (Amc.Amt_Type == "Offer")
                dbCommand = database.GetSqlStringCommand("SELECT Time_Days FROM M_Promotional WHERE (Promo_ID = '" + Amc.Promo_Id + "') AND (Flag = 1) ");
            else
                dbCommand = database.GetSqlStringCommand("SELECT Plan_Time FROM  M_Plan WHERE Plan_ID='" + Amc.Plan_ID + "'  AND Flag= 1 ");
            return database.ExecuteScalar(dbCommand).ToString();
        }

        public static DataTable GetBeyondOffer(Object9420 Amc)
        {
            dbCommand = database.GetSqlStringCommand("SELECT * FROM M_Amc_Offer WHERE (Pro_ID = '" + Amc.Pro_ID + "') AND (IsCancel = 1) AND (Trans_type = 'Offer') AND (CONVERT(VARCHAR,Date_From,111) >= '" + Convert.ToDateTime(Amc.AmcDateFrom).ToString("yyyy/MM/dd") + "') AND (CONVERT(VARCHAR,Date_To,111) <= '" + Convert.ToDateTime(Amc.AmcDateTo).ToString("yyyy/MM/dd") + "') ");
            //SELECT * FROM M_Amc_Offer WHERE (Pro_ID = 'AA02') AND (IsCancel = 1)  AND (Trans_type = 'Offer') AND (CONVERT(VARCHAR,Date_From,111) <= '2014/08/23') ");
            DataSet ds = database.ExecuteDataSet(dbCommand);
            if (ds.Tables[0].Rows.Count > 0)
            {
                string q = "";
                for (int i = 0; i < ds.Tables[0].Rows.Count; i++)
                {
                    if (Convert.ToDateTime(ds.Tables[0].Rows[i]["Date_From"]) < Convert.ToDateTime(Amc.DateFrom))
                    {
                        q += ds.Tables[0].Rows[i]["Amc_Offer_ID"].ToString() + ",";
                    }
                }
                ds.Tables[0].Rows.Clear();
                if (q.ToString() != "")
                {
                    q = q.ToString().Substring(0, q.Length - 1);
                    DataView dv = ds.Tables[0].DefaultView;
                    dv.RowFilter = "Amc_Offer_ID IN (" + q + ")";
                    DataTable dt = new DataTable();
                    dt = dv.ToTable();
                    if (dt.Rows.Count > 0)
                        return dt;
                    else
                        return ds.Tables[0];
                }
                else
                    return ds.Tables[0];
            }
            else
                return database.ExecuteDataSet(dbCommand).Tables[0];
        }

        public static void InsertTestimonialData(Object9420 obj)
        {
            dbCommand = database.GetStoredProcCommand("PROC_InsertUpdateTestimonial");
            database.AddInParameter(dbCommand, "Testimonial_ID", DbType.String, obj.Testimonial_ID);
            database.AddInParameter(dbCommand, "User_Id", DbType.String, obj.Comp_ID);
            database.AddInParameter(dbCommand, "Testimonial", DbType.String, obj.Testimonial_Text);
            database.AddInParameter(dbCommand, "Test_Image1", DbType.String, obj.Img1);
            database.AddInParameter(dbCommand, "Test_Image2", DbType.String, obj.Img2);
            database.AddInParameter(dbCommand, "Act_Flg", DbType.Int32, obj.Act_Flag);
            database.AddInParameter(dbCommand, "Con_Flg", DbType.Int32, obj.Con_Flag);
            database.AddInParameter(dbCommand, "Del_Flg", DbType.Int32, obj.Del_Flag);
            database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, obj.Entry_Date);
            database.AddInParameter(dbCommand, "DML", DbType.String, obj.DML);
            database.ExecuteNonQuery(dbCommand);
        }

        //Added by Bipin for wellverse

        public static void Insertfakedata(insertfakedata obj)
        {
            dbCommand = database.GetStoredProcCommand("sp_insFakedata");
            database.AddInParameter(dbCommand, "@Mobileno", DbType.String, obj.Mobileno);
            database.AddInParameter(dbCommand, "@Imgpath", DbType.String, obj.Imgpath);
            database.AddInParameter(dbCommand, "@Purchasedfrom", DbType.String, obj.Purchsedfrom);
            database.AddInParameter(dbCommand, "@Lat", DbType.String, obj.Lat);
            database.AddInParameter(dbCommand, "@Long", DbType.String, obj.Long);
            database.AddInParameter(dbCommand, "@Address", DbType.String, obj.Address);
            database.AddInParameter(dbCommand, "@City", DbType.String, obj.City);
            database.AddInParameter(dbCommand, "@State", DbType.String, obj.State);
            database.AddInParameter(dbCommand, "@Country", DbType.String, obj.Country);
            database.AddInParameter(dbCommand, "@Comp_id", DbType.String, obj.Comp_id);
            database.AddInParameter(dbCommand, "@Remark", DbType.String, obj.Remark);
            database.AddInParameter(dbCommand, "@DML", DbType.String, obj.DML);
            database.ExecuteNonQuery(dbCommand);
        }

        //End of Wellverse
        public static DataSet Enquirdetailsdownload(string product,string mode,string status,DateTime startdate,DateTime enddate,string companyId,string service_id)
        {
            dbCommand = database.GetStoredProcCommand("[enq_detailsdownload]");
            database.AddInParameter(dbCommand, "@product", DbType.String, product);
            database.AddInParameter(dbCommand, "@mode", DbType.String, mode);
            database.AddInParameter(dbCommand, "@status", DbType.String, status);
            database.AddInParameter(dbCommand, "@start_date", DbType.DateTime, Convert.ToDateTime(startdate.ToString("yyyy-MM-dd") + " 00:00:01.999"));
database.AddInParameter(dbCommand, "@enq_date", DbType.DateTime, Convert.ToDateTime(enddate.ToString("yyyy-MM-dd") + " 23:59:59.999"));
           // database.AddInParameter(dbCommand, "@enq_date", DbType.DateTime, enddate);
            database.AddInParameter(dbCommand, "@companyid", DbType.String, companyId);
            database.AddInParameter(dbCommand, "@serviceid", DbType.String, service_id);
            dbCommand.CommandTimeout = 500;


         return   database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillTestimonial(Object9420 Reg)
        {
            string Qry = "";
            if (Reg.DML == "F")
                Qry = " AND Act_Flg = 1 AND Con_Flg = 1";
            dbCommand = database.GetSqlStringCommand("SELECT [Testimonial_ID],[User_Id],(SELECT Contact_Person FROM Comp_Reg WHERE Comp_ID = M_Testimonial.User_Id) as Contact_Person,(SELECT Comp_Name FROM Comp_Reg WHERE Comp_ID = M_Testimonial.User_Id) as Comp_Name,substring([Testimonial],0,25)+'.....' as [Short_Testimonial],[Testimonial],[Test_Image1],[Test_Image2],[Act_Flg],[Con_Flg],[Del_Flg],[Entry_Date],CASE WHEN [Con_Flg] = 1 THEN (CASE WHEN [Act_Flg] = 1 THEN 'De-Active' ELSE 'Active' END) ELSE '' END as Status " +
            " ,'Sound/Testimonial/'+substring([User_Id],charindex('-',[User_Id])+1,len([User_Id])-charindex('-',[User_Id]))+'/'+[Test_Image1] as f1,'Sound/Testimonial/'+substring([User_Id],charindex('-',[User_Id])+1,len([User_Id])-charindex('-',[User_Id]))+'/'+[Test_Image2] as f2 " +
            " FROM [M_Testimonial] WHERE ('' = '" + Reg.Comp_ID + "' OR [User_Id] = '" + Reg.Comp_ID + "') AND ('' = '" + Reg.Testimonial_ID + "' OR Testimonial_ID = '" + Reg.Testimonial_ID + "') " + Qry + " AND Del_Flg = 0 ORDER BY Entry_Date DESC ");
            return database.ExecuteDataSet(dbCommand);
        }

        public static void UpdateTestimonial(Object9420 Reg)
        {
            if (Reg.chkstr == "Confirm")
            {
                if (Reg.Flag == 0)
                    Reg.Flag = 1;
                else
                    Reg.Flag = 0;
                if (Reg.Flag == 0)
                    dbCommand = database.GetSqlStringCommand("UPDATE [M_Testimonial] SET [Act_Flg] = 0,[Con_Flg] = " + Reg.Flag + ",[Del_Flg] = 0 WHERE [Testimonial_ID] = '" + Reg.Testimonial_ID + "'");
                else
                    dbCommand = database.GetSqlStringCommand("UPDATE [M_Testimonial] SET [Con_Flg] = " + Reg.Flag + " WHERE [Testimonial_ID] = '" + Reg.Testimonial_ID + "'");
            }
            else if (Reg.chkstr == "Reject")
            {
                Reg.Flag = 1;
                //if (Reg.Flag == 0)
                //    Reg.Flag = 1;
                //else
                //    Reg.Flag = 0;
                //if (Reg.Flag == 0)
                //    dbCommand = database.GetSqlStringCommand("UPDATE [M_Testimonial] SET [Act_Flg] = 0,[Con_Flg] = 0,[Del_Flg] = " + Reg.Flag + " WHERE [Testimonial_ID] = '" + Reg.Testimonial_ID + "'");
                //else
                dbCommand = database.GetSqlStringCommand("UPDATE [M_Testimonial] SET [Del_Flg] = " + Reg.Flag + " WHERE [Testimonial_ID] = '" + Reg.Testimonial_ID + "'");
            }
            else if (Reg.chkstr == "ChangeStatus")
            {
                if (Reg.Flag == 0)
                    Reg.Flag = 1;
                else
                    Reg.Flag = 0;
                dbCommand = database.GetSqlStringCommand("UPDATE [M_Testimonial] SET [Act_Flg] = " + Reg.Flag + " WHERE [Testimonial_ID] = '" + Reg.Testimonial_ID + "'");
            }
            database.ExecuteNonQuery(dbCommand);
        }
        public static void CancelledAmcOfferPlan(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_CancelledAmcOfferPlan");
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, Reg.Pro_ID);
            database.AddInParameter(dbCommand, "Head_ID", DbType.String, Reg.Head_ID);
            database.AddInParameter(dbCommand, "Head_Name", DbType.String, Reg.Head_Name);
            database.AddInParameter(dbCommand, "Cancelled_By", DbType.String, Reg.Cancelled_By);
            database.AddInParameter(dbCommand, "Entry_Date", DbType.DateTime, Reg.Entry_Date);
            database.AddInParameter(dbCommand, "Remarks", DbType.String, Reg.Remarks);
            database.ExecuteNonQuery(dbCommand);
        }

        public static void InterestedAsDemo(Object9420 obj)
        {
            // Check for Duplicate Enrty Product
            DataSet ds = SQL_DB.ExecuteDataSet("SELECT [Comp_Email] FROM [Interested_Demo] where [Comp_Email] = '" + obj.Comp_Email + "' and [Status] = 0");
            if (ds.Tables[0].Rows.Count > 0)
                return;
            dbCommand = database.GetStoredProcCommand("PROC_InterestedCompany");
            database.AddInParameter(dbCommand, "Comp_Name", DbType.String, obj.Comp_Name);
            database.AddInParameter(dbCommand, "Comp_Email", DbType.String, obj.Comp_Email);
            database.AddInParameter(dbCommand, "Contact_Person", DbType.String, obj.Contact_Person);
            database.AddInParameter(dbCommand, "Mobile_No", DbType.String, obj.Mobile_No);
            database.AddInParameter(dbCommand, "Reg_Date", DbType.DateTime, obj.Entry_Date);
            database.AddInParameter(dbCommand, "Status", DbType.String, obj.Status);
            database.AddInParameter(dbCommand, "Contact_Flag", DbType.String, obj.Status);
            database.ExecuteNonQuery(dbCommand);
        }
        public static DataSet FillPrintLbl(Object9420 obj)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetStoredProcCommand("PROC_FillPrintLabel");
            database.AddInParameter(dbCommand, "Date_From", DbType.String, Convert.ToDateTime(obj.DateFrom).ToString("yyyy/MM/dd"));
            database.AddInParameter(dbCommand, "Date_To", DbType.String, Convert.ToDateTime(obj.DateTo).ToString("yyyy/MM/dd"));
            database.AddInParameter(dbCommand, "Pro_ID", DbType.String, obj.Pro_ID);
        g:
            try
            {
                ds = database.ExecuteDataSet(dbCommand);
            }
            catch
            {
                goto g;
            }
            return ds;
        }

        public static DataSet DispatchLabelsStatus(Object9420 obj)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT  m.LabelRequestId as Tracking_No,COUNT(m.Pro_ID) AS TotalCode, m.Pro_ID, ml.Entry_Date,(SELECT COUNT(Pro_ID) AS Cnt  FROM M_Code WHERE (LabelRequestId = m.LabelRequestId) AND (DispatchFlag = 1)) AS DispatchCode, COUNT(m.Pro_ID) - (SELECT COUNT(Pro_ID) AS Cnt FROM M_Code AS M_Code_2  WHERE (LabelRequestId = m.LabelRequestId) AND (DispatchFlag = 1)) AS PendingDispatchCode, " +
            " (SELECT     COUNT(Pro_ID) AS Cnt FROM M_Code AS M_Code_1 WHERE      (LabelRequestId = m.LabelRequestId) AND (ReceiveFlag = 1)) AS ReceiveCode, p.Pro_Name FROM M_Code AS m INNER JOIN M_Label_Request AS ml ON m.LabelRequestId = ml.Tracking_No INNER JOIN Pro_Reg as p ON m.Pro_ID = p.Pro_ID " +
            " WHERE ('' = '" + obj.Pro_ID + "' or p.Pro_ID = '" + obj.Pro_ID + "') AND ('' = '" + obj.Comp_ID + "' or p.Comp_ID = '" + obj.Comp_ID + "') GROUP BY m.LabelRequestId, m.Pro_ID, ml.Entry_Date, p.Pro_Name");
        g:
            try
            {
                ds = database.ExecuteDataSet(dbCommand);
            }
            catch
            {
                goto g;
            }
            return ds;
        }
        public static DataSet GetPlanInfo(Object9420 Inv)
        {
            DataSet ds = new DataSet();
            dbCommand = database.GetSqlStringCommand("SELECT Row_ID, Invoice_ID, Invoice_Date, Comp_ID, Pro_ID, Head_ID as Amc_Offer_ID,(SELECT Plan_ID FROM M_Amc_Offer WHERE Amc_Offer_ID = M_Invoice.Head_ID) as Plan_ID, Head_Name as Trans_Type, G_Amount as Plan_Amount, Discount as Plan_Discount, Service_Tax, VAT, N_Amount, Upgrade_From, Upgrade_Amount,  " +
            " Last_Paid_Amount, Last_Paid_Date, Balance, Net_Pay, Status FROM M_Invoice WHERE Head_ID = " + Inv.Plan_ID + " AND Head_Name = '" + Inv.Head_Name + "' ");
        g:
            try
            {
                ds = database.ExecuteDataSet(dbCommand);
            }
            catch
            {
                goto g;
            }
            return ds;
        }

        public static DataSet FetchProduct(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Pro_ID,Pro_Name FROM Pro_Reg WHERE (''='" + Reg.Comp_ID + "' OR Comp_ID = '" + Reg.Comp_ID + "') ORDER BY Pro_Name ");
            return database.ExecuteDataSet(dbCommand);
        }
        public static DataSet FillInterestedForDemo(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT Row_ID, Comp_Name,Comp_Email,Contact_Person,Mobile_No,Reg_Date,Status as Status1,CASE WHEN Status = 0 THEN 'New' WHEN Status = 1 THEN 'Contact' ELSE 'Rejected' END [Status],Contact_Flag FROM Interested_Demo WHERE Contact_Person like '%" + Reg.chkstr + "%' AND Comp_Name like '%" + Reg.Comp_Name + "%' AND LEN(Comp_Name) > 0 " + Reg.statusstr + " ORDER BY Row_ID DESC ");
            return database.ExecuteDataSet(dbCommand);
        }

        public static DataSet FindServiceInfo(Object9420 Inv)
        {
            dbCommand = database.GetSqlStringCommand("SELECT * FROM M_ServiceSubscription WHERE (Subscribe_Id = '" + Inv.Subscribe_Id + "')");
            return database.ExecuteDataSet(dbCommand);
        }

        public static Int32 GetNoOfCodes(string p)
        {
            dbCommand = database.GetSqlStringCommand("SELECT COUNT(Row_ID) Cnt FROM M_Code WHERE Use_Type ='" + p + "'");
            DataTable dt = database.ExecuteDataSet(dbCommand).Tables[0];
            if (dt.Rows.Count > 0)
                return Convert.ToInt32(dt.Rows[0]["Cnt"]);
            else
                return 0;
        }

        public static DataTable GetMessageTemplete(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_GetMessageTemplete");
            database.AddInParameter(dbCommand, "ServiceId", DbType.String, Reg.TempleteHead);
            database.AddInParameter(dbCommand, "SubHeadId", DbType.String, Reg.SubHeadId);
            return database.ExecuteDataSet(dbCommand).Tables[0];
        }
        public static DataTable GetAllServices(Object9420 Reg)
        {
            dbCommand = database.GetStoredProcCommand("PROC_GetAllServices");
            database.AddInParameter(dbCommand, "ProID", DbType.String, Reg.Pro_ID);
            return database.ExecuteDataSet(dbCommand).Tables[0];
        }

        public static void GetCompanyInfo(Object9420 Reg)
        {
            dbCommand = database.GetSqlStringCommand("SELECT * FROM Comp_Reg WHERE Comp_ID= '" + Reg.Comp_ID + "'");
            DataTable dt = database.ExecuteDataSet(dbCommand).Tables[0];
            if (dt.Rows.Count > 0)
            {
                Reg.Contact_Person = dt.Rows[0]["Contact_Person"].ToString();
                Reg.Comp_Email = dt.Rows[0]["Comp_Email"].ToString();
                Reg.Comp_Name = dt.Rows[0]["Comp_Name"].ToString();
            }
        }

        internal static void PrintCodes()
        {
            dbCommand = database.GetStoredProcCommand("Print_code");
            database.ExecuteNonQuery(dbCommand);
        }
    }

    public class CouponProverObj
    {
        private static Database database = DatabaseFactory.CreateDatabase();
        private static DbCommand dbCommand;

        #region Coupon Provider Master
        public static DataTable CPMFillDataGrid(CouponProver Reg)
        {
            dbCommand = database.GetStoredProcCommand("Proc_GetCouponProvider");
            database.AddInParameter(dbCommand, "CouponProvider_Id", DbType.Int64, Reg.CouponProvider_Id);
            database.AddInParameter(dbCommand, "CouponProviderName", DbType.String, Reg.CouponProviderName);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            DataTable dt = database.ExecuteDataSet(dbCommand).Tables[0];
            if (Reg.DML == "S")
            {
                if (dt.Rows.Count > 0)
                {
                    Reg.CouponProvider_Id = Convert.ToInt64(dt.Rows[0]["CouponProvider_Id"]);
                    Reg.CouponProviderName = dt.Rows[0]["CouponProviderName"].ToString();
                    Reg.CouponProviderEmail = dt.Rows[0]["CouponProviderEmail"].ToString();
                    Reg.CouponProviderContactPerson = dt.Rows[0]["CouponProviderContactPerson"].ToString();
                    Reg.CouponProviderContactNo = dt.Rows[0]["CouponProviderContactNo"].ToString();
                    Reg.IsActive = Convert.ToInt32(dt.Rows[0]["IsActive"]);
                    Reg.IsDelete = Convert.ToInt32(dt.Rows[0]["IsDelete"]);
                }
            }
            return dt;
        }
        public static void CPMInsertUpdate(CouponProver Reg)
        {
            dbCommand = database.GetStoredProcCommand("Proc_InsUpdCouponProvider");
            database.AddInParameter(dbCommand, "CouponProvider_Id", DbType.Int64, Reg.CouponProvider_Id);
            database.AddInParameter(dbCommand, "CouponProviderName", DbType.String, Reg.CouponProviderName);
            database.AddInParameter(dbCommand, "CouponProviderEmail", DbType.String, Reg.CouponProviderEmail);
            database.AddInParameter(dbCommand, "CouponProviderContactPerson", DbType.String, Reg.CouponProviderContactPerson);
            database.AddInParameter(dbCommand, "CouponProviderContactNo", DbType.String, Reg.CouponProviderContactNo);
            database.AddInParameter(dbCommand, "EntryDate", DbType.DateTime, Reg.EntryDate);
            database.AddInParameter(dbCommand, "IsActive", DbType.Int32, Reg.IsActive);
            database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, Reg.IsDelete);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
        }
        public static void CPMActivateDelete(CouponProver Reg)
        {
            dbCommand = database.GetStoredProcCommand("Proc_CouponProviderActDelete");
            database.AddInParameter(dbCommand, "CouponProvider_Id", DbType.Int64, Reg.CouponProvider_Id);
            database.AddInParameter(dbCommand, "IsActive", DbType.Int32, Reg.IsActive);
            database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, Reg.IsDelete);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
        }
        #endregion

        #region Coupon Master
        public static DataTable CMFillDataGrid(CouponProver Reg)
        {
            dbCommand = database.GetStoredProcCommand("Proc_GetCoupon");
            database.AddInParameter(dbCommand, "Coupon_ID", DbType.String, Reg.Coupon_ID);
            database.AddInParameter(dbCommand, "CouponName", DbType.String, Reg.CouponName);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            DataTable dt = database.ExecuteDataSet(dbCommand).Tables[0];
            if (Reg.DML == "S")
            {
                if (dt.Rows.Count > 0)
                {
                    Reg.Coupon_ID = dt.Rows[0]["Coupon_ID"].ToString();
                    Reg.CouponName = dt.Rows[0]["CouponName"].ToString();
                    Reg.CouponProvider_Id = Convert.ToInt64(dt.Rows[0]["CouponProvider_Id"].ToString());
                    Reg.IsActive = Convert.ToInt32(dt.Rows[0]["IsActive"]);
                    Reg.IsDelete = Convert.ToInt32(dt.Rows[0]["IsDelete"]);
                }
            }
            return dt;
        }
        public static void CMInsertUpdate(CouponProver Reg)
        {
            //if (Reg.DML == "I")
            //    Reg.Coupon_ID = GetID("Coupon");
            dbCommand = database.GetStoredProcCommand("Proc_InsUpdCoupon");
            database.AddInParameter(dbCommand, "Coupon_ID", DbType.String, Reg.Coupon_ID);
            database.AddInParameter(dbCommand, "CouponName", DbType.String, Reg.CouponName);
            database.AddInParameter(dbCommand, "CouponProvider_Id", DbType.Int64, Reg.CouponProvider_Id);
            database.AddInParameter(dbCommand, "EntryDate", DbType.DateTime, Reg.EntryDate);
            database.AddInParameter(dbCommand, "IsActive", DbType.Int32, Reg.IsActive);
            database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, Reg.IsDelete);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
            //if (Reg.DML == "I")
            //    SetID("Coupon");
        }
        public static void CMActivateDelete(CouponProver Reg)
        {
            dbCommand = database.GetStoredProcCommand("Proc_CouponActDelete");
            database.AddInParameter(dbCommand, "Coupon_ID", DbType.String, Reg.Coupon_ID);
            database.AddInParameter(dbCommand, "IsActive", DbType.Int32, Reg.IsActive);
            database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, Reg.IsDelete);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
        }
        #endregion

        #region Gift Master
        public static DataTable GiftFillDataGrid(CouponProver Reg)
        {
            dbCommand = database.GetStoredProcCommand("Proc_GetGift");
            database.AddInParameter(dbCommand, "Gift_ID", DbType.String, Reg.Gift_ID);
            database.AddInParameter(dbCommand, "GiftName", DbType.String, Reg.GiftName);
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            DataTable dt = database.ExecuteDataSet(dbCommand).Tables[0];
            if (Reg.DML == "S")
            {
                if (dt.Rows.Count > 0)
                {
                    Reg.Gift_ID = dt.Rows[0]["Gift_ID"].ToString();
                    Reg.GiftName = dt.Rows[0]["GiftName"].ToString();
                    Reg.IsActive = Convert.ToInt32(dt.Rows[0]["IsActive"]);
                    Reg.IsDelete = Convert.ToInt32(dt.Rows[0]["IsDelete"]);
                    Reg.Comp_ID = dt.Rows[0]["Comp_ID"].ToString();
                }
            }
            return dt;
        }
        public static void GiftInsertUpdate(CouponProver Reg)
        {
            if (Reg.DML == "I")
                Reg.Gift_ID = GetID("Gift");
            dbCommand = database.GetStoredProcCommand("Proc_InsUpdGift");
            database.AddInParameter(dbCommand, "Gift_ID", DbType.String, Reg.Gift_ID);
            database.AddInParameter(dbCommand, "GiftName", DbType.String, Reg.GiftName);
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.AddInParameter(dbCommand, "EntryDate", DbType.DateTime, Reg.EntryDate);
            database.AddInParameter(dbCommand, "IsActive", DbType.Int32, Reg.IsActive);
            database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, Reg.IsDelete);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
            if (Reg.DML == "I")
                SetID("Gift");
        }
        public static void GiftActivateDelete(CouponProver Reg)
        {
            dbCommand = database.GetStoredProcCommand("Proc_GiftActDelete");
            database.AddInParameter(dbCommand, "Gift_ID", DbType.String, Reg.Gift_ID);
            database.AddInParameter(dbCommand, "IsActive", DbType.Int32, Reg.IsActive);
            database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, Reg.IsDelete);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
        }
        #endregion

        #region Question Master
        public static DataTable QuestionFillDataGrid(CouponProver Reg)
        {
            dbCommand = database.GetStoredProcCommand("[Proc_GetQuestion]");
            database.AddInParameter(dbCommand, "QuestionID", DbType.String, Reg.Question_Id);
            database.AddInParameter(dbCommand, "Question", DbType.String, Reg.QuestionName);
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            DataTable dt = database.ExecuteDataSet(dbCommand).Tables[0];
            if (Reg.DML == "S")
            {
                if (dt.Rows.Count > 0)
                {
                    Reg.Question_Id = dt.Rows[0]["Questionid"].ToString();
                    Reg.QuestionName = dt.Rows[0]["Question"].ToString();
                    Reg.IsActive = Convert.ToInt32(dt.Rows[0]["IsActive"]);
                    Reg.IsDelete = Convert.ToInt32(dt.Rows[0]["IsDelete"]);
                    Reg.Comp_ID = dt.Rows[0]["Comp_ID"].ToString();
                }
            }
            return dt;
        }
        public static void QuestionInsertUpdate(CouponProver Reg)
        {
            // if (Reg.DML == "I")
            // Reg.Gift_ID = GetID("Gift");
            dbCommand = database.GetStoredProcCommand("[Proc_InsUpdRunSurveyQuestion]");
            database.AddInParameter(dbCommand, "QuestionID", DbType.String, Reg.Question_Id);
            database.AddInParameter(dbCommand, "Question", DbType.String, Reg.QuestionName);
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.AddInParameter(dbCommand, "EntryDate", DbType.DateTime, Reg.EntryDate);
            database.AddInParameter(dbCommand, "IsActive", DbType.Int32, Reg.IsActive);
            database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, Reg.IsDelete);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
            // if (Reg.DML == "I")
            //SetID("Gift");
        }
        public static void QuestionActivateDelete(CouponProver Reg)
        {
            dbCommand = database.GetStoredProcCommand("[Proc_QuestionActDelete]");
            database.AddInParameter(dbCommand, "QuestionID", DbType.String, Reg.Question_Id);
            database.AddInParameter(dbCommand, "IsActive", DbType.Int32, Reg.IsActive);
            database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, Reg.IsDelete);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
        }
        //public static void GiftActivateDelete(CouponProver Reg)
        //{
        //    dbCommand = database.GetStoredProcCommand("Proc_GiftActDelete");
        //    database.AddInParameter(dbCommand, "Gift_ID", DbType.String, Reg.Gift_ID);
        //    database.AddInParameter(dbCommand, "IsActive", DbType.Int32, Reg.IsActive);
        //    database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, Reg.IsDelete);
        //    database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
        //    database.ExecuteNonQuery(dbCommand);
        //}
        #endregion

        #region Coupon Request Master
        public static DataTable CRFillDataGrid(CouponProver Reg)
        {
            dbCommand = database.GetStoredProcCommand("Proc_GetCouponRequest");
            database.AddInParameter(dbCommand, "CouponRequest_ID", DbType.String, Reg.CouponRequest_ID);
            database.AddInParameter(dbCommand, "CouponName", DbType.String, Reg.CouponName);
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            DataTable dt = database.ExecuteDataSet(dbCommand).Tables[0];
            if (Reg.DML == "S")
            {
                if (dt.Rows.Count > 0)
                {
                    Reg.CouponRequest_ID = dt.Rows[0]["CouponRequest_ID"].ToString();
                    Reg.Coupon_ID = dt.Rows[0]["Coupon_ID"].ToString();
                    Reg.CouponName = dt.Rows[0]["CouponName"].ToString();
                    Reg.DateFrom = dt.Rows[0]["DateFrom"].ToString();
                    Reg.DateTo = dt.Rows[0]["DateTo"].ToString();
                    Reg.CouponCount = Convert.ToInt64(dt.Rows[0]["CouponCount"]);
                    Reg.IsActive = Convert.ToInt32(dt.Rows[0]["IsActive"]);
                    Reg.IsDelete = Convert.ToInt32(dt.Rows[0]["IsDelete"]);
                    Reg.Comp_ID = dt.Rows[0]["Comp_ID"].ToString();
                }
            }
            return dt;
        }
        public static void CRInsertUpdate(CouponProver Reg)
        {
            // if (Reg.DML == "I")
            //     Reg.CouponRequest_ID = GetID("CouponRequest");
            dbCommand = database.GetStoredProcCommand("Proc_InsUpdCouponRequest");
            database.AddInParameter(dbCommand, "CouponRequest_ID", DbType.String, Reg.CouponRequest_ID);
            database.AddInParameter(dbCommand, "Coupon_ID", DbType.String, Reg.Coupon_ID);
            database.AddInParameter(dbCommand, "Comp_ID", DbType.String, Reg.Comp_ID);
            database.AddInParameter(dbCommand, "DateFrom", DbType.DateTime, Convert.ToDateTime(Reg.DateFrom).ToString("yyyy/MM/dd"));
            database.AddInParameter(dbCommand, "DateTo", DbType.DateTime, Convert.ToDateTime(Reg.DateTo).ToString("yyyy/MM/dd"));
            database.AddInParameter(dbCommand, "CouponCount", DbType.Int64, Reg.CouponCount);
            database.AddInParameter(dbCommand, "EntryDate", DbType.DateTime, Reg.EntryDate);
            database.AddInParameter(dbCommand, "IsAdminVerify", DbType.Int32, Reg.IsAdminVerify);
            database.AddInParameter(dbCommand, "IsActive", DbType.Int32, Reg.IsActive);
            database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, Reg.IsDelete);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
            // if (Reg.DML == "I")
            //    SetID("CouponRequest");
        }
        public static void CRActivateDelete(CouponProver Reg)
        {
            dbCommand = database.GetStoredProcCommand("Proc_CouponRequestActDelete");
            database.AddInParameter(dbCommand, "CouponRequest_ID", DbType.String, Reg.CouponRequest_ID);
            database.AddInParameter(dbCommand, "IsActive", DbType.Int32, Reg.IsActive);
            database.AddInParameter(dbCommand, "IsDelete", DbType.Int32, Reg.IsDelete);
            database.AddInParameter(dbCommand, "DML", DbType.String, Reg.DML);
            database.ExecuteNonQuery(dbCommand);
        }
        #endregion

        #region Utility Funcion Get Code Gen ID & Set Code Gen ID
        public static string GetID(string Prfor)
        {
            dbCommand = database.GetSqlStringCommand("SELECT PrPrefix + CONVERT(varchar, PrStart) AS ID FROM Code_Gen WHERE (Prfor = '" + Prfor + "')");
            return database.ExecuteScalar(dbCommand).ToString();
        }
        public static void SetID(string Prfor)
        {
            dbCommand = database.GetSqlStringCommand("SELECT PrStart FROM Code_Gen WHERE (Prfor = '" + Prfor + "')");
            DataTable dt = database.ExecuteDataSet(dbCommand).Tables[0];
            if (dt.Rows.Count > 0)
            {
                Int64 p = Convert.ToInt32(dt.Rows[0]["PrStart"]);
                p++;
                dbCommand = database.GetSqlStringCommand("UPDATE Code_Gen SET  PrStart = '" + p + "' WHERE (Prfor = '" + Prfor + "')");
                database.ExecuteNonQuery(dbCommand);
            }
        }
        #endregion
    }
}