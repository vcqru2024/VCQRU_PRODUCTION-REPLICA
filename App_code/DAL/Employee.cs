using System;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace EmpMeetingDAL
{
	/// <summary>
	/// Data access class for table Employee
	/// </summary>
	public sealed class Employee
	{
		private Employee() {}

		/// <summary>
		/// Inserts a record into the Employee table.
		/// </summary>
		/// <param name="name"></param>
		/// <param name="address"></param>
		/// <param name="email"></param>
		/// <param name="mobileno"></param>
		/// <param name="pwd"></param>
		/// <param name="city"></param>
		/// <param name="pincode"></param>
		/// <param name="emp_type"></param>
		/// <param name="createddate"></param>
		/// <param name="createdby"></param>
		/// <param name="modifieddate"></param>
		/// <param name="modifiedby"></param>
		/// <param name="active"></param>
		/// <param name="dalete"></param>
		/// <returns></returns>
		public static int Insert(string name, string address, string email, string mobileno, string pwd, string city, string pincode, short emp_type, DateTime createddate, int createdby, DateTime modifieddate, int modifiedby, bool active, bool dalete)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmployeeInsert");

				db.AddInParameter(dbCommand, "name", DbType.String, name);
				db.AddInParameter(dbCommand, "Address", DbType.String, address);
				db.AddInParameter(dbCommand, "Email", DbType.String, email);
				db.AddInParameter(dbCommand, "mobileno", DbType.String, mobileno);
				db.AddInParameter(dbCommand, "pwd", DbType.String, pwd);
				db.AddInParameter(dbCommand, "city", DbType.String, city);
				db.AddInParameter(dbCommand, "pincode", DbType.String, pincode);
				db.AddInParameter(dbCommand, "Emp_type", DbType.Int16, emp_type);
				db.AddInParameter(dbCommand, "createddate", DbType.DateTime, createddate);
				db.AddInParameter(dbCommand, "createdby", DbType.Int32, createdby);
				db.AddInParameter(dbCommand, "modifieddate", DbType.DateTime, modifieddate);
				db.AddInParameter(dbCommand, "modifiedby", DbType.Int32, modifiedby);
				db.AddInParameter(dbCommand, "active", DbType.Boolean, active);
				db.AddInParameter(dbCommand, "dalete", DbType.Boolean, dalete);

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
		/// Selects a single record from the Employee table.
		/// </summary>
		/// <param name="employeeID"></param>
		/// <returns>DataSet</returns>
		public static DataSet Select(int employeeID)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmployeeSelect");

				db.AddInParameter(dbCommand, "EmployeeID", DbType.Int32, employeeID);

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
		/// Selects all records from the Employee table.
		/// </summary>
		/// <returns>DataSet</returns>
		public static DataSet SelectAll()
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmployeeSelectAll");

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
		/// Updates a record in the Employee table.
		/// </summary>
		/// <param name="employeeID"></param>
		/// <param name="name"></param>
		/// <param name="address"></param>
		/// <param name="email"></param>
		/// <param name="mobileno"></param>
		/// <param name="pwd"></param>
		/// <param name="city"></param>
		/// <param name="pincode"></param>
		/// <param name="emp_type"></param>
		/// <param name="createddate"></param>
		/// <param name="createdby"></param>
		/// <param name="modifieddate"></param>
		/// <param name="modifiedby"></param>
		/// <param name="active"></param>
		/// <param name="dalete"></param>
		public static void Update(int employeeID, string name, string address, string email, string mobileno, string pwd, string city, string pincode, short emp_type, DateTime createddate, int createdby, DateTime modifieddate, int modifiedby, bool active, bool dalete)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmployeeUpdate");

				db.AddInParameter(dbCommand, "EmployeeID", DbType.Int32, employeeID);
				db.AddInParameter(dbCommand, "name", DbType.String, name);
				db.AddInParameter(dbCommand, "Address", DbType.String, address);
				db.AddInParameter(dbCommand, "Email", DbType.String, email);
				db.AddInParameter(dbCommand, "mobileno", DbType.String, mobileno);
				db.AddInParameter(dbCommand, "pwd", DbType.String, pwd);
				db.AddInParameter(dbCommand, "city", DbType.String, city);
				db.AddInParameter(dbCommand, "pincode", DbType.String, pincode);
				db.AddInParameter(dbCommand, "Emp_type", DbType.Int16, emp_type);
				db.AddInParameter(dbCommand, "createddate", DbType.DateTime, createddate);
				db.AddInParameter(dbCommand, "createdby", DbType.Int32, createdby);
				db.AddInParameter(dbCommand, "modifieddate", DbType.DateTime, modifieddate);
				db.AddInParameter(dbCommand, "modifiedby", DbType.Int32, modifiedby);
				db.AddInParameter(dbCommand, "active", DbType.Boolean, active);
				db.AddInParameter(dbCommand, "dalete", DbType.Boolean, dalete);

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
		/// Deletes a record from the Employee table by a composite primary key.
		/// </summary>
		/// <param name="employeeID"></param>
		public static void Delete(int employeeID)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmployeeDelete");

				db.AddInParameter(dbCommand, "EmployeeID", DbType.Int32, employeeID);

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
