Number.prototype.formatMoney = function (c, d, t) {
    var n = this, c = isNaN(c = Math.abs(c)) ? 2 : c, d = d == undefined ? "," : d, t = t == undefined ? "." : t, s = n < 0 ? "-" : "", i = parseInt(n = Math.abs(+n || 0).toFixed(c)) + "", j = (j = i.length) > 3 ? j % 3 : 0;
    return s + (j ? i.substr(0, j) + t : "") + i.substr(j).replace(/(\d{3})(?=\d)/g, "$1" + t) + (c ? d + Math.abs(n - i).toFixed(c).slice(2) : "");
};

$(document).ajaxSend(function () {
    if (!pageBlocked) {
        $.blockUI({
            message: 'Procesando...  <br /> <img src="../img/loading.gif" />',
            theme: false,
            baseZ: 2000,
            css: {
                border: 'none',
                padding: '20px',
                '-webkit-border-radius': '10px',
                '-moz-border-radius': '10px',
                opacity: .6,
                color: '#000',
                'font-size': '12pt',
                'font-weight': 'bold'
            }
        });
    }
}).ajaxStop(function () {
    jQuery.unblockUI();
    pageBlocked = false;
});

$.ajaxSetup({
    cache: false
});

var pageBlocked = false;
var Accion = '';
var linksoft = linksoft || {};

linksoft.util = {
    ajaxCallback: function (url, args, callback) {
        $.ajax({
            type: "post",
            url: url,
            data: args,
            success: function (response) {
                callback(response);
            },
            failure: function (response) {
                callback(response);
            }
        });
    },
    setToolbar: function (panelFormSelector, callback) {
        var $obj = $('#' + panelFormSelector + ' input,' + '#' + panelFormSelector + ' select,' + '#' + panelFormSelector + ' button');

        $("#btnNuevo").click(function () {

            $obj.each(function () {
                var $control = $(this);
                var $type = $control.attr('type');

                if ($type == 'text' || $type == 'password' || $type == 'hidden') {

                    $control.val('');
                    $control.attr('readonly', false);

                }
                if ($type == 'checkbox' || $type == 'radio' || $type == 'button') {

                    $control.attr('checked', false);
                    $control.attr('disabled', false);
                }

                if ($control.is('select')) {

                    $control.attr('disabled', false);
                }

            });

            $("#btnNuevo").attr('disabled', true);
            $("#btnRefrescar").attr('disabled', true);
            $("#btnEditar").attr('disabled', true);
            $("#btnGuardar").attr('disabled', false);
            $("#btnDeshacer").attr('disabled', false);
            $("#btnEliminar").attr('disabled', true);

            $("#btnPrimero").attr('disabled', true);
            $("#btnAnterior").attr('disabled', true);
            $("#btnSiguiente").attr('disabled', true);
            $("#btnUltimo").attr('disabled', true);

            $('a[href="#tabMain"]').tab('show');

            $('#tabMain').find(':input:first').focus();

            Accion = 'add';

            callback();
        });

        $("#btnEditar").click(function () {

            $("#btnRefrescar").attr('disabled', true);
            $("#btnNuevo").attr('disabled', true);
            $("#btnEditar").attr('disabled', true);
            $("#btnGuardar").attr('disabled', false);
            $("#btnDeshacer").attr('disabled', false);
            $("#btnEliminar").attr('disabled', true);

            $("#btnPrimero").attr('disabled', true);
            $("#btnAnterior").attr('disabled', true);
            $("#btnSiguiente").attr('disabled', true);
            $("#btnUltimo").attr('disabled', true);

            $obj.each(function () {
                var $control = $(this);
                var $type = $control.attr('type');

                if ($type == 'text' || $type == 'password') {

                    $control.attr('readonly', false);

                }
                if ($type == 'checkbox' || $type == 'radio' || $type == 'button') {

                    $control.attr('disabled', false);
                }

                if ($control.is('select')) {

                    $control.attr('disabled', false);
                }

            });

            $('a[href="#tabMain"]').tab('show');

            $('#tabMain').find(':input:first').focus();

            Accion = 'edit';
        });

        $("#btnEliminar").click(function () {
            Accion = 'del';
        });

        $("#btnDeshacer").click(function () {

            $("#btnRefrescar").attr('disabled', false);
            $("#btnNuevo").attr('disabled', false);
            $("#btnEditar").attr('disabled', false);
            $("#btnGuardar").attr('disabled', true);
            $("#btnDeshacer").attr('disabled', true);
            $("#btnEliminar").attr('disabled', false);

            $("#btnPrimero").attr('disabled', false);
            $("#btnAnterior").attr('disabled', false);
            $("#btnSiguiente").attr('disabled', false);
            $("#btnUltimo").attr('disabled', false);

            $obj.each(function () {

                var $control = $(this);
                var $type = $control.attr('type');

                if ($type == 'text' || $type == 'password' || $type == 'hidden') {

                    $control.val('');
                    $control.attr('readonly', true);

                }
                if ($type == 'checkbox' || $type == 'radio' || $type == 'button') {
                    $control.attr('disabled', true);
                }

                if ($control.is('select')) {

                    $control.attr('disabled', true);
                }

            });

            Accion = '';

            linksoft.util.reloadListado();
        });

        $("#btnRefrescar").click(function () {
            linksoft.util.reloadListado();
        });

        $('#btnPrimero').click(function () {
            linksoft.util.firstRow();
        });

        $('#btnAnterior').click(function () {
            linksoft.util.previousRow();
        });

        $('#btnSiguiente').click(function () {
            linksoft.util.nextRow();
        });

        $('#btnUltimo').click(function () {
            linksoft.util.lastRow();
        });
    },
    defaultLoad: function (panelFormSelector) {
        var $obj = $('#' + panelFormSelector + ' input,' + '#' + panelFormSelector + ' select,' + '#' + panelFormSelector + ' button');

        $("#btnRefrescar").attr('disabled', false);
        $("#btnNuevo").attr('disabled', false);
        $("#btnEditar").attr('disabled', false);
        $("#btnGuardar").attr('disabled', true);
        $("#btnDeshacer").attr('disabled', true);
        $("#btnEliminar").attr('disabled', false);

        $("#btnPrimero").attr('disabled', false);
        $("#btnAnterior").attr('disabled', false);
        $("#btnSiguiente").attr('disabled', false);
        $("#btnUltimo").attr('disabled', false);

        $obj.each(function () {

            var $control = $(this);
            var $type = $control.attr('type');

            if ($type == 'text' || $type == 'password' || $type == 'hidden') {

                $control.val('');
                $control.attr('readonly', true);

            }
            if ($type == 'checkbox' || $type == 'radio' || $type == 'button') {
                $control.attr('disabled', true);
            }

            if ($control.is('select')) {

                $control.attr('disabled', true);
            }

        });

        Accion = '';

        linksoft.util.reloadListado();
    },
    nextRow: function () {
        var table = $("#tablaListado").DataTable();
        var rowSelected = table.row().$('tr.selected');
        var rowIndex = rowSelected.index();
        rowSelected.removeClass('selected');
        table.row(rowIndex).$(rowSelected).next('tr').click();
    },
    previousRow: function () {
        var table = $("#tablaListado").DataTable();
        var rowSelected = table.row().$('tr.selected');
        var rowIndex = rowSelected.index();
        rowSelected.removeClass('selected');
        table.row(rowIndex).$(rowSelected).prev('tr').click();
    },
    firstRow: function () {
        var table = $("#tablaListado").DataTable();
        var rowSelected = table.row().$('tr.selected');
        rowSelected.removeClass('selected');
        table.row(0).$('tr:first').click();
    },
    lastRow: function () {
        var table = $("#tablaListado").DataTable();
        var rowSelected = table.row().$('tr.selected');
        rowSelected.removeClass('selected');
        table.row(0).$('tr:last').click();
    },
    reloadListado: function () {
        var table = $('#tablaListado').DataTable();
        table.ajax.reload(function () {
            $('#tablaListado tbody tr:first').click();
        });
    },
    showMessage: function (message, alertType) {
        $('#message').append('<div id="alertdiv" class="alert ' + alertType + '"><a class="close" data-dismiss="alert">×</a><span>' + message + '</span></div>')

        setTimeout(function () {
            $("#alertdiv").remove();
        }, 5000);
    },
    configDatepickerEs: function () {
        $.datepicker.regional['es'] = {
            closeText: 'Cerrar',
            prevText: 'Anterior',
            nextText: 'Siguiente',
            currentText: 'Hoy',
            monthNames: ['Enero', 'Febrero', 'Marzo', 'Abril', 'Mayo', 'Junio', 'Julio', 'Agosto', 'Septiembre', 'Octubre', 'Noviembre', 'Diciembre'],
            monthNamesShort: ['Ene', 'Feb', 'Mar', 'Abr', 'May', 'Jun', 'Jul', 'Ago', 'Sep', 'Oct', 'Nov', 'Dic'],
            dayNames: ['Domingo', 'Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado'],
            dayNamesShort: ['Dom', 'Lun', 'Mar', 'Mié', 'Juv', 'Vie', 'Sáb'],
            dayNamesMin: ['Do', 'Lu', 'Ma', 'Mi', 'Ju', 'Vi', 'Sá'],
            weekHeader: 'Sem',
            dateFormat: 'dd/mm/yy',
            firstDay: 1,
            isRTL: false,
            showMonthAfterYear: false,
            changeMonth: true,
            changeYear: true,
            showAnim: 'drop',
            yearSuffix: ''
        };
        $.datepicker.setDefaults($.datepicker.regional['es']);
    },
    openModal: function (selectorDiv, selectorFrame, urlFrame, titulo) {
        $('#' + selectorFrame).attr("src", urlFrame);
        $('#' + selectorDiv).dialog({
            title: titulo,
            modal: true,
            height: '500',
            width: '550',
            close: function () {
                $('#' + selectorFrame).attr("src", "");
                $('#' + selectorDiv).dialog('destroy');
            }
        });
    },
    openModalCustomSize: function (selectorDiv, selectorFrame, urlFrame, titulo, alto, ancho) {
        $('#' + selectorFrame).attr("src", urlFrame);
        $('#' + selectorDiv).dialog({
            title: titulo,
            modal: true,
            height: alto,
            width: ancho,
            close: function () {
                $('#' + selectorFrame).attr("src", "");
                $('#' + selectorDiv).dialog('destroy');
            }
        });
    },
    alert: function (msg) {
        $.blockUI({
            theme: true,
            title: 'Linksoft',
            message: '<p>' + msg + '</p>',
            timeout: 1000
        });
    },
    openModalConfirmacion: function (mensaje, callback) {
        $('#message').html(mensaje);
        $('#message').dialog({
            title: 'Confirmación',
            modal: true,
            open: function (event, ui) {
                $(".ui-dialog-titlebar-close").hide();
            },
            close: function () {
                $('#message').html('');
                $('#message').dialog('destroy');
            },
            buttons: {
                "Aceptar": function () {
                    if (typeof (callback) != typeof (undefined))
                        callback();

                    $('#message').html('');
                    $('#message').dialog('destroy');
                },
                "Cancelar": function () {
                    $('#message').html('');
                    $('#message').dialog('destroy');
                }
            }
        });
    },
    getParameterByName: function (name) {
        name = name.replace(/[\[]/, "\\[").replace(/[\]]/, "\\]");
        var regex = new RegExp("[\\?&]" + name + "=([^&#]*)"),
        results = regex.exec(location.search);
        return results === null ? "" : decodeURIComponent(results[1].replace(/\+/g, " "));
    },
    importes: function (selector) {
        var $this = $('#' + selector);
        $this.on('keypress', function (e) {
            if (String.fromCharCode(e.keyCode).match(/[^0-9.]/g)) return false;
        });
    },
    parseJsonDate: function (jsonDate) {
        var dateString = jsonDate.substr(6);
        var currentTime = new Date(parseInt(dateString));
        var month = currentTime.getMonth() + 1;
        var day = currentTime.getDate();
        var year = currentTime.getFullYear();
        var date = day + "/" + month + "/" + year;
        return date;
    }
};



