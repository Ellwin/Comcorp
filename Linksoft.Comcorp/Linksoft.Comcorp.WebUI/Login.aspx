<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Login.aspx.vb" Inherits="Linksoft.Comcorp.WebUI.Login" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title>Login</title>
    <link href="~/css/jquery-ui.min.css" rel="stylesheet" type="text/css" />
    <link href="~/css/jquery-ui.theme.min.css" rel="stylesheet" type="text/css" />
    <link href="~/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
     <link href="~/css/Site.css" rel="stylesheet" type="text/css" />

     <script type="text/javascript">
         var baseURL = "<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>";
    </script>

     <script src="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>js/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script src="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>js/jquery-ui.js" type="text/javascript"></script>
     <script src="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>js/bootstrap.js" type="text/javascript"></script>
    <script src="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>js/jquery.blockUI.js" type="text/javascript"></script>

    <script type="text/javascript">
        $(document).ready(function () {
            
            Sys.WebForms.PageRequestManager.getInstance().add_pageLoaded(function (evt, args) {
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
                $('#txtFecha').datepicker();

                $('form input').keydown(function (event) {
                    if (event.keyCode == 13) {
                        event.preventDefault();
                        return false;
                    }
                });


                $('#btnCerrar').click(function () {
                    $('.modal-backdrop').remove();
                });
            });

        })
        
        function mostrarMensaje(message, alertType) {
            $('#message').append('<div id="alertdiv" class="alert ' + alertType + '"><a class="close" data-dismiss="alert">×</a><span>' + message + '</span></div>')

            setTimeout(function () { $("#alertdiv").remove(); }, 5000);
        }

        function mostrarMensajeModal(message, alertType) {
            $('.modal-body').append('<div id="messageModal"></div>');
            $('#messageModal').append('<div id="alertdiv" class="alert ' + alertType + '"><a class="close" data-dismiss="alert">×</a><span>' + message + '</span></div>')

            setTimeout(function () { $("#alertdiv").remove(); }, 5000);
        }
    </script>
</head>
<body>
    <nav class="navbar navbar-default navbar-fixed-top">
        <div class="container-fluid">
            <div class="navbar-header">
                <a class="navbar-brand" href="#">
                <img src="img/logo.png" alt="linksoft" width="100px" height="50px"/>
                </a>
            </div>    
        </div>
    </nav>
    <div class="container">    
        
        <div id="loginbox" style="margin-top:50px;" class="mainbox col-md-6 col-md-offset-3 col-sm-8 col-sm-offset-2">                    
            <div id="message"></div>
            <div class="panel panel-info" >
                    <div class="panel-heading">
                        <div class="panel-title">Login</div>
                    </div>     

                    <div style="padding-top:30px" class="panel-body" >

                        <div style="display:none" id="login-alert" class="alert alert-danger col-sm-12"></div>
                        
                        <form id="loginform" class="form-horizontal" role="form" runat="server"> 
                        <asp:ScriptManager ID="ScriptManager1" runat="server"></asp:ScriptManager>
                        <script type="text/javascript" language="javascript">
                            Sys.WebForms.PageRequestManager.getInstance().add_endRequest(EndRequestHandler);
                            function EndRequestHandler(sender, args) {
                                if (args.get_error() != undefined) {
                                    args.set_errorHandled(true);
                                }
                            }
                        </script>
                        <asp:UpdatePanel ID="UpdatePanel1" runat="server"> 
                            <ContentTemplate>                              
                                <div style="margin-bottom: 25px" class="input-group">
                                    <span class="input-group-addon"><i class="glyphicon glyphicon-user"></i></span>
                                            <asp:TextBox ID="txtUsuario" CssClass="form-control" name="username" placeholder="usuario" runat="server"></asp:TextBox>
                                </div>
                                
                                <div style="margin-bottom: 25px" class="input-group">
                                            <span class="input-group-addon"><i class="glyphicon glyphicon-lock"></i></span>
                                            <asp:TextBox ID="txtPassword" TextMode="Password" CssClass="form-control" name="password" placeholder="password" runat="server"></asp:TextBox>
                                </div>   
                                <asp:Button ID="btnIngresar" CssClass="btn btn-lg btn-primary btn-block" runat="server" Text="Ingresar" />
                                    
                                <!-- Modal -->
                                <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
                                  <div class="modal-dialog" role="document">
                                    <div class="modal-content">
                                      <div class="modal-header">
                                        <h4 class="modal-title" id="myModalLabel">Datos de la Empresa</h4>
                                      </div>
                                      <div class="modal-body">
                                                                                
                                        <div class="row" style="margin-bottom: 25px">
                                            <div class="col-xs-3">
                                                <label>Código:</label>
                                                <asp:TextBox ID="txtCodCompania" AutoPostBack="true" CssClass="form-control upper" name="compania" placeholder="compania" runat="server" MaxLength="3"></asp:TextBox>
                                            </div>
                                            <div class="col-xs-9">
                                                <label>Compañía:</label>
                                                <asp:TextBox ID="txtCompania" CssClass="form-control" runat="server" ReadOnly="true"></asp:TextBox>
                                            </div>                                                    
                                        </div>
                                        <div class="row" style="margin-bottom: 25px" >
                                            <div class="col-xs-7">
                                                <label >Sucursal:</label>
                                                <asp:DropDownList ID="ddlSucursal" CssClass="form-control input-sm" runat="server">
                                                </asp:DropDownList>
                                            </div>
                                            <div class="col-xs-5">
                                                <label>Fecha:</label>
                                                <asp:TextBox ID="txtFecha" CssClass="form-control" name="fecha" placeholder="fecha" runat="server" ReadOnly="true"></asp:TextBox>
                                            </div>
                                        </div>                                      
                                      </div>
                                      <div class="modal-footer">
                                        <button type="button" id="btnCerrar" class="btn btn-default" data-dismiss="modal" runat="server">Cerrar</button>
                                        <asp:Button ID="btnIniciarSesion" runat="server" Text="Acceder" 
                                                    CssClass="btn btn-primary" onclick="btnIniciarSesion_Click"/>
                                      </div>
                                    </div>
                                  </div>
                                </div>
                                    
                                			                    
                        </ContentTemplate>
                        <Triggers>
                            <asp:AsyncPostBackTrigger ControlID="txtCodCompania" EventName="TextChanged" />
                            <asp:AsyncPostBackTrigger ControlID="btnIniciarSesion" EventName="Click" />    
                        </Triggers>
                    </asp:UpdatePanel>
                    </form>     
                    <script src="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>js/jsUpdateProgress.js" type="text/javascript"></script>
                  </div>                  
               </div>                     
           </div>  
        </div>

</body>
</html>
