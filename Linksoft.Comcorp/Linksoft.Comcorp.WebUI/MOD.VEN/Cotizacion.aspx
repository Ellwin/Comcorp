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
        var tablaListado;
        $(function () {
            linksoft.util.configDatepickerEs();

            linksoft.util.setToolbar('regCotizacion', function () {
                habilitarControles();
            });

            $('#txtFechaEmision').datepicker();
            $('#txtFechaVencimiento').datepicker();


            $("#txtFechaEmision").on('change', function () {
                getTipoCambio();
            });

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
                            { "data": "nuTasaImpuesto", "visible": false },
                            { "data": "codListaPrecio", "visible": false }
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


            tablaListado = $('#tablaListado').DataTable({
                "scrollY": 200,
                "scrollX": true,
                "paging": false,
                "ordering": false,
                "jQueryUI": true,
                "initComplete": function (settings, json) {
                    $('#tablaListado tbody tr:first').click();
                },
                "ajax": {
                    "url": cotizacionURL,
                    "contentType": "application/json",
                    "data": function (d) {
                        return JSON.stringify(d.data);

                    }
                },
                "columns": [
                            { "data": "id" },
                            { "data": "dsDoc" },
                            { "data": "dsDocSerie" },
                            { "data": "dsDocNro" },
                            { "data": "feEmision", "className": "text-center", "render": function (data, type, full, meta) { return linksoft.util.parseJsonDate(data) } },
                            { "data": "codOperFact" },
                            { "data": "codCliente" },
                            { "data": "dsCliente" },
                            { "data": "nuTotalMN", "className": "text-right", "render": function (data, type, full, meta) { return data.toFixed(2) } },
                            { "data": "nuTotalME", "className": "text-right", "render": function (data, type, full, meta) { return data.toFixed(2) } },
                            { "data": "nuBrutoMN", "className": "text-right", "render": function (data, type, full, meta) { return data.toFixed(2) } },
                            { "data": "nuBrutoME", "className": "text-right", "render": function (data, type, full, meta) { return data.toFixed(2) } },
                            { "data": "nuNetoMN", "className": "text-right", "render": function (data, type, full, meta) { return data.toFixed(2) } },
                            { "data": "nuNetoME", "className": "text-right", "render": function (data, type, full, meta) { return data.toFixed(2) } },
                            { "data": "nuImpuestoMN", "className": "text-right", "render": function (data, type, full, meta) { return data.toFixed(2) } },
                            { "data": "nuImpuestoME", "className": "text-right", "render": function (data, type, full, meta) { return data.toFixed(2) } },
                            { "data": "dsEstado", "className": "text-center" },
                            { "data": "codCia", "visible": false },
                            { "data": "codEjercicio", "visible": false },
                            { "data": "codPeriodo", "visible": false },
                            { "data": "dsOperFact", "visible": false },
                            { "data": "codAlmacen", "visible": false },
                            { "data": "dsAlmacen", "visible": false },
                            { "data": "dsTipoDoc", "visible": false },
                            { "data": "dsTipoTrans", "visible": false },
                            { "data": "feVencimiento", "visible": false },
                            { "data": "codOperLog", "visible": false },
                            { "data": "codZona", "visible": false },
                            { "data": "dsZona", "visible": false },
                            { "data": "codVendedor", "visible": false },
                            { "data": "dsVendedor", "visible": false },
                            { "data": "codSucursal", "visible": false },
                            { "data": "dsSucursal", "visible": false },
                            { "data": "codCobrador", "visible": false },
                            { "data": "dsCobrador", "visible": false },
                            { "data": "codCondPago", "visible": false },
                            { "data": "dsCondPago", "visible": false },
                            { "data": "dsDireccionCliente", "visible": false },
                            { "data": "dsGlosa", "visible": false },
                            { "data": "dsPrioridad", "visible": false },
                            { "data": "nuTipoCambio", "visible": false },
                            { "data": "codMoneda", "visible": false },
                            { "data": "dsMoneda", "visible": false },
                            { "data": "dsUsuCreacion", "visible": false },
                            { "data": "feCreacion", "visible": false },
                            { "data": "dsUsuModificacion", "visible": false },
                            { "data": "feModificacion", "visible": false }
                          ]
            });

            $('#tablaListado tbody').on('click', 'tr', function () {
                if ($(this).hasClass('selected')) {
                    $(this).removeClass('selected');
                }
                else {
                    tablaListado.$('tr.selected').removeClass('selected');
                    $(this).addClass('selected');
                }

                if (tablaListado.data().length == 0) {
                    return;
                }

                var d = tablaListado.row(this).data();
                var feEmision = linksoft.util.parseJsonDate(d.feEmision);
                var feVencimiento = linksoft.util.parseJsonDate(d.feVencimiento);

                $('#txtDoc').val(d.dsDoc);
                $('#txtSerie').val(d.dsDocSerie);
                $('#txtNumero').val(d.dsDocNro);
                $('#txtCodCondPago').val(d.codCondPago);
                $('#txtCondPago').val(d.dsCondPago);
                $('#txtTipoCondPago').val(d.dsTipoCondPago);
                $('#txtFechaEmision').val(feEmision);
                $('#txtFechaVencimiento').val(feVencimiento);
                $('#txtCodOperFact').val(d.codOperFact);
                $('#txtOperFact').val(d.dsOperFact);
                $('#txtCodOperLog').val(d.codOperLog);
                $('#txtCodZona').val(d.codZona);
                $('#txtZona').val(d.dsZona);
                $('#txtCodAlmacen').val(d.codAlmacen);
                $('#txtAlmacen').val(d.dsAlmacen);
                $('#txtCodUnidadOperativa').val(d.codSucursal);
                $('#txtUnidadOperativa').val(d.dsSucursal);
                $('#txtCodVendedor').val(d.codVendedor);
                $('#txtVendedor').val(d.dsVendedor);
                $('#txtCodCobrador').val(d.codCobrador);
                $('#txtCobrador').val(d.dsCobrador);
                $('#txtCodCliente').val(d.codCliente);
                $('#txtCliente').val(d.dsCliente);
                $('#txtDireccion').val(d.dsDireccionCliente);
                $('#txtGlosa').val(d.dsGlosa);
                $('#ddlPrioridad').val(d.dsPrioridad);
                $('#txtTipoCambio').val(d.nuTipoCambio);
                $('#txtCodMoneda').val(d.codMoneda);
                $('#txtCodListaPrecio').val(d.codListaPrecio);
                $('#txtMoneda').val(d.dsMoneda);
                $('#txtBruto').val(d.nuBruto.toFixed(2));
                $('#txtNeto').val(d.nuNeto.toFixed(2));
                $('#txtImpuesto').val(d.nuImpuesto.toFixed(2));
                $('#txtTotal').val(d.nuTotal.toFixed(2));
                $('#ddlEstado').val(d.dsEstado);

                tablaCotizacion.clear().draw();

                var cotizacionDetalleParam = {
                    Metodo: 'GetCotizacionDetalle',
                    cia: d.codCia,
                    ejercicio: d.codEjercicio,
                    periodo: d.codPeriodo,
                    doc: d.dsDoc,
                    serie: d.dsDocSerie,
                    nro: d.dsDocNro
                };

                linksoft.util.ajaxCallback(cotizacionURL, cotizacionDetalleParam, function (response) {
                    var data = {};
                    data = response.data;

                    $.each(data, function (i, elem) {
                        addItemFactura(elem);
                    });

                });

            });

            $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                var tablaListado = $('#tablaListado').DataTable(),
                    tablaCotizacionDetalle = $('#tablaCotizacionDetalle').DataTable();

                tablaListado.columns.adjust().draw();
                tablaCotizacionDetalle.columns.adjust().draw();
            })

            Busqueda();


            $("#btnGuardar").on('click', function () {

                var alert_type = 'alert-danger';

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
                    linksoft.util.alert('Ingrese cliente.');
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtCliente').focus();
                    return false;
                }

                if ($('#txtCodOperFact').val() == '') {
                    linksoft.util.alert('Ingrese operación de facturación.');
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtOperFact').focus();
                    return false;
                }

                if ($('#txtTipoCambio').val() == '') {
                    linksoft.util.alert('Ingrese tipo de cambio.');
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtTipoCambio').focus();
                    return false;
                }

                if ($('#txtCodVendedor').val() == '') {
                    linksoft.util.alert('Ingrese vendedor.');
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtVendedor').focus();
                    return false;
                }

                if ($('#txtCodCondPago').val() == '') {
                    linksoft.util.alert('Ingrese condición de pago.');
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtCondPago').focus();
                    return false;
                }

                if ($('#txtCodUnidadOperativa').val() == '') {
                    linksoft.util.alert('Ingrese unidad operativa.');
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtUnidadOperativa').focus();
                    return false;
                }

                if ($('#txtCodZona').val() == '') {
                    linksoft.util.alert('Ingrese zona.');
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtZona').focus();
                    return false;
                }

                if ($('#tablaCotizacionDetalle').DataTable().data().length == 0) {
                    linksoft.util.alert('No existe detalle de cotización.');
                    $('a[href="#tabDetalle"]').tab('show');
                    $('#btnAgregarItem').focus();
                    return false;
                }

            linksoft.util.openModalConfirmacion('¿Está seguro(a) de guardar la cotización?', function () {
                Guardar();
            });

            return false;
        });

        $("#btnEliminar").on('click', function () {
            linksoft.util.openModalConfirmacion('¿Está seguro(a) de eliminar la cotización?', function () {
                Guardar();
            });
        });

    });

        function ajustarColumnas() {
            var table = $('#tablaListado').DataTable();
            table.columns.adjust().draw();
        }

        function Guardar() {
            var objCotizacion = {};

            objCotizacion.dsDoc = $('#txtDoc').val().trim();
            objCotizacion.dsDocSerie = $('#txtSerie').val().trim();
            objCotizacion.dsDocNro = $('#txtNumero').val().trim();
            objCotizacion.codCondPago = $('#txtCodCondPago').val().trim();
            objCotizacion.feEmision = $('#txtFechaEmision').val().trim();
            objCotizacion.feVencimiento = $('#txtFechaVencimiento').val().trim();
            objCotizacion.codOperFact = $('#txtCodOperFact').val().trim();
            objCotizacion.codOperLog = $('#txtCodOperLog').val().trim();
            objCotizacion.codZona = $('#txtCodZona').val().trim();
            objCotizacion.codAlmacen = $('#txtCodAlmacen').val().trim();
            objCotizacion.codSucursal = $('#txtCodUnidadOperativa').val().trim();
            objCotizacion.codVendedor = $('#txtCodVendedor').val().trim();
            objCotizacion.codCobrador = $('#txtCodCobrador').val().trim();
            objCotizacion.codCliente = $('#txtCodCliente').val().trim();
            objCotizacion.dsCliente = $('#txtCliente').val().trim();
            objCotizacion.dsDireccionCliente = $('#txtDireccion').val().trim();
            objCotizacion.dsGlosa = $('#txtGlosa').val().trim();
            objCotizacion.dsPrioridad = $('#ddlPrioridad').val().trim();
            objCotizacion.nuTipoCambio = $('#txtTipoCambio').val().trim();
            objCotizacion.codMoneda = $('#txtCodMoneda').val().trim();
            objCotizacion.nuBruto = $('#txtBruto').val().trim();
            objCotizacion.nuNeto = $('#txtNeto').val().trim();
            objCotizacion.nuImpuesto = $('#txtImpuesto').val().trim();
            objCotizacion.nuTotal = $('#txtTotal').val().trim();
            objCotizacion.dsEstado = $('#ddlEstado').val().trim();
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
                if (response.mensaje == 'SUCCESS') {
                    var msg = '';
                    if (Accion == 'add') {
                        msg = 'Se registró la cotización correctamente.';
                    } else if (Accion == 'edit') {
                        msg = 'Se actualizó la cotización correctamente.';
                    } else if (Accion == 'del') {
                        msg = 'Se eliminó la cotización correctamente.';
                    }
                    linksoft.util.showMessage(msg, 'alert-success');
                    linksoft.util.defaultLoad('regCotizacion');
                    $("#btnAgregarItem").attr('disabled', true);
                    $("#btnEliminarItem").attr('disabled', true);
                } else {
                    linksoft.util.showMessage('Error al guardar.', 'alert-danger');
                }
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
                $("#txtBruto").val('0.00');
                $("#txtNeto").val('0.00');
                $("#txtImpuesto").val('0.00');
                $("#txtTotal").val('0.00');

                $("#btnAgregarItem").attr('disabled', false);
                $("#btnEliminarItem").attr('disabled', false);

                var fecha = $('#lblFecha').html();
                $("#txtFechaEmision").val(fecha);
                $("#txtFechaVencimiento").val(fecha);

                getTipoCambio();

                $('#tablaCotizacionDetalle').DataTable().clear().draw();
                $('#tablaListado').DataTable().clear().draw();
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
                    linksoft.util.alert('Ingrese cliente.');
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtCliente').focus();
                    return;
                }

                if ($('#txtCodOperFact').val() == '') {
                    linksoft.util.alert('Ingrese operación de facturación.');
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtOperFact').focus();
                    return;
                }

                if ($('#txtTipoCambio').val() == '') {
                    linksoft.util.alert('Ingrese tipo de cambio.');
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtTipoCambio').focus();
                    return;
                }

                if ($('#txtCodVendedor').val() == '') {
                    linksoft.util.alert('Ingrese vendedor.');
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtVendedor').focus();
                    return;
                }

                if ($('#txtCodCondPago').val() == '') {
                    linksoft.util.alert('Ingrese condición de pago.');
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtCondPago').focus();
                    return;
                }

                if ($('#txtCodZona').val() == '') {
                    linksoft.util.alert('Ingrese zona.');
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
                    $("#txtCodOperLog").val(response.objeto.codOperacionLogistica);
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
                    $("#txtCodOperLog").val('');
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
                'nuSaldo': parseFloat(objItem.nuSaldo).toFixed(2),
                'nuPrecio': parseFloat(objItem.nuPrecio).toFixed(2),
                'nuCantidad': parseFloat(objItem.nuCantidad).toFixed(2),
                'nuBruto': parseFloat(objItem.nuBruto).toFixed(2),
                'nuNeto': parseFloat(objItem.nuNeto).toFixed(2),
                'nuImpuesto': parseFloat(objItem.nuImpuesto).toFixed(2),
                'nuTotal': parseFloat(objItem.nuTotal).toFixed(2),
                'dsTipoItem': objItem.dsTipoItem,
                'codLinea': objItem.codLinea,
                'dsLinea': objItem.dsLinea,
                'codSubLinea': objItem.codSubLinea,
                'dsSubLinea': objItem.dsSubLinea,
                'bIva': objItem.bIva,
                'nuTasaImpuesto': objItem.nuTasaImpuesto,
                'codListaPrecio': objItem.codListaPrecio
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
                        <button type="button" id="btnAgregarItem" class="btn btn-xs" disabled="disabled"><span class="glyphicon glyphicon-plus text-success"></span>  Agregar</button>
                        <button type="button" id="btnEliminarItem" class="btn btn-xs" disabled="disabled"><span class="glyphicon glyphicon-remove text-danger"></span>  Eliminar</button>
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
                        <th>Cod. Lista Precio</th>
                    </tr>
                </thead>
            </table>

        </div>
    </div>

    <div class="tab-pane" id="tabListado">
        <div class="panel panel-primary">
            <div class="panel panel-heading">
                    <h4 class="panel-title">Listado de Cotización</h4>
            </div>
            <table id="tablaListado" class="display" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Doc.</th>
                        <th>Serie</th>
                        <th>Numero</th>
                        <th>Fecha Doc.</th>
                        <th>Oper.Fact.</th>
                        <th>Cliente</th>
                        <th>Razon y/o Nombres</th>
                        <th>Total MN</th>
                        <th>Total ME</th>
                        <th>Bruto MN</th>
                        <th>Bruto ME</th>
                        <th>Neto MN</th>
                        <th>Neto ME</th>
                        <th>Impuesto MN</th>
                        <th>Impuesto ME</th>
                        <th>Estado</th>
                        <th>Cia</th>
                        <th>Ejercicio</th>
                        <th>Periodo</th>
                        <th>Des. Oper. Fact.</th>
                        <th>Alm.</th>
                        <th>Des. Alm.</th>
                        <th>Tipo Doc.</th>
                        <th>Tipo Trans.</th>
                        <th>Fecha Venc.</th>
                        <th>Oper Log.</th>
                        <th>Zona</th>
                        <th>Des. Zona</th>
                        <th>Vendedor</th>
                        <th>Des. Vendedor</th>
                        <th>Unidad Oper.</th>
                        <th>Des. Unidad Oper.</th>
                        <th>Cobrador</th>
                        <th>Des. Cobrador</th>
                        <th>Cond. Pago</th>
                        <th>Des. Cond. Pago</th>
                        <th>Dir. Cliente</th>
                        <th>Glosa</th>
                        <th>Prioridad</th>
                        <th>Tipo Cambio</th>
                        <th>Moneda</th>
                        <th>Des. Moneda</th>
                        <th>Usu. Crea.</th>
                        <th>Fecha Crea.</th>
                        <th>Usu. Modif.</th>
                        <th>Fecha Modif.</th>
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
