Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports Linksoft.Comcorp.BusinessEntities

Public Class DA_Usuario
    Inherits DA_BaseClass

    Public Shared Function GetLogin(ByVal strUsuario As String, ByVal strPassword As String) As BE_Usuario
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("usp_Adm_SeguridadUsuario_GetLogin", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@codUsuario", SqlDbType.VarChar).Value = strUsuario
                    cmd.Parameters.Add("@dsPassword", SqlDbType.VarChar).Value = strPassword
                    Using lector As SqlDataReader = cmd.ExecuteReader
                        Dim lstUsuario As New List(Of BE_Usuario)
                        Dim usuario As BE_Usuario
                        While lector.Read()
                            usuario = New BE_Usuario
                            With usuario
                                .codUsuario = Convert.ToString(lector.Item("codUsuario"))
                                .codRol = Convert.ToString(lector.Item("codRol"))
                                .dsUsuario = Convert.ToString(lector.Item("dsUsuario"))
                                .dsRol = Convert.ToString(lector.Item("dsRol"))
                            End With
                            lstUsuario.Add(usuario)
                        End While
                        Return lstUsuario.FirstOrDefault
                    End Using
                End Using
            End Using
        Catch ex As Exception
            Throw ex
        End Try
    End Function

End Class
