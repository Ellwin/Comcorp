Public Class Constantes
#Region "Constantes de Sesion"

    Public Const USUARIO_SESION As String = "USUARIO_SESION"

#End Region

#Region "Alertas Bootstrap"

    Public Const ALERT_SUCCESS As String = "alert-success"
    Public Const ALERT_INFO As String = "alert-info"
    Public Const ALERT_WARNING As String = "alert-warning"
    Public Const ALERT_DANGER As String = "alert-danger"

#End Region

#Region "Errores de BD"
    Public Const ERROR_BD_PRIMARY_KEY As String = "El código ya existe en la base de datos."
    Public Const ERROR_BD_CONSTRAINT As String = "Error de constraint de base de datos."
#End Region

#Region "ResultType"

    Public Const RESULT_TYPE_ERROR As String = "ERROR"
    Public Const ERROR_DEFAULT_MESSAGE As String = "Ha ocurrido un error, consulte con el Administrador del Sistema."
    Public Const RESULT_TYPE_SUCCESS As String = "SUCCESS"
    Public Const SUCCESS_DEFAULT_MESSAGE As String = "Se guardaron los cambios correctamente."

#End Region

#Region "Formatos de Fecha"
    Public Const FORMAT_YYYY_MM_DD As String = "yyyy-MM-dd"
    Public Const FORMAT_DD_MM_YYYY As String = "dd-MM-yyyy"
#End Region

#Region "Moneda"
    Public Const MONEDA_SOLES As String = "01"
    Public Const MONEDA_DOLARES As String = "02"
#End Region

#Region "Modulos"

    Public Const DATCONTA As String = "001"
    Public Const DATINVEN As String = "002"
    Public Const DATFACTU As String = "003"
    Public Const DATCOMPR As String = "004"
    Public Const DATTESOR As String = "005"
    Public Const DATCTCOB As String = "006"
    Public Const DATCTPAG As String = "007"
    Public Const DATIMPOR As String = "008"
    Public Const DATPRESU As String = "009"
    Public Const DATAFIJO As String = "010"
    Public Const DATPLANI As String = "011"
    Public Const DATSERV As String = "012"
    Public Const DATCMR As String = "013"
    Public Const DATEJECU As String = "014"
    Public Const DATDISTR As String = "016"
    Public Const POS As String = "019"
    Public Const DATADMIN As String = "020"
    Public Const DATPROD As String = "021"

#End Region

#Region "Tipos de Transaccion Facturacion"
    Public Const TRANS_FACTURACION_DIRECTA = "001"

#End Region

#Region "Acciones de Transaccion"
    Public Const ACCION_NUEVO = "add"
    Public Const ACCION_EDITAR = "edit"
    Public Const ACCION_ELIMINAR = "del"
#End Region
    
End Class
