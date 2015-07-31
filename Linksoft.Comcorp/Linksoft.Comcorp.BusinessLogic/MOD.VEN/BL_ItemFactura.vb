Imports Linksoft.Comcorp.DataAccess
Imports Linksoft.Comcorp.BusinessEntities

Public Class BL_ItemFactura

    Public Shared Function GetItemFactura(ByVal codCia As String, ByVal codArticulo As String,
                                          ByVal codEjercicio As String, ByVal codPeriodo As String,
                                          ByVal codAlmacen As String) As BE_ItemFactura

        Return DA_ItemFactura.GetItemFactura(codCia, codArticulo, codEjercicio, codPeriodo, codAlmacen)

    End Function

    Public Shared Function GetListaPrecioArticulo(ByVal codCia As String, ByVal codArticulo As String, ByVal codListaPrecio As String) As BE_ItemFactura
        Return DA_ItemFactura.GetListaPrecioArticulo(codCia, codArticulo, codListaPrecio)
    End Function
End Class
