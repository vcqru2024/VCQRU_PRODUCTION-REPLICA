using System;
using System.Collections.Generic;
using System.Data;

namespace EmpMeetingBAL
{
	/// <summary>
	/// Business Logic class for table EmpMeeting_ServicesFor
	/// </summary>
	public class EmpMeeting_ServicesFor
	{
		#region Fields

		private int empMeeting_ServicesForId;
		private int meetingid;
		private string services;

		#endregion

		#region Constructors

		/// <summary>
		/// Initializes a new instance of the EmpMeeting_ServicesFor class.
		/// </summary>
		public EmpMeeting_ServicesFor()
		{
				InitVariables();
		}

		/// <summary>
		/// Initializes a new instance of the EmpMeeting_ServicesFor class.
		/// </summary>
		public EmpMeeting_ServicesFor(int meetingid, string services)
		{
			this.meetingid = meetingid;
			this.services = services;
		}

		/// <summary>
		/// Initializes a new instance of the EmpMeeting_ServicesFor class.
		/// </summary>
		public EmpMeeting_ServicesFor(int empMeeting_ServicesForId, int meetingid, string services)
		{
			this.empMeeting_ServicesForId = empMeeting_ServicesForId;
			this.meetingid = meetingid;
			this.services = services;
		}

		/// <summary>
		/// Initializes a new instance of the EmpMeeting_ServicesFor class.
		/// </summary>
		public EmpMeeting_ServicesFor(DataSet ds)
		{
			MakeObject(ds);
		}

		/// <summary>
		/// Initializes a new instance of the EmpMeeting_ServicesFor class.
		/// </summary>
		public EmpMeeting_ServicesFor(int empMeeting_ServicesForId)
		{
			DataSet ds = EmpMeeting_ServicesFor.Select(empMeeting_ServicesForId);
			MakeObject(ds);
		}

		#endregion

		#region Properties

		/// <summary>
		/// Gets or sets the EmpMeeting_ServicesForId value.
		/// </summary>
		public virtual int EmpMeeting_ServicesForId
		{
			get { return empMeeting_ServicesForId; }
			set { empMeeting_ServicesForId = value; }
		}

		/// <summary>
		/// Gets or sets the Meetingid value.
		/// </summary>
		public virtual int Meetingid
		{
			get { return meetingid; }
			set { meetingid = value; }
		}

		/// <summary>
		/// Gets or sets the Services value.
		/// </summary>
		public virtual string Services
		{
			get { return services; }
			set { services = value; }
		}

		#endregion

		#region Methods

		/// <summary>
		/// Initialize Variables
		/// </summary>
		public void InitVariables()
		{
			this.meetingid = 0;
			this.services = string.Empty;
		}

		/// <summary>
		/// Create object by DataSet
		/// </summary>
		/// <param name="ds"></param>
		private void MakeObject(DataSet ds)
		{
			if(ds.Tables.Count > 0 && ds.Tables[0].Rows.Count > 0)
			{
				DataTable dt = ds.Tables[0];
				if (dt.Columns.Contains("EmpMeeting_ServicesForId"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["EmpMeeting_ServicesForId"]), out empMeeting_ServicesForId );
				}
				if (dt.Columns.Contains("Meetingid"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["Meetingid"]), out meetingid );
				}
				if (dt.Columns.Contains("Services"))
				{
					services = Convert.ToString(dt.Rows[0]["Services"]);
				}
			}
			else
				InitVariables();
		}

		/// <summary>
		/// Saves a record to the EmpMeeting_ServicesFor table.
		/// </summary>
		public void Insert(string ServiceString)
		{
			empMeeting_ServicesForId = EmpMeetingDAL.EmpMeeting_ServicesFor.Insert(meetingid, services, ServiceString);
		}

		/// <summary>
		/// Updates a record in the EmpMeeting_ServicesFor table.
		/// </summary>
		public void Update()
		{
			EmpMeetingDAL.EmpMeeting_ServicesFor.Update(empMeeting_ServicesForId, meetingid, services);
		}

		/// <summary>
		/// Deletes a record from the EmpMeeting_ServicesFor table by a composite primary key.
		/// </summary>
		public void Delete()
		{
			EmpMeetingDAL.EmpMeeting_ServicesFor.Delete(empMeeting_ServicesForId);
		}

		/// <summary>
		/// Deletes a record from the EmpMeeting_ServicesFor table by a foreign key.
		/// </summary>
		/// <param name="meetingid"></param>
		public static void DeleteByMeetingid(int meetingid)
		{
			EmpMeetingDAL.EmpMeeting_ServicesFor.DeleteByMeetingid(meetingid);
		}

		/// <summary>
		/// Selects a single record from the EmpMeeting_ServicesFor table.
		/// </summary>
		/// <param name="empMeeting_ServicesForId"></param>
		/// <returns>DataSet</returns>
		public static DataSet Select(int empMeeting_ServicesForId)
		{
			return EmpMeetingDAL.EmpMeeting_ServicesFor.Select(empMeeting_ServicesForId);
		}

		/// <summary>
		/// Selects all records from the EmpMeeting_ServicesFor table by a foreign key.
		/// </summary>
		/// <param name="meetingid"></param>
		/// <returns>DataSet</returns>
		public static DataSet SelectByMeetingid(int meetingid)
		{
			return EmpMeetingDAL.EmpMeeting_ServicesFor.SelectByMeetingid(meetingid);
		}

		/// <summary>
		/// Selects all records from the EmpMeeting_ServicesFor table.
		/// </summary>
		/// <returns>DataSet</returns>
		public static DataSet SelectAll()
		{
			return EmpMeetingDAL.EmpMeeting_ServicesFor.SelectAll();
		}

		#endregion
	}
}
