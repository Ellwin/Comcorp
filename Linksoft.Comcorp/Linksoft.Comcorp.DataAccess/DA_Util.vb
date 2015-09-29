Imports System.Data.SqlClient
Imports Linksoft.Comcorp.BusinessEntities

Public Class DA_Util
    Inherits DA_BaseClass

    Private Shared m_oConnection As SqlConnection

    ''' <summary>
    ''' Abre la conexion segun la cadena de conexión especificada.
    ''' </summary>
    ''' <param name="Connect"></param>
    ''' <returns><c>Booleano.</c> Devuelve <c>True</c> si la conexión es aperturada correctamente, en caso contrario devuelve <c>False</c>.</returns>
    ''' <remarks>Tomar en cuenta que este metodo cierra la conexión, luego reinicializa la variable y finalmente la vuelve a abrir 
    ''' con la cadena de conexión especificada.</remarks>
    Public Function OpenConnection(ByVal Connect As String) As Boolean
        Dim lErrNo As Integer
        Dim sErrDesc As String

        'assume failure
        OpenConnection = False

        'enable error handler
        On Error GoTo ErrorHandler

        'establish the transaction if DSN specified
        If Connect <> vbNullString Then
            'CloseConnection()
            m_oConnection = New SqlConnection(Connect)
            m_oConnection.Open()
            'pone formato de fecha y hora
            'm_oConnection.Execute scSETDATE, , adExecuteNoRecords
        End If

        'we're out of here
        OpenConnection = True
        Exit Function
        'if we're here there then's been an error so process
ErrorHandler:

        'store incoming values and raise error
        lErrNo = Err.Number
        sErrDesc = Err.Description
        On Error GoTo 0
        OpenConnection = False
        Exit Function

    End Function


    ''' <summary>
    ''' Cierra la conexion al origen de datos.
    ''' </summary>
    ''' <returns>Siempre devuelve <c>False</c></returns>
    ''' <remarks></remarks>
    Public Function CloseConnection() As Boolean
        If Not m_oConnection Is Nothing Then
            m_oConnection.Close()
            'UPGRADE_NOTE: Object m_oConnection may not be destroyed until it is garbage collected. Click for more: 'ms-help://MS.VSCC/commoner/redir/redirect.htm?keyword="vbup1029"'
            m_oConnection = Nothing
        End If
        Return CloseConnection()
    End Function

    ''' <summary>
    ''' Ejecuta una instrucción SQL y asigna el resultado de la consulta a la cadena enviada como segundo parametro.
    ''' </summary>
    ''' <param name="vSQLQuery"></param>
    ''' <param name="vTextASoc"></param>
    ''' <param name="vMostrarMsgError"></param>
    ''' <returns><c>Booleano.</c> Devuelve <c>True</c> si la instrucción es ejecutada correctamente, en caso contrario devuelve <c>False</c>.</returns>
    ''' <remarks></remarks>
    Public Function GetDataScalar(ByVal vSQLQuery As String, ByRef vTextASoc As String, Optional ByVal vMostrarMsgError As Boolean = True) As Boolean

        Dim oConn As New SqlConnection(ConnectionStringSQLServer)
        Dim Cm As New SqlCommand

        'assume failure
        GetDataScalar = False

        Try
            oConn.Open()
            With Cm
                .Connection = oConn
                .CommandType = CommandType.Text
                .CommandText = vSQLQuery
                .CommandTimeout = 300 '5 min
            End With
            vTextASoc = Cm.ExecuteScalar.ToString.Trim
            GetDataScalar = True
        Catch ex As Exception
            GetDataScalar = False
        Finally
            oConn.Close()
            oConn = Nothing : Cm = Nothing
        End Try

    End Function



    ''' <summary>
    ''' Ejecuta una instrucción SQL y asigna el resultado de la consulta a un nuevo <c>DataTable</c> dentro del <c>DataSet</c> enviado como segundo parametro.
    ''' Este metodo toma la conexion SQL que el Sistema DatCorp utiliza como predeterminada.
    ''' </summary>
    ''' <param name="SQLQuery"></param>
    ''' <param name="DS"></param>
    ''' <param name="NomTabla"></param>
    ''' <param name="vMostrarMsgError"></param>
    ''' <returns><c>Booleano.</c> Devuelve <c>True</c> si la instrucción es ejecutada correctamente, en caso contrario devuelve <c>False</c>.</returns>
    ''' <remarks></remarks>
    Public Function GetDataSet(ByVal SQLQuery As String, ByRef DS As DataSet, Optional ByVal NomTabla As String = "Table", Optional ByVal vMostrarMsgError As Boolean = True) As Boolean
        Dim oConn As SqlConnection
        Dim lErrNo As Integer
        Dim sErrDesc As String

        'assume failure
        GetDataSet = False

        'enable error handler
        On Error GoTo ErrorHandler

        If m_oConnection Is Nothing Then
            If Not OpenConnection(ConnectionStringSQLServer) Then
                Exit Function
            End If
        End If
        oConn = m_oConnection
        If DS Is Nothing Then
            DS = New DataSet
        End If

        Dim cmd As New SqlCommand
        cmd.Connection = oConn
        cmd.CommandType = CommandType.Text
        cmd.CommandText = SQLQuery
        cmd.CommandTimeout = 300 '5 min

        With New SqlDataAdapter(cmd.CommandText, oConn)
            .Fill(DS, NomTabla)
        End With

        oConn = Nothing
        cmd = Nothing

        GetDataSet = True
        Exit Function

        'if we're here there then's been an error so process
ErrorHandler:
        GetDataSet = False
    End Function



    Public Shared Function GetPeriodoActual(ByVal codCia As String, ByVal dsFecha As String) As BE_Periodo
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("SP_PERIODOACTUAL", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@ccod_cia", SqlDbType.VarChar).Value = codCia
                    cmd.Parameters.Add("@cfecha", SqlDbType.VarChar).Value = dsFecha

                    cmd.Parameters.Add("@cresulperiodo", SqlDbType.VarChar, 6).Direction = ParameterDirection.Output
                    cmd.Parameters.Add("@cresulejercicio", SqlDbType.VarChar, 6).Direction = ParameterDirection.Output

                    cmd.ExecuteNonQuery()

                    Dim objPeriodo As New BE_Periodo
                    objPeriodo.codEjercicio = cmd.Parameters("@cresulejercicio").Value.ToString.Trim
                    objPeriodo.codPeriodo = cmd.Parameters("@cresulperiodo").Value.ToString.Trim

                    Return objPeriodo
                End Using
            End Using
        Catch ex As Exception
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
    End Function

    Public Shared Function GetTipoCambio(ByVal codCia As String, ByVal codMoneda As String, ByVal dsFecha As String) As BE_TipoCambio
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("Usp_Concorp_Util_GetTipoCambio", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@codCia", SqlDbType.VarChar).Value = codCia
                    cmd.Parameters.Add("@codMoneda", SqlDbType.VarChar).Value = codMoneda
                    cmd.Parameters.Add("@dsFecha", SqlDbType.VarChar).Value = dsFecha
                    Using lector As SqlDataReader = cmd.ExecuteReader
                        Dim lstTipoCambio As New List(Of BE_TipoCambio)
                        Dim objTipoCambio As BE_TipoCambio
                        While lector.Read()
                            objTipoCambio = New BE_TipoCambio
                            With objTipoCambio
                                .codCia = Convert.ToString(lector.Item("codCia"))
                                .codMoneda = Convert.ToString(lector.Item("codMoneda"))
                                .feTipoCambio = Convert.ToDateTime(lector.Item("feTipoCambio"))
                                .nuTipoCambioCompra = Convert.ToDouble(lector.Item("nuTipoCambioCompra"))
                                .nuTipoCambioVenta = Convert.ToDouble(lector.Item("nuTipoCambioVenta"))
                                .dsEstado = Convert.ToString(lector.Item("dsEstado"))
                            End With
                            lstTipoCambio.Add(objTipoCambio)
                        End While
                        lector.Close()
                        Return lstTipoCambio.FirstOrDefault
                    End Using
                End Using
            End Using
        Catch ex As Exception
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
    End Function

    Public Shared Function Valores_Predeterminados(ByVal codCia As String, ByVal codUsuario As String, ByVal vModulo As String, ByVal vCodAtributo As String, ByVal vWhereCampoBd As String, Optional ByVal bTraerElValorDefault As Boolean = False) As String
        Valores_Predeterminados = " 1=1 "

        Dim vSql As String = ""

        If bTraerElValorDefault = False Then
            vSql = "SELECT '''' + replace(rtrim(cval_1_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_2_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_3_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_4_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_5_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_6_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_7_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_8_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_9_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_10_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_11_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_12_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_13_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_14_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_15_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_16_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_17_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_18_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_19_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_20_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_21_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_22_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_23_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_24_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_25_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_26_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_27_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_28_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_29_a),'.','') + ''',' + "
            vSql &= "	'''' + replace(rtrim(cval_30_a),'.','') + ''''  as Valores, "

            'vSql &= "	'''' + replace(rtrim(cval_10_a),'.','') + ''''  as Valores, "
            vSql &= "	replace(rtrim(cval_1_a),'.','') Valor1 "
            vSql &= "FROM ad_atrib_p "
            vSql &= "where ccod_atri = '" & vCodAtributo & "' "
            vSql &= "	and ccod_mod = '" & vModulo & "' "
            vSql &= "	and ccod_cia = '" & Trim(codCia) & "' "
            vSql &= "	and ccod_usu = '" & Trim(codUsuario) & "' "

            Dim Ds As New DataSet
            Dim DA_Util As New DA_Util
            If Not DA_Util.GetDataSet(vSql, Ds) Then Exit Function

            If Ds.Tables(0).Rows.Count > 0 Then
                If Ds.Tables(0).Rows(0).Item("Valor1").ToString.Trim <> "" Then
                    Return vWhereCampoBd & " in (" & Ds.Tables(0).Rows(0).Item("Valores").ToString.Trim & ")"
                End If
            End If
        Else
            Valores_Predeterminados = ""

            vSql = "SELECT cval "
            vSql &= "FROM Valores_Predefinidos "
            vSql &= "where ccod_atri = '" & vCodAtributo & "' "
            vSql &= "	and ccod_mod = '" & vModulo & "' "
            vSql &= "	and ccod_cia = '" & Trim(codCia) & "' "
            vSql &= "	and ccod_usu = '" & Trim(codUsuario) & "' "
            vSql &= "	and bval = 1 "

            Dim Ds As New DataSet
            Dim DA_Util As New DA_Util

            If Not DA_Util.GetDataSet(vSql, Ds) Then Exit Function

            If Ds.Tables(0).Rows.Count > 0 Then
                If Ds.Tables(0).Rows(0).Item("cval").ToString.Trim <> "" Then
                    'Return vWhereCampoBd & " in ('" & Ds.Tables(0).Rows(0).Item("cval").ToString.Trim & "') "
                    Return Ds.Tables(0).Rows(0).Item("cval").ToString.Trim
                End If
                'Else
                '    MessageBox.Show("No se establecio Valor Predeterminado para el Atributo " & vCodAtributo, Dal.Cons.D_titulo, MessageBoxButtons.OK, MessageBoxIcon.Exclamation)
            End If
        End If
    End Function

    Public Shared Function Ver_Atributo(ByVal codUsuario As String, ByVal vModulo As String, ByVal vCodAtributo As String) As String
        Ver_Atributo = ""

        Dim vsql As String = "select cval_1_a from AD_ATRIB "
        vsql = vsql & "where ccod_mod = '" & vModulo & "' "
        vsql = vsql & "and ccod_usu = '" & Trim(codUsuario) & "' "
        vsql = vsql & "and ccod_atri = '" & vCodAtributo & "' "
        Dim ds As New DataSet
        Dim DA_Util As New DA_Util
        If Not DA_Util.GetDataSet(vsql, ds, "Table") Then
            Exit Function
        End If
        If ds.Tables("Table").Rows.Count > 0 Then
            Ver_Atributo = ds.Tables("Table").Rows(0)("cval_1_a").ToString.Trim
        End If

        Return Ver_Atributo
    End Function

End Class
