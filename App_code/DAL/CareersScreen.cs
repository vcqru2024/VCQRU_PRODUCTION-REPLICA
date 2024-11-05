using System;
using System.Data;
using System.Data.Common;
using Microsoft.Practices.EnterpriseLibrary.Data;

namespace Career
{
	/// <summary>
	/// Data access class for table CareersScreen
	/// </summary>
	public sealed class CareersScreenDal
	{
		private CareersScreenDal() {}

		/// <summary>
		/// Inserts a record into the CareersScreen table.
		/// </summary>
		/// <param name="jobCategory"></param>
		/// <param name="preferredLocation"></param>
		/// <param name="availability"></param>
		/// <param name="positionApplyFor"></param>
		/// <param name="resumeName"></param>
		/// <param name="resumeName2"></param>
		/// <param name="fullName"></param>
		/// <param name="emailAddress"></param>
		/// <param name="yearsOfExp"></param>
		/// <param name="skills"></param>
		/// <param name="country"></param>
		/// <param name="state"></param>
		/// <param name="city"></param>
		/// <param name="findVcqru"></param>
		/// <param name="active"></param>
		/// <param name="createdDate"></param>
		/// <param name="createdBy"></param>
		/// <returns></returns>
		public static int Insert(int jobCategory, string preferredLocation, int availability, string positionApplyFor, string resumeName, string resumeName2, string fullName, string emailAddress, int yearsOfExp, string skills, string country, string state, string city, int findVcqru, bool active, DateTime createdDate, int createdBy)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("CareersScreenInsert");

				db.AddInParameter(dbCommand, "JobCategory", DbType.Int32, jobCategory);
				db.AddInParameter(dbCommand, "PreferredLocation", DbType.String, preferredLocation);
				db.AddInParameter(dbCommand, "Availability", DbType.Int32, availability);
				db.AddInParameter(dbCommand, "PositionApplyFor", DbType.String, positionApplyFor);
				db.AddInParameter(dbCommand, "ResumeName", DbType.String, resumeName);
				db.AddInParameter(dbCommand, "ResumeName2", DbType.String, resumeName2);
				db.AddInParameter(dbCommand, "FullName", DbType.String, fullName);
				db.AddInParameter(dbCommand, "EmailAddress", DbType.String, emailAddress);
				db.AddInParameter(dbCommand, "YearsOfExp", DbType.Int32, yearsOfExp);
				db.AddInParameter(dbCommand, "Skills", DbType.String, skills);
				db.AddInParameter(dbCommand, "Country", DbType.String, country);
				db.AddInParameter(dbCommand, "State", DbType.String, state);
				db.AddInParameter(dbCommand, "City", DbType.String, city);
				db.AddInParameter(dbCommand, "FindVcqru", DbType.Int32, findVcqru);
				db.AddInParameter(dbCommand, "Active", DbType.Boolean, active);
				db.AddInParameter(dbCommand, "CreatedDate", DbType.DateTime, createdDate);
				db.AddInParameter(dbCommand, "CreatedBy", DbType.Int32, createdBy);

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
		/// Selects a single record from the CareersScreen table.
		/// </summary>
		/// <param name="careersid"></param>
		/// <returns>DataSet</returns>
		public static DataSet Select(int careersid)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("CareersScreenSelect");

				db.AddInParameter(dbCommand, "Careersid", DbType.Int32, careersid);

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
		/// Selects all records from the CareersScreen table.
		/// </summary>
		/// <returns>DataSet</returns>
		public static DataSet SelectAll()
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("CareersScreenSelectAll");

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
        public static void UpdateResume(string resumename, string resumename2, int careers_id)
        {
            Database db = null;
            DbCommand dbCommand = null;
            try
            {
                db = DatabaseFactory.CreateDatabase();
                dbCommand = db.GetStoredProcCommand("CareersScreenUpdateResume");

                db.AddInParameter(dbCommand, "Careersid", DbType.Int32, careers_id);
               
                db.AddInParameter(dbCommand, "ResumeName", DbType.String, resumename);
                db.AddInParameter(dbCommand, "ResumeName2", DbType.String, resumename2);
              
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
        /// Updates a record in the CareersScreen table.
        /// </summary>
        /// <param name="careersid"></param>
        /// <param name="jobCategory"></param>
        /// <param name="preferredLocation"></param>
        /// <param name="availability"></param>
        /// <param name="positionApplyFor"></param>
        /// <param name="resumeName"></param>
        /// <param name="resumeName2"></param>
        /// <param name="fullName"></param>
        /// <param name="emailAddress"></param>
        /// <param name="yearsOfExp"></param>
        /// <param name="skills"></param>
        /// <param name="country"></param>
        /// <param name="state"></param>
        /// <param name="city"></param>
        /// <param name="findVcqru"></param>
        /// <param name="active"></param>
        /// <param name="createdDate"></param>
        /// <param name="createdBy"></param>
        public static void Update(int careersid, int jobCategory, string preferredLocation, int availability, string positionApplyFor, string resumeName, string resumeName2, string fullName, string emailAddress, int yearsOfExp, string skills, string country, string state, string city, int findVcqru, bool active, DateTime createdDate, int createdBy)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("CareersScreenUpdate");

				db.AddInParameter(dbCommand, "Careersid", DbType.Int32, careersid);
				db.AddInParameter(dbCommand, "JobCategory", DbType.Int32, jobCategory);
				db.AddInParameter(dbCommand, "PreferredLocation", DbType.String, preferredLocation);
				db.AddInParameter(dbCommand, "Availability", DbType.Int32, availability);
				db.AddInParameter(dbCommand, "PositionApplyFor", DbType.String, positionApplyFor);
				db.AddInParameter(dbCommand, "ResumeName", DbType.String, resumeName);
				db.AddInParameter(dbCommand, "ResumeName2", DbType.String, resumeName2);
				db.AddInParameter(dbCommand, "FullName", DbType.String, fullName);
				db.AddInParameter(dbCommand, "EmailAddress", DbType.String, emailAddress);
				db.AddInParameter(dbCommand, "YearsOfExp", DbType.Int32, yearsOfExp);
				db.AddInParameter(dbCommand, "Skills", DbType.String, skills);
				db.AddInParameter(dbCommand, "Country", DbType.String, country);
				db.AddInParameter(dbCommand, "State", DbType.String, state);
				db.AddInParameter(dbCommand, "City", DbType.String, city);
				db.AddInParameter(dbCommand, "FindVcqru", DbType.Int32, findVcqru);
				db.AddInParameter(dbCommand, "Active", DbType.Boolean, active);
				db.AddInParameter(dbCommand, "CreatedDate", DbType.DateTime, createdDate);
				db.AddInParameter(dbCommand, "CreatedBy", DbType.Int32, createdBy);

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
		/// Deletes a record from the CareersScreen table by a composite primary key.
		/// </summary>
		/// <param name="careersid"></param>
		public static void Delete(int careersid)
		{
			Database db = null;
			DbCommand dbCommand = null;
			try
			{
				db = DatabaseFactory.CreateDatabase();
				dbCommand = db.GetStoredProcCommand("CareersScreenDelete");

				db.AddInParameter(dbCommand, "Careersid", DbType.Int32, careersid);

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
