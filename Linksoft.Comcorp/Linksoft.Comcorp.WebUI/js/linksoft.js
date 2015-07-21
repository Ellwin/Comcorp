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
    setToolbar: function (panelFormSelector, jqGridSelector, callback) {
        var $obj = $('#' + panelFormSelector + ' input,' + '#' + panelFormSelector + ' select');

        $("#btnNuevo").click(function () {

            $obj.each(function () {
                var $control = $(this);
                var $type = $control.attr('type');

                if ($type == 'text' || $type == 'password') {

                    $control.val('');
                    $control.attr('readonly', false);

                }
                if ($type == 'checkbox' || $type == 'radio') {

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
            $("#btnCancelar").attr('disabled', false);

            $("#btnPrimero").attr('disabled', true);
            $("#btnAnterior").attr('disabled', true);
            $("#btnSiguiente").attr('disabled', true);
            $("#btnUltimo").attr('disabled', true);

            $('a[href="#tabMain"]').tab('show');

            $('#tabMain').find(':input:first').focus();

            Accion = 'add';
        });

        $("#btnEditar").click(function () {

            $("#btnRefrescar").attr('disabled', true);
            $("#btnNuevo").attr('disabled', true);
            $("#btnEditar").attr('disabled', true);
            $("#btnGuardar").attr('disabled', false);
            $("#btnDeshacer").attr('disabled', false);
            $("#btnEliminar").attr('disabled', true);
            $("#btnCancelar").attr('disabled', false);

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
                if ($type == 'checkbox' || $type == 'radio') {

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

        $("#btnCancelar").click(function () {

            $("#btnRefrescar").attr('disabled', false);
            $("#btnNuevo").attr('disabled', false);
            $("#btnEditar").attr('disabled', false);
            $("#btnGuardar").attr('disabled', true);
            $("#btnDeshacer").attr('disabled', true);
            $("#btnEliminar").attr('disabled', false);
            $("#btnCancelar").attr('disabled', true);

            $("#btnPrimero").attr('disabled', false);
            $("#btnAnterior").attr('disabled', false);
            $("#btnSiguiente").attr('disabled', false);
            $("#btnUltimo").attr('disabled', false);

            $obj.each(function () {

                var $control = $(this);
                var $type = $control.attr('type');

                if ($type == 'text' || $type == 'password') {

                    $control.val('');
                    $control.attr('readonly', true);

                }
                if ($type == 'checkbox' || $type == 'radio') {
                    $control.attr('disabled', true);
                }

                if ($control.is('select')) {

                    $control.attr('disabled', true);
                }

            });


            Accion = '';

            callback();

        });

        $("#btnRefrescar").click(function () {
            callback();
        });

        $('#btnPrimero').click(function () {
            linksoft.util.firstRow(jqGridSelector);
        });

        $('#btnAnterior').click(function () {
            linksoft.util.previousRow(jqGridSelector);
        });

        $('#btnSiguiente').click(function () {
            linksoft.util.nextRow(jqGridSelector);
        });

        $('#btnUltimo').click(function () {
            linksoft.util.lastRow(jqGridSelector);
        });
    },
    nextRow: function (selector) {
        var ids = $("#" + selector).jqGrid("getDataIDs");
        var selectedRow = $("#" + selector).jqGrid("getGridParam", "selrow");
        var curr_index = 0;

        for (var i = 0; i < ids.length; i++) {
            if (ids[i] == selectedRow)
                curr_index = i;
        }

        if ((curr_index + 1) < ids.length)
            $("#" + selector).jqGrid("setSelection", ids[curr_index + 1]);
    },
    previousRow: function (selector) {

        var ids = $("#" + selector).jqGrid("getDataIDs");
        var selectedRow = $("#" + selector).jqGrid("getGridParam", "selrow");
        var curr_index = 0;

        for (var i = 0; i < ids.length; i++) {
            if (ids[i] == selectedRow)
                curr_index = i;
        }

        if ((curr_index - 1) >= 0)
            $("#" + selector).jqGrid("setSelection", ids[curr_index - 1]);
    },
    firstRow: function (selector) {
        var ids = $("#" + selector).jqGrid("getDataIDs");

        $("#" + selector).jqGrid("setSelection", ids[0]);
    },
    lastRow: function (selector) {
        var ids = $("#" + selector).jqGrid("getDataIDs");
        var last = ids.length - 1;

        $("#" + selector).jqGrid("setSelection", ids[last]);
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
    }
};



