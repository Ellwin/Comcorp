Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient

Public Class DA_BaseClass


    Public Shared Function ConnectionStringSQLServer() As String
        Return ConfigurationManager.AppSettings("cnSQLServer")
    End Function




End Class
