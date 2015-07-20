<%@ Page Language="vb" AutoEventWireup="false" CodeBehind="Busqueda.aspx.vb" Inherits="Linksoft.Comcorp.WebUI.Busqueda" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
    <title></title>
    <link href="~/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <link href="~/css/Site.css" rel="stylesheet" type="text/css" />
      
    <script src="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>js/jquery-1.11.2.min.js" type="text/javascript"></script>
    <script src="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>js/bootstrap.js" type="text/javascript"></script>
    <script src="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>js/jquery.blockUI.js" type="text/javascript"></script>
    <script src="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>js/jsUpdateProgress.js" type="text/javascript"></script>

    <style type="text/css">
       .table {
                font-size: 12px 
                } 
        
    </style>
</head>
<body>
    <form id="form1" runat="server">
    <asp:ScriptManager ID="ScriptManager2" runat="server" ></asp:ScriptManager>
    <div class="modal-dialog">
        <div class="panel panel-primary">
            <div class="panel-heading">Busqueda</div>
                <div class="panel-body">
                    <div class="row">
                        <div class="col-xs-3">
                            <input type="text" class="form-control" id="txtCodigo" placeholder="Codigo" />
                        </div>
                        <div class="col-xs-6">
                            <input type="text" class="form-control" id="txtDescripcion" placeholder="Descripcion"/>
                        </div>
                        <div class="col-xs-2">
                            <button class="btn btn-info" type="button"><span class="glyphicon glyphicon-arrow-right"></span> Buscar</button>
                        </div>
                    </div>
                    <hr />
                    <div class="row">
                        <div class="col-xs-11">
                            <asp:UpdatePanel ID="upBusqueda" runat="server">
                                <ContentTemplate>
                                    <asp:GridView runat="server" ID="gvBusqueda" AutoGenerateColumns="False"
                                     DataKeyNames="codigo" EmptyDataText="No se encontraron registros." 
                                     CssClass="table table-bordered table-striped" AllowPaging="True" PageSize="10">
                                    <Columns>
                                        <asp:BoundField DataField="codigo" HeaderText="Codigo" ItemStyle-HorizontalAlign="Left" />
                                        <asp:BoundField DataField="descripcion" HeaderText="Descripcion" ItemStyle-HorizontalAlign="Left" />
                                        <asp:TemplateField>
                                            <ItemTemplate>
                                                <asp:LinkButton ID="lbSeleccionar" runat="server" Text="Seleccionar"></asp:LinkButton>
                                            </ItemTemplate>
                                        </asp:TemplateField>
                                    </Columns>
                                    </asp:GridView>
                                </ContentTemplate>
                                <Triggers>
                            
                                    <asp:AsyncPostBackTrigger ControlID="gvBusqueda" EventName="PageIndexChanging"/>
                                </Triggers>
                            </asp:UpdatePanel>
                        </div>
                    </div>
                </div>
        </div>
    </div>
    </form>
</body>
</html>
