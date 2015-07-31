Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.DataAccess

Public Class BL_Almacen
    Public Shared Function GetAlmacen(ByVal codCia As String, ByVal codAlmacen As String) As BE_Almacen
        Return DA_Almacen.GetAlmacen(codCia, codAlmacen)
    End Function
End Class
