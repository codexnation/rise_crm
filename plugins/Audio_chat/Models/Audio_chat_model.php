<?php
namespace Audio_chat\Models;
class Audio_chat_model extends \App\Models\Crud_model {
    protected $table = null;
    protected $com_like_unlike_tbl = null;
    protected $comment_tbl = null;
    protected $task_tbl = null;
    function __construct() {
        $this->table = 'projects_audio_version';
        parent::__construct($this->table);
        $this->com_like_unlike_tbl = $this->db->prefixTable('projects_audio_comment_like_unlike');
        $this->comment_tbl = $this->db->prefixTable('projects_audio_comment');
        $this->task_tbl = $this->db->prefixTable('tasks');
    }
    function get_details($options = array()){
        $audio_chat = $this->db->prefixTable('projects_audio_version');
        $project_id = get_array_value($options, "project_id");
        $id = get_array_value($options, "id");
        $where = "WHERE 1 ";
        if($project_id !=''){
            $where .= " AND ".$audio_chat.".project_id = ".$project_id;
        }
        if($id !=''){
            $where .= " AND ".$audio_chat.".id = ".$id;
        }
        $sql = "SELECT $audio_chat.*
        FROM $audio_chat
        $where
        ORDER BY $audio_chat.id ASC";
        return  $this->db->query($sql);
    }
    function delete_audio_chat($id,$task_delete){
        if(is_numeric($id)){
            $audio_chat = $this->get_details(array("id"=>$id))->getRow();
                delete_app_files("plugins/".AUDIO_CHAT."/files/audio/".$audio_chat->project_id."/", $audio_chat->audio_file);
            $this->db->table($this->table)->delete(array('id'=>$id));
            if($this->db->affectedRows()){
                $this->db->table($this->comment_tbl)->delete(array('audio_version'=>$id));
                if($task_delete=='1'){
                    $this->db->table($this->task_tbl)->delete(array('audio_v_id'=>$id));
                }
                $this->db->table($this->com_like_unlike_tbl)->delete(array('audio_version'=>$id));
                return true;
            }else{
                return false;
            }
        }
    }
    // function get_max_version($project_id)
    // {
    //     $audio_chat = $this->db->prefixTable('projects_audio_version');
    //     $where = "WHERE 1 ";
    //     if($project_id !=''){
    //         $where .= " AND ".$audio_chat.".project_id = ".$project_id;
    //     }
    //     $sql ="SELECT MAX(version) AS max_version
    //     FROM $audio_chat
    //     $where ";
    //     $result = $this->db->query($sql);
    //     $row = $result->getRow();
    //     return $row->max_version;

    // }
    


       
}
