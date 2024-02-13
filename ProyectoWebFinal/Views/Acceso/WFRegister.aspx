
<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WFRegister.aspx.cs" Inherits="ProyectoWebFinal.Views.Acceso.WFRegister" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
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
    <link href="../../Recursos/EstiloRegister.css" rel="stylesheet" />
 <!-- Additional existing references -->
 <link rel="preload" as="script" crossorigin="anonymous" href="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js" />
 <link rel="preload" as="script" crossorigin="anonymous" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js" />

    <title>Registrarse</title>
</head>
<body>
    <section>
    <div class="contenedor">
        <div class="formulario">
            <form id="form1" runat="server">
                <div>
                    <h2>Registro de Empleados</h2>                    

                    <div class="input-contenedor">

                        <input id="txtNombre" type="text" runat="server" required="required" />
                        <label for="txtNombre">Nombres:</label>

                    </div>                                        

                    <div class="input-contenedor">

                        <input id="txtEmail" type="text" runat="server" required="required" />
                        <label for="txtEmail">Email:</label>

                    </div>

                    <div class="input-contenedor">

                        <input id="txtContraseña" type="password" runat="server" required="required" />
                        <label for="txtContraseña">Contraseña</label>

                    </div>

                    <div>
                        <asp:Button ID="ButtonRegistrar" CssClass="btnAcceder" runat="server" Text="Registrar" />
                    </div>
                </div>
            </form>
        </div>
    </div>
</section>

<div class="block-ui">REGISTRANDO.....</div>

<script type="text/javascript">
    $(document).ready(function () {

        $("#<%= ButtonRegistrar.ClientID %>").click(function (e) {

            e.preventDefault();

            var formData = new FormData(); 
            formData.append("Nombre", $("#<%= txtNombre.ClientID %>").val());
            formData.append("Email", $("#<%= txtEmail.ClientID %>").val());            
            formData.append("Contraseña", $("#<%= txtContraseña.ClientID %>").val());

            $(".block-ui").show();
            $.ajax({
                type: "POST",
                url: "/Acceso/GuardarRegistro",
                data: formData,
                contentType: false,
                processData: false,
                success: function (response) {

                    setTimeout(function () {
                        $(".block-ui").hide();
                        alert("Registro Exitoso");
                        location.replace("/Acceso/Login");
                        //Response.Redirect("~/Views/Home/WFPrincipal.aspx");
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
</body>
</html>
