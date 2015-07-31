Imports System.Web
Imports System.Web.Services
Imports System.Web.SessionState

Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.BusinessLogic
Imports Linksoft.Framework.Common


Public Class HandlerCotizacion
    Implements System.Web.IHttpHandler, IRequiresSessionState

    Sub ProcessRequest(ByVal context As HttpContext) Implements IHttpHandler.ProcessRequest

        Dim Metodo As String = context.Request("Metodo")

        Select Case Metodo
            Case "CargarItemFactura"
                CargarItemFactura(context)
            Case "GetTipoCambio"
                GetTipoCambio(context)
            Case "GetDatosCliente"
                GetDatosCliente(context)
            Case "GetCondicionPago"
                GetCondicionPago(context)
            Case "GetOperacionFacturacion"
                GetOperacionFacturacion(context)
            Case "GetItemFactura"
                GetItemFactura(context)
            Case "GetDatosArticulo"
                GetDatosArticulo(context)
            Case "GetListaPrecioArticulo"
                GetListaPrecioArticulo(context)
        End Select

    End Sub

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

    Private Sub CargarItemFactura(ByVal context As HttpContext)
        Dim codMoneda As String = context.Request("moneda").ToString.Trim
        Dim codVendedor As String = context.Request("vendedor").ToString.Trim
        Dim codAlmacen As String = context.Request("almacen").ToString.Trim
        Dim codListaPrecio As String = context.Request("listaprecio").ToString.Trim

        Dim objItemFactura As New BE_ItemFactura
        Dim objJsonMessage As New JsonMessage

        Dim objSesionLogin As BE_SesionLogin = CType(context.Session(Constantes.USUARIO_SESION), BE_SesionLogin)

        With objItemFactura
            .codMoneda = codMoneda
            .dsMoneda = BL_Moneda.GetMoneda(objSesionLogin.codCia, codMoneda).dsMoneda
            .codAlmacen = codAlmacen
            .dsAlmacen = BL_Almacen.GetAlmacen(objSesionLogin.codCia, codAlmacen).dsAlmacen
            .codVendedor = codVendedor
            .dsVendedor = BL_Vendedor.GetVendedor(objSesionLogin.codCia, codVendedor).dsVendedor
            .codListaPrecio = codListaPrecio
        End With

        objJsonMessage.objeto = objItemFactura
        WebUtil.Serializar(objJsonMessage, context)
    End Sub

    Private Sub GetTipoCambio(ByVal context As HttpContext)
        Dim fecha As String = Format(CDate(context.Request("Fecha")), Constantes.FORMAT_YYYY_MM_DD)

        Dim objTipoCambio As New BE_TipoCambio
        Dim objJsonMessage As New JsonMessage

        Dim objSesionLogin As BE_SesionLogin = CType(context.Session(Constantes.USUARIO_SESION), BE_SesionLogin)

        objTipoCambio = BL_Util.GetTipoCambio(objSesionLogin.codCia, "02", fecha)

        If Not objTipoCambio Is Nothing Then
            objJsonMessage.objeto = objTipoCambio
            objJsonMessage.mensaje = Constantes.RESULT_TYPE_SUCCESS
        End If

        WebUtil.Serializar(objJsonMessage, context)
        
    End Sub


    Private Sub GetDatosCliente(ByVal context As HttpContext)
        Dim codCliente As String = context.Request("codCliente").ToString.Trim

        Dim objCliente As New BE_Cliente
        Dim objJsonMessage As New JsonMessage

        Dim objSesionLogin As BE_SesionLogin = CType(context.Session(Constantes.USUARIO_SESION), BE_SesionLogin)

        objCliente = BL_Cliente.GetDatosCliente(objSesionLogin.codCia, codCliente)

        If Not objCliente Is Nothing Then
            objJsonMessage.objeto = objCliente
            objJsonMessage.mensaje = Constantes.RESULT_TYPE_SUCCESS
        End If

        WebUtil.Serializar(objJsonMessage, context)

    End Sub

    Private Sub GetCondicionPago(ByVal context As HttpContext)
        Dim codCondicionPago As String = context.Request("codCondicionPago").ToString.Trim

        Dim objCondicionPago As New BE_CondicionPago
        Dim objJsonMessage As New JsonMessage

        Dim objSesionLogin As BE_SesionLogin = CType(context.Session(Constantes.USUARIO_SESION), BE_SesionLogin)

        objCondicionPago = BL_CondicionPago.GetCondicionPago(objSesionLogin.codCia, codCondicionPago)

        If Not objCondicionPago Is Nothing Then
            objJsonMessage.objeto = objCondicionPago
            objJsonMessage.mensaje = Constantes.RESULT_TYPE_SUCCESS
        End If

        WebUtil.Serializar(objJsonMessage, context)

    End Sub

    Private Sub GetOperacionFacturacion(ByVal context As HttpContext)
        Dim codOperacionFacturacion As String = context.Request("codOperacionFacturacion").ToString.Trim

        Dim objOperacionFacturacion As New BE_OperacionFacturacion
        Dim objJsonMessage As New JsonMessage

        Dim objSesionLogin As BE_SesionLogin = CType(context.Session(Constantes.USUARIO_SESION), BE_SesionLogin)

        objOperacionFacturacion = BL_OperacionFacturacion.GetOperacionFacturacion(objSesionLogin.codCia, codOperacionFacturacion)

        If Not objOperacionFacturacion Is Nothing Then
            objJsonMessage.objeto = objOperacionFacturacion
            objJsonMessage.mensaje = Constantes.RESULT_TYPE_SUCCESS
        End If

        WebUtil.Serializar(objJsonMessage, context)

    End Sub

    Private Sub GetItemFactura(ByVal context As HttpContext)
        Dim codArticulo As String = context.Request("codArticulo").ToString.Trim
        Dim codAlmacen As String = context.Request("codAlmacen").ToString.Trim

        Dim objItemFactura As New BE_ItemFactura
        Dim objJsonMessage As New JsonMessage

        Dim objSesionLogin As BE_SesionLogin = CType(context.Session(Constantes.USUARIO_SESION), BE_SesionLogin)

        objItemFactura = BL_ItemFactura.GetItemFactura(objSesionLogin.codCia, codArticulo, objSesionLogin.codEjercicio, objSesionLogin.codPeriodo, codAlmacen)

        If Not objItemFactura Is Nothing Then
            objJsonMessage.objeto = objItemFactura
            objJsonMessage.mensaje = Constantes.RESULT_TYPE_SUCCESS
        End If

        WebUtil.Serializar(objJsonMessage, context)

    End Sub

    Private Sub GetDatosArticulo(ByVal context As HttpContext)
        Dim codArticulo As String = context.Request("codArticulo").ToString.Trim
        Dim codAlmacen As String = context.Request("codAlmacen").ToString.Trim

        Dim objItemFactura As New BE_ItemFactura
        Dim objJsonMessage As New JsonMessage

        Dim objSesionLogin As BE_SesionLogin = CType(context.Session(Constantes.USUARIO_SESION), BE_SesionLogin)

        objItemFactura = BL_ItemFactura.GetItemFactura(objSesionLogin.codCia, codArticulo, objSesionLogin.codEjercicio, objSesionLogin.codPeriodo, codAlmacen)

        If Not objItemFactura Is Nothing Then
            objJsonMessage.objeto = objItemFactura
            objJsonMessage.mensaje = Constantes.RESULT_TYPE_SUCCESS
        End If

        WebUtil.Serializar(objJsonMessage, context)

    End Sub


    Private Sub GetListaPrecioArticulo(ByVal context As HttpContext)
        Dim codArticulo As String = context.Request("codArticulo").ToString.Trim
        Dim codListaPrecio As String = context.Request("codListaPrecio").ToString.Trim
        Dim codMoneda As String = context.Request("codMoneda").ToString.Trim

        Dim objItemFactura As New BE_ItemFactura
        Dim objJsonMessage As New JsonMessage

        Dim objSesionLogin As BE_SesionLogin = CType(context.Session(Constantes.USUARIO_SESION), BE_SesionLogin)

        objItemFactura = BL_ItemFactura.GetListaPrecioArticulo(objSesionLogin.codCia, codArticulo, codListaPrecio)

        If Not objItemFactura Is Nothing Then
            objJsonMessage.objeto = objItemFactura

            If codMoneda = Constantes.MONEDA_SOLES Then
                objItemFactura.nuPrecio = objItemFactura.nuPrecioMN
            Else
                objItemFactura.nuPrecio = objItemFactura.nuPrecioME
            End If
            objJsonMessage.mensaje = Constantes.RESULT_TYPE_SUCCESS
        End If

        WebUtil.Serializar(objJsonMessage, context)

    End Sub
End Class