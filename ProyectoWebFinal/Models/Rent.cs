using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProyectoWebFinal.Models
{
    public class Rent
    {
        public int ID_Alquiler { get; set; }
        public string ID_Usuario { get; set; }
        public int ID_TipoDocumento { get; set; }
        public string Documento { get; set; }
        public int ID_TipoBrevete { get; set; }
        public string Brevete { get; set; }
        public int ID_Auto { get; set; }
        public int Dias { get; set; }
        public decimal Precio { get; set; }
    }
}