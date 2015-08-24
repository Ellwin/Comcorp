Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.DataAccess

Public Class BL_Item

    Public Shared Function ListarItemQuery(ByVal codTipoQuery As String, ByVal codTabla As String, ByVal codCia As String,
                                           ByVal codigo As String, ByVal descripcion As String) As List(Of BE_Item)
        Return DA_Item.ListarItemQuery(codTipoQuery, codTabla, codCia, codigo, descripcion)
    End Function

End Class
