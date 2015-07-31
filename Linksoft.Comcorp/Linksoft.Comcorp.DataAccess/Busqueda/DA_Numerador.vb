Imports System
Imports System.Data
Imports System.Data.SqlClient
Imports Linksoft.Comcorp.BusinessEntities

Public Class DA_Numerador
    Inherits DA_BaseClass

    Public Shared Function ListarNumerador(ByVal catDoc As String, ByVal codCia As String) As List(Of BE_Numerador)
        Try
            Dim strSQL = "Select cdoc_tipo as dsTipoDoc,cdoc_serie as dsSerie,cdsc_num as dsNumerador From Fa_ctnumer " & _
                                  "Where ccat_doc = '" & catDoc & "' And ccod_cia = '" & codCia & "' And cstatus = 'A'"

            Using cn As New SqlConnection(ConnectionStringSQLServer)
                cn.Open()
                Using cmd As New SqlCommand(strSQL, cn)
                    cmd.CommandType = CommandType.Text
                    Using lector As SqlDataReader = cmd.ExecuteReader
                        Dim lstNumerador As New List(Of BE_Numerador)
                        Dim objNumerador As BE_Numerador
                        While lector.Read()
                            objNumerador = New BE_Numerador
                            With objNumerador
                                .dsTipoDoc = Convert.ToString(lector.Item("dsTipoDoc"))
                                .dsSerie = Convert.ToString(lector.Item("dsSerie"))
                                .dsNumerador = Convert.ToString(lector.Item("dsNumerador"))
                            End With
                            lstNumerador.Add(objNumerador)
                        End While
                        Return lstNumerador
                    End Using
                End Using
            End Using
        Catch ex As Exception
            DA_BaseClass.LogSQLException(ex)
            Throw ex
        End Try
    End Function

End Class
