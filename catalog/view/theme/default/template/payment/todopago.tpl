

<form action="<?php echo $action; ?>" method="post">
	<input type="hidden" name="order_id" value="<?php echo $order_id ?>"/> 
	
	<div class="buttons" id="imagen">
		<div class="pull-left">
	        <img src="catalog/view/theme/default/image/todopago.jpg" />
        </div>
        <div class="pull-right" id="botones">
        	<br />
        	<?php if($formulario=="hibrid") {?>
        		        <input type="button" onclick="first_step()" id="boton_pago" value="Confirmar Pago" class="btn btn-primary" />

	        <?php } else {?>
	        	        <input type="submit" id="boton_pago" value="Confirmar Pago" class="btn btn-primary" />

	        <?php } ?>
		</div>
	</div>
</form>

<div id="formualrio_hibrido" hidden>
	<div class="contentContainer">
		<div id="tp-form-tph">
			<div id="tp-logo"></div>
			<div id="tp-content-form">
				<span class="tp-label">Elegí tu forma de pago </span>
				<div>
					<select id="formaDePagoCbx"></select>	
				</div>
				<div>
					<select id="bancoCbx"></select>
				</div>
				<div>
					<select id="promosCbx" class="left"></select>
					<label id="labelPromotionTextId" class="left tp-label"></label>
					<div class="clear"></div>
				</div>
				<div>
					<input id="numeroTarjetaTxt"/>
				</div>
				<div class="dateFields">
		            <input id="mesTxt" class="left">
		            <span class="left spacer">/</span>
		            <input id="anioTxt" class="left">
		            <div class="clear"></div>
		      	</div>
				<div>
					<input id="codigoSeguridadTxt" class="left"/>
					<label id="labelCodSegTextId" class="left tp-label"></label>
					<div class="clear"></div>
				</div>
				<div>
					<input id="apynTxt"/>
				</div>
				<div>
					<select id="tipoDocCbx"></select>
				</div>
				<div>
					<input id="nroDocTxt"/>	
				</div>
				<div>
					<input id="emailTxt"/><br/>
				</div>
				<div id="tp-bt-wrapper">
					<button id="MY_btnConfirmarPago" class="tp-button"/>
					<button id="MY_btnPagarConBilletera" class="tp-button"/>
				</div>
			</div>	
		</div>

	</div>
</div>


<script>
var orderid = '<?php echo $order_id; ?>';

function first_step(){
$.post("http://localhost/opencart-2.1.0.2/upload/index.php?route=payment/todopago/first_step_todopago",{order_id:orderid},llegadaDatos);
}

function llegadaDatos(rta)
{
  rta_json = JSON.parse(rta);
  alert("ud paga con formulario hibrido ");
  alert(rta);
  $("#formualrio_hibrido").show();
  $("#botones").hide();
  $("#imagen").hide();
}
</script>
