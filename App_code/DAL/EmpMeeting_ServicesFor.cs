using System;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace EmpMeetingDAL
{
	/// <summary>
	/// Data access class for table EmpMeeting_ServicesFor
	/// </summary>
	public sealed class EmpMeeting_ServicesFor
	{
		private EmpMeeting_ServicesFor() {}

		/// <summary>
		/// Inserts a record into the EmpMeeting_ServicesFor table.
		/// </summary>
		/// <param name="meetingid"></param>
		/// <param name="services"></param>
		/// <returns></returns>
		public static int Insert(int meetingid, string services,string ServiceString)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmpMeeting_ServicesForInsert");

				db.AddInParameter(dbCommand, "Meetingid", DbType.Int32, meetingid);
				db.AddInParameter(dbCommand, "Services", DbType.String, services);
                db.AddInParameter(dbCommand, "ServiceString", DbType.String, ServiceString);
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
		/// Selects a single record from the EmpMeeting_ServicesFor table.
		/// </summary>
		/// <param name="empMeeting_ServicesForId"></param>
		/// <returns>DataSet</returns>
		public static DataSet Select(int empMeeting_ServicesForId)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmpMeeting_ServicesForSelect");

				db.AddInParameter(dbCommand, "EmpMeeting_ServicesForId", DbType.Int32, empMeeting_ServicesForId);

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
		/// Selects all records from the EmpMeeting_ServicesFor table by a foreign key.
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
				dbCommand = db.GetStoredProcCommand("EmpMeeting_ServicesForSelectByMeetingid");

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
		/// Selects all records from the EmpMeeting_ServicesFor table.
		/// </summary>
		/// <returns>DataSet</returns>
		public static DataSet SelectAll()
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmpMeeting_ServicesForSelectAll");

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
		/// Updates a record in the EmpMeeting_ServicesFor table.
		/// </summary>
		/// <param name="empMeeting_ServicesForId"></param>
		/// <param name="meetingid"></param>
		/// <param name="services"></param>
		public static void Update(int empMeeting_ServicesForId, int meetingid, string services)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmpMeeting_ServicesForUpdate");

				db.AddInParameter(dbCommand, "EmpMeeting_ServicesForId", DbType.Int32, empMeeting_ServicesForId);
				db.AddInParameter(dbCommand, "Meetingid", DbType.Int32, meetingid);
				db.AddInParameter(dbCommand, "Services", DbType.String, services);

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
		/// Deletes a record from the EmpMeeting_ServicesFor table by a composite primary key.
		/// </summary>
		/// <param name="empMeeting_ServicesForId"></param>
		public static void Delete(int empMeeting_ServicesForId)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmpMeeting_ServicesForDelete");

				db.AddInParameter(dbCommand, "EmpMeeting_ServicesForId", DbType.Int32, empMeeting_ServicesForId);

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
		/// Deletes a record from the EmpMeeting_ServicesFor table by a foreign key.
		/// </summary>
		/// <param name="meetingid"></param>
		public static void DeleteByMeetingid(int meetingid)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("EmpMeeting_ServicesForDeleteByMeetingid");

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
