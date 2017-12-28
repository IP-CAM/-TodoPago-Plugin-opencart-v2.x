<?php if(empty($extension)){ echo $header; }?>
<?php if(empty($extension)){ echo $column_left; }?>
<div id="content">
  <div class="page-header">
    <div class="container-fluid">
      <h1>TodoPago (<?php echo $todopago_version; ?>)</h1>
      <div class="pull-right"><a id="continueButton" class="btn btn-danger" data-toggle="<?php echo $button_continue_text; ?>"><i class="fa fa-check"></i></a></div>
    </div>
  </div>
   <div class="container-fluid">
       <div class="panel panel-danger">
           <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-minus-circle"></i> Desinstalaci&oacute;n de la extensi&oacute;n.</h3>
           </div>
           <div class="panel-body">
                <p>Seleccione los campos :</p>
              <form id="form" action="<?php echo $button_continue_action; ?>" method="post" enctype="smultipart/form-data">
                <ul>
                   <li>
                    <input type="checkbox" checked="true" id="check_todopago_transaccion" name="drop_table_todopago_transaccion"> Eliminar tabla <em>todopago_transaccion</em>, esta lleva un registro de las transacciones hechas con el medio de pago en caso de hacerlo, ya no podr&aacute; hacer un get status de las transacciones guardadas si reinstala el plugin (Las transacciones se mantendr&aacute;n en el registro del ecommerce, seleccionelo si est&aacute; seguro de que no volver&aacute; a instalar el medio.</input>
                   </li>
                    <li>
                        <input type="checkbox" checked="true" id="check_postcode_required" name="revert_postcode_required"> Se setear&aacute; el c&oacute;digo postal como no obligatorio para Argentina. (Cuando se instal&oacute; la extensi&oacute;n este se puso obligatorio)</input></li>
                    <li><input type="checkbox" checked="true" id="check_cs_code" name="drop_column_cs_code"> Se eliminar&aacute; la columna agregada a la tabla de zonas que tiene el c&oacute;digo de las provincias argentinas necesario para el pago por este medio.</input></li>
                    </ul>
                </form>
           </div>
       </div>
    </div>
</div>
<script type="text/javascript"><!--

    window.onkeydown= function(){

	return (event.keyCode != 116) && (event.keyCode == 154);
	}
	history.pushState(null, null, 'index.php?route=<?php echo $extension; ?>payment/todopago/confirmInstallation&token=8cddbffc58936e11a463b38a37cd8cf0');
    window.addEventListener('popstate', function(event) {
    history.pushState(null, null, 'index.php?route=<?php echo $extension; ?>payment/todopago/confirmInstallation&token=8cddbffc58936e11a463b38a37cd8cf0');
    });
    var clickpermitido = false;
    $('#continueButton').bind('click', function (e){
        clickpermitido = true;
        $('#form').submit();
    });
    $(window).bind('beforeunload', function(e){

        e = e || window.event;

        if (clickpermitido){
            return;
        }
        e.preventDefault();
        e.stopPropagation();
        return "<?php echo $back_button_message; ?>";
    });
//--></script>
<?php if(empty($extension)){ echo $footer; }?>
