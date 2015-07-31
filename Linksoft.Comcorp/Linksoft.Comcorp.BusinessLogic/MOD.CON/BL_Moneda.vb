Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.DataAccess

Public Class BL_Moneda
    Public Shared Function GetMoneda(ByVal codCia As String, ByVal codMoneda As String) As BE_Moneda
        Return DA_Moneda.GetMoneda(codCia, codMoneda)
    End Function
End Class
