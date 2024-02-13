<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="WFLogin.aspx.cs" Inherits="ProyectoWebFinal.Views.Acceso.WFLogin" %>

<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">

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

<!-- Additional existing references -->
<link rel="preload" as="script" crossorigin="anonymous" href="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js" />
<link rel="preload" as="script" crossorigin="anonymous" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js" />

<link href="../../Recursos/EstiloAcceso.css" rel="stylesheet" />

<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <title>Inicio de Sesion</title>
</head>

    <section>
        <div class="contenedor">
            <div class="formulario">
                <form action="/Acceso/Ingresar" id="form1" runat="server">
                    <h2>Iniciar Sesión</h2>
                    <div class="input-contenedor">
    
                        <input id="email" type="email" runat="server" required="required" name="email"  />
                        <label for="Email">Email</label>

                    </div>
                    <div class="input-contenedor">

                        <input id="contraseña" type="password" runat="server" required="required" />
                        <label for="Contraseña">Contraseña</label>

                    </div>                    
                    <div>             
                    
                        <a href="/Acceso/Register" >Crea tu cuenta</a>

                        <asp:Button ID="ButtonIngresar" CssClass="btnAcceder" runat="server" Text="Ingresar" />                                            

                    </div>                
                </form>
            </div>
        </div>

            <div class="block-ui">INGRESANDO.....</div>
    </section>


</html>
