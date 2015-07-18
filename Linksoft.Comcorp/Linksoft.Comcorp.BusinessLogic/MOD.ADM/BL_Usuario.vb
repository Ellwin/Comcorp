Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.DataAccess

Public Class BL_Usuario

    Public Shared Function GetLogin(ByVal strUsuario As String, ByVal strPassword As String) As BE_Usuario
        Return DA_Usuario.GetLogin(strUsuario, strPassword)
    End Function
End Class
