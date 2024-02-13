<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WFUsuario.aspx.cs" Inherits="ProyectoWebFinal.Views.Usuario.WFUsuario" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../Recursos/EstiloPrincipal.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="MainContent" runat="server">    

    <div class="fondo">
    <div style="background: aliceblue;padding: 0.5px;margin: 0 0 10px 0;border: black solid 1px;border-radius: 15px;">
        <h1 class="text-center" style="margin: 15px;background: transparent;">Mantenimiento Usuario</h1>
    </div>
    <div>
        <form id="frmUsuario">

        <div style="margin: 20px 100px;">
            <h3>Usuario:</h3>
        </div>
        <div class="contenedor-tabla">
            <table style="width: 500px;">
                
                <tr class="columnas">
                    <td class="columnas">
                        <label for="txtNombre">Nombre</label>
                    </td>

                    <td class="columnas">
                        <asp:TextBox runat="server" ID="txtNombre" CssClass="form-control" />
                    </td>
                </tr>
                
                <tr class="columnas">
                    <td class="columnas">
                        <label for="txtEmail">Email</label>
                    </td>

                    <td class="columnas">
                        <asp:TextBox runat="server" ID="txtEmail" CssClass="form-control" />
                    </td>
                </tr>   
                                             
                <tr class="columnas">
                    <td class="columnas">
                        <label for="txtContraseña">Contraseña</label>
                    </td>
                    <td class="columnas">
                        <asp:TextBox runat="server" ID="txtContraseña" CssClass="form-control" />
                    </td>        
                </tr>
                
                <tr class="columnas">	
                    <td class="columnas" colspan="2">
                        <asp:Button ID="btnActualizarCuenta" CssClass="custom-button" runat="server" Text="Actualizar Cuenta" OnClick="btnActualizarCuenta_Click1" />
	                </td>
                </tr>
                
                <tr class="columnas">	
                    <td class="columnas" colspan="2">
                        <label>Desea eliminar cuenta?</label>
                    </td>
                    <td class="columnas" colspan="2">
                        <asp:Button ID="btnEliminarCuenta" CssClass="custom-eliminar" runat="server" Text="Eliminar Cuenta" OnClick="btnEliminarCuenta_Click1" />
                    </td>
                </tr>

            </table>   
             
       </form>       
    </div>
</div>

</asp:Content>
<asp:Content ID="Content4" ContentPlaceHolderID="DetailContent" runat="server">
</asp:Content>
