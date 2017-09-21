<script>
!function(t,o){"function"==typeof define&&define.amd?define(o):"object"==typeof exports?module.exports=o():t.tingle=o()}(this,function(){function t(t){var o={onClose:null,onOpen:null,beforeClose:null,stickyFooter:!1,footer:!1,cssClass:[],closeLabel:"Close",closeMethods:["overlay","button","escape"]};this.opts=h({},o,t),this.init()}function o(){this.modal.classList.contains("tingle-modal--visible")&&(this.isOverflow()?this.modal.classList.add("tingle-modal--overflow"):this.modal.classList.remove("tingle-modal--overflow"),!this.isOverflow()&&this.opts.stickyFooter?this.setStickyFooter(!1):this.isOverflow()&&this.opts.stickyFooter&&(e.call(this),this.setStickyFooter(!0)))}function e(){this.modalBoxFooter&&(this.modalBoxFooter.style.width=this.modalBox.clientWidth+"px",this.modalBoxFooter.style.left=this.modalBox.offsetLeft+"px")}function s(){this.modal=document.createElement("div"),this.modal.classList.add("tingle-modal"),0!==this.opts.closeMethods.length&&this.opts.closeMethods.indexOf("overlay")!==-1||this.modal.classList.add("tingle-modal--noOverlayClose"),this.modal.style.display="none",this.opts.cssClass.forEach(function(t){"string"==typeof t&&this.modal.classList.add(t)},this),this.opts.closeMethods.indexOf("button")!==-1&&(this.modalCloseBtn=document.createElement("button"),this.modalCloseBtn.classList.add("tingle-modal__close"),this.modalCloseBtnIcon=document.createElement("span"),this.modalCloseBtnIcon.classList.add("tingle-modal__closeIcon"),this.modalCloseBtnIcon.innerHTML="×",this.modalCloseBtnLabel=document.createElement("span"),this.modalCloseBtnLabel.classList.add("tingle-modal__closeLabel"),this.modalCloseBtnLabel.innerHTML=this.opts.closeLabel,this.modalCloseBtn.appendChild(this.modalCloseBtnIcon),this.modalCloseBtn.appendChild(this.modalCloseBtnLabel)),this.modalBox=document.createElement("div"),this.modalBox.classList.add("tingle-modal-box"),this.modalBoxContent=document.createElement("div"),this.modalBoxContent.classList.add("tingle-modal-box__content"),this.modalBox.appendChild(this.modalBoxContent),this.opts.closeMethods.indexOf("button")!==-1&&this.modal.appendChild(this.modalCloseBtn),this.modal.appendChild(this.modalBox)}function i(){this.modalBoxFooter=document.createElement("div"),this.modalBoxFooter.classList.add("tingle-modal-box__footer"),this.modalBox.appendChild(this.modalBoxFooter)}function n(){this._events={clickCloseBtn:this.close.bind(this),clickOverlay:d.bind(this),resize:o.bind(this),keyboardNav:l.bind(this)},this.opts.closeMethods.indexOf("button")!==-1&&this.modalCloseBtn.addEventListener("click",this._events.clickCloseBtn),this.modal.addEventListener("mousedown",this._events.clickOverlay),window.addEventListener("resize",this._events.resize),document.addEventListener("keydown",this._events.keyboardNav)}function l(t){this.opts.closeMethods.indexOf("escape")!==-1&&27===t.which&&this.isOpen()&&this.close()}function d(t){this.opts.closeMethods.indexOf("overlay")!==-1&&!a(t.target,"tingle-modal")&&t.clientX<this.modal.clientWidth&&this.close()}function a(t,o){for(;(t=t.parentElement)&&!t.classList.contains(o););return t}function r(){this.opts.closeMethods.indexOf("button")!==-1&&this.modalCloseBtn.removeEventListener("click",this._events.clickCloseBtn),this.modal.removeEventListener("mousedown",this._events.clickOverlay),window.removeEventListener("resize",this._events.resize),document.removeEventListener("keydown",this._events.keyboardNav)}function h(){for(var t=1;t<arguments.length;t++)for(var o in arguments[t])arguments[t].hasOwnProperty(o)&&(arguments[0][o]=arguments[t][o]);return arguments[0]}function c(){var t,o=document.createElement("tingle-test-transition"),e={transition:"transitionend",OTransition:"oTransitionEnd",MozTransition:"transitionend",WebkitTransition:"webkitTransitionEnd"};for(t in e)if(void 0!==o.style[t])return e[t]}var m=c();return t.prototype.init=function(){this.modal||(s.call(this),n.call(this),document.body.insertBefore(this.modal,document.body.firstChild),this.opts.footer&&this.addFooter())},t.prototype.destroy=function(){null!==this.modal&&(r.call(this),this.modal.parentNode.removeChild(this.modal),this.modal=null)},t.prototype.open=function(){this.modal.style.removeProperty?this.modal.style.removeProperty("display"):this.modal.style.removeAttribute("display"),document.body.classList.add("tingle-enabled"),this.setStickyFooter(this.opts.stickyFooter),this.modal.classList.add("tingle-modal--visible");var t=this;m?this.modal.addEventListener(m,function o(){"function"==typeof t.opts.onOpen&&t.opts.onOpen.call(t),t.modal.removeEventListener(m,o,!1)},!1):"function"==typeof t.opts.onOpen&&t.opts.onOpen.call(t),o.call(this)},t.prototype.isOpen=function(){return!!this.modal.classList.contains("tingle-modal--visible")},t.prototype.close=function(){if("function"==typeof this.opts.beforeClose){var t=this.opts.beforeClose.call(this);if(!t)return}document.body.classList.remove("tingle-enabled"),this.modal.classList.remove("tingle-modal--visible");var o=this;m?this.modal.addEventListener(m,function t(){o.modal.removeEventListener(m,t,!1),o.modal.style.display="none","function"==typeof o.opts.onClose&&o.opts.onClose.call(this)},!1):(o.modal.style.display="none","function"==typeof o.opts.onClose&&o.opts.onClose.call(this))},t.prototype.setContent=function(t){"string"==typeof t?this.modalBoxContent.innerHTML=t:(this.modalBoxContent.innerHTML="",this.modalBoxContent.appendChild(t))},t.prototype.getContent=function(){return this.modalBoxContent},t.prototype.addFooter=function(){i.call(this)},t.prototype.setFooterContent=function(t){this.modalBoxFooter.innerHTML=t},t.prototype.getFooterContent=function(){return this.modalBoxFooter},t.prototype.setStickyFooter=function(t){this.isOverflow()||(t=!1),t?this.modalBox.contains(this.modalBoxFooter)&&(this.modalBox.removeChild(this.modalBoxFooter),this.modal.appendChild(this.modalBoxFooter),this.modalBoxFooter.classList.add("tingle-modal-box__footer--sticky"),e.call(this),this.modalBoxContent.style["padding-bottom"]=this.modalBoxFooter.clientHeight+20+"px"):this.modalBoxFooter&&(this.modalBox.contains(this.modalBoxFooter)||(this.modal.removeChild(this.modalBoxFooter),this.modalBox.appendChild(this.modalBoxFooter),this.modalBoxFooter.style.width="auto",this.modalBoxFooter.style.left="",this.modalBoxContent.style["padding-bottom"]="",this.modalBoxFooter.classList.remove("tingle-modal-box__footer--sticky")))},t.prototype.addFooterBtn=function(t,o,e){var s=document.createElement("button");return s.innerHTML=t,s.addEventListener("click",e),"string"==typeof o&&o.length&&o.split(" ").forEach(function(t){s.classList.add(t)}),this.modalBoxFooter.appendChild(s),s},t.prototype.resize=function(){console.warn("Resize is deprecated and will be removed in version 1.0")},t.prototype.isOverflow=function(){var t=window.innerHeight,o=this.modalBox.clientHeight;return o>=t},{modal:t}});
</script>
<style>
.tingle-modal *{box-sizing:border-box}.tingle-modal{position:fixed;top:0;right:0;bottom:0;left:0;z-index:1000;display:-webkit-box;display:-ms-flexbox;display:flex;visibility:hidden;-webkit-box-orient:vertical;-webkit-box-direction:normal;-ms-flex-direction:column;flex-direction:column;-webkit-box-align:center;-ms-flex-align:center;align-items:center;overflow:hidden;background:rgba(0,0,0,.8);opacity:0;cursor:pointer;-webkit-transition:-webkit-transform .2s ease;transition:-webkit-transform .2s ease;transition:transform .2s ease;transition:transform .2s ease,-webkit-transform .2s ease}.tingle-modal--noClose .tingle-modal__close,.tingle-modal__closeLabel{display:none}.tingle-modal--confirm .tingle-modal-box{text-align:center}.tingle-modal--noOverlayClose{cursor:default}.tingle-modal__close{position:fixed;top:10px;right:28px;z-index:1000;padding:0;width:5rem;height:5rem;border:none;background-color:transparent;color:#f0f0f0;font-size:6rem;font-family:monospace;line-height:1;cursor:pointer;-webkit-transition:color .3s ease;transition:color .3s ease}.tingle-modal__close:hover{color:#fff}.tingle-modal-box{position:relative;-ms-flex-negative:0;flex-shrink:0;margin-top:auto;margin-bottom:auto;width:60%;border-radius:4px;background:#fff;opacity:1;cursor:auto;-webkit-transition:-webkit-transform .3s cubic-bezier(.175,.885,.32,1.275);transition:-webkit-transform .3s cubic-bezier(.175,.885,.32,1.275);transition:transform .3s cubic-bezier(.175,.885,.32,1.275);transition:transform .3s cubic-bezier(.175,.885,.32,1.275),-webkit-transform .3s cubic-bezier(.175,.885,.32,1.275);-webkit-transform:scale(.8);-ms-transform:scale(.8);transform:scale(.8)}.tingle-modal-box__content{padding:3rem}.tingle-modal-box__footer{padding:1.5rem 2rem;width:auto;border-bottom-right-radius:4px;border-bottom-left-radius:4px;background-color:#f5f5f5;cursor:auto}.tingle-modal-box__footer::after{display:table;clear:both;content:""}.tingle-modal-box__footer--sticky{position:fixed;bottom:-200px;z-index:10001;opacity:1;-webkit-transition:bottom .3s ease-in-out .3s;transition:bottom .3s ease-in-out .3s}.tingle-enabled{overflow:hidden;height:100%}.tingle-modal--visible .tingle-modal-box__footer{bottom:0}.tingle-enabled .tingle-content-wrapper{-webkit-filter:blur(15px);filter:blur(15px)}.tingle-modal--visible{visibility:visible;opacity:1}.tingle-modal--visible .tingle-modal-box{-webkit-transform:scale(1);-ms-transform:scale(1);transform:scale(1)}.tingle-modal--overflow{overflow-y:scroll;padding-top:8vh}.tingle-btn{display:inline-block;margin:0 .5rem;padding:1rem 2rem;border:none;background-color:grey;box-shadow:none;color:#fff;vertical-align:middle;text-decoration:none;font-size:inherit;font-family:inherit;line-height:normal;cursor:pointer;-webkit-transition:background-color .4s ease;transition:background-color .4s ease}.tingle-btn--primary{background-color:#3498db}.tingle-btn--danger{background-color:#e74c3c}.tingle-btn--default{background-color:#34495e}.tingle-btn--pull-left{float:left}.tingle-btn--pull-right{float:right}@media (max-width :540px){.tingle-modal-box{width:auto;border-radius:0}.tingle-modal{top:60px;display:block;width:100%}.tingle-modal--noClose{top:0}.tingle-modal--overflow{padding:0}.tingle-modal-box__footer .tingle-btn{display:block;float:none;margin-bottom:1rem;width:100%}.tingle-modal__close{top:0;right:0;left:0;display:block;width:100%;height:60px;border:none;background-color:#2c3e50;box-shadow:none;color:#fff;line-height:55px}.tingle-modal__closeLabel{display:inline-block;vertical-align:middle;font-size:1.5rem;font-family:-apple-system,BlinkMacSystemFont,"Segoe UI",Roboto,Oxygen,Ubuntu,Cantarell,"Fira Sans","Droid Sans","Helvetica Neue",sans-serif}.tingle-modal__closeIcon{display:inline-block;margin-right:.5rem;vertical-align:middle;font-size:4rem}}
</style>

<style type="text/css">
    #popup {
        left: 0;
        position: absolute;
        top: 0;
        width: 100%;
        z-index: 1001;
    }

    #popup_prod {
        left: 0;
        position: absolute;
        top: 0;
        width: 100%;
        z-index: 1001;
    }

    .content-popup {
        margin: 0px auto;
        margin-top: 130px;
        position: relative;
        padding: 10px;
        width: 400px;
        height: 300px;
        border-radius: 4px;
        background-color: #FFFFFF;
        box-shadow: 0 2px 5px #666666;
    }

    .content-popup h2 {
        color: #48484B;
        border-bottom: 1px solid #48484B;
        margin-top: 0;
        padding-bottom: 4px;
    }

    .popup-overlay {
        left: 0;
        position: absolute;
        top: 0;
        width: 100%;
        z-index: 999;
        display: none;
        background-color: #777777;
        cursor: pointer;
        opacity: 0.7;
    }

    .close {
        positio#logon: absolute;
        right: 15px;
    }

    .content-popup img {
        position: relative;
        align-self: right;
    }

    .content-popup button {
        position: relative;
        left: 25px;
        bottom: 50px;
    }

    .content-popup #cancel {
        position: relative;
        left: 105px;
        bottom: 237px;
    }

    .content-popup #cancel_prod {
        position: relative;
        left: 105px;
        bottom: 237px;
    }
</style>
<?php echo $header; ?>
<?php echo $column_left; ?>
<div id="content">
    <div class="page-header">
        <div class="container-fluid">
            <h1>Todo Pago (<?php echo $todopago_version; ?>)</h1>
            <div class="pull-right">
                <a onclick="$('#form').submit();" class="btn btn-primary" data-toggle="tooltip" title="<?php echo $button_save; ?>"><i class="fa <?php echo $button_save_class; ?>"></i></a>
                <a href="<?php echo $cancel; ?>" class="btn btn-default" data-toggle="tooltip" title="Cancelar"><i class="fa fa-reply"></i></a>
            </div>
            <ul class="breadcrumb">
                <?php foreach ($breadcrumbs as $breadcrumb) { ?>
                <li>
                    <a href="<?php echo $breadcrumb['href']; ?>">
                        <?php echo $breadcrumb[ 'text']; ?>
                    </a>
                </li>
                <?php } ?>
            </ul>
        </div>
    </div>
    <div class="container-fluid">
        <?php if ($need_upgrade) { ?>
        <div class="alert alert-warning"><i class="fa fa-exclamation-circle"></i>
            Usted ha subido una nueva versión del m&oacute;dulo, para su correcto funcionamiento debe actualizarlo haciendo click en el botón "Upgrade" indicado con el &iacute;cono <i class="fa <?php echo $button_save_class; ?>"></i>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <?php if (isset($error[ 'error_warning'])) { ?>
        <div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i>
            <?php echo $error[ 'error_warning']; ?>
            <button type="button" class="close" data-dismiss="alert">&times;</button>
        </div>
        <?php } ?>
        <div class="panel panel-default">
            <div class="panel-heading">
                <h3 class="panel-title"><i class="fa fa-pencil"></i>Configuración de Todo Pago</h3>
            </div>
            <div class="panel-body">

                <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form" class="form-horizontal">
                    <ul class="nav nav-tabs">
                        <li class="active"><a href="#tab-general" data-toggle="tab">GENERAL</a>
                        </li>
                        <li><a href="#tab-test" data-toggle="tab">AMBIENTE TEST</a>
                        </li>
                        <li><a href="#tab-produccion" data-toggle="tab">AMBIENTE PRODUCCION</a>
                        </li>
                        <li><a href="#tab-estadosdelpedido" data-toggle="tab">ESTADOS DEL PEDIDO</a>
                        </li>
                        <li><a href="#tab-status" data-toggle="tab">STATUS DE LAS OPERACIONES</a>
                        </li>
                    </ul>
                    <div class="tab-content">
                        <!-- TAB GENERAL -->
                        <div class="tab-pane active" id="tab-general">
                           <input type="hidden" name="upgrade" value="<?php echo $need_upgrade ?>">
                           <input type="hidden" name="todopago_version" value="<?php echo $todopago_version; ?>">
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_status">Enabled</label>
                                <div class="field col-sm-5">
                                    <select class="form-control" name="todopago_status" id="todopago_status">
                                        <?php if ($todopago_status) { ?>
                                            <option value="1" selected="selected">
                                                <?php echo $text_enabled; ?>
                                            </option>
                                            <option value="0">
                                                <?php echo $text_disabled; ?>
                                            </option>
                                        <?php } else { ?>
                                            <option value="1">
                                                <?php echo $text_enabled; ?>
                                            </option>
                                            <option value="0" selected="selected">
                                                <?php echo $text_disabled; ?>
                                            </option>
                                        <?php } ?>
                                    </select>
                                </div>
                                <div class="info-field col-sm-5">
                                    <div class="info-field col-sm-5"><em>Activa y desactiva el módulo de pago</em>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_segmentodelcomercio">Segmento del Comercio</label>
                                <div class="field col-sm-5">
                                    <select class="form-control" name="todopago_segmentodelcomercio" id="todopago_segmentodelcomercio">
                                        <option value="Retail" <?php if ($todopago_segmentodelcomercio=="Retail" ) echo "selected" ?> >Retail</option>
                                        <!--<option value="Ticketing" <?php if ($todopago_segmentodelcomercio=="Ticketing" ) echo "selected"?> >Ticketing</option>
                                        <option value="Services" <?php if ($todopago_segmentodelcomercio=="Services" ) echo "selected"?> >Service</option>
                                        <option value="Digital Goods" <?php if ($todopago_segmentodelcomercio=="Digital Goods" ) echo "selected"?> >Digital Goods</option>-->
                                    </select>
                                </div>
                                <div class="info-field col-sm-5"><em>La elección del segmento determina los tipos de datos a enviar</em>
                                </div>
                            </div>
                            <!--<div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_canaldeingresodelpedido">Canal de Ingreso del Pedido</label>
                                <div class="field col-sm-5">
                                    <select class="form-control" name="todopago_canaldeingresodelpedido" id="todopago_canaldeingresodelpedido">
                                        <option value="Web" <?php if ($todopago_canaldeingresodelpedido=="Web" ) echo "selected" ?>>Web</option>
                                        <option value="Mobile" <?php if ($todopago_canaldeingresodelpedido=="Mobile" ) echo "selected" ?>>Mobile</option>
                                        <option value="Telefonica" <?php if ($todopago_canaldeingresodelpedido=="Telefonica" ) echo "selected" ?>>Telefonica</option>
                                    </select>
                                </div>
                                <div class="info-field col-sm-5"><em></em>
                                </div>
                            </div>-->
                            <div class="form-group">
                                <label class="col-sm-2 control-label" for="todopago_deadline">Dead Line</label>
                                <div class="field col-sm-5">
                                    <input type="number" min="0" class="form-control" name="todopago_deadline" id="todopago_deadline" value="<?php echo $todopago_deadline; ?>" />
                                </div>
                                <div class="info-field col-sm-5"><em>Días máximos para la entrega</em>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_modotestproduccion">Modo test o Producción</label>
                                <div class="field col-sm-5">
                                    <select class="form-control" name="todopago_modotestproduccion" id="todopago_modotestproduccion">
                                        <option value="test" <?php if ($todopago_modotestproduccion=="test" ){ ?> selected='selected' <?php } ?>>Test</option>
                                        <option value="prod" <?php if ($todopago_modotestproduccion=="prod" ){ ?>selected='selected'<?php } ?>>Produccion</option>
                                    </select>
                                </div>
                                <div class="info-field col-sm-5"><em>Debe ser configurado en CONFIGURACION - AMBIENTE TEST / PRODUCCION</em>
                                </div>


                            </div>
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_formulario">Tipo de formulario que desea utilizar</label>
                                <div class="field col-sm-5">
                                    <select class="form-control" name="todopago_formulario" id="todopago_formulario">
                                        <option value="redirec" <?php if ($todopago_formulario=="redirec" ){ ?> selected='selected' <?php } ?>>Redirección</option>
                                        <option value="hibrid" <?php if ($todopago_formulario=="hibrid" ){ ?>selected='selected'<?php } ?>>Híbrido</option>
                                    </select>
                                </div>
                                <div class="info-field col-sm-5"><em>Puede usar un formulario integrado al comercio o redireccionar al formulario externo</em>
                                </div>
                            </div>


                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_maxinstallments">Máximo de cuotas</label>
                                <div class="field col-sm-1">
                                    <div class="checkbox">
                                        <?php    
                                        $checked = (isset($todopago_maxinstallments))?' checked="checked" ':''; ?>
                                        <label><input type="checkbox" id="habilitar" value="" <?php echo $checked; ?>> Habilitar</label>
                                    </div>
                                </div>
                                <div class="field col-sm-4">
                                    <select class="form-control" name="todopago_maxinstallments" id="todopago_maxinstallments" disabled>
                                    <?php
                                    for ($i = 0; $i <= 12; $i++) { ?>
                                        <option value="<?php echo $i ?>"><?php echo $i ?></option> <?php

                                        if ($i == $todopago_maxinstallments) { ?>
                                            <script> $("select option[value=<?php echo $i ?>]").attr("selected","selected"); </script><?php
                                        }
                                    }
                                    ?>
                                    </select>
                                </div>

                                <div class="info-field col-sm-5"><em>* Seleccione la cantidad máxima de cuotas</em>
                                </div>
                            </div>

                            <!-- TIEMPO DE VIDA DEL FORMULARIO-->
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_timeout_form_enabled">Habilitar Tiempo de vida para el formulario de pago</label>
                                <div class="field col-sm-1">
                                    <div class="checkbox">
                                        <?php    
                                        $checked = (isset($todopago_timeout_form) )?' checked="checked" ':''; ?>
                                        <label><input type="checkbox" id="todopago_timeout_form_enabled" name="todopago_timeout_form_enabled" value="" <?php echo $checked; ?> > Habilitar</label>
                                    </div>
                                </div>
                                <?php $timeout = (isset($todopago_timeout_form))?$todopago_timeout_form:'1800000'; ?>
                                <div class="field col-sm-4">
                                    <input type="number" min="300000" max="21600000" class="form-control" name="todopago_timeout_form" id="todopago_timeout_form" value="<?php echo $timeout; ?>" disabled />
                                </div>

                                <div class="info-field col-sm-5"><em>* ingrese el tiempo de vida del formulario en ms (por defecto tiene el valor 1800000 Valor minimo: 300000 (5 minutos)
Valor maximo: 21600000 (6hs))</em>
                                </div>
                            </div>

                            <!-- Vaciar carrito de compras -->
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_cart">¿Desea vaciar el carrito de compras luego de una operación fallida?</label>
                                <div class="field col-sm-5">
                                    <select class="form-control" name="todopago_cart" id="todopago_cart">
                                        <?php if ($todopago_cart) { ?>
                                            <option value="1" selected="selected">
                                                <?php echo $text_enabled; ?>
                                            </option>
                                            <option value="0">
                                                <?php echo $text_disabled; ?>
                                            </option>
                                        <?php } else { ?>
                                            <option value="1">
                                                <?php echo $text_enabled; ?>
                                            </option>
                                            <option value="0" selected="selected">
                                                <?php echo $text_disabled; ?>
                                            </option>
                                        <?php } ?>
                                    </select>
                                </div>
                                <div class="info-field col-sm-5"><em>Ante un pago fallido se podrá elegir el comportamiento esperado, vaciando o no el carrito de compras.</em>
                                </div>

                            </div>

                            <!-- Validar dirección con gmaps -->
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_gmaps_validacion">¿Desea validar la dirección de compra con Google Maps?</label>
                                <div class="field col-sm-5">
                                    <select class="form-control" name="todopago_gmaps_validacion" id="todopago_gmaps_validacion">
                                        <?php if ($todopago_gmaps_validacion) { ?>
                                        <option value="1" selected="selected">
                                            <?php echo $text_enabled; ?>
                                        </option>
                                        <option value="0">
                                            <?php echo $text_disabled; ?>
                                        </option>
                                        <?php } else { ?>
                                        <option value="1">
                                            <?php echo $text_enabled; ?>
                                        </option>
                                        <option value="0" selected="selected">
                                            <?php echo $text_disabled; ?>
                                        </option>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>

                        </div>
                        <!-- END TAB GENERAL-->

                        <!-- TAB AMBIENTE TEST -->
                        <div class="tab-pane" id="tab-test">
                           <div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_authorizationHTTPtest">Authorization HTTP</label>
                                <div class="field col-sm-5">
                                    <input type="text" name="todopago_authorizationHTTPtest" value="<?php echo $todopago_authorizationHTTPtest; ?>" placeholder="Authorization" id="todopago_authorizationHTTPtest" class="form-control" />
                                </div>
                                <div class="input-field col-sm-5"><em>ejemplo: PRISMA 912EC803B2CE4xxxx541068D495AB570</em>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_idsitetest">Id Site Todo Pago</label>
                                <div class="field col-sm-5">
                                    <input type="text" class="form-control" name="todopago_idsitetest" id="todopago_idsitetest" value="<?php echo $todopago_idsitetest; ?>" />
                                </div>
                                <div class="info-field col-sm-5"><em>Número de Comercio provisto por Todo Pago</em>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_securitytest">Security code</label>
                                <div class="field col-sm-5">
                                    <input type="text" class="form-control" name="todopago_securitytest" id="todopago_securitytest" value="<?php echo $todopago_securitytest; ?>" />
                                </div>
                                <div class="info-field col-sm-5"><em>Código provisto por Todo Pago</em>
                                </div>
                            </div>
                            <div class="form-group required">
                                <div class="col-sm-2"></div>
                                <div class="field col-sm-4">
                                    <button type="button" id="open" class="btn btn-primary">Requerir datos</button>
                                    <button type="button" id="borrar" class="btn btn-primary">Borrar</button>
                                </div>
                            </div>
                        </div>

                        <div id="popup" style="display: none;">
                            <div class="content-popup">

                                <div>
                                    <h2>Obtener credenciales <img src="http://www.todopago.com.ar/sites/todopago.com.ar/files/logo.png"></h2>

                                    <br />
                                    <label class="control-label">E-mail</label>
                                    <input id="mail" class="form-control" name="mail" type="email" value="" placeholder="E-mail" />
                                    <label class="control-label">Contrase&ntilde;a</label>
                                    <input id="pass" class="form-control" name="pass" type="password" value="" placeholder="Contrase&ntilde;a" />
                                    <button id="confirm_test" style="margin:20%;" class="btn-config-credentials btn btn-primary">Acceder</button>
                                    <button id="cancel" style="margin:20%;" class="btn-config-credentials btn btn-danger">Cancelar</button>
                                </div>
                            </div>
                        </div>
                        <!-- END TAB AMBIENTE TEST -->

                        <!-- TAB AMBIENTE PRODUCCION -->
                        <div class="tab-pane" id="tab-produccion">
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_authorizationHTTPproduccion">Authorization HTTP</label>
                                <div class="field col-sm-5">
                                    <input type="text" name="todopago_authorizationHTTPproduccion" value="<?php echo $todopago_authorizationHTTPproduccion; ?>" placeholder="Authorization" id="todopago_authorizationHTTPproduccion" class="form-control" />
                                </div>
                                <div class="input-field col-sm-5"><em>Se deben pasar los datos en formato json. ejemplo: { "Authorization":"PRISMA 912EC803B2CE49E4A541068D495AB570"}</em>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_idsiteproduccion">Id Site Todo Pago</label>
                                <div class="field col-sm-5">
                                    <input type="text" class="form-control" name="todopago_idsiteproduccion" id="todopago_idsiteproduccion" value="<?php echo $todopago_idsiteproduccion; ?>" />
                                </div>
                                <div class="info-field col-sm-5"><em>Número de Comercio provisto por Todo Pago</em>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_securityproduccion">Security code</label>
                                <div class="field col-sm-5">
                                    <input type="text" class="form-control" name="todopago_securityproduccion" id="todopago_securityproduccion" value="<?php echo $todopago_securityproduccion; ?>" />
                                </div>
                                <div class="info-field col-sm-5"><em>Código provisto por Todo Pago</em>
                                </div>
                            </div>
                            <div class="form-group required">
                                <div class="col-sm-2"></div>
                                <div class="field col-sm-4">
                                    <button type="button" id="open_prod" class="btn btn-primary">Requerir datos</button>
                                    <button type="button" id="borrar_prod" class="btn btn-primary">Borrar</button>
                                </div>
                            </div>
                        </div>

                         <div id="popup_prod" style="display: none;">
                            <div class="content-popup">
                                <div>
                                    <h2>Obtener credenciales <img src="http://www.todopago.com.ar/sites/todopago.com.ar/files/logo.png"></h2>

                                    <br />
                                    <label class="control-label">E-mail</label>
                                    <input id="mail_prod" class="form-control" name="mail" type="email" value="" placeholder="E-mail" />
                                    <label class="control-label">Contrase&ntilde;a</label>
                                    <input id="pass_prod" class="form-control" name="pass" type="password" value="" placeholder="Contrase&ntilde;a" />
                                    <button id="confirm_prod" style="margin:20%;" class="btn-config-credentials btn btn-primary">Acceder</button>
                                    <button id="cancel_prod" style="margin:20%;" class="btn-config-credentials btn btn-danger">Cancelar</button>
                                </div>
                            </div>
                        </div>
                        <!--END TAB AMBIENTE PRODUCCION -->

                        <!-- TAB ESTADO DEL PEDIDO -->
                        <div class="tab-pane" id="tab-estadosdelpedido">
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_order_status_id_pro">Estado cuando la transaccion ha sido iniciada</label>
                                <div class="field col-sm-5">
                                    <select class="form-control" name="todopago_order_status_id_pro" id="todopago_order_status_id_pro">
                                        <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status[ 'order_status_id']==$todopago_order_status_id_pro) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected">
                                            <?php echo $order_status[ 'name']; ?>
                                        </option>
                                        <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>">
                                            <?php echo $order_status[ 'name']; ?>
                                        </option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_order_status_id_aprov">Estado cuando la transaccion ha sido aprobada</label>
                                <div class="field col-sm-5">
                                    <select class="form-control" name="todopago_order_status_id_aprov" id="todopago_order_status_id_aprov">
                                        <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status[ 'order_status_id']==$todopago_order_status_id_aprov) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected">
                                            <?php echo $order_status[ 'name']; ?>
                                        </option>
                                        <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>">
                                            <?php echo $order_status[ 'name']; ?>
                                        </option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_order_status_id_rech">Estado cuando la transaccion ha sido Rechazada</label>
                                <div class="field col-sm-5">
                                    <select class="form-control" name="todopago_order_status_id_rech" id="todopago_order_status_id_rech">
                                        <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status[ 'order_status_id']==$todopago_order_status_id_rech) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected">
                                            <?php echo $order_status[ 'name']; ?>
                                        </option>
                                        <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>">
                                            <?php echo $order_status[ 'name']; ?>
                                        </option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_order_status_id_off">Estado cuando la transaccion ha sido Offline</label>
                                <div class="field col-sm-5">
                                    <select class="form-control" name="todopago_order_status_id_off" id="todopago_order_status_id_off">
                                        <?php foreach ($order_statuses as $order_status) { ?>
                                        <?php if ($order_status[ 'order_status_id']==$todopago_order_status_id_off) { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>" selected="selected">
                                            <?php echo $order_status[ 'name']; ?>
                                        </option>
                                        <?php } else { ?>
                                        <option value="<?php echo $order_status['order_status_id']; ?>">
                                            <?php echo $order_status[ 'name']; ?>
                                        </option>
                                        <?php } ?>
                                        <?php } ?>
                                    </select>
                                </div>
                            </div>

                        </div>
                        <!-- END TAB ESTADO DEL PEDIDO -->

                        <!-- TAB STATUS-->
                        <div class="tab-pane" id="tab-status">
                            <table class="form" border="1">
                                <script type="text/javascript">
                                    $(document).ready(function () {
                                        var valore = '<?php echo $orders_array ?>';
                                        var tabla_db = '';
                                        valore_json = JSON.parse(valore);
                                        valore_json.forEach(function (value, key) {
                                            tabla_db += "<tr>";
                                            tabla_db += "<th><a onclick='verstatus(" + value.order_id + ")' style='cursor:pointer'>" + value.order_id + "</a></th>";
                                            tabla_db += "<th>" + value.date_added + "</th>";
                                            tabla_db += "<th>" + value.firstname + "</th>";
                                            tabla_db += "<th>" + value.lastname + "</th>";
                                            tabla_db += "<th>" + value.store_name + "</th>";
                                            tabla_db += "<th>$" + value.total + "</th>";
                                            tabla_db += "<th><a onclick='devolver(" + value.order_id + ")' style='cursor:pointer'>Devolver</a></th>";
                                            tabla_db += "</tr>";
                                        });

                                        $("#tabla_db").prepend(tabla_db);
                                        $('#tabla').dataTable();

                                    });

                                    function verstatus(order) {
                                        $('#content').css('cursor', 'progress');
                                        url_get_status = '<?php echo $url_get_status ?>';
                                        $.get(url_get_status, {
                                            order_id: order
                                        }, llegadaDatos);
                                        return false;
                                    }

                                    function llegadaDatos(datos) {
                                        $('#content').css('cursor', 'auto');
var modal = new tingle.modal({
    footer: true,
    stickyFooter: false,
    closeMethods: ['overlay', 'button', 'escape'],
    closeLabel: "Close",
});
modal.setContent(datos);
modal.open();

                                    }

                                </script>
                                <link rel="stylesheet" href="http://cdn.datatables.net/1.10.2/css/jquery.dataTables.css">
                                <table id="tabla" class="display" cellspacing="0" width="100%">

                                    <thead>
                                        <tr>
                                            <th>Nro</th>
                                            <th>Fecha</th>
                                            <th>Nombre</th>
                                            <th>Apellido</th>
                                            <th>Tienda</th>
                                            <th>Total</th>
                                            <th>devolucion</th>
                                        </tr>
                                    </thead>

                                    <tfoot>
                                        <tr>
                                            <th>Nro</th>
                                            <th>Fecha</th>
                                            <th>Nombre</th>
                                            <th>Apellido</th>
                                            <th>Tienda</th>
                                            <th>Total</th>
                                            <th>devolucion</th>
                                        </tr>
                                    </tfoot>

                                    <tbody id="tabla_db">
                                    </tbody>
                                </table>
                        </div>
                        <!-- END TAB STATUS-->
                    </div>
                </form>
            </div>
        </div>
        <script type="text/javascript">
            <!--
                function devolver(order_id){
                   var monto = prompt("Monto a parcial devolver (valor real del producto, sin el costo adicional) o vacío para devolución total (ej: 1.23): ", "");
                   if (monto !== null) {
                        $('#content').css('cursor', 'progress');
                        var url_devolver = '<?php echo $url_devolver ?>';
                        $.post(url_devolver,{order_id: order_id, monto: monto}, llegadaDatosDevolucion );
                    }
                   return false;
                }

                function llegadaDatosDevolucion(datos) {
                    $('#content').css('cursor', 'auto');
                    alert(datos);
                }
            //-->
        </script>
        <script type="text/javascript">
            $(document).ready(function() {

                $('#open').click(function() {

                    $('#popup').fadeIn('slow');
                    $('.popup-overlay').fadeIn('slow');
                    $('.popup-overlay').height($(window).height());
                    //return false;
                });

                $('#confirm_test').click(function() {

                    $.post("view/template/<?php echo $extension; ?>payment/todopago_credentials.php", {
                    mail: $("#mail").val(),
                    pass: $("#pass").val(),
                    ambiente: "test"
                }, function(data) {
                    $("#mail").val('');
                    $("#pass").val('');
                    json_data = JSON.parse(data);
                    console.log(json_data);
                    if(json_data.codigoResultado === 0) {
                        $('input:text[name=todopago_authorizationHTTPtest]').val(json_data.apikey);
                        $('input:text[name=todopago_idsitetest]').val(json_data.merchandid);
                        $('input:text[name=todopago_securitytest]').val(json_data.security);
                    } else {
                        alert(json_data.mensajeResultado);
                    }
                });
                    $('#popup').fadeOut('slow');
                    $('.popup-overlay').fadeOut('slow');
                    return false;
                });
                $('#cancel').click(function() {
                    $('#popup').fadeOut('slow');
                    $('.popup-overlay').fadeOut('slow');
                    return false;
                });
                $('#borrar').click(function() {
                    $('input:text[name=todopago_authorizationHTTPtest]').val('');
                    $('input:text[name=todopago_idsitetest]').val('');
                    $('input:text[name=todopago_securitytest]').val('');
                });
            });
        </script>
        <script type="text/javascript">
            $(document).ready(function() {
                $('#open_prod').click(function() {

                    $('#popup_prod').fadeIn('slow');
                    $('.popup-overlay').fadeIn('slow');
                    $('.popup-overlay').height($(window).height());
                    //return false;
                });

                $('#confirm_prod').click(function() {

                    $.post("view/template/<?php echo $extension; ?>payment/todopago_credentials.php", {
                    mail: $("#mail_prod").val(),
                    pass: $("#pass_prod").val(),
                    ambiente: "prod"
                }, function(data) {
                    $("#mail_prod").val('');
                    $("#pass_prod").val('');
                    json_data = JSON.parse(data);
                    console.log(json_data);
                    if(json_data.codigoResultado === 0) {
                        $('input:text[name=todopago_authorizationHTTPproduccion]').val(json_data.apikey);
                        $('input:text[name=todopago_idsiteproduccion]').val(json_data.merchandid);
                        $('input:text[name=todopago_securityproduccion]').val(json_data.security);
                    } else {
                        alert(json_data.mensajeResultado);
                    }
                });

                    $('#popup_prod').fadeOut('slow');
                    $('.popup-overlay').fadeOut('slow');
                    return false;
                });
                $('#cancel_prod').click(function() {
                    $('#popup_prod').fadeOut('slow');
                    $('.popup-overlay').fadeOut('slow');
                    return false;
                });
                $('#borrar_prod').click(function() {
                    $('input:text[name=todopago_authorizationHTTPproduccion]').val('');
                    $('input:text[name=todopago_idsiteproduccion]').val('');
                    $('input:text[name=todopago_securityproduccion]').val('');
                });

                var todopago_status = '<?php echo $todopago_status ?>';
                if(todopago_status == 1){
                    $('#todopago_status').val('1');
                }

            });
        </script>
        <?php echo $footer; ?>

        <script>

        $(document).ready(function(){
            if ($('#habilitar').attr('checked')) {
                $("#todopago_maxinstallments").removeAttr("disabled");

            }else{
                $("#todopago_maxinstallments").val("0");

            }

            $("#habilitar").click(function() {

                if ($('#habilitar').prop('checked')) {
                    $("#todopago_maxinstallments").removeAttr("disabled");

                }else
                {
                    $("#todopago_maxinstallments").prop('disabled', true);
                    $("#todopago_maxinstallments").val("");

                }

            });


            // CHECKBOX TIMEOUT FORM
            if ($('#todopago_timeout_form_enabled').attr('checked')) {
                $("#todopago_timeout_form").removeAttr("disabled");

            }

            $("#todopago_timeout_form_enabled").click(function() {

                //alert( $('input:checkbox[name=todopago_timeout_form_enabled]:checked').is(':checked') );

                if ($('#todopago_timeout_form_enabled').prop('checked')) {
                    $("#todopago_timeout_form").removeAttr("disabled");

                }else
                {
                    $("#todopago_timeout_form").prop('disabled', true);
                }

            });
        });

        </script>
