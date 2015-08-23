Imports System.Data.SqlClient
Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Framework.Common

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
                                .codOperacionLogistica = Convert.ToString(lector.Item("dsOperacionLogistica"))
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

    Public Shared Function ListarCliente(ByVal codCia As String) As List(Of BE_Cliente)
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("Usp_Concorp_co_ctcoa_ListarCliente", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@codCia", SqlDbType.VarChar).Value = codCia
                    Using lector As SqlDataReader = cmd.ExecuteReader
                        Dim lstCliente As New List(Of BE_Cliente)
                        Dim objCliente As BE_Cliente
                        While lector.Read()
                            objCliente = New BE_Cliente
                            With objCliente
                                .id = Convert.ToInt64(lector.Item("id"))
                                .codCia = Convert.ToString(lector.Item("codCia"))
                                .codCliente = Convert.ToString(lector.Item("codCliente"))
                                .dsCliente = Convert.ToString(lector.Item("dsCliente"))
                                .dsTipoClasificacion = Convert.ToString(lector.Item("dsTipoClasificacion"))
                                .dsTipoCliente = Convert.ToString(lector.Item("dsTipoCliente"))
                                .dsTipoDocumento = Convert.ToString(lector.Item("dsTipoDocumento"))
                                .dsNroDocumento = Convert.ToString(lector.Item("dsNroDocumento"))
                                .dsRuc = Convert.ToString(lector.Item("dsRuc"))
                                .dsApellidoPaterno = Convert.ToString(lector.Item("dsApellidoPaterno"))
                                .dsApellidoMaterno = Convert.ToString(lector.Item("dsApellidoMaterno"))
                                .dsNombres = Convert.ToString(lector.Item("dsNombres"))

                                If Not IsDBNull(lector.Item("feNacimiento")) Then
                                    .feNacimiento = Convert.ToDateTime(lector.Item("feNacimiento"))
                                Else
                                    .feNacimiento = String.Empty
                                End If

                                .dsDireccion = Convert.ToString(lector.Item("dsDireccion"))
                                .dsTelefono1 = Convert.ToString(lector.Item("dsTelefono1"))
                                .dsDistrito = Convert.ToString(lector.Item("dsDistrito"))
                                .dsProvincia = Convert.ToString(lector.Item("dsProvincia"))
                                .dsTelefono2 = Convert.ToString(lector.Item("dsTelefono2"))
                                .dsDepartamento = Convert.ToString(lector.Item("dsDepartamento"))
                                .dsPais = Convert.ToString(lector.Item("dsPais"))
                                .dsFax = Convert.ToString(lector.Item("dsFax"))
                                .dsEmail1 = Convert.ToString(lector.Item("dsEmail1"))
                                .dsCodigoPostal = Convert.ToString(lector.Item("dsCodigoPostal"))
                                .dsEmail2 = Convert.ToString(lector.Item("dsEmail2"))
                                .dsUsuCreacion = Convert.ToString(lector.Item("dsUsuCreacion"))
                                .feCreacion = Convert.ToDateTime(lector.Item("feCreacion"))
                                .dsUsuModificacion = Convert.ToString(lector.Item("dsUsuModificacion"))
                                .feModificacion = Convert.ToDateTime(lector.Item("feModificacion"))
                                .dsEstado = Convert.ToString(lector.Item("dsEstado"))
                            End With
                            lstCliente.Add(objCliente)
                        End While
                        Return lstCliente
                    End Using
                End Using
            End Using
        Catch ex As Exception
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
    End Function

    Public Shared Function InsertCliente(ByVal objCliente As BE_Cliente) As Boolean
        Dim resultado As Boolean = False

        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using trx = cn.BeginTransaction
                    Try

                        Using cmd As New SqlCommand("Usp_Concorp_co_ctcoa_InsertCliente", cn)
                            cmd.CommandType = CommandType.StoredProcedure
                            cmd.Transaction = trx
                            cmd.Parameters.Add("@codCia", SqlDbType.Char, 3).Value = objCliente.codCia
                            cmd.Parameters.Add("@codCliente", SqlDbType.Char, 11).Value = objCliente.codCliente
                            cmd.Parameters.Add("@dsCliente", SqlDbType.Char, 80).Value = objCliente.dsCliente
                            cmd.Parameters.Add("@dsTipoClasificacion", SqlDbType.Char, 1).Value = objCliente.dsTipoClasificacion
                            cmd.Parameters.Add("@dsTipoCliente", SqlDbType.Char, 2).Value = objCliente.dsTipoCliente
                            cmd.Parameters.Add("@dsTipoDocumento", SqlDbType.Char, 2).Value = objCliente.dsTipoDocumento
                            cmd.Parameters.Add("@dsNroDocumento", SqlDbType.Char, 12).Value = IIf(String.IsNullOrEmpty(objCliente.dsNroDocumento), DBNull.Value, objCliente.dsNroDocumento)
                            cmd.Parameters.Add("@dsRuc", SqlDbType.Char, 11).Value = IIf(String.IsNullOrEmpty(objCliente.dsRuc), DBNull.Value, objCliente.dsRuc)
                            cmd.Parameters.Add("@dsApellidoPaterno", SqlDbType.Char, 50).Value = IIf(String.IsNullOrEmpty(objCliente.dsApellidoPaterno), DBNull.Value, objCliente.dsApellidoPaterno)
                            cmd.Parameters.Add("@dsApellidoMaterno", SqlDbType.Char, 50).Value = IIf(String.IsNullOrEmpty(objCliente.dsApellidoMaterno), DBNull.Value, objCliente.dsApellidoMaterno)
                            cmd.Parameters.Add("@dsNombres", SqlDbType.Char, 50).Value = IIf(String.IsNullOrEmpty(objCliente.dsNombres), DBNull.Value, objCliente.dsNombres)
                            cmd.Parameters.Add("@feNacimiento", SqlDbType.SmallDateTime)

                            If String.IsNullOrEmpty(objCliente.feNacimiento) Then
                                cmd.Parameters("@feNacimiento").Value = DBNull.Value
                            Else
                                cmd.Parameters("@feNacimiento").Value = Format(CDate(objCliente.feNacimiento), Constantes.FORMAT_YYYY_MM_DD)
                            End If


                            cmd.Parameters.Add("@dsDireccion", SqlDbType.NVarChar, 200).Value = IIf(String.IsNullOrEmpty(objCliente.dsDireccion), DBNull.Value, objCliente.dsDireccion)
                            cmd.Parameters.Add("@dsTelefono1", SqlDbType.VarChar, 25).Value = IIf(String.IsNullOrEmpty(objCliente.dsTelefono1), DBNull.Value, objCliente.dsTelefono1)
                            cmd.Parameters.Add("@dsDistrito", SqlDbType.Char, 30).Value = IIf(String.IsNullOrEmpty(objCliente.dsDistrito), DBNull.Value, objCliente.dsDistrito)
                            cmd.Parameters.Add("@dsProvincia", SqlDbType.Char, 30).Value = IIf(String.IsNullOrEmpty(objCliente.dsProvincia), DBNull.Value, objCliente.dsProvincia)
                            cmd.Parameters.Add("@dsTelefono2", SqlDbType.VarChar, 25).Value = IIf(String.IsNullOrEmpty(objCliente.dsTelefono2), DBNull.Value, objCliente.dsTelefono2)
                            cmd.Parameters.Add("@dsDepartamento", SqlDbType.Char, 30).Value = IIf(String.IsNullOrEmpty(objCliente.dsDepartamento), DBNull.Value, objCliente.dsDepartamento)
                            cmd.Parameters.Add("@dsPais", SqlDbType.Char, 30).Value = IIf(String.IsNullOrEmpty(objCliente.dsPais), DBNull.Value, objCliente.dsPais)
                            cmd.Parameters.Add("@dsFax", SqlDbType.Char, 100).Value = IIf(String.IsNullOrEmpty(objCliente.dsFax), DBNull.Value, objCliente.dsFax)
                            cmd.Parameters.Add("@dsEmail1", SqlDbType.Char, 50).Value = IIf(String.IsNullOrEmpty(objCliente.dsEmail1), DBNull.Value, objCliente.dsEmail1)
                            cmd.Parameters.Add("@dsCodigoPostal", SqlDbType.Char, 7).Value = IIf(String.IsNullOrEmpty(objCliente.dsCodigoPostal), DBNull.Value, objCliente.dsCodigoPostal)
                            cmd.Parameters.Add("@dsEmail2", SqlDbType.Char, 50).Value = IIf(String.IsNullOrEmpty(objCliente.dsEmail2), DBNull.Value, objCliente.dsEmail2)
                            cmd.Parameters.Add("@codUsuario", SqlDbType.Char, 5).Value = objCliente.codUsuario
                            cmd.Parameters.Add("@dsEstado", SqlDbType.Char, 1).Value = objCliente.dsEstado

                            cmd.ExecuteNonQuery()

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

    Public Shared Function UpdateCliente(ByVal objCliente As BE_Cliente) As Boolean
        Dim resultado As Boolean = False

        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using trx = cn.BeginTransaction
                    Try

                        Using cmd As New SqlCommand("Usp_Concorp_co_ctcoa_UpdateCliente", cn)
                            cmd.CommandType = CommandType.StoredProcedure
                            cmd.Transaction = trx
                            cmd.Parameters.Add("@codCia", SqlDbType.Char, 3).Value = objCliente.codCia
                            cmd.Parameters.Add("@codCliente", SqlDbType.Char, 11).Value = objCliente.codCliente
                            cmd.Parameters.Add("@dsCliente", SqlDbType.Char, 80).Value = objCliente.dsCliente
                            cmd.Parameters.Add("@dsTipoClasificacion", SqlDbType.Char, 1).Value = objCliente.dsTipoClasificacion
                            cmd.Parameters.Add("@dsTipoCliente", SqlDbType.Char, 2).Value = objCliente.dsTipoCliente
                            cmd.Parameters.Add("@dsTipoDocumento", SqlDbType.Char, 2).Value = objCliente.dsTipoDocumento
                            cmd.Parameters.Add("@dsNroDocumento", SqlDbType.Char, 12).Value = IIf(String.IsNullOrEmpty(objCliente.dsNroDocumento), DBNull.Value, objCliente.dsNroDocumento)
                            cmd.Parameters.Add("@dsRuc", SqlDbType.Char, 11).Value = IIf(String.IsNullOrEmpty(objCliente.dsRuc), DBNull.Value, objCliente.dsRuc)
                            cmd.Parameters.Add("@dsApellidoPaterno", SqlDbType.Char, 50).Value = IIf(String.IsNullOrEmpty(objCliente.dsApellidoPaterno), DBNull.Value, objCliente.dsApellidoPaterno)
                            cmd.Parameters.Add("@dsApellidoMaterno", SqlDbType.Char, 50).Value = IIf(String.IsNullOrEmpty(objCliente.dsApellidoMaterno), DBNull.Value, objCliente.dsApellidoMaterno)
                            cmd.Parameters.Add("@dsNombres", SqlDbType.Char, 50).Value = IIf(String.IsNullOrEmpty(objCliente.dsNombres), DBNull.Value, objCliente.dsNombres)
                            cmd.Parameters.Add("@feNacimiento", SqlDbType.SmallDateTime)

                            If String.IsNullOrEmpty(objCliente.feNacimiento) Then
                                cmd.Parameters("@feNacimiento").Value = DBNull.Value
                            Else
                                cmd.Parameters("@feNacimiento").Value = Format(CDate(objCliente.feNacimiento), Constantes.FORMAT_YYYY_MM_DD)
                            End If


                            cmd.Parameters.Add("@dsDireccion", SqlDbType.NVarChar, 200).Value = IIf(String.IsNullOrEmpty(objCliente.dsDireccion), DBNull.Value, objCliente.dsDireccion)
                            cmd.Parameters.Add("@dsTelefono1", SqlDbType.VarChar, 25).Value = IIf(String.IsNullOrEmpty(objCliente.dsTelefono1), DBNull.Value, objCliente.dsTelefono1)
                            cmd.Parameters.Add("@dsDistrito", SqlDbType.Char, 30).Value = IIf(String.IsNullOrEmpty(objCliente.dsDistrito), DBNull.Value, objCliente.dsDistrito)
                            cmd.Parameters.Add("@dsProvincia", SqlDbType.Char, 30).Value = IIf(String.IsNullOrEmpty(objCliente.dsProvincia), DBNull.Value, objCliente.dsProvincia)
                            cmd.Parameters.Add("@dsTelefono2", SqlDbType.VarChar, 25).Value = IIf(String.IsNullOrEmpty(objCliente.dsTelefono2), DBNull.Value, objCliente.dsTelefono2)
                            cmd.Parameters.Add("@dsDepartamento", SqlDbType.Char, 30).Value = IIf(String.IsNullOrEmpty(objCliente.dsDepartamento), DBNull.Value, objCliente.dsDepartamento)
                            cmd.Parameters.Add("@dsPais", SqlDbType.Char, 30).Value = IIf(String.IsNullOrEmpty(objCliente.dsPais), DBNull.Value, objCliente.dsPais)
                            cmd.Parameters.Add("@dsFax", SqlDbType.Char, 100).Value = IIf(String.IsNullOrEmpty(objCliente.dsFax), DBNull.Value, objCliente.dsFax)
                            cmd.Parameters.Add("@dsEmail1", SqlDbType.Char, 50).Value = IIf(String.IsNullOrEmpty(objCliente.dsEmail1), DBNull.Value, objCliente.dsEmail1)
                            cmd.Parameters.Add("@dsCodigoPostal", SqlDbType.Char, 7).Value = IIf(String.IsNullOrEmpty(objCliente.dsCodigoPostal), DBNull.Value, objCliente.dsCodigoPostal)
                            cmd.Parameters.Add("@dsEmail2", SqlDbType.Char, 50).Value = IIf(String.IsNullOrEmpty(objCliente.dsEmail2), DBNull.Value, objCliente.dsEmail2)
                            cmd.Parameters.Add("@codUsuario", SqlDbType.Char, 5).Value = objCliente.codUsuario
                            cmd.Parameters.Add("@dsEstado", SqlDbType.Char, 1).Value = objCliente.dsEstado

                            cmd.ExecuteNonQuery()

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

    Public Shared Function DeleteCliente(ByVal objCliente As BE_Cliente) As Boolean
        Dim resultado As Boolean = False
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using trx = cn.BeginTransaction
                    Try

                        Using cmd As New SqlCommand("Usp_Concorp_co_ctcoa_DeleteCliente", cn)
                            cmd.CommandType = CommandType.StoredProcedure
                            cmd.Transaction = trx
                            cmd.Parameters.Add("@codCia", SqlDbType.Char, 3).Value = objCliente.codCia
                            cmd.Parameters.Add("@codCliente", SqlDbType.Char, 11).Value = objCliente.codCliente
                            cmd.ExecuteNonQuery()

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

End Class
