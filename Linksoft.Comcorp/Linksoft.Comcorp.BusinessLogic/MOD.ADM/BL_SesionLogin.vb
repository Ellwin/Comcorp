Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.DataAccess

Public Class BL_SesionLogin

    Public Shared Function GetLogin(ByVal strUsuario As String, ByVal strPassword As String) As BE_SesionLogin
        Return DA_SesionLogin.GetLogin(strUsuario, strPassword)
    End Function

End Class
