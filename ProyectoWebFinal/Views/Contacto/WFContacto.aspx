<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WFContacto.aspx.cs" Inherits="ProyectoWebFinal.Views.Contacto.WebForm1" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
    <link href="../../Recursos/EstiloPrincipal.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div class="fondo">
        <h1 style="text-align: center;">CONTACTO</h1>
        <div style="position:relative;display:flex;align-items: flex-start;justify-content:center;width: auto;height: auto;margin-bottom: 10px;overflow:hidden;">
            <p style="font-size: 20px; ">En Drive Dreams, nos dedicamos a brindarte el mejor servicio de alquiler de autos.
            Contamos con una amplia flota de vehículos de calidad, perfectamente mantenidos y listos para llevarte a donde necesites.
            Ya sea que estés planeando unas vacaciones, un viaje de negocios o simplemente necesites un auto por un día, estamos aquí para ayudarte.
            Nuestro equipo de profesionales amigables y capacitados está disponible para responder a tus preguntas, brindarte asesoramiento 
            sobre el mejor vehículo para tus necesidades y ayudarte a realizar una reserva fácilmente. Nos enorgullece ofrecer tarifas competitivas,
            flexibilidad en los horarios y un servicio personalizado que te hará sentir seguro y satisfecho.
            Si tienes alguna consulta, comentario o deseas realizar una reserva, no dudes en ponerte en contacto con nosotros. 
            Estamos disponibles LUNES a VIERNES de 9am a 8pm para atender todas tus necesidades de alquiler de autos. 
            ¡Esperamos poder servirte pronto!
            </p>
        </div>
        <div style="display: flex; flex-direction: row">
            <h3 style="display: flex; justify-content: center;padding: 10px;">Nuestras Redes: </h3>
            <div style="text-align:center;margin: 0;padding: 0;">
                <a href="https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwjPppWP38mDAxV4Q7gEHYnuDcsQFnoECAUQAQ&url=https%3A%2F%2Fwww.facebook.com%2F%3Flocale%3Des_LA&usg=AOvVaw1I60-Ja6y72-wCvsxEihv7&opi=89978449"><i class='bx bxl-facebook-circle' style="font-size: 45px;color: #480388;"></i></a>
                <a href="https://www.instagram.com/garagesportique/?hl=es"><i class='bx bxl-instagram' style="font-size: 45px;color: #480388;" ></i></a>
                <a href="https://www.google.com/url?sa=t&rct=j&q=&esrc=s&source=web&cd=&cad=rja&uact=8&ved=2ahUKEwi6183q4MmDAxUdqZUCHYJTAJcQFnoECAUQAQ&url=https%3A%2F%2Fwww.whatsapp.com%2F%3Flang%3Des_LA&usg=AOvVaw1p9u-k6NGHZLp1fns5M8XW&opi=89978449"><i class='bx bxl-whatsapp' style="font-size: 45px;color: #480388;"></i></a>
            </div>
        </div>
    </div>
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="DetailContent" runat="server">
</asp:Content>
