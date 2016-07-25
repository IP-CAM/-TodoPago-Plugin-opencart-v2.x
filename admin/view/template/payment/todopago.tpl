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
        <?php if ($need_upgrade) {?>
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
                                    <input type="number" class="form-control" name="todopago_deadline" id="todopago_deadline" value="<?php echo $todopago_deadline; ?>" />
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
                                <div class="info-field col-sm-5"><em>Debe ser cofigurado en CONFIGURACION - AMBIENTE TEST / PRODUCCION</em>
                                </div>


                            </div>
                            <div class="form-group required">
                                <label class="col-sm-2 control-label" for="todopago_formulario">Modo test o Producción</label>
                                <div class="field col-sm-5">
                                    <select class="form-control" name="todopago_formulario" id="todopago_formulario">
                                        <option value="redirec" <?php if ($todopago_formulario=="redirec" ){ ?> selected='selected' <?php } ?>>Redirección</option>
                                        <option value="hibrid" <?php if ($todopago_formulario=="hibrid" ){ ?>selected='selected'<?php } ?>>Híbrido</option>
                                    </select>
                                </div>
                                <div class="info-field col-sm-5"><em>* descripción aca</em>
                                </div>
 <p>                         </div>

</p> 
        
                  <div class="form-group required">
                         <label class="col-sm-2 control-label" for="todopago_maxinstallments">Máximo de cuotas</label>
                               <div class="field col-sm-1">
                            <div class="checkbox">
                                       <?php    if (isset($todopago_maxinstallments)){ ?>
                         
                                   <label><input type="checkbox" id="habilitar" value="" checked="checked"> Habilitar</label>
                       
                             <?php }else {?>
                              <label><input type="checkbox" id="habilitar" value=""> Habilitar</label>
                              <?php } ?>
                        </div>
                      </div>
                                <div class="field col-sm-4">
                                    <select class="form-control" name="todopago_maxinstallments" id="todopago_maxinstallments" disabled>
                        <?php  
                    for ($i = 0; $i <= 12; $i++) {
              
                                 ?>   <option value="<?php echo $i ?>"><?php echo $i ?></option> <?php

                              if ($i == $todopago_maxinstallments) {
?><script> $("select option[value=<?php echo $i ?>]").attr("selected","selected"); </script><?php
                                            }


                   }
                    ?>                             
                                  
                                    </select>
                                </div>
              
                                <div class="info-field col-sm-5"><em>* Seleccione la cantidad máxmia de cuotas</em>
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
                                        alert(datos);
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
            $('#htabs a').tabs();
            
            function devolver(order_id){
               var monto = prompt("Monto a Devolver: ", "ej: 1.23");
               
               $('#content').css('cursor', 'progress');
               var url_devolver = '<?php echo $url_devolver ?>';
               $.post(url_devolver,{order_id: order_id, monto: monto}, llegadaDatosDevolucion );
               return false;
         }   
            function devolver_total(order_id){
                alert("devolucion total!");
                $.post();
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

                    $.post("view/template/payment/todopago_credentials.php", {
                    mail: $("#mail").val(),
                    pass: $("#pass").val(),
                    tab: "test"
                }, function(data) {
                  json_data = JSON.parse(data);
                  console.log(json_data);
                  $('input:text[name=todopago_authorizationHTTPtest]').val(json_data.Credentials.APIKey);
                  $('input:text[name=todopago_idsitetest]').val(json_data.Credentials.merchantId);

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

                    $.post("view/template/payment/todopago_credentials.php", {
                    mail: $("#mail").val(),
                    pass: $("#pass").val(),
                    tab: "prod"
                }, function(data) {
                  json_data = JSON.parse(data);
                  console.log(json_data);
                  $('input:text[name=todopago_authorizationHTTPproduccion]').val(json_data.Credentials.APIKey);
                  $('input:text[name=todopago_idsiteproduccion]').val(json_data.Credentials.merchantId);

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
    });        
            </script>