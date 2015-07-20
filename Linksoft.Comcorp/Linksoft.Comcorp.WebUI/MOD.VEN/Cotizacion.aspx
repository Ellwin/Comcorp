<%@ Page Title="" Language="vb" AutoEventWireup="false" MasterPageFile="~/Site.Master" CodeBehind="Cotizacion.aspx.vb" Inherits="Linksoft.Comcorp.WebUI.Cotizacion" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
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
                          <a data-toggle="modal" class="btn btn-info" href="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>Busqueda/Busqueda.aspx" data-target="#myModal"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</a>
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
                          <a data-toggle="modal" class="btn btn-info" href="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>Busqueda/Busqueda.aspx" data-target="#myModal"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</a>
                       </span>
                       <input type="text" class="form-control" placeholder="Doc." id="txtAlmacen" />
                    </div>
                </div>
                <div class="col-xs-2">
                    <label>Fe. Vencimiento</label>
                    <input type="text" class="form-control input-sm" id="Text4" required/>
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
                          <a data-toggle="modal" class="btn btn-info" href="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>Busqueda/Busqueda.aspx" data-target="#myModal"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</a>
                       </span>
                       <input type="text" class="form-control" placeholder="Doc." id="Text1" />
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
                          <a data-toggle="modal" class="btn btn-info" href="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>Busqueda/Busqueda.aspx" data-target="#myModal"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</a>
                       </span>
                       <input type="text" class="form-control" placeholder="Doc." id="Text2" />
                    </div>
                </div>
            </div>
            <br />
            <div class="row">
                <div class="col-xs-8">
                    <label>Vendedor</label>
                    <div class="input-group"> 
                       <span class="input-group-btn">
                          <a data-toggle="modal" class="btn btn-info" href="<%=Linksoft.Comcorp.WebUI.WebUtil.AbsoluteWebRoot%>Busqueda/Busqueda.aspx" data-target="#myModal"><span class="glyphicon glyphicon-arrow-right"></span>  Buscar</a>
                       </span>
                       <input type="text" class="form-control" placeholder="Doc." id="Text3" />
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
                          <button class="btn btn-info" type="button"><span class="glyphicon glyphicon-arrow-right"></span> Buscar</button>
                       </span>
                       <input type="text" class="form-control" placeholder="Doc." id="Text5" />
                    </div>
                </div>
                <div class="col-xs-2">
                    <label>Tipo Cond.</label>
                    <input type="text" class="form-control input-sm" id="Text7" readonly="readonly" required/>
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
</asp:Content>
