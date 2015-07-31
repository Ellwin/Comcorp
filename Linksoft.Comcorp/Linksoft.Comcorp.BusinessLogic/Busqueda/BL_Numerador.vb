Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.DataAccess

Public Class BL_Numerador

    Public Shared Function ListarNumerador(ByVal catDoc As String, ByVal codCia As String) As List(Of BE_Numerador)
        Return DA_Numerador.ListarNumerador(catDoc, codCia)
    End Function
End Class
