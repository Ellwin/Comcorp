<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Cotizacion.aspx.vb" Inherits="Linksoft.Comcorp.WebUI.Cotizacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        th, td { white-space: nowrap; }
        div.dataTables_wrapper {
            width: 100%;
            margin: 0 auto;
            font-size: 12px;
        }
    </style>
    <script type="text/javascript">
        var cotizacionURL = 'Handlers/HandlerCotizacion.ashx';
        var tablaCotizacion;
        $(function () {
            linksoft.util.configDatepickerEs();

            linksoft.util.setToolbar('regCotizacion', function () {
                habilitarControles();
            });

            $('#txtFechaEmision').datepicker();
            $('#txtFechaVencimiento').datepicker();

            getTipoCambio();

            $('a[href="#tabMain"]').tab('show');

            linksoft.util.importes('txtTipoCambio');

            tablaCotizacion = $('#tablaCotizacionDetalle').DataTable({
                "scrollY": 200,
                "scrollX": true,
                "paging": false,
                "ordering": false,
                "jQueryUI": true,
                "columns": [
                            { "data": "codAlmacen" },
                            { "data": "codArticulo" },
                            { "data": "dsArticulo" },
                            { "data": "codUnidadMedidaAlmacen" },
                            { "data": "codVendedor" },
                            { "data": "nuSaldo", "className": "text-right" },
                            { "data": "nuPrecio", "className": "text-right" },
                            { "data": "nuCantidad", "className": "text-right" },
                            { "data": "nuBruto", "className": "text-right" },
                            { "data": "nuNeto", "className": "text-right" },
                            { "data": "nuImpuesto", "className": "text-right" },
                            { "data": "nuTotal", "className": "text-right" },
                            { "data": "dsTipoItem", "className": "text-center" },
                            { "data": "codLinea" },
                            { "data": "dsLinea" },
                            { "data": "codSubLinea" },
                            { "data": "dsSubLinea" },
                            { "data": "bIva", "visible": false },
                            { "data": "nuTasaImpuesto", "visible": false }
                          ]
            });

            $('#tablaCotizacionDetalle tbody').on('click', 'tr', function () {
                if ($(this).hasClass('selected')) {
                    $(this).removeClass('selected');
                }
                else {
                    tablaCotizacion.$('tr.selected').removeClass('selected');
                    $(this).addClass('selected');
                }
            });

            $('#btnEliminarItem').click(function () {
                $('#tablaCotizacionDetalle').DataTable().row('.selected').remove().draw(false);

                calcularTotales();
            });

            Busqueda();


            $("#btnGuardar").on('click', function () {

                var alert_type = 'alert-danger'

                if ($('#txtDoc').val() == '') {
                    linksoft.util.alert('Ingrese documento.');
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtDoc').focus();
                    return false;
                }

                if ($('#txtSerie').val() == '') {
                    linksoft.util.alert('Ingrese serie.');
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtSerie').focus();
                    return false;
                }

                if ($('#txtCodAlmacen').val() == '') {
                    linksoft.util.alert('Ingrese almacén.');
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtAlmacen').focus();
                    return false;
                }

                if ($('#txtCodCliente').val() == '') {
                    linksoft.util.alert('Ingrese cliente.', alert_type);
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtCliente').focus();
                    return false;
                }

                if ($('#txtCodOperFact').val() == '') {
                    linksoft.util.alert('Ingrese operación de facturación.', alert_type);
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtOperFact').focus();
                    return false;
                }

                if ($('#txtTipoCambio').val() == '') {
                    linksoft.util.alert('Ingrese tipo de cambio.', alert_type);
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtTipoCambio').focus();
                    return false;
                }

                if ($('#txtCodVendedor').val() == '') {
                    linksoft.util.alert('Ingrese vendedor.', alert_type);
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtVendedor').focus();
                    return false;
                }

                if ($('#txtCodCondPago').val() == '') {
                    linksoft.util.alert('Ingrese condición de pago.', alert_type);
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtCondPago').focus();
                    return false;
                }

                if ($('#txtCodZona').val() == '') {
                    linksoft.util.alert('Ingrese zona.', alert_type);
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtZona').focus();
                    return false;
                }

                if ($('#tablaCotizacionDetalle').DataTable().data().length == 0) {
                    linksoft.util.alert('No existe detalle de cotización.', alert_type);
                    $('a[href="#tabDetalle"]').tab('show');
                    $('#btnAgregarItem').focus();
                    return false;
                }

                linksoft.util.openModalConfirmacion('¿Está seguro(a) de guardar la cotización?', function () {
                    Guardar();
                });

                return false;
            });

        });

        function Guardar() {
            var objCotizacion = {};

            objCotizacion.dsDoc = $('#txtDoc').val();
            objCotizacion.dsDocSerie = $('#txtSerie').val();
            objCotizacion.codCondPago = $('#txtCodCondPago').val();
            objCotizacion.feEmision = $('#txtFechaEmision').val();
            objCotizacion.feVencimiento = $('#txtFechaVencimiento').val();
            objCotizacion.codOperFact = $('#txtCodOperFact').val();
            objCotizacion.codOperLog = $('#txtCodOperLog').val();
            objCotizacion.codZona = $('#txtCodZona').val();
            objCotizacion.codAlmacen = $('#txtCodAlmacen').val();
            objCotizacion.codSucursal = $('#txtCodUnidadOperativa').val();
            objCotizacion.codVendedor = $('#txtCodVendedor').val();
            objCotizacion.codCobrador = $('#txtCodCobrador').val();
            objCotizacion.codCliente = $('#txtCodCliente').val();
            objCotizacion.dsCliente = $('#txtCliente').val();
            objCotizacion.dsDireccionCliente = $('#txtDireccion').val();
            objCotizacion.dsGlosa = $('#txtGlosa').val();
            objCotizacion.dsPrioridad = $('#ddlPrioridad').val();
            objCotizacion.nuTipoCambio = $('#txtTipoCambio').val();
            objCotizacion.codMoneda = $('#txtCodMoneda').val();
            objCotizacion.nuBruto = $('#txtBruto').val();
            objCotizacion.nuNeto = $('#txtNeto').val();
            objCotizacion.nuImpuesto = $('#txtImpuesto').val();
            objCotizacion.nuTotal = $('#txtTotal').val();
            objCotizacion.dsEstado = $('#ddlEstado').val();
            objCotizacion.Accion = Accion;

            objCotizacion.lstCotizacionDetalle = [];

            var table = $('#tablaCotizacionDetalle').DataTable();

            table.rows().every(function () {
                var d = this.data();
                objCotizacion.lstCotizacionDetalle.push(d);
            });


            var cotizacionParam = {
                Metodo: 'Guardar',
                Cotizacion: JSON.stringify(objCotizacion)
            };


            linksoft.util.ajaxCallback(cotizacionURL, cotizacionParam, function (response) {
                
            });
        }

        function habilitarControles() {
            if (Accion == 'add') {
                $("#txtDoc").attr('readonly', true);
                $("#txtSerie").attr('readonly', true);
                $("#txtNumero").attr('readonly', true);
                $("#txtAlmacen").attr('readonly', true);
                $("#txtCliente").attr('readonly', true);
                $("#txtOperFact").attr('readonly', true);
                $("#txtMoneda").attr('readonly', true);
                $("#txtVendedor").attr('readonly', true);
                $("#txtCondPago").attr('readonly', true);
                $("#txtTipoCondPago").attr('readonly', true);
                $("#txtUnidadOperativa").attr('readonly', true);
                $("#txtZona").attr('readonly', true);
                $("#txtCobrador").attr('readonly', true);

                var fecha = $('#lblFecha').html();
                $("#txtFechaEmision").val(fecha);
                $("#txtFechaVencimiento").val(fecha);
            }
            
        }

        function cargarItemNumerador(doc, serie) {
            $("#txtDoc").val(doc);
            $("#txtSerie").val(serie);

            $("#modalBusqueda").dialog("close");
        }

        function cargarItem(busqueda, codigo, descripcion) {
            switch (busqueda) {
                case "ALMACEN":
                    $("#txtCodAlmacen").val(codigo);
                    $("#txtAlmacen").val(descripcion);
                    break;
                case "CLIENTE":
                    $("#txtCodCliente").val(codigo);
                    $("#txtCliente").val(descripcion);

                    getDatosCliente(codigo);

                    break;
                case "VENDEDOR":
                    $("#txtCodVendedor").val(codigo);
                    $("#txtVendedor").val(descripcion);
                    break;
                case "OPERFACT":
                    $("#txtCodOperFact").val(codigo);
                    $("#txtOperFact").val(descripcion);

                    getOperacionFacturacion(codigo)

                    break;
                case "CONDPAGO":
                    $("#txtCodCondPago").val(codigo);
                    $("#txtCondPago").val(descripcion);

                    getCondicionPago(codigo);

                    break;
                case "COBRADOR":
                    $("#txtCodCobrador").val(codigo);
                    $("#txtCobrador").val(descripcion);

                    break;
                case "SUCURSAL":
                    $("#txtCodUnidadOperativa").val(codigo);
                    $("#txtUnidadOperativa").val(descripcion);

                    break;
                case "ZONA":
                    $("#txtCodZona").val(codigo);
                    $("#txtZona").val(descripcion);

                    break;
            }
            $("#modalBusqueda").dialog("close");
        };

        function Busqueda() {

            $('#btnBuscarDoc').click(function () {
                linksoft.util.openModal('modalBusqueda', 'frameBusqueda', '<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>Busqueda/Numerador.aspx?cat=C', 'Listado de Numeradores');
            });

            $('#btnBuscarAlmacen').click(function () {
                linksoft.util.openModal('modalBusqueda', 'frameBusqueda', '<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>Busqueda/Busqueda.aspx?tipo=BUSQUEDA&valor=ALMACEN', 'Busqueda de Almacenes');
            });

            $('#btnBuscarCliente').click(function () {
                linksoft.util.openModal('modalBusqueda', 'frameBusqueda', '<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>Busqueda/Busqueda.aspx?tipo=BUSQUEDA&valor=CLIENTE', 'Busqueda de Cliente');
            });

            $('#btnBuscarOperFact').click(function () {
                linksoft.util.openModal('modalBusqueda', 'frameBusqueda', '<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>Busqueda/Busqueda.aspx?tipo=BUSQUEDA&valor=OPERFACT', 'Busqueda de Operaciones de Venta');
            });

            $('#btnBuscarVendedor').click(function () {
                linksoft.util.openModal('modalBusqueda', 'frameBusqueda', '<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>Busqueda/Busqueda.aspx?tipo=BUSQUEDA&valor=VENDEDOR', 'Busqueda de Vendedor');
            });

            $('#btnBuscarCondPago').click(function () {
                linksoft.util.openModal('modalBusqueda', 'frameBusqueda', '<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>Busqueda/Busqueda.aspx?tipo=BUSQUEDA&valor=CONDPAGO', 'Busqueda de Condición de Pago');
            });

            $('#btnBuscarUnidadOperativa').click(function () {
                linksoft.util.openModal('modalBusqueda', 'frameBusqueda', '<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>Busqueda/Busqueda.aspx?tipo=BUSQUEDA&valor=SUCURSAL', 'Busqueda de Unidad Operativa');
            });

            $('#btnBuscarZona').click(function () {
                linksoft.util.openModal('modalBusqueda', 'frameBusqueda', '<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>Busqueda/Busqueda.aspx?tipo=BUSQUEDA&valor=ZONA', 'Busqueda de Zona');
            });

            $('#btnBuscarCobrador').click(function () {
                linksoft.util.openModal('modalBusqueda', 'frameBusqueda', '<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>Busqueda/Busqueda.aspx?tipo=BUSQUEDA&valor=COBRADOR', 'Busqueda de Cobrador');
            });

            AgregarItem();
        }

        function AgregarItem() {

            $('#btnAgregarItem').click(function () {

                var alert_type = 'alert-danger'

                if ($('#txtCodAlmacen').val() == '') {
                    linksoft.util.alert('Ingrese almacén.');
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtAlmacen').focus();
                    return;
                }

                if ($('#txtCodCliente').val() == '') {
                    linksoft.util.alert('Ingrese cliente.', alert_type);
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtCliente').focus();
                    return;
                }

                if ($('#txtCodOperFact').val() == '') {
                    linksoft.util.alert('Ingrese operación de facturación.', alert_type);
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtOperFact').focus();
                    return;
                }

                if ($('#txtTipoCambio').val() == '') {
                    linksoft.util.alert('Ingrese tipo de cambio.', alert_type);
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtTipoCambio').focus();
                    return;
                }

                if ($('#txtCodVendedor').val() == '') {
                    linksoft.util.alert('Ingrese vendedor.', alert_type);
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtVendedor').focus();
                    return;
                }

                if ($('#txtCodCondPago').val() == '') {
                    linksoft.util.alert('Ingrese condición de pago.', alert_type);
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtCondPago').focus();
                    return;
                }

                if ($('#txtCodZona').val() == '') {
                    linksoft.util.alert('Ingrese zona.', alert_type);
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtZona').focus();
                    return;
                }

                var moneda = $("#txtCodMoneda").val();
                var almacen = $("#txtCodAlmacen").val();
                var vendedor = $("#txtCodVendedor").val();
                var listaprecio = $("#txtCodListaPrecio").val();

                linksoft.util.openModalCustomSize('modalBusqueda', 'frameBusqueda', '<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>MOD.VEN/ItemFactura.aspx?moneda=' + moneda + '&almacen=' + almacen + '&vendedor=' + vendedor+'&listaprecio='+ listaprecio+'', 'Agregar Item', '550', '550');
            });
        }

        function closeModal() {
            
            $("#modalBusqueda").dialog("close");
            
        }

        function getTipoCambio() {

            $("#txtFechaEmision").on('change', function () {

                var tcParam = {
                    Metodo: 'GetTipoCambio',
                    Fecha: $("#txtFechaEmision").val()
                };

                linksoft.util.ajaxCallback(cotizacionURL, tcParam, function (response) {
                    if (response.mensaje == 'SUCCESS') {
                        $("#txtTipoCambio").val(response.objeto.nuTipoCambioVenta);
                    } else {
                        $("#txtTipoCambio").val('');
                    }
                });
            });


        }

        function getDatosCliente(codigo) {
            var clienteParam = {
                Metodo: 'GetDatosCliente',
                codCliente: codigo
            };

            linksoft.util.ajaxCallback(cotizacionURL, clienteParam, function (response) {
                if (response.mensaje == 'SUCCESS') {
                    $("#txtDireccion").val(response.objeto.dsDireccion);
                    $("#txtCodOperFact").val(response.objeto.codOperacionFacturacion);
                    $("#txtOperFact").val(response.objeto.dsOperacionFacturacion);
                    $("#txtCodMoneda").val(response.objeto.codMoneda);
                    $("#txtMoneda").val(response.objeto.dsMoneda);
                    $("#txtCodVendedor").val(response.objeto.codVendedor);
                    $("#txtVendedor").val(response.objeto.dsVendedor);
                    $("#txtCodCondPago").val(response.objeto.codCondicionPago);
                    $("#txtCondPago").val(response.objeto.dsCondicionPago);
                    $("#txtTipoCondPago").val(response.objeto.dsTipoCondicionPago);
                    $("#txtCodListaPrecio").val(response.objeto.codListaPrecio);

                    var $fechaVencimiento = $('#txtFechaEmision').datepicker('getDate');
                    var diasVencimiento = response.objeto.nuDiasVencimiento;
                    $fechaVencimiento.setDate($fechaVencimiento.getDate() + diasVencimiento);
                    $('#txtFechaVencimiento').datepicker().datepicker('setDate', $fechaVencimiento);

                } else {
                    $("#txtDireccion").val('');
                    $("#txtCodOperFact").val('');
                    $("#txtOperFact").val('');
                    $("#txtCodMoneda").val('');
                    $("#txtMoneda").val('');
                    $("#txtCodVendedor").val('');
                    $("#txtVendedor").val('');
                    $("#txtCodCondPago").val('');
                    $("#txtCondPago").val('');
                    $("#txtTipoCondPago").val('');
                    $("#txtCodListaPrecio").val('');
                }
            });
        }


        function getCondicionPago(codigo) {
            var condicionParam = {
                Metodo: 'GetCondicionPago',
                codCondicionPago: codigo
            };

            linksoft.util.ajaxCallback(cotizacionURL, condicionParam, function (response) {
                if (response.mensaje == 'SUCCESS') {
                    $("#txtCodCondPago").val(response.objeto.codCondicionPago);
                    $("#txtCondPago").val(response.objeto.dsCondicionPago);
                    $("#txtTipoCondPago").val(response.objeto.dsTipoCondicionPago);

                    var $fechaVencimiento = $('#txtFechaEmision').datepicker('getDate');
                    var diasVencimiento = response.objeto.nuDiasVencimiento;
                    $fechaVencimiento.setDate($fechaVencimiento.getDate() + diasVencimiento);
                    $('#txtFechaVencimiento').datepicker().datepicker('setDate', $fechaVencimiento);

                } else {
                    $("#txtCodCondPago").val('');
                    $("#txtCondPago").val('');
                    $("#txtTipoCondPago").val('');
                }
            });
        }

        function getOperacionFacturacion(codigo) {
            var operfactParam = {
                Metodo: 'GetOperacionFacturacion',
                codOperacionFacturacion: codigo
            };

            linksoft.util.ajaxCallback(cotizacionURL, operfactParam, function (response) {
                if (response.mensaje == 'SUCCESS') {
                    $("#txtCodOperFact").val(response.objeto.codOperacionFacturacion);
                    $("#txtOperFact").val(response.objeto.dsOperacionFacturacion);
                    $("#txtCodOperLog").val(response.objeto.codOperacionLogistica);
                    $("#txtCodMoneda").val(response.objeto.codMoneda);
                    $("#txtMoneda").val(response.objeto.dsMoneda);

                } else {
                    $("#txtCodOperFact").val('');
                    $("#txtOperFact").val('');
                    $("#txtCodOperLog").val('');
                    $("#txtCodMoneda").val('');
                    $("#txtMoneda").val('');
                }
            });
        }

        function addItemFactura(objItem) {
            var table = $('#tablaCotizacionDetalle').DataTable();
            table.row.add({
                'codAlmacen': objItem.codAlmacen,
                'codArticulo': objItem.codArticulo,
                'dsArticulo': objItem.dsArticulo,
                'codUnidadMedidaAlmacen': objItem.codUnidadMedidaAlmacen,
                'codVendedor': objItem.codVendedor,
                'nuSaldo': objItem.nuSaldo,
                'nuPrecio': objItem.nuPrecio,
                'nuCantidad': objItem.nuCantidad,
                'nuBruto': objItem.nuBruto,
                'nuNeto': objItem.nuNeto,
                'nuImpuesto': objItem.nuImpuesto,
                'nuTotal': objItem.nuTotal,
                'dsTipoItem': objItem.dsTipoItem,
                'codLinea': objItem.codLinea,
                'dsLinea': objItem.dsLinea,
                'codSubLinea': objItem.codSubLinea,
                'dsSubLinea': objItem.dsSubLinea,
                'bIva': objItem.bIva,
                'nuTasaImpuesto': objItem.nuTasaImpuesto
            }).draw();

            table.columns.adjust().draw();

            calcularTotales();
        }

        function calcularTotales() {
            var totalBruto = 0.00, 
                totalNeto = 0.00,
                totalImpuesto = 0.00,
                total = 0.00;

            var table = $('#tablaCotizacionDetalle').DataTable();
            var arrBruto = table.column(8).data();
            var arrNeto = table.column(9).data();
            var arrImpuesto = table.column(10).data();
            var arrTotal = table.column(11).data();

            for (var i = 0; i < arrBruto.length; i++) {
                totalBruto += parseFloat(arrBruto[i]);
            }


            for (var i = 0; i < arrNeto.length; i++) {
                totalNeto += parseFloat(arrNeto[i]);
            }

            for (var i = 0; i < arrImpuesto.length; i++) {
                totalImpuesto += parseFloat(arrImpuesto[i]);
            }

            for (var i = 0; i < arrTotal.length; i++) {
                total += parseFloat(arrTotal[i]);
            }

            $('#txtBruto').val(totalBruto.toFixed(2));
            $('#txtNeto').val(totalNeto.toFixed(2));
            $('#txtImpuesto').val(totalImpuesto.toFixed(2));
            $('#txtTotal').val(total.toFixed(2));
        }
        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="tab-pane" id="tabMain">
        
        <div class="panel panel-primary">
            <div class="panel panel-heading">
                    <h4 class="panel-title">Registro de Cotización</h4>
            </div>
            <div class="panel panel-body" id="regCotizacion">
                <div class="row">
                    <div class="col-xs-4">
                        <label>Documento</label>
                    
                        <div class="input-group"> 
                           <span class="input-group-btn">
                              <button type="button" id="btnBuscarDoc" class="btn btn-info" disabled="disabled"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</button>
                           </span>
                           <input type="text" class="form-control" id="txtDoc" readonly="readonly"/>
                        </div>
                    </div>
                    <div class="col-xs-2">
                        <label>Serie</label>
                        <input type="text" class="form-control input-sm" id="txtSerie" readonly="readonly" required/>
                    </div>
                    <div class="col-xs-2">
                        <label>Número</label>
                        <input type="text" class="form-control input-sm" id="txtNumero" readonly="readonly"/>
                    </div>
                
                    <div class="col-xs-2">
                        <label>Fe. Emisión</label>
                        <input type="text" class="form-control input-sm" id="txtFechaEmision" readonly="readonly"/>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Almacen</label>
                        <div class="input-group"> 
                           <span class="input-group-btn">
                              <button type="button" id="btnBuscarAlmacen" class="btn btn-info" disabled="disabled"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</button>
                           </span>
                           <input type="hidden" class="form-control" id="txtCodAlmacen"/>
                           <input type="text" class="form-control" id="txtAlmacen" readonly="readonly" />
                        </div>
                    </div>
                    <div class="col-xs-2">
                        <label>Fe. Vencimiento</label>
                        <input type="text" class="form-control input-sm" id="txtFechaVencimiento" readonly="readonly"/>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Glosa</label>
                        <input type="text" class="form-control input-sm" id="txtGlosa" readonly="readonly" />
                    </div>
                    <div class="col-xs-2">
                        <label >Estado:</label>
                        <select class="form-control input-sm" id="ddlEstado" disabled="disabled">
                            <option value="P" >Pendiente</option>
                        </select>
                    </div>
                </div>
                <hr />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Cliente</label>
                        <div class="input-group"> 
                           <span class="input-group-btn">
                              <button type="button" id="btnBuscarCliente" class="btn btn-info" disabled="disabled"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</button>
                           </span>
                           <input type="hidden" class="form-control" id="txtCodCliente" />
                           <input type="hidden" class="form-control" id="txtCodListaPrecio" />
                           <input type="text" class="form-control" id="txtCliente" readonly="readonly" />
                        </div>
                    </div>
                    <div class="col-xs-2">
                        <label>Tipo Cambio</label>
                        <input type="text" class="form-control input-sm text-right" id="txtTipoCambio" readonly="readonly"/>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Direccion</label>
                        <input type="text" class="form-control input-sm" id="txtDireccion" readonly="readonly" />
                    </div>
                    <div class="col-xs-2">
                        <label >Prioridad:</label>
                        <select class="form-control input-sm" id="ddlPrioridad" disabled="disabled">
                            <option value="B" >Baja</option>
                        </select>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Oper. Fact.</label>
                        <div class="input-group"> 
                           <span class="input-group-btn">
                              <button type="button" id="btnBuscarOperFact" class="btn btn-info" disabled="disabled"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</button>
                           </span>
                           <input type="hidden" class="form-control" id="txtCodOperFact" />
                           <input type="hidden" class="form-control" id="txtCodOperLog" />
                           <input type="text" class="form-control" id="txtOperFact" readonly="readonly" />
                        </div>
                    </div>
                    <div class="col-xs-2">
                        <label>Moneda.</label>
                        <input type="hidden" class="form-control input-sm" id="txtCodMoneda" />
                        <input type="text" class="form-control input-sm" id="txtMoneda" readonly="readonly"/>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Vendedor</label>
                        <div class="input-group"> 
                           <span class="input-group-btn">
                              <button type="button" id="btnBuscarVendedor" class="btn btn-info" disabled="disabled"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</button>
                           </span>
                           <input type="hidden" class="form-control input-sm" id="txtCodVendedor" />
                           <input type="text" class="form-control" id="txtVendedor" readonly="readonly" />
                        </div>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Condición</label>
                        <div class="input-group"> 
                           <span class="input-group-btn">
                              <button type="button" id="btnBuscarCondPago" class="btn btn-info" disabled="disabled"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</button>
                           </span>
                           <input type="hidden" class="form-control" id="txtCodCondPago" />
                           <input type="text" class="form-control" id="txtCondPago" readonly="readonly" />
                        </div>
                    </div>
                    <div class="col-xs-2">
                        <label>Tipo Cond.</label>
                        <input type="text" class="form-control input-sm" id="txtTipoCondPago" readonly="readonly"/>
                    </div>
                </div>
                <hr />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Unidad Operativa</label>
                        <div class="input-group"> 
                           <span class="input-group-btn">
                              <button type="button" id="btnBuscarUnidadOperativa" class="btn btn-info" disabled="disabled"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</button>
                           </span>
                           <input type="hidden" class="form-control" id="txtCodUnidadOperativa" />
                           <input type="text" class="form-control" id="txtUnidadOperativa" readonly="readonly" />
                        </div>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Zona de Venta</label>
                        <div class="input-group"> 
                           <span class="input-group-btn">
                              <button type="button" id="btnBuscarZona" class="btn btn-info" disabled="disabled"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</button>
                           </span>
                           <input type="hidden" class="form-control" id="txtCodZona" />
                           <input type="text" class="form-control" id="txtZona" readonly="readonly" />
                        </div>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Cobrador</label>
                        <div class="input-group"> 
                           <span class="input-group-btn">
                              <button type="button" id="btnBuscarCobrador" class="btn btn-info" disabled="disabled"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</button>
                           </span>
                           <input type="hidden" class="form-control" id="txtCodCobrador" />
                           <input type="text" class="form-control" id="txtCobrador" readonly="readonly" />
                        </div>
                    </div>
                </div>
                <br />
                        
            </div>
            <div class="panel-footer panel-primary clearfix collapse" id="audit">
                        
                <div class="pull-left">
                    <span id="auditUserCreate" class="h6"></span>
                </div>
                <div class="pull-right">
                    <span id="auditDateCreate" class="h6"></span>
                </div>
                <br />
                <div class="pull-left">
                    <span id="auditUserUpdate" class="h6"></span>
                </div>
                <div class="pull-right">
                    <span id="auditDateUpdate" class="h6"></span>
                </div>
            </div>
        </div>      
                  
    </div>

    <div class="tab-pane" id="tabDetalle">
        <div class="panel panel-primary">
            <div class="panel panel-heading">
                    <h4 class="panel-title">Detalle de Cotización</h4>
            </div>
            <div class="panel panel-body">
                <div class="row">
                    <div class="col-xs-4"> 
                        <br />
                        <button type="button" id="btnAgregarItem" class="btn btn-xs"><span class="glyphicon glyphicon-plus text-success"></span>  Agregar</button>
                        <button type="button" id="btnEliminarItem" class="btn btn-xs"><span class="glyphicon glyphicon-remove text-danger"></span>  Eliminar</button>
                    </div>
                    <div class="col-xs-2">
                        <label>Bruto</label>
                        <input type="text" class="form-control input-sm text-right" id="txtBruto" readonly="readonly"  />
                    </div> 
                    <div class="col-xs-2">
                        <label>Neto</label>
                        <input type="text" class="form-control input-sm text-right" id="txtNeto" readonly="readonly"  />
                    </div> 
                    <div class="col-xs-2">
                        <label>Impuesto</label>
                        <input type="text" class="form-control input-sm text-right" id="txtImpuesto" readonly="readonly" />
                    </div>
                    <div class="col-xs-2">
                        <label>Total</label>
                        <input type="text" class="form-control input-sm text-right" id="txtTotal" readonly="readonly" />
                    </div>
                </div>
                
            </div>
            <table id="tablaCotizacionDetalle" class="display" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>Alm.</th>
                        <th>Artículo</th>
                        <th>Descripción</th>
                        <th>U. Med.</th>
                        <th>Vendedor</th>
                        <th>Saldo</th>
                        <th>Precio</th>
                        <th>Cantidad</th>
                        <th>Bruto</th>
                        <th>Neto</th>
                        <th>Impuesto</th>
                        <th>Total</th>
                        <th>Tipo Item</th>
                        <th>Cod. Línea</th>
                        <th>Des. Línea</th>
                        <th>Cod. SubLínea</th>
                        <th>Des. SubLínea</th>
                        <th>Afecto Igv</th>
                        <th>Tasa Impuesto</th>
                    </tr>
                </thead>
            </table>

        </div>
    </div>

    <div id="myModal" class="modal fade">
        <div class="modal-dialog">
            <div class="modal-content">
            </div>
        </div>
    </div>
    <div id="modalBusqueda" style="display:none">
        <iframe id="frameBusqueda" frameborder="0" width="100%" height="100%"></iframe> 
    </div>
</asp:Content>
