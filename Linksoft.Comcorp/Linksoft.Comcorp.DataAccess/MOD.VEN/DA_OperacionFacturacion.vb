Imports System.Data.SqlClient
Imports Linksoft.Comcorp.BusinessEntities

Public Class DA_OperacionFacturacion
    Inherits DA_BaseClass

    Public Shared Function GetOperacionFacturacion(ByVal codCia As String, ByVal codOperacionFacturacion As String) As BE_OperacionFacturacion
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("Usp_Concorp_fa_ctoperfact_GetOperacionFacturacion", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@codCia", SqlDbType.VarChar).Value = codCia
                    cmd.Parameters.Add("@codOperacionFacturacion", SqlDbType.VarChar).Value = codOperacionFacturacion

                    Using lector As SqlDataReader = cmd.ExecuteReader
                        Dim lstOperacionFacturacion As New List(Of BE_OperacionFacturacion)
                        Dim objOperacionFacturacion As BE_OperacionFacturacion
                        While lector.Read()
                            objOperacionFacturacion = New BE_OperacionFacturacion
                            With objOperacionFacturacion
                                .codCia = Convert.ToString(lector.Item("codCia"))
                                .codOperacionFacturacion = Convert.ToString(lector.Item("codOperacionFacturacion"))
                                .dsOperacionFacturacion = Convert.ToString(lector.Item("dsOperacionFacturacion"))
                                .dsDocTipo = Convert.ToString(lector.Item("dsDocTipo"))
                                .codMoneda = Convert.ToString(lector.Item("codMoneda"))
                                .dsMoneda = Convert.ToString(lector.Item("dsMoneda"))
                                .dsEstado = Convert.ToString(lector.Item("dsEstado"))
                            End With
                            lstOperacionFacturacion.Add(objOperacionFacturacion)
                        End While
                        Return lstOperacionFacturacion.FirstOrDefault
                    End Using
                End Using
            End Using
        Catch ex As Exception
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
    End Function
End Class
