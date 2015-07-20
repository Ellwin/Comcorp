Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.BusinessLogic


Public Class Busqueda
    Inherits System.Web.UI.Page

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            Buscar()
        End If
    End Sub

    Private Sub Buscar()
        Dim lstItem As New List(Of BE_Item)
        lstItem = BL_Item.ListarItemQuery("BUSQUEDA", "CLIENTE", "001")

        gvBusqueda.DataSource = lstItem
        gvBusqueda.DataBind()

    End Sub

    Private Sub gvBusqueda_PageIndexChanging(ByVal sender As Object, ByVal e As System.Web.UI.WebControls.GridViewPageEventArgs) Handles gvBusqueda.PageIndexChanging
        gvBusqueda.PageIndex = e.NewPageIndex
        Buscar()
    End Sub
End Class