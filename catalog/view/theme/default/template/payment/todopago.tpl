<form action="<?php echo $action; ?>" method="post">
	<input type="hidden" name="order_id" value="<?php echo $order_id ?>"/> 
	
	<div class="buttons" id="imagen">
		<div class="pull-left">
	        <img src="catalog/view/theme/default/image/todopago.jpg" />
        </div>
        <div class="pull-right" id="botones">
        	<br />
            	        <input type="submit" id="boton_pago" value="Confirmar Pago" class="btn btn-primary" />
		</div>
	</div>
</form>
