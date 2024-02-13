using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;

namespace ProyectoWebFinal.Models
{
    public class Usuarios
    {
        public int ID_Usuario { get; set; }
        public string Nombre { get; set; }
        public string Email { get; set; }
        public string Contraseña { get; set; }
        public Rol ID_Rol { get; set; }
    }
}