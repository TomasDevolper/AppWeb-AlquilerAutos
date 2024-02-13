using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProyectoWebFinal.Models
{
    public class Cars
    {
        public int ID_Autos { get; set; }
        public string Matricula { get; set; }
        public string Marca { get; set; }
        public string Modelo { get; set; }
        public string Año { get; set; }
        public string Color { get; set; }
        public decimal Precio { get; set; }
        public HttpPostedFileBase Imag { get; set; }
        public Boolean Disponibilidad { get; set; }
        public string Auto { get; set; }
    }
}