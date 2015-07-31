Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.DataAccess


Public Class BL_CondicionPago
    Public Shared Function GetCondicionPago(ByVal codCia As String, ByVal codCondicionPago As String) As BE_CondicionPago
        Return DA_CondicionPago.GetCondicionPago(codCia, codCondicionPago)
    End Function
End Class
