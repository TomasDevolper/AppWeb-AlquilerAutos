<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WFListaAutos.aspx.cs" Inherits="ProyectoWebFinal.Views.Autos.WFListaAutos" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
 <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

 <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">

 <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
 <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
    <link href="../../Recursos/EstiloPrincipal.css" rel="stylesheet" />

 <!-- jqGrid CSS and JS references -->
 <link href="http://trirand.com/blog/jqgrid/themes/redmond/jquery-ui-custom.css" rel="stylesheet" />
 <link href="http://trirand.com/blog/jqgrid/themes/ui.jqgrid.css" rel="stylesheet" />
 <link href="http://trirand.com/blog/jqgrid/themes/ui.multiselect.css" rel="stylesheet" />
 <script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>

 <!-- Additional existing references -->
 <link rel="preload" as="script" crossorigin="anonymous" href="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js">
 <link rel="preload" as="script" crossorigin="anonymous" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js">

</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="display: flex;flex-direction: column;align-items: center;" class="fondo">
        <form id="form1" >
            <div>
                <div>
                    <h1 style="background: #fff7c0;padding: 10px 50px;margin: 10px 0 20px 0;border: black solid 1px;border-radius: 15px;text-align: center;">AUTOS</h1>
                </div>
                <table id="jqGrid"></table>
                <div id="jqGridPager"></div> 
            </div>
             <asp:HiddenField ID="HiddenField1" runat="server" />
        </form>     
    </div> 
   <!-- Model edit -->
<div id="editModal" class="modal fade" tabindex="-1" aria-hidden="true"  >
  <div class="modal-dialog" >
    <div class="modal-content">
	      <div class="modal-header">
			    <h5 class="modal-title">Editar Auto</h5>
			    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
			    </button>
	      </div>

        <div class="modal-body">
		    <input type="hidden" id="editCode" class="form-control">

		    <div>
			    <label>Marca Auto</label>
			    <input type="text" id="editMarca" class="form-control" >
		    </div>

            <div>
                <label>Modelo Auto</label>
                <input type="text" id="editModelo" class="form-control" >
            </div>

		    <div>
			    <label>Año</label>
			    <input type="text" id="editAño" class="form-control" >
		    </div>

            <div>
                <label>Color</label>
                <input type="text" id="editColor" class="form-control" >
            </div>

            <div>
                <label>Precio</label>
                <input type="text" id="editPrecio" class="form-control" >
            </div>

	    </div>

	    <div class="modal-footer">
		    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
		    <button type="button" class="btn btn-primary" id="saveEdit">Save changes</button>
	    </div>

    </div>
  </div>
</div>

<!-- Model Delete -->
<div id="deleteModal" class="modal fade" tabindex="-1" role="dialog" aria-hidden="true"  >
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
	    <h5 class="modal-title">Eliminar Auto</h5>
	    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	      <span aria-hidden="true">&times;</span>
	    </button>
      </div>
      <div class="modal-body">
	    <p>ESTAS SEGURO DE ELIMINAR? SEGUROOOOO-........?</p>
      </div>
      <div class="modal-footer">
	    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
	    <button type="button" class="btn btn-primary">Save changes</button>
      </div>
    </div>
  </div>
</div>

    <script type="text/javascript">
        $(document).ready(function () {

            var dataObjeto = $("#<%= HiddenField1.ClientID %>").val();
            var usuariosData = JSON.parse(dataObjeto);

            $("#jqGrid").jqGrid({
                datatype: "local",
                data: usuariosData,
                colModel: [
                    { label: "Codigo Autos", name: "ID_Autos", key: true, width: 150 },
                    { label: "Matricula", name: "Matricula", width: 150 },
                    { label: "Marca", name: "Marca", width: 150 },
                    { label: "Modelo", name: "Modelo", width: 150 },
                    { label: "Año", name: "Año", width: 150 },
                    { label: "Color", name: "Color", width: 150 },
                    { label: "Precio", name: "Precio", width: 150 },
                    { label: "Disponibilidad", name: "Disponibilidad", width: 150 },
                    { label: "Select", name: "Select", width: 100, formatter: selectButtonFormater },

                    { label: "Edit", name: "edit", width: 70, formatter: editButtonFormater },
                    { label: "Delete", name: "delete", width: 70, formatter: deleteButtonFormater }
                ],
                pager: "#jqGridPager",
                height: 200,
                width: 900,
                rowNum: 20,
                viewrecords: true
            });

            $("#jqGrid").on("click", ".btn-delete", function (event) {

                var selectId = $(this).data("id");

                if (confirm("Estás seguro de eliminar el registro seleccionado?")) {
                    $.ajax({
                        url: '/Autos/EliminarAuto',
                        type: 'POST',
                        data: { ID_Autos: selectId },
                        success: function (response) {
                            if (response.success) {
                                alert(response.message);
                                location.reload();
                            } else {
                                alert("Error al eliminar Auto:" + response.message);
                            }
                        },
                        error: function (error) {
                            alert("Error en el servidor");
                        }
                    });
                }
            });

            $("#editCode").prop("readonly", true);
            $("#saveEdit").click(function (e) {

                var formData = new FormData();
                formData.append("Marca", $("#editMarca").val());
                formData.append("Modelo", $("#editModelo").val());
                formData.append("Año", $("#editAño").val());
                formData.append("Color", $("#editColor").val());
                formData.append("Precio", $("#editPrecio").val());
                formData.append("ID_Autos", $("#editCode").val());

                $(".block-ui").show();
                // Inicio de ajax
                $.ajax({
                    type: "POST",
                    url: "/Autos/ActualizarAuto",
                    data: formData,
                    contentType: false,
                    processData: false,

                    success: function (response) {

                        setTimeout(function () {
                            $(".block-ui").hide();
                            alert("Actualización Exitosa");
                            location.reload();
                        }, 2000);
                        //location.reload();
                    },
                    error: function (error) {
                        $(".block-ui").hide();
                        alert("Error al actualizar: " + error.responseText);
                    }
                });
            });


            function selectButtonFormater(cellValue, options, rowObject) {
                return "<button type='button' class='btn-select' data-id='" + rowObject.ID_Autos + "'   > Seleccionar </button>";
            }

            function editButtonFormater(cellValue, options, rowObject) {
                return "<i class='fas fa-edit btn-edit' data-id='" + rowObject.ID_Autos + "' ></i>";
            }

            function deleteButtonFormater(cellValue, options, rowObject) {
                return "<i class='fas fa-trash-alt btn-delete' data-id='" + rowObject.ID_Autos + "' ></i>";
            }

            $("#jqGrid").on("click", ".btn-edit", function (event) {

                var selectId = $(this).data("id");
                var rowData = $("#jqGrid").jqGrid('getRowData', selectId);
                openEditModal(rowData.ID_Autos, rowData.Marca, rowData.Modelo, rowData.Año, rowData.Color, rowData.Precio)
            });

            $("#jqGrid").on("click", ".btn-delete", function (event) {

                var selectId = $(this).data("id");

                openDeleteModal(selectId);

            });

            function openDeleteModal(ID_Autos) {
                $("#deleteModal").modal('show');
            }

            function openEditModal(ID_Autos, Marca, Modelo, Año, Color, Precio) {

                $("#editCode").val(ID_Autos);
                $("#editMarca").val(Marca);
                $("#editModelo").val(Modelo);
                $("#editAño").val(Año);
                $("#editColor").val(Color);
                $("#editPrecio").val(Precio);

                $("#editModal").modal('show');
            }
        });
    </script> 

</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="DetailContent" runat="server">
</asp:Content>
