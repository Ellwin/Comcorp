Imports Linksoft.Comcorp.DataAccess
Imports Linksoft.Comcorp.BusinessEntities

Public Class Funciones

    Public Shared Function GetPeriodoActual(ByVal strCia As String, ByVal strFecha As String) As BE_Periodo
        Return DA_Util.GetPeriodoActual(strCia, strFecha)
    End Function


End Class
