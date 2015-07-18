Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.DataAccess

Public Class BL_Cia
    Public Shared Function GetCia(ByVal strCia As String) As BE_Cia
        Return DA_Cia.GetCia(strCia)
    End Function
End Class
