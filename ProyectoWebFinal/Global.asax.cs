using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;
using System.Web.SessionState;

namespace ProyectoWebFinal
{
    public class Global : System.Web.HttpApplication
    {

        protected void Application_Start(object sender, EventArgs e)
        {
            //Limpiar las vistas
            ViewEngines.Engines.Clear();
            
            RegisterRoutes(RouteTable.Routes);
        }

        public static void RegisterRoutes(RouteCollection routes)
        {
            //Registrar session
            routes.MapRoute(
                name: "Default",
                url: "{controller}/{action}/{id}",
                defaults: new { Controller = "Acceso", action = "Login", id = UrlParameter.Optional }
                );

            //Registrar session
            routes.MapRoute(
                name: "Default1",
                url: "{controller}/{action}/{id}",
                defaults: new { Controller = "Acceso", action = "Register", id = UrlParameter.Optional }
                );

            //Registrar session
            routes.MapRoute(
                name: "Default2",
                url: "{controller}/{action}/{id}",
                defaults: new { Controller = "Alquiler", action = "Agregar", id = UrlParameter.Optional }
                );

            routes.MapRoute(
                name: "Default3",
                url: "{controller}/{action}/{id}",
                defaults: new { Controller = "Alquiler", action = "Listar", id = UrlParameter.Optional }
                );

            routes.MapRoute(
                name: "Default4",
                url: "{controller}/{action}/{id}",
                defaults: new { Controller = "Alquiler", action = "Agregar", id = UrlParameter.Optional }
                );

            routes.MapRoute(
                name: "Default5",
                url: "{controller}/{action}/{id}",
                defaults: new { Controller = "Autos", action = "Listar", id = UrlParameter.Optional }
                );

            routes.MapRoute(
                name: "Default6",
                url: "{controller}/{action}/{id}",
                defaults: new { Controller = "Autos", action = "Agregar", id = UrlParameter.Optional }
                );

            routes.MapRoute(
                name: "Default7",
                url: "{controller}/{action}/{id}",
                defaults: new { Controller = "Contacto", action = "Ingresar", id = UrlParameter.Optional }
                );

            routes.MapRoute(
                name: "Default8",
                url: "{controller}/{action}/{id}",
                defaults: new { Controller = "Principal", action = "Ingresar", id = UrlParameter.Optional }
                );
        }

        protected void Session_Start(object sender, EventArgs e)
        {

        }

        protected void Application_BeginRequest(object sender, EventArgs e)
        {

        }

        protected void Application_AuthenticateRequest(object sender, EventArgs e)
        {

        }

        protected void Application_Error(object sender, EventArgs e)
        {

        }

        protected void Session_End(object sender, EventArgs e)
        {

        }

        protected void Application_End(object sender, EventArgs e)
        {

        }
    }
}