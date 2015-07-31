Imports System.Data
Imports System.Data.SqlClient
Imports Linksoft.Comcorp.BusinessEntities

Public Class DA_Cia
    Inherits DA_BaseClass

    Public Shared Function GetCia(ByVal codCia As String) As BE_Cia
        Try
            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand("Usp_Concorp_ad_ctcia_GetCia", cn)
                    cmd.CommandType = CommandType.StoredProcedure
                    cmd.Parameters.Add("@codCia", SqlDbType.VarChar).Value = codCia
                    Using lector As SqlDataReader = cmd.ExecuteReader
                        Dim lstCia As New List(Of BE_Cia)
                        Dim cia As BE_Cia
                        While lector.Read()
                            cia = New BE_Cia
                            With cia
                                .codCia = Convert.ToString(lector.Item("codCia"))
                                .dsCia = Convert.ToString(lector.Item("dsCia"))
                            End With
                            lstCia.Add(cia)
                        End While
                        lector.Close()
                        Return lstCia.FirstOrDefault
                    End Using
                End Using
            End Using
        Catch ex As Exception
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
    End Function
End Class
