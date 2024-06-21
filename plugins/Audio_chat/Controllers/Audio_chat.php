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
use PhpOffice\PhpSpreadsheet\Spreadsheet;
use PhpOffice\PhpSpreadsheet\Writer\Xlsx;

class Audio_chat extends \App\Controllers\Security_Controller {
    protected $Audio_chat_model;
    protected $staff_id;
    function __construct() {
        parent::__construct();
        require_once(APPPATH . "ThirdParty/PHPOffice-PhpSpreadsheet/vendor/autoload.php");
        $this->staff_id = $this->login_user->id;
        $this->Audio_chat_model = new \Audio_chat\Models\Audio_chat_model();
        $this->Audio_comment_model = new \Audio_chat\Models\Audio_comment_model();
    }
    function index() {
        if(!can_manage_has_permission('audio_chat_permission','yes') || can_manage_has_permission('delete_audio_project_per','yes')) {
            app_redirect("forbidden");
        }
    }
    function version_waveform($project_id)
    {  
        validate_numeric_value($project_id);
        $view_data = [];
        $view_data['project_id'] = $project_id;
        $id = $this->request->getPost('id');
        $option = array("project_id" => $project_id,"id"=>$id);
        $view_data['audio_chat'] = $this->Audio_chat_model->get_details($option)->getRow();
        if (empty($view_data['audio_chat'])) {
            return $this->template->view(AUDIO_CHAT."\Views\audio_chat\index",$view_data);
        }else{
            $id = isset($id)?$id:$view_data['audio_chat']->id;
            $options = array("project_id"=>$project_id,"audio_version"=>$id);
            $view_data['audio_version'] = $this->Audio_comment_model->get_audio_version_details($options);
            if($this->request->getPost('id')){
                echo json_encode(array("success" => false, 'data' => $this->template->view(AUDIO_CHAT."\Views\audio_chat\waveform",$view_data)));
                exit(); 
            }else{
                return $this->template->view(AUDIO_CHAT."\Views\audio_chat\waveform",$view_data);
            }
        }
    }
    function modal_form($project_id)
    {  
        $id = $this->request->getPost("id");
        $model_info = $this->Audio_chat_model->get_one($id);
        $view_data['model_info'] = $model_info;
        $view_data['project_id'] = $project_id;
        return $this->template->view(AUDIO_CHAT."\Views\audio_chat\modal_form",$view_data);
    }
    function save()
    {    
        $id = $this->request->getPost('id');
        $project_id = $this->request->getPost('project_id');
        if($this->request->getPost('version')){
            $version = $this->request->getPost('version');
        }else{
            // $max_version = $this->Audio_chat_model->get_max_version($project_id);
            $version = app_lang('default');
        }
        $time = date('Y-m-d H:i:s');
        $data = array(
            "version" => $version,
            "project_id" => $project_id,
            "status" => $this->request->getPost('status'),
            "updated" => $time,
        );
        $audio_file_info = $this->Audio_chat_model->get_one($id);
        $files_data = move_files_from_temp_dir_to_permanent_dir(FCPATH."plugins/".AUDIO_CHAT."/files/audio/".$project_id."/", "audio_chat");
        $unserialize_files_data = unserialize($files_data);
        $audio_chat = get_array_value($unserialize_files_data, 0);
        if ($audio_chat) {
            if ($id && $audio_file_info->audio_file) {
                delete_app_files(FCPATH."plugins/".AUDIO_CHAT."/files/audio/".$project_id."/", array($audio_file_info->audio_file));
            }
            $data["audio_file"] = $audio_chat['file_name'];
        } 
        if (empty($id)) {
            $data['created'] = $time;
            $data['created_by'] = $this->staff_id;
        }
        $data = clean_data($data);
        $save_id = $this->Audio_chat_model->ci_save($data, $id);
        if ($save_id) {
            echo json_encode(array("success" => true, "data" => $this->_row_data($save_id), 'id' => $save_id, 'message' => app_lang('record_saved')));
        } else {
            echo json_encode(array("success" => false, 'message' => app_lang('error_occurred')));
        }
    }
   
    private function _row_data($id) {
        $options = array("id" => $id);
        $data = $this->Audio_chat_model->get_details($options)->getRow();
        return $data;
    }
    function delete() {
        $this->validate_submitted_data(array(
            "id" => "numeric|required"
        ));
        $id = $this->request->getPost('id');
        $task_delete = $this->request->getPost('task_delete');
        $resp = $this->Audio_chat_model->delete_audio_chat($id,$task_delete);
        if ($resp) {
            echo json_encode(array("success" => true, 'message' => app_lang('record_deleted')));
            
        } else {
            echo json_encode(array("danger" => false, 'message' => app_lang('record_cannot_be_deleted')));
        }

    } 
    function upload_file($project_id) {
        if ($_FILES) {
            $file = $this->request->getFile('file');
            $newName = $file->getRandomName();
            $file->move(FCPATH."plugins/".AUDIO_CHAT."/files/audio/".$project_id."/", $newName); 
            $data = array(
                "version" =>app_lang('default'),
                "project_id" => $project_id,
                "audio_file" =>$newName,             
                "updated" => date('Y-m-d H:i:s'),
                "created" => date('Y-m-d H:i:s'),
                "created_by" => $this->staff_id,
            ); 
            $save_id = $this->Audio_chat_model->ci_save($data, $id='');
        }else{
            echo json_encode(array("success" => false, 'message' => app_lang('failed_upload_audio_file')));
            exit();   
        }
    }
    function validate_audio_file() {
        $file_name = $this->request->getPost("file_name");
        $viewable_extansions = array(
            "mp4",
            "wav",
            "mp3",
        );
        $file_extension = strtolower(pathinfo($file_name, PATHINFO_EXTENSION));
        if (in_array($file_extension, $viewable_extansions)) {
            echo json_encode(array("success" => true));
        } 
        else {
            echo json_encode(array("success" => false, 'message' => app_lang('please_upload_a_valid_audio_file')));
        }
        
    }
    function upload_file_temp() {
        $file = get_array_value($_FILES, "file");
        if (!$file) {
            die("Invalid file");
        }
        $temp_file = get_array_value($file, "tmp_name");
        $file_name = get_array_value($file, "name");
        $file_size = get_array_value($file, "size");
        $temp_file_path = get_setting("temp_file_path");
        $target_path = getcwd() . '/' . $temp_file_path;
        if (!is_dir($target_path)) {
            if (!mkdir($target_path, 0755, true)) {
                die('Failed to create file folders.');
            }
        }
        $target_file = $target_path . $file_name;
        copy($temp_file, $target_file);
    }
    function comment_save()
    {
        if($this->request->getPost()){
            $this->validate_submitted_data(array(
                "comment" => "required",
            ));
            if ($this->request->getPost('audio_time')) {
                $timeParts = explode('-', $this->request->getPost('audio_time'));
                if (count($timeParts) === 2) {
                    $audio_time = $timeParts[0];
                    $audio_time_end = $timeParts[1];
                }else{
                   $audio_time = $timeParts[0]; 
                   $audio_time_end =null;
                }
            }else{
                $audio_time = ''; 
                $audio_time_end =null;
            }
            $id = $this->request->getPost('id');
            $data = array(
                "project_id" => $this->request->getPost('project_id'),
                "comment_id" => $this->request->getPost('comment_id')?$this->request->getPost('comment_id'):0,
                "audio_version" => $this->request->getPost('audio_version'),
                "audio_seconds" => $this->request->getPost('audio_seconds'),
                "audio_time" => $audio_time,
                "comment" => $this->request->getPost('comment'),
                "comment_by" => $this->staff_id,
                "created_at" =>  date('Y-m-d H:i:s'),
                "audio_time_end" =>  $audio_time_end,
            );
            $data = clean_data($data);
            $save_id = $this->Audio_comment_model->ci_save($data, $id);
            if ($save_id) {
                if($this->request->getPost('comment_id') && $id==''){
                     echo json_encode(array("success"=>true,"data"=>$this->view_comment_reply($save_id)));
                }elseif ($this->request->getPost('id')) {
                    echo json_encode(array("success" => true, "data" => $this->request->getPost('comment')));
                }
                else{
                    $save_data = $this->Audio_comment_model->get_details(array("id" => $save_id))->getRow();
                    $profile = get_avatar($save_data->created_by_avatar);
                    echo json_encode(array("success" => true, "data" => $this->_row_comment_data($save_id),"comment_datail"=>$save_data,"profile"=>$profile));
                }
            } else {
                echo json_encode(array("success" => false, 'message' => app_lang('error_occurred')));
            }
        }
    }
    function _row_comment_data($id)
    {
        $options = array("id" => $id);
        $view_data['audio_comment'] = $this->Audio_comment_model->get_details($options)->getRow();
        return $this->template->view(AUDIO_CHAT."\Views\audio_chat/comment_list", $view_data);
    }
    function view_comment_reply($id)
    {
        $options = array("id" => $id);
        $view_data['audio_comment'] = $this->Audio_comment_model->get_details($options)->getResult();
        return $this->template->view(AUDIO_CHAT."\Views\audio_chat/comment_reply_list", $view_data);
    }
    function view_comment_replies($id)
    {
        $options = array("comment_id" => $id);
        $view_data['audio_comment'] = $this->Audio_comment_model->get_details($options)->getResult();
        return $this->template->view(AUDIO_CHAT."\Views\audio_chat/comment_reply_list", $view_data);
    }
    function audio_comment_reply_form($comment_id,$project_id,$id='') {
        if($id!=''){
            $view_data['audio_comment_reply'] = $this->Audio_comment_model->get_details(array("id"=>$id))->getRow();
        }else{
            $option = array("project_id" => $project_id,"id"=>$comment_id);
            $view_data['audio_comment'] = $this->Audio_comment_model->get_details($option)->getRow();
        }
        return $this->template->view(AUDIO_CHAT."\Views\audio_chat/reply_form", $view_data);
    } 
    function comment_delete($id)
    {   
        $resp = $this->Audio_comment_model->delete_audio_comment($id);
        if ($resp) {
            echo json_encode(array("success" => true, 'message' => app_lang('record_deleted')));
            
        } else {
            echo json_encode(array("danger" => false, 'message' => app_lang('record_cannot_be_deleted')));
        }
    }
    function add_remove_like_unlike($id){  
        $post = $this->request->getPost();
        $save = $this->Audio_comment_model->processRecord($post,$this->staff_id);
        if (is_array($save)) {
            $data = $this->Audio_comment_model->commentTask_likeUnlike($save);
            $likeData = $data['likeData'];
            echo json_encode(array("success" => true, "likeData"=>$likeData ,"totalLikes"=>$data['totalLikes'] ,"message" => app_lang('record_saved')));
        } else {
            echo json_encode(array("success" => false, app_lang('error_occurred')));
        }
    }
    function change_comment_task_order_by($id){
        $project_id = $this->request->getPost('project_id');
        $order_by = $this->request->getPost('order_by');
        $options = array("audio_version"=>$id,"project_id" => $project_id,'order_by'=>$order_by);
        $audio_comment_task = $this->Audio_comment_model->get_audio_version_details($options);
        $html ='';
        foreach ($audio_comment_task as $key => $aud_v_detail) { 
           if ($aud_v_detail->comment_type =='comment') {
               if ($aud_v_detail->comment_id == 0) {
                    $view_data['audio_comment'] = $aud_v_detail;
                    $view_data['login_user'] = $this->login_user;
                    $html .=  view(AUDIO_CHAT."\Views\audio_chat/comment_list", $view_data);
               }  
            }else{
                $view_data['audio_comment'] = $aud_v_detail;
                $view_data['login_user'] = $this->login_user;
                $html .=  view(AUDIO_CHAT."\Views/tasks/task_list", $view_data);
            }
       }
         echo json_encode(array("success" => true, "data"=>$html ,"order_by"=>comments_task_order_by_filter($order_by),"message" => app_lang('record_saved')));
        
    }
    function change_version_status($id)
    {
        $status_id = $this->request->getPost('status_id');
        $data = [];
        $data['status'] = $this->request->getPost('status_id'); 
        $data = clean_data($data);
        $save_id = $this->Audio_chat_model->ci_save($data, $id);
        if ($save_id) {
            echo json_encode(array("success" => true, "data" => audio_version_status($status_id), 'id' => $save_id, 'message' => app_lang('record_saved')));
        } else {
            echo json_encode(array("success" => false, 'message' => app_lang('error_occurred')));
        }
    } 
    function download_csv_comment_task($id){
        $audio_chat = $this->Audio_chat_model->get_one($id);
        $audio_chat_details = $this->Audio_comment_model->get_audio_version_details(array("audio_version"=>$id, 'order_by'=>'oldestFirst'));
        $project = $this->Projects_model->get_one($audio_chat->project_id);
        $file_name = $audio_chat->version . '.csv'; 
        header("Content-Description: File Transfer"); 
        header("Content-Disposition: attachment; filename=$file_name"); 
        header("Content-Type: application/csv; charset=UTF-8");
        $file = fopen('php://output', 'w');
        $header = array(app_lang('project'),app_lang('file'),app_lang('fileurl'),app_lang('version'),app_lang('commenter'),app_lang('commentId'),app_lang('comments'),app_lang('is_reply'),app_lang('commented_at'),app_lang('duration'),app_lang('timecode'),app_lang('timecode_in'),app_lang('timecode_out'),app_lang('time_in'),app_lang('time_out'),app_lang('type'));
        fputcsv($file, $header);
        foreach ($audio_chat_details as $detail) {
            $is_reply = ($detail->comment_id==0)?'false':'true';
            if($detail->audio_time_end==null){
                $row = array(
                    $project->title,
                    $audio_chat->audio_file,
                    base_url("/plugins/".AUDIO_CHAT."/files/audio/".$audio_chat->project_id),
                    $audio_chat->version,
                    $detail->created_by_user,
                    $detail->id,
                    $detail->comment,
                    $is_reply,
                    $detail->created_at,
                    '00:00:00:000',
                    '00:00:00:000',
                    '00:00:00:000',
                    '00:00:00:000',
                    '00:00:00:00',
                    '00:00:00:00',
                    $detail->comment_type
                );
            }else{
                $start_time = timeToSeconds($detail->audio_time);
                $start_time_end = timeToSeconds($detail->audio_time_end);
                $secondParts = explode('-', $detail->audio_seconds);
                $duration = $secondParts[1]-$secondParts[0];
                $row = array(
                    $project->title,
                    $audio_chat->audio_file,
                    base_url("/plugins/".AUDIO_CHAT."/files/audio/".$audio_chat->project_id),
                    $audio_chat->version,
                    $detail->created_by_user,
                    $detail->id,
                    $detail->comment,
                    $is_reply,
                    $detail->created_at,
                    secondsToHHMMSSMMM($duration),
                    secondsToHHMMSSMMM($secondParts[0]),
                    secondsToHHMMSSMMM($secondParts[0]),
                    secondsToHHMMSSMMM($secondParts[1]),
                    convertToHMS($detail->audio_time),
                    convertToHMS($detail->audio_time_end),
                    $detail->comment_type
                );
        }
            fputcsv($file, $row);
        }
        fclose($file); 
        exit; 
    }   
    function comment_export_as_excle($id)
    {
        $audio_chat = $this->Audio_chat_model->get_one($id);
        $audio_chat_details = $this->Audio_comment_model->get_audio_version_details(array("audio_version"=>$id, 'order_by'=>'oldestFirst'));
        $project = $this->Projects_model->get_one($audio_chat->project_id);
        $spreadsheet = new Spreadsheet();
        $spreadsheet->getProperties()->setCreator('Name')
            ->setTitle($audio_chat->version.'Excel Export')
            ->setSubject('Excel Export')
            ->setDescription('document for exporting data to Excel.');
        $headers = array(
            app_lang('project'), 
            app_lang('file'), 
            app_lang('fileurl'), 
            app_lang('version'), 
            app_lang('commenter'), 
            app_lang('commentId'), 
            app_lang('comments'), 
            app_lang('is_reply'), 
            app_lang('commented_at'), 
            app_lang('duration'), 
            app_lang('timecode'), 
            app_lang('timecode_in'), 
            app_lang('timecode_out'), 
            app_lang('time_in'), 
            app_lang('time_out'), 
            app_lang('type')
        );
        $sheet = $spreadsheet->getActiveSheet();
    $columnIndex = 'A';
    foreach ($headers as $header) {
        $sheet->setCellValue($columnIndex . '1', $header);
        $sheet->getStyle($columnIndex . '1')->getFont()->setBold(true); 
        if ($header == app_lang('file')) {
            $sheet->getColumnDimension($columnIndex)->setWidth(30); 
        }
        if ($header == app_lang('fileurl')) {
            $sheet->getColumnDimension($columnIndex)->setWidth(50); 
        }
        $columnIndex++;
    }
    $rowIndex = 2; 
    foreach ($audio_chat_details as $detail) {
        $is_reply = ($detail->comment_id == 0) ? 'false' : 'true';

        if ($detail->audio_time_end == null) {
            $row = array(
                $project->title,
                $audio_chat->audio_file,
                base_url("/plugins/" . AUDIO_CHAT . "/files/audio/" . $audio_chat->project_id),
                $audio_chat->version,
                $detail->created_by_user,
                $detail->id,
                $detail->comment,
                $is_reply,
                $detail->created_at,
                '00:00:00:000',
                '00:00:00:000',
                '00:00:00:000',
                '00:00:00:000',
                '00:00:00:00',
                '00:00:00:00',
                $detail->comment_type
            );
        } else {
            $start_time = timeToSeconds($detail->audio_time);
            $start_time_end = timeToSeconds($detail->audio_time_end);
            $secondParts = explode('-', $detail->audio_seconds);
            $duration = $secondParts[1] - $secondParts[0];
            $row = array(
                $project->title,
                $audio_chat->audio_file,
                base_url("/plugins/" . AUDIO_CHAT . "/files/audio/" . $audio_chat->project_id),
                $audio_chat->version,
                $detail->created_by_user,
                $detail->id,
                $detail->comment,
                $is_reply,
                $detail->created_at,
                secondsToHHMMSSMMM($duration),
                secondsToHHMMSSMMM($secondParts[0]),
                secondsToHHMMSSMMM($secondParts[0]),
                secondsToHHMMSSMMM($secondParts[1]),
                convertToHMS($detail->audio_time),
                convertToHMS($detail->audio_time_end),
                $detail->comment_type
            );
        }
        $columnIndex = 'A';
        foreach ($row as $cell) {
            $sheet->setCellValue($columnIndex . $rowIndex, $cell);
            $columnIndex++;
        }
        $rowIndex++;
    }

        $writer = new Xlsx($spreadsheet);
        $filename = $audio_chat->version.'.xlsx';
        header('Content-Type: application/vnd.openxmlformats-officedocument.spreadsheetml.sheet');
        header('Content-Disposition: attachment;filename="' . $filename . '"');
        header('Cache-Control: max-age=0');
        $writer->save('php://output');
       
    }
}

    
/* End of file Custom_field.php */
/* Location: ./plugins/Custom_field/controllers/Custom_field.php */

