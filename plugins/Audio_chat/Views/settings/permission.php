<?php if ($login_user->is_admin) { 
    // echo "<pre>";
    // print_r($permissions);exit();
   // $audio_chat_permission = get_array_value($permissions, "audio_chat_permission");
   $edit_audio_project_per = get_array_value($permissions, "edit_audio_project_per");
   $add_audio_project_per = get_array_value($permissions, "add_audio_project_per");
   $delete_audio_project_per = get_array_value($permissions, "delete_audio_project_per");
?>
<li>
    <span data-feather="key" class="icon-14 ml-20"></span>
    <h5><?php echo app_lang("audio_chat_can_manage"); ?></h5>
    <div>
        <?php
        if (is_null($add_audio_project_per)) {
            $add_audio_project_per = "";
        }
        echo form_checkbox("add_audio_project_per", "yes", $add_audio_project_per, "id='add_audio_project_per' class='form-check-input'")
        ?>
        <label for="audio_chat_no"><?php echo app_lang("add_audio_project"); ?> </label>
    </div>
    <div>
        <?php
        if (is_null($edit_audio_project_per)) {
            $edit_audio_project_per = "";
        }
        echo form_checkbox("edit_audio_project_per", "yes", $edit_audio_project_per, "id='edit_audio_project_per' class='form-check-input'")
        ?>
        <label for="audio_chat_no"><?php echo app_lang("edit_audio_project"); ?> </label>
    </div>
    <div>
        <?php
        if (is_null($delete_audio_project_per)) {
            $delete_audio_project_per = "";
        }
        echo form_checkbox("delete_audio_project_per", "yes", $delete_audio_project_per, "id='delete_audio_project_per' class='form-check-input'")
        ?>
        <label for="audio_chat_no"><?php echo app_lang("delete_audio_project"); ?> </label>
    </div>
    <!-- <div>
        <?php
        // if (is_null($audio_chat_permission)) {
        //     $audio_chat_permission = "";
        // }

        // echo form_radio(array(
        //     "id" => "audio_chat_no",
        //     "name" => "audio_chat_permission",
        //     "value" => "no",
        //     "class" => "form-check-input"
        //         ), $audio_chat_permission, ($audio_chat_permission === "no" || $audio_chat_permission === "no") ? true : false);
        ?>
        <label for="audio_chat_no"><?php //echo app_lang("no"); ?> </label>
    </div>
    <div>
        <?php
        // echo form_radio(array(
        //     "id" => "audio_chat_yes",
        //     "name" => "audio_chat_permission",
        //     "value" => "yes",
        //     "class" => "form-check-input"
        //         ), $audio_chat_permission, ($audio_chat_permission === "yes") ? true : false);
        ?>
        <label for="audio_chat_yes"><?php //echo app_lang("yes"); ?></label>
    </div> -->
</li>
<?php } ?>

