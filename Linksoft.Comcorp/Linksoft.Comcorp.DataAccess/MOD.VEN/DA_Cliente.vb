Imports System.Data.SqlClient
Imports Linksoft.Comcorp.BusinessEntities

Public Class DA_Cliente
    Inherits DA_BaseClass

    Public Shared Function GetDatosCliente(ByVal codCia As String, ByVal codCliente As String) As BE_Cliente
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("Usp_Concorp_co_ctcoa_GetCliente", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@codCia", SqlDbType.VarChar).Value = codCia
                    cmd.Parameters.Add("@codCliente", SqlDbType.VarChar).Value = codCliente
                    Using lector As SqlDataReader = cmd.ExecuteReader
                        Dim lstCliente As New List(Of BE_Cliente)
                        Dim objCliente As BE_Cliente
                        While lector.Read()
                            objCliente = New BE_Cliente
                            With objCliente
                                .codCia = Convert.ToString(lector.Item("codCia"))
                                .codCliente = Convert.ToString(lector.Item("codCliente"))
                                .dsCliente = Convert.ToString(lector.Item("dsCliente"))
                                .dsTipoCliente = Convert.ToString(lector.Item("dsTipoCliente"))
                                .dsDireccion = Convert.ToString(lector.Item("dsDireccion"))
                                .codOperacionFacturacion = Convert.ToString(lector.Item("codOperacionFacturacion"))
                                .dsOperacionFacturacion = Convert.ToString(lector.Item("dsOperacionFacturacion"))
                                .codMoneda = Convert.ToString(lector.Item("codMoneda"))
                                .dsMoneda = Convert.ToString(lector.Item("dsMoneda"))
                                .codCondicionPago = Convert.ToString(lector.Item("codCondicionPago"))
                                .dsCondicionPago = Convert.ToString(lector.Item("dsCondicionPago"))
                                .dsTipoCondicionPago = Convert.ToString(lector.Item("dsTipoCondicionPago"))
                                .nuDiasVencimiento = Convert.ToInt32(lector.Item("nuDiasVencimiento"))
                                .codVendedor = Convert.ToString(lector.Item("codVendedor"))
                                .dsVendedor = Convert.ToString(lector.Item("dsVendedor"))
                                .codZona = Convert.ToString(lector.Item("codZona"))
                                .dsZona = Convert.ToString(lector.Item("dsZona"))
                                .codCobrador = Convert.ToString(lector.Item("codCobrador"))
                                .dsCobrador = Convert.ToString(lector.Item("dsCobrador"))
                                .codCanalVenta = Convert.ToString(lector.Item("codCanalVenta"))
                                .dsCanalVenta = Convert.ToString(lector.Item("dsCanalVenta"))
                                .codUnidadOperativa = Convert.ToString(lector.Item("codUnidadOperativa"))
                                .dsUnidadOperativa = Convert.ToString(lector.Item("dsUnidadOperativa"))
                                .codListaPrecio = Convert.ToString(lector.Item("codListaPrecio"))
                                .dsListaPrecio = Convert.ToString(lector.Item("dsListaPrecio"))
                                .codListaDescuento = Convert.ToString(lector.Item("codListaDescuento"))
                                .dsListaDescuento = Convert.ToString(lector.Item("dsListaDescuento"))
                                .dsEstado = Convert.ToString(lector.Item("dsEstado"))
                            End With
                            lstCliente.Add(objCliente)
                        End While
                        Return lstCliente.FirstOrDefault
                    End Using
                End Using
            End Using
        Catch ex As Exception
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
    End Function
End Class
