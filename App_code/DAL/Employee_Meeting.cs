using System;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace EmpMeetingBAL
{
	/// <summary>
	/// Data access class for table Employee_Meeting
	/// </summary>
	public sealed class Employee_MeetingDAL
	{
		private Employee_MeetingDAL() {}

		/// <summary>
		/// Inserts a record into the Employee_Meeting table.
		/// </summary>
		/// <param name="companyName"></param>
		/// <param name="personName"></param>
		/// <param name="email"></param>
		/// <param name="mobileNo"></param>
		/// <param name="meetingDate"></param>
		/// <param name="meetingTime"></param>
		/// <param name="meetingStatus"></param>
		/// <param name="followUpdate"></param>
		/// <param name="followupTime"></param>
		/// <param name="followUpPerson"></param>
		/// <param name="followUpDesignation"></param>
		/// <param name="followUpEmail"></param>
		/// <param name="followUpMobile"></param>
		/// <param name="visitStatus"></param>
		/// <param name="employeeid"></param>
		/// <param name="employeeSupervisor"></param>
		/// <param name="createdDate"></param>
		/// <param name="createdBy"></param>
		/// <param name="modifiedDate"></param>
		/// <param name="modifiedBy"></param>
		/// <param name="isActive"></param>
		/// <param name="isDelete"></param>
		/// <returns></returns>
		public static int Insert(string companyName, string personName, string email, string mobileNo, DateTime meetingDate, string meetingTime, 
            short meetingStatus, DateTime? followUpdate, string followupTime, string followUpPerson, string followUpDesignation, string followUpEmail, 
            string followUpMobile, string visitStatus, int employeeid, int employeeSupervisor,int meetingMasterID, DateTime createdDate, int createdBy, DateTime modifiedDate, int modifiedBy, bool isActive, bool isDelete)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("Employee_MeetingInsert1");

				db.AddInParameter(dbCommand, "CompanyName", DbType.String, companyName);
				db.AddInParameter(dbCommand, "PersonName", DbType.String, personName);
				db.AddInParameter(dbCommand, "Email", DbType.String, email);
				db.AddInParameter(dbCommand, "MobileNo", DbType.String, mobileNo);
				db.AddInParameter(dbCommand, "MeetingDate", DbType.DateTime, meetingDate);
				db.AddInParameter(dbCommand, "MeetingTime", DbType.String, meetingTime);
				db.AddInParameter(dbCommand, "MeetingStatus", DbType.Int16, meetingStatus);
				db.AddInParameter(dbCommand, "FollowUpdate", DbType.DateTime, followUpdate);
				db.AddInParameter(dbCommand, "FollowupTime", DbType.String, followupTime);
				db.AddInParameter(dbCommand, "FollowUpPerson", DbType.String, followUpPerson);
				db.AddInParameter(dbCommand, "FollowUpDesignation", DbType.String, followUpDesignation);
				db.AddInParameter(dbCommand, "FollowUpEmail", DbType.String, followUpEmail);
				db.AddInParameter(dbCommand, "FollowUpMobile", DbType.String, followUpMobile);
				db.AddInParameter(dbCommand, "VisitStatus", DbType.String, visitStatus);
				db.AddInParameter(dbCommand, "Employeeid", DbType.Int32, employeeid);
				db.AddInParameter(dbCommand, "EmployeeSupervisor", DbType.Int32, employeeSupervisor);
                db.AddInParameter(dbCommand, "MeetingMasterID", DbType.Int32, meetingMasterID);
				db.AddInParameter(dbCommand, "CreatedDate", DbType.DateTime, createdDate);
				db.AddInParameter(dbCommand, "CreatedBy", DbType.Int32, createdBy);
				//db.AddInParameter(dbCommand, "ModifiedDate", DbType.DateTime, modifiedDate);
				//db.AddInParameter(dbCommand, "ModifiedBy", DbType.Int32, modifiedBy);
				db.AddInParameter(dbCommand, "IsActive", DbType.Boolean, isActive);
				//db.AddInParameter(dbCommand, "IsDelete", DbType.Boolean, isDelete);

				// Execute the query and return the new identity value
				int returnValue = Convert.ToInt32(db.ExecuteScalar(dbCommand));

				return returnValue;
			}
			catch (Exception)
			{
				throw;
			}
			finally
			{
				if (dbCommand != null)
				{
					dbCommand.Dispose();
					dbCommand = null;
				}
				if (db != null)
					db = null;
			}
		}

		/// <summary>
		/// Selects a single record from the Employee_Meeting table.
		/// </summary>
		/// <param name="meetingID"></param>
		/// <returns>DataSet</returns>
		public static DataSet Select(int meetingID)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("Employee_MeetingSelect");

				db.AddInParameter(dbCommand, "MeetingID", DbType.Int32, meetingID);

				return db.ExecuteDataSet(dbCommand);
			}
			catch (Exception)
			{
				throw;
			}
			finally
			{
				if (dbCommand != null)
				{
					dbCommand.Dispose();
					dbCommand = null;
				}
				if (db != null)
					db = null;
			}
		}

		/// <summary>
		/// Selects all records from the Employee_Meeting table.
		/// </summary>
		/// <returns>DataSet</returns>
		public static DataSet SelectAll(int EmpID, string compname, string mobileno, DateTime? dtfrom, DateTime? dtto, int Empid2)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
                db = DatabaseFactory.CreateDatabase();

                dbCommand = db.GetStoredProcCommand("Employee_MeetingSelectAll1");
                db.AddInParameter(dbCommand, "EmpID", DbType.Int32, EmpID);
                db.AddInParameter(dbCommand, "@CompanyName", DbType.String, compname);
                db.AddInParameter(dbCommand, "@Mobileno", DbType.String, mobileno);
                db.AddInParameter(dbCommand, "@dtFrom", DbType.DateTime, dtfrom);
                db.AddInParameter(dbCommand, "@dtTo", DbType.DateTime, dtto);
                db.AddInParameter(dbCommand, "@Empid2", DbType.Int32, Empid2);
                return db.ExecuteDataSet(dbCommand);
              
			}
			catch (Exception)
			{
				throw;
			}
			finally
			{
				if (dbCommand != null)
				{
					dbCommand.Dispose();
					dbCommand = null;
				}
				if (db != null)
					db = null;
			}
		}

		/// <summary>
		/// Updates a record in the Employee_Meeting table.
		/// </summary>
		/// <param name="meetingID"></param>
		/// <param name="companyName"></param>
		/// <param name="personName"></param>
		/// <param name="email"></param>
		/// <param name="mobileNo"></param>
		/// <param name="meetingDate"></param>
		/// <param name="meetingTime"></param>
		/// <param name="meetingStatus"></param>
		/// <param name="followUpdate"></param>
		/// <param name="followupTime"></param>
		/// <param name="followUpPerson"></param>
		/// <param name="followUpDesignation"></param>
		/// <param name="followUpEmail"></param>
		/// <param name="followUpMobile"></param>
		/// <param name="visitStatus"></param>
		/// <param name="employeeid"></param>
		/// <param name="employeeSupervisor"></param>
		/// <param name="createdDate"></param>
		/// <param name="createdBy"></param>
		/// <param name="modifiedDate"></param>
		/// <param name="modifiedBy"></param>
		/// <param name="isActive"></param>
		/// <param name="isDelete"></param>
		public static void Update(int meetingID, string companyName, string personName, string email, string mobileNo, DateTime meetingDate, string meetingTime, short meetingStatus, DateTime? followUpdate, string followupTime, string followUpPerson, string followUpDesignation, string followUpEmail, string followUpMobile, string visitStatus, int employeeid, int employeeSupervisor, DateTime createdDate, int createdBy, DateTime modifiedDate, int modifiedBy, bool isActive, bool isDelete)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("Employee_MeetingUpdate1");

				db.AddInParameter(dbCommand, "MeetingID", DbType.Int32, meetingID);
				db.AddInParameter(dbCommand, "CompanyName", DbType.String, companyName);
				db.AddInParameter(dbCommand, "PersonName", DbType.String, personName);
				db.AddInParameter(dbCommand, "Email", DbType.String, email);
				db.AddInParameter(dbCommand, "MobileNo", DbType.String, mobileNo);
				db.AddInParameter(dbCommand, "MeetingDate", DbType.DateTime, meetingDate);
				db.AddInParameter(dbCommand, "MeetingTime", DbType.String, meetingTime);
				db.AddInParameter(dbCommand, "MeetingStatus", DbType.Int16, meetingStatus);
				db.AddInParameter(dbCommand, "FollowUpdate", DbType.DateTime, followUpdate);
				db.AddInParameter(dbCommand, "FollowupTime", DbType.String, followupTime);
				db.AddInParameter(dbCommand, "FollowUpPerson", DbType.String, followUpPerson);
				db.AddInParameter(dbCommand, "FollowUpDesignation", DbType.String, followUpDesignation);
				db.AddInParameter(dbCommand, "FollowUpEmail", DbType.String, followUpEmail);
				db.AddInParameter(dbCommand, "FollowUpMobile", DbType.String, followUpMobile);
				db.AddInParameter(dbCommand, "VisitStatus", DbType.String, visitStatus);
				db.AddInParameter(dbCommand, "Employeeid", DbType.Int32, employeeid);
				db.AddInParameter(dbCommand, "EmployeeSupervisor", DbType.Int32, employeeSupervisor);
				//db.AddInParameter(dbCommand, "CreatedDate", DbType.DateTime, createdDate);
			//	db.AddInParameter(dbCommand, "CreatedBy", DbType.Int32, createdBy);
				db.AddInParameter(dbCommand, "ModifiedDate", DbType.DateTime, modifiedDate);
				db.AddInParameter(dbCommand, "ModifiedBy", DbType.Int32, modifiedBy);
			//	db.AddInParameter(dbCommand, "IsActive", DbType.Boolean, isActive);
			//	db.AddInParameter(dbCommand, "IsDelete", DbType.Boolean, isDelete);

				db.ExecuteNonQuery(dbCommand);
			}
			catch (Exception)
			{
				throw;
			}
			finally
			{
				if (dbCommand != null)
				{
					dbCommand.Dispose();
					dbCommand = null;
				}
				if (db != null)
					db = null;
			}
		}

		/// <summary>
		/// Deletes a record from the Employee_Meeting table by a composite primary key.
		/// </summary>
		/// <param name="meetingID"></param>
		public static void Delete(int meetingID)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("Employee_MeetingDelete");

				db.AddInParameter(dbCommand, "MeetingID", DbType.Int32, meetingID);

				db.ExecuteNonQuery(dbCommand);
			}
			catch (Exception)
			{
				throw;
			}
			finally
			{
				if (dbCommand != null)
				{
					dbCommand.Dispose();
					dbCommand = null;
				}
				if (db != null)
					db = null;
			}
		}
	}
}
