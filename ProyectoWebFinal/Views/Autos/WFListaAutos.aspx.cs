using ProyectoWebFinal.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Serialization;
using System.Web.UI;
using System.Web.UI.WebControls;

namespace ProyectoWebFinal.Views.Autos
{
    public partial class WFListaAutos : System.Web.UI.Page
    {
        protected void Page_Load(object sender, EventArgs e)
        {
            if (!IsPostBack)
            {
                var autos = HttpContext.Current.Items["Auto"] as List<Cars_Inner>;

                if (autos != null)
                {
                    var serializer = new JavaScriptSerializer();
                    HiddenField1.Value = serializer.Serialize(autos);

                }
            }
        }
    }
}