﻿<%@ Page Title="" Language="C#" MasterPageFile="~/SiteMaterAllPages.Master" AutoEventWireup="true" CodeBehind="recuperar-contrasenia.aspx.cs" Inherits="Presentacion.recuperar_contrasenia" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="ContentPlaceHolder1" runat="server">

    <section class="contenedor-mediano">
<h2 class="subtitulo">Recupera tu contraseña</h2>
<div class="descripcion-seccion">
    <p>Ingresa en el siguiente formulario el correo electrónico que tengas asociado a tu usuario, de esta manera podremos enviarte los datos correspondientes para iniciar sesión.</p>
</div>




<div class="">
    <form runat="server" class="contenedor-cuenta">
        <!-- Modal -->
<div class="modal fade" id="modalRecuperarContrasenia" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true">
  <div class="modal-dialog modal-dialog-centered" role="document">
    <div class="modal-content m-contenido">
      <div class="modal-header m-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
          <span aria-hidden="true">&times;</span>
        </button>
      </div>
      <div class="modal-body">
          <i class="far fa-paper-plane m-icono"></i>
       <p>La contraseña ha sido enviada a tu correo.</p>
      </div>
            
    </div>
  </div>
</div>
<!--Fin Ventana modal-->
        <!--Formulario Inicio Sesión-->
        <div class="formulario-iniciar-sesion recuperar-pass">
            <fieldset>
                <h3>Ingresa tu correo electrónico</h3>
                <div class="fieldset-datos">
                    <div class="form-item">
                        <label for="tboxEmailRecuperacion">Email</label>
                        <div class="input-imagen">
                            <asp:TextBox ID="tboxEmailRecuperacion" type="email" runat="server"></asp:TextBox>
                            <i class="far fa-paper-plane"></i>
                        </div>
                    <asp:Label ID="lblErrorEmailRecuperacion" runat="server" Text="" class="Error"></asp:Label>
                    </div>
                </div>
                <asp:Button ID="btnRecuperarContrasenia" Text="Enviar" runat="server" CssClass="btn btn-completo" OnClick="btnRecuperarContrasenia_Click"/>
            </fieldset>
        </div>
    </form>              
</div>
    </section>

</asp:Content>
