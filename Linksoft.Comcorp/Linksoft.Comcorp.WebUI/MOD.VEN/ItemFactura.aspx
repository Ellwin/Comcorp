<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="ItemFactura.aspx.vb" Inherits="Linksoft.Comcorp.WebUI.ItemFactura" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>

    <link href="~/css/jquery-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="~/css/jquery-ui.theme.min.css" rel="stylesheet" type="text/css" />
    <link href="~/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    
    <script type="text/javascript">
        var baseURL = "<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>";
    </script>
      
    <script src="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>js/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script src="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>js/jquery-ui.js" type="text/javascript"></script>
    <script src="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>js/bootstrap.js" type="text/javascript"></script>
    <script src="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>js/jquery.blockUI.js" type="text/javascript"></script>

    <script src="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>js/linksoft.js" type="text/javascript"></script>

    <script type="text/javascript">
        var cotizacionURL = 'Handlers/HandlerCotizacion.ashx';
        var objItem = {};

        $(function () {

            cargarItemFactura();

            $('#btnBuscarArticulo').click(function () {
                linksoft.util.openModalCustomSize('modalBusqueda', 'frameBusqueda', '<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>Busqueda/Busqueda.aspx?tipo=BUSQUEDA&valor=ARTICULO', 'Busqueda de Artículos', '400', '450');
            });

            linksoft.util.importes('txtCantidad');
            linksoft.util.importes('txtPrecio');

            $('#btnAceptar').click(function () {

                var alert_type = 'alert-danger'

                if ($('#txtCodArticulo').val() == '') {
                    linksoft.util.alert('Ingrese artículo.');
                    $('#txtArticulo').focus();
                    return;
                }

                if ($('#txtCantidad').val() == '') {
                    linksoft.util.alert('Ingrese cantidad.');
                    $('#txtCantidad').focus();
                    return;
                }

                if ($('#txtCantidad').val() == 0) {
                    linksoft.util.alert('Ingrese cantidad válida.');
                    $('#txtCantidad').focus();
                    return;
                }

                if ($('#txtPrecio').val() == '') {
                    linksoft.util.alert('Ingrese precio.');
                    $('#txtPrecio').focus();
                    return;
                }

                if ($('#txtPrecio').val() == 0) {
                    linksoft.util.alert('Ingrese precio válido.');
                    $('#txtPrecio').focus();
                    return;
                }


                addRow(objItem);
            });

            $('#btnCancelar').click(function () {
                parent.closeModal();
            });

            $('#txtCantidad, #txtPrecio').on('change', function () {
                calcularTotal();
            })

        })

        function cargarItemFactura(){
            var itemParam = {
                Metodo : 'CargarItemFactura',
                moneda: linksoft.util.getParameterByName('moneda'),
                vendedor: linksoft.util.getParameterByName('vendedor'),
                almacen: linksoft.util.getParameterByName('almacen'),
                listaprecio : linksoft.util.getParameterByName('listaprecio')
            };

            linksoft.util.ajaxCallback(cotizacionURL, itemParam, function (response) {
                $('#txtCodAlmacen').val(response.objeto.codAlmacen);
                $('#txtAlmacen').val(response.objeto.dsAlmacen);
                $('#txtCodVendedor').val(response.objeto.codVendedor);
                $('#txtVendedor').val(response.objeto.dsVendedor);
                $('#txtCodMoneda').val(response.objeto.codMoneda);
                $('#txtMoneda').val(response.objeto.dsMoneda);
                $('#txtCodListaPrecio').val(response.objeto.codListaPrecio);
            });
        }

        function addRow(objItem) {
            objItem.codAlmacen = $('#txtCodAlmacen').val();
            objItem.codArticulo = $('#txtCodArticulo').val();
            objItem.dsArticulo = $('#txtArticulo').val();
            objItem.codUnidadMedidaAlmacen = $('#txtUnidadMedida').val();
            objItem.codVendedor = $('#txtCodVendedor').val();
            objItem.nuSaldo = $('#txtStock').val();
            objItem.nuPrecio = $('#txtPrecio').val();
            objItem.nuCantidad = $('#txtCantidad').val();
            objItem.nuBruto = $('#txtBruto').val();
            objItem.nuNeto = $('#txtNeto').val();
            objItem.nuImpuesto = $('#txtImpuesto').val();
            objItem.nuTotal = $('#txtTotal').val();
            objItem.bIva = $('#txtIndIva').val();
            objItem.dsTipoItem = $('#txtTipoItem').val();
            objItem.codLinea = $('#txtCodLinea').val();
            objItem.dsLinea = $('#txtLinea').val();
            objItem.codSubLinea = $('#txtCodSubLinea').val();
            objItem.dsSubLinea = $('#txtSubLinea').val();
            objItem.nuTasaImpuesto = $('#txtPorcImpuesto').val();
            
            parent.addItemFactura(objItem);
            parent.closeModal();
        }

        function cargarItem(busqueda, codigo, descripcion) {
            switch (busqueda) {
                case "ARTICULO":
                    $("#txtCodArticulo").val(codigo);
                    $("#txtArticulo").val(descripcion);

                    getDatosArticulo(codigo);
                    getListaPrecioArticulo(codigo);

                    break;
            };
            $("#modalBusqueda").dialog("close");

        }

        function getDatosArticulo(codigo) { 
             var articuloParam = {
                Metodo : 'GetDatosArticulo',
                codArticulo: codigo,
                codAlmacen: $("#txtCodAlmacen").val()
            };

            linksoft.util.ajaxCallback(cotizacionURL, articuloParam, function (response) {
                if (response.mensaje == 'SUCCESS') {
                    $('#txtCodLinea').val(response.objeto.codLinea);
                    $('#txtLinea').val(response.objeto.dsLinea);
                    $('#txtCodSubLinea').val(response.objeto.codSubLinea);
                    $('#txtSubLinea').val(response.objeto.dsSubLinea);
                    $('#txtUnidadMedida').val(response.objeto.codUnidadMedidaAlmacen);
                    $('#txtTipoItem').val(response.objeto.dsTipoItem);
                    $('#txtIndIva').val(response.objeto.bIva);
                    $('#txtColor').val(response.objeto.dsColor);
                    $('#txtMarca').val(response.objeto.dsMarca);
                    $('#txtModelo').val(response.objeto.dsModelo);
                    $('#txtStock').val(response.objeto.nuSaldo.toFixed(2));
                    $('#txtPorcImpuesto').val(response.objeto.nuTasaImpuesto.toFixed(2));
                }
            });
        }

        function getListaPrecioArticulo(codigo) {
            var listaprecioParam = {
                Metodo: 'GetListaPrecioArticulo',
                codArticulo: codigo,
                codListaPrecio: $("#txtCodListaPrecio").val(),
                codMoneda: $('#txtCodMoneda').val()
            };

            linksoft.util.ajaxCallback(cotizacionURL, listaprecioParam, function (response) {
                if (response.mensaje == 'SUCCESS') {
                    $('#txtPrecio').val(response.objeto.nuPrecio.toFixed(2));
                }
                else {
                    $('#txtPrecio').val('0.00');
                }
            });
        }

        function calcularTotal() {
            var bruto = 0,
                neto = 0,
                porcImpuesto = 0,
                impuesto = 0,
                total = 0

            bruto = $('#txtPrecio').val() * $('#txtCantidad').val();
            neto = $('#txtPrecio').val() * $('#txtCantidad').val();
            porcImpuesto = $('#txtPorcImpuesto').val() / 100;
            impuesto = neto * porcImpuesto;
            total = neto + impuesto;

            $('#txtBruto').val(bruto.toFixed(2));
            $('#txtNeto').val(neto.toFixed(2));
            $('#txtImpuesto').val(impuesto.toFixed(2));
            $('#txtTotal').val(total.toFixed(2));
        }

    </script>

</head>
<body>
    <form id="form2" runat="server">
        <div>
            <div class="panel panel-default">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-xs-2"><label>Artículo</label></div>
                        <div class="col-xs-10">
                            <div class="input-group"> 
                                <span class="input-group-btn">
                                    <button type="button" id="btnBuscarArticulo" class="btn btn-info btn-sm"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</button>
                                </span>
                                <input type="hidden" class="form-control input-sm" id="txtCodListaPrecio"/>
                                <input type="hidden" class="form-control input-sm" id="txtCodLinea"/>
                                <input type="hidden" class="form-control input-sm" id="txtLinea"/>
                                <input type="hidden" class="form-control input-sm" id="txtCodSubLinea"/>
                                <input type="hidden" class="form-control input-sm" id="txtSubLinea"/>
                                <input type="hidden" class="form-control input-sm" id="txtUnidadMedida"/>
                                <input type="hidden" class="form-control input-sm" id="txtTipoItem"/>
                                <input type="hidden" class="form-control input-sm" id="txtIndIva"/>
                                <input type="hidden" class="form-control input-sm" id="txtCodArticulo"/>
                                <input type="text" class="form-control input-sm" id="txtArticulo" readonly="readonly" />
                            </div>
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-xs-2"><label>Almacén</label></div>
                        <div class="col-xs-10">
                            <input type="hidden" class="form-control input-sm" id="txtCodAlmacen"/>
                            <input type="text" class="form-control input-sm" id="txtAlmacen" readonly="readonly" />
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-xs-2"><label>Vendedor</label></div>
                        <div class="col-xs-10">
                            <input type="hidden" class="form-control input-sm" id="txtCodVendedor"/>
                            <input type="text" class="form-control input-sm" id="txtVendedor" readonly="readonly" />
                        </div>
                    </div>
                    <br /> 
                    <div class="row">
                        <div class="col-xs-4">
                            <label>Modelo</label>
                            <input type="text" class="form-control input-sm" id="txtModelo" readonly="readonly" />
                        </div>
                        <div class="col-xs-4">
                            <label>Marca</label>
                            <input type="text" class="form-control input-sm" id="txtMarca" readonly="readonly" />
                        </div>
                        <div class="col-xs-4">
                            <label>Color</label>
                            <input type="text" class="form-control input-sm" id="txtColor" readonly="readonly" />
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-xs-2"><label>Stock</label></div>
                        <div class="col-xs-4">
                            <input type="text" class="form-control input-sm text-right" id="txtStock" readonly="readonly" />
                        </div>
                        <div class="col-xs-2"><label>Moneda</label></div>
                        <div class="col-xs-4">
                            <input type="hidden" class="form-control input-sm" id="txtCodMoneda"/>
                            <input type="text" class="form-control input-sm" id="txtMoneda" readonly="readonly" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-2"><label>Cantidad</label></div>
                        <div class="col-xs-4">
                            <input type="text" class="form-control input-sm text-right" id="txtCantidad"/>
                        </div>
                        <div class="col-xs-2"><label>Neto</label></div>
                        <div class="col-xs-4">
                            <input type="text" class="form-control input-sm text-right" id="txtNeto" readonly="readonly" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-2"><label>Precio</label></div>
                        <div class="col-xs-4">
                            <input type="text" class="form-control input-sm text-right" id="txtPrecio"/>
                        </div>
                        <div class="col-xs-2"><label>Impuesto</label></div>
                        <div class="col-xs-4">
                            <input type="hidden" class="form-control input-sm text-right" id="txtPorcImpuesto" />
                            <input type="text" class="form-control input-sm text-right" id="txtImpuesto" readonly="readonly" />
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-xs-2"><label>Bruto</label></div>
                        <div class="col-xs-4">
                            <input type="text" class="form-control input-sm text-right" id="txtBruto" readonly="readonly" />
                        </div>
                        <div class="col-xs-2"><label>Total</label></div>
                        <div class="col-xs-4">
                            <input type="text" class="form-control input-sm text-right" id="txtTotal" readonly="readonly" />
                        </div>
                    </div>
                    <br />
                    <div class="row">
                        <div class="col-xs-12">
                            <p class="pull-right">
                                <button type="button" id="btnCancelar" class="btn btn-danger btn-sm"><span class="glyphicon glyphicon-log-out"></span>  Cancelar</button>
                                <button type="button" id="btnAceptar" class="btn btn-success btn-sm"><span class="glyphicon glyphicon-ok"></span>  Aceptar</button>
                            </p>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div id="modalBusqueda" style="display:none">
            <iframe id="frameBusqueda" frameborder="0" width="100%" height="100%"></iframe> 
        </div>
    </form>
</body>
</html>
