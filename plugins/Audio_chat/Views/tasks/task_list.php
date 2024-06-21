<?php   $this->Audio_comment_model = new \Audio_chat\Models\Audio_comment_model();
?>
<div id="task_list_container-<?php echo $audio_comment->id; ?>" class="comment_list p15 b-b">
   <div class="clearfix mb10">
      <div class="d-flex">
         <div class="w-100">
            <div class="d-flex">
               <div class="flex-shrink-0 me-2">
                  <span class="avatar avatar-xs">
                  <img src="<?php echo get_avatar($audio_comment->created_by_avatar); ?>" alt="..." />
                  </span>
               </div>
               <div class="w-100">
                  <div class="mt5"><?php echo get_team_member_profile_link($audio_comment->comment_by, $audio_comment->created_by_user, array("class" => "dark strong")); ?></div>
               </div>
            </div>
         </div>
         <?php if ($login_user->is_admin || $audio_comment->comment_by == $login_user->id) { ?>
         <div class="flex-shrink-0">
            <span class="float-end dropdown">
               <div class="text-off dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="true" >
                  <i data-feather="chevron-down" class="icon"></i>
               </div>
               <ul class="dropdown-menu" role="menu">
                  <li role="presentation" class="text-center"><?php echo js_anchor(app_lang('delete'), array("class" => "delete dropdown-item", "data-id" => $audio_comment->id, "data-action-url" => get_uri("tasks/delete"),"data-fade-out-on-success" => "#task_list_container-$audio_comment->id", "data-action" => "delete-confirmation" ,"data-reload-on-success" => true));?></li>
                  <li role="presentation" class="text-center"> <?php echo modal_anchor(get_uri("task/tasks_modal_form/".$audio_comment->audio_version), app_lang('edit'), array("class" => "", "title" => app_lang('edit_task'),'data-post-project_id'=>$audio_comment->project_id,"data-post-id" => $audio_comment->id))?></li>
               </ul>
            </span>
         </div>
         <?php } ?>
      </div>
      <?php $line ='';
      $audio_end_time ='';
      if ($audio_comment->audio_time_end!= null) {
         $line =' - ';
         $audio_end_time = 'data-end-time="'.timeToSeconds($audio_comment->audio_time_end).'"';
      }?>
      <?php $line ='';
      $audio_end_time ='';
      if ($audio_comment->audio_time_end!= null) {
         $line =' - ';
         $audio_end_time = 'data-end-time="'.timeToSeconds($audio_comment->audio_time_end).'"';
      }?>
      <div class="play-data mt10 mb10">
         <a href="javascript:;" class="togglePlay" data-start-time="<?php echo timeToSeconds($audio_comment->audio_time);?>" <?php echo $audio_end_time;?> style="border: none; background: none;"><i data-feather='play' class='icon-16'></i></a><span class="ml5"><?php echo $audio_comment->audio_time .''.$line.''.$audio_comment->audio_time_end;?></span>
      </div>
      <?php 
      echo modal_anchor(get_uri("tasks/view"), "<span class='task_title_$audio_comment->id'>".$audio_comment->comment."</span>", array("title" => app_lang('task_info') . " #$audio_comment->id", "data-post-id" => $audio_comment->id,  "class" => '', "data-modal-lg" => "1"))
      ?>
      <div class="info-data">
         <div class="reply-data">
      <?php
      $like_data =  $this->Audio_comment_model->commentTask_likeUnlike(array('rel_id'=>$audio_comment->id,'type'=>'task','staff_id'=>$login_user->id));
         $likeData = $like_data['likeData'];
      if(!empty($likeData)){
         $like_id =$likeData->like_id;
         $is_like =$likeData->is_like;
      }else{
         $like_id = '';
         $is_like = 0;
      } 
      $heartred_class = $is_like =='1' ? 'icon-fill-comment_task' : ''; ?>
      <a href="#" onclick="comment_task_like_unlike(this); return false" class="ml5" data-like-id="<?php echo $like_id; ?>" data-version-id="<?php echo $audio_comment->audio_version; ?>" data-rel-id="<?php echo $audio_comment->id; ?>" data-project-id="<?php echo $audio_comment->project_id; ?>" data-is-like="<?php echo $is_like; ?>" data-type = "task"><span><i data-feather="heart" class="icon-16 <?php echo $heartred_class; ?>"></i> <?php echo ($like_data['totalLikes'] >= 1) ? $like_data['totalLikes'] : ''; ?></span></a>
      </div>
      <small><span class="text-off float-end"><?php echo format_to_relative_time($audio_comment->created_at); ?></span></small>
      </div>
     </p>
   </div>
   
      
</div>

