using ProyectoWebFinal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProyectoWebFinal.Views.Alquiler
{
    public partial class WFListaAlquiler : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var docu = HttpContext.Current.Items["Alquiler"] as List<Rent_Inner>;

                if (docu != null)
                {
                    var serializer = new JavaScriptSerializer();
                    HiddenField1.Value = serializer.Serialize(docu);

                }
            }
        }
    }
}