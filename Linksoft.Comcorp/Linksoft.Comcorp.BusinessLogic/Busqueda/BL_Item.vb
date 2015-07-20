Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.DataAccess

Public Class BL_Item

    Public Shared Function ListarItemQuery(ByVal strCodTipoQuery As String, ByVal strCodTabla As String, ByVal strCia As String) As List(Of BE_Item)
        Return DA_Item.ListarItemQuery(strCodTipoQuery, strCodTabla, strCia)
    End Function

End Class
