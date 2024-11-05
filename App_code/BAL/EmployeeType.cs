using System;
using System.Collections.Generic;
using System.Data;

namespace EmpMeetingBAL
{
	/// <summary>
	/// Business Logic class for table EmployeeType
	/// </summary>
	public class EmployeeType
	{
		#region Fields

		private int employeeTypeid;
		private string type;

		#endregion

		#region Constructors

		/// <summary>
		/// Initializes a new instance of the EmployeeType class.
		/// </summary>
		public EmployeeType()
		{
				InitVariables();
		}

		/// <summary>
		/// Initializes a new instance of the EmployeeType class.
		/// </summary>
		public EmployeeType(string type)
		{
			this.type = type;
		}

		/// <summary>
		/// Initializes a new instance of the EmployeeType class.
		/// </summary>
		public EmployeeType(int employeeTypeid, string type)
		{
			this.employeeTypeid = employeeTypeid;
			this.type = type;
		}

		/// <summary>
		/// Initializes a new instance of the EmployeeType class.
		/// </summary>
		public EmployeeType(DataSet ds)
		{
			MakeObject(ds);
		}

		/// <summary>
		/// Initializes a new instance of the EmployeeType class.
		/// </summary>
		public EmployeeType(int employeeTypeid)
		{
			DataSet ds = EmployeeType.Select(employeeTypeid);
			MakeObject(ds);
		}

		#endregion

		#region Properties

		/// <summary>
		/// Gets or sets the EmployeeTypeid value.
		/// </summary>
		public virtual int EmployeeTypeid
		{
			get { return employeeTypeid; }
			set { employeeTypeid = value; }
		}

		/// <summary>
		/// Gets or sets the Type value.
		/// </summary>
		public virtual string Type
		{
			get { return type; }
			set { type = value; }
		}

		#endregion

		#region Methods

		/// <summary>
		/// Initialize Variables
		/// </summary>
		public void InitVariables()
		{
			this.type = string.Empty;
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
				if (dt.Columns.Contains("EmployeeTypeid"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["EmployeeTypeid"]), out employeeTypeid );
				}
				if (dt.Columns.Contains("Type"))
				{
					type = Convert.ToString(dt.Rows[0]["Type"]);
				}
			}
			else
				InitVariables();
		}

		/// <summary>
		/// Saves a record to the EmployeeType table.
		/// </summary>
		public void Insert()
		{
			employeeTypeid = EmpMeetingDAL.EmployeeType.Insert(type);
		}

		/// <summary>
		/// Updates a record in the EmployeeType table.
		/// </summary>
		public void Update()
		{
            EmpMeetingDAL.EmployeeType.Update(employeeTypeid, type);
		}

		/// <summary>
		/// Deletes a record from the EmployeeType table by a composite primary key.
		/// </summary>
		public void Delete()
		{
            EmpMeetingDAL.EmployeeType.Delete(employeeTypeid);
		}

		/// <summary>
		/// Selects a single record from the EmployeeType table.
		/// </summary>
		/// <param name="employeeTypeid"></param>
		/// <returns>DataSet</returns>
		public static DataSet Select(int employeeTypeid)
		{
			return EmpMeetingDAL.EmployeeType.Select(employeeTypeid);
		}

		/// <summary>
		/// Selects all records from the EmployeeType table.
		/// </summary>
		/// <returns>DataSet</returns>
		public static DataSet SelectAll()
		{
			return EmpMeetingDAL.EmployeeType.SelectAll();
		}

		#endregion
	}
}
