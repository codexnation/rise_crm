<?php
// Import necessary classes
use App\Controllers\Security_Controller;
use App\Controllers\App_Controller;

function can_manage_has_permission($permisson_key = '',$permisson_value = ''){
    $CI = audio_chat_get_ci();
    $login_user = $CI->login_user;
    if($login_user->is_admin == true && $login_user->user_type == 'staff'){
        return true;
    }
    if($permisson_key == "" || $permisson_value == ""){
        return false;
    }
    $permissions = $login_user->permissions;
    if(get_array_value($permissions, $permisson_key) == $permisson_value){
        return true;
    }
    return false;
}
function audio_chat_get_ci($check = false)
{
    $ci = new Security_Controller(false);
    $ci->Audio_chat_model = new \Audio_chat\Models\Audio_chat_model();
    $ci->Audio_comment_model = new \Audio_chat\Models\Audio_comment_model();
    return $ci;
}
function get_audio_chat_version($project_id)
{   
    $ci = audio_chat_get_ci();
    $options = array("project_id" => $project_id);
    $list_data = $ci->Audio_chat_model->get_details($options)->getResult();
    return $list_data;
}
function timeToSeconds($time) {
    $timeParts = explode(':', $time);
    $seconds = 0;
    if (count($timeParts) === 3) {
        $seconds += $timeParts[0] * 3600; 
        $seconds += $timeParts[1] * 60;   
        $seconds += $timeParts[2];        
    } elseif (count($timeParts) === 2) {
        $seconds += $timeParts[0] * 60;   
        $seconds += $timeParts[1];        
    } elseif (count($timeParts) === 1) {
        $seconds += $timeParts[0];        
    }
    return $seconds;
}
function comments_task_order_by_filter($key=''){
    $order_by = array(
        "timeline" => app_lang("timeline"),
        "newestFirst" => app_lang("newestFirst"),
        "oldestFirst" => app_lang('oldestFirst'),
    );
    if($key){
        foreach ($order_by as $k=>$v) {
            if ($k == $key) {
                $order_by = $v;
                break;
            }
        }
    }
    
    return $order_by;
}
function audio_version_status($id=''){
    $status =[
         [
            'id'             => 1,
            'name'           => app_lang("no_status")
        ],
        [
            'id'             => 2,
            'name'           => app_lang("waiting_review")
        ],
        [
            'id'             => 3,
            'name'           => app_lang('revision_requested')
        ],
        [
            'id'             => 4,
            'name'           => app_lang('approved')
        ],
    ];
    if($id){
        foreach ($status as $s) {
            if ($s['id'] == $id) {
                $status = $s;
                break;
            }
        }
    }
    return $status;
}
function convertToHMS($time) {
    if (preg_match("/^\d{2}:\d{2}$/", $time)) {
        $time = '00:' . $time;
    }
    return date("H:i:s", strtotime($time));
}
function secondsToHHMMSSMMM($seconds) {
    $hours = floor($seconds / 3600);
    $seconds %= 3600;
    $minutes = floor($seconds / 60);
    $seconds %= 60;
    $sec = floor($seconds);
    $milliseconds = floor(($seconds - $sec) * 1000);
    return sprintf("%02d:%02d:%02d:%03d", $hours, $minutes, $sec, $milliseconds);
}
function audio_setPlaybackRate($key=''){
    $speedback = array(
        "0.25" => "0.25",
        "0.50" => "0.50",
        "0.75" => "0.75",
        "1.0" => app_lang("normal"),
        "1.25" => "1.25",
        "1.50" => "1.50",
        "1.75" => "1.75",
        "2.0" => "2.0",
    );
    if($key){
        foreach ($speedback as $k=>$v) {
            if ($k == $key) {
                $speedback = $v;
                break;
            }
        }
    }
    
    return $speedback;
}



