Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.DataAccess

Public Class BL_Vendedor
    Public Shared Function GetVendedor(ByVal codCia As String, ByVal codVendedor As String) As BE_Vendedor
        Return DA_Vendedor.GetVendedor(codCia, codVendedor)
    End Function
End Class
