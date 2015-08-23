Imports System.Web
Imports System.Web.Services
Imports System.Web.SessionState

Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.BusinessLogic
Imports Linksoft.Framework.Common

Public Class HandlerCliente
    Implements System.Web.IHttpHandler, IRequiresSessionState

    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest

        Dim Metodo As String = context.Request("Metodo")

        Select Case Metodo
            Case "Guardar"
                Guardar(context)
            Case Else
                ListarCliente(context)
        End Select

    End Sub

    Private Sub ListarCliente(ByVal context As HttpContext)

        Dim lstCliente As New List(Of BE_Cliente)
        Dim objJsonMessage As New JsonMessage
        Dim objSesionLogin As BE_SesionLogin = CType(context.Session(Constantes.USUARIO_SESION), BE_SesionLogin)

        lstCliente = BL_Cliente.ListarCliente(objSesionLogin.codCia)

        objJsonMessage.data = lstCliente

        WebUtil.Serializar(objJsonMessage, context)

    End Sub
    Private Sub Guardar(ByVal context As HttpContext)
        Dim objJsonMessage As New JsonMessage

        Try
            Dim jsonCliente = context.Request("Cliente")
            Dim deserCliente As BE_Cliente = WebUtil.Deserializar(Of BE_Cliente)(jsonCliente, context)
            Dim objSesionLogin As BE_SesionLogin = CType(context.Session(Constantes.USUARIO_SESION), BE_SesionLogin)
            Dim objCliente As New BE_Cliente

            objCliente = deserCliente
            objCliente.codCia = objSesionLogin.codCia
            objCliente.codUsuario = objSesionLogin.codUsuario



            Select Case objCliente.Accion
                Case Constantes.ACCION_NUEVO
                    If BL_Cliente.InsertCliente(objCliente) Then
                        objJsonMessage.mensaje = Constantes.RESULT_TYPE_SUCCESS
                    Else
                        objJsonMessage.mensaje = Constantes.RESULT_TYPE_ERROR
                    End If

                Case Constantes.ACCION_EDITAR
                    If BL_Cliente.UpdateCliente(objCliente) Then
                        objJsonMessage.mensaje = Constantes.RESULT_TYPE_SUCCESS
                    Else
                        objJsonMessage.mensaje = Constantes.RESULT_TYPE_ERROR
                    End If

                Case Constantes.ACCION_ELIMINAR
                    If BL_Cliente.DeleteCliente(objCliente) Then
                        objJsonMessage.mensaje = Constantes.RESULT_TYPE_SUCCESS
                    Else
                        objJsonMessage.mensaje = Constantes.RESULT_TYPE_ERROR
                    End If
            End Select

            WebUtil.Serializar(objJsonMessage, context)
        Catch ex As Exception
            objJsonMessage.mensaje = Constantes.RESULT_TYPE_ERROR
        End Try
        

    End Sub

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class