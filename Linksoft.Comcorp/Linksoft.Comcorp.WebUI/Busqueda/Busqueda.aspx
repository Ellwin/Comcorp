<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Busqueda.aspx.vb" Inherits="Linksoft.Comcorp.WebUI.Busqueda" %>

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
    
    <script type="text/javascript">
        function retornarValor(busqueda, codigo, descripcion) {
            parent.cargarItem(busqueda, codigo, descripcion);
            return false;
        }
    </script>

    <style type="text/css">
       .table {font-size: 11px }                
    </style>
</head>
<body>
    <form id="form2" runat="server">
    <div >
        <asp:ScriptManager ID="ScriptManager1" runat="server" EnablePartialRendering="true" />
        <div class="panel panel-default">
            <div class="panel-heading">
                <div class="row">
                        <div class="col-xs-3">
                            <asp:TextBox runat="server" ID="txtCodigo" CssClass="form-control input-sm" placeholder="Codigo"></asp:TextBox>
                        </div>
                        <div class="col-xs-6">
                            <asp:TextBox runat="server" ID="txtDescripcion" CssClass="form-control input-sm" placeholder="Descripción"></asp:TextBox>
                        </div>
                        <div class="col-xs-2">
                            <asp:Button ID="btnBuscar" runat="server" Text="Buscar" CssClass="btn btn-info btn-sm"/>
                        </div>
                    </div>
            </div>
                <div class="panel-body">
                     
                </div>
                <asp:UpdatePanel ID="upBusqueda" runat="server">
                    <ContentTemplate>
                        <asp:GridView runat="server" ID="gvBusqueda" AutoGenerateColumns="False"
                                                EmptyDataText="No se encontraron registros." 
                                                CssClass="table table-bordered table-striped" AllowPaging="True" PageSize="7">
                                            <Columns>
                                                <asp:BoundField DataField="codigo" HeaderText="Codigo" ItemStyle-HorizontalAlign="Left" />
                                                <asp:BoundField DataField="descripcion" HeaderText="Descripcion" ItemStyle-HorizontalAlign="Left" />
                                                <asp:TemplateField>
                                                    <ItemTemplate>
                                                        <asp:Button ID="btnSeleccionar" runat="server" Text="Seleccionar" CssClass="btn btn-link btn-xs"></asp:Button>
                                                    </ItemTemplate>
                                                </asp:TemplateField>
                                            </Columns>
                            </asp:GridView>
                     </ContentTemplate>
                    <Triggers>
                        <asp:AsyncPostBackTrigger controlID="btnBuscar" EventName="Click"/>
                        <asp:AsyncPostBackTrigger ControlID="gvBusqueda" EventName="PageIndexChanging"/>
                    </Triggers>                        
                </asp:UpdatePanel>
        </div>
    </div>
    </form>
    <script src="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>js/jsUpdateProgress.js" type="text/javascript"></script>
</body>
</html>
