<style>
    .custom-file-upload {
    display: inline-block;
    padding: 6px 12px;
    cursor: pointer;
    border: 1px dashed; #ccc;
    border-radius: 10px;
    background-color: #f1f1f1;
    font-size: 16px;
}
.custom-file-upload input[type="file"] {
    display: none;
}
</style>
<?php 
if(empty($audio_chat)){ ?>
<div id="page-content" class=" clearfix">
    <div class="card">
        <div class="text-center mb15 box">
           <div class="box-content" style="vertical-align: middle; height:20rem">
                <i data-feather="music" width="10rem" height="10rem" style="color:rgba(128, 128, 128, 0.1)"></i>
                <h3 class="mt10"><?php echo app_lang("upload_audio_file"); ?></h3>
                <p class="mt5"><?php echo app_lang("you_can_comment_audio_file");?></p>
                <div id="audio_chat-dropzone" class="post-dropzone">
                <?php  echo form_open_multipart('', array("id" => "audio_chat-form", "class" => "general-form bg-white", "role" => "form")); ?>
    
                    <div class="float-start mr15">
                        <?php echo view("includes/dropzone_preview"); ?>    
                    </div>
                    <div class="upload-file-button btn btn-default btn-sm">
                        <span><i data-feather="upload" class="icon-14"></i> <?php echo app_lang("upload"); ?></span>
                    </div>
                    <?php echo form_close();?>
                </div>
                    
           </div>
        </div>
    </div>
</div>
<script>
    $(document).ready(function () {
      $('span.help').addClass('hide');
       var uploadUrl = "<?php echo get_uri("audio_chat/upload_file/".$project_id); ?>";
        var validationUrl = "<?php echo get_uri("audio_chat/validate_audio_file"); ?>";
        var dropzone = attachDropzoneWith_Form("#audio_chat-form", uploadUrl, validationUrl, {maxFiles: 1});
    });
    function attachDropzoneWith_Form(dropzoneTarget, uploadUrl, validationUrl, options) {
    var $dropzonePreviewArea = $(dropzoneTarget),
            $dropzonePreviewScrollbar = $dropzonePreviewArea.find(".post-file-dropzone-scrollbar"),
            $previews = $dropzonePreviewArea.find(".post-file-previews"),
            $postFileUploadRow = $dropzonePreviewArea.find(".post-file-upload-row"),
            $uploadFileButton = $dropzonePreviewArea.find(".upload-file-button"),
            $submitButton = $dropzonePreviewArea.find("button[type=submit]"),
            previewsContainer = getRandomAlphabet(15),
            postFileUploadRowId = getRandomAlphabet(15),
            uploadFileButtonId = getRandomAlphabet(15);

    //set random id with the previws 
    $previews.attr("id", previewsContainer);
    $postFileUploadRow.attr("id", postFileUploadRowId);
    $uploadFileButton.attr("id", uploadFileButtonId);


    //get the template HTML and remove it from the doumenthe template HTML and remove it from the doument
    var previewNode = document.querySelector("#" + postFileUploadRowId);
    previewNode.id = "";
    var previewTemplate = previewNode.parentNode.innerHTML;
    previewNode.parentNode.removeChild(previewNode);

    if (!options)
        options = {};

    var postFilesDropzone = new Dropzone(dropzoneTarget, {
        url: uploadUrl,
        thumbnailWidth: 80,
        thumbnailHeight: 80,
        parallelUploads: 20,
        maxFilesize: 3000,
        previewTemplate: previewTemplate,
        dictDefaultMessage: AppLanugage.fileUploadInstruction,
        autoQueue: true,
        previewsContainer: "#" + previewsContainer,
        clickable: "#" + uploadFileButtonId,
        maxFiles: options.maxFiles ? options.maxFiles : 1000,
        timeout: 20000000, //20000 seconds
        sending: function (file, xhr, formData) {
            formData.append(AppHelper.csrfTokenName, AppHelper.csrfHash);
        },
        init: function () {
            this.on("maxfilesexceeded", function (file) {
                this.removeAllFiles();
                this.addFile(file);
            });
        },
        accept: function (file, done) {
            if (file.name.length > 200) {
                done(AppLanugage.fileNameTooLong);
            }

            if (file.size > AppHelper.uploadMaxFileSize) {
                done(AppLanugage.fileSizeTooLong);
                appAlert.error(AppLanugage.fileSizeTooLong);
            }

            $dropzonePreviewScrollbar.removeClass("hide");
            initScrollbar($dropzonePreviewScrollbar, {setHeight: 90});

            $dropzonePreviewScrollbar.parent().removeClass("hide");
            $dropzonePreviewArea.find("textarea").focus();

            var postData = {file_name: file.name, file_size: file.size};

            //validate the file
            $.ajax({
                url: validationUrl,
                data: postData,
                cache: false,
                type: 'POST',
                dataType: "json",
                success: function (response) {
                    if (response.success) {

                        $(file.previewTemplate).append('<input type="hidden" name="file_names[]" value="' + file.name + '" />\n\
                                 <input type="hidden" name="file_sizes[]" value="' + file.size + '" />');
                        done();
                    } else {
                        appAlert.error(response.message);
                        $(file.previewTemplate).find("input").remove();
                        done(response.message);

                    }
                }
            });
        },
        processing: function () {
            $submitButton.prop("disabled", true);
            appLoader.show();
        },
        queuecomplete: function () {
            $submitButton.prop("disabled", false);
            appLoader.hide();
        },
        reset: function (file) {
            $dropzonePreviewScrollbar.addClass("hide");
        },
        fallback: function () {
            //add custom fallback;
            $("body").addClass("dropzone-disabled");

            $uploadFileButton.click(function () {
                //fallback for old browser
                $(this).html("<i data-feather='camera' class='icon-16'></i> Add more");

                $dropzonePreviewScrollbar.removeClass("hide");
                initScrollbar($dropzonePreviewScrollbar, {setHeight: 90});

                $dropzonePreviewScrollbar.parent().removeClass("hide");
                $previews.prepend("<div class='clearfix p5 file-row'><button type='button' class='btn btn-xs btn-danger pull-left mr10 remove-file'><i data-feather='x' class='icon-16'></i></button> <input class='pull-left' type='file' name='manualFiles[]' /></div>");

            });
            $previews.on("click", ".remove-file", function () {
                $(this).parent().remove();
            });
        },
        success: function (file) {
            setTimeout(function () {
                $(file.previewElement).find(".progress-bar-striped").removeClass("progress-bar-striped progress-bar-animated");
                location.reload();
                if (file.status=='success') {
                   appAlert.success('audio upload file successfully');
                } 
            }, 1000);
        }
    });

    return true;
};
    
    </script>
<?php }