using System;
using System.Collections.Generic;
using System.Data;
using EmpMeetingDAL;

namespace EmpMeetingBAL
{
	/// <summary>
	/// Business Logic class for table EmployeeMeetingMaster
	/// </summary>
	public class EmployeeMeetingMaster
	{
		#region Fields

		private int emp_MeetingMasterId;
		private string title;
		private int employeeSupervisor;
		private DateTime createddate;
		private int createdby;

		#endregion

		#region Constructors

		/// <summary>
		/// Initializes a new instance of the EmployeeMeetingMaster class.
		/// </summary>
		public EmployeeMeetingMaster()
		{
				InitVariables();
		}

		/// <summary>
		/// Initializes a new instance of the EmployeeMeetingMaster class.
		/// </summary>
		public EmployeeMeetingMaster(string title, int employeeSupervisor, DateTime createddate, int createdby)
		{
			this.title = title;
			this.employeeSupervisor = employeeSupervisor;
			this.createddate = createddate;
			this.createdby = createdby;
		}

		/// <summary>
		/// Initializes a new instance of the EmployeeMeetingMaster class.
		/// </summary>
		public EmployeeMeetingMaster(int emp_MeetingMasterId, string title, int employeeSupervisor, DateTime createddate, int createdby)
		{
			this.emp_MeetingMasterId = emp_MeetingMasterId;
			this.title = title;
			this.employeeSupervisor = employeeSupervisor;
			this.createddate = createddate;
			this.createdby = createdby;
		}

		/// <summary>
		/// Initializes a new instance of the EmployeeMeetingMaster class.
		/// </summary>
		public EmployeeMeetingMaster(DataSet ds)
		{
			MakeObject(ds);
		}

		/// <summary>
		/// Initializes a new instance of the EmployeeMeetingMaster class.
		/// </summary>
		public EmployeeMeetingMaster(int emp_MeetingMasterId)
		{
			DataSet ds = EmployeeMeetingMaster.Select(emp_MeetingMasterId);
			MakeObject(ds);
		}

		#endregion

		#region Properties

		/// <summary>
		/// Gets or sets the Emp_MeetingMasterId value.
		/// </summary>
		public virtual int Emp_MeetingMasterId
		{
			get { return emp_MeetingMasterId; }
			set { emp_MeetingMasterId = value; }
		}

		/// <summary>
		/// Gets or sets the Title value.
		/// </summary>
		public virtual string Title
		{
			get { return title; }
			set { title = value; }
		}

		/// <summary>
		/// Gets or sets the EmployeeSupervisor value.
		/// </summary>
		public virtual int EmployeeSupervisor
		{
			get { return employeeSupervisor; }
			set { employeeSupervisor = value; }
		}

		/// <summary>
		/// Gets or sets the Createddate value.
		/// </summary>
		public virtual DateTime Createddate
		{
			get { return createddate; }
			set { createddate = value; }
		}

		/// <summary>
		/// Gets or sets the Createdby value.
		/// </summary>
		public virtual int Createdby
		{
			get { return createdby; }
			set { createdby = value; }
		}

		#endregion

		#region Methods

		/// <summary>
		/// Initialize Variables
		/// </summary>
		public void InitVariables()
		{
			this.title = string.Empty;
			this.employeeSupervisor = 0;
			this.createddate = DateTime.MinValue;
			this.createdby = 0;
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
				if (dt.Columns.Contains("Emp_MeetingMasterId"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["Emp_MeetingMasterId"]), out emp_MeetingMasterId );
				}
				if (dt.Columns.Contains("Title"))
				{
					title = Convert.ToString(dt.Rows[0]["Title"]);
				}
				if (dt.Columns.Contains("EmployeeSupervisor"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["EmployeeSupervisor"]), out employeeSupervisor );
				}
				if (dt.Columns.Contains("Createddate"))
				{
					DateTime.TryParse(Convert.ToString(dt.Rows[0]["Createddate"]), out createddate );
				}
				if (dt.Columns.Contains("Createdby"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["Createdby"]), out createdby );
				}
			}
			else
				InitVariables();
		}

		/// <summary>
		/// Saves a record to the EmployeeMeetingMaster table.
		/// </summary>
		public void Insert()
		{
			emp_MeetingMasterId = EmpMeetingDAL.EmployeeMeetingMaster.Insert(title, employeeSupervisor, createddate, createdby);
		}

		/// <summary>
		/// Updates a record in the EmployeeMeetingMaster table.
		/// </summary>
		public void Update()
		{
            EmpMeetingDAL.EmployeeMeetingMaster.Update(emp_MeetingMasterId, title, employeeSupervisor, createddate, createdby);
		}

		/// <summary>
		/// Deletes a record from the EmployeeMeetingMaster table by a composite primary key.
		/// </summary>
		public void Delete()
		{
            EmpMeetingDAL.EmployeeMeetingMaster.Delete(emp_MeetingMasterId);
		}

		/// <summary>
		/// Selects a single record from the EmployeeMeetingMaster table.
		/// </summary>
		/// <param name="emp_MeetingMasterId"></param>
		/// <returns>DataSet</returns>
		public static DataSet Select(int emp_MeetingMasterId)
		{
			return EmpMeetingDAL.EmployeeMeetingMaster.Select(emp_MeetingMasterId);
		}

		/// <summary>
		/// Selects all records from the EmployeeMeetingMaster table.
		/// </summary>
		/// <returns>DataSet</returns>
		public static DataSet SelectAll()
		{
			return EmpMeetingDAL.EmployeeMeetingMaster.SelectAll();
		}

		#endregion
	}
}
