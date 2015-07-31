Imports System.Data.SqlClient
Imports Linksoft.Comcorp.BusinessEntities

Public Class DA_Vendedor
    Inherits DA_BaseClass

    Public Shared Function GetVendedor(ByVal codCia As String, ByVal codVendedor As String) As BE_Vendedor
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("Usp_Concorp_fa_ctvend_GetVendedor", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@codCia", SqlDbType.VarChar).Value = codCia
                    cmd.Parameters.Add("@codVendedor", SqlDbType.VarChar).Value = codVendedor

                    Using lector As SqlDataReader = cmd.ExecuteReader
                        Dim lstVendedor As New List(Of BE_Vendedor)
                        Dim objVendedor As BE_Vendedor
                        While lector.Read()
                            objVendedor = New BE_Vendedor
                            With objVendedor
                                .codCia = Convert.ToString(lector.Item("codCia"))
                                .codVendedor = Convert.ToString(lector.Item("codVendedor"))
                                .dsVendedor = Convert.ToString(lector.Item("dsVendedor"))
                                .dsEstado = Convert.ToString(lector.Item("dsEstado"))
                            End With
                            lstVendedor.Add(objVendedor)
                        End While
                        Return lstVendedor.FirstOrDefault
                    End Using
                End Using
            End Using
        Catch ex As Exception
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
    End Function
End Class
