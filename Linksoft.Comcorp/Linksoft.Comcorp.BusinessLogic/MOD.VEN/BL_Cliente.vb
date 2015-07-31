Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.DataAccess

Public Class BL_Cliente
    Public Shared Function GetDatosCliente(ByVal codCia As String, ByVal codCliente As String) As BE_Cliente
        Return DA_Cliente.GetDatosCliente(codCia, codCliente)
    End Function

End Class
