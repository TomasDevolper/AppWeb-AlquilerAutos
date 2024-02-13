using ProyectoWebFinal.Models;
using System;
using System.Collections.Generic;
using System.Configuration;
using System.Data.SqlClient;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProyectoWebFinal.Views.Alquiler
{
    public partial class WFAgregarAlquiler : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var docu = HttpContext.Current.Items["Documento"] as List<Document>;

                if (docu != null)
                {
                    var serializer = new JavaScriptSerializer();
                    HiddenField1.Value = serializer.Serialize(docu);

                    ddlDocumento.DataSource = docu;
                    ddlDocumento.DataTextField = "Descripcion";
                    ddlDocumento.DataValueField = "ID_TipoDocumentoss";
                    ddlDocumento.DataBind();
                }
            }
            //Brevete
            if (!IsPostBack)
            {
                var brevete = HttpContext.Current.Items["Brevete"] as List<Brief>;


                if (brevete != null)
                {
                    var serializer = new JavaScriptSerializer();
                    HiddenField2.Value = serializer.Serialize(brevete);

                    ddlBrevete.DataSource = brevete;
                    ddlBrevete.DataTextField = "Descripcion";
                    ddlBrevete.DataValueField = "ID_TipoBrevetess";
                    ddlBrevete.DataBind();
                }
            }
            //Usuario
            if (!IsPostBack)
            {
                var usu = HttpContext.Current.Session["Usuario"] as Usuarios;

                if (usu != null)
                {                    
                    HiddenField3.Value = usu.ID_Usuario.ToString();
                    
                    ddlNombre.DataSource = new List<Usuarios> { usu };
                    ddlNombre.DataTextField = "Nombre";
                    ddlNombre.DataValueField = "ID_Usuario";
                    ddlNombre.DataBind();
                    ddlNombre.Enabled = false;
                }
            }

            //Autos
            if (!IsPostBack)
            {
                var auto = HttpContext.Current.Items["Auto"] as List<Cars>;

                if (auto != null)
                {
                    var serializer = new JavaScriptSerializer();
                    HiddenField4.Value = serializer.Serialize(auto);

                    ddlAuto.DataSource = auto;
                    ddlAuto.DataTextField = "Marca";
                    ddlAuto.DataValueField = "ID_Autos";
                    ddlAuto.DataBind();
                }
            }

            ((Site1)this.Master).CargarMenu();

        }

        private decimal ObtenerPrecioAutoDesdeBD(int idAuto)
        {
            
            string cnx = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            // Ejemplo de código para obtener el precio del auto desde la base de datos
            using (SqlConnection connection = new SqlConnection(cnx))
            {
                connection.Open();
                string sql = "SELECT Precio FROM Autos WHERE ID_Autos = @ID_Autos";
                using (SqlCommand command = new SqlCommand(sql, connection))
                {
                    command.Parameters.AddWithValue("@ID_Autos", idAuto);
                    return (decimal)command.ExecuteScalar();
                }
            }
        }

        protected void btnCalcularPrecio_Click(object sender, EventArgs e)
        {
            int diasAlquiler = int.Parse(txtDias.Value);

            // Aquí obtienes el ID del auto seleccionado
            int idAuto = int.Parse(ddlAuto.SelectedValue);
           
            decimal precioAuto = ObtenerPrecioAutoDesdeBD(idAuto);

            // Aquí calculas el precio total del alquiler
            decimal precioAlquiler = precioAuto * diasAlquiler;

            // Asignar el valor al ddl
            txtPrecio.Value = precioAlquiler.ToString();
        }

        protected void ddlAuto_SelectedIndexChanged(object sender, EventArgs e)
        {
            if (IsPostBack && !string.IsNullOrEmpty(ddlAuto.SelectedValue))
            {
                // Aquí puedes obtener la información del auto seleccionado y cargar la imagen
                string imagPath = ObtenerPathDeImagen(ddlAuto.SelectedValue);

                if (!string.IsNullOrEmpty(imagPath))
                {
                    imgAuto.ImageUrl = imagPath;
                }
            }
            ((Site1)this.Master).CargarMenu();
        }

        private string ObtenerPathDeImagen(string autoId)
        {
            // Ejemplo de conexión a la base de datos y consulta
            string connectionString = ConfigurationManager.ConnectionStrings["DefaultConnection"].ConnectionString;
            using (SqlConnection connection = new SqlConnection(connectionString))
            {
                connection.Open();

                string query = "SELECT Imag FROM Autos WHERE ID_Autos = @AutoId";
                using (SqlCommand command = new SqlCommand(query, connection))
                {
                    command.Parameters.AddWithValue("@AutoId", autoId);
                    return command.ExecuteScalar() as string;
                }
            }
        }

    }
}