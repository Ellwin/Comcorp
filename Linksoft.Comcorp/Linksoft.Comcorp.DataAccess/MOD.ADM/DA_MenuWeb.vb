Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports Linksoft.Comcorp.BusinessEntities

Public Class DA_MenuWeb
    Inherits DA_BaseClass

    Public Shared Function ListarMenuWeb(ByVal codRol As String) As List(Of BE_MenuWeb)
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("Usp_Concorp_Adm_SeguridadAutorizacion_ListMenuWebByRol", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@codRol", SqlDbType.Char).Value = codRol
                    Using lector As SqlDataReader = cmd.ExecuteReader
                        Dim lstMenuWeb As New List(Of BE_MenuWeb)
                        Dim menu As BE_MenuWeb
                        While lector.Read()
                            menu = New BE_MenuWeb
                            With menu
                                .codPadre = Convert.ToString(lector.Item("codPadre"))
                                .codOpcion = Convert.ToString(lector.Item("codOpcion"))
                                .dsOpcion = Convert.ToString(lector.Item("dsOpcion"))
                                .dsUrl = Convert.ToString(lector.Item("dsUrl"))
                            End With
                            lstMenuWeb.Add(menu)
                        End While
                        Return lstMenuWeb
                    End Using
                End Using
            End Using
        Catch ex As Exception
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
    End Function
End Class
