using ProyectoWebFinal.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Globalization;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProyectoWebFinal.Controllers
{
    public class AlquilerController : Controller
    {
        // GET: Alquiler
        public ActionResult Agregar()
        {
            List<Document> objListaTipoDocumento = ObtenerDocumento();
            Session["Documento"] = objListaTipoDocumento;
            HttpContext.Items["Documento"] = objListaTipoDocumento;

            List<Brief> objListaTipoBrevete = ObtenerBrevete();
            Session["Brevete"] = objListaTipoBrevete;
            HttpContext.Items["Brevete"] = objListaTipoBrevete;

            List<Cars> objListaAuto = ObtenerAuto();
            Session["Auto"] = objListaAuto;
            HttpContext.Items["Auto"] = objListaAuto;

            var path = "~/Views/Alquiler/WFAgregarAlquiler.aspx";
            Response.Clear();
            Server.Execute(path);
            Response.End();
            return null;
        }

        public ActionResult Listar()
        {
            
            List<Rent_Inner> objListaAlqui = ObtenerAlquiler();
            Session["Alquiler"] = objListaAlqui;
            HttpContext.Items["Alquiler"] = objListaAlqui;

            var path = "~/Views/Alquiler/WFListaAlquiler.aspx";
            Response.Clear();
            Server.Execute(path);
            Response.End();
            return null;
        }
        
        public List<Document> ObtenerDocumento()
        {
            var objListaTipoDocumento = new List<Document>();
            string cnx = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection cnn = new SqlConnection(cnx))
            {
                cnn.Open();
                string sqlQuery = "select * from Tipo_Documento";
                SqlCommand cmd = new SqlCommand(sqlQuery, cnn);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        objListaTipoDocumento.Add(new Document
                        {
                            ID_TipoDocumentoss = Convert.ToInt32(reader["ID_TipoDocumento"].ToString()),
                            Descripcion = reader["Descripcion"].ToString()
                        }
                        );
                    }
                }
            }
            return objListaTipoDocumento;
        }

        public List<Brief> ObtenerBrevete()
        {
            var objListaTipoBrevete = new List<Brief>();
            string cnx = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection cnn = new SqlConnection(cnx))
            {
                cnn.Open();
                string sqlQuery = "select * from Tipo_Brevete";
                SqlCommand cmd = new SqlCommand(sqlQuery, cnn);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        objListaTipoBrevete.Add(new Brief
                        {
                            ID_TipoBrevetess = Convert.ToInt32(reader["ID_TipoBrevete"].ToString()),
                            Descripcion = reader["Descripcion"].ToString()
                        }
                        );
                    }
                }
            }
            return objListaTipoBrevete;
        }

        public List<Cars> ObtenerAuto()
        {
            var objListaAuto = new List<Cars>();
            string cnx = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection cnn = new SqlConnection(cnx))
            {
                cnn.Open();
                string sqlQuery = @"SELECT ID_Autos, CONCAT(Marca, ' ', Modelo) AS 'Auto'
                                    FROM Autos";
                SqlCommand cmd = new SqlCommand(sqlQuery, cnn);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        objListaAuto.Add(new Cars
                        {
                            ID_Autos = Convert.ToInt32(reader["ID_Autos"].ToString()),
                            Marca = reader["Auto"].ToString()
                        }
                        );
                    }
                }
            }
            return objListaAuto;
        }

        public JsonResult GuardarAlquiler(Rent datos)
        {

            string cnx = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection cnn = new SqlConnection(cnx))
            {
                cnn.Open();
                string sqlQueryInsert = "INSERT INTO [dbo].[Alquiler] (ID_Usuario ,ID_TipoDocumento ,Documento ,ID_TipoBrevete ,Brevete ,ID_Auto ,Dias ,Precio) VALUES (@ID_Usuario ,@ID_TipoDocumento ,@Documento ,@ID_TipoBrevete ,@Brevete ,@ID_Auto ,@Dias ,@Precio)";

                using (SqlCommand cmd = new SqlCommand(sqlQueryInsert, cnn))
                {

                    cmd.Parameters.AddWithValue("@ID_Usuario", datos.ID_Usuario);
                    cmd.Parameters.AddWithValue("@ID_TipoDocumento", datos.ID_TipoDocumento);
                    cmd.Parameters.AddWithValue("@Documento", datos.Documento);
                    cmd.Parameters.AddWithValue("@ID_TipoBrevete", datos.ID_TipoBrevete);
                    cmd.Parameters.AddWithValue("@Brevete", datos.Brevete);
                    cmd.Parameters.AddWithValue("@ID_Auto", datos.ID_Auto);
                    cmd.Parameters.AddWithValue("@Dias", datos.Dias);
                    cmd.Parameters.AddWithValue("@Precio", datos.Precio);
                    cmd.ExecuteNonQuery();
                }
            }
            return Json(new { success = false, message = "Ok" });
        }

        public List<Rent_Inner> ObtenerAlquiler()
        {
            var objListaAlqui = new List<Rent_Inner>();
            string cnx = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection cnn = new SqlConnection(cnx))
            {
                cnn.Open();
                string sqlQuery = @"SELECT a.ID_Alquiler, u.Nombre as 'Nombre', d.Descripcion as 'TipoDocumento', a.Documento as 'Documento', b.Descripcion as 'TipoBrevete',
                                  a.Brevete as 'Brevete', l.Marca as 'Marca', l.Modelo as 'Modelo', a.Dias as 'Dias' ,a.Precio as 'Precio'
                                  FROM Alquiler a
                                  INNER JOIN Tipo_Documento d ON a.ID_TipoDocumento = d.ID_TipoDocumento
                                  INNER JOIN Tipo_Brevete b ON a.ID_TipoBrevete = b.ID_TipoBrevete
                                  INNER JOIN Usuarios u ON a.ID_Usuario = u.ID_Usuario
                                  INNER JOIN Autos l ON a.ID_Auto = l.ID_Autos";

                SqlCommand cmd = new SqlCommand(sqlQuery, cnn);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        objListaAlqui.Add(new Rent_Inner
                        {
                            ID_Alquiler = Convert.ToInt32(reader["ID_Alquiler"]),
                            Nombre = reader["Nombre"].ToString(),
                            ID_TipoDocumento = reader["TipoDocumento"].ToString(),
                            Documento = reader["Documento"].ToString(),
                            ID_TipoBrevete = reader["TipoBrevete"].ToString(),
                            Brevete = reader["Brevete"].ToString(),
                            Marca = reader["Marca"].ToString(),
                            Modelo = reader["Modelo"].ToString(),
                            Dias = reader["Dias"].ToString(),
                            Precio = reader["Precio"].ToString()

                        }
                        );
                    }
                }
            }
            return objListaAlqui;
        }

        [HttpPost]
        public JsonResult EliminarAlquiler(Rent alqui)
        {
            string cnx = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection cnn = new SqlConnection(cnx))
            {
                cnn.Open();

                string sqlQueryInsert = @"DELETE FROM [dbo].[Alquiler] WHERE  [ID_Alquiler] = @ID_Alquiler";

                using (SqlCommand cmd = new SqlCommand(sqlQueryInsert, cnn))
                {
                    cmd.Parameters.AddWithValue("@ID_Alquiler", alqui.ID_Alquiler);
                    cmd.ExecuteNonQuery();
                }
            }
            return Json(new { success = true, message = "Alquiler Eliminado" });
        }

        [HttpPost]
        public JsonResult ActualizarAlquiler(Rent alqui)
        {
            string cnx = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection cnn = new SqlConnection(cnx))
            {
                cnn.Open();

                string sqlQueryInsert = @"UPDATE [dbo].[Alquiler]
                               SET [Documento] = @Documento
                                  ,[Brevete] = @Brevete
                             WHERE  [ID_Alquiler] = @ID_Alquiler";

                using (SqlCommand cmd = new SqlCommand(sqlQueryInsert, cnn))
                {
                    cmd.Parameters.AddWithValue("@Documento", alqui.Documento);
                    cmd.Parameters.AddWithValue("@Brevete", alqui.Brevete);
                    cmd.Parameters.AddWithValue("@ID_Alquiler", alqui.ID_Alquiler);
                    cmd.ExecuteNonQuery();
                }
            }
            return Json(new { success = false, message = "Alquiler actualizado con éxito" });
        }

    }
}