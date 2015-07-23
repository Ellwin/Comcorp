Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.BusinessLogic
Imports Linksoft.Framework.Common

Public Class Numerador
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Session(Constantes.USUARIO_SESION) Is Nothing Then

            If Not Page.IsPostBack Then
                Dim strCatDoc As String = Convert.ToString(Request.QueryString("cat")).Trim
                Dim objSesionLogin As BE_SesionLogin = CType(Session(Constantes.USUARIO_SESION), BE_SesionLogin)

                Buscar(strCatDoc, objSesionLogin.codCia)
            End If
        Else
            Response.Redirect(WebUtil.AbsoluteWebRoot.ToString & "Login.aspx")
        End If
    End Sub

    Private Sub Buscar(ByVal strCatDoc As String, ByVal strCia As String)
        Dim lstNumerador As New List(Of BE_Numerador)
        lstNumerador = BL_Numerador.ListarNumerador(strCatDoc, strCia)

        gvBusqueda.DataSource = lstNumerador
        gvBusqueda.DataBind()

    End Sub

    Private Sub gvBusqueda_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvBusqueda.PageIndexChanging
        Dim strCatDoc As String = Convert.ToString(Request.QueryString("cat")).Trim
        Dim objSesionLogin As BE_SesionLogin = CType(Session(Constantes.USUARIO_SESION), BE_SesionLogin)

        gvBusqueda.PageIndex = e.NewPageIndex

        Buscar(strCatDoc, objSesionLogin.codCia)
    End Sub

    Private Sub gvBusqueda_RowDataBound(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewRowEventArgs) Handles gvBusqueda.RowDataBound
        If e.Row.RowType = DataControlRowType.DataRow Then
            Dim btn As Button = CType(e.Row.FindControl("btnSeleccionar"), Button)
            btn.OnClientClick = "javascript:retornarValor('" + DataBinder.Eval(e.Row.DataItem, "dsTipoDoc") + "','" + DataBinder.Eval(e.Row.DataItem, "dsSerie") + "');"
        End If
    End Sub
End Class