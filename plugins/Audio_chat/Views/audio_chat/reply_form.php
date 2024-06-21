<?php echo form_open(get_uri("audio_chat/comment_save"), array("class" => "comment_reply-form general-form", "role" => "form")); ?>
<div class="mb15 pr15 box">
    <!-- <div class="box-content avatar avatar-sm pr15">
        <img src="<?php echo get_avatar($login_user->image); ?>" alt="..." />
    </div> -->
    <?php if(!isset($audio_comment_reply)){ ?>
        <div class="box-content "style="width:40px">
            <a href="javascript:;" class="btn btn-default" onclick="reply_form_hide()" >X</a>   
        </div>

    <?php } ?>
    <div class="box-content form-group">
        <input type="hidden" name="id" value="<?php echo isset($audio_comment_reply) ? $audio_comment_reply->id : ''; ?>">
        <input type="hidden" name="comment_id" value="<?php echo isset($audio_comment_reply) ? $audio_comment_reply->comment_id : $audio_comment->id; ?>">
        <input type="hidden" name="project_id" value="<?php echo isset($audio_comment_reply) ? $audio_comment_reply->project_id : $audio_comment->project_id; ?>">
        <input type="hidden" name="audio_version" value="<?php echo isset($audio_comment_reply) ? $audio_comment_reply->audio_version : $audio_comment->audio_version; ?>">
        <?php if (isset($audio_comment_reply)) {
            echo '<input type="hidden" name="audio_time" value="'.$audio_comment_reply->audio_time.'">';

        }?>

        <?php
        $border_class = isset($audio_comment_reply)?'border border-secondary':'';
        echo form_input(array(
             "id" => "comment",
             "name" => "comment",
             "class" => "form-control ".$border_class,
             "value" => isset($audio_comment_reply) ? $audio_comment_reply->comment : '',
             "placeholder" => app_lang('type_reply'),
             "data-rule-required" => true,
             "data-msg-required" => app_lang("field_required"),
             "data-rich-text-editor" => true,
         ));
        ?>

    </div> 
        
</div>
<?php echo form_close(); ?>

<script type="text/javascript">
    $(document).ready(function () {
        $(".comment_reply-form").appForm({
            isModal: false,
            onSuccess: function (result) {
                $(".comment_reply-form").parent().html("");
                var audio_comment_id = '<?php echo isset($audio_comment_reply) ? $audio_comment_reply->id : '0'; ?>';
                var perent_comment_id = '<?php echo isset($audio_comment_reply) ? $audio_comment_reply->comment_id : '0'; ?>';
                if (audio_comment_id !='0' && perent_comment_id=='0') {
                    $("#audio_comment-<?php echo isset($audio_comment_reply) ? $audio_comment_reply->id : ''; ?>").html('');
                    $("#audio_comment-<?php echo isset($audio_comment_reply) ? $audio_comment_reply->id : ''; ?>").append('<span class="comment-reply-<?php echo isset($audio_comment_reply) ? $audio_comment_reply->id : ''; ?>">'+result.data+'</span>');
                } else {
                    var comment_id = '<?php echo isset($audio_comment_reply) ? $audio_comment_reply->comment_id : $audio_comment->id; ?>';
                    if(audio_comment_id != 0){
                        $("#audio_comment_reply-"+audio_comment_id).html('<span class="comment-reply-'+audio_comment_id+'">'+result.data+'</span>');
                    }else{
                        $("#comment_reply-list-"+ comment_id).prepend(result.data);
                    }
                    var totalCount = $("#comment_reply-list-"+comment_id+" .reply_total_count").length;
                    if(totalCount == 1){
                        $("#view_replies-"+comment_id).removeClass("hide");
                    }
                    $(".reply_total"+comment_id).text(totalCount);
                }
            }
        });
        $(document).on('click', '.comment_reply-form #comment', function() {
            $(this).addClass("border border-secondary");
        });

    });
    function reply_form_hide() {
        $('.comment_reply-form').hide();
    }

</script>