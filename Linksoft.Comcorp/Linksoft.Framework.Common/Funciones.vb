Imports System
Imports System.Text
Imports System.Security.Cryptography


Public Class Funciones

    Private des As New TripleDESCryptoServiceProvider
    Private myKey As String = "DWGTYJVMP"
    Private hashmd5 As New MD5CryptoServiceProvider

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

    Public Function Encriptar(ByVal texto As String) As String
        DES.Key = hashmd5.ComputeHash((New UnicodeEncoding).GetBytes(myKey))
        DES.Mode = CipherMode.ECB
        If Trim(texto) = "" Then
            Encriptar = ""
        Else
            Dim desdencrypt As ICryptoTransform = DES.CreateEncryptor()
            Dim MyASCIIEncoding As New ASCIIEncoding
            Dim buff() As Byte = UnicodeEncoding.ASCII.GetBytes(texto)
            Encriptar = Convert.ToBase64String(desdencrypt.TransformFinalBlock(buff, 0, buff.Length))
        End If
        Return Encriptar
    End Function
    Public Function Desencriptar(ByVal texto As String) As String
        If Trim(texto) = "" Then
            Desencriptar = ""
        Else
            DES.Key = hashmd5.ComputeHash((New UnicodeEncoding).GetBytes(myKey))
            DES.Mode = CipherMode.ECB
            Dim desdencrypt As ICryptoTransform = DES.CreateDecryptor()
            Dim buff() As Byte = Convert.FromBase64String(texto)
            Desencriptar = UnicodeEncoding.ASCII.GetString(desdencrypt.TransformFinalBlock(buff, 0, buff.Length))
        End If
        Return Desencriptar
    End Function

End Class
