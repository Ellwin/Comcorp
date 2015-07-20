Imports System.Configuration
Imports System.Data
Imports System.Data.SqlClient
Imports log4net

Public Class DA_BaseClass

    Protected Shared ReadOnly log As ILog = LogManager.GetLogger("_logBD")

    Public Shared Sub LogSQLException(ByVal sqlEx As SqlException)
        log.Error("Error capa de datos: ", sqlEx)
        Throw sqlEx
    End Sub


    Public Shared Function ConnectionStringSQLServer() As String
        Return ConfigurationManager.AppSettings("cnSQLServer")
    End Function




End Class
