using ProyectoWebFinal.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Runtime.Remoting.Messaging;
using System.Web;
using System.Web.Mvc;

namespace ProyectoWebFinal.Controllers
{
    public class PrincipalController : Controller
    {
        // GET: Principal
        public ActionResult Ingresar()
        {
            var path = "~/Views/Principal/WFPrincipal.aspx";
            Response.Clear();
            Server.Execute(path);
            Response.End();
            return null;
        }

        public ActionResult Autos()
        {
            string autos = CargarAutos();
            return Content(autos, "text/plain");

        }
        public string CargarAutos()
        {
            string productosHTML;
            string connectionString = System.Configuration.ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection conn = new SqlConnection(connectionString))
            {
                conn.Open();
                // Ajusta la consulta 
                string productosQuery = string.Empty;

                productosQuery = "SELECT ID_Autos , CONCAT(Marca, ' ', Modelo) AS 'Auto', Imag FROM [dbo].[Autos]";

                using (SqlCommand cmd = new SqlCommand(productosQuery, conn))
                {
                    using (SqlDataReader reader = cmd.ExecuteReader())
                    {

                        var carros = new List<Cars_Inner>();

                        while (reader.Read())
                        {
                            var carro = new Cars_Inner
                            {
                                ID_Autos = reader.GetInt32(reader.GetOrdinal("ID_Autos")),
                                Marca = reader["Auto"].ToString(),
                                Imag = reader["Imag"].ToString()
                            };
                            carros.Add(carro);
                        }

                        productosHTML = "<div class='slick-track' id='track'>";
                        foreach (var item in carros)
                        {

                            string ItemsDelMenu = "<div class='slick'>";
                            ItemsDelMenu += "<div>";
                            ItemsDelMenu += "<a href='/Alquiler/Agregar'>";
                            ItemsDelMenu += $"<h4>{item.Marca}</h4>";
                            ItemsDelMenu += "<picture>";
                            ItemsDelMenu += $"<img src={item.Imag} alt={item.Marca}>";
                            ItemsDelMenu += "</picture>";
                            ItemsDelMenu += "</a>";
                            ItemsDelMenu += "</div>";
                            ItemsDelMenu += "</div>";

                            productosHTML += ItemsDelMenu;

                        }
                        productosHTML += "</div>";
                    }
                }
                conn.Close();
            }
            return productosHTML;
        }
    }
}