<%@ Page Title="" Language="C#" MasterPageFile="~/Site1.Master" AutoEventWireup="true" CodeBehind="WFListaAlquiler.aspx.cs" Inherits="ProyectoWebFinal.Views.Alquiler.WFListaAlquiler" %>
<asp:Content ID="Content1" ContentPlaceHolderID="head" runat="server">
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">

<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css" rel="stylesheet">

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>


<!-- jqGrid CSS and JS references -->
<link href="http://trirand.com/blog/jqgrid/themes/redmond/jquery-ui-custom.css" rel="stylesheet" />
<link href="http://trirand.com/blog/jqgrid/themes/ui.jqgrid.css" rel="stylesheet" />
<link href="http://trirand.com/blog/jqgrid/themes/ui.multiselect.css" rel="stylesheet" />
<script src="https://cdnjs.cloudflare.com/ajax/libs/free-jqgrid/4.15.5/jquery.jqgrid.min.js"></script>

<!-- Additional existing references -->
<link rel="preload" as="script" crossorigin="anonymous" href="https://cdnjs.cloudflare.com/ajax/libs/jquery/1.12.4/jquery.min.js">
<link rel="preload" as="script" crossorigin="anonymous" href="https://cdnjs.cloudflare.com/ajax/libs/jqueryui/1.11.4/jquery-ui.min.js">
    <link href="../../Recursos/EstiloPrincipal.css" rel="stylesheet" />
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="MainContent" runat="server">
    <div style="display: flex;flex-direction: column;align-items: center;" class="fondo">
        <form id="form1" >
            <div>
                <div>
                    <h1 style="background: #fff7c0;padding: 10px 50px;margin: 10px 0 20px 0;border: black solid 1px;border-radius: 15px;text-align: center;">Alquiler</h1>
                </div>
            </div>
             <asp:HiddenField ID="HiddenField1" runat="server" />

                <table id="jqGrid"></table>
                <div id="jqGridPager"></div> 
        </form>
    </div>
        <!-- Model edit -->
<div id="editModal" class="modal fade" tabindex="-1" aria-hidden="true"  >
  <div class="modal-dialog" >
    <div class="modal-content">
	      <div class="modal-header">
			    <h5 class="modal-title">Editar Alquiler</h5>
			    <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close">
			    </button>
	      </div>

        <div class="modal-body">
		    <input type="hidden" id="editCode" class="form-control">

		    <div>
			    <label>Documento</label>
			    <input type="text" id="editDocumento" class="form-control" >
		    </div>

            <div>
                <label>Brevete</label>
                <input type="text" id="editBrevete" class="form-control" >
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
	    <h5 class="modal-title">Modal Eliminar</h5>
	    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	      <span aria-hidden="true">&times;</span>
	    </button>
      </div>
      <div class="modal-body">
	    <p>Modal body text goes here.</p>
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
                { label: "Codigo", name: "ID_Alquiler", key: true, width: 150 },
                { label: "Nombre", name: "Nombre", width: 150 },
                { label: "TipoDocumento", name: "ID_TipoDocumento", width: 150 },
                { label: "Documento", name: "Documento", width: 150 },
                { label: "TipoBrevete", name: "ID_TipoBrevete", width: 150 },
                { label: "Brevete", name: "Brevete", width: 150 },
                { label: "Marca", name: "Marca", width: 150 },
                { label: "Modelo", name: "Modelo", width: 150 },
                { label: "Dias", name: "Dias", width: 150 },
                { label: "Precio", name: "Precio", width: 150 },
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
                    url: '/Alquiler/EliminarAlquiler',
                    type: 'POST',
                    data: { ID_Alquiler: selectId },
                    success: function (response) {
                        if (response.success) {
                            alert(response.message);
                            location.reload();
                        } else {
                            alert("Error al eliminar vendedor:" + response.message);
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
            formData.append("Documento", $("#editDocumento").val());
            formData.append("Brevete", $("#editBrevete").val());
            formData.append("ID_Alquiler", $("#editCode").val());

            $(".block-ui").show();
            // Inicio de ajax
            $.ajax({
                type: "POST",
                url: "/Alquiler/ActualizarAlquiler",
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
            return "<button type='button' class='btn-select' data-id='" + rowObject.ID_Alquiler + "'   > Seleccionar </button>";
        }

        function editButtonFormater(cellValue, options, rowObject) {
            return "<i class='fas fa-edit btn-edit' data-id='" + rowObject.ID_Alquiler + "' ></i>";
        }

        function deleteButtonFormater(cellValue, options, rowObject) {
            return "<i class='fas fa-trash-alt btn-delete' data-id='" + rowObject.ID_Alquiler + "' ></i>";
        }

        $("#jqGrid").on("click", ".btn-edit", function (event) {

            var selectId = $(this).data("id");
            var rowData = $("#jqGrid").jqGrid('getRowData', selectId);
            openEditModal(rowData.ID_Alquiler, rowData.Documento, rowData.Brevete)
        });

        $("#jqGrid").on("click", ".btn-delete", function (event) {

            var selectId = $(this).data("id");

            openDeleteModal(selectId);

        });

        function openDeleteModal(ID_Alquiler) {
            $("#deleteModal").modal('show');
        }

        function openEditModal(ID_Alquiler, Documento, Brevete) {

            $("#editCode").val(ID_Alquiler);
            $("#editDocumento").val(Documento);
            $("#editBrevete").val(Brevete);

            $("#editModal").modal('show');
        }
    });
</script> 
   
</asp:Content>
<asp:Content ID="Content3" ContentPlaceHolderID="DetailContent" runat="server">
</asp:Content>
