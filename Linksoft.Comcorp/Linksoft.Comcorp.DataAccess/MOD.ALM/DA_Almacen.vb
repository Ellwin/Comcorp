Imports System.Data.SqlClient
Imports Linksoft.Comcorp.BusinessEntities

Public Class DA_Almacen
    Inherits DA_BaseClass

    Public Shared Function GetAlmacen(ByVal codCia As String, ByVal codAlmacen As String) As BE_Almacen
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("Usp_Concorp_al_ctalmac_GetAlmacen", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@codCia", SqlDbType.VarChar).Value = codCia
                    cmd.Parameters.Add("@codAlmacen", SqlDbType.VarChar).Value = codAlmacen

                    Using lector As SqlDataReader = cmd.ExecuteReader
                        Dim lstAlmacen As New List(Of BE_Almacen)
                        Dim objAlmacen As BE_Almacen
                        While lector.Read()
                            objAlmacen = New BE_Almacen
                            With objAlmacen
                                .codCia = Convert.ToString(lector.Item("codCia"))
                                .codAlmacen = Convert.ToString(lector.Item("codAlmacen"))
                                .dsAlmacen = Convert.ToString(lector.Item("dsAlmacen"))
                                .dsEstado = Convert.ToString(lector.Item("dsEstado"))
                            End With
                            lstAlmacen.Add(objAlmacen)
                        End While
                        Return lstAlmacen.FirstOrDefault
                    End Using
                End Using
            End Using
        Catch ex As Exception
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
    End Function

End Class
