$(document).ready(function () { showProgress(); });
function showProgress() {
    
    Sys.WebForms.PageRequestManager.getInstance().add_beginRequest(function() {
        $.blockUI({
            message: 'Procesando...  <br /> <img src="' + baseURL + 'img/loading.gif" />',
            theme: false,
            baseZ: 1000,
            css: {
                width:'300px',
                border: 'none',
                padding: '10px',
                '-webkit-border-radius': '10px',
                '-moz-border-radius': '10px',
                opacity: .6,
                color: '#000',
                'font-size': '10pt',
                'font-weight': 'bold'
            }
        });
    });
    Sys.WebForms.PageRequestManager.getInstance().add_endRequest(function() {
        $.unblockUI();
    });

}  