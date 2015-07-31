Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.DataAccess

Public Class BL_SesionLogin

    Public Shared Function GetLogin(ByVal codUsuario As String, ByVal dsPassword As String) As BE_SesionLogin
        Return DA_SesionLogin.GetLogin(codUsuario, dsPassword)
    End Function

End Class
