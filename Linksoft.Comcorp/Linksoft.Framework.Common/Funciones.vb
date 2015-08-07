Public Class Funciones

    Public Function Redondear(ByVal vNum As Double, ByVal vCantDec As Int16) As Double
        Dim str As String, i As Integer
        str = "#0"
        If vCantDec > 0 Then
            str = str & "."
            For i = 1 To vCantDec
                str = str & "0"
            Next i
        End If

        Return Val(Format(vNum, str))
    End Function

    Public Function Replicavalor(ByVal Valor_a_Replicar As String, ByVal Cant_a_Replicar As Integer) As String
        Dim ncontador As Integer, ccadena As String
        ccadena = ""
        For ncontador = 1 To Cant_a_Replicar
            ccadena = ccadena + Valor_a_Replicar
        Next
        Replicavalor = ccadena
    End Function

End Class
