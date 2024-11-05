using System;
using System.Collections.Generic;
using System.Data;
using EmpMeetingDAL;

namespace EmpMeetingBAL
{
	/// <summary>
	/// Business Logic class for table Employee_Meeting
	/// </summary>
	public class Employee_MeetingBAL
	{
		#region Fields

		private int meetingID;
		private string companyName;
		private string personName;
		private string email;
		private string mobileNo;
		private DateTime meetingDate;
		private string meetingTime;
		private short meetingStatus;
		private DateTime? followUpdate;
		private string followupTime;
		private string followUpPerson;
		private string followUpDesignation;
		private string followUpEmail;
		private string followUpMobile;
		private string visitStatus;
		private int employeeid;
		private int employeeSupervisor;
        private int meetingMasterID;
		private DateTime createdDate;
		private int createdBy;
		private DateTime modifiedDate;
		private int modifiedBy;
		private bool isActive;
		private bool isDelete;

		#endregion

		#region Constructors

		/// <summary>
		/// Initializes a new instance of the Employee_Meeting class.
		/// </summary>
		public Employee_MeetingBAL()
		{
				InitVariables();
		}

		/// <summary>
		/// Initializes a new instance of the Employee_Meeting class.
		/// </summary>
		public Employee_MeetingBAL(string companyName, string personName, string email, string mobileNo, DateTime meetingDate, string meetingTime,
            short meetingStatus, DateTime followUpdate, string followupTime, string followUpPerson, string followUpDesignation, string followUpEmail, 
            string followUpMobile, string visitStatus, int employeeid, int employeeSupervisor,int MeetingMasterID, DateTime createdDate, int createdBy, DateTime modifiedDate, 
            int modifiedBy, bool isActive, bool isDelete)
		{
			this.companyName = companyName;
			this.personName = personName;
			this.email = email;
			this.mobileNo = mobileNo;
			this.meetingDate = meetingDate;
			this.meetingTime = meetingTime;
			this.meetingStatus = meetingStatus;
			this.followUpdate = followUpdate;
			this.followupTime = followupTime;
			this.followUpPerson = followUpPerson;
			this.followUpDesignation = followUpDesignation;
			this.followUpEmail = followUpEmail;
			this.followUpMobile = followUpMobile;
			this.visitStatus = visitStatus;
			this.employeeid = employeeid;
			this.employeeSupervisor = employeeSupervisor;
            this.MeetingMasterID = MeetingMasterID;
            this.createdDate = createdDate;
			this.createdBy = createdBy;
			this.modifiedDate = modifiedDate;
			this.modifiedBy = modifiedBy;
			this.isActive = isActive;
			this.isDelete = isDelete;
		}

		/// <summary>
		/// Initializes a new instance of the Employee_Meeting class.
		/// </summary>
		public Employee_MeetingBAL(int meetingID, string companyName, string personName, string email, string mobileNo, DateTime meetingDate, string meetingTime, short meetingStatus, DateTime followUpdate, string followupTime, string followUpPerson, string followUpDesignation, string followUpEmail, string followUpMobile, string visitStatus, int employeeid, int employeeSupervisor,int meetingMasterID, DateTime createdDate, int createdBy, DateTime modifiedDate, int modifiedBy, bool isActive, bool isDelete)
		{
			this.meetingID = meetingID;
			this.companyName = companyName;
			this.personName = personName;
			this.email = email;
			this.mobileNo = mobileNo;
			this.meetingDate = meetingDate;
			this.meetingTime = meetingTime;
			this.meetingStatus = meetingStatus;
			this.followUpdate = followUpdate;
			this.followupTime = followupTime;
			this.followUpPerson = followUpPerson;
			this.followUpDesignation = followUpDesignation;
			this.followUpEmail = followUpEmail;
			this.followUpMobile = followUpMobile;
			this.visitStatus = visitStatus;
			this.employeeid = employeeid;
			this.employeeSupervisor = employeeSupervisor;
            this.meetingMasterID = meetingMasterID;
            this.createdDate = createdDate;
			this.createdBy = createdBy;
			this.modifiedDate = modifiedDate;
			this.modifiedBy = modifiedBy;
			this.isActive = isActive;
			this.isDelete = isDelete;
		}

		/// <summary>
		/// Initializes a new instance of the Employee_Meeting class.
		/// </summary>
		public Employee_MeetingBAL(DataSet ds)
		{
			MakeObject(ds);
		}

		/// <summary>
		/// Initializes a new instance of the Employee_Meeting class.
		/// </summary>
		public Employee_MeetingBAL(int meetingID)
		{
			DataSet ds = Employee_MeetingBAL.Select(meetingID);
			MakeObject(ds);
		}

		#endregion

		#region Properties

		/// <summary>
		/// Gets or sets the MeetingID value.
		/// </summary>
		public virtual int MeetingID
		{
			get { return meetingID; }
			set { meetingID = value; }
		}

		/// <summary>
		/// Gets or sets the CompanyName value.
		/// </summary>
		public virtual string CompanyName
		{
			get { return companyName; }
			set { companyName = value; }
		}

		/// <summary>
		/// Gets or sets the PersonName value.
		/// </summary>
		public virtual string PersonName
		{
			get { return personName; }
			set { personName = value; }
		}

		/// <summary>
		/// Gets or sets the Email value.
		/// </summary>
		public virtual string Email
		{
			get { return email; }
			set { email = value; }
		}

		/// <summary>
		/// Gets or sets the MobileNo value.
		/// </summary>
		public virtual string MobileNo
		{
			get { return mobileNo; }
			set { mobileNo = value; }
		}

		/// <summary>
		/// Gets or sets the MeetingDate value.
		/// </summary>
		public virtual DateTime MeetingDate
		{
			get { return meetingDate; }
			set { meetingDate = value; }
		}

		/// <summary>
		/// Gets or sets the MeetingTime value.
		/// </summary>
		public virtual string MeetingTime
		{
			get { return meetingTime; }
			set { meetingTime = value; }
		}

		/// <summary>
		/// Gets or sets the MeetingStatus value.
		/// </summary>
		public virtual short MeetingStatus
		{
			get { return meetingStatus; }
			set { meetingStatus = value; }
		}

		/// <summary>
		/// Gets or sets the FollowUpdate value.
		/// </summary>
		public virtual DateTime? FollowUpdate
		{
			get { return followUpdate; }
			set { followUpdate = value; }
		}

		/// <summary>
		/// Gets or sets the FollowupTime value.
		/// </summary>
		public virtual string FollowupTime
		{
			get { return followupTime; }
			set { followupTime = value; }
		}

		/// <summary>
		/// Gets or sets the FollowUpPerson value.
		/// </summary>
		public virtual string FollowUpPerson
		{
			get { return followUpPerson; }
			set { followUpPerson = value; }
		}

		/// <summary>
		/// Gets or sets the FollowUpDesignation value.
		/// </summary>
		public virtual string FollowUpDesignation
		{
			get { return followUpDesignation; }
			set { followUpDesignation = value; }
		}

		/// <summary>
		/// Gets or sets the FollowUpEmail value.
		/// </summary>
		public virtual string FollowUpEmail
		{
			get { return followUpEmail; }
			set { followUpEmail = value; }
		}

		/// <summary>
		/// Gets or sets the FollowUpMobile value.
		/// </summary>
		public virtual string FollowUpMobile
		{
			get { return followUpMobile; }
			set { followUpMobile = value; }
		}

		/// <summary>
		/// Gets or sets the VisitStatus value.
		/// </summary>
		public virtual string VisitStatus
		{
			get { return visitStatus; }
			set { visitStatus = value; }
		}

		/// <summary>
		/// Gets or sets the Employeeid value.
		/// </summary>
		public virtual int Employeeid
		{
			get { return employeeid; }
			set { employeeid = value; }
		}

		/// <summary>
		/// Gets or sets the EmployeeSupervisor value.
		/// </summary>
		public virtual int EmployeeSupervisor
		{
			get { return employeeSupervisor; }
			set { employeeSupervisor = value; }
		}
        public virtual int MeetingMasterID
        {
            get { return meetingMasterID; }
            set { meetingMasterID = value; }
        }

        /// <summary>
        /// Gets or sets the CreatedDate value.
        /// </summary>
        public virtual DateTime CreatedDate
		{
			get { return createdDate; }
			set { createdDate = value; }
		}

		/// <summary>
		/// Gets or sets the CreatedBy value.
		/// </summary>
		public virtual int CreatedBy
		{
			get { return createdBy; }
			set { createdBy = value; }
		}

		/// <summary>
		/// Gets or sets the ModifiedDate value.
		/// </summary>
		public virtual DateTime ModifiedDate
		{
			get { return modifiedDate; }
			set { modifiedDate = value; }
		}

		/// <summary>
		/// Gets or sets the ModifiedBy value.
		/// </summary>
		public virtual int ModifiedBy
		{
			get { return modifiedBy; }
			set { modifiedBy = value; }
		}

		/// <summary>
		/// Gets or sets the IsActive value.
		/// </summary>
		public virtual bool IsActive
		{
			get { return isActive; }
			set { isActive = value; }
		}

		/// <summary>
		/// Gets or sets the IsDelete value.
		/// </summary>
		public virtual bool IsDelete
		{
			get { return isDelete; }
			set { isDelete = value; }
		}

		#endregion

		#region Methods

		/// <summary>
		/// Initialize Variables
		/// </summary>
		public void InitVariables()
		{
			this.companyName = string.Empty;
			this.personName = string.Empty;
			this.email = string.Empty;
			this.mobileNo = string.Empty;
			this.meetingDate = DateTime.MinValue;
			this.meetingTime = string.Empty;
			this.meetingStatus = 0;
			this.followUpdate = DateTime.MinValue;
			this.followupTime = string.Empty;
			this.followUpPerson = string.Empty;
			this.followUpDesignation = string.Empty;
			this.followUpEmail = string.Empty;
			this.followUpMobile = string.Empty;
			this.visitStatus = string.Empty;
			this.employeeid = 0;
			this.employeeSupervisor = 0;
			this.createdDate = DateTime.MinValue;
			this.createdBy = 0;
			this.modifiedDate = DateTime.MinValue;
			this.modifiedBy = 0;
			this.isActive = false;
			this.isDelete = false;
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
				if (dt.Columns.Contains("MeetingID"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["MeetingID"]), out meetingID );
				}
				if (dt.Columns.Contains("CompanyName"))
				{
					companyName = Convert.ToString(dt.Rows[0]["CompanyName"]);
				}
				if (dt.Columns.Contains("PersonName"))
				{
					personName = Convert.ToString(dt.Rows[0]["PersonName"]);
				}
				if (dt.Columns.Contains("Email"))
				{
					email = Convert.ToString(dt.Rows[0]["Email"]);
				}
				if (dt.Columns.Contains("MobileNo"))
				{
					mobileNo = Convert.ToString(dt.Rows[0]["MobileNo"]);
				}
				if (dt.Columns.Contains("MeetingDate"))
				{
					DateTime.TryParse(Convert.ToString(dt.Rows[0]["MeetingDate"]), out meetingDate );
				}
				if (dt.Columns.Contains("MeetingTime"))
				{
					meetingTime = Convert.ToString(dt.Rows[0]["MeetingTime"]);
				}
				if (dt.Columns.Contains("MeetingStatus"))
				{
					short.TryParse(Convert.ToString(dt.Rows[0]["MeetingStatus"]), out meetingStatus );
				}
				if (dt.Columns.Contains("FollowUpdate"))
				{
                    if (!string.IsNullOrEmpty(dt.Rows[0]["FollowUpdate"].ToString()))
                    {
                        followUpdate = Convert.ToDateTime(Convert.ToString(dt.Rows[0]["FollowUpdate"]));
                        //DateTime.TryParse(Convert.ToString(dt.Rows[0]["FollowUpdate"]), out followUpdate);
                    }
                    else
                    {
                        followUpdate = null;
                    }
				}
				if (dt.Columns.Contains("FollowupTime"))
				{
					followupTime = Convert.ToString(dt.Rows[0]["FollowupTime"]);
				}
				if (dt.Columns.Contains("FollowUpPerson"))
				{
					followUpPerson = Convert.ToString(dt.Rows[0]["FollowUpPerson"]);
				}
				if (dt.Columns.Contains("FollowUpDesignation"))
				{
					followUpDesignation = Convert.ToString(dt.Rows[0]["FollowUpDesignation"]);
				}
				if (dt.Columns.Contains("FollowUpEmail"))
				{
					followUpEmail = Convert.ToString(dt.Rows[0]["FollowUpEmail"]);
				}
				if (dt.Columns.Contains("FollowUpMobile"))
				{
					followUpMobile = Convert.ToString(dt.Rows[0]["FollowUpMobile"]);
				}
				if (dt.Columns.Contains("VisitStatus"))
				{
					visitStatus = Convert.ToString(dt.Rows[0]["VisitStatus"]);
				}
				if (dt.Columns.Contains("Employeeid"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["Employeeid"]), out employeeid );
				}
				if (dt.Columns.Contains("EmployeeSupervisor"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["EmployeeSupervisor"]), out employeeSupervisor );
				}
                if (dt.Columns.Contains("MeetingMasterID"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["MeetingMasterID"]), out meetingMasterID);
				}
				if (dt.Columns.Contains("CreatedDate"))
				{
					DateTime.TryParse(Convert.ToString(dt.Rows[0]["CreatedDate"]), out createdDate );
				}
				if (dt.Columns.Contains("CreatedBy"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["CreatedBy"]), out createdBy );
				}
				if (dt.Columns.Contains("ModifiedDate"))
				{
					DateTime.TryParse(Convert.ToString(dt.Rows[0]["ModifiedDate"]), out modifiedDate );
				}
				if (dt.Columns.Contains("ModifiedBy"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["ModifiedBy"]), out modifiedBy );
				}
				if (dt.Columns.Contains("IsActive"))
				{
					isActive = Convert.ToBoolean(dt.Rows[0]["IsActive"]);
				}
				if (dt.Columns.Contains("IsDelete"))
				{
					isDelete = Convert.ToBoolean(dt.Rows[0]["IsDelete"]);
				}
			}
			else
				InitVariables();
		}

		/// <summary>
		/// Saves a record to the Employee_Meeting table.
		/// </summary>
		public void Insert()
		{
			meetingID = Employee_MeetingDAL.Insert(companyName, personName, email, mobileNo, meetingDate, meetingTime, meetingStatus, followUpdate, followupTime, followUpPerson, followUpDesignation, followUpEmail, followUpMobile, visitStatus, employeeid, employeeSupervisor, meetingMasterID, createdDate, createdBy, modifiedDate, modifiedBy, isActive, isDelete);
		}

		/// <summary>
		/// Updates a record in the Employee_Meeting table.
		/// </summary>
		public void Update()
		{
            Employee_MeetingDAL.Update(meetingID, companyName, personName, email, mobileNo, meetingDate, meetingTime, meetingStatus, followUpdate, followupTime, followUpPerson, followUpDesignation, followUpEmail, followUpMobile, visitStatus, employeeid, employeeSupervisor, createdDate, createdBy, modifiedDate, modifiedBy, isActive, isDelete);
		}

		/// <summary>
		/// Deletes a record from the Employee_Meeting table by a composite primary key.
		/// </summary>
		public void Delete()
		{
			Employee_MeetingDAL.Delete(meetingID);
		}

		/// <summary>
		/// Selects a single record from the Employee_Meeting table.
		/// </summary>
		/// <param name="meetingID"></param>
		/// <returns>DataSet</returns>
		public static DataSet Select(int meetingID)
		{
			return Employee_MeetingDAL.Select(meetingID);
		}

		/// <summary>
		/// Selects all records from the Employee_Meeting table.
		/// </summary>
		/// <returns>DataSet</returns>
		public static DataSet SelectAll(int EmpID, string compname, string mobileno, DateTime? dtfrom, DateTime? dtto, int Empid2)
		{
			return Employee_MeetingDAL.SelectAll(EmpID, compname, mobileno, dtfrom, dtto, Empid2);
		}

		#endregion
	}
}
