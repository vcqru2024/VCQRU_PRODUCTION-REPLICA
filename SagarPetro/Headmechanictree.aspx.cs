using System;
using System.Collections.Generic;
using System.Data;
using System.Linq;
using System.Text;
using System.Web;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class SagarPetro_Headmechanictree : System.Web.UI.Page
{
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack)
        {
            PopulateTreeView();
        }
    }

    private void PopulateTreeView()
    {
        DataTable mechanicsTable = GetMechanicsData();

        // Create a dictionary to store TreeNode references by Id
        Dictionary<int, TreeNode> nodes = new Dictionary<int, TreeNode>();

        string[] headers = { "ID", "Head mechanic id", "UserName", "User Type", "Mobile_Number", "KYC",
                         "State", "District", "City", "Pin Code", "Mechanic Type", "Date of Birth",
                         "Gender", "Marital_Status", "Available Amount" };
        string tableHeaders = string.Join(",", headers);

        foreach (DataRow row in mechanicsTable.Rows)
        {
            string nodeText = FormatNodeText(row, tableHeaders);
            TreeNode node = new TreeNode(nodeText, row["ID"].ToString());
            int id = Convert.ToInt32(row["ID"]);
            nodes[id] = node;

            if (row["Head mechanic id"] == DBNull.Value)
            {
                TreeView1.Nodes.Add(node);
            }
            else
            {
                int parentId = Convert.ToInt32(row["Head mechanic id"]);
                if (nodes.ContainsKey(parentId))
                {
                    nodes[parentId].ChildNodes.Add(node);
                }
            }
        }
    }

    private string FormatNodeText(DataRow row, string tableHeaders)
    {
        StringBuilder sb = new StringBuilder();

        // Start of the table with Bootstrap classes for styling
        sb.Append("<table class='table table-hover table-striped table-bordered'>");

        // Append the provided headers directly (only once)
        sb.Append("<thead><tr>");
        sb.Append(tableHeaders);
        sb.Append("</tr></thead>");

        // Table body with row data
        sb.Append("<tbody><tr>");
        foreach (var header in tableHeaders.Split(','))
        {
            sb.AppendFormat("<td>{0}</td>", HttpUtility.HtmlEncode(row[header.Trim()].ToString())); // Encode HTML to prevent XSS
        }
        sb.Append("</tr></tbody>");

        sb.Append("</table>");

        return sb.ToString();
    }








    private DataTable GetMechanicsData()
    {
        DataTable dt = SQL_DB.ExecuteDataTable("exec USP_GETHeadMechanicsDetailsScoreADMIN_SP '" + Session["CompanyId"].ToString() + "'");
        if (dt.Rows.Count == 0)
        {
            dt = null;
        }
        return dt;
    }
}