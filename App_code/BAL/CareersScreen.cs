using System;
using System.Collections.Generic;
using System.Data;

namespace CareerBAL
{
	/// <summary>
	/// Business Logic class for table CareersScreen
	/// </summary>
	public class CareersScreen
	{
		#region Fields

		private int careersid;
		private int jobCategory;
		private string preferredLocation;
		private int availability;
		private string positionApplyFor;
		private string resumeName;
		private string resumeName2;
		private string fullName;
		private string emailAddress;
		private int yearsOfExp;
		private string skills;
		private string country;
		private string state;
		private string city;
		private int findVcqru;
		private bool active;
		private DateTime createdDate;
		private int createdBy;

		#endregion

		#region Constructors

		/// <summary>
		/// Initializes a new instance of the CareersScreen class.
		/// </summary>
		public CareersScreen()
		{
				InitVariables();
		}

		/// <summary>
		/// Initializes a new instance of the CareersScreen class.
		/// </summary>
		public CareersScreen(int jobCategory, string preferredLocation, int availability, string positionApplyFor, string resumeName, string resumeName2, string fullName, string emailAddress, int yearsOfExp, string skills, string country, string state, string city, int findVcqru, bool active, DateTime createdDate, int createdBy)
		{
			this.jobCategory = jobCategory;
			this.preferredLocation = preferredLocation;
			this.availability = availability;
			this.positionApplyFor = positionApplyFor;
			this.resumeName = resumeName;
			this.resumeName2 = resumeName2;
			this.fullName = fullName;
			this.emailAddress = emailAddress;
			this.yearsOfExp = yearsOfExp;
			this.skills = skills;
			this.country = country;
			this.state = state;
			this.city = city;
			this.findVcqru = findVcqru;
			this.active = active;
			this.createdDate = createdDate;
			this.createdBy = createdBy;
		}

		/// <summary>
		/// Initializes a new instance of the CareersScreen class.
		/// </summary>
		public CareersScreen(int careersid, int jobCategory, string preferredLocation, int availability, string positionApplyFor, string resumeName, string resumeName2, string fullName, string emailAddress, int yearsOfExp, string skills, string country, string state, string city, int findVcqru, bool active, DateTime createdDate, int createdBy)
		{
			this.careersid = careersid;
			this.jobCategory = jobCategory;
			this.preferredLocation = preferredLocation;
			this.availability = availability;
			this.positionApplyFor = positionApplyFor;
			this.resumeName = resumeName;
			this.resumeName2 = resumeName2;
			this.fullName = fullName;
			this.emailAddress = emailAddress;
			this.yearsOfExp = yearsOfExp;
			this.skills = skills;
			this.country = country;
			this.state = state;
			this.city = city;
			this.findVcqru = findVcqru;
			this.active = active;
			this.createdDate = createdDate;
			this.createdBy = createdBy;
		}

		/// <summary>
		/// Initializes a new instance of the CareersScreen class.
		/// </summary>
		public CareersScreen(DataSet ds)
		{
			MakeObject(ds);
		}

		/// <summary>
		/// Initializes a new instance of the CareersScreen class.
		/// </summary>
		public CareersScreen(int careersid)
		{
			DataSet ds = CareersScreen.Select(careersid);
			MakeObject(ds);
		}

		#endregion

		#region Properties

		/// <summary>
		/// Gets or sets the Careersid value.
		/// </summary>
		public virtual int Careersid
		{
			get { return careersid; }
			set { careersid = value; }
		}

		/// <summary>
		/// Gets or sets the JobCategory value.
		/// </summary>
		public virtual int JobCategory
		{
			get { return jobCategory; }
			set { jobCategory = value; }
		}

		/// <summary>
		/// Gets or sets the PreferredLocation value.
		/// </summary>
		public virtual string PreferredLocation
		{
			get { return preferredLocation; }
			set { preferredLocation = value; }
		}

		/// <summary>
		/// Gets or sets the Availability value.
		/// </summary>
		public virtual int Availability
		{
			get { return availability; }
			set { availability = value; }
		}

		/// <summary>
		/// Gets or sets the PositionApplyFor value.
		/// </summary>
		public virtual string PositionApplyFor
		{
			get { return positionApplyFor; }
			set { positionApplyFor = value; }
		}

		/// <summary>
		/// Gets or sets the ResumeName value.
		/// </summary>
		public virtual string ResumeName
		{
			get { return resumeName; }
			set { resumeName = value; }
		}

		/// <summary>
		/// Gets or sets the ResumeName2 value.
		/// </summary>
		public virtual string ResumeName2
		{
			get { return resumeName2; }
			set { resumeName2 = value; }
		}

		/// <summary>
		/// Gets or sets the FullName value.
		/// </summary>
		public virtual string FullName
		{
			get { return fullName; }
			set { fullName = value; }
		}

		/// <summary>
		/// Gets or sets the EmailAddress value.
		/// </summary>
		public virtual string EmailAddress
		{
			get { return emailAddress; }
			set { emailAddress = value; }
		}

		/// <summary>
		/// Gets or sets the YearsOfExp value.
		/// </summary>
		public virtual int YearsOfExp
		{
			get { return yearsOfExp; }
			set { yearsOfExp = value; }
		}

		/// <summary>
		/// Gets or sets the Skills value.
		/// </summary>
		public virtual string Skills
		{
			get { return skills; }
			set { skills = value; }
		}

		/// <summary>
		/// Gets or sets the Country value.
		/// </summary>
		public virtual string Country
		{
			get { return country; }
			set { country = value; }
		}

		/// <summary>
		/// Gets or sets the State value.
		/// </summary>
		public virtual string State
		{
			get { return state; }
			set { state = value; }
		}

		/// <summary>
		/// Gets or sets the City value.
		/// </summary>
		public virtual string City
		{
			get { return city; }
			set { city = value; }
		}

		/// <summary>
		/// Gets or sets the FindVcqru value.
		/// </summary>
		public virtual int FindVcqru
		{
			get { return findVcqru; }
			set { findVcqru = value; }
		}

		/// <summary>
		/// Gets or sets the Active value.
		/// </summary>
		public virtual bool Active
		{
			get { return active; }
			set { active = value; }
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

		#endregion

		#region Methods

		/// <summary>
		/// Initialize Variables
		/// </summary>
		public void InitVariables()
		{
			this.jobCategory = 0;
			this.preferredLocation = string.Empty;
			this.availability = 0;
			this.positionApplyFor = string.Empty;
			this.resumeName = string.Empty;
			this.resumeName2 = string.Empty;
			this.fullName = string.Empty;
			this.emailAddress = string.Empty;
			this.yearsOfExp = 0;
			this.skills = string.Empty;
			this.country = string.Empty;
			this.state = string.Empty;
			this.city = string.Empty;
			this.findVcqru = 0;
			this.active = false;
			this.createdDate = DateTime.MinValue;
			this.createdBy = 0;
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
				if (dt.Columns.Contains("Careersid"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["Careersid"]), out careersid );
				}
				if (dt.Columns.Contains("JobCategory"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["JobCategory"]), out jobCategory );
				}
				if (dt.Columns.Contains("PreferredLocation"))
				{
					preferredLocation = Convert.ToString(dt.Rows[0]["PreferredLocation"]);
				}
				if (dt.Columns.Contains("Availability"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["Availability"]), out availability );
				}
				if (dt.Columns.Contains("PositionApplyFor"))
				{
					positionApplyFor = Convert.ToString(dt.Rows[0]["PositionApplyFor"]);
				}
				if (dt.Columns.Contains("ResumeName"))
				{
					resumeName = Convert.ToString(dt.Rows[0]["ResumeName"]);
				}
				if (dt.Columns.Contains("ResumeName2"))
				{
					resumeName2 = Convert.ToString(dt.Rows[0]["ResumeName2"]);
				}
				if (dt.Columns.Contains("FullName"))
				{
					fullName = Convert.ToString(dt.Rows[0]["FullName"]);
				}
				if (dt.Columns.Contains("EmailAddress"))
				{
					emailAddress = Convert.ToString(dt.Rows[0]["EmailAddress"]);
				}
				if (dt.Columns.Contains("YearsOfExp"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["YearsOfExp"]), out yearsOfExp );
				}
				if (dt.Columns.Contains("Skills"))
				{
					skills = Convert.ToString(dt.Rows[0]["Skills"]);
				}
				if (dt.Columns.Contains("Country"))
				{
					country = Convert.ToString(dt.Rows[0]["Country"]);
				}
				if (dt.Columns.Contains("State"))
				{
					state = Convert.ToString(dt.Rows[0]["State"]);
				}
				if (dt.Columns.Contains("City"))
				{
					city = Convert.ToString(dt.Rows[0]["City"]);
				}
				if (dt.Columns.Contains("FindVcqru"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["FindVcqru"]), out findVcqru );
				}
				if (dt.Columns.Contains("Active"))
				{
					active = Convert.ToBoolean(dt.Rows[0]["Active"]);
				}
				if (dt.Columns.Contains("CreatedDate"))
				{
					DateTime.TryParse(Convert.ToString(dt.Rows[0]["CreatedDate"]), out createdDate );
				}
				if (dt.Columns.Contains("CreatedBy"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["CreatedBy"]), out createdBy );
				}
			}
			else
				InitVariables();
		}

		/// <summary>
		/// Saves a record to the CareersScreen table.
		/// </summary>
		public void Insert()
		{
			careersid = Career.CareersScreenDal.Insert(jobCategory, preferredLocation, availability, positionApplyFor, resumeName, resumeName2, fullName, emailAddress, yearsOfExp, skills, country, state, city, findVcqru, active, createdDate, createdBy);
		}

		/// <summary>
		/// Updates a record in the CareersScreen table.
		/// </summary>
		public void Update()
		{
			Career.CareersScreenDal.Update(careersid, jobCategory, preferredLocation, availability, positionApplyFor, resumeName, resumeName2, fullName, emailAddress, yearsOfExp, skills, country, state, city, findVcqru, active, createdDate, createdBy);
		}
        public void Update(string resumename, string resumename2,int careers_id)
        {
            Career.CareersScreenDal.UpdateResume(resumename,  resumename2,  careers_id);
        }
        /// <summary>
        /// Deletes a record from the CareersScreen table by a composite primary key.
        /// </summary>
        public void Delete()
		{
			Career.CareersScreenDal.Delete(careersid);
		}

		/// <summary>
		/// Selects a single record from the CareersScreen table.
		/// </summary>
		/// <param name="careersid"></param>
		/// <returns>DataSet</returns>
		public static DataSet Select(int careersid)
		{
			return Career.CareersScreenDal.Select(careersid);
		}

		/// <summary>
		/// Selects all records from the CareersScreen table.
		/// </summary>
		/// <returns>DataSet</returns>
		public static DataSet SelectAll()
		{
			return Career.CareersScreenDal.SelectAll();
		}

		#endregion
	}
}
