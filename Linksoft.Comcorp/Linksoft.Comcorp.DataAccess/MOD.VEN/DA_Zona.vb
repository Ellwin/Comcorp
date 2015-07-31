Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports Linksoft.Comcorp.BusinessEntities


Public Class DA_Zona
    Inherits DA_BaseClass


    Public Shared Function ListarZonas(ByVal codCia As String) As List(Of BE_Zona)
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("Usp_Concorp_fa_ctzonas_ListZonas", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@codCia", SqlDbType.VarChar).Value = codCia
                    Using lector As SqlDataReader = cmd.ExecuteReader
                        Dim lstZona As New List(Of BE_Zona)
                        Dim zona As BE_Zona
                        While lector.Read()
                            zona = New BE_Zona
                            With zona
                                .codZona = Convert.ToString(lector.Item("codZona"))
                                .dsZona = Convert.ToString(lector.Item("dsZona"))
                            End With
                            lstZona.Add(zona)
                        End While
                        Return lstZona
                    End Using
                End Using
            End Using
        Catch ex As Exception
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
    End Function

End Class
