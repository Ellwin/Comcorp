Imports System.Data.SqlClient
Imports Linksoft.Comcorp.BusinessEntities

Public Class DA_CondicionPago
    Inherits DA_BaseClass

    Public Shared Function GetCondicionPago(ByVal codCia As String, ByVal codCondicionPago As String) As BE_CondicionPago
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("Usp_Concorp_fa_ctcondpago_GetCondicionPago", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@codCia", SqlDbType.VarChar).Value = codCia
                    cmd.Parameters.Add("@codCondicionPago", SqlDbType.VarChar).Value = codCondicionPago

                    Using lector As SqlDataReader = cmd.ExecuteReader
                        Dim lstCondicionPago As New List(Of BE_CondicionPago)
                        Dim objCondicionPago As BE_CondicionPago
                        While lector.Read()
                            objCondicionPago = New BE_CondicionPago
                            With objCondicionPago
                                .codCia = Convert.ToString(lector.Item("codCia"))
                                .codCondicionPago = Convert.ToString(lector.Item("codCondicionPago"))
                                .dsCondicionPago = Convert.ToString(lector.Item("dsCondicionPago"))
                                .dsTipoCondicionPago = Convert.ToString(lector.Item("dsTipoCondicionPago"))
                                .nuDiasVencimiento = Convert.ToInt32(lector.Item("nuDiasVencimiento"))
                                .dsEstado = Convert.ToString(lector.Item("dsEstado"))
                            End With
                            lstCondicionPago.Add(objCondicionPago)
                        End While
                        Return lstCondicionPago.FirstOrDefault
                    End Using
                End Using
            End Using
        Catch ex As Exception
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
    End Function
End Class
