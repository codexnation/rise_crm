<?php
/**
 * Custom_field Controller
 *
 * @package     CodeIgniter
 * @subpackage  Controllers
 * @category    Controllers
 */

namespace Audio_chat\Controllers;

use App\Controllers\Security_Controller;

class Task extends \App\Controllers\Security_Controller {
    // protected $Audio_chat_model;
    function __construct() {
        parent::__construct();
        $this->staff_id = $this->login_user->id;
        $this->Audio_comment_model = new \Audio_chat\Models\Audio_comment_model();
        $this->Task_priority_model = model("App\Models\Task_priority_model");
        $this->Project_settings_model = model('App\Models\Project_settings_model');
    }
    function index() {
        if(!can_manage_audio_chat('audio_chat')) {
            app_redirect("forbidden");
        }
    }
  
    function tasks_modal_form($a_v_id)
    {   
        $id = $this->request->getPost('id');
        $project_id = $this->request->getPost('project_id');
        $audio_time = $this->request->getPost('audio_time');
        $audio_seconds = $this->request->getPost('audio_seconds');
        $model_info = $this->Tasks_model->get_one($id);
        $view_data =[];
        if ($model_info->context) {
            $selected_context = $model_info->context; //has highest priority 
            $context_id_key = $model_info->context . "_id";
            $selected_context_id = $model_info->{$context_id_key};
        }

        $dropdowns = $this->_get_task_related_dropdowns('project',$project_id, true);
        $view_data = array_merge($view_data, $dropdowns);
        $view_data['model_info'] = $model_info;
        $view_data["audio_version_id"] = $a_v_id;
        $view_data["project_id"] = $project_id;
        $view_data["audio_time"] = $audio_time;
        $view_data["audio_seconds"] = $audio_seconds;
        $view_data['is_clone'] = $this->request->getPost('is_clone');
        $view_data['view_type'] = $this->request->getPost("view_type");

        $view_data['show_assign_to_dropdown'] = true;
        if ($this->login_user->user_type == "client") {
            if (!get_setting("client_can_assign_tasks")) {
                $view_data['show_assign_to_dropdown'] = false;
            }
        } else {
            if (!$id && !$view_data['model_info']->assigned_to) {
                $view_data['model_info']->assigned_to = $this->login_user->id;
            }
        }

        $view_data["custom_fields"] = $this->Custom_fields_model->get_combined_details("tasks", $view_data['model_info']->id, $this->login_user->is_admin, $this->login_user->user_type)->getResult();
        $view_data["project_deadline"] = $this->_get_project_deadline_for_task(get_array_value($view_data, $project_id));
        $view_data["show_time_with_task"] = (get_setting("show_time_with_task_start_date_and_deadline")) ? true : false;
        $view_data['time_format_24_hours'] = get_setting("time_format") == "24_hours" ? true : false;

        return $this->template->view(AUDIO_CHAT."\Views/tasks\modal_form",$view_data);

    }
    private function _get_task_related_dropdowns($context = "", $context_id = 0, $return_empty_context = false) {

        //get milestone dropdown
        $milestones_dropdown = array(array("id" => "", "text" => "-"));
        if ($context == "project" && $context_id) {
            $milestones = $this->Milestones_model->get_details(array("project_id" => $context_id, "deleted" => 0))->getResult();
            foreach ($milestones as $milestone) {
                $milestones_dropdown[] = array("id" => $milestone->id, "text" => $milestone->title);
            }
        }

        //get project members and collaborators dropdown
        if ($context == "project" && $context_id) {
            $show_client_contacts = $this->can_access_clients(true);
            if ($this->login_user->user_type === "client" && get_setting("client_can_assign_tasks")) {
                $show_client_contacts = true;
            }
            $project_members = $this->Project_members_model->get_project_members_dropdown_list($context_id, array(), $show_client_contacts, true)->getResult();
        } else if ($context == "project") {
            $project_members = array();
        } else {
            $options = array("status" => "active", "user_type" => "staff");
            $project_members = $this->Users_model->get_details($options)->getResult();
        }


        $assign_to_dropdown = array(array("id" => "", "text" => "-"));
        $collaborators_dropdown = array();
        foreach ($project_members as $member) {
            $user_id = isset($member->user_id) ? $member->user_id : $member->id;
            $member_name = isset($member->member_name) ? $member->member_name : ($member->first_name . " " . $member->last_name);
            $assign_to_dropdown[] = array("id" => $user_id, "text" => $member_name);
            $collaborators_dropdown[] = array("id" => $user_id, "text" => $member_name);
        }

        //get labels suggestion
        $label_suggestions = $this->make_labels_dropdown("task");

        $task_status_options = array();
        if ($context == "project" && $context_id) {
            $task_status_options["exclude_status_ids"] = $this->get_removed_task_status_ids($context_id);
        } else {
            $task_status_options["hide_from_non_project_related_tasks"] = 0;
        }

        //statues dropdown
        $statuses_dropdown = array();
        $statuses = $this->Task_status_model->get_details($task_status_options)->getResult();
        foreach ($statuses as $status) {
            $statuses_dropdown[] = array("id" => $status->id, "text" => $status->key_name ? app_lang($status->key_name) : $status->title);
        }

        //task points dropdown 
        $task_points = array();
        $task_point_range = get_setting("task_point_range");
        $task_point_start = 1;
        if (str_starts_with($task_point_range, '0')) {
            $task_point_start = 0;
        }

        for ($i = $task_point_start; $i <= $task_point_range * 1; $i++) {
            if ($i <= 1) {
                $task_points[$i] = $i . " " . app_lang('point');
            } else {
                $task_points[$i] = $i . " " . app_lang('points');
            }
        }
        //properties dropdown 
        $priorities = $this->Task_priority_model->get_details()->getResult();
        $priorities_dropdown = array(array("id" => "", "text" => "-"));
        foreach ($priorities as $priority) {
            $priorities_dropdown[] = array("id" => $priority->id, "text" => $priority->title);
        }
        return array(
            "milestones_dropdown" => $milestones_dropdown,
            "assign_to_dropdown" => $assign_to_dropdown,
            "collaborators_dropdown" => $collaborators_dropdown,
            "label_suggestions" => $label_suggestions,
            "statuses_dropdown" => $statuses_dropdown,
            "points_dropdown" => $task_points,
            "priorities_dropdown" => $priorities_dropdown,
        );
    }
    private function _get_project_deadline_for_task($project_id = 0) {
        if (!$project_id) {
            return "";
        }
        $project_deadline_date = "";
        $project_deadline = $this->Projects_model->get_one($project_id)->deadline;
        if (get_setting("task_deadline_should_be_before_project_deadline") && is_date_exists($project_deadline)) {
            $project_deadline_date = format_to_date($project_deadline, false);
        }
        return $project_deadline_date;
    }
    private function get_removed_task_status_ids($project_id = 0) {
        if (!$project_id) {
            return "";
        }

        $this->init_project_settings($project_id);
        return get_setting("remove_task_statuses");
    }
    function save() {
        $project_id = $this->request->getPost('project_id');
        $id = $this->request->getPost('id');
        $now = get_current_utc_time();

        $is_clone = $this->request->getPost('is_clone');
        $main_task_id = "";
        if ($is_clone && $id) {
            $main_task_id = $id; //store main task id to get items later
            $id = ""; //on cloning task, save as new
        }
        $context_data = $this->get_context_and_id();
        $context = $context_data["context"] ? $context_data["context"] : "project";
        if ($id) {
            $task_info = $this->Tasks_model->get_one($id);
        }
        $assigned_to = $this->request->getPost('assigned_to');
        $collaborators = $this->request->getPost('collaborators');
        $recurring = $this->request->getPost('recurring') ? 1 : 0;
        $repeat_every = $this->request->getPost('repeat_every');
        $repeat_type = $this->request->getPost('repeat_type');
        $no_of_cycles = $this->request->getPost('no_of_cycles');
        $status_id = $this->request->getPost('status_id');
        $priority_id = $this->request->getPost('priority_id');
        $milestone_id = $this->request->getPost('milestone_id');
        $start_date = $this->request->getPost('start_date');
        $deadline = $this->request->getPost('deadline');
        //convert to 24hrs time format
        $start_time = $this->request->getPost('start_time');
        $end_time = $this->request->getPost('end_time');
        if (get_setting("time_format") != "24_hours") {
            $start_time = convert_time_to_24hours_format($start_time);
            $end_time = convert_time_to_24hours_format($end_time);
        }

        if ($start_time && strlen($start_time) == 4 || strlen($start_time) == 7) {
            $start_time = "0" . $start_time; // ex. convert 9:00 to 09:00
        }

        if ($end_time && strlen($end_time) == 4 || strlen($end_time) == 7) {
            $end_time = "0" . $end_time; // ex. convert 9:00 to 09:00
        }

        if ($start_date) {
            if ($start_time) {
                $start_date = $start_date . " " . $start_time;
            }
        }
        if ($deadline) {
            if ($end_time) {
                $deadline = $deadline . " " . $end_time;
            }
        }
        if ($this->request->getPost('audio_time')) {
            $timeParts = explode('-', $this->request->getPost('audio_time'));
            if (count($timeParts) === 2) {
                $audio_time = $timeParts[0];
                $audio_time_end = $timeParts[1];
            }else{
               $audio_time = $timeParts[0]; 
               $audio_time_end =null;
            }
        }

        $data = array(
            "audio_time" => $audio_time,
            "audio_time_end" => $audio_time_end,
            "audio_seconds" => $this->request->getPost('audio_seconds'),
            "audio_v_id" => $this->request->getPost('audio_version_id'),
            "title" => $this->request->getPost('title'),
            "description" => $this->request->getPost('description'),
            "project_id" => $project_id ? $project_id : 0,
            "milestone_id" => $milestone_id ? $milestone_id : 0,
            "points" => $this->request->getPost('points'),
            "status_id" => $status_id,
            "labels" => $this->request->getPost('labels'),
            "start_date" => $start_date,
            "deadline" => $deadline,
            "recurring" => $recurring,
            "repeat_every" => $repeat_every ? $repeat_every : 0,
            "repeat_type" => $repeat_type ? $repeat_type : NULL,
            "no_of_cycles" => $no_of_cycles ? $no_of_cycles : 0,
        );
        if($id==''){
            $data['audio_task_created_at'] = date('Y-m-d H:i:s');
            $data['audio_task_by'] = $this->login_user->id;
        }

        if (!$id) {
            $data["created_date"] = $now;
            $data["context"] = $context;
            $data["sort"] = $this->Tasks_model->get_next_sort_value($project_id, $status_id);
        }

        

        //clint can't save the assign to and collaborators
        if ($this->login_user->user_type == "client") {
            if (get_setting("client_can_assign_tasks")) {
                $data["assigned_to"] = $assigned_to;
            } else if (!$id) { //it's new data to save
                $data["assigned_to"] = 0;
            }

            $data["collaborators"] = "";
        } else {
            $data["assigned_to"] = $assigned_to;
            $data["collaborators"] = $collaborators;
        }

        $data = clean_data($data);

        //set null value after cleaning the data
        if (!$data["start_date"]) {
            $data["start_date"] = NULL;
        }

        if (!$data["deadline"]) {
            $data["deadline"] = NULL;
        }

        //deadline must be greater or equal to start date
        if ($data["start_date"] && $data["deadline"] && $data["deadline"] < $data["start_date"]) {
            echo json_encode(array("success" => false, 'message' => app_lang('deadline_must_be_equal_or_greater_than_start_date')));
            return false;
        }

        $copy_checklist = $this->request->getPost("copy_checklist");

        $next_recurring_date = "";

        if ($recurring && get_setting("enable_recurring_option_for_tasks")) {
            //set next recurring date for recurring tasks

            if ($id) {
                //update
                if ($this->request->getPost('next_recurring_date')) { //submitted any recurring date? set it.
                    $next_recurring_date = $this->request->getPost('next_recurring_date');
                } else {
                    //re-calculate the next recurring date, if any recurring fields has changed.
                    if ($task_info->recurring != $data['recurring'] || $task_info->repeat_every != $data['repeat_every'] || $task_info->repeat_type != $data['repeat_type'] || $task_info->start_date != $data['start_date']) {
                        $recurring_start_date = $start_date ? $start_date : $task_info->created_date;
                        $next_recurring_date = add_period_to_date($recurring_start_date, $repeat_every, $repeat_type);
                    }
                }
            } else {
                //insert new
                $recurring_start_date = $start_date ? $start_date : get_array_value($data, "created_date");
                $next_recurring_date = add_period_to_date($recurring_start_date, $repeat_every, $repeat_type);
            }


            //recurring date must have to set a future date
            if ($next_recurring_date && get_today_date() >= $next_recurring_date) {
                echo json_encode(array("success" => false, 'message' => app_lang('past_recurring_date_error_message_title_for_tasks'), 'next_recurring_date_error' => app_lang('past_recurring_date_error_message'), "next_recurring_date_value" => $next_recurring_date));
                return false;
            }
        }

        //save status changing time for edit mode
        if ($id) {
            if ($task_info->status_id !== $status_id) {
                $data["status_changed_at"] = $now;
            }

            $this->check_sub_tasks_statuses($status_id, $id);
        }

        $save_id = $this->Tasks_model->ci_save($data, $id);
        if ($save_id) {

            if ($is_clone && $main_task_id) {
                //clone task checklist
                if ($copy_checklist) {
                    $checklist_items = $this->Checklist_items_model->get_all_where(array("task_id" => $main_task_id, "deleted" => 0))->getResult();
                    foreach ($checklist_items as $checklist_item) {
                        //prepare new checklist data
                        $checklist_item_data = (array) $checklist_item;
                        unset($checklist_item_data["id"]);
                        $checklist_item_data['task_id'] = $save_id;

                        $checklist_item = $this->Checklist_items_model->ci_save($checklist_item_data);
                    }
                }

                //clone sub tasks
                if ($this->request->getPost("copy_sub_tasks")) {
                    $sub_tasks = $this->Tasks_model->get_all_where(array("parent_task_id" => $main_task_id, "deleted" => 0))->getResult();
                    foreach ($sub_tasks as $sub_task) {
                        //prepare new sub task data
                        $sub_task_data = (array) $sub_task;

                        unset($sub_task_data["id"]);
                        unset($sub_task_data["blocked_by"]);
                        unset($sub_task_data["blocking"]);

                        $sub_task_data['status_id'] = 1;
                        $sub_task_data['parent_task_id'] = $save_id;
                        $sub_task_data['created_date'] = $now;

                        $sub_task_data["sort"] = $this->Tasks_model->get_next_sort_value($sub_task_data["project_id"], $sub_task_data['status_id']);

                        $sub_task_save_id = $this->Tasks_model->ci_save($sub_task_data);

                        //clone sub task checklist
                        if ($copy_checklist) {
                            $checklist_items = $this->Checklist_items_model->get_all_where(array("task_id" => $sub_task->id, "deleted" => 0))->getResult();
                            foreach ($checklist_items as $checklist_item) {
                                //prepare new checklist data
                                $checklist_item_data = (array) $checklist_item;
                                unset($checklist_item_data["id"]);
                                $checklist_item_data['task_id'] = $sub_task_save_id;

                                $this->Checklist_items_model->ci_save($checklist_item_data);
                            }
                        }
                    }
                }
            }

            //save next recurring date 
            if ($next_recurring_date) {
                $recurring_task_data = array(
                    "next_recurring_date" => $next_recurring_date
                );
                $this->Tasks_model->save_reminder_date($recurring_task_data, $save_id);
            }

            // if created from ticket then save the task id
            

            $activity_log_id = get_array_value($data, "activity_log_id");

            $new_activity_log_id = save_custom_fields("tasks", $save_id, $this->login_user->is_admin, $this->login_user->user_type, $activity_log_id);

            if ($id) {
                //updated
                if ($task_info->context === "project") {
                    log_notification("project_task_updated", array("project_id" => $project_id, "task_id" => $save_id, "activity_log_id" => $new_activity_log_id ? $new_activity_log_id : $activity_log_id));
                } else {
                    $context_id_key = $task_info->context . "_id";
                    $context_id_value = ${$task_info->context . "_id"};

                    log_notification("general_task_updated", array("$context_id_key" => $context_id_value, "task_id" => $save_id, "activity_log_id" => $new_activity_log_id ? $new_activity_log_id : $activity_log_id));
                }
            } else {
                //created
                if ($context === "project") {
                    log_notification("project_task_created", array("project_id" => $project_id, "task_id" => $save_id));
                } else {
                    $context_id_key = $context . "_id";
                    $context_id_value = ${$context . "_id"};

                    log_notification("general_task_created", array("$context_id_key" => $context_id_value, "task_id" => $save_id));
                }

                //save uploaded files as comment
                $target_path = get_setting("timeline_file_path");
                $files_data = move_files_from_temp_dir_to_permanent_dir($target_path, "project_comment");

                if ($files_data && $files_data != "a:0:{}") {
                    $comment_data = array(
                        "created_by" => $this->login_user->id,
                        "created_at" => $now,
                        "project_id" => $project_id,
                        "task_id" => $save_id
                    );

                    $comment_data = clean_data($comment_data);

                    $comment_data["files"] = $files_data; //don't clean serilized data

                    $this->Project_comments_model->save_comment($comment_data);
                }
            }
            if($id==''){
                $save_data = $this->Audio_comment_model->get_audio_version_task($save_id);
                $profile = get_avatar($save_data->created_by_avatar);
                echo json_encode(array("success" => true, "data" => $this->_row_comment_data($save_id), 'id' => $save_id ,"task_datail"=>$save_data,"profile"=>$profile,'message' => app_lang('record_saved')));
            }else{
                echo json_encode(array("success" => true, "data" => $this->request->getPost('title'), 'id' => $save_id, 'message' => app_lang('record_saved')));
            }
        } else {
            echo json_encode(array("success" => false, 'message' => app_lang('error_occurred')));
        }
    }
     private function get_context_and_id($model_info = null) {
        $context_id_pairs = array(array("context" => "project", "id_key" => "project_id", "id" => null));

        foreach ($context_id_pairs as $pair) {
            $id_key = $pair["id_key"];
            $id = $model_info ? ($model_info->$id_key ? $model_info->$id_key : null) : null;

            $request = request(); //needed when loading controller from widget helper

            if ($id !== null) {
                $pair["id"] = $id;
            } else if ($request->getPost($id_key)) {
                $pair["id"] = $request->getPost($id_key);
            }

            if ($pair["id"] !== null) {
                return $pair;
            }
        }

        return array("context" => "project", "id" => null);
    }
    private function check_sub_tasks_statuses($status_id = 0, $parent_task_id = 0) {
        if ($status_id !== "3") {
            //parent task isn't marking as done
            return true;
        }

        $sub_tasks = $this->Tasks_model->get_details(array("parent_task_id" => $parent_task_id, "deleted" => 0))->getResult();

        foreach ($sub_tasks as $sub_task) {
            if ($sub_task->status_id !== "3") {
                //this sub task isn't done yet, show error and exit
                echo json_encode(array("success" => false, 'message' => app_lang("parent_task_completing_error_message")));
                exit();
            }
        }
    }
    function _row_comment_data($id)
    {
        $view_data['audio_comment'] = $this->Audio_comment_model->get_audio_version_task($id);
        return $this->template->view(AUDIO_CHAT."\Views/tasks/task_list", $view_data);
    }
    
}

    


/* End of file Custom_field.php */
/* Location: ./plugins/Custom_field/controllers/Custom_field.php */