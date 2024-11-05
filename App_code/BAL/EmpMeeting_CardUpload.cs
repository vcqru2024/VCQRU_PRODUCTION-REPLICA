using System;
using System.Collections.Generic;
using System.Data;

namespace EmpMeetingBAL
{
	/// <summary>
	/// Business Logic class for table EmpMeeting_CardUpload
	/// </summary>
	public class EmpMeeting_CardUpload
	{
		#region Fields

		private int empMeeting_CardUploadid;
		private int meetingid;
		private string fileUploadName;
		private string fileUploadOriginalName;

		#endregion

		#region Constructors

		/// <summary>
		/// Initializes a new instance of the EmpMeeting_CardUpload class.
		/// </summary>
		public EmpMeeting_CardUpload()
		{
				InitVariables();
		}

		/// <summary>
		/// Initializes a new instance of the EmpMeeting_CardUpload class.
		/// </summary>
		public EmpMeeting_CardUpload(int meetingid, string fileUploadName, string fileUploadOriginalName)
		{
			this.meetingid = meetingid;
			this.fileUploadName = fileUploadName;
			this.fileUploadOriginalName = fileUploadOriginalName;
		}

		/// <summary>
		/// Initializes a new instance of the EmpMeeting_CardUpload class.
		/// </summary>
		public EmpMeeting_CardUpload(int empMeeting_CardUploadid, int meetingid, string fileUploadName, string fileUploadOriginalName)
		{
			this.empMeeting_CardUploadid = empMeeting_CardUploadid;
			this.meetingid = meetingid;
			this.fileUploadName = fileUploadName;
			this.fileUploadOriginalName = fileUploadOriginalName;
		}

		/// <summary>
		/// Initializes a new instance of the EmpMeeting_CardUpload class.
		/// </summary>
		public EmpMeeting_CardUpload(DataSet ds)
		{
			MakeObject(ds);
		}

		/// <summary>
		/// Initializes a new instance of the EmpMeeting_CardUpload class.
		/// </summary>
		public EmpMeeting_CardUpload(int empMeeting_CardUploadid)
		{
			DataSet ds = EmpMeeting_CardUpload.Select(empMeeting_CardUploadid);
			MakeObject(ds);
		}

		#endregion

		#region Properties

		/// <summary>
		/// Gets or sets the EmpMeeting_CardUploadid value.
		/// </summary>
		public virtual int EmpMeeting_CardUploadid
		{
			get { return empMeeting_CardUploadid; }
			set { empMeeting_CardUploadid = value; }
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
		/// Gets or sets the FileUploadName value.
		/// </summary>
		public virtual string FileUploadName
		{
			get { return fileUploadName; }
			set { fileUploadName = value; }
		}

		/// <summary>
		/// Gets or sets the FileUploadOriginalName value.
		/// </summary>
		public virtual string FileUploadOriginalName
		{
			get { return fileUploadOriginalName; }
			set { fileUploadOriginalName = value; }
		}

		#endregion

		#region Methods

		/// <summary>
		/// Initialize Variables
		/// </summary>
		public void InitVariables()
		{
			this.meetingid = 0;
			this.fileUploadName = string.Empty;
			this.fileUploadOriginalName = string.Empty;
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
				if (dt.Columns.Contains("EmpMeeting_CardUploadid"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["EmpMeeting_CardUploadid"]), out empMeeting_CardUploadid );
				}
				if (dt.Columns.Contains("Meetingid"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["Meetingid"]), out meetingid );
				}
				if (dt.Columns.Contains("FileUploadName"))
				{
					fileUploadName = Convert.ToString(dt.Rows[0]["FileUploadName"]);
				}
				if (dt.Columns.Contains("FileUploadOriginalName"))
				{
					fileUploadOriginalName = Convert.ToString(dt.Rows[0]["FileUploadOriginalName"]);
				}
			}
			else
				InitVariables();
		}

		/// <summary>
		/// Saves a record to the EmpMeeting_CardUpload table.
		/// </summary>
		public void Insert()
		{
			empMeeting_CardUploadid = EmpMeetingDAL.EmpMeeting_CardUpload.Insert(meetingid, fileUploadName, fileUploadOriginalName);
		}

		/// <summary>
		/// Updates a record in the EmpMeeting_CardUpload table.
		/// </summary>
		public void Update()
		{
			EmpMeetingDAL.EmpMeeting_CardUpload.Update(empMeeting_CardUploadid, meetingid, fileUploadName, fileUploadOriginalName);
		}

		/// <summary>
		/// Deletes a record from the EmpMeeting_CardUpload table by a composite primary key.
		/// </summary>
		public void Delete()
		{
			EmpMeetingDAL.EmpMeeting_CardUpload.Delete(empMeeting_CardUploadid);
		}

		/// <summary>
		/// Deletes a record from the EmpMeeting_CardUpload table by a foreign key.
		/// </summary>
		/// <param name="meetingid"></param>
		public static void DeleteByMeetingid(int meetingid)
		{
			EmpMeetingDAL.EmpMeeting_CardUpload.DeleteByMeetingid(meetingid);
		}

		/// <summary>
		/// Selects a single record from the EmpMeeting_CardUpload table.
		/// </summary>
		/// <param name="empMeeting_CardUploadid"></param>
		/// <returns>DataSet</returns>
		public static DataSet Select(int empMeeting_CardUploadid)
		{
			return EmpMeetingDAL.EmpMeeting_CardUpload.Select(empMeeting_CardUploadid);
		}

		/// <summary>
		/// Selects all records from the EmpMeeting_CardUpload table by a foreign key.
		/// </summary>
		/// <param name="meetingid"></param>
		/// <returns>DataSet</returns>
		public static DataSet SelectByMeetingid(int meetingid)
		{
			return EmpMeetingDAL.EmpMeeting_CardUpload.SelectByMeetingid(meetingid);
		}

		/// <summary>
		/// Selects all records from the EmpMeeting_CardUpload table.
		/// </summary>
		/// <returns>DataSet</returns>
		public static DataSet SelectAll()
		{
			return EmpMeetingDAL.EmpMeeting_CardUpload.SelectAll();
		}

		#endregion
	}
}
