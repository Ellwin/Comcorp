Imports System.Web
Imports System.Web.Services
Imports System.Web.SessionState
Imports Linksoft.Framework.Common

Public Class HandlerGenerico
    Implements System.Web.IHttpHandler, IRequiresSessionState

    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest
        Dim metodo = context.Request("Metodo")
        Select Case metodo
            Case "VerificarSesion"
                Me.VerificarSesion(context)
        End Select
    End Sub

    Private Sub VerificarSesion(ByVal context As HttpContext)
        Dim resultado = True
        If context.Session(Constantes.USUARIO_SESION) Is Nothing Then
            resultado = False
        End If
        WebUtil.Serializar(resultado, context)
    End Sub

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

End Class