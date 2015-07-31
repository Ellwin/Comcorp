Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.DataAccess

Public Class BL_Item

    Public Shared Function ListarItemQuery(ByVal codTipoQuery As String, ByVal codTabla As String, ByVal codCia As String) As List(Of BE_Item)
        Return DA_Item.ListarItemQuery(codTipoQuery, codTabla, codCia)
    End Function

End Class
