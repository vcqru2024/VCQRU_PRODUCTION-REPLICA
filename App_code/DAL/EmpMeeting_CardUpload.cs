using System;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace EmpMeetingDAL
{
	/// <summary>
	/// Data access class for table EmpMeeting_CardUpload
	/// </summary>
	public sealed class EmpMeeting_CardUpload
	{
		private EmpMeeting_CardUpload() {}

		/// <summary>
		/// Inserts a record into the EmpMeeting_CardUpload table.
		/// </summary>
		/// <param name="meetingid"></param>
		/// <param name="fileUploadName"></param>
		/// <param name="fileUploadOriginalName"></param>
		/// <returns></returns>
		public static int Insert(int meetingid, string fileUploadName, string fileUploadOriginalName)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmpMeeting_CardUploadInsert");

				db.AddInParameter(dbCommand, "Meetingid", DbType.Int32, meetingid);
				db.AddInParameter(dbCommand, "FileUploadName", DbType.String, fileUploadName);
				db.AddInParameter(dbCommand, "FileUploadOriginalName", DbType.String, fileUploadOriginalName);

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
		/// Selects a single record from the EmpMeeting_CardUpload table.
		/// </summary>
		/// <param name="empMeeting_CardUploadid"></param>
		/// <returns>DataSet</returns>
		public static DataSet Select(int empMeeting_CardUploadid)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmpMeeting_CardUploadSelect");

				db.AddInParameter(dbCommand, "EmpMeeting_CardUploadid", DbType.Int32, empMeeting_CardUploadid);

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
		/// Selects all records from the EmpMeeting_CardUpload table by a foreign key.
		/// </summary>
		/// <param name="meetingid"></param>
		/// <returns>DataSet</returns>
		public static DataSet SelectByMeetingid(int meetingid)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmpMeeting_CardUploadSelectByMeetingid");

				db.AddInParameter(dbCommand, "Meetingid", DbType.Int32, meetingid);

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
		/// Selects all records from the EmpMeeting_CardUpload table.
		/// </summary>
		/// <returns>DataSet</returns>
		public static DataSet SelectAll()
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmpMeeting_CardUploadSelectAll");

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
		/// Updates a record in the EmpMeeting_CardUpload table.
		/// </summary>
		/// <param name="empMeeting_CardUploadid"></param>
		/// <param name="meetingid"></param>
		/// <param name="fileUploadName"></param>
		/// <param name="fileUploadOriginalName"></param>
		public static void Update(int empMeeting_CardUploadid, int meetingid, string fileUploadName, string fileUploadOriginalName)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmpMeeting_CardUploadUpdate");

				db.AddInParameter(dbCommand, "EmpMeeting_CardUploadid", DbType.Int32, empMeeting_CardUploadid);
				db.AddInParameter(dbCommand, "Meetingid", DbType.Int32, meetingid);
				db.AddInParameter(dbCommand, "FileUploadName", DbType.String, fileUploadName);
				db.AddInParameter(dbCommand, "FileUploadOriginalName", DbType.String, fileUploadOriginalName);

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
		/// Deletes a record from the EmpMeeting_CardUpload table by a composite primary key.
		/// </summary>
		/// <param name="empMeeting_CardUploadid"></param>
		public static void Delete(int empMeeting_CardUploadid)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmpMeeting_CardUploadDelete");

				db.AddInParameter(dbCommand, "EmpMeeting_CardUploadid", DbType.Int32, empMeeting_CardUploadid);

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
		/// Deletes a record from the EmpMeeting_CardUpload table by a foreign key.
		/// </summary>
		/// <param name="meetingid"></param>
		public static void DeleteByMeetingid(int meetingid)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmpMeeting_CardUploadDeleteByMeetingid");

				db.AddInParameter(dbCommand, "Meetingid", DbType.Int32, meetingid);

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
