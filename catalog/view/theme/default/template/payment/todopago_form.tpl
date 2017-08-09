<?php if ($ambiente == "test") { ?>
	<script type="text/javascript" src="https://developers.todopago.com.ar/resources/TPHybridForm-v0.1.js"></script>
<?php } else { ?>
	<script type="text/javascript" src="https://forms.todopago.com.ar/resources/TPHybridForm-v0.1.js"></script>
<?php } ?>
<div  class="pull-right button">
<input type="button" id="comenzar_pago_btn" onclick="init_my_form()" class="btn btn-primary" value="Comenzar Pago"></button>
</div>
<script type="text/javascript">
	function init_my_form(){
		todopago_init_form();
		todopago_hybrid_form();
		$("#formualrio_hibrido").show();
		$("#comenzar_pago_btn").hide();
	}
	
</script>

<?php
$ch = curl_init();

curl_setopt($ch, CURLOPT_URL,$action);
curl_setopt($ch, CURLOPT_POST, 1);
curl_setopt($ch, CURLOPT_POSTFIELDS,
            "order_id=$order_id");


// receive server response ...
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

$server_output = curl_exec ($ch);
$rta_server = json_decode($server_output);

curl_close ($ch);

if ($rta_server->StatusCode != -1) {
?>
	<script>window.location.href = "<?php echo $rta_server->URL_ErrorPageHybrid; ?>"</script>
<?php
}
?>

<div id="formualrio_hibrido" class="table-responsive" hidden>
	<table class="table table-bordered table-hover">
		<thead>
			<tr>
				<td colspan="2">
				<div id="tp-logo"></div>
				<p class="tp-label">Elegí tu forma de pago </p></td>
			</tr>
		</thead>

		<tbody>

			<tr>
				<td width="50%">
					<div>
						<select id="formaDePagoCbx" class="form-control"></select>	
					</div>
				</td>
				<td>
					<div>
						<select id="bancoCbx" class="form-control"></select>
					</div>
				</td>
			</tr>

			<tr>
				<td colspan="2">
					<div>
						<select id="promosCbx" class="form-control"></select>
						<label id="labelPromotionTextId" class="left"></label>
					</div>
				</td>
			</tr>

			<!-- Para los casos en el que el comercio opera con PEI -->
			<tr>
				<td colspan="2">
					<div>
						<input id="peiCbx" />
						<label id="labelPeiCheckboxId"></label>
					</div>
					<div>
						<input id="peiTokenTxt" class="left form-control text-box single-line" />
						<label id="labelPeiTokenTextId"></label>
					</div><br/>
				</td>
			</tr>

			<tr>
				<td>
					<div>
						<input id="numeroTarjetaTxt"  class="form-control left" />
					</div>
				</td>
				<td>
					<div>
						<input id="codigoSeguridadTxt" class="form-control left" />
						<label id="labelCodSegTextId" ></label>
					</div>
				</td>
			</tr>

			<tr>
				<td colspan="2">
					<input id="mesTxt" />
					/
					<input id="anioTxt" />
				</td>
			</tr>

			<tr>
				<td colspan="2">
					<div>
						<input id="apynTxt" class="left form-control" />
					</div>
				</td>
			</tr>
				
			<tr>
				<td>
					
						<select id="tipoDocCbx" class="form-control" ></select>
					
				</td>
				<td>
						<input id="nroDocTxt" class="form-control" />					
				</td>
			</tr>

			<tr>
				<td colspan="2">
					<div >
						<input id="emailTxt" class="left form-control" />
					</div>
				</td>
			</tr>

		</tbody>
		<tfoot>
		
		</tfoot>

	</table>
	
		
		<div  class="pull-right">
				<input type="button" class="btn btn-primary" id="MY_btnConfirmarPago" class="button" value="Pagar"/>
		</div>
	
		<div  class="pull-right">
				<input type="button" class="btn btn-primary" id="MY_btnPagarConBilletera" class="button" value="Pagar con Billetera"/>
		</div>
</div>

	<script>
				
		var orderid = '<?php echo $order_id; ?>';


		//securityRequesKey, esta se obtiene de la respuesta del SAR
		var security = "<?php echo $rta_server->PublicRequestKey; ?>";
		var mail = "<?php echo $mail; ?>";
		var completeName = "<?php echo $completeName; ?>";
		var dni = '';
		var defDniType = 'DNI'
			
		/************* CONFIGURACION DEL API ************************/
		function todopago_init_form()
			{window.TPFORMAPI.hybridForm.initForm({
			callbackValidationErrorFunction: 'validationCollector',
			callbackBilleteraFunction: 'billeteraPaymentResponse',
            callbackCustomSuccessFunction: 'customPaymentSuccessResponse',
            callbackCustomErrorFunction: 'customPaymentErrorResponse',
            botonPagarId: 'MY_btnConfirmarPago',
            botonPagarConBilleteraId: 'MY_btnPagarConBilletera',
            modalCssClass: 'modal-class',
            modalContentCssClass: 'modal-content',
            beforeRequest: 'initLoading',
            afterRequest: 'stopLoading'
		});}
		/************* SETEO UN ITEM PARA COMPRAR ************************/
        function todopago_hybrid_form(){
        window.TPFORMAPI.hybridForm.setItem({
            publicKey: security,
            defaultNombreApellido: completeName,
            defaultNumeroDoc: dni,
            defaultMail: mail,
            defaultTipoDoc: defDniType
        });
		}
		//callbacks de respuesta del pago
		function validationCollector(parametros) {
			console.log("My validator collector");
			console.log(parametros.field + " ==> " + parametros.error);
			console.log(parametros);
		}
		function customPaymentSuccessResponse(response) {
			console.log("My custom payment success callback");
			console.log(response.ResultCode + " : " + response.ResultMessage);
			
			window.location.href = "<?php echo $url_second_step.'&Order='.$order_id.'&Answer=' ?>"+response.AuthorizationKey;
		}
		
		function billeteraPaymentResponse(response) {
			console.log("My wallet callback");
			console.log(response.ResultCode + " : " + response.ResultMessage);
            
            if (response.AuthorizationKey) {
				window.location.href = "<?php echo $url_second_step.'&Order='.$order_id.'&Answer=' ?>"+response.AuthorizationKey;
			} else {
				window.location.href = "<?php echo $url_second_step.'&Order='.$order_id.'&ResultMessage=' ?>"+response.ResultMessage;
			}
		}

		function customPaymentErrorResponse(response) {
			console.log("Mi custom payment error callback");
			console.log(response.ResultCode + " : " + response.ResultMessage);
			console.log(response);
			
			if (response.AuthorizationKey) {
				window.location.href = "<?php echo $url_second_step.'&Order='.$order_id.'&Answer=' ?>"+response.AuthorizationKey;
			} else {
				window.location.href = "<?php echo $url_second_step.'&Order='.$order_id.'&ResultMessage=' ?>"+response.ResultMessage;
			}
		}
		function initLoading() {
			console.log('Cargando');
		}
		function stopLoading() {
			console.log('Stop loading...');
		} 	


</script>
<style type="text/css">

		#tp-logo{
			background-image: url("https://portal.todopago.com.ar/app/images/logo.png");
			background-repeat: no-repeat;
			height:40px;
			width:110px;
			margin: 0 0 0 14px;
		}
	</style>
