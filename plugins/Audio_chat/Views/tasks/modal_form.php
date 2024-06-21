<?php 
echo form_open(get_uri("task/save"), array("id" => "task-form", "class" => "general-form", "role" => "form")); ?>
<div id="tasks-dropzone" class="post-dropzone">
    <div class="modal-body clearfix">
        <div class="container-fluid">
            <input type="hidden" name="id" value="<?php echo $model_info->id; ?>" />
            <input type="hidden" name="project_id" value="<?php echo ($model_info->project_id!='')?$model_info->project_id:$project_id; ?>" />
            <input type="hidden" name="audio_version_id" value="<?php echo $audio_version_id; ?>" />
            <input type="hidden" name="audio_time" value="<?php echo ($model_info->audio_time!='')?$model_info->audio_time:$audio_time; ?>" />
            <input type="hidden" name="audio_seconds" value="<?php echo ($model_info->audio_seconds!='')?$model_info->audio_seconds:$audio_seconds; ?>" />
            <?php if ($is_clone) { ?>
                <input type="hidden" name="is_clone" value="1" />
            <?php } ?>
            <div class="form-group">
                <div class="row">
                    <label for="title" class=" col-md-3"><?php echo app_lang('title'); ?></label>
                    <div class=" col-md-9">
                        <?php
                        echo form_input(array(
                            "id" => "title",
                            "name" => "title",
                            "value" => $model_info->title,
                            "class" => "form-control",
                            "placeholder" => app_lang('title'),
                            "autofocus" => true,
                            "data-rule-required" => true,
                            "data-msg-required" => app_lang("field_required"),
                        ));
                        ?>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <label for="description" class=" col-md-3"><?php echo app_lang('description'); ?></label>
                    <div class=" col-md-9">
                        <?php
                        echo form_textarea(array(
                            "id" => "description",
                            "name" => "description",
                            "value" => process_images_from_content($model_info->description, false),
                            "class" => "form-control",
                            "placeholder" => app_lang('description'),
                            "data-rich-text-editor" => true
                        ));
                        ?>
                    </div>
                </div>
            </div>
            <?php
            $related_to_dropdowns = array();
              ?>
                <input type="hidden" name="context" id="task-context" value="project" />
            <div class="form-group">
                <div class="row">
                    <label for="points" class="col-md-3"><?php echo app_lang('points'); ?>
                        <span class="help" data-bs-toggle="tooltip" title="<?php echo app_lang('task_point_help_text'); ?>"><i data-feather="help-circle" class="icon-16"></i></span>
                    </label>

                    <div class="col-md-9">
                        <?php
                        echo form_dropdown("points", $points_dropdown, array($model_info->points), "class='select2'");
                        ?>
                    </div>
                </div>
            </div>
            <div class="form-group" id="milestones-dropdown">
                <div class="row">
                    <label for="milestone_id" class=" col-md-3"><?php echo app_lang('milestone'); ?></label>
                    <div class="col-md-9" id="dropdown-apploader-section">
                        <?php
                        echo form_input(array(
                            "id" => "milestone_id",
                            "name" => "milestone_id",
                            "value" => $model_info->milestone_id,
                            "class" => "form-control",
                            "placeholder" => app_lang('milestone')
                        ));
                        ?>
                    </div>
                </div>
            </div>
            <?php if ($show_assign_to_dropdown) { ?>
                <div class="form-group">
                    <div class="row">
                        <label for="assigned_to" class=" col-md-3"><?php echo app_lang('assign_to'); ?></label>
                        <div class="col-md-9" id="dropdown-apploader-section">
                            <?php
                            echo form_input(array(
                                "id" => "assigned_to",
                                "name" => "assigned_to",
                                "value" => $model_info->assigned_to,
                                "class" => "form-control",
                                "placeholder" => app_lang('assign_to')
                            ));
                            ?>
                        </div>
                    </div>
                </div>

                <div class="form-group">
                    <div class="row">
                        <label for="collaborators" class=" col-md-3"><?php echo app_lang('collaborators'); ?></label>
                        <div class="col-md-9" id="dropdown-apploader-section">
                            <?php
                            echo form_input(array(
                                "id" => "collaborators",
                                "name" => "collaborators",
                                "value" => $model_info->collaborators,
                                "class" => "form-control",
                                "placeholder" => app_lang('collaborators')
                            ));
                            ?>
                        </div>
                    </div>
                </div>

            <?php } ?>

            <div class="form-group">
                <div class="row">
                    <label for="status_id" class=" col-md-3"><?php echo app_lang('status'); ?></label>
                    <div class="col-md-9">
                        <?php
                        $selected_status = get_array_value($statuses_dropdown[0], "id");

                        if (!$is_clone && $model_info->status_id) {
                            $selected_status = $model_info->status_id;
                        }

                        echo form_input(array(
                            "id" => "task_status_id",
                            "name" => "status_id",
                            "value" => $selected_status,
                            "class" => "form-control"
                        ));
                        ?>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <label for="priority_id" class=" col-md-3"><?php echo app_lang('priority'); ?></label>
                    <div class="col-md-9">
                        <?php
                        echo form_input(array(
                            "id" => "priority_id",
                            "name" => "priority_id",
                            "value" => $model_info->priority_id,
                            "class" => "form-control",
                            "placeholder" => app_lang('priority')
                        ));
                        ?>
                    </div>
                </div>
            </div>
            <div class="form-group">
                <div class="row">
                    <label for="project_labels" class=" col-md-3"><?php echo app_lang('labels'); ?></label>
                    <div class=" col-md-9" id="dropdown-apploader-section">
                        <?php
                        echo form_input(array(
                            "id" => "project_labels",
                            "name" => "labels",
                            "value" => $model_info->labels,
                            "class" => "form-control",
                            "placeholder" => app_lang('labels')
                        ));
                        ?>
                    </div>
                </div>
            </div>
            <div class="clearfix">
                <div class="row">
                    <label for="start_date" class="<?php echo $show_time_with_task ? "col-md-3 col-sm-3" : "col-md-3" ?>"><?php echo app_lang('start_date'); ?></label>
                    <div class="<?php echo $show_time_with_task ? "col-md-4 col-sm-4" : "col-md-9" ?> form-group">
                        <?php
                        echo form_input(array(
                            "id" => "start_date",
                            "name" => "start_date",
                            "autocomplete" => "off",
                            "value" => is_date_exists($model_info->start_date) ? date("Y-m-d", strtotime($model_info->start_date)) : "",
                            "class" => "form-control",
                            "placeholder" => "YYYY-MM-DD"
                        ));
                        ?>
                    </div>

                    <?php if ($show_time_with_task) { ?>
                        <label for="start_time" class=" col-md-2 col-sm-2"><?php echo app_lang('start_time'); ?></label>
                        <div class=" col-md-3 col-sm-3 form-group">
                            <?php
                            $start_date = (is_date_exists($model_info->start_date)) ? $model_info->start_date : "";
                            if ($time_format_24_hours) {
                                $start_time = $start_date ? date("H:i", strtotime($start_date)) : "";
                            } else {
                                if (date("H:i:s", strtotime($start_date)) == "00:00:00") {
                                    $start_time = "";
                                } else {
                                    $start_time = $start_date ? convert_time_to_12hours_format(date("H:i:s", strtotime($start_date))) : "";
                                }
                            }
                            echo form_input(array(
                                "id" => "start_time",
                                "name" => "start_time",
                                "value" => $start_time,
                                "class" => "form-control",
                                "placeholder" => app_lang('start_time')
                            ));
                            ?>
                        </div>
                    <?php } ?>
                </div>
            </div>

            <div class="clearfix">
                <div class="row">
                    <label for="deadline" class="<?php echo $show_time_with_task ? "col-md-3 col-sm-3" : "col-md-3" ?>"><?php echo app_lang('deadline'); ?></label>
                    <div class="<?php echo $show_time_with_task ? "col-md-4 col-sm-4" : "col-md-9" ?> form-group">
                        <?php
                        echo form_input(array(
                            "id" => "deadline",
                            "name" => "deadline",
                            "autocomplete" => "off",
                            "value" => is_date_exists($model_info->deadline) ? date("Y-m-d", strtotime($model_info->deadline)) : "",
                            "class" => "form-control",
                            "placeholder" => "YYYY-MM-DD",
                            "data-rule-greaterThanOrEqual" => "#start_date",
                            "data-msg-greaterThanOrEqual" => app_lang("deadline_must_be_equal_or_greater_than_start_date")
                        ));
                        ?>
                    </div>

                    <?php if ($show_time_with_task) { ?>
                        <label for="end_time" class=" col-md-2 col-sm-2"><?php echo app_lang('end_time'); ?></label>
                        <div class=" col-md-3 col-sm-3 form-group">
                            <?php
                            $deadline = (is_date_exists($model_info->deadline)) ? $model_info->deadline : "";
                            if ($time_format_24_hours) {
                                $end_time = $deadline ? date("H:i", strtotime($deadline)) : "";
                            } else {
                                if (date("H:i:s", strtotime($deadline)) == "00:00:00") {
                                    $end_time = "";
                                } else {
                                    $end_time = $deadline ? convert_time_to_12hours_format(date("H:i:s", strtotime($deadline))) : "";
                                }
                            }
                            echo form_input(array(
                                "id" => "end_time",
                                "name" => "end_time",
                                "value" => $end_time,
                                "class" => "form-control",
                                "placeholder" => app_lang('end_time')
                            ));
                            ?>
                        </div>
                    <?php } ?>
                </div>
            </div>

            <?php if (get_setting("enable_recurring_option_for_tasks")) { ?>

                <div class="form-group">
                    <div class="row">
                        <label for="recurring" class=" col-md-3"><?php echo app_lang('recurring'); ?>  <span class="help" data-bs-toggle="tooltip" title="<?php echo app_lang('cron_job_required'); ?>"><i data-feather="help-circle" class="icon-16"></i></span></label>
                        <div class=" col-md-9">
                            <?php
                            echo form_checkbox("recurring", "1", $model_info->recurring ? true : false, "id='recurring' class='form-check-input'");
                            ?>
                        </div>
                    </div>
                </div>   

                <div id="recurring_fields" class="<?php if (!$model_info->recurring) echo "hide"; ?>"> 
                    <div class="form-group">
                        <div class="row">
                            <label for="repeat_every" class=" col-md-3"><?php echo app_lang('repeat_every'); ?></label>
                            <div class="col-md-4">
                                <?php
                                echo form_input(array(
                                    "id" => "repeat_every",
                                    "name" => "repeat_every",
                                    "type" => "number",
                                    "value" => $model_info->repeat_every ? $model_info->repeat_every : 1,
                                    "min" => 1,
                                    "class" => "form-control recurring_element",
                                    "placeholder" => app_lang('repeat_every'),
                                    "data-rule-required" => true,
                                    "data-msg-required" => app_lang("field_required")
                                ));
                                ?>
                            </div>
                            <div class="col-md-5">
                                <?php
                                echo form_dropdown(
                                        "repeat_type", array(
                                    "days" => app_lang("interval_days"),
                                    "weeks" => app_lang("interval_weeks"),
                                    "months" => app_lang("interval_months"),
                                    "years" => app_lang("interval_years"),
                                        ), $model_info->repeat_type ? $model_info->repeat_type : "months", "class='select2 recurring_element' id='repeat_type'"
                                );
                                ?>
                            </div>
                        </div>    
                    </div>    

                    <div class="form-group">
                        <div class="row">
                            <label for="no_of_cycles" class=" col-md-3"><?php echo app_lang('cycles'); ?></label>
                            <div class="col-md-4">
                                <?php
                                echo form_input(array(
                                    "id" => "no_of_cycles",
                                    "name" => "no_of_cycles",
                                    "type" => "number",
                                    "min" => 1,
                                    "value" => $model_info->no_of_cycles ? $model_info->no_of_cycles : "",
                                    "class" => "form-control",
                                    "placeholder" => app_lang('cycles')
                                ));
                                ?>
                            </div>
                            <div class="col-md-5 mt5">
                                <span class="help" data-bs-toggle="tooltip" title="<?php echo app_lang('recurring_cycle_instructions'); ?>"><i data-feather="help-circle" class="icon-16"></i></span>
                            </div>
                        </div>  
                    </div>  

                    <div class = "form-group hide" id = "next_recurring_date_container" >
                        <div class="row">
                            <label for = "next_recurring_date" class = " col-md-3"><?php echo app_lang('next_recurring_date'); ?>  </label>
                            <div class=" col-md-9">
                                <?php
                                echo form_input(array(
                                    "id" => "next_recurring_date",
                                    "name" => "next_recurring_date",
                                    "class" => "form-control",
                                    "placeholder" => app_lang('next_recurring_date'),
                                    "autocomplete" => "off",
                                    "data-rule-required" => true,
                                    "data-msg-required" => app_lang("field_required"),
                                ));
                                ?>
                            </div>
                        </div>
                    </div>
                </div>  

            <?php } ?>

            <?php echo view("custom_fields/form/prepare_context_fields", array("custom_fields" => $custom_fields, "label_column" => "col-md-3", "field_column" => " col-md-9")); ?> 

            <?php echo view("includes/dropzone_preview"); ?>

            <?php if ($is_clone) { ?>
                <?php if ($has_checklist) { ?>
                    <div class="form-group">
                        <label for="copy_checklist" class=" col-md-12">
                            <?php
                            echo form_checkbox("copy_checklist", "1", true, "id='copy_checklist' class='float-start mr15 form-check-input'");
                            ?>    
                            <?php echo app_lang('copy_checklist'); ?>
                        </label>
                    </div>
                <?php } ?>

                <?php if ($has_sub_task) { ?>
                    <div class="form-group">
                        <label for="copy_sub_tasks" class=" col-md-12">
                            <?php
                            echo form_checkbox("copy_sub_tasks", "1", false, "id='copy_sub_tasks' class='float-start mr15 form-check-input'");
                            ?>    
                            <?php echo app_lang('copy_sub_tasks'); ?>
                        </label>
                    </div>
                <?php } ?>
            <?php } ?>
        </div>
    </div>

    <div class="modal-footer">
        <div id="link-of-new-view" class="hide">
            <?php
            echo modal_anchor(get_uri("tasks/view"), "", array("data-modal-lg" => "1"));
            ?>
        </div>

        <?php
        if (!$model_info->id) {
            echo view("includes/upload_button");
        }
        ?>

        <button type="button" class="btn btn-default" data-bs-dismiss="modal"><span data-feather="x" class="icon-16"></span> <?php echo app_lang('close'); ?></button>
            <?php if ($view_type !== "details") { ?>
                <button id="save-and-show-button" type="button" class="btn btn-info text-white"><span data-feather="check-circle" class="icon-16"></span> <?php echo app_lang('save_and_show'); ?></button>
            <?php } ?>
            <button type="submit" class="btn btn-primary"><span data-feather="check-circle" class="icon-16"></span> <?php echo app_lang('save'); ?></button>
    </div>
</div>
<?php echo form_close(); ?>

<script type="text/javascript">
    $(document).ready(function () {

        //send data to show the task after save
        window.showAddNewModal = false;

        $("#save-and-show-button, #save-and-add-button").click(function () {
            window.showAddNewModal = true;
            $(this).trigger("submit");
        });

        var taskShowText = "<?php echo app_lang('task_info') ?>";

        window.taskForm = $("#task-form").appForm({
            closeModalOnSuccess: false,
            onSuccess: function (result) {
                var task_id = '<?php echo isset($model_info) ? $model_info->id : '0'; ?>';
                if (task_id==0) {
                    $("#audio_comment_list").prepend(result.data);
                    $('#no_comments_yet').hide();
                    location.reload();
                }else{
                    $("#task_list_container-"+task_id+" .task_title_"+task_id).text(result.data);
                }
                $("#reload-kanban-button:visible").trigger("click");

                $("#save_and_show_value").append(result.save_and_show_link);

                if (window.showAddNewModal) {
                    var $taskViewLink = $("#link-of-new-view").find("a");

                        $taskViewLink.attr("data-action-url", "<?php echo get_uri("tasks/view"); ?>");
                        $taskViewLink.attr("data-title", taskShowText + " #" + result.id);
                        $taskViewLink.attr("data-post-id", result.id);
                    

                    $taskViewLink.trigger("click");
                } else {
                    window.taskForm.closeModal();

                    if (window.refreshAfterAddTask) {
                        window.refreshAfterAddTask = false;
                        location.reload();
                    }
                }

                window.reloadKanban = true;

                if (typeof window.reloadGantt === "function") {
                    window.reloadGantt(true);
                }
            },
            onAjaxSuccess: function (result) {
                if (!result.success && result.next_recurring_date_error) {
                    $("#next_recurring_date").val(result.next_recurring_date_value);
                    $("#next_recurring_date_container").removeClass("hide");

                    $("#task-form").data("validator").showErrors({
                        "next_recurring_date": result.next_recurring_date_error
                    });
                }
            }
        });
        $("#task-form .select2").select2();
        setTimeout(function () {
            $("#title").focus();
        }, 200);

        setDatePicker("#start_date");

        setDatePicker("#deadline", {
            endDate: "<?php echo $project_deadline; ?>"
        });

        setTimePicker("#start_time, #end_time");

        $('[data-bs-toggle="tooltip"]').tooltip();

        //show/hide recurring fields
        $("#recurring").click(function () {
            if ($(this).is(":checked")) {
                $("#recurring_fields").removeClass("hide");
            } else {
                $("#recurring_fields").addClass("hide");
            }
        });

        setDatePicker("#next_recurring_date", {
            startDate: moment().add(1, 'days').format("YYYY-MM-DD") //set min date = tomorrow
        });


    });
</script>

<?php
echo view("tasks/get_dropdowns_script", array(
    "related_to_dropdowns" => $related_to_dropdowns,
    "milestones_dropdown" => $milestones_dropdown,
    "assign_to_dropdown" => $assign_to_dropdown,
    "collaborators_dropdown" => $collaborators_dropdown,
    "statuses_dropdown" => $statuses_dropdown,
    "label_suggestions" => $label_suggestions,
    "priorities_dropdown" => $priorities_dropdown
));
