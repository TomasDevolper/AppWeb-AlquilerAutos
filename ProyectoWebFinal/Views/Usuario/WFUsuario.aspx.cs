using ProyectoWebFinal.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Helpers;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProyectoWebFinal.Views.Usuario
{
    public partial class WFUsuario : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            var usuario = HttpContext.Current.Session["Usuario"] as Usuarios;

            if (!IsPostBack)
            {
                txtContraseña.Text = usuario.Contraseña;
                txtNombre.Text = usuario.Nombre;
                txtEmail.Text = usuario.Email;     

                
            }
            
        }   

        private void MostrarMensaje(string mensaje)
        {            
            string script = "alert('" + mensaje + "');";
         
            ClientScript.RegisterStartupScript(this.GetType(), "alert", script, true);
        }

        protected void btnActualizarCuenta_Click1(object sender, EventArgs e)
        {
            var usuario = HttpContext.Current.Session["Usuario"] as Usuarios;

            string cnx = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection cnn = new SqlConnection(cnx))
            {
                cnn.Open();

                string sqlQueryUpdate = @"UPDATE [dbo].[Usuarios]
                                  SET [Nombre] = @Nombre
                                     ,[Email] = @Email
                                     ,[Contraseña] = @Contraseña
                                  WHERE [ID_Usuario] = @ID_Usuario;
                                  SELECT @@ROWCOUNT;";

                using (SqlCommand cmd = new SqlCommand(sqlQueryUpdate, cnn))
                {
                    cmd.Parameters.AddWithValue("@Nombre", txtNombre.Text);
                    cmd.Parameters.AddWithValue("@Email", txtEmail.Text);
                    cmd.Parameters.AddWithValue("@Contraseña", txtContraseña.Text);
                    cmd.Parameters.AddWithValue("@ID_Usuario", usuario.ID_Usuario);

                    int rowsAffected = Convert.ToInt32(cmd.ExecuteScalar());

                    if (rowsAffected > 0)
                    {
                        // Actualizar los datos en la sesión
                        usuario.Nombre = txtNombre.Text;
                        usuario.Email = txtEmail.Text;
                        usuario.Contraseña = txtContraseña.Text;

                        // Actualizar la sesión
                        HttpContext.Current.Session["Usuario"] = usuario;

                        // Redirigir para recargar la página
                        HttpContext.Current.Response.Redirect(Request.RawUrl, true);

                        // Llamar al método de recarga en la página maestra
                        ((Site1)this.Master).CargarMenu();
                    }
                    else
                    {
                        // Manejar la situación en la que ninguna fila fue afectada (si es necesario)
                        string script = "alert('No se realizaron modificaciones.');";
                        ClientScriptManager cs = Page.ClientScript;
                        cs.RegisterStartupScript(this.GetType(), "PopupScript", script, true);
                    }
                }
            }
        }


        protected void btnEliminarCuenta_Click1(object sender, EventArgs e)
        {
            var usuario = HttpContext.Current.Session["Usuario"] as Usuarios;

            EliminarUsuario(usuario.ID_Usuario);

            MostrarMensaje("CUENTA ELIMINADA EXITOSAMENTE");

            Session.Clear();
            Response.Redirect("/Acceso/Login");
        }

        private void EliminarUsuario(int idUsuario)
        {
            using (SqlConnection cnn = new SqlConnection(System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString))
            {
                cnn.Open();

                string sqlQuery = "DELETE FROM [dbo].[Usuarios] WHERE [ID_Usuario] = @ID_Usuario";

                using (SqlCommand cmd = new SqlCommand(sqlQuery, cnn))
                {
                    cmd.Parameters.AddWithValue("@ID_Usuario", idUsuario);
                    cmd.ExecuteNonQuery();                    

                }
            }
        }


    }
}