<div class="post-dropzone">
<?php 
echo form_open_multipart(get_uri("audio_chat/save"), array("id" => "add-audio_chat-form", "class" => "general-form bg-white custom-js-form", "role" => "form")); ?>
<div class="modal-body clearfix">
    <div class="container-fluid">
        <input type="hidden" name="id" value="<?php echo $model_info->id; ?>" />
        <input type="hidden" name="project_id" value="<?php echo $project_id; ?>" />
        <input type="hidden" name="old_audio_file" value="<?php echo $model_info->audio_file; ?>" />
        <div class="mb-3 form-group">
            <div class="row">
                <label for="version" class=" col-md-3"><?php echo app_lang('version'); ?></label>
                <div class=" col-md-9">
                    <?php
                    echo form_input(array(
                        "id" => "version",
                        "name" => "version",
                        // "type" => "number",
                        "value" => $model_info->version,
                        "class" => "form-control",
                        "placeholder" => app_lang('version'),
                        "autofocus" => true,
                        "data-rule-required" => true,
                        "data-msg-required" => app_lang("field_required"),
                    ));
                    ?>
                </div>
            </div>
        </div>
        <?php if($model_info->id==''){ ?>
        <div class="mb-3 form-group">
            <div class="row">
                <label class=" col-md-3"><?php echo app_lang('audio_file'); ?></label>
                <div class="col-md-9">
                    <div class="float-start mr15">
                        <?php echo view("includes/dropzone_preview"); ?>    
                    </div>
                    <div class="float-start upload-file-button btn btn-default btn-sm">
                        <span><i data-feather="upload" class="icon-14"></i> <?php echo app_lang("upload"); ?></span>
                    </div>
                </div>
            </div>
        </div>
        <?php } ?>
        <div class="mb-3 form-group">
            <div class="row">
                <label class=" col-md-3"><?php echo app_lang('status'); ?></label>
                <div class="col-md-9">
                    <?php
                    $status_dropdown = array();
                    foreach (audio_version_status() as $status) {
                       $status_dropdown[$status['id']] = $status['name'];
                    }
                        echo form_dropdown("status", $status_dropdown, $model_info->status, "class='select2'");
                    ?>
                </div>
            </div>
        </div>
    </div>
</div>
<div class="modal-footer">
    <button type="button" class="btn btn-default" data-bs-dismiss="modal"><span data-feather="x" class="icon-16"></span> <?php echo app_lang('close'); ?></button>
    <button type="submit" class="btn btn-primary"><span data-feather="check-circle" class="icon-16"></span> <?php echo app_lang('save'); ?></button>
</div>
<?php echo form_close(); ?>
</div>
<script type="text/javascript">
    "use strict";
    $(document).ready(function () {
        $("#add-audio_chat-form .select2").select2();
        var id = '<?php echo $model_info->id?>'; 
        $("#add-audio_chat-form").appForm({
            onSuccess: function (result) {
                if (id=='') {
                    var count = document.querySelectorAll('#version_dropdown li').length;
                    $('#version_dropdown').append('<li role="presentation" class="text-center"><a href="#" onclick="change_version('+result.data.project_id+','+result.data.id+');" class="dropdown-item"> V ' + count +' ('+result.data.version+')</a></li>');
                    feather.replace();
                }
            }
        });
        if (id == '') {
            var uploadUrl = "<?php echo get_uri("audio_chat/upload_file_temp"); ?>";
            var validationUrl = "<?php echo get_uri("audio_chat/validate_audio_file"); ?>";
            var dropzone = attachDropzoneWithForm("#add-audio_chat-form", uploadUrl, validationUrl, {maxFiles: 1}); 
        }
        setTimeout(function () {
            $("#title").focus();
        }, 200);

    });
</script>    