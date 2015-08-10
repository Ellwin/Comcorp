Imports System.Data.SqlClient
Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Framework.Common


Public Class DA_Cotizacion
    Inherits DA_BaseClass

    Public Shared Function InsertCotizacion(ByVal objCotizacion As BE_Cotizacion) As Boolean
        Dim resultado As Boolean = False
        Dim dsDocNro As String = String.Empty
        Dim vFunciones As New Funciones
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using trx = cn.BeginTransaction
                    Try
                        Using cmd As New SqlCommand("SP_NUMERADORFAC", cn)
                            cmd.CommandType = CommandType.StoredProcedure
                            cmd.Transaction = trx
                            cmd.Parameters.Add("@cOperacion", SqlDbType.Char, 1).Value = "D"
                            cmd.Parameters.Add("@ccod_cia", SqlDbType.Char, 3).Value = objCotizacion.codCia
                            cmd.Parameters.Add("@cdoc_tipo", SqlDbType.Char, 2).Value = objCotizacion.dsDoc
                            cmd.Parameters.Add("@cdoc_serie", SqlDbType.Char, 3).Value = objCotizacion.dsDocSerie

                            cmd.Parameters.Add("@error_devuelto", SqlDbType.Char, 1).Direction = ParameterDirection.Output
                            cmd.Parameters.Add("@cretornar", SqlDbType.Char, 7).Direction = ParameterDirection.Output
                            cmd.ExecuteNonQuery()

                            dsDocNro = cmd.Parameters("@cretornar").Value
                            dsDocNro = Format(Val(dsDocNro), vFunciones.Replicavalor("0", 7))

                        End Using

                        Using cmd As New SqlCommand("Usp_Concorp_fa_cbpedcot_InsertCotizacion", cn)
                            cmd.CommandType = CommandType.StoredProcedure
                            cmd.Transaction = trx
                            cmd.Parameters.Add("@codCia", SqlDbType.VarChar).Value = objCotizacion.codCia
                            cmd.Parameters.Add("@dsDoc", SqlDbType.VarChar).Value = objCotizacion.dsDoc
                            cmd.Parameters.Add("@dsDocSerie", SqlDbType.VarChar).Value = objCotizacion.dsDocSerie
                            cmd.Parameters.Add("@dsDocNro", SqlDbType.VarChar).Value = dsDocNro
                            cmd.Parameters.Add("@codEjercicio", SqlDbType.VarChar).Value = objCotizacion.codEjercicio
                            cmd.Parameters.Add("@codPeriodo", SqlDbType.VarChar).Value = objCotizacion.codPeriodo
                            cmd.Parameters.Add("@codCondPago", SqlDbType.VarChar).Value = objCotizacion.codCondPago
                            cmd.Parameters.Add("@dsTipoTrans", SqlDbType.VarChar).Value = objCotizacion.dsTipoTrans
                            cmd.Parameters.Add("@dsTipoDoc", SqlDbType.VarChar).Value = objCotizacion.dsTipoDoc
                            cmd.Parameters.Add("@feEmision", SqlDbType.SmallDateTime).Value = Format(objCotizacion.feEmision, Constantes.FORMAT_YYYY_MM_DD)
                            cmd.Parameters.Add("@feVencimiento", SqlDbType.SmallDateTime).Value = Format(objCotizacion.feVencimiento, Constantes.FORMAT_YYYY_MM_DD)
                            cmd.Parameters.Add("@codOperFact", SqlDbType.VarChar).Value = objCotizacion.codOperFact
                            cmd.Parameters.Add("@codOperLog", SqlDbType.VarChar).Value = IIf(String.IsNullOrEmpty(objCotizacion.codOperLog), DBNull.Value, objCotizacion.codOperLog)
                            cmd.Parameters.Add("@codZona", SqlDbType.VarChar).Value = objCotizacion.codZona
                            cmd.Parameters.Add("@codAlmacen", SqlDbType.VarChar).Value = objCotizacion.codAlmacen
                            cmd.Parameters.Add("@codSucursal", SqlDbType.VarChar).Value = objCotizacion.codSucursal
                            cmd.Parameters.Add("@codVendedor", SqlDbType.VarChar).Value = objCotizacion.codVendedor
                            cmd.Parameters.Add("@codCobrador", SqlDbType.VarChar).Value = IIf(String.IsNullOrEmpty(objCotizacion.codCobrador), DBNull.Value, objCotizacion.codCobrador)
                            cmd.Parameters.Add("@codCliente", SqlDbType.VarChar).Value = objCotizacion.codCliente
                            cmd.Parameters.Add("@dsCliente", SqlDbType.VarChar).Value = objCotizacion.dsCliente
                            cmd.Parameters.Add("@dsDireccionCliente", SqlDbType.VarChar).Value = objCotizacion.dsDireccionCliente
                            cmd.Parameters.Add("@dsGlosa", SqlDbType.VarChar).Value = objCotizacion.dsGlosa
                            cmd.Parameters.Add("@dsPrioridad", SqlDbType.VarChar).Value = objCotizacion.dsPrioridad
                            cmd.Parameters.Add("@nuTipoCambio", SqlDbType.Decimal).Value = objCotizacion.nuTipoCambio
                            cmd.Parameters.Add("@codMoneda", SqlDbType.VarChar).Value = objCotizacion.codMoneda
                            cmd.Parameters.Add("@nuBrutoMN", SqlDbType.Decimal).Value = objCotizacion.nuBrutoMN
                            cmd.Parameters.Add("@nuBrutoME", SqlDbType.Decimal).Value = objCotizacion.nuBrutoME
                            cmd.Parameters.Add("@nuNetoMN", SqlDbType.Decimal).Value = objCotizacion.nuNetoMN
                            cmd.Parameters.Add("@nuNetoME", SqlDbType.Decimal).Value = objCotizacion.nuNetoME
                            cmd.Parameters.Add("@nuImpuestoMN", SqlDbType.Decimal).Value = objCotizacion.nuImpuestoMN
                            cmd.Parameters.Add("@nuImpuestoME", SqlDbType.Decimal).Value = objCotizacion.nuImpuestoME
                            cmd.Parameters.Add("@nuTotalMN", SqlDbType.Decimal).Value = objCotizacion.nuTotalMN
                            cmd.Parameters.Add("@nuTotalME", SqlDbType.Decimal).Value = objCotizacion.nuTotalME
                            cmd.Parameters.Add("@bIndicadorPrn", SqlDbType.Bit).Value = objCotizacion.bIndicadorPrn
                            cmd.Parameters.Add("@dsIndContable", SqlDbType.VarChar).Value = objCotizacion.dsIndContable
                            cmd.Parameters.Add("@dsIndImpreso", SqlDbType.VarChar).Value = objCotizacion.dsIndImpreso
                            cmd.Parameters.Add("@codUsuario", SqlDbType.VarChar).Value = objCotizacion.codUsuario
                            cmd.Parameters.Add("@dsEstado", SqlDbType.VarChar).Value = objCotizacion.dsEstado


                            cmd.ExecuteNonQuery()

                        End Using

                        For Each item In objCotizacion.lstCotizacionDetalle
                            Using cmd As New SqlCommand("Usp_Concorp_fa_lnpedcot_InsertCotizacionDetalle", cn)
                                cmd.CommandType = CommandType.StoredProcedure
                                cmd.Transaction = trx

                                cmd.Parameters.Add("@codCia", SqlDbType.VarChar).Value = item.codCia
                                cmd.Parameters.Add("@dsDoc", SqlDbType.VarChar).Value = item.dsDoc
                                cmd.Parameters.Add("@dsDocSerie", SqlDbType.VarChar).Value = item.dsDocSerie
                                cmd.Parameters.Add("@dsDocNro", SqlDbType.VarChar).Value = dsDocNro
                                cmd.Parameters.Add("@codEjercicio", SqlDbType.VarChar).Value = item.codEjercicio
                                cmd.Parameters.Add("@codPeriodo", SqlDbType.VarChar).Value = item.codPeriodo
                                cmd.Parameters.Add("@dsTipoTrans", SqlDbType.VarChar).Value = item.dsTipoTrans
                                cmd.Parameters.Add("@dsTipoDoc", SqlDbType.VarChar).Value = item.dsTipoDoc
                                cmd.Parameters.Add("@dsIdItem", SqlDbType.VarChar).Value = item.dsIdItem
                                cmd.Parameters.Add("@codArticulo", SqlDbType.VarChar).Value = item.codArticulo
                                cmd.Parameters.Add("@dsArticulo", SqlDbType.VarChar).Value = item.dsArticulo
                                cmd.Parameters.Add("@dsTipoItem", SqlDbType.VarChar).Value = item.dsTipoItem
                                cmd.Parameters.Add("@codLinea", SqlDbType.VarChar).Value = item.codLinea
                                cmd.Parameters.Add("@codSubLinea", SqlDbType.VarChar).Value = item.codSubLinea
                                cmd.Parameters.Add("@nuSaldo", SqlDbType.Decimal).Value = item.nuSaldo
                                cmd.Parameters.Add("@nuCantidad", SqlDbType.Decimal).Value = item.nuCantidad
                                cmd.Parameters.Add("@codMoneda", SqlDbType.VarChar).Value = item.codMoneda
                                cmd.Parameters.Add("@codMonedaListaPrecio", SqlDbType.VarChar).Value = item.codMonedaListaPrecio
                                cmd.Parameters.Add("@nuTipoCambio", SqlDbType.Decimal).Value = item.nuTipoCambio
                                cmd.Parameters.Add("@nuPrecioMN", SqlDbType.Decimal).Value = item.nuPrecioMN
                                cmd.Parameters.Add("@nuPrecioME", SqlDbType.Decimal).Value = item.nuPrecioME
                                cmd.Parameters.Add("@nuBrutoMN", SqlDbType.Decimal).Value = item.nuBrutoMN
                                cmd.Parameters.Add("@nuBrutoME", SqlDbType.Decimal).Value = item.nuBrutoME
                                cmd.Parameters.Add("@nuNetoMN", SqlDbType.Decimal).Value = item.nuNetoMN
                                cmd.Parameters.Add("@nuNetoME", SqlDbType.Decimal).Value = item.nuNetoME
                                cmd.Parameters.Add("@nuImpuestoMN", SqlDbType.Decimal).Value = item.nuImpuestoMN
                                cmd.Parameters.Add("@nuImpuestoME", SqlDbType.Decimal).Value = item.nuImpuestoME
                                cmd.Parameters.Add("@nuTotalMN", SqlDbType.Decimal).Value = item.nuTotalMN
                                cmd.Parameters.Add("@nuTotalME", SqlDbType.Decimal).Value = item.nuTotalME
                                cmd.Parameters.Add("@codCliente", SqlDbType.VarChar).Value = item.codCliente
                                cmd.Parameters.Add("@codVendedor", SqlDbType.VarChar).Value = item.codVendedor
                                cmd.Parameters.Add("@codAlmacen", SqlDbType.VarChar).Value = item.codAlmacen
                                cmd.Parameters.Add("@codOperLog", SqlDbType.VarChar).Value = item.codOperLog
                                cmd.Parameters.Add("@codUnidadMedida", SqlDbType.VarChar).Value = item.codUnidadMedidaAlmacen
                                cmd.Parameters.Add("@codZona", SqlDbType.VarChar).Value = item.codZona
                                cmd.Parameters.Add("@codSucursal", SqlDbType.VarChar).Value = item.codSucursal
                                cmd.Parameters.Add("@codOperFact", SqlDbType.VarChar).Value = item.codOperFact
                                cmd.Parameters.Add("@feEmision", SqlDbType.SmallDateTime).Value = Format(item.feEmision, Constantes.FORMAT_YYYY_MM_DD)
                                cmd.Parameters.Add("@bIva", SqlDbType.Bit).Value = item.bIva
                                cmd.Parameters.Add("@bSerie", SqlDbType.Bit).Value = item.bSerie
                                cmd.Parameters.Add("@bLote", SqlDbType.Bit).Value = item.bLote
                                cmd.Parameters.Add("@codCondPago", SqlDbType.VarChar).Value = item.codCondPago
                                cmd.Parameters.Add("@codListaPrecio", SqlDbType.VarChar).Value = item.codListaPrecio
                                cmd.Parameters.Add("@bAfectoPercepcion", SqlDbType.Bit).Value = item.bAfectoPercepcion
                                cmd.Parameters.Add("@codUsuario", SqlDbType.VarChar).Value = item.codUsuario
                                cmd.Parameters.Add("@dsEstado", SqlDbType.VarChar).Value = item.dsEstado

                                cmd.ExecuteNonQuery()
                            End Using
                        Next

                        Using cmd As New SqlCommand("SP_NUMERADORFAC", cn)
                            cmd.CommandType = CommandType.StoredProcedure
                            cmd.Transaction = trx

                            cmd.Parameters.Add("@cOperacion", SqlDbType.Char, 1).Value = "A"
                            cmd.Parameters.Add("@ccod_cia", SqlDbType.Char, 3).Value = objCotizacion.codCia
                            cmd.Parameters.Add("@cdoc_tipo", SqlDbType.Char, 2).Value = objCotizacion.dsDoc
                            cmd.Parameters.Add("@cdoc_serie", SqlDbType.Char, 3).Value = objCotizacion.dsDocSerie

                            cmd.Parameters.Add("@error_devuelto", SqlDbType.Char, 1).Direction = ParameterDirection.Output
                            cmd.Parameters.Add("@cretornar", SqlDbType.Char, 7).Direction = ParameterDirection.Output
                            cmd.ExecuteNonQuery()

                            dsDocNro = cmd.Parameters("@cretornar").Value
                            dsDocNro = Format(Val(dsDocNro), vFunciones.Replicavalor("0", 7))
                        End Using

                        trx.Commit()
                        resultado = True
                    Catch ex As Exception
                        trx.Rollback()
                        resultado = False
                        DA_BaseClass.LogSQLException(ex)
                    End Try
                End Using
            End Using
        Catch ex As Exception
            resultado = False
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
        Return resultado
    End Function

    Public Shared Function ListarCotizacion(ByVal codCia As String, ByVal codEjercicio As String, ByVal codPeriodo As String) As List(Of BE_Cotizacion)
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("Usp_Concorp_fa_cbpedcot_ListarCotizacion", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@codCia", SqlDbType.VarChar).Value = codCia
                    cmd.Parameters.Add("@codEjercicio", SqlDbType.VarChar).Value = codEjercicio
                    cmd.Parameters.Add("@codPeriodo", SqlDbType.VarChar).Value = codPeriodo
                    Using lector As SqlDataReader = cmd.ExecuteReader
                        Dim lstCotizacion As New List(Of BE_Cotizacion)
                        Dim objCotizacion As BE_Cotizacion
                        While lector.Read()
                            objCotizacion = New BE_Cotizacion
                            With objCotizacion
                                .id = Convert.ToInt64(lector.Item("id"))
                                .codCia = Convert.ToString(lector.Item("codCia"))
                                .dsDoc = Convert.ToString(lector.Item("dsDoc"))
                                .dsDocSerie = Convert.ToString(lector.Item("dsDocSerie"))
                                .dsDocNro = Convert.ToString(lector.Item("dsDocNro"))
                                .codEjercicio = Convert.ToString(lector.Item("codEjercicio"))
                                .codPeriodo = Convert.ToString(lector.Item("codPeriodo"))
                                .feEmision = Convert.ToDateTime(lector.Item("feEmision"))
                                .codOperFact = Convert.ToString(lector.Item("codOperFact"))
                                .dsOperFact = Convert.ToString(lector.Item("dsOperFact"))
                                .codCliente = Convert.ToString(lector.Item("codCliente"))
                                .dsCliente = Convert.ToString(lector.Item("dsCliente"))
                                .nuTotal = Convert.ToDouble(lector.Item("nuTotal"))
                                .nuTotalMN = Convert.ToDouble(lector.Item("nuTotalMN"))
                                .nuTotalME = Convert.ToDouble(lector.Item("nuTotalME"))
                                .nuBruto = Convert.ToDouble(lector.Item("nuBruto"))
                                .nuBrutoMN = Convert.ToDouble(lector.Item("nuBrutoMN"))
                                .nuBrutoME = Convert.ToDouble(lector.Item("nuBrutoME"))
                                .nuNeto = Convert.ToDouble(lector.Item("nuNeto"))
                                .nuNetoMN = Convert.ToDouble(lector.Item("nuNetoMN"))
                                .nuNetoME = Convert.ToDouble(lector.Item("nuNetoME"))
                                .nuImpuesto = Convert.ToDouble(lector.Item("nuImpuesto"))
                                .nuImpuestoMN = Convert.ToDouble(lector.Item("nuImpuestoMN"))
                                .nuImpuestoME = Convert.ToDouble(lector.Item("nuImpuestoME"))
                                .codAlmacen = Convert.ToString(lector.Item("codAlmacen"))
                                .dsAlmacen = Convert.ToString(lector.Item("dsAlmacen"))
                                .dsTipoDoc = Convert.ToString(lector.Item("dsTipoDoc"))
                                .dsTipoTrans = Convert.ToString(lector.Item("dsTipoTrans"))
                                .feVencimiento = Convert.ToDateTime(lector.Item("feVencimiento"))
                                .codOperLog = Convert.ToString(lector.Item("codOperLog"))
                                .codZona = Convert.ToString(lector.Item("codZona"))
                                .dsZona = Convert.ToString(lector.Item("dsZona"))
                                .codVendedor = Convert.ToString(lector.Item("codVendedor"))
                                .dsVendedor = Convert.ToString(lector.Item("dsVendedor"))
                                .codSucursal = Convert.ToString(lector.Item("codSucursal"))
                                .dsSucursal = Convert.ToString(lector.Item("dsSucursal"))
                                .codCobrador = Convert.ToString(lector.Item("codCobrador"))
                                .dsCobrador = Convert.ToString(lector.Item("dsCobrador"))
                                .codCondPago = Convert.ToString(lector.Item("codCondPago"))
                                .dsCondPago = Convert.ToString(lector.Item("dsCondPago"))
                                .dsTipoCondPago = Convert.ToString(lector.Item("dsTipoCondPago"))
                                .dsDireccionCliente = Convert.ToString(lector.Item("dsDireccionCliente"))
                                .dsGlosa = Convert.ToString(lector.Item("dsGlosa"))
                                .dsPrioridad = Convert.ToString(lector.Item("dsPrioridad"))
                                .nuTipoCambio = Convert.ToDouble(lector.Item("nuTipoCambio"))
                                .codMoneda = Convert.ToString(lector.Item("codMoneda"))
                                .dsMoneda = Convert.ToString(lector.Item("dsMoneda"))
                                .dsUsuCreacion = Convert.ToString(lector.Item("dsUsuCreacion"))
                                .feCreacion = Convert.ToDateTime(lector.Item("feCreacion"))
                                .dsUsuModificacion = Convert.ToString(lector.Item("dsUsuModificacion"))
                                .feModificacion = Convert.ToDateTime(lector.Item("feModificacion"))
                                .dsEstado = Convert.ToString(lector.Item("dsEstado"))
                            End With
                            lstCotizacion.Add(objCotizacion)
                        End While
                        Return lstCotizacion
                    End Using
                End Using
            End Using
        Catch ex As Exception
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
    End Function

    Public Shared Function GetCotizacionDetalle(ByVal codCia As String, ByVal codEjercicio As String, ByVal codPeriodo As String,
                                                ByVal dsDoc As String, ByVal dsDocSerie As String, ByVal dsDocNro As String) As List(Of BE_ItemFactura)
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("Usp_Concorp_fa_lnpedcot_GetCotizacionDetalle", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@codCia", SqlDbType.VarChar).Value = codCia
                    cmd.Parameters.Add("@dsDoc", SqlDbType.VarChar).Value = dsDoc
                    cmd.Parameters.Add("@dsDocSerie", SqlDbType.VarChar).Value = dsDocSerie
                    cmd.Parameters.Add("@dsDocNro", SqlDbType.VarChar).Value = dsDocNro
                    cmd.Parameters.Add("@codEjercicio", SqlDbType.VarChar).Value = codEjercicio
                    cmd.Parameters.Add("@codPeriodo", SqlDbType.VarChar).Value = codPeriodo
                    Using lector As SqlDataReader = cmd.ExecuteReader
                        Dim lstCotizacionDetalle As New List(Of BE_ItemFactura)
                        Dim objCotizacionDetalle As BE_ItemFactura
                        While lector.Read()
                            objCotizacionDetalle = New BE_ItemFactura
                            With objCotizacionDetalle
                                '.id = Convert.ToInt64(lector.Item("id"))
                                '.dsDoc = Convert.ToString(lector.Item("dsDoc"))
                                '.dsDocSerie = Convert.ToString(lector.Item("dsDocSerie"))
                                '.dsDocNro = Convert.ToString(lector.Item("dsDocNro"))
                                '.codEjercicio = Convert.ToString(lector.Item("codEjercicio"))
                                '.codPeriodo = Convert.ToString(lector.Item("codPeriodo"))
                                '.feEmision = Convert.ToDateTime(lector.Item("feEmision"))
                                '.codOperFact = Convert.ToString(lector.Item("codOperFact"))
                                '.dsOperFact = Convert.ToString(lector.Item("dsOperFact"))
                                '.codCliente = Convert.ToString(lector.Item("codCliente"))
                                .nuPrecio = Convert.ToDouble(lector.Item("nuPrecio"))
                                .nuPrecioMN = Convert.ToDouble(lector.Item("nuPrecioMN"))
                                .nuPrecioME = Convert.ToDouble(lector.Item("nuPrecioME"))
                                .nuTotal = Convert.ToDouble(lector.Item("nuTotal"))
                                .nuTotalMN = Convert.ToDouble(lector.Item("nuTotalMN"))
                                .nuTotalME = Convert.ToDouble(lector.Item("nuTotalME"))
                                .nuBruto = Convert.ToDouble(lector.Item("nuBruto"))
                                .nuBrutoMN = Convert.ToDouble(lector.Item("nuBrutoMN"))
                                .nuBrutoME = Convert.ToDouble(lector.Item("nuBrutoME"))
                                .nuNeto = Convert.ToDouble(lector.Item("nuNeto"))
                                .nuNetoMN = Convert.ToDouble(lector.Item("nuNetoMN"))
                                .nuNetoME = Convert.ToDouble(lector.Item("nuNetoME"))
                                .nuImpuesto = Convert.ToDouble(lector.Item("nuImpuesto"))
                                .nuImpuestoMN = Convert.ToDouble(lector.Item("nuImpuestoMN"))
                                .nuImpuestoME = Convert.ToDouble(lector.Item("nuImpuestoME"))
                                .nuTasaImpuesto = Convert.ToDouble(lector.Item("nuTasaImpuesto"))
                                .nuSaldo = Convert.ToDouble(lector.Item("nuSaldo"))
                                '.dsIdItem = Convert.ToString(lector.Item("dsIdItem"))
                                .codUnidadMedidaAlmacen = Convert.ToString(lector.Item("codUnidadMedidaAlmacen"))
                                .codAlmacen = Convert.ToString(lector.Item("codAlmacen"))
                                .dsAlmacen = Convert.ToString(lector.Item("dsAlmacen"))
                                .codArticulo = Convert.ToString(lector.Item("codArticulo"))
                                .dsArticulo = Convert.ToString(lector.Item("dsArticulo"))
                                .dsTipoItem = Convert.ToString(lector.Item("dsTipoItem"))
                                '.dsTipoListaPrecio = Convert.ToString(lector.Item("dsTipoListaPrecio"))
                                .codListaPrecio = Convert.ToString(lector.Item("codListaPrecio"))
                                .bIva = Convert.ToBoolean(lector.Item("bIva"))
                                .codLinea = Convert.ToString(lector.Item("codLinea"))
                                .dsLinea = Convert.ToString(lector.Item("dsLinea"))
                                .codSubLinea = Convert.ToString(lector.Item("codSubLinea"))
                                .dsSubLinea = Convert.ToString(lector.Item("dsSubLinea"))
                                '.dsTipoDoc = Convert.ToString(lector.Item("dsTipoDoc"))
                                '.dsTipoTrans = Convert.ToString(lector.Item("dsTipoTrans"))
                                '.codOperLog = Convert.ToString(lector.Item("codOperLog"))
                                '.codZona = Convert.ToString(lector.Item("codZona"))
                                '.dsZona = Convert.ToString(lector.Item("dsZona"))
                                .codVendedor = Convert.ToString(lector.Item("codVendedor"))
                                .dsVendedor = Convert.ToString(lector.Item("dsVendedor"))
                                '.codSucursal = Convert.ToString(lector.Item("codSucursal"))
                                '.dsSucursal = Convert.ToString(lector.Item("dsSucursal"))
                                '.codCondPago = Convert.ToString(lector.Item("codCondPago"))
                                '.dsCondPago = Convert.ToString(lector.Item("dsCondPago"))
                                '.dsTipoCondPago = Convert.ToString(lector.Item("dsTipoCondPago"))
                                '.nuTipoCambio = Convert.ToDouble(lector.Item("nuTipoCambio"))
                                .codMoneda = Convert.ToString(lector.Item("codMoneda"))
                                .dsMoneda = Convert.ToString(lector.Item("dsMoneda"))
                                '.codMonedaListaPrecio = Convert.ToString(lector.Item("codMonedaListaPrecio"))
                                '.dsUsuCreacion = Convert.ToString(lector.Item("dsUsuCreacion"))
                                '.feCreacion = Convert.ToDateTime(lector.Item("feCreacion"))
                                '.dsUsuModificacion = Convert.ToString(lector.Item("dsUsuModificacion"))
                                '.feModificacion = Convert.ToDateTime(lector.Item("feModificacion"))
                                .dsEstado = Convert.ToString(lector.Item("dsEstado"))
                            End With
                            lstCotizacionDetalle.Add(objCotizacionDetalle)
                        End While
                        Return lstCotizacionDetalle
                    End Using
                End Using
            End Using
        Catch ex As Exception
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
    End Function

End Class
