Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.DataAccess


Public Class BL_OperacionFacturacion
    Public Shared Function GetOperacionFacturacion(ByVal codCia As String, ByVal codOperacionFacturacion As String) As BE_OperacionFacturacion
        Return DA_OperacionFacturacion.GetOperacionFacturacion(codCia, codOperacionFacturacion)
    End Function
End Class
