Imports Linksoft.Comcorp.DataAccess
Imports Linksoft.Comcorp.BusinessEntities

Public Class BL_Util

    Public Shared Function GetPeriodoActual(ByVal codCia As String, ByVal dsFecha As String) As BE_Periodo
        Return DA_Util.GetPeriodoActual(codCia, dsFecha)
    End Function

    Public Shared Function GetTipoCambio(ByVal codCia As String, ByVal codMoneda As String, ByVal dsFecha As String) As BE_TipoCambio
        Return DA_Util.GetTipoCambio(codCia, codMoneda, dsFecha)
    End Function

    Public Shared Function Valores_Predeterminados(ByVal codCia As String, ByVal codUsuario As String, ByVal vModulo As String, ByVal vCodAtributo As String, ByVal vWhereCampoBd As String, Optional ByVal bTraerElValorDefault As Boolean = False) As String
        Return DA_Util.Valores_Predeterminados(codCia, codUsuario, vModulo, vCodAtributo, vWhereCampoBd, bTraerElValorDefault)
    End Function

End Class
