Imports Linksoft.Comcorp.DataAccess
Imports Linksoft.Comcorp.BusinessEntities

Public Class BL_Cotizacion
    Public Shared Function InsertCotizacion(ByVal objCotizacion As BE_Cotizacion) As Boolean
        Return DA_Cotizacion.InsertCotizacion(objCotizacion)
    End Function

    Public Shared Function UpdateCotizacion(ByVal objCotizacion As BE_Cotizacion) As Boolean
        Return DA_Cotizacion.UpdateCotizacion(objCotizacion)
    End Function

    Public Shared Function DeleteCotizacion(ByVal objCotizacion As BE_Cotizacion) As Boolean
        Return DA_Cotizacion.DeleteCotizacion(objCotizacion)
    End Function

    Public Shared Function ListarCotizacion(ByVal codCia As String, ByVal codEjercicio As String, ByVal codPeriodo As String) As List(Of BE_Cotizacion)
        Return DA_Cotizacion.ListarCotizacion(codCia, codEjercicio, codPeriodo)
    End Function

    Public Shared Function GetCotizacionDetalle(ByVal codCia As String, ByVal codEjercicio As String, ByVal codPeriodo As String,
                                                ByVal dsDoc As String, ByVal dsDocSerie As String, ByVal dsDocNro As String) As List(Of BE_ItemFactura)
        Return DA_Cotizacion.GetCotizacionDetalle(codCia, codEjercicio, codPeriodo, dsDoc, dsDocSerie, dsDocNro)
    End Function
End Class
