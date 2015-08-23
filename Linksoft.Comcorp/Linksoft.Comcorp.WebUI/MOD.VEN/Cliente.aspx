<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Cliente.aspx.vb" Inherits="Linksoft.Comcorp.WebUI.Cliente" %>
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
        var clienteURL = 'Handlers/HandlerCliente.ashx';
        var tablaListado;

        $(function () {
            linksoft.util.configDatepickerEs();

            linksoft.util.setToolbar('regCliente', function () {
                habilitarControles();
            });

            $('#txtFechaNacimiento').datepicker();

            $('a[href="#tabDetalle"]').hide();
            $('a[href="#tabMain"]').tab('show');

            incializarDatatable();
            eventos();

        });

        function habilitarControles() {

            if (Accion == 'add') {
                $("#txtDescripcion").attr('readonly', true);
                $("#txtRuc").attr('readonly', true);
                $('#tablaListado').DataTable().clear().draw();
            }

            if (Accion == 'edit') {
                $("#txtCodigo").attr('readonly', true);
                $('#tablaListado').DataTable().clear().draw();

                if ($('#ddlTipoPersona').val() == '01') {
                    $("#txtPaterno").attr('readonly', false);
                    $("#txtMaterno").attr('readonly', false);
                    $("#txtNombres").attr('readonly', false);
                    $("#txtDescripcion").attr('readonly', true);

                } else {

                    $("#txtPaterno").attr('readonly', true);
                    $("#txtMaterno").attr('readonly', true);
                    $("#txtNombres").attr('readonly', true);
                    $("#txtDescripcion").attr('readonly', false);

                }

                if ($('#ddlTipoDocumento').val() == '06') {
                    $("#txtRuc").attr('readonly', false);
                    $("#txtNroDocumento").attr('readonly', true);

                } else {
                    $("#txtRuc").attr('readonly', true);
                    $("#txtNroDocumento").attr('readonly', false);
                }
            }

        }

        function eventos() {
            $('a[data-toggle="tab"]').on('shown.bs.tab', function (e) {
                var table = $('#tablaListado').DataTable();
                table.columns.adjust().draw();
            });

            $('#ddlTipoPersona').on('change', function () {
                if ($(this).val() == '01') {
                    $("#txtPaterno").attr('readonly', false);
                    $("#txtMaterno").attr('readonly', false);
                    $("#txtNombres").attr('readonly', false);
                    $("#txtDescripcion").attr('readonly', true);

                    $('#txtPaterno').val('');
                    $('#txtMaterno').val('');
                    $('#txtNombres').val('');
                    $('#txtDescripcion').val('');
                } else {
                    

                    $("#txtPaterno").attr('readonly', true);
                    $("#txtMaterno").attr('readonly', true);
                    $("#txtNombres").attr('readonly', true);
                    $("#txtDescripcion").attr('readonly', false);

                    $('#txtPaterno').val('');
                    $('#txtMaterno').val('');
                    $('#txtNombres').val('');
                    $('#txtDescripcion').val('');
                }
            });

            $('#ddlTipoDocumento').on('change', function () {
                if ($(this).val() == '06') {
                    $("#txtRuc").attr('readonly', false);
                    $("#txtNroDocumento").attr('readonly', true);

                    $('#txtRuc').val('');
                    $('#txtNroDocumento').val('');
                } else {
                    $("#txtRuc").attr('readonly', true);
                    $("#txtNroDocumento").attr('readonly', false);

                    $('#txtRuc').val('');
                    $('#txtNroDocumento').val('');
                }
            });

            $('#txtPaterno, #txtMaterno, #txtNombres').on('keyup', function () {
                var $paterno = $('#txtPaterno').val(),
                    $materno = $('#txtMaterno').val(),
                    $nombres = $('#txtNombres').val(),
                    $descripcion = $paterno + ' ' + $materno + ' ' + $nombres;
                $('#txtDescripcion').val($descripcion);
            });


            $("#btnGuardar").on('click', function () {
                if ($('#txtCodigo').val().trim() == '') {
                    linksoft.util.alert('Ingrese código.');
                    $('a[href="#tabMain"]').tab('show');
                    $('#txtCodigo').focus();
                    return false;
                }

                if ($('#ddlTipoDocumento').val() == '01') {
                    if ($('#txtNroDocumento').val().trim() == '') {
                        linksoft.util.alert('Ingrese documento.');
                        $('a[href="#tabMain"]').tab('show');
                        $('#txtNroDocumento').focus();
                        return false;
                    }
                }

                if ($('#ddlTipoDocumento').val() == '06') {
                    if ($('#txtRuc').val().trim() == '') {
                        linksoft.util.alert('Ingrese ruc.');
                        $('a[href="#tabMain"]').tab('show');
                        $('#txtRuc').focus();
                        return false;
                    }
                }

                if ($('#ddlTipoPersona').val() == '01') {
                    if ($('#txtPaterno').val().trim() == '') {
                        linksoft.util.alert('Ingrese apellido paterno.');
                        $('a[href="#tabMain"]').tab('show');
                        $('#txtPaterno').focus();
                        return false;
                    }

                    if ($('#txtMaterno').val().trim() == '') {
                        linksoft.util.alert('Ingrese apellido materno.');
                        $('a[href="#tabMain"]').tab('show');
                        $('#txtMaterno').focus();
                        return false;
                    }

                    if ($('#txtNombres').val().trim() == '') {
                        linksoft.util.alert('Ingrese nombres.');
                        $('a[href="#tabMain"]').tab('show');
                        $('#txtNombres').focus();
                        return false;
                    }

                } else {
                    if ($('#txtDescripcion').val().trim() == '') {
                        linksoft.util.alert('Ingrese descripcion.');
                        $('a[href="#tabMain"]').tab('show');
                        $('#txtDescripcion').focus();
                        return false;
                    }
                }

                linksoft.util.openModalConfirmacion('¿Está seguro(a) de guardar el cliente?', function () {
                    Guardar();
                });

                return false;
            });


            $("#btnEliminar").on('click', function () {
                linksoft.util.openModalConfirmacion('¿Está seguro(a) de eliminar el cliente?', function () {
                    Guardar();
                });
            });


        }

        function incializarDatatable() {
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
                    "url": clienteURL,
                    "contentType": "application/json",
                    "data": function (d) {
                        return JSON.stringify(d.data);

                    }
                },
                "columns": [
                            { "data": "id" },
                            { "data": "codCliente" },
                            { "data": "dsCliente" },
                            { "data": "dsEstado", "className": "text-center" },
                            { "data": "dsTipoClasificacion", "visible": false },
                            { "data": "dsTipoCliente", "visible": false },
                            { "data": "dsTipoDocumento", "visible": false },
                            { "data": "dsNroDocumento", "visible": false },
                            { "data": "dsRuc", "visible": false },
                            { "data": "dsApellidoPaterno", "visible": false },
                            { "data": "dsApellidoMaterno", "visible": false },
                            { "data": "dsNombres", "visible": false },
                            { "data": "feNacimiento", "visible": false },
                            { "data": "dsDireccion", "visible": false },
                            { "data": "dsTelefono1", "visible": false },
                            { "data": "dsDistrito", "visible": false },
                            { "data": "dsProvincia", "visible": false },
                            { "data": "dsTelefono2", "visible": false },
                            { "data": "dsDepartamento", "visible": false },
                            { "data": "dsPais", "visible": false },
                            { "data": "dsFax", "visible": false },
                            { "data": "dsEmail1", "visible": false },
                            { "data": "dsCodigoPostal", "visible": false },
                            { "data": "dsEmail2", "visible": false },
                            { "data": "codCia", "visible": false },
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
                var feNacimiento = linksoft.util.parseJsonDate(d.feNacimiento);

                $('#txtCodigo').val(d.codCliente);
                $('#ddlClasificacion').val(d.dsTipoClasificacion);
                $('#txtNroDocumento').val(d.dsNroDocumento);
                $('#ddlTipoPersona').val(d.dsTipoCliente);
                $('#ddlTipoDocumento').val(d.dsTipoDocumento);
                $('#txtDescripcion').val(d.dsCliente);
                $('#txtPaterno').val(d.dsApellidoPaterno);
                $('#txtMaterno').val(d.dsApellidoMaterno);
                $('#txtNombres').val(d.dsNombres);
                $('#txtFechaNacimiento').val(d.feNacimiento);
                $('#txtRuc').val(d.dsRuc);
                $('#ddlEstado').val(d.dsEstado);
                $('#txtDireccion').val(d.dsDireccion);
                $('#txtTelefono1').val(d.dsTelefono1);
                $('#txtDistrito').val(d.dsDistrito);
                $('#txtProvincia').val(d.dsProvincia);
                $('#txtTelefono2').val(d.dsTelefono2);
                $('#txtDepartamento').val(d.dsDepartamento);
                $('#txtPais').val(d.dsPais);
                $('#txtFax').val(d.dsFax);
                $('#txtEmail1').val(d.dsEmail1);
                $('#txtCodigoPostal').val(d.dsCodigoPostal);
                $('#txtEmail2').val(d.dsEmail2);

            });
        }

        function Guardar() {
            var objCliente = {};

            objCliente.codCliente = $('#txtCodigo').val().trim();
            objCliente.dsCliente = $('#txtDescripcion').val().trim();
            objCliente.dsTipoClasificacion = $('#ddlClasificacion').val().trim();
            objCliente.dsTipoCliente = $('#ddlTipoPersona').val().trim();
            objCliente.dsTipoDocumento = $('#ddlTipoDocumento').val().trim();
            objCliente.dsNroDocumento = $('#txtNroDocumento').val().trim();
            objCliente.dsRuc = $('#txtRuc').val().trim();
            objCliente.dsApellidoPaterno = $('#txtPaterno').val().trim();
            objCliente.dsApellidoMaterno = $('#txtMaterno').val().trim();
            objCliente.dsNombres = $('#txtNombres').val().trim();
            objCliente.feNacimiento = $('#txtFechaNacimiento').val().trim();
            objCliente.dsDireccion = $('#txtDireccion').val().trim();
            objCliente.dsTelefono1 = $('#txtTelefono1').val().trim();
            objCliente.dsDistrito = $('#txtDistrito').val().trim();
            objCliente.dsProvincia = $('#txtProvincia').val().trim();
            objCliente.dsTelefono2 = $('#txtTelefono2').val().trim();
            objCliente.dsDepartamento = $('#txtDepartamento').val().trim();
            objCliente.dsPais = $('#txtPais').val().trim();
            objCliente.dsFax = $('#txtFax').val().trim();
            objCliente.dsEmail1 = $('#txtEmail1').val().trim();
            objCliente.dsCodigoPostal = $('#txtCodigoPostal').val().trim();
            objCliente.dsEmail2 = $('#txtEmail2').val().trim();
            objCliente.dsEstado = $('#ddlEstado').val().trim();
            objCliente.Accion = Accion;

            var clienteParam = {
                Metodo: 'Guardar',
                Cliente: JSON.stringify(objCliente)
            };


            linksoft.util.ajaxCallback(clienteURL, clienteParam, function (response) {
                if (response.mensaje == 'SUCCESS') {
                    var msg = '';
                    if (Accion == 'add') {
                        msg = 'Se registró el cliente correctamente.';
                    } else if (Accion == 'edit') {
                        msg = 'Se actualizó el cliente correctamente.';
                    } else if (Accion == 'del') {
                        msg = 'Se eliminó el cliente correctamente.';
                    }
                    linksoft.util.showMessage(msg, 'alert-success');
                    linksoft.util.defaultLoad('regCliente');
                } else {
                    linksoft.util.showMessage('Error al guardar.', 'alert-danger');
                }

            });
        
        }

        
    </script>
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="mainContent" runat="server">
    <div class="tab-pane" id="tabMain">
        <div class="panel panel-primary">
            <div class="panel panel-heading">
                    <h4 class="panel-title">Registro de Cliente</h4>
            </div>
            <div class="panel panel-body" id="regCliente">
                <div class="row">
                    <div class="col-xs-4">
                        <label>Codigo</label>
                        <input type="text" class="form-control" id="txtCodigo" readonly="readonly" maxlength="11"/>
                    </div>
                    <div class="col-xs-4">
                        <label >Clasificación</label>
                        <select class="form-control input-sm" id="ddlClasificacion" disabled="disabled">
                            <option value="C" >Cliente</option>
                        </select>
                    </div>
                    <div class="col-xs-4">
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-4">
                        <label>Documento</label>
                        <input type="text" class="form-control" id="txtNroDocumento" readonly="readonly" maxlength="12"/>
                    </div>
                    <div class="col-xs-4">
                        <label >Tipo Persona</label>
                        <select class="form-control input-sm" id="ddlTipoPersona" disabled="disabled">
                            <option value="01" >Natural</option>
                            <option value="02" >Jurídica</option>
                            <option value="03" >No Docimiliado</option>
                        </select>
                    </div>
                    <div class="col-xs-4">
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-4">
                        <label >Tipo Doc.</label>
                        <select class="form-control input-sm" id="ddlTipoDocumento" disabled="disabled">
                            <option value="01" >DNI</option>
                            <option value="02" >Carnet FF. Policiales</option>
                            <option value="03" >Carnet FF. Armadas</option>
                            <option value="04" >Carnet Extranjería</option>
                            <option value="06" >RUC</option>
                            <option value="07" >Pasaporte</option>
                            <option value="00" >Sin Documento</option>
                        </select>
                    </div>
                    <div class="col-xs-8">
                        <label>Descripción</label>
                        <input type="text" class="form-control" id="txtDescripcion" readonly="readonly" maxlength="80"/>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-4">
                        <label>RUC</label>
                        <input type="text" class="form-control" id="txtRuc" readonly="readonly" maxlength="11"/>
                    </div>
                    <div class="col-xs-8">
                        <label>Apellido Paterno</label>
                        <input type="text" class="form-control" id="txtPaterno" readonly="readonly" maxlength="50"/>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-4">
                        <label>Fecha Nac.</label>
                        <input type="text" class="form-control" id="txtFechaNacimiento" readonly="readonly" maxlength="10"/>
                    </div>
                    <div class="col-xs-8">
                        <label>Apellido Materno</label>
                        <input type="text" class="form-control" id="txtMaterno" readonly="readonly" maxlength="50"/>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-4">
                        <label>Estado</label>
                        <select class="form-control input-sm" id="ddlEstado" disabled="disabled">
                            <option value="A" >Activo</option>
                            <option value="I" >Inactivo</option>
                        </select>
                    </div>
                    <div class="col-xs-8">
                        <label>Nombres</label>
                        <input type="text" class="form-control" id="txtNombres" readonly="readonly" maxlength="50" />
                    </div>
                </div>
                <hr />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Dirección</label>
                        <input type="text" class="form-control" id="txtDireccion" readonly="readonly" maxlength="200" />
                    </div>
                    <div class="col-xs-4">
                        <label>Telefono 1</label>
                        <input type="text" class="form-control" id="txtTelefono1" readonly="readonly" maxlength="25"/>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-4">
                        <label>Distrito/Ciudad</label>
                        <input type="text" class="form-control" id="txtDistrito" readonly="readonly" maxlength="30"/>
                    </div>
                    <div class="col-xs-4">
                        <label>Provincia</label>
                        <input type="text" class="form-control" id="txtProvincia" readonly="readonly" maxlength="30"/>
                    </div>
                    <div class="col-xs-4">
                        <label>Telefono 2</label>
                        <input type="text" class="form-control" id="txtTelefono2" readonly="readonly" maxlength="30"/>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-4">
                        <label>Dpto./Estado</label>
                        <input type="text" class="form-control" id="txtDepartamento" readonly="readonly" maxlength="30"/>
                    </div>
                    <div class="col-xs-4">
                        <label>País</label>
                        <input type="text" class="form-control" id="txtPais" readonly="readonly" maxlength="30"/>
                    </div>
                    <div class="col-xs-4">
                        <label>Fax</label>
                        <input type="text" class="form-control" id="txtFax" readonly="readonly" maxlength="100"/>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Email 1</label>
                        <input type="text" class="form-control" id="txtEmail1" readonly="readonly" maxlength="50"/>
                    </div>
                    <div class="col-xs-4">
                        <label>Código Postal</label>
                        <input type="text" class="form-control" id="txtCodigoPostal" readonly="readonly" maxlength="7"/>
                    </div>
                </div>
                <br />
                <div class="row">
                    <div class="col-xs-8">
                        <label>Email 2</label>
                        <input type="text" class="form-control" id="txtEmail2" readonly="readonly" maxlength="50"/>
                    </div>
                    <div class="col-xs-4">
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
    <div class="tab-pane" id="tabListado">
        <div class="panel panel-primary">
            <div class="panel panel-heading">
                    <h4 class="panel-title">Listado de Clientes</h4>
            </div>
            <table id="tablaListado" class="display" cellspacing="0" width="100%">
                <thead>
                    <tr>
                        <th>Id</th>
                        <th>Código</th>
                        <th>Descripción</th>
                        <th>Estado</th>
                        <th>Tipo Clasificación</th>
                        <th>Tipo Cliente</th>
                        <th>Tipo Documento</th>
                        <th>Nro. Documento</th>
                        <th>Ruc</th>
                        <th>Apellido Paterno</th>
                        <th>Apellido Materno</th>
                        <th>Nombres</th>
                        <th>Fecha Nacimiento</th>
                        <th>Direccion</th>
                        <th>Telefono 1</th>
                        <th>Distrito</th>
                        <th>Provincia</th>
                        <th>Telefono 2</th>
                        <th>Departamento</th>
                        <th>Pais</th>
                        <th>Fax</th>
                        <th>Email 1</th>
                        <th>Codigo Postal</th>
                        <th>Email 2</th>
                        <th>Cia</th>
                        <th>Usu. Crea.</th>
                        <th>Fecha Crea.</th>
                        <th>Usu. Modif.</th>
                        <th>Fecha Modif.</th>
                    </tr>
                </thead>
            </table>
        </div>
    </div>
</asp:Content>
