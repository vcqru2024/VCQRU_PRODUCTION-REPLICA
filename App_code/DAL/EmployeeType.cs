using System;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace EmpMeetingDAL
{
	/// <summary>
	/// Data access class for table EmployeeType
	/// </summary>
	public sealed class EmployeeType
	{
		private EmployeeType() {}

		/// <summary>
		/// Inserts a record into the EmployeeType table.
		/// </summary>
		/// <param name="type"></param>
		/// <returns></returns>
		public static int Insert(string type)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmployeeTypeInsert");

				db.AddInParameter(dbCommand, "Type", DbType.String, type);

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
		/// Selects a single record from the EmployeeType table.
		/// </summary>
		/// <param name="employeeTypeid"></param>
		/// <returns>DataSet</returns>
		public static DataSet Select(int employeeTypeid)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmployeeTypeSelect");

				db.AddInParameter(dbCommand, "EmployeeTypeid", DbType.Int32, employeeTypeid);

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
		/// Selects all records from the EmployeeType table.
		/// </summary>
		/// <returns>DataSet</returns>
		public static DataSet SelectAll()
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmployeeTypeSelectAll");

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
		/// Updates a record in the EmployeeType table.
		/// </summary>
		/// <param name="employeeTypeid"></param>
		/// <param name="type"></param>
		public static void Update(int employeeTypeid, string type)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmployeeTypeUpdate");

				db.AddInParameter(dbCommand, "EmployeeTypeid", DbType.Int32, employeeTypeid);
				db.AddInParameter(dbCommand, "Type", DbType.String, type);

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
		/// Deletes a record from the EmployeeType table by a composite primary key.
		/// </summary>
		/// <param name="employeeTypeid"></param>
		public static void Delete(int employeeTypeid)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmployeeTypeDelete");

				db.AddInParameter(dbCommand, "EmployeeTypeid", DbType.Int32, employeeTypeid);

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
