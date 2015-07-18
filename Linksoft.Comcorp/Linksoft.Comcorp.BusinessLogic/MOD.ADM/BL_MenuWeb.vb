Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.DataAccess
Public Class BL_MenuWeb

    Public Shared Function ListarMenuWeb(ByVal codRol As String) As List(Of BE_MenuWeb)
        Return DA_MenuWeb.ListarMenuWeb(codRol)
    End Function
End Class
