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

<div class="tp_wrapper" id="tpForm">

    <section class="tp-total tp-flex">
        <div>
            <strong>Total a pagar $<?php echo number_format($ordertotal, 2, '.', ''); ?></strong>
        </div>
        <div>
            Elegí tu forma de pago
        </div>
    </section>

    <section class="billetera_virtual_tp tp-flex tp-flex-responsible">
        <div class="tp-flex-grow-1 tp-bloque-span texto_billetera_virtual text_size_billetera">
            <p>Pagá con tu <strong>Billetera Virtual Todo Pago</strong></p>
            <p>y evitá cargar los datos de tu tarjeta</p>
        </div>
        <div class="tp-flex-grow-1 tp-bloque-span">
            <button id="btn_Billetera" title="Pagar con Billetera" class="tp_btn tp_btn_sm text_size_billetera">
                Iniciar Sesión
            </button>
        </div>
    </section>

    <section class="billeterafm_tp">
        <div class="field field-payment-method">
            <label for="formaPagoCbx" class="text_small">Forma de Pago</label>
            <div class="input-box">
                <select id="formaPagoCbx" class="tp_form_control"></select>
                <span class="tp-error" id="formaPagoCbxError"></span>
            </div>
        </div>
    </section>

    <section class="billetera_tp">
        <div class="tp-row">
            <p>
                Con tu tarjeta de crédito o débito
            </p>
        </div>
        <!-- Número de tarjeta y banco -->
        <div class="tp-bloque-full tp-flex tp-flex-responsible tp-main-col">
            <!-- Tarjeta -->
            <div class="tp-flex-grow-1">
                <label for="numeroTarjetaTxt" class="text_small">Número de Tarjeta</label>
                <input id="numeroTarjetaTxt" class="tp_form_control" maxlength="19" title="Número de Tarjeta"
                       min-length="14" autocomplete="off">
                <img src="catalog/view/theme/default/image/empty.png" id="tp-tarjeta-logo"
                     alt="" />
                <!-- <span class="error" id="numeroTarjetaTxtError"></span> -->
                <label id="numeroTarjetaLbl" class="tp-error"></label>
            </div>
            <!-- Banco -->
            <div class="tp-flex-grow-1">
                <label for="bancoCbx" class="text_small">Banco</label>
                <select id="bancoCbx" class="tp_form_control" placeholder="Selecciona banco"></select>
                <span class="tp-error" id="bancoCbxError" />
            </div>
            <div class="tp_col tp-bloque-span payment-method">
                <label for="medioPagoCbx" class="text_small">Medio de Pago</label>
                <select id="medioPagoCbx" class="tp_form_control" placeholder="Mediopago"></select>
                <span class="tp-error" id="medioPagoCbxError"></span>
            </div>
        </div>

        <div class="tp-row tp-bloque-full tp-flex tp-flex-responsible tp-main-col" id="pei-block">
            <section id="peibox">
                <label id="peiLbl" for="peiCbx" class="text_small right">Pago con PEI</label>
                <label class="switch" id="switch-pei">
                    <input type="checkbox" id="peiCbx">
                    <span class="slider round"></span>
                    <span id="slider-text"></span>
                </label>
            </section>
        </div>

        <!--div class="tp_row">
            <div class="tp_col tp-bloque-span">
                <label for="medioPagoCbx" class="text_small">Medio de Pago</label>
                <select id="medioPagoCbx" class="tp_form_control" placeholder="Mediopago"></select>
                <span class="error" id="medioPagoCbxError"></span>
            </div>
        </div-->
        <!-- Vencimiento + DNI-->
        <div class="tp-bloque-full tp-flex tp-flex-row tp-flex-responsible tp-flex-space-between tp-main-col">
            <!-- vencimiento -->
            <div class="tp-flex-grow-1 tp-flex tp-flex-col">
                <!-- títulos -->
                <div class="tp-row tp-flex tp-flex-space-between tp-title">
                    <div class="tp-flex-grow-1">
                        <label for="mesCbx" class="text_small">Vencimiento</label>
                    </div>
                    <div class="tp-flex-grow-1">
                    </div>
                    <div class="tp-flex-grow-1">
                        <label for="codigoSeguridadTxt" class="text_small">Código de Seguridad</label>
                    </div>
                </div>
                <!-- inputs -->
                <div class="tp-row tp-flex tp-flex-space-between tp-input-row">
                    <div class="tp-flex-grow-1">
                        <select id="mesCbx" maxlength="2" class="tp_form_control" placeholder="Mes"></select>
                    </div>
                    <div class="tp-flex-grow-1">
                        <select id="anioCbx" maxlength="2" class="tp_form_control"></select>
                    </div>
                    <div class="tp-flex-grow-1">
                        <input id="codigoSeguridadTxt" class="tp_form_control" maxlength="4" autocomplete="off" />
                    </div>
                    <div class="tp-cvv-helper-container">
                        <div class="tp-anexo clave-ico" id="tp-cvv-caller"></div>
                        <div id="tp-cvv-helper">
                            <p>
                                Para Visa, Master, Cabal y Diners, los 3 dígitos se encuentran en el <strong>dorso</strong>
                                de
                                tu tarjeta. (izq)
                            </p>
                            <p>
                                Para Amex, los 4 dígitos se encuentran en el frente de tu tarjeta. (der)
                            </p>
                            <img id="tp-cvv-helper-img" alt="ilustración tarjetas" src="catalog/view/theme/default/image/clave-ej.png"/>
                        </div>
                    </div>
                </div>
                <!-- warnings -->
                <div class="tp-row tp-flex tp-error-title">
                    <label id="fechaLbl" class="left tp-error"></label>
                    <span class="tp-error" id="codigoSeguridadTxtError"></span>
                    <label id="codigoSeguridadLbl" class="left tp-label spacer tp-error"></label>
                </div>
            </div>
            <!-- DNI -->
            <div class="tp-flex-grow-1 tp-flex tp-flex-col">
                <!-- títulos -->
                <div class="tp-row tp-flex tp-flex-space-between tp-title">
                    <div class="tp-flex-1">
                        <label for="tipoDocCbx" class="text_small">Tipo</label>
                    </div>
                    <div class="tp-flex-3">
                        <label for="NumeroDocCbx" class="text_small">Número</label>
                    </div>
                </div>
                <!-- inputs -->
                <div class="tp-row tp-flex tp-input-row">
                    <div class="tp-flex-1">
                        <select id="tipoDocCbx" class="tp_form_control"></select>
                    </div>
                    <div class="tp-flex-3" id="tp-dni-numero">
                        <input id="nroDocTxt" maxlength="10" type="text" class="tp_form_control"
                               autocomplete="off" />
                    </div>
                </div>
                <!-- warnings -->
                <div class="tp-row tp-flex tp-error-title">
                    <div class="tp-flex-1">
                    </div>
                    <div class="tp-flex-3">
                        <span class="tp-error" id="nroDocLbl"></span>
                    </div>
                </div>
            </div>
        </div>


        <!-- Nombre y Apellido, y Mail -->
        <div class="tp-bloque-full tp-flex tp-flex-responsible tp-main-col">
            <div class="tp-flex-grow-1">
                <label for="nombreTxt" class="text_small">Nombre y Apellido</label>
                <input id="nombreTxt" class="tp_form_control" autocomplete="off" placeholder="" maxlength="50">
                <span class="tp-error" id="nombreLbl"></span>
            </div>
            <div class="tp-flex-grow-1">
                <label for="emailTxt" class="text_small">Email</label>
                <input id="emailTxt" type="email" class="tp_form_control tp-input-row" placeholder="nombre@mail.com"
                       data-mail=""
                       autocomplete="off" />
                <label id="emailLbl" class="left tp-label spacer tp-error"></label>
            </div>
        </div>

        <!-- Cantidad de cuotas y CFT -->
        <div class="tp-bloque-full tp-flex tp-main-col tp-flex-responsible">
            <div class="tp-flex-grow-1">
                <label for="promosCbx" class="text_small">Cantidad de cuotas</label>
                <select id="promosCbx" class="tp_form_control"></select>
                <span class="tp-error" id="promosCbxError"></span>
            </div>
            <div class="tp-flex-grow-1 tp-promo-cft">
                <label id="promosLbl" class="left tp_form_control"></label>
            </div>
        </div>

        <!-- Token de PEI -->
        <div class="tp-bloque-full tp-flex tp-main-col tp-flex-responsible">
            <div class="tp-flex-grow-1">
                <label id="tokenPeiLbl" for="tokenPeiTxt" class="text_small"></label>
                <input id="tokenPeiTxt" class="tp_form_control tp-input-row" />
            </div>
            <div class="tp-flex-grow-1">
            </div>
        </div>
        
        <!-- Pagar -->
        <div class="tp_row">
            <div class="tp_col tp_span_2_of_2">
                <button id="btn_ConfirmarPago" class="tp_btn" title="Pagar" class="button">
                    <span>Pagar</span>
                </button>
            </div>
            <div class="tp_col tp_span_2_of_2">
                <div class="confirmacion">
                    Al confirmar el pago acepto los <a href="https://www.todopago.com.ar/terminos-y-condiciones-comprador" target="_blank" title="Términos y Condiciones" id="tycId" class="tp_color_text">
                        Términos
                        y Condiciones
                    </a> de Todo Pago.
                </div>
            </div>
        </div>
    </section>
    <div class="tp_row">
        <div id="tp-powered">
            Powered by <img id="tp-powered-img" src="catalog/view/theme/default/image/tp_logo_prod.png" />
        </div>
    </div>
</div>



<script type="text/javascript">

    var medioDePago = document.getElementById('medioPagoCbx');
    var tarjetaLogo = document.getElementById('tp-tarjeta-logo');
    var poweredLogo = document.getElementById('tp-powered-img');
    var numeroTarjetaTxt = document.getElementById('numeroTarjetaTxt')
    var poweredLogoUrl = "catalog/view/theme/default/image/";
    var emptyImg = "catalog/view/theme/default/image/empty.png";
    
    var switchPei = $("#switch-pei");
    var sliderText = $("#slider-text");

    var helperCaller = $("#tp-cvv-caller");
    var helperPopup = $("#tp-cvv-helper");

    var idTarjetas  = {
        42: 'VISA',
        43: 'VISAD',
        1: 'AMEX',
        2: 'DINERS',
        6: 'CABAL',
        7: 'CABALD',
        14: 'MC',
        15: 'MCD'
    };

    var diccionarioTarjetas = {
        'VISA': 'VISA',
        'VISA DEBITO': 'VISAD',
        'AMEX': 'AMEX',
        'DINERS': 'DINERS',
        'CABAL': 'CABAL',
        'CABAL DEBITO': 'CABALD',
        'MASTER CARD': 'MC',
        'MASTER CARD DEBITO': 'MCD',
        'NARANJA': 'NARANJA'
    };

    /************* HELPERS *************/

    numeroTarjetaTxt.onblur = clearImage;

    function clearImage() {
        tarjetaLogo.src = emptyImg;
    }

    function cardImage(select) {
        var tarjeta = idTarjetas[select.value];
        if (tarjeta === undefined) {
            tarjeta = diccionarioTarjetas[select.textContent];
        }
        if (tarjeta !== undefined) {
            tarjetaLogo.src = 'https://forms.todopago.com.ar/formulario/resources/images/' + tarjeta + '.png';
            tarjetaLogo.style.display = 'block';
        }
    }

    /************* CONFIGURACION DEL API *****************/
    function loadScript(url, callback) {
        var entorno = (url.indexOf('developers') === -1) ? 'prod' : 'developers';
        console.log(entorno);
        poweredLogo.src = poweredLogoUrl + 'tp_logo_' + entorno + '.png';
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
            $("#peibox").css("display", "none");
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
            botonPagarId: 'btn_ConfirmarPago',
            botonPagarConBilleteraId: 'btn_Billetera',
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

        if (input == 'numeroTarjetaTxt')
            $("#peibox").css("display", "none");

        if (input.search("Txt") !== -1) {
            label = input.replace("Txt", "Lbl");
        } else {
            label = input.replace("Cbx", "Lbl");
        }
        
        if (document.getElementById(label) !== null) {
            document.getElementById(label).innerText = parametros.error;
        }
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

    // Verifica que el usuario no haya puesto para solo pagar con PEI y actúa en consecuencia
    function activateSwitch(soloPEI) {
        readPeiCbx();

        var peiChk = $("#peiCbx");

        console.log("Solo PEI: " + soloPEI);
        if (!soloPEI) {
            $("#switch-pei").click(function () {
                if (!peiChk.prop("checked")) {
                    switchPei.prop("checked", true);
                    peiChk.prop("checked", true);
                    sliderText.text("SÍ");
                    sliderText.css('transform', 'translateX(0)');
                } else {
                    switchPei.prop("checked", false);
                    peiChk.prop("checked", false);
                    sliderText.text("NO");
                    sliderText.css('transform', 'translateX(26px)');
                }
            });
        }
    }

    function getInitialPEIState() {
        return ($("#peiCbx").prop("disabled"));
    }

    function initLoading() {
        console.log('Loading...');
        cardImage(medioDePago);
    }

    function stopLoading() {
        console.log('Stop loading...');
        var peiCbx = $("#peiCbx");
        var peiRow = $("#peibox");
        var tokenPeiTxt = $("#tokenPeiTxt");

        if (document.getElementById('peiLbl').style.display === "inline-block") {
            $("#peibox").css('display', 'table-cell');
        } else {
            $("#peibox").hide("fast");
            $("#peiCbx").prop("checked", false);
        }

        if (peiCbx.css('display') !== 'none') {
            peiRow.show('fast');
            switchPei = $("#switch-pei");
            switchPei.css("display", "block");
            activateSwitch(getInitialPEIState());
        } else {
            peiRow.hide('fast');
            peiRow.css("display", "none");
            $("#peiCbx").prop("checked", false);
        }
    }

    function readPeiCbx() {
        var peiCbx = $("#peiCbx");
        if (peiCbx.prop("checked", true)) {
            switchPei.prop("checked", true);
            sliderText.text("SÍ");
            sliderText.css('transform', 'translateX(0)');
        } else {
            switchPei.prop("checked", true);
            sliderText.text("NO");
            sliderText.css('transform', 'translateX(26px)');
        }
    }

    helperCaller.click(function () {
        helperPopup.toggle(500);
    });
</script>