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

#Region "Tipos de Transaccion Facturacion"
    Public Const TRANS_FACTURACION_DIRECTA = "001"

#End Region
    
End Class
