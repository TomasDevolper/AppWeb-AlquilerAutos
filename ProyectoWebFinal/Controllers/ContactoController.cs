using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace ProyectoWebFinal.Controllers
{
    public class ContactoController : Controller
    {
        // GET: Contacto
        public ActionResult Ingresar()
        {
            var path = "~/Views/Contacto/WFContacto.aspx";
            Response.Clear();
            Server.Execute(path);
            Response.End();
            return null;
        }

        public ActionResult Ingresar2()
        {
            var path = "~/Views/Contacto/WFContacto2.aspx";
            Response.Clear();
            Server.Execute(path);
            Response.End();
            return null;
        }
    }
}