Imports Microsoft.VisualBasic
Imports System
Imports System.Data
Imports System.Configuration
Imports System.Web
Imports System.Web.Security
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Web.UI.WebControls.WebParts
Imports System.Web.UI.HtmlControls
Imports System.Data.SqlClient
Imports System.Web.Mail
Imports System.IO

Public Class dtcon
    Public Shared Function OpenConnection() As SqlConnection
        Dim conn As SqlConnection = CreateConnection()
        conn.Open()
        Return conn
    End Function
    Public Shared ReadOnly Property ConnectionString() As String
        Get
            Return System.Configuration.ConfigurationManager.ConnectionStrings("defaultConnectionbeta").ConnectionString
        End Get
    End Property

    Public Shared Function CreateConnection() As SqlConnection
        Return New SqlConnection(ConnectionString)
    End Function
End Class
