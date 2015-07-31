<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Cotizacion.aspx.vb" Inherits="Linksoft.Comcorp.WebUI.Cotizacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <style type="text/css">
        th, td { white-space: nowrap; }
        div.dataTables_wrapper {
            width: 100%;
            margin: 0 auto;
        }
    </style>
    <script type="text/javascript">
        var cotizacionURL = 'Handlers/HandlerCotizacion.ashx';
        var currentCotizacion = {};
        var tablaCotizacion;
        $(function () {
            linksoft.util.configDatepickerEs();
            getTipoCambio();

            $('#txtFechaEmision').datepicker().datepicker("setDate", new Date());
            $('#txtFechaVencimiento').datepicker().datepicker("setDate", new Date());

            $('a[href="#tabMain"]').tab('show');


            tablaCotizacion = $('#tablaCotizacionDetalle').dataTable({
                "scrollY": 200,
                "scrollX": true,
                "paging": false,
                "jQueryUI": true
            });


            Busqueda();



        });

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
                    $("#txtCodMoneda").val(response.objeto.codMoneda);
                    $("#txtMoneda").val(response.objeto.dsMoneda);

                } else {
                    $("#txtCodOperFact").val('');
                    $("#txtOperFact").val('');
                    $("#txtCodMoneda").val('');
                    $("#txtMoneda").val('');
                }
            });
        }

        function addItemFactura(objItem) {
            var table = $('#tablaCotizacionDetalle').DataTable();
            table.row.add([
                objItem.codArticulo,
                objItem.dsArticulo,
                objItem.dsTipoItem,
                objItem.codUnidadMedidaAlmacen,
                objItem.nuSaldo,
                objItem.codLinea,
                objItem.dsLinea,
                objItem.codSubLinea,
                objItem.dsSubLinea,
                objItem.dsModelo,
                objItem.dsMarca,
                objItem.dsColor
            ]).draw();

            table.columns.adjust().draw();
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
                              <button type="button" id="btnBuscarDoc" class="btn btn-info"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</button>
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
                        <input type="text" class="form-control input-sm" id="txtNumero" readonly="readonly" required/>
                    </div>
                
                    <div class="col-xs-2">
                        <label>Fe. Emisión</label>
                        <input type="text" class="form-control input-sm" id="txtFechaEmision" required/>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Almacen</label>
                        <div class="input-group"> 
                           <span class="input-group-btn">
                              <button type="button" id="btnBuscarAlmacen" class="btn btn-info"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</button>
                           </span>
                           <input type="hidden" class="form-control" id="txtCodAlmacen"/>
                           <input type="text" class="form-control" id="txtAlmacen" readonly="readonly" />
                        </div>
                    </div>
                    <div class="col-xs-2">
                        <label>Fe. Vencimiento</label>
                        <input type="text" class="form-control input-sm" id="txtFechaVencimiento" required/>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Glosa</label>
                        <input type="text" class="form-control input-sm" id="txtGlosa" />
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
                              <button type="button" id="btnBuscarCliente" class="btn btn-info"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</button>
                           </span>
                           <input type="hidden" class="form-control" id="txtCodCliente" />
                           <input type="hidden" class="form-control" id="txtCodListaPrecio" />
                           <input type="text" class="form-control" id="txtCliente" readonly="readonly" />
                        </div>
                    </div>
                    <div class="col-xs-2">
                        <label>Tipo Cambio</label>
                        <input type="text" class="form-control input-sm" id="txtTipoCambio" />
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Direccion</label>
                        <input type="text" class="form-control input-sm" id="txtDireccion" />
                    </div>
                    
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Oper. Fact.</label>
                        <div class="input-group"> 
                           <span class="input-group-btn">
                              <button type="button" id="btnBuscarOperFact" class="btn btn-info"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</button>
                           </span>
                           <input type="hidden" class="form-control" id="txtCodOperFact" />
                           <input type="text" class="form-control" id="txtOperFact" readonly="readonly" />
                        </div>
                    </div>
                    <div class="col-xs-2">
                        <label>Moneda.</label>
                        <input type="hidden" class="form-control input-sm" id="txtCodMoneda" />
                        <input type="text" class="form-control input-sm" id="txtMoneda" readonly="readonly" required/>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Vendedor</label>
                        <div class="input-group"> 
                           <span class="input-group-btn">
                              <button type="button" id="btnBuscarVendedor" class="btn btn-info"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</button>
                           </span>
                           <input type="hidden" class="form-control input-sm" id="txtCodVendedor" />
                           <input type="text" class="form-control" id="txtVendedor" readonly="readonly" />
                        </div>
                    </div>
                    <div class="col-xs-2">
                        <label>Reg. Tribut.</label>
                        <input type="text" class="form-control input-sm" id="Text6" readonly="readonly" required/>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Condición</label>
                        <div class="input-group"> 
                           <span class="input-group-btn">
                              <button type="button" id="btnBuscarCondPago" class="btn btn-info"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</button>
                           </span>
                           <input type="hidden" class="form-control" id="txtCodCondPago" />
                           <input type="text" class="form-control" id="txtCondPago" readonly="readonly" />
                        </div>
                    </div>
                    <div class="col-xs-2">
                        <label>Tipo Cond.</label>
                        <input type="text" class="form-control input-sm" id="txtTipoCondPago" readonly="readonly" required/>
                    </div>
                </div>
                <hr />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Unidad Operativa</label>
                        <div class="input-group"> 
                           <span class="input-group-btn">
                              <button type="button" id="btnBuscarUnidadOperativa" class="btn btn-info"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</button>
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
                              <button type="button" id="btnBuscarZona" class="btn btn-info"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</button>
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
                              <button type="button" id="btnBuscarCobrador" class="btn btn-info"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</button>
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
                    <button type="button" id="btnAgregarItem" class="btn btn-success btn-xs"><span class="glyphicon glyphicon-plus"></span>  Agregar</button>
                </div>
            </div>
            <table id="tablaCotizacionDetalle" class="table table-striped table-bordered" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>Artículo</th>
                        <th>Descripción</th>
                        <th>Tipo Item</th>
                        <th>Unidad Medida</th>
                        <th>Saldo</th>
                        <th>Cod. Línea</th>
                        <th>Des. Línea</th>
                        <th>Cod. SubLínea</th>
                        <th>Des. SubLínea</th>
                        <th>Modelo</th>
                        <th>Marca</th>
                        <th>Color</th>
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
