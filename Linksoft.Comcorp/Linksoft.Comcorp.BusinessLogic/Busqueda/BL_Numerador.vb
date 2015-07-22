Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.DataAccess

Public Class BL_Numerador

    Public Shared Function ListarNumerador(ByVal strCatDoc As String, ByVal strCia As String) As List(Of BE_Numerador)
        Return DA_Numerador.ListarNumerador(strCatDoc, strCia)
    End Function
End Class
