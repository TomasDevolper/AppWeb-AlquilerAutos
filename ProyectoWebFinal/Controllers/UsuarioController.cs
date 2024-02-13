using ProyectoWebFinal.Models;
using System;
using System.Collections.Generic;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProyectoWebFinal.Controllers
{
    public class UsuarioController : Controller
    {
        // GET: Usuario
        public ActionResult Ingresar()
        {
            var path = "~/Views/Usuario/WFUsuario.aspx";
            Response.Clear();
            Server.Execute(path);
            Response.End();
            return null;
        }        
        
    }
}