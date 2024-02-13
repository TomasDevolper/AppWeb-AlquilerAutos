using ProyectoWebFinal.Models;
using System;
using System.Collections.Generic;
using System.Data;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProyectoWebFinal.Controllers
{
    public class AccesoController : Controller
    {
        // GET: Acceso
        public ActionResult Login()
        {
             var vpath = "~/Views/Acceso/WFLogin.aspx";
             Response.Clear();
             Server.Execute(vpath);
             Response.End();
             return null;
        }

        public ActionResult Register()
        {
            var vpath = "~/Views/Acceso/WFRegister.aspx";
            Response.Clear();
            Server.Execute(vpath);
            Response.End();
            return null;
        }

        public JsonResult GuardarRegistro(Usuarios modelUser)
        {
            string cnx = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection cnn = new SqlConnection(cnx))
            {
                cnn.Open();
                string sqlQueryInsert = "INSERT INTO [dbo].[Usuarios] (Nombre , Email ,Contraseña) VALUES (@Nombre , @Email, @Contraseña)";

                using (SqlCommand cmd = new SqlCommand(sqlQueryInsert, cnn))
                {
                    cmd.Parameters.AddWithValue("@Nombre", modelUser.Nombre);
                    cmd.Parameters.AddWithValue("@Email", modelUser.Email);
                    cmd.Parameters.AddWithValue("@Contraseña", modelUser.Contraseña);
                    cmd.ExecuteNonQuery();
                }
            }
            return Json(new { success = false, message = "Ok" });
        }

        [HttpPost]
        public ActionResult Ingresar(string email, string contraseña)
        {
            // Validar las credenciales recibidas
            Usuarios usuarioAutenticado = ObtenerUsuarioPorCredenciales(email, contraseña);

            if (usuarioAutenticado != null)
            {
                // Usuario autenticado, y establezco una sesión USUARIO
                Session["Usuario"] = usuarioAutenticado;
                HttpContext.Items["Usuario"] = usuarioAutenticado;

                return RedirectToAction("Ingresar", "Principal"); // Redirige a la página Principal              
            }
            else
            {
                // Credenciales incorrectas, mostrar un mensaje de error
                return RedirectToAction("Login", "Acceso");
            }
        }


        private Usuarios ObtenerUsuarioPorCredenciales(string email, string contraseña)
        {
            Usuarios usuario = null;
            string cnn = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection sqlConn = new SqlConnection(cnn))
            {
                string SqlQuery = "SELECT ID_Usuario, Nombre, Email, Contraseña, ID_Rol FROM Usuarios WHERE Email = @Email and Contraseña = @Contraseña";

                SqlCommand sqlCmd = new SqlCommand(SqlQuery, sqlConn);
                sqlCmd.Parameters.AddWithValue("@Email", email);
                sqlCmd.Parameters.AddWithValue("@Contraseña", contraseña);

                // Ejecutar SQL SELECT
                sqlCmd.CommandType = CommandType.Text;
                sqlConn.Open();

                using (SqlDataReader sqlDR = sqlCmd.ExecuteReader())
                {
                    if (sqlDR.Read())
                    {
                        usuario = new Usuarios()
                        {
                            ID_Usuario = Convert.ToInt32(sqlDR["ID_Usuario"].ToString()),
                            Nombre = sqlDR["Nombre"].ToString(),
                            Email = sqlDR["Email"].ToString(),
                            Contraseña = sqlDR["Contraseña"].ToString(),
                            ID_Rol = (Rol)sqlDR["ID_Rol"]
                        };
                    }
                }
            }

            return usuario;
        }

    }
}