<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WFAgregarAlquiler.aspx.cs" Inherits="ProyectoWebFinal.Views.Alquiler.WFAgregarAlquiler" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <script src="https://kit.fontawesome.com/87841f5732.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    <!-- Existing Bootstrap and jQuery references -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />

    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>

    <!-- jqGrid CSS and JS references -->
    <link href="http://trirand.com/blog/jqgrid/themes/redmond/jquery-ui-custom.css" rel="stylesheet" />
    <link href="http://trirand.com/blog/jqgrid/themes/ui.jqgrid.css" rel="stylesheet" />
    <link href="http://trirand.com/blog/jqgrid/themes/ui.multiselect.css" rel="stylesheet" />
    <script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>
        <link href="../../Recursos/EstiloPrincipal.css" rel="stylesheet" />
    <!-- Additional existing references -->
    <link rel="preload" as="script" crossorigin="anonymous" href="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js" />
    <link rel="preload" as="script" crossorigin="anonymous" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js" />

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="fondo">
        <div style="background: aliceblue;padding: 0.5px;margin: 0 0 10px 0;border: black solid 1px;border-radius: 15px;">
            <h1 class="text-center" style="margin: 15px;background: transparent;">REGISTRAR ALQUILER</h1>
        </div>
        <div>
            <form id="frmRegistrarAlquiler">
    
            <div style="margin: 20px 100px;">
                <h3>Datos Alquiler:</h3>
            </div>
            <div class="contenedor-tabla">
                <table style="width: 500px;">
                    <tr class="columnas">
                        <td class="columnas">
                            <label for="ddlNombre">Nombre</label>
                        </td>
                        <td class="columnas">
                            <asp:DropDownList ID="ddlNombre" runat="server"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="columnas">
                        <td class="columnas">
                            <label for="ddlDocumento">TipoDocumento</label>
                        </td>

                        <td class="columnas">
                            <asp:DropDownList ID="ddlDocumento" runat="server"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="columnas">
                        <td class="columnas">
                            <label for="txtDocumento">Documento</label>
                        </td>

                        <td class="columnas">
                            <input id="txtDocumento" type="text" runat="server" required="required"/>
                        </td>
                    </tr>
                    <tr class="columnas">
                        <td class="columnas">
                            <label for="ddlBrevete">Tipo Brevete</label>
                        </td>

                        <td class="columnas">
                            <asp:DropDownList ID="ddlBrevete" runat="server"></asp:DropDownList>
                        </td>
                    </tr>
                    <tr class="columnas">
                        <td class="columnas">
                            <label for="txtBrevete">Brevete</label>
                        </td>

                        <td class="columnas">
                            <input id="txtBrevete" type="text" runat="server" required="required"/>
                        </td>
                    </tr>   
                
                    <tr class="columnas">
                        <td class="columnas">
                            <label for="ddlAuto">Auto</label>
                        </td>
                        <td class="columnas">
                            <asp:DropDownList ID="ddlAuto" AutoPostBack="true" runat="server" OnSelectedIndexChanged="ddlAuto_SelectedIndexChanged"></asp:DropDownList>
                
                        </td>
                    </tr>        
                    <tr class="columnas">
                        <td class="columnas">
                            <label for="txtDias">Dias</label>
                        </td>

                        <td class="columnas">
                            <input id="txtDias" type="text" runat="server" required="required"/>
                        </td>
                    </tr>
                    <tr class="columnas">
                        <td class="columnas">
                            <label for="txtPrecio">Precio Total</label>
                        </td>
                        <td class="columnas">
                            <input id="txtPrecio" type="text" runat="server" enableviewstate="False" />
                        </td>
                        <td class="columnas" style="width: 50px;">
                            <asp:Button ID="btnCalcularPrecio" CssClass="btn btn-success" runat="server" Text="🔎" OnClick="btnCalcularPrecio_Click" style="background: #7fa3a3;" />
                        </td>

                    </tr>
                    <tr class="columnas">	
                        <td class="columnas" colspan="2">
                            <asp:Button ID="ButtonRegistrar" CssClass="btn btn-success" runat="server" Text="Registrar" />
		                </td>
                    </tr>
        
                </table>     
                <div class="imagen-auto" style="width: 450px;">
                    <asp:Image ID="imgAuto" Class="imagen" runat="server" style="height: 250px;object-fit: cover;width: 400px;border-radius: 4px;box-shadow: 0 2px 5px 0 rgba(0,0,0,.5);transition: .3s ease-in-out;position: absolute;display: flex;margin: 50px 75px;" />
                </div>
            </div>  
                <asp:HiddenField ID="HiddenField1" runat="server"/>
                <asp:HiddenField ID="HiddenField2" runat="server" />
                <asp:HiddenField ID="HiddenField3" runat="server" />
                <asp:HiddenField ID="HiddenField4" runat="server" />
        </form>    
        </div>
    </div>
    <script type="text/javascript">
        $(document).ready(function () {

            $("#<%= ButtonRegistrar.ClientID %>").click(function (e) {

                e.preventDefault();

                const data = {
                    ID_Usuario: $('#<%= ddlNombre.ClientID%>').val(),
                    ID_TipoDocumento: $('#<%= ddlDocumento.ClientID%> option:selected').val(),
                    Documento: $('#<%= txtDocumento.ClientID%>').val(),
                    ID_TipoBrevete: $('#<%= ddlBrevete.ClientID%> option:selected').val(),
                    Brevete: $('#<%= txtBrevete.ClientID%>').val(),                    
                    ID_Auto: $('#<%= ddlAuto.ClientID%> option:selected').val(),
                    Dias: $('#<%= txtDias.ClientID%>').val(),
                    Precio: $('#<%= txtPrecio.ClientID%>').val()
                }

                $(".block-ui").show();
                $.ajax({
                    type: "POST",
                    url: "/Alquiler/GuardarAlquiler",
                    data: JSON.stringify({ datos: data }),
                    contentType: 'application/json',
                    processData: false,
                    //success: function (response) {
                    //    alert("Persona Registrada");
                    //    location.reload();
                    //},
                    success: (function (response) {
                        $(".block-ui").hide();
                        alert("Registro Exitoso");
                        location.reload();
                    }),
                    error: function (error) {
                        $(".block-ui").hide();
                        alert("Error en el registro: " + error.responseText);
                    }

                });
            });
        });
    </script>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="DetailContent" runat="server">
</asp:Content>
