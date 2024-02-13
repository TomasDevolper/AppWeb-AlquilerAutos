using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProyectoWebFinal.Models
{
    public class Rent_Inner
    {
        public int ID_Alquiler { get; set; }
        public string Nombre { get; set; }
        public string ID_TipoDocumento { get; set; }
        public string Documento { get; set; }
        public string ID_TipoBrevete { get; set; }
        public string Brevete { get; set; }
        public string Marca { get; set; }
        public string Modelo { get; set; }
        public string Dias { get; set; }
        public string Precio { get; set; }
    }
}