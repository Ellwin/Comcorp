Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.DataAccess

Public Class BL_Cia
    Public Shared Function GetCia(ByVal codCia As String) As BE_Cia
        Return DA_Cia.GetCia(codCia)
    End Function
End Class
