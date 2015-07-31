Imports System.Data.SqlClient
Imports Linksoft.Comcorp.BusinessEntities

Public Class DA_ItemFactura
    Inherits DA_BaseClass

    Public Shared Function GetItemFactura(ByVal codCia As String, ByVal codArticulo As String,
                                          ByVal codEjercicio As String, ByVal codPeriodo As String,
                                          ByVal codAlmacen As String) As BE_ItemFactura
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("Usp_Concorp_Util_GetItemFactura", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@codCia", SqlDbType.VarChar).Value = codCia
                    cmd.Parameters.Add("@codArticulo", SqlDbType.VarChar).Value = codArticulo
                    cmd.Parameters.Add("@codEjercicio", SqlDbType.VarChar).Value = codEjercicio
                    cmd.Parameters.Add("@codPeriodo", SqlDbType.VarChar).Value = codPeriodo
                    cmd.Parameters.Add("@codAlmacen", SqlDbType.VarChar).Value = codAlmacen
                    Using lector As SqlDataReader = cmd.ExecuteReader
                        Dim lstItemFactura As New List(Of BE_ItemFactura)
                        Dim objItemFactura As BE_ItemFactura
                        While lector.Read()
                            objItemFactura = New BE_ItemFactura
                            With objItemFactura
                                .codArticulo = Convert.ToString(lector.Item("codArticulo"))
                                .dsArticulo = Convert.ToString(lector.Item("dsArticulo"))
                                .codUnidadMedidaAlmacen = Convert.ToString(lector.Item("codUnidadMedidaAlmacen"))
                                .nuSaldo = Convert.ToDouble(lector.Item("nuSaldo"))
                                .codLinea = Convert.ToString(lector.Item("codLinea"))
                                .dsLinea = Convert.ToString(lector.Item("dsLinea"))
                                .codSubLinea = Convert.ToString(lector.Item("codSubLinea"))
                                .dsSubLinea = Convert.ToString(lector.Item("dsSubLinea"))
                                .dsModelo = Convert.ToString(lector.Item("dsModelo"))
                                .dsMarca = Convert.ToString(lector.Item("dsMarca"))
                                .dsColor = Convert.ToString(lector.Item("dsColor"))
                                .bIva = Convert.ToBoolean(lector.Item("bIva"))
                                .nuTasaImpuesto = Convert.ToDouble(lector.Item("nuTasaImpuesto"))
                            End With
                            lstItemFactura.Add(objItemFactura)
                        End While
                        Return lstItemFactura.FirstOrDefault
                    End Using
                End Using
            End Using
        Catch ex As Exception
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
    End Function

    Public Shared Function GetListaPrecioArticulo(ByVal codCia As String, ByVal codArticulo As String, ByVal codListaPrecio As String) As BE_ItemFactura
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("Usp_Concorp_fa_lnlprec_GetListaPrecioArticulo", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@codCia", SqlDbType.VarChar).Value = codCia
                    cmd.Parameters.Add("@codArticulo", SqlDbType.VarChar).Value = codArticulo
                    cmd.Parameters.Add("@codListaPrecio", SqlDbType.VarChar).Value = codListaPrecio
                    
                    Using lector As SqlDataReader = cmd.ExecuteReader
                        Dim lstItemFactura As New List(Of BE_ItemFactura)
                        Dim objItemFactura As BE_ItemFactura
                        While lector.Read()
                            objItemFactura = New BE_ItemFactura
                            With objItemFactura
                                .codCia = Convert.ToString(lector.Item("codCia"))
                                .codListaPrecio = Convert.ToString(lector.Item("codListaPrecio"))
                                .codArticulo = Convert.ToString(lector.Item("codArticulo"))
                                .nuPrecioMN = Convert.ToDouble(lector.Item("nuPrecioMN"))
                                .nuPrecioME = Convert.ToDouble(lector.Item("nuPrecioME"))
                                .dsEstado = Convert.ToString(lector.Item("dsEstado"))
                            End With
                            lstItemFactura.Add(objItemFactura)
                        End While
                        Return lstItemFactura.FirstOrDefault
                    End Using
                End Using
            End Using
        Catch ex As Exception
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
    End Function
End Class
