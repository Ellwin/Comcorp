Imports System.Data.SqlClient
Imports Linksoft.Comcorp.BusinessEntities

Public Class DA_Moneda
    Inherits DA_BaseClass

    Public Shared Function GetMoneda(ByVal codCia As String, ByVal codMoneda As String) As BE_Moneda
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("Usp_Concorp_co_ctmoneda_GetMoneda", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@codCia", SqlDbType.VarChar).Value = codCia
                    cmd.Parameters.Add("@codMoneda", SqlDbType.VarChar).Value = codMoneda

                    Using lector As SqlDataReader = cmd.ExecuteReader
                        Dim lstMoneda As New List(Of BE_Moneda)
                        Dim objMoneda As BE_Moneda
                        While lector.Read()
                            objMoneda = New BE_Moneda
                            With objMoneda
                                .codCia = Convert.ToString(lector.Item("codCia"))
                                .codMoneda = Convert.ToString(lector.Item("codMoneda"))
                                .dsMoneda = Convert.ToString(lector.Item("dsMoneda"))
                                .dsAbreviaturaMoneda = Convert.ToString(lector.Item("dsAbreviaturaMoneda"))
                                .dsSimboloMoneda = Convert.ToString(lector.Item("dsSimboloMoneda"))
                                .dsEstado = Convert.ToString(lector.Item("dsEstado"))
                            End With
                            lstMoneda.Add(objMoneda)
                        End While
                        Return lstMoneda.FirstOrDefault
                    End Using
                End Using
            End Using
        Catch ex As Exception
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
    End Function
End Class
