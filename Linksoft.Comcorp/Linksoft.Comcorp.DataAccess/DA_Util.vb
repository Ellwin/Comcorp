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
            CloseConnection()
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



    Public Shared Function GetPeriodoActual(ByVal strCia As String, ByVal strFecha As String) As BE_Periodo
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("SP_PERIODOACTUAL", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@ccod_cia", SqlDbType.VarChar).Value = strCia
                    cmd.Parameters.Add("@cfecha", SqlDbType.VarChar).Value = strFecha

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

End Class
