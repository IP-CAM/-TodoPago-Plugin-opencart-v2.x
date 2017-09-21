<link href="catalog/view/theme/default/stylesheet/todopago_form.css" rel="stylesheet">

<div  class="pull-right button">
    <input type="button" id="comenzar_pago_btn" onclick="init_my_form()" class="btn btn-primary" value="Comenzar Pago"></button>
</div>

<script type="text/javascript">
    function init_my_form() {
        $.post( "<?php echo $action; ?>", {order_id: <?php echo($order_id); ?> }).done(function(data) {
            loadScript('<?php echo $script; ?>', function () {
                if (data) {
                    try {
                        var response = JSON.parse(data);
                        console.log(response);
                        if (response.hasOwnProperty('PublicRequestKey'))
                            loader(response.PublicRequestKey);
                        else
                            window.location.href = response.URL_ErrorPageHybrid;
                    } catch(e) {
                        console.log(e); // error in the above string (in this case, yes)!
                        window.location.href = "<?php echo $url_fail_page; ?>"
                    }
                } else {
                    window.location.href = "<?php echo $url_fail_page; ?>"
                }
            });
        });

        $("#loading-hibrid").css("width", "33%");
        $("#formulario_hibrido").show();
        $("#comenzar_pago_btn").hide();
        $("#progress").show();
    }
</script>

<!-- inicio formulario -->
<div id="progress" class="progress" hidden>
    <div class="progress-bar progress-bar-striped active" id="loading-hibrid" role="progressbar" aria-valuemin="0"
         aria-valuemax="100">
    </div>
</div>

<div id="formulario_hibrido" hidden>
    <div class="formuHibrido container-fluid" id="tpForm">
        <img src="https://portal.todopago.com.ar/app/images/logo.png" alt="todopago" id="todopago_logo">
        <!-- row  1 -->
        <div class="row">
            <div class="col-md-2">
                <select id="formaPagoCbx" class="input form-control"></select>
            </div>
            <div class="loaded-form">
                <div class="col-md-4">
                    <input id="numeroTarjetaTxt" class="input form-control">
                    <label id="numeroTarjetaLbl" for="numeroTarjetaTxt" class="warning"></label>
                </div>
                <div class="col-md-6 nombreTexto">
                    <input id="nombreTxt" class="input form-control">
                </div>
            </div>
        </div>

        <div class="loaded-form">
            <div class="row" id="row-pei">
                <div class="col-md-6 col-md-offset-2">
                    <div class="form-horizontal">
                        <div class="checkbox">
                            <input id="peiCbx" type="checkbox">
                            <label id="peiLbl" for="peiCbx"></label>
                        </div>
                    </div>
                </div>
            </div>
            <!-- row 2 -->
            <div class="row">
                <div class="col-md-2">
                    <select id="medioPagoCbx" class="input form-control"></select>
                </div>
                <div class="col-md-4">
                    <select id="bancoCbx" class="input form-control"></select>
                </div>
                <div class="col-md-2">
                    <select id="tipoDocCbx" class="input form-control"></select>
                </div>
                <div class="col-md-4">
                    <input id="nroDocTxt" class="input form-control">
                </div>
            </div>
            <!-- row 3 -->
            <div class="row">

                <div class="col-md-2">
                    <select id="mesCbx" class="input form-control"></select>
                </div>
                <div class="col-md-2">
                    <select id="anioCbx" class="input form-control"></select>
                    <label id="fechaLbl" class="warning"></label>
                </div>
                <div class="col-md-2">
                    <input id="codigoSeguridadTxt" class="input form-control">
                    <label id="codigoSeguridadLbl" for="codigoSeguridadTxt" class="warning"></label>
                </div>
                <div class="col-md-6">
                    <input id="emailTxt" class="input form-control">
                </div>
            </div>
            <!-- row 4 -->
            <div class="row">
                <div class="col-md-6">
                    <select id="promosCbx" class="input form-control"></select>
                </div>
                <div class="col-md-3">
                    <input id="tokenPeiTxt" class="input form-control">
                    <label id="tokenPeiLbl" for="tokenPeiTxt" class="warning"></label>
                </div>
            </div>
            <!-- row 5 -->
            <div class="row">
                <div class="col-md-2">
                    <label id="promosLbl" for="promosCbx"></label>
                </div>
            </div>
        </div>
        <!-- row 6 -->
        <div class="row">
            <button id="MY_btnPagarConBilletera" class="btn btn-primary pull-right"></button>
            <button id="MY_btnConfirmarPago" class="btn btn-primary pull-right"></button>
        </div>
    </div>
</div>

<script type="text/javascript">
    /************* CONFIGURACION DEL API *****************/

    function loadScript(url, callback) {
        var script = document.createElement("script");
        script.type = "text/javascript";
        if (script.readyState) {  //IE
            script.onreadystatechange = function () {
                if (script.readyState === "loaded" || script.readyState === "complete") {
                    script.onreadystatechange = null;
                    callback();
                }
            };
        } else {  //et al.
            script.onload = function () {
                callback();
            };
            script.onerror = function () {
                window.location.href = "<?php echo $url_second_step.'&Order='.$order_id.'&ResultMessage=' ?>" + "Falló la carga del formulario.";
            }
        }
        script.src = url;
        document.getElementsByTagName("head")[0].appendChild(script);
    }

    var formaDePago = document.getElementById("formaPagoCbx");
    formaDePago.addEventListener("click", function () {
        if (formaDePago.value === "1") {
            $(".loaded-form").show('fast');
        } else {
            $(".loaded-form").hide('fast');
        }
    });

    formaDePago.addEventListener('blur', function () {
        setTimeout(function () {
            peiLabelLoader();
        }, 200);
    });

    function peiLabelLoader() {
        console.log($("#peiCbx").css('display'));

    }
    
    function loader(publicRequestKey) {
        $("#loading-hibrid").css("width", "66%");
        setTimeout(function () {
            ignite(publicRequestKey);
        }, 100);
        setTimeout(function () {
            $("#loading-hibrid").css("width", "100%");
        }, 1000);
        setTimeout(function () {
            $(".progress").hide('fast');
        }, 1500);
        setTimeout(function () {
            $("#tpForm").fadeTo('fast', 1);
        }, 1700);
    }

    function ignite(publicRequestKey) {
        //  window.TPFORMAPI.hybridForm.constructDefaultForm("formContainer");
        window.TPFORMAPI.hybridForm.initForm({
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
        });
        /************* SETEO UN ITEM PARA COMPRAR ******************/
        window.TPFORMAPI.hybridForm.setItem({
            publicKey: publicRequestKey,
            defaultNombreApellido: '<?php echo $completeName; ?>',
            defaultNumeroDoc: '',
            defaultMail: '<?php echo $mail; ?>',
            defaultTipoDoc: 'DNI'
        });
    }

    /************ FUNCIONES CALLBACKS ************/

    function validationCollector(parametros) {
        console.log("Validando los datos");
        console.log(parametros.field + " -> " + parametros.error);
        var input = parametros.field;
        if (input.search("Txt") !== -1) {
            label = input.replace("Txt", "Lbl");
        } else {
            label = input.replace("Cbx", "Lbl");
        }
        document.getElementById(label).innerHTML = parametros.error;
    }


    function billeteraPaymentResponse(response) {
        console.log("Iniciando billetera");
        console.log(response.ResultCode + " -> " + response.ResultMessage);
        if (response.AuthorizationKey) {
            window.location.href = "<?php echo $url_second_step.'&Order='.$order_id.'&Answer=' ?>" + response.AuthorizationKey;
        } else {
            window.location.href = "<?php echo $url_second_step.'&Order='.$order_id.'&ResultMessage=' ?>" + response.ResultMessage;
        }
    }

    function customPaymentSuccessResponse(response) {
        console.log("Success");
        console.log(response.ResultCode + " -> " + response.ResultMessage);
        window.location.href = "<?php echo $url_second_step.'&Order='.$order_id.'&Answer=' ?>" + response.AuthorizationKey;
    }

    function customPaymentErrorResponse(response) {
        console.log(response.ResultCode + " -> " + response.ResultMessage);
        if (response.AuthorizationKey) {
            window.location.href = "<?php echo $url_second_step.'&Order='.$order_id.'&Answer=' ?>" + response.AuthorizationKey;
        } else {
            window.location.href = "<?php echo $url_second_step.'&Order='.$order_id.'&ResultMessage=' ?>" + response.ResultMessage;
        }
    }

    function initLoading() {
        console.log('Loading...');
    }

    function stopLoading() {
        console.log('Stop loading...');
        var peiCbx = $("#peiCbx");
        var rowPei = $("#row-pei");
        if (peiCbx.css('display') !== 'none') {
            rowPei.show('fast');
        } else {
            rowPei.css("display", "none");
        }
    }
</script>
