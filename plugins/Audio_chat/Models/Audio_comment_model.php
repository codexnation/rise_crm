<?php
namespace Audio_chat\Models;
class Audio_comment_model extends \App\Models\Crud_model {
    protected $table = null;
    protected $projects_audio_comment_like_unlike = null;
    function __construct() {
        $this->table = 'projects_audio_comment';
        $this->pro_audio_com_like_unlike_tbl = 'projects_audio_comment_like_unlike';
        parent::__construct($this->table);
    }
    function get_details($options = array()){
        $audio_comment = $this->db->prefixTable('projects_audio_comment');
        $users_table = $this->db->prefixTable('users');
        $id = get_array_value($options, "id");
        $project_id = get_array_value($options, "project_id");
        $audio_version = get_array_value($options, "audio_version");
        $comment_id = get_array_value($options, "comment_id");
        $where = "WHERE 1 ";
        if($id !=''){
            $where .= " AND ".$audio_comment.".id = ".$id;
        }
        if($project_id !=''){
            $where .= " AND ".$audio_comment.".project_id = ".$project_id;
        }
        if($audio_version !=''){
            $where .= " AND ".$audio_comment.".audio_version = ".$audio_version;
        }
        if($comment_id !=''){
            $where .= " AND ".$audio_comment.".comment_id = ".$comment_id;
        }
        $sql = "SELECT $audio_comment.*,CONCAT($users_table.first_name, ' ',$users_table.last_name) AS created_by_user, $users_table.image as created_by_avatar,$audio_comment.id AS parent_post_id,
        (SELECT COUNT($audio_comment.id) as total_replies FROM $audio_comment WHERE $audio_comment.comment_id=parent_post_id AND $audio_comment.deleted=0) AS total_replies
        FROM $audio_comment
        LEFT JOIN $users_table ON $users_table.id= $audio_comment.comment_by
        $where";
        return  $this->db->query($sql);
    }
    function get_audio_version_details($options = array()) {
        $audio_comment = $this->db->prefixTable('projects_audio_comment');
        $tasks = $this->db->prefixTable('tasks');
        $users_table = $this->db->prefixTable('users');

        $project_id = get_array_value($options, "project_id");
        $audio_version = get_array_value($options, "audio_version");
        $order_by = get_array_value($options, "order_by");

        $where_audio_comment = "WHERE 1";
        $where_tasks = "WHERE 1";

        if (!empty($project_id)) {
            $where_audio_comment .= " AND ".$audio_comment.".project_id = ".$project_id;
            $where_tasks .= " AND ".$tasks.".project_id = ".$project_id;
        }
        if (!empty($audio_version)) {
            $where_audio_comment .= " AND $audio_comment.audio_version = ".$audio_version;
            $where_tasks .= " AND $tasks.audio_v_id = ".$audio_version;
        }
        if (!empty($order_by)) {
                if ($order_by=='timeline') {
                    $orderBy ='audio_time ASC';
                }elseif($order_by=='oldestFirst'){
                    $orderBy ='created_at ASC';
                }else{
                    $orderBy ='created_at DESC';
                }
        }else{
            $orderBy ='created_at DESC';
        }
        $where_audio_comment .= " AND $audio_comment.deleted = 0";
            $where_tasks .= " AND $tasks.deleted = 0";
        $sql_audio_comment = "SELECT 
                $audio_comment.id,
                $audio_comment.project_id,
                $audio_comment.comment_id,
                $audio_comment.audio_version,
                CONVERT($audio_comment.audio_time USING utf8mb4) COLLATE utf8mb4_general_ci AS audio_time,
                CONVERT($audio_comment.audio_time_end USING utf8mb4) COLLATE utf8mb4_general_ci AS audio_time_end,
                CONVERT($audio_comment.audio_seconds USING utf8mb4) COLLATE utf8mb4_general_ci AS audio_seconds,
                CONVERT($audio_comment.comment USING utf8mb4) COLLATE utf8mb4_general_ci AS comment,
                $audio_comment.comment_by,
                $audio_comment.created_at,
                $audio_comment.deleted,
                CONVERT(CONCAT($users_table.first_name, ' ', $users_table.last_name) USING utf8mb4) COLLATE utf8mb4_general_ci AS created_by_user,
                CONVERT($users_table.image USING utf8mb4) COLLATE utf8mb4_general_ci AS created_by_avatar,
                $audio_comment.id AS parent_post_id,
                (SELECT COUNT(ac.id) FROM $audio_comment ac WHERE ac.comment_id = $audio_comment.id AND ac.deleted = 0) AS total_replies,
                CONVERT('comment' USING utf8mb4) COLLATE utf8mb4_general_ci AS comment_type
            FROM 
                $audio_comment
            LEFT JOIN 
                $users_table ON $users_table.id = $audio_comment.comment_by
            $where_audio_comment";
        $sql_tasks = "SELECT 
                $tasks.id,
                $tasks.project_id,
                0 AS comment_id,
                $tasks.audio_v_id AS audio_version,
                CONVERT($tasks.audio_time USING utf8mb4) COLLATE utf8mb4_general_ci AS audio_time,
                CONVERT($tasks.audio_time_end USING utf8mb4) COLLATE utf8mb4_general_ci AS audio_time_end,
                CONVERT($tasks.audio_seconds USING utf8mb4) COLLATE utf8mb4_general_ci AS audio_seconds,
                CONVERT($tasks.title USING utf8mb4) COLLATE utf8mb4_general_ci AS comment,
                $tasks.audio_task_by AS comment_by,
                $tasks.audio_task_created_at AS created_at,
                $tasks.deleted,
                CONVERT(CONCAT($users_table.first_name, ' ', $users_table.last_name) USING utf8mb4) COLLATE utf8mb4_general_ci AS created_by_user,
                CONVERT($users_table.image USING utf8mb4) COLLATE utf8mb4_general_ci AS created_by_avatar,
                NULL AS parent_post_id,
                0 AS total_replies,
                CONVERT('task' USING utf8mb4) COLLATE utf8mb4_general_ci AS comment_type
            FROM 
                $tasks
            LEFT JOIN 
                $users_table ON $users_table.id = $tasks.audio_task_by
            $where_tasks";

        // $sql = "($sql_audio_comment) UNION ALL ($sql_tasks) ORDER BY created_at DESC";
        $sql = "($sql_audio_comment) UNION ALL ($sql_tasks) ORDER BY $orderBy";
        $query = $this->db->query($sql);
        return $query->getResult();
    }
    function get_audio_version_task($id){
        $tasks = $this->db->prefixTable('tasks');
        $users_table = $this->db->prefixTable('users');

        $where = "WHERE 1 ";
        $params = [];

        if($id !=''){
            $where .= " AND ".$tasks.".id = ".$id;
        }
        $sql = "SELECT $tasks.id,$tasks.project_id,$tasks.audio_v_id AS audio_version,$tasks.audio_time,$tasks.audio_time_end,$tasks.audio_seconds,$tasks.title AS comment,$tasks.audio_task_created_at AS created_at,$tasks.deleted,NULL AS parent_post_id, 0 AS total_replies,$tasks.audio_task_by AS comment_by,CONCAT($users_table.first_name, ' ', $users_table.last_name) AS created_by_user,$users_table.image AS created_by_avatar
            FROM $tasks
            LEFT JOIN $users_table ON $users_table.id = $tasks.audio_task_by 
            $where";
            return $this->db->query($sql)->getRow();
    }

    function delete_audio_comment($id){
        if(is_numeric($id)){
            $options = array("id" => $id);
            $audio_comment_reply = $this->get_details($options)->getResult();

            $this->db->table($this->table)->delete(array('id'=>$id));
            if($this->db->affectedRows()){
                if(!empty($audio_comment_reply)){
                    $this->db->table($this->table)->delete(array('comment_id'=>$id));
                }
                return true;
            }else{
                return false;
            }
        }
    }
    function commentTask_likeUnlike($options) {
        $comment_like_unlike = $this->db->prefixTable('projects_audio_comment_like_unlike');
        $id = get_array_value($options, "id");
        $project_id = get_array_value($options, "project_id");
        $staff_id = get_array_value($options, "staff_id");
        $rel_id = get_array_value($options, "rel_id");
        $type = get_array_value($options, "type");
        $where = "WHERE 1 ";
        if ($id != '') {
            $where .= " AND " . $comment_like_unlike . ".id = " . $id;
        }
        if ($staff_id != '') {
            $where .= " AND " . $comment_like_unlike . ".staff_id = " . $staff_id;
        }
        if ($type != '') {
            $where .= " AND " . $comment_like_unlike . ".type = '" . $type."'";
        }
        if ($rel_id != '') {
            $where .= " AND " . $comment_like_unlike . ".rel_id = " . $rel_id;
        }

        $sql = "SELECT is_like, id as like_id FROM $comment_like_unlike $where";
        $result = $this->db->query($sql);
        $like_data= $result->getRow();

        $likeCountSql = "SELECT COUNT(*) as total_likes FROM $comment_like_unlike WHERE rel_id = $rel_id AND is_like = 1";
        $likeCountResult = $this->db->query($likeCountSql);
        $totalLikes = $likeCountResult->getRow()->total_likes;
        return [
            'likeData' => $like_data,
            'totalLikes' => $totalLikes,
        ];
    }
    function processRecord($param,$staff_id)
    {   
        $insData = array(
            'project_id'=>$param['project_id'],
            'audio_version'=>$param['version_id'],
            'rel_id'=>$param['rel_id'],
            'type'=>$param['type'],
            'staff_id'=>$staff_id,
            'is_like'=>$param['is_like']==0?1:0,
        );
        if($param['like_id'] !=''){   
            $this->db->table($this->pro_audio_com_like_unlike_tbl)->update($insData,array('id'=>$param['like_id']));
            $id = $param['like_id'];
        }else{
            $this->db->table($this->pro_audio_com_like_unlike_tbl)->insert($insData);
            $id = $this->db->insertID();
        }
         return array('id'=>$id,'rel_id'=>$param['rel_id']);
    }

       
}
