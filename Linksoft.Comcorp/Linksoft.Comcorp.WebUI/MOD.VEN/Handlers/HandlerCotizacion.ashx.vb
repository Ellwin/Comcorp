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
            Case "GetCotizacionDetalle"
                GetCotizacionDetalle(context)
            Case "Guardar"
                Guardar(context)
            Case Else
                ListarCotizacion(context)
        End Select

    End Sub

    ReadOnly Property IsReusable() As Boolean Implements IHttpHandler.IsReusable
        Get
            Return False
        End Get
    End Property

    Private Sub ListarCotizacion(ByVal context As HttpContext)

        Dim lstCotizacion As New List(Of BE_Cotizacion)
        Dim objJsonMessage As New JsonMessage
        Dim objSesionLogin As BE_SesionLogin = CType(context.Session(Constantes.USUARIO_SESION), BE_SesionLogin)

        lstCotizacion = BL_Cotizacion.ListarCotizacion(objSesionLogin.codCia, objSesionLogin.codEjercicio, objSesionLogin.codPeriodo)

        objJsonMessage.data = lstCotizacion

        WebUtil.Serializar(objJsonMessage, context)

    End Sub

    Private Sub GetCotizacionDetalle(ByVal context As HttpContext)
        Dim codCia As String = context.Request("cia").ToString.Trim
        Dim codEjercicio As String = context.Request("ejercicio").ToString.Trim
        Dim codPeriodo As String = context.Request("periodo").ToString.Trim
        Dim dsDoc As String = context.Request("doc").ToString.Trim
        Dim dsDocSerie As String = context.Request("serie").ToString.Trim
        Dim dsDocNro As String = context.Request("nro").ToString.Trim

        Dim lstCotizacionDetalle As New List(Of BE_ItemFactura)
        Dim objJsonMessage As New JsonMessage
        Dim objSesionLogin As BE_SesionLogin = CType(context.Session(Constantes.USUARIO_SESION), BE_SesionLogin)

        lstCotizacionDetalle = BL_Cotizacion.GetCotizacionDetalle(codCia, codEjercicio, codPeriodo, dsDoc, dsDocSerie, dsDocNro)

        objJsonMessage.data = lstCotizacionDetalle

        WebUtil.Serializar(objJsonMessage, context)

    End Sub

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

        objTipoCambio = BL_Util.GetTipoCambio(objSesionLogin.codCia, Constantes.MONEDA_DOLARES, fecha)

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

    Private Sub Guardar(ByVal context As HttpContext)
        Dim vFunciones As New Funciones

        Dim jsonCotizacion = context.Request("Cotizacion")
        Dim deserCotizacion As BE_Cotizacion = WebUtil.Deserializar(Of BE_Cotizacion)(jsonCotizacion, context)


        Dim objSesionLogin As BE_SesionLogin = CType(context.Session(Constantes.USUARIO_SESION), BE_SesionLogin)
        Dim objCotizacion As New BE_Cotizacion

        With objCotizacion
            .codCia = objSesionLogin.codCia
            .codEjercicio = objSesionLogin.codEjercicio
            .codPeriodo = objSesionLogin.codPeriodo
            .dsDoc = deserCotizacion.dsDoc
            .dsDocSerie = deserCotizacion.dsDocSerie
            .codCondPago = deserCotizacion.codCondPago
            .dsTipoTrans = Constantes.TRANS_FACTURACION_DIRECTA
            .dsTipoDoc = "C"
            .feEmision = CDate(deserCotizacion.feEmision)
            .feVencimiento = CDate(deserCotizacion.feVencimiento)
            .codOperFact = deserCotizacion.codOperFact
            .codOperLog = deserCotizacion.codOperLog
            .codZona = deserCotizacion.codZona
            .codAlmacen = deserCotizacion.codAlmacen
            .codSucursal = deserCotizacion.codSucursal
            .codVendedor = deserCotizacion.codVendedor
            .codCobrador = deserCotizacion.codCobrador
            .codCliente = deserCotizacion.codCliente
            .dsCliente = deserCotizacion.dsCliente
            .dsDireccionCliente = deserCotizacion.dsDireccionCliente
            .dsGlosa = deserCotizacion.dsGlosa
            .dsPrioridad = deserCotizacion.dsPrioridad
            .nuTipoCambio = CDbl(deserCotizacion.nuTipoCambio)
            .codMoneda = deserCotizacion.codMoneda
            .codUsuario = objSesionLogin.codUsuario
            .bIndicadorPrn = False
            .dsIndContable = "N"
            .dsIndImpreso = "N"
            .dsEstado = deserCotizacion.dsEstado

            Dim objCotizacionDetalle As BE_CotizacionDetalle
            Dim idItem As Integer = 0

            .lstCotizacionDetalle = New List(Of BE_CotizacionDetalle)

            For Each item In deserCotizacion.lstCotizacionDetalle
                idItem += 1
                objCotizacionDetalle = New BE_CotizacionDetalle

                objCotizacionDetalle.codCia = .codCia
                objCotizacionDetalle.dsDoc = .dsDoc
                objCotizacionDetalle.dsDocSerie = .dsDocSerie
                objCotizacionDetalle.codEjercicio = .codEjercicio
                objCotizacionDetalle.codPeriodo = .codPeriodo
                objCotizacionDetalle.dsTipoTrans = .dsTipoTrans
                objCotizacionDetalle.dsTipoDoc = .dsTipoDoc
                objCotizacionDetalle.dsIdItem = idItem
                objCotizacionDetalle.codArticulo = item.codArticulo
                objCotizacionDetalle.dsArticulo = item.dsArticulo
                objCotizacionDetalle.dsTipoItem = item.dsTipoItem
                objCotizacionDetalle.codLinea = item.codLinea
                objCotizacionDetalle.codSubLinea = item.codSubLinea
                objCotizacionDetalle.nuCantidad = CDbl(item.nuCantidad)
                objCotizacionDetalle.codMoneda = .codMoneda
                objCotizacionDetalle.codMonedaListaPrecio = Constantes.MONEDA_SOLES
                objCotizacionDetalle.nuTipoCambio = CDbl(.nuTipoCambio)
                objCotizacionDetalle.codCliente = .codCliente
                objCotizacionDetalle.codVendedor = .codVendedor
                objCotizacionDetalle.codAlmacen = .codAlmacen
                objCotizacionDetalle.codOperLog = .codOperLog
                objCotizacionDetalle.codOperFact = .codOperFact
                objCotizacionDetalle.codUnidadMedidaAlmacen = item.codUnidadMedidaAlmacen
                objCotizacionDetalle.codZona = .codZona
                objCotizacionDetalle.codSucursal = .codSucursal
                objCotizacionDetalle.feEmision = CDate(.feEmision)
                objCotizacionDetalle.bIva = item.bIva
                objCotizacionDetalle.bSerie = 0
                objCotizacionDetalle.bLote = 0
                objCotizacionDetalle.bAfectoPercepcion = 1
                objCotizacionDetalle.codCondPago = .codCondPago
                objCotizacionDetalle.codListaPrecio = item.codListaPrecio
                objCotizacionDetalle.codUsuario = objSesionLogin.codUsuario
                objCotizacionDetalle.dsEstado = .dsEstado

                If .codMoneda = Constantes.MONEDA_SOLES Then

                    objCotizacionDetalle.nuPrecioMN = item.nuPrecio
                    objCotizacionDetalle.nuPrecioME = Val(item.nuPrecio) / Val(.nuTipoCambio)

                    objCotizacionDetalle.nuBrutoMN = vFunciones.Redondear(Val(item.nuCantidad) * Val(item.nuPrecio), 2)
                    objCotizacionDetalle.nuBrutoME = vFunciones.Redondear(Val(objCotizacionDetalle.nuBrutoMN) / Val(.nuTipoCambio), 2)

                    objCotizacionDetalle.nuNetoMN = vFunciones.Redondear(Val(item.nuCantidad) * Val(item.nuPrecio), 2)
                    objCotizacionDetalle.nuNetoME = vFunciones.Redondear(Val(objCotizacionDetalle.nuNetoMN) / Val(.nuTipoCambio), 2)

                    objCotizacionDetalle.nuImpuestoMN = vFunciones.Redondear(Val(objCotizacionDetalle.nuNetoMN) * (Val(item.nuTasaImpuesto) / 100), 2)
                    objCotizacionDetalle.nuImpuestoME = vFunciones.Redondear(Val(objCotizacionDetalle.nuImpuestoMN) / Val(.nuTipoCambio), 2)

                    objCotizacionDetalle.nuTotalMN = vFunciones.Redondear(Val(objCotizacionDetalle.nuNetoMN) + Val(objCotizacionDetalle.nuImpuestoMN), 2)
                    objCotizacionDetalle.nuTotalME = vFunciones.Redondear(Val(objCotizacionDetalle.nuTotalMN) / Val(.nuTipoCambio), 2)

                ElseIf .codMoneda = Constantes.MONEDA_DOLARES Then

                    objCotizacionDetalle.nuPrecioME = item.nuPrecio
                    objCotizacionDetalle.nuPrecioMN = Val(item.nuPrecio) * Val(.nuTipoCambio)

                    objCotizacionDetalle.nuBrutoME = vFunciones.Redondear(Val(item.nuCantidad) * Val(item.nuPrecio), 2)
                    objCotizacionDetalle.nuBrutoMN = vFunciones.Redondear(Val(objCotizacionDetalle.nuBrutoME) * Val(.nuTipoCambio), 2)

                    objCotizacionDetalle.nuNetoME = vFunciones.Redondear(Val(item.nuCantidad) * Val(item.nuPrecio), 2)
                    objCotizacionDetalle.nuNetoMN = vFunciones.Redondear(Val(objCotizacionDetalle.nuNetoME) * Val(.nuTipoCambio), 2)

                    objCotizacionDetalle.nuImpuestoME = vFunciones.Redondear(Val(objCotizacionDetalle.nuNetoME) * (Val(item.nuTasaImpuesto) / 100), 2)
                    objCotizacionDetalle.nuImpuestoMN = vFunciones.Redondear(Val(objCotizacionDetalle.nuImpuestoME) * Val(.nuTipoCambio), 2)

                    objCotizacionDetalle.nuTotalME = vFunciones.Redondear(Val(objCotizacionDetalle.nuNetoME) + Val(objCotizacionDetalle.nuImpuestoME), 2)
                    objCotizacionDetalle.nuTotalMN = vFunciones.Redondear(Val(objCotizacionDetalle.nuTotalME) * Val(.nuTipoCambio), 2)

                Else
                    'Otra Moneda
                End If


                .lstCotizacionDetalle.Add(objCotizacionDetalle)
            Next

            .nuBrutoMN = vFunciones.Redondear(.lstCotizacionDetalle.Sum(Function(x) x.nuBrutoMN), 2)
            .nuBrutoME = vFunciones.Redondear(.lstCotizacionDetalle.Sum(Function(x) x.nuBrutoME), 2)

            .nuNetoMN = vFunciones.Redondear(.lstCotizacionDetalle.Sum(Function(x) x.nuNetoMN), 2)
            .nuNetoME = vFunciones.Redondear(.lstCotizacionDetalle.Sum(Function(x) x.nuNetoME), 2)

            .nuImpuestoMN = vFunciones.Redondear(.lstCotizacionDetalle.Sum(Function(x) x.nuImpuestoMN), 2)
            .nuImpuestoME = vFunciones.Redondear(.lstCotizacionDetalle.Sum(Function(x) x.nuImpuestoME), 2)

            .nuTotalMN = vFunciones.Redondear(.lstCotizacionDetalle.Sum(Function(x) x.nuTotalMN), 2)
            .nuTotalME = vFunciones.Redondear(.lstCotizacionDetalle.Sum(Function(x) x.nuTotalME), 2)


        End With

        Dim objJsonMessage As New JsonMessage

        If BL_Cotizacion.InsertCotizacion(objCotizacion) Then
            objJsonMessage.mensaje = Constantes.RESULT_TYPE_SUCCESS
        Else
            objJsonMessage.mensaje = Constantes.RESULT_TYPE_ERROR
        End If

        WebUtil.Serializar(objJsonMessage, context)
    End Sub

End Class