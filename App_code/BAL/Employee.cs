using System;
using System.Collections.Generic;
using System.Data;

namespace EmpMeetingBAL
{
	/// <summary>
	/// Business Logic class for table Employee
	/// </summary>
	public class Employee
	{
		#region Fields

		private int employeeID;
		private string name;
		private string address;
		private string email;
		private string mobileno;
		private string pwd;
		private string city;
		private string pincode;
		private short emp_type;
		private DateTime createddate;
		private int createdby;
		private DateTime modifieddate;
		private int modifiedby;
		private bool active;
		private bool dalete;

		#endregion

		#region Constructors

		/// <summary>
		/// Initializes a new instance of the Employee class.
		/// </summary>
		public Employee()
		{
				InitVariables();
		}

		/// <summary>
		/// Initializes a new instance of the Employee class.
		/// </summary>
		public Employee(string name, string address, string email, string mobileno, string pwd, string city, string pincode, short emp_type, DateTime createddate, int createdby, DateTime modifieddate, int modifiedby, bool active, bool dalete)
		{
			this.name = name;
			this.address = address;
			this.email = email;
			this.mobileno = mobileno;
			this.pwd = pwd;
			this.city = city;
			this.pincode = pincode;
			this.emp_type = emp_type;
			this.createddate = createddate;
			this.createdby = createdby;
			this.modifieddate = modifieddate;
			this.modifiedby = modifiedby;
			this.active = active;
			this.dalete = dalete;
		}

		/// <summary>
		/// Initializes a new instance of the Employee class.
		/// </summary>
		public Employee(int employeeID, string name, string address, string email, string mobileno, string pwd, string city, string pincode, short emp_type, DateTime createddate, int createdby, DateTime modifieddate, int modifiedby, bool active, bool dalete)
		{
			this.employeeID = employeeID;
			this.name = name;
			this.address = address;
			this.email = email;
			this.mobileno = mobileno;
			this.pwd = pwd;
			this.city = city;
			this.pincode = pincode;
			this.emp_type = emp_type;
			this.createddate = createddate;
			this.createdby = createdby;
			this.modifieddate = modifieddate;
			this.modifiedby = modifiedby;
			this.active = active;
			this.dalete = dalete;
		}

		/// <summary>
		/// Initializes a new instance of the Employee class.
		/// </summary>
		public Employee(DataSet ds)
		{
			MakeObject(ds);
		}

		/// <summary>
		/// Initializes a new instance of the Employee class.
		/// </summary>
		public Employee(int employeeID)
		{
			DataSet ds = Employee.Select(employeeID);
			MakeObject(ds);
		}

		#endregion

		#region Properties

		/// <summary>
		/// Gets or sets the EmployeeID value.
		/// </summary>
		public virtual int EmployeeID
		{
			get { return employeeID; }
			set { employeeID = value; }
		}

		/// <summary>
		/// Gets or sets the Name value.
		/// </summary>
		public virtual string Name
		{
			get { return name; }
			set { name = value; }
		}

		/// <summary>
		/// Gets or sets the Address value.
		/// </summary>
		public virtual string Address
		{
			get { return address; }
			set { address = value; }
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
		/// Gets or sets the Mobileno value.
		/// </summary>
		public virtual string Mobileno
		{
			get { return mobileno; }
			set { mobileno = value; }
		}

		/// <summary>
		/// Gets or sets the Pwd value.
		/// </summary>
		public virtual string Pwd
		{
			get { return pwd; }
			set { pwd = value; }
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
		/// Gets or sets the Pincode value.
		/// </summary>
		public virtual string Pincode
		{
			get { return pincode; }
			set { pincode = value; }
		}

		/// <summary>
		/// Gets or sets the Emp_type value.
		/// </summary>
		public virtual short Emp_type
		{
			get { return emp_type; }
			set { emp_type = value; }
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

		/// <summary>
		/// Gets or sets the Modifieddate value.
		/// </summary>
		public virtual DateTime Modifieddate
		{
			get { return modifieddate; }
			set { modifieddate = value; }
		}

		/// <summary>
		/// Gets or sets the Modifiedby value.
		/// </summary>
		public virtual int Modifiedby
		{
			get { return modifiedby; }
			set { modifiedby = value; }
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
		/// Gets or sets the Dalete value.
		/// </summary>
		public virtual bool Dalete
		{
			get { return dalete; }
			set { dalete = value; }
		}

		#endregion

		#region Methods

		/// <summary>
		/// Initialize Variables
		/// </summary>
		public void InitVariables()
		{
			this.name = string.Empty;
			this.address = string.Empty;
			this.email = string.Empty;
			this.mobileno = string.Empty;
			this.pwd = string.Empty;
			this.city = string.Empty;
			this.pincode = string.Empty;
			this.emp_type = 0;
			this.createddate = DateTime.MinValue;
			this.createdby = 0;
			this.modifieddate = DateTime.MinValue;
			this.modifiedby = 0;
			this.active = false;
			this.dalete = false;
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
				if (dt.Columns.Contains("EmployeeID"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["EmployeeID"]), out employeeID );
				}
				if (dt.Columns.Contains("name"))
				{
					name = Convert.ToString(dt.Rows[0]["name"]);
				}
				if (dt.Columns.Contains("Address"))
				{
					address = Convert.ToString(dt.Rows[0]["Address"]);
				}
				if (dt.Columns.Contains("Email"))
				{
					email = Convert.ToString(dt.Rows[0]["Email"]);
				}
				if (dt.Columns.Contains("mobileno"))
				{
					mobileno = Convert.ToString(dt.Rows[0]["mobileno"]);
				}
				if (dt.Columns.Contains("pwd"))
				{
					pwd = Convert.ToString(dt.Rows[0]["pwd"]);
				}
				if (dt.Columns.Contains("city"))
				{
					city = Convert.ToString(dt.Rows[0]["city"]);
				}
				if (dt.Columns.Contains("pincode"))
				{
					pincode = Convert.ToString(dt.Rows[0]["pincode"]);
				}
				if (dt.Columns.Contains("Emp_type"))
				{
					short.TryParse(Convert.ToString(dt.Rows[0]["Emp_type"]), out emp_type );
				}
				if (dt.Columns.Contains("createddate"))
				{
					DateTime.TryParse(Convert.ToString(dt.Rows[0]["createddate"]), out createddate );
				}
				if (dt.Columns.Contains("createdby"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["createdby"]), out createdby );
				}
				if (dt.Columns.Contains("modifieddate"))
				{
					DateTime.TryParse(Convert.ToString(dt.Rows[0]["modifieddate"]), out modifieddate );
				}
				if (dt.Columns.Contains("modifiedby"))
				{
					int.TryParse(Convert.ToString(dt.Rows[0]["modifiedby"]), out modifiedby );
				}
				if (dt.Columns.Contains("active"))
				{
					active = Convert.ToBoolean(dt.Rows[0]["active"]);
				}
				if (dt.Columns.Contains("dalete"))
				{
					dalete = Convert.ToBoolean(dt.Rows[0]["dalete"]);
				}
			}
			else
				InitVariables();
		}

		/// <summary>
		/// Saves a record to the Employee table.
		/// </summary>
		public void Insert()
		{
			employeeID = EmpMeetingDAL.Employee.Insert(name, address, email, mobileno, pwd, city, pincode, emp_type, createddate, createdby, modifieddate, modifiedby, active, dalete);
		}

		/// <summary>
		/// Updates a record in the Employee table.
		/// </summary>
		public void Update()
		{
            EmpMeetingDAL.Employee.Update(employeeID, name, address, email, mobileno, pwd, city, pincode, emp_type, createddate, createdby, modifieddate, modifiedby, active, dalete);
		}

		/// <summary>
		/// Deletes a record from the Employee table by a composite primary key.
		/// </summary>
		public void Delete()
		{
            EmpMeetingDAL.Employee.Delete(employeeID);
		}

		/// <summary>
		/// Selects a single record from the Employee table.
		/// </summary>
		/// <param name="employeeID"></param>
		/// <returns>DataSet</returns>
		public static DataSet Select(int employeeID)
		{
			return EmpMeetingDAL.Employee.Select(employeeID);
		}

		/// <summary>
		/// Selects all records from the Employee table.
		/// </summary>
		/// <returns>DataSet</returns>
		public static DataSet SelectAll()
		{
			return EmpMeetingDAL.Employee.SelectAll();
		}

		#endregion
	}
}
