Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports Linksoft.Comcorp.BusinessEntities

Public Class DA_SesionLogin
    Inherits DA_BaseClass

    Public Shared Function GetLogin(ByVal strUsuario As String, ByVal strPassword As String) As BE_SesionLogin
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("usp_Adm_SeguridadUsuario_GetLogin", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@codUsuario", SqlDbType.VarChar).Value = strUsuario
                    cmd.Parameters.Add("@dsPassword", SqlDbType.VarChar).Value = strPassword
                    Using lector As SqlDataReader = cmd.ExecuteReader
                        Dim lstSesionLogin As New List(Of BE_SesionLogin)
                        Dim objSesionLogin As BE_SesionLogin
                        While lector.Read()
                            objSesionLogin = New BE_SesionLogin
                            With objSesionLogin
                                .codUsuario = Convert.ToString(lector.Item("codUsuario"))
                                .codRol = Convert.ToString(lector.Item("codRol"))
                                .dsUsuario = Convert.ToString(lector.Item("dsUsuario"))
                                .dsRol = Convert.ToString(lector.Item("dsRol"))
                            End With
                            lstSesionLogin.Add(objSesionLogin)
                        End While
                        Return lstSesionLogin.FirstOrDefault
                    End Using
                End Using
            End Using
        Catch ex As Exception
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
    End Function
End Class
