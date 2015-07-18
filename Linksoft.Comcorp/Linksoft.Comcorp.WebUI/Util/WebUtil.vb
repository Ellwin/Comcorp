Public Class WebUtil

    Private Shared rutaRelativa As String

    ''' <summary>
    ''' Retorna la ruta relativa del sitio
    ''' </summary>
    Public Shared Property RelativeWebRoot As String
        Get
            If rutaRelativa Is Nothing Then
                rutaRelativa = VirtualPathUtility.ToAbsolute("~/")
            End If
            Return rutaRelativa
        End Get
        Set(ByVal value As String)

        End Set
    End Property


    ''' <summary>
    ''' Retorna la ruta absoluta del sitio
    ''' </summary>
    Public Shared Property AbsoluteWebRoot As Uri
        Get
            Dim context As HttpContext = HttpContext.Current

            If context Is Nothing Then
                Throw New System.Net.WebException("El contexto es nulo")
            End If

            If context.Items("absoluteurl") Is Nothing Then
                context.Items("absoluteurl") = New Uri(context.Request.Url.GetLeftPart(UriPartial.Authority) & RelativeWebRoot)
            End If

            Return CType(context.Items("absoluteurl"), Uri)


        End Get
        Set(ByVal value As Uri)

        End Set
    End Property

    ''' <summary>
    ''' Serializa objeto JSON
    ''' </summary>
    ''' <param name="obj"></param>
    ''' <param name="context"></param>
    ''' <remarks></remarks>
    Public Shared Sub Serializar(ByVal obj As Object, ByVal context As HttpContext)
        Dim ser As New System.Web.Script.Serialization.JavaScriptSerializer
        Dim jasonData = ser.Serialize(obj)

        With context.Response
            .ContentType = "application/json"
            .ContentEncoding = Encoding.UTF8
            .Write(jasonData)
            .End()
        End With

    End Sub

    ''' <summary>
    ''' Deserializa objeto JSON
    ''' </summary>
    ''' <param name="obj"></param>
    ''' <param name="context"></param>
    ''' <remarks></remarks>
    Public Shared Function Deserializar(Of T)(ByVal obj As String, ByVal context As HttpContext) As T
        Dim ser As New System.Web.Script.Serialization.JavaScriptSerializer
        Return ser.Deserialize(Of T)(obj)
    End Function

End Class
