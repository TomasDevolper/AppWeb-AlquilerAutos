<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WFAgregarAutos.aspx.cs" Inherits="ProyectoWebFinal.Views.Autos.WFAgregarAutos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<script src="https://kit.fontawesome.com/87841f5732.js" crossorigin="anonymous"></script>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

<!-- Existing Bootstrap and jQuery references -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet" />

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet" />

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link href="../../Recursos/EstiloPrincipal.css" rel="stylesheet" />
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
            <h1 class="text-center" style="margin: 15px;background: transparent;">REGISTRAR AUTO</h1>
        </div>
        <div>
               <form id="frmRegistrarAuto">
            <div style="margin: 20px 100px;">
                <h3>DATOS DEL AUTO:</h3>
            </div>
                   <div class="contenedor-tabla" style="margin: 0 100px;display: flex;justify-content: flex-start;">
                       <table style="width: 800px;">
                            <tr class="columnas">
                                <td class="columnas">
                                    <label for="txtMatricula">Matricula:</label>
                                </td>
                                <td class="columnas">
                                    <input id="txtMatricula" type="text" runat="server" required="required"/>
                                </td>
                            </tr>

                            <tr class="columnas">
                                <td class="columnas">
                                    <label for="txtMarca">Marca:</label>
                                </td>
                                <td class="columnas">
                                    <input id="txtMarca" type="text" runat="server" required="required"/>
                                </td>
                            </tr>

                            <tr class="columnas">
                                <td class="columnas">
                                    <label for="txtModelo">Modelo:</label>
                                </td>
                                <td class="columnas">
                                    <input id="txtModelo" type="text" runat="server" required="required"/>
                                </td>
                            </tr>

                            <tr class="columnas">
                                <td class="columnas">
                                    <label for="txtAño">Año:</label>
                                </td>
                                <td class="columnas">
                                    <input id="txtAño" type="text" runat="server" required="required"/>
                                </td>
                            </tr>

                            <tr class="columnas">
                                <td class="columnas">
                                    <label for="txtColor">Color:</label>
                                </td>
                                <td class="columnas">
                                    <input id="txtColor" type="text" runat="server" required="required"/>
                                </td>
                            </tr>

                            <tr class="columnas">
                                <td class="columnas">
                                    <label for="txtPrecio">Precio:</label>
                                </td>
                                <td class="columnas">
                                    <input id="txtPrecio" type="text" runat="server" required="required"/>
                                </td>
                            </tr>

                            <tr class="columnas">		
                                <td class="columnas">
                                    <label for="FileUploadFoto" >Foto de Auto</label> 
                                </td>

                                <td class="columnas">
                                    <asp:FileUpload ID="FileUploadFoto" runat="server" CssClass="form-control-file" /> 
                                </td>
                            </tr>
                            <tr class="columnas">		
                                <td class="columnas">
                                    <label for="txtDisponibilidad" >Disponibilidad:</label>
                                </td>
                                <td class="columnas">
                                    <div class="form-check">
                                      <asp:RadioButton ID="RadioButtonSI" CssClass="form-check-input" GroupName="Disponibilidad" Text="" runat="server" />
                                        <label class="form-check-label" for="RadioButtonSI" >Si</label>
	                                </div>                    
	                                <div class="form-check">
                                      <asp:RadioButton ID="RadioButtonNO" CssClass="form-check-input" GroupName="Disponibilidad" Text="" runat="server" />
                                         <label class="form-check-label" for="RadioButtonNO" >No</label>
                                    </div>
                                </td>
                           </tr>
                            <tr class="columnas">		
                                <td colspan="2" class="columnas">
                                    <asp:Button ID="ButtonRegistrar" CssClass="btn btn-success" runat="server" Text="Registrar" />
                                </td>
                            </tr>
                        </table>          
                   </div>
            
        </form>
        </div>
    </div>
  <script type="text/javascript">
      $(document).ready(function () {

          $("#<%= ButtonRegistrar.ClientID %>").click(function (e) {

                e.preventDefault();

                var formData = new FormData();
                formData.append("Matricula", $("#<%= txtMatricula.ClientID %>").val());
                formData.append("Marca", $("#<%= txtMarca.ClientID %>").val());
                formData.append("Modelo", $("#<%= txtModelo.ClientID %>").val());
                formData.append("Año", $("#<%= txtAño.ClientID %>").val());
                formData.append("Color", $("#<%= txtColor.ClientID %>").val());
                formData.append("Precio", $("#<%= txtPrecio.ClientID %>").val());
                formData.append("Imag", $("#<%=  FileUploadFoto.ClientID %>")[0].files[0])
                var radioButton = document.querySelector('input[name="Disponibilidad"]:checked');
                if (radioButton) {
                    formData.append("Disponibilidad", radioButton.value);
                }
                //formData.append("Disponibilidad", $('input[name=<=// RadioButtonSI.GroupName %>"]').is(":checked"));
                //formData.append("TerminosAceptados", $("#// CheckBoxTerminos.ClientID %>").is(":checked") );

                $.ajax({
                    type: "POST",
                    url: "/Autos/RegistrarAuto",
                    data: formData,
                    contentType: false,
                    processData: false,
                    success: function (response) {

                        setTimeout(function () {
                            $(".block-ui").hide();
                            alert("Registro Exitoso");
                            location.reload();
                        }, 2000);
                    },
                    error: function (error) {
                        $(".block-ui").hide();
                        alert("Error en registro: " + error.responseText);
                    }
                });
            });
        });
  </script>

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="DetailContent" runat="server">
</asp:Content>
