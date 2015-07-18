﻿Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.BusinessLogic
Imports Linksoft.Comcorp.WebUI.WebUtil

Public Class Site
    Inherits System.Web.UI.MasterPage

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            CargarMenu()
        End If
    End Sub

    Protected Sub lbCerrarSesion_Click(ByVal sender As Object, ByVal e As EventArgs) Handles lbCerrarSesion.Click
        Session.Abandon()
        Session.Clear()
        Response.Cookies.Add(New HttpCookie("ASP.NET_SessionId", ""))
        Response.AddHeader("Cache-Control", "no-cache")
        Response.Redirect(WebUtil.AbsoluteWebRoot.ToString & "Login.aspx")
    End Sub


    ''' <summary>
    ''' Rutina para cargar menu del usuario
    ''' </summary>
    ''' <remarks></remarks>
    Public Sub CargarMenu()

        Dim rol As String = "AD"

        Dim lstMenu As List(Of BE_MenuWeb) = BL_MenuWeb.ListarMenuWeb(rol)
        Dim item, itemHijo As BE_MenuWeb

        If Not lstMenu Is Nothing Then
            Dim sb As New StringBuilder
            Dim ruta As String = WebUtil.AbsoluteWebRoot.ToString
            For Each item In lstMenu.Where(Function(x) x.codPadre = "00")
                sb.Append("<ul>")
                sb.Append("<li><a href='#'>")
                sb.Append(item.dsOpcion)
                sb.Append("</a>")
                sb.Append("<ul>")

                For Each itemHijo In lstMenu.Where(Function(x) x.codPadre = item.codOpcion)
                    sb.Append(String.Format("<li><a href={0}", ruta))
                    sb.Append(itemHijo.dsUrl)
                    sb.Append(" title='")
                    sb.Append(itemHijo.dsOpcion)
                    sb.Append("'>")
                    sb.Append(itemHijo.dsOpcion)
                    sb.Append("</a></li>")
                Next

                sb.Append("</ul >")
                sb.Append("</li>")
                sb.Append("</ul>")
            Next
            divmenu.InnerHtml = sb.ToString
        End If

    End Sub

End Class