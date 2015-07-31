Imports System
Imports System.Web
Imports System.Web.UI
Imports System.Web.UI.WebControls
Imports System.Collections.Generic

Imports Linksoft.Comcorp.BusinessEntities
Imports Linksoft.Comcorp.BusinessLogic
Imports Linksoft.Framework.Common
Imports System.Data.SqlClient

Public Class Login
    Inherits System.Web.UI.Page

    Private Shared m_oConnection As SqlConnection

    Protected Sub Page_Load(ByVal sender As Object, ByVal e As System.EventArgs) Handles Me.Load
        If Not Page.IsPostBack Then
            txtUsuario.Focus()
            txtFecha.Text = Format(Now.Date, "dd/MM/yyyy")
        End If
    End Sub

    Protected Sub btnIniciarSesion_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnIniciarSesion.Click
        Dim mensaje As String = String.Empty
        Dim script As String = String.Empty
        Dim resultado As Boolean = True

        Dim objSesionLogin As New BE_SesionLogin
        Dim objPeriodo As New BE_Periodo


        Dim strFecha As String = String.Empty

        objSesionLogin = BL_SesionLogin.GetLogin(txtUsuario.Text.Trim, txtPassword.Text.Trim)

        script = "$('#myModal').modal({show:true, backdrop: 'static', keyboard: false});"
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "", script, True)

        If Not objSesionLogin Is Nothing Then
            If String.IsNullOrEmpty(txtCodCompania.Text.Trim) Then
                mensaje &= "Ingrese código de compañía . <br/>"
                resultado = False
            End If
            If (ddlSucursal.Items.Count = 0) Then
                mensaje &= "Seleccione sucursal. <br/>"
                resultado = False
            Else
                If ddlSucursal.SelectedItem.Value = "0" Then
                    mensaje &= "Seleccione sucursal. <br/>"
                    resultado = False
                End If
            End If
            If String.IsNullOrEmpty(txtFecha.Text.Trim) Then
                mensaje &= "Ingrese fecha. <br/>"
                resultado = False
            Else
                If Not IsDate(txtFecha.Text) Then
                    mensaje &= "Ingrese una fecha válida. <br/>"
                    resultado = False
                Else
                    strFecha = Format(CDate(txtFecha.Text), "yyyy-MM-dd")
                    objPeriodo = BL_Util.GetPeriodoActual(txtCodCompania.Text, strFecha)
                End If
            End If


            If resultado = False Then
                script = "$(function(){mostrarMensajeModal('" & mensaje & "','" + Constantes.ALERT_DANGER + "')})"
                ScriptManager.RegisterStartupScript(Me, Page.GetType(), "msj", script, True)
            Else
                
                If String.IsNullOrEmpty(objPeriodo.codEjercicio) And String.IsNullOrEmpty(objPeriodo.codPeriodo) Then

                    mensaje = "El periodo para la fecha ingresada aún no ha sido configurado."
                    script = "$(function(){mostrarMensajeModal('" & mensaje & "','" + Constantes.ALERT_DANGER + "')})"
                    ScriptManager.RegisterStartupScript(Me, Page.GetType(), "msjPeriodo", script, True)

                Else

                    With objSesionLogin
                        .codCia = txtCodCompania.Text.ToUpper
                        .dsCia = txtCompania.Text.ToUpper
                        .codZona = ddlSucursal.SelectedItem.Value
                        .dsZona = ddlSucursal.SelectedItem.Text
                        .fePeriodo = Convert.ToDateTime(txtFecha.Text)
                        .codEjercicio = objPeriodo.codEjercicio
                        .codPeriodo = objPeriodo.codPeriodo
                    End With

                    Session(Constantes.USUARIO_SESION) = objSesionLogin
                    Response.Redirect("Default.aspx")
                End If
                
            End If
        End If
    End Sub

    Protected Sub btnIngresar_Click(ByVal sender As Object, ByVal e As EventArgs) Handles btnIngresar.Click
        Dim mensaje As String = String.Empty
        Dim script As String = String.Empty
        Dim resultado As Boolean = True

        txtPassword.Attributes("value") = txtPassword.Text

        If String.IsNullOrEmpty(txtUsuario.Text.Trim) Then
            mensaje &= "Ingrese usuario. <br/>"
            resultado = False
        End If

        If String.IsNullOrEmpty(txtPassword.Text.Trim) Then
            mensaje &= "Ingrese password. <br/>"
            resultado = False
        End If

        If (Not String.IsNullOrEmpty(txtUsuario.Text.Trim) And Not String.IsNullOrEmpty(txtPassword.Text.Trim)) Then

            Dim objUsuario As New BE_SesionLogin

            objUsuario = BL_SesionLogin.GetLogin(txtUsuario.Text.Trim, txtPassword.Text.Trim)

            If Not objUsuario Is Nothing Then
                resultado = True
            Else
                mensaje &= "Usuario o password incorrecto"
                resultado = False
            End If


        End If

        If resultado = False Then
            script = "$(function(){mostrarMensaje('" & mensaje & "','" + Constantes.ALERT_DANGER + "')})"
            ScriptManager.RegisterStartupScript(Me, Page.GetType(), "", script, True)
        Else
            script = "$('#myModal').modal({ backdrop: 'static', keyboard: false}); " + SetControlFocus(txtCodCompania.ID) + ""
            ScriptManager.RegisterStartupScript(Page, Page.GetType(), "", script, True)
        End If
    End Sub

    Private Sub txtCodCompania_TextChanged(ByVal sender As Object, ByVal e As System.EventArgs) Handles txtCodCompania.TextChanged
        Dim mensaje As String = String.Empty
        Dim script As String = String.Empty
        Dim resultado As Boolean = True

        script = "$('#myModal').modal({show:true, backdrop: 'static', keyboard: false});"
        ScriptManager.RegisterStartupScript(Page, Page.GetType(), "", script, True)

        Dim objCia As New BE_Cia
        objCia = BL_Cia.GetCia(txtCodCompania.Text.Trim)

        If Not objCia Is Nothing Then
            txtCompania.Text = objCia.dsCia.ToUpper
        Else
            mensaje &= "Compania no existe"
            resultado = False
        End If

        If resultado = False Then

            script = "$(function(){mostrarMensajeModal('" & mensaje & "','" + Constantes.ALERT_DANGER + "'); " + SetControlFocus(txtCodCompania.ID) + "})"
            ScriptManager.RegisterStartupScript(Me, Page.GetType(), "msj", script, True)

            txtCompania.Text = String.Empty
            ddlSucursal.Items.Clear()

            SetControlFocus(txtCodCompania.ID)
        Else
            ListarSucursal(txtCodCompania.Text.Trim)
            script = "$(function(){" + SetControlFocus(ddlSucursal.ID) + "})"
            ScriptManager.RegisterStartupScript(Me, Page.GetType(), "msj", script, True)
        End If

    End Sub

    Private Sub ListarSucursal(ByVal strCia As String)
        Dim lstZona As New List(Of BE_Zona)
        lstZona = BL_Zona.ListarZonas(strCia)

        ddlSucursal.DataSource = lstZona
        ddlSucursal.DataValueField = "codZona"
        ddlSucursal.DataTextField = "dsZona"
        ddlSucursal.DataBind()
        ddlSucursal.Items.Insert(0, New ListItem("--Seleccione--", "0"))
    End Sub

    Private Function SetControlFocus(ByVal strControlID As String) As String
        Dim script As String = String.Empty
        script = " setTimeout(function(){$('#" + strControlID + "').focus();},500);"
        Return script
    End Function

    Private Sub LimpiarModal()
        txtCodCompania.Text = String.Empty
        txtCompania.Text = String.Empty
        ddlSucursal.Items.Clear()
    End Sub

    Private Function ValidarModal() As Boolean
        Dim mensaje As String = String.Empty
        Dim resultado As Boolean = True
        Dim script As String = String.Empty

        

        If String.IsNullOrEmpty(txtCodCompania.Text.Trim) Then
            mensaje &= "Ingrese código de compañía . <br/>"
            resultado = False
        End If
        If (ddlSucursal.Items.Count = 0) Then
            mensaje &= "Seleccione sucursal. <br/>"
            resultado = False
        Else
            If ddlSucursal.SelectedItem.Value = "0" Then
                mensaje &= "Seleccione sucursal. <br/>"
                resultado = False
            End If
        End If

        Return resultado
    End Function

    Private Sub btnCerrar_ServerClick(ByVal sender As Object, ByVal e As System.EventArgs) Handles btnCerrar.ServerClick
        LimpiarModal()
    End Sub

End Class