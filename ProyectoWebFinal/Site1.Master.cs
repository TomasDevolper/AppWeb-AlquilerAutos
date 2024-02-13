using ProyectoWebFinal.Models;
using ProyectoWebFinal.Views.Usuario;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.UI;
using System.Web.UI.HtmlControls;
using System.Web.UI.WebControls;

namespace ProyectoWebFinal
{
    public partial class Site1 : System.Web.UI.MasterPage
    {
        protected void Page_Load(object sender, EventArgs e)
        {            
            var usuario = HttpContext.Current.Session["Usuario"] as Usuarios;

            if (!IsPostBack) {
                CargarMenu();
            }
            if (!IsPostBack)
            {
                if (usuario != null)
                {
                    ddlMenu.Items[0].Text = usuario.Nombre;  
                }
            }
        }

        public void CargarMenu()
        {
            var usuario = HttpContext.Current.Session["Usuario"] as Usuarios;

            //if (!IsPostBack)
            //{
                if (usuario != null)
                {
                    // Limpiar elementos anteriores del menú
                    Menus.Controls.Clear();

                    // Agregar elementos del menú según el rol del usuario
                    if (usuario.ID_Rol.ToString() == "Administrador")
                    {
                        AgregarElementoMenu("Principal", "/Principal/Ingresar", "PrincipalMenuItem");
                        AgregarElementoMenu("Registro Autos", "/Autos/Agregar", "RegistroAutosMenuItem");
                        AgregarElementoMenu("Lista Autos", "/Autos/Listar", "ListaAutosMenuItem");
                        AgregarElementoMenu("Registro Alquiler", "/Alquiler/Agregar", "RegistroAlquilerMenuItem");
                        AgregarElementoMenu("Historial Alquiler", "/Alquiler/Listar", "HistorialAlquilerMenuItem");
                        AgregarElementoMenu("Contacto", "/Contacto/Ingresar", "ContactoMenuItem");
                    }
                    else if (usuario.ID_Rol.ToString() == "Usuario")
                    {
                        AgregarElementoMenu("Principal", "/Principal/Ingresar", "PrincipalMenuItem");
                        AgregarElementoMenu("Registro Alquiler", "/Alquiler/Agregar", "RegistroAlquilerMenuItem");
                        AgregarElementoMenu("Contacto", "/Contacto/Ingresar", "ContactoMenuItem");
                    }
                    else
                    {
                        // Rol no válido, muestra un mensaje de error
                        MostrarMensajeError("Rol no válido. Acceso denegado.");
                    }
                }
                else
                {
                    // Usuario no autenticado, muestra un mensaje de error
                    MostrarMensajeError("Usuario no autenticado. Acceso denegado.");
                }
            //}            
        }

        private void AgregarElementoMenu(string texto, string url, string id)
        {
            // Crear un nuevo elemento ListItem
            var listItem = new HtmlGenericControl("li");
            listItem.ID = id;

            // Crear un nuevo elemento Anchor dentro del ListItem
            var anchor = new HtmlAnchor();
            anchor.HRef = url;
            anchor.InnerText = texto;

            // Agregar el Anchor al ListItem
            listItem.Controls.Add(anchor);

            // Agregar el ListItem a la lista Menus
            Menus.Controls.Add(listItem);
        }

        private void MostrarMensajeError(string mensaje)
        {
            // Puedes usar un Literal, Label u otro control para mostrar el mensaje
            LiteralMensajeError.Text = mensaje;
            LiteralMensajeError.Visible = true;
        }

        protected void ddlMenu_SelectedIndexChanged(object sender, EventArgs e)
        {
            string selectedOption = ddlMenu.SelectedValue;

            if (!string.IsNullOrEmpty(selectedOption))
            {
                if (selectedOption == "miPerfil")
                {
                    // Redirecciona a la página de perfil
                    Response.Redirect("/Usuario/Ingresar");
                }
                else if (selectedOption == "cerrarSesion")
                {
                    Session.Clear();
                    Response.Redirect("/Acceso/Login");
                }
            }
        }

        

    }
}