using System;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace EmpMeetingDAL
{
	/// <summary>
	/// Data access class for table EmployeeMeetingMaster
	/// </summary>
	public sealed class EmployeeMeetingMaster
	{
		private EmployeeMeetingMaster() {}

		/// <summary>
		/// Inserts a record into the EmployeeMeetingMaster table.
		/// </summary>
		/// <param name="title"></param>
		/// <param name="employeeSupervisor"></param>
		/// <param name="createddate"></param>
		/// <param name="createdby"></param>
		/// <returns></returns>
		public static int Insert(string title, int employeeSupervisor, DateTime createddate, int createdby)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmployeeMeetingMasterInsert");

				db.AddInParameter(dbCommand, "Title", DbType.String, title);
				db.AddInParameter(dbCommand, "EmployeeSupervisor", DbType.Int32, employeeSupervisor);
				db.AddInParameter(dbCommand, "Createddate", DbType.DateTime, createddate);
				db.AddInParameter(dbCommand, "Createdby", DbType.Int32, createdby);

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
		/// Selects a single record from the EmployeeMeetingMaster table.
		/// </summary>
		/// <param name="emp_MeetingMasterId"></param>
		/// <returns>DataSet</returns>
		public static DataSet Select(int emp_MeetingMasterId)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmployeeMeetingMasterSelect");

				db.AddInParameter(dbCommand, "Emp_MeetingMasterId", DbType.Int32, emp_MeetingMasterId);

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
		/// Selects all records from the EmployeeMeetingMaster table.
		/// </summary>
		/// <returns>DataSet</returns>
		public static DataSet SelectAll()
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmployeeMeetingMasterSelectAll");

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
		/// Updates a record in the EmployeeMeetingMaster table.
		/// </summary>
		/// <param name="emp_MeetingMasterId"></param>
		/// <param name="title"></param>
		/// <param name="employeeSupervisor"></param>
		/// <param name="createddate"></param>
		/// <param name="createdby"></param>
		public static void Update(int emp_MeetingMasterId, string title, int employeeSupervisor, DateTime createddate, int createdby)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmployeeMeetingMasterUpdate");

				db.AddInParameter(dbCommand, "Emp_MeetingMasterId", DbType.Int32, emp_MeetingMasterId);
				db.AddInParameter(dbCommand, "Title", DbType.String, title);
				db.AddInParameter(dbCommand, "EmployeeSupervisor", DbType.Int32, employeeSupervisor);
				db.AddInParameter(dbCommand, "Createddate", DbType.DateTime, createddate);
				db.AddInParameter(dbCommand, "Createdby", DbType.Int32, createdby);

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
		/// Deletes a record from the EmployeeMeetingMaster table by a composite primary key.
		/// </summary>
		/// <param name="emp_MeetingMasterId"></param>
		public static void Delete(int emp_MeetingMasterId)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmployeeMeetingMasterDelete");

				db.AddInParameter(dbCommand, "Emp_MeetingMasterId", DbType.Int32, emp_MeetingMasterId);

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
