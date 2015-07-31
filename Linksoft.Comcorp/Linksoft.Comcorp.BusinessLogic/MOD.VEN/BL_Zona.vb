Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.DataAccess

Public Class BL_Zona

    Public Shared Function ListarZonas(ByVal codCia As String) As List(Of BE_Zona)
        Return DA_Zona.ListarZonas(codCia)
    End Function
End Class
