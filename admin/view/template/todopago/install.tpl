<?php if(empty($extension)){ echo $header; }?>
<?php if(empty($extension)){ echo $column_left; }?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
          <h1>TodoPago (<?php echo $todopago_version; ?>)</h1>
          <div class="pull-right">
              <a id="install-button" class="btn btn-success" data-toggle="<?php echo $install_button_text; ?>"><i class="fa fa-check"></i></a>
              <a id="cancel-button" class="btn btn-default" data-toggle="<?php echo $cancel_button_text; ?>"><i class="fa fa-reply"></i></a>
          </div>
        </div>
    </div>
    <div class="container-fluid">
      <div class="panel panel-success">
       <div class="panel-heading">
        <h3 class="panel-title"><i class="fa fa-plus-circle"></i> Instalaci&oacute;n de la extensi&oacute;n.</h3>
       </div>
       <div class="panel-body">
        <p>Se le informa que se realizar&aacute;n los siguientes cambios:</p>
        <ul>
            <li>Se agregar&aacute; una tabla <em>todopago_transaccion</em> a su base de datos la cu&aacute;l guardar&aacute; informaci&oacute;n sobre las transacciones realizadas por el medio de pago.</li>
            <li>Se setear&aacute; el c&oacute;digo postal obligatoria para Argentina. (Esto se debe a que por cuestones de seguridad aquellos clientes que no tengan c&oacute;digo postal no podr&aacute;n pagar con este medio).</li>
            <li>Se agregar&aacute; una nueva culumna a la tabla de zonas asignando un nuevo c&oacute;digo a las provincias argentinas necesario para el pago.</li>
        </ul>
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
    history.pushState(null, null, 'index.php?route=<?php echo $extension; ?>payment/todopago/confirmIninstallation&token=8cddbffc58936e11a463b38a37cd8cf0');
    });

    var clickpermitido = false;
    $('#install-button').bind('click', function(){
        clickpermitido = true;
        window.location = "<?php echo $install_button_action; ?>";
    });

    $('#cancel-button').bind('click', function(){
        clickpermitido = true;
        window.location = "<?php echo $cancel_button_action; ?>";
    });

    $(window).bind('beforeunload', function(e){

        e = e || window.event;

        if (clickpermitido){
            return;
        }
        e.preventDefault();
        e.stopPropagation();
        $.post("<?php echo $cancel_button_action; ?>", function(data){});
        return "<?php echo $back_button_message; ?>";
    });
//--></script>
<?php if(empty($extension)){ echo $footer; }?>
