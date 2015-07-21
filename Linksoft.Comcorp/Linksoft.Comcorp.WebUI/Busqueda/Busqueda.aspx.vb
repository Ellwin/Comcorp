Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.BusinessLogic
Imports Linksoft.Framework.Common


Public Class Busqueda
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Session(Constantes.USUARIO_SESION) Is Nothing Then

            If Not Page.IsPostBack Then
                Dim strTipo As String = Convert.ToString(Request.QueryString("tipo")).Trim
                Dim strValor As String = Convert.ToString(Request.QueryString("valor")).Trim
                Dim objSesionLogin As BE_SesionLogin = CType(Session(Constantes.USUARIO_SESION), BE_SesionLogin)

                Buscar(strTipo, strValor, objSesionLogin.codCia)
            End If
        Else
            Response.Redirect(WebUtil.AbsoluteWebRoot.ToString & "Login.aspx")
        End If

    End Sub

    Private Sub Buscar(ByVal strTipo As String, ByVal strValor As String, ByVal strCia As String)
        Dim lstItem As New List(Of BE_Item)
        lstItem = BL_Item.ListarItemQuery(strTipo, strValor, strCia)

        gvBusqueda.DataSource = lstItem
        gvBusqueda.DataBind()

    End Sub

    Private Sub gvBusqueda_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvBusqueda.PageIndexChanging
        Dim strTipo As String = Convert.ToString(Request.QueryString("tipo")).Trim
        Dim strValor As String = Convert.ToString(Request.QueryString("valor")).Trim
        Dim objSesionLogin As BE_SesionLogin = CType(Session(Constantes.USUARIO_SESION), BE_SesionLogin)

        gvBusqueda.PageIndex = e.NewPageIndex

        Buscar(strTipo, strValor, objSesionLogin.codCia)
    End Sub
End Class