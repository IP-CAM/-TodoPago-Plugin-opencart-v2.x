<link href="catalog/view/theme/default/stylesheet/todopago_form.css" rel="stylesheet">

<div class="pull-right button">
    <input type="button" id="comenzar_pago_btn" onclick="init_my_form()" class="btn btn-primary"
           value="Comenzar Pago"></button>
</div>
<script type="text/javascript">
    function parseAnswerSAR(data) {
        var response;
        try {
            response = JSON.parse(data);
        } catch (e) {
            console.log("ERROR:" + e);
            response = false;
        }
        return response;
    }
    function sliceAnswerSAR(data) {
        var pos = data.indexOf('<?php echo $bracket; ?>');
        var response = data.slice(pos);
        console.log(response);
        response = parseAnswerSAR(response);
        if (response === false) {
            window.location.href = "<?php echo $url_fail_page; ?>"
        } else {
            return response;
        }
    }


    function init_my_form() {
        $.post("<?php echo $action; ?>", {order_id: <?php echo($order_id); ?> }).done(function (data) {
            loadScript('<?php echo $script; ?>', function () {
                if (data) {
                    console.log(data);
                    var response = parseAnswerSAR(data);
                    if (response === false) {
                        response = sliceAnswerSAR(data);
                    }
                    if (response.StatusCode === 702 || response === false) {
                        console.log(e); // error in the above string (in this case, yes)!
                        window.location.href = "<?php echo $url_fail_page; ?>"
                    }
                    if (response.hasOwnProperty('PublicRequestKey')) {
                        loader(response.PublicRequestKey);
                    } else {
                        window.location.href = response.URL_ErrorPageHybrid;
                    }
                }
            });
        });

        $("#loading-hibrid").css("width", "33%");
        $("#contenedor-formulario").show('slow');
        $("#tp-form").css("opacity", 0);
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

<!-- inicio formulario -->
<div id="contenedor-formulario">
    <div class="formu-hibrido container-fluid" id="tp-form">
        <img src="https://portal.todopago.com.ar/app/images/logo.png" alt="todopago" id="todopago-logo">
        <div class="tp-container">
            <div id="tp-container-billetera">
                <span class="tp-title">Pagá con tu Billetera Virtual Todo Pago y evitá cargar los datos de tu tarjeta.</span>
                <button id="MY_btnPagarConBilletera" class="tp-btn tp-pull-right tp-button-billetera">Iniciar sesión
                </button>
            </div>
        </div>
        <!-- row  1 -->
        <div class="row">
            <select id="formaPagoCbx" class="tp-input "></select>
        </div>
        <div class="loaded-form">
            <div class="tp-container">
                <div class="tp-row">
                    <span class="tp-title">Pagar con tu tarjeta de débito o crédito</span>
                </div>
                <div class="tp-row" id="row-pei">
                    <div class="tp-col-2">
                        <div class="switch" id="switch-pei">
                            <input id="peiCbx" class="pull-left" type="checkbox">
                            <span class="slider round"></span>
                        </div>
                    </div>
                    <div class="tp-col-4">
                        <label id="peiLbl" for="peiCbx"></label>
                    </div>
                </div>
                <div class="tp-container-2-columns">
                    <div class="tp-col tp-col-sm-4 tp-col-left">
                        <!-- row 1 -->
                        <div class="tp-row">
                            <input id="numeroTarjetaTxt" class="tp-input" tabindex="1">
                            <label id="numeroTarjetaLbl" for="numeroTarjetaTxt" class="warning"></label>
                        </div>
                        <!-- row 2 -->
                        <div class="tp-row">
                            <div class="tp-col tp-col-2">
                                <select id="mesCbx" class="tp-input" tabindex="2"></select>
                            </div>
                            <div class="tp-col tp-col-2">
                                <select id="anioCbx" class="tp-input" tabindex="3"></select>
                            </div>
                            <div class="tp-col tp-col-4">
                                <input id="codigoSeguridadTxt" class="tp-input" tabindex="4">
                            </div>
                        </div>
                        <!-- error row 2 -->
                        <div class="tp-row-error">
                            <div class="tp-col tp-col-4">
                                <label for="anioCbx" id="fechaLbl" class="warning"></label>
                            </div>
                            <div class="tp-col tp-col-4">
                                <label id="codigoSeguridadLbl" for="codigoSeguridadTxt" class="warning"></label>
                            </div>
                        </div>
                        <!-- row 3 -->
                        <div class="tp-row">
                            <input id="nombreTxt" class="tp-input" tabindex="5">
                        </div>
                        <!-- error row 3 -->
                        <div class="tp-row-error">
                            <label for="nombreTxt" id="nombreLbl" class="warning"></label>
                        </div>
                        <!-- row 4 -->
                        <div class="tp-row">
                            <select id="promosCbx" class="tp-input"></select>
                        </div>
                        <!-- row 5 -->
                        <div class="tp-row">
                            <input id="tokenPeiTxt" class="tp-input ">
                            <label id="tokenPeiLbl" for="tokenPeiTxt" class="warning"></label>
                        </div>
                    </div>
                    <div class="tp-col tp-col-sm-4 tp-col-right">
                        <!-- row 1 -->
                        <div class="tp-row">
                            <div class="tp-col-4">
                                <select id="medioPagoCbx" class="tp-input "></select>
                            </div>
                            <div class="tp-col-4">
                                <select id="bancoCbx" class="tp-input "></select>
                            </div>
                        </div>
                        <!-- row 2 -->
                        <div class="tp-row">
                            <div class="tp-col-2">
                                <select id="tipoDocCbx" class="tp-input "></select>
                            </div>
                            <div class="tp-col-6">
                                <input id="nroDocTxt" class="tp-input" tabindex="6">
                            </div>
                        </div>
                        <!-- error row 2 -->
                        <div class="tp-row-error">
                            <div class="tp-col-2">
                            </div>
                            <div class="tp-col-6">
                                <label for="nroDocTxt" id="nroDocLbl" class="warning"></label>
                            </div>
                        </div>
                        <!-- row 3 -->
                        <div class="tp-row">
                            <input id="emailTxt" class="tp-input ">
                        </div>
                        <!-- error row 3 -->
                        <div class="tp-row-error">
                            <label for="emailTxt" id="emailLbl" class="warning"></label>
                        </div>
                        <!-- row 4 -->
                        <div class="tp-row">
                            <label id="promosLbl" class="tp-cft" for="promosCbx"></label>
                        </div>
                        <!-- row 5-->
                        <div class="tp-row">
                            <button id="MY_btnConfirmarPago" class="tp-btn tp-btn-pagar pull-right"></button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- row 5 -->

    </div>
</div>

<script type="text/javascript">
    /************* CONFIGURACION DEL API *****************/

    function loadScript(url, callback) {
        var script = document.createElement("script");
        script.type = "text/javascript";
        script.src = url;

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

        document.getElementsByTagName("head")[0].appendChild(script);
    }

    var formaDePago = document.getElementById("formaPagoCbx");
    var peiChk = $("#peiCbx");

    formaDePago.addEventListener("click", function () {
        if (formaDePago.value === "1") {
            $(".loaded-form").show('fast');
        } else {
            $(".loaded-form").hide('fast');
            $("#switch-pei").css("display", "none");
        }
    });
    
    function initialFormaDePago() {
        if (formaDePago.value === "1") {
            $(".loaded-form").show('fast');
        }
    }

    function desplegarForm() {
        if (formaDePago.value === "1") {
            $(formaDePago).hide('fast');
            $(".loaded-form").show('fast');
        }
    }

    formaDePago.addEventListener('blur', function () {
        setTimeout(function () {
            peiLabelLoader();
        }, 200);
    });

    function getInitialPEIState() {
        return (peiChk.is(":disabled"));
    }

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
            initialFormaDePago();
        }, 1500);
        setTimeout(function () {
            $("#tp-form").fadeTo('fast', 1);
            desplegarForm();
        }, 1700);
    }

    function activateSwitch(soloPEI) {
        console.log("Solo PEI: " + soloPEI);
        if (!soloPEI) {
            $("#switch-pei").click(function () {
                if (!peiChk.prop("checked")) {
                    peiChk.prop("checked", true);
                } else {
                    peiChk.prop("checked", false);
                }
            });
        }
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
        if (document.getElementById(label) !== null)
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
            switchPei = $("#switch-pei");
            switchPei.css("display", "block");
            activateSwitch(getInitialPEIState());
        } else {
            rowPei.css("display", "none");
        }
    }
</script>
