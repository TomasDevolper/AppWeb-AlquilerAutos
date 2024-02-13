using ProyectoWebFinal.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.IO;
using System.Linq;
using System.Web;
using System.Web.Hosting;
using System.Web.Mvc;

namespace ProyectoWebFinal.Controllers
{
    public class AutosController : Controller
    {
        // GET: Autos
        public ActionResult Listar()
        {
            List<Cars_Inner> objListaAutos = ObtenerAuto();
            Session["Auto"] = objListaAutos;
            HttpContext.Items["Auto"] = objListaAutos;

            var path = "~/Views/Autos/WFListaAutos.aspx";
            Response.Clear();
            Server.Execute(path);
            Response.End();
            return null;
        }      

        public ActionResult Agregar()
        {
            var path = "~/Views/Autos/WFAgregarAutos.aspx";
            Response.Clear();
            Server.Execute(path);
            Response.End();
            return null;
        }

        public JsonResult RegistrarAuto(Cars autos, HttpPostedFileBase Imag)
        {
            string cnx = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection cnn = new SqlConnection(cnx))
            {
                cnn.Open();
                string sqlQuery = "INSERT INTO Autos (Matricula, Marca, Modelo, Año, Color, Precio, Imag, Disponibilidad) VALUES (@Matricula, @Marca, @Modelo ,@Año ,@Color , @Precio, @Imag, @Disponibilidad)";
                SqlCommand cmd = new SqlCommand(sqlQuery, cnn);
                cmd.Parameters.AddWithValue("@Matricula", autos.Matricula);
                cmd.Parameters.AddWithValue("@Marca", autos.Marca);
                cmd.Parameters.AddWithValue("@Modelo", autos.Modelo);
                cmd.Parameters.AddWithValue("@Año", autos.Año);
                cmd.Parameters.AddWithValue("@Color", autos.Color);
                cmd.Parameters.AddWithValue("@Precio", autos.Precio);
                cmd.Parameters.AddWithValue("@Imag", GuardarFoto(Imag));
                cmd.Parameters.AddWithValue("@Disponibilidad", autos.Disponibilidad);

                cmd.ExecuteNonQuery();
            }
            if (ModelState.IsValid)
            {
                string rutaFoto = GuardarFoto(Imag);
            }
            return Json(new { success = false, message = "Ok" });
        }

        private string GuardarFoto(HttpPostedFileBase Imag)
        {
            if (Imag == null || Imag.ContentLength <= 0)
            {
                return null;
            }

            string nombreArchivo = Path.GetFileName(Imag.FileName);
            string nombreUnicoArchivo = $"{Guid.NewGuid()}_{nombreArchivo}";
            //UploadedFiles
            string rutaGuardarFoto = Path.Combine(HostingEnvironment.MapPath("~/FotoAutos/"), nombreUnicoArchivo);
            Imag.SaveAs(rutaGuardarFoto);

            return $"~/FotoAutos/{nombreUnicoArchivo}";
        }

        public List<Cars_Inner> ObtenerAuto()
        {
            var objListaAutos = new List<Cars_Inner>();
            string cnx = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection cnn = new SqlConnection(cnx))
            {
                cnn.Open();
                string sqlQuery = @"SELECT ID_Autos, Matricula, Marca, Modelo, Año, Color, Precio,
                                    CASE WHEN Disponibilidad = 1 THEN 'Si' ELSE 'No' END as 'Disponibilidad' FROM Autos";
                SqlCommand cmd = new SqlCommand(sqlQuery, cnn);

                using (SqlDataReader reader = cmd.ExecuteReader())
                {
                    while (reader.Read())
                    {
                        objListaAutos.Add(new Cars_Inner
                        {
                            ID_Autos = Convert.ToInt32(reader["ID_Autos"]),
                            Matricula = reader["Matricula"].ToString(),
                            Marca = reader["Marca"].ToString(),
                            Modelo = reader["Modelo"].ToString(),
                            Año = reader["Año"].ToString(),
                            Color = reader["Color"].ToString(),
                            Precio = reader["Precio"].ToString(),
                            Disponibilidad = reader["Disponibilidad"].ToString()
                        });
                    }
                }
            }
            return objListaAutos;
        }

        [HttpPost]
        public JsonResult EliminarAuto(Cars car)
        {
            string cnx = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection cnn = new SqlConnection(cnx))
            {
                cnn.Open();

                string sqlQueryInsert = @"DELETE FROM [dbo].[Autos] WHERE  [ID_Autos] = @ID_Autos";

                using (SqlCommand cmd = new SqlCommand(sqlQueryInsert, cnn))
                {
                    cmd.Parameters.AddWithValue("@ID_Autos", car.ID_Autos);
                    cmd.ExecuteNonQuery();
                }
            }
            return Json(new { success = true, message = "Auto Eliminado" });
        }

        [HttpPost]
        public JsonResult ActualizarAuto(Cars car)
        {
            string cnx = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;

            using (SqlConnection cnn = new SqlConnection(cnx))
            {
                cnn.Open();

                string sqlQueryInsert = @"UPDATE [dbo].[Autos]
                               SET [Marca] = @Marca
                                  ,[Modelo] = @Modelo
                                  ,[Año] = @Año
                                  ,[Color] = @Color
                                  ,[Precio] = @Precio                                  
                             WHERE  [ID_Autos] = @ID_Autos";

                using (SqlCommand cmd = new SqlCommand(sqlQueryInsert, cnn))
                {
                    cmd.Parameters.AddWithValue("@Marca", car.Marca);
                    cmd.Parameters.AddWithValue("@Modelo", car.Modelo);
                    cmd.Parameters.AddWithValue("@Año", car.Año);
                    cmd.Parameters.AddWithValue("@Color", car.Color);
                    cmd.Parameters.AddWithValue("@Precio", car.Precio);
                    cmd.Parameters.AddWithValue("@ID_Autos", car.ID_Autos);
                    cmd.ExecuteNonQuery();
                }
            }
            return Json(new { success = false, message = "Auto actualizado con éxito" });
        }
    }
}
