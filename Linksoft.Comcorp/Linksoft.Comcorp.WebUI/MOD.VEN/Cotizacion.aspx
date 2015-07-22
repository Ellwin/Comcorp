<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Cotizacion.aspx.vb" Inherits="Linksoft.Comcorp.WebUI.Cotizacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script type="text/javascript">
        $(function () {
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
        });

        function cargarItem(busqueda, codigo, descripcion) {
            switch (busqueda) {
                case "ALMACEN":
                    $("#txtAlmacen").val(descripcion);
                    break;
                case "CLIENTE":
                    $("#txtCliente").val(descripcion);
                    break;
                case "VENDEDOR":
                    $("#txtVendedor").val(descripcion);
                    break;
                case "OPERFACT":
                    $("#txtOperFact").val(descripcion);
                    break;
                case "CONDPAGO":
                    $("#txtCondPago").val(descripcion);
                    break;
            }
            $("#modalBusqueda").dialog("close");
        };
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
<div class="tab-pane fade" id="tabMain">
        
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
                       <input type="text" class="form-control" id="txtAlmacen" readonly="readonly" />
                    </div>
                </div>
                <div class="col-xs-2">
                    <label>Fe. Vencimiento</label>
                    <input type="text" class="form-control input-sm" id="txtFechaVenc" required/>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-xs-10">
                    <label>Glosa</label>
                    <input type="text" class="form-control input-sm" id="txtGlosa" />
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
                       <input type="text" class="form-control" id="txtCliente" readonly="readonly" />
                    </div>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-xs-8">
                    <label>Direccion</label>
                    <select class="form-control input-sm" id="ddlDireccion" >
                    </select>
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
                       <input type="text" class="form-control" id="txtOperFact" readonly="readonly" />
                    </div>
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
                       <input type="text" class="form-control" id="txtCondPago" readonly="readonly" />
                    </div>
                </div>
                <div class="col-xs-2">
                    <label>Tipo Cond.</label>
                    <input type="text" class="form-control input-sm" id="txtTipoCondPago" readonly="readonly" required/>
                </div>
            </div>
            <div class="row">
                    <div class="col-xs-5">
                    <label >Estado:</label>
                    <select class="form-control input-sm" id="ddlEstado" disabled="disabled">
                        <option value="A" >Activo</option>
                        <option value="I" >Inactivo</option>
                    </select>
                </div>
                <div class="col-xs-5">
                        <label class="invisible">s</label>
                        <div class="checkbox">
                            <input type="checkbox" id="chkAdmin" disabled="disabled" /> 
                            <label>Administrador</label>
                        </div>                    
                </div>
        
            </div>
                        
                        
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
