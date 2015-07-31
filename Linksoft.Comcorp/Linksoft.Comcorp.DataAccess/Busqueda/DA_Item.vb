Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports Linksoft.Comcorp.BusinessEntities

Public Class DA_Item
    Inherits DA_BaseClass

    Public Shared Function ListarItemQuery(ByVal codTipoQuery As String, ByVal codTabla As String, ByVal codCia As String) As List(Of BE_Item)
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("Usp_Concorp_Adm_Queries_ExecQuery", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@codTipoQuery", SqlDbType.VarChar).Value = codTipoQuery
                    cmd.Parameters.Add("@codTabla", SqlDbType.VarChar).Value = codTabla
                    cmd.Parameters.Add("@codCia", SqlDbType.VarChar).Value = codCia
                    Using lector As SqlDataReader = cmd.ExecuteReader
                        Dim lstItem As New List(Of BE_Item)
                        Dim objItem As BE_Item
                        While lector.Read()
                            objItem = New BE_Item
                            With objItem
                                .codigo = Convert.ToString(lector.Item("codigo"))
                                .descripcion = Convert.ToString(lector.Item("descripcion"))
                            End With
                            lstItem.Add(objItem)
                        End While
                        Return lstItem
                    End Using
                End Using
            End Using
        Catch ex As Exception
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
    End Function


End Class
