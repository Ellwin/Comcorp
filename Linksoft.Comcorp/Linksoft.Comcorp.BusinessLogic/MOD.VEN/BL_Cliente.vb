Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.DataAccess

Public Class BL_Cliente
    Public Shared Function GetDatosCliente(ByVal codCia As String, ByVal codCliente As String) As BE_Cliente
        Return DA_Cliente.GetDatosCliente(codCia, codCliente)
    End Function

    Public Shared Function ListarCliente(ByVal codCia As String) As List(Of BE_Cliente)
        Return DA_Cliente.ListarCliente(codCia)
    End Function

    Public Shared Function InsertCliente(ByVal objCliente As BE_Cliente) As Boolean
        Return DA_Cliente.InsertCliente(objCliente)
    End Function

    Public Shared Function UpdateCliente(ByVal objCliente As BE_Cliente) As Boolean
        Return DA_Cliente.UpdateCliente(objCliente)
    End Function

    Public Shared Function DeleteCliente(ByVal objCliente As BE_Cliente) As Boolean
        Return DA_Cliente.DeleteCliente(objCliente)
    End Function

End Class
