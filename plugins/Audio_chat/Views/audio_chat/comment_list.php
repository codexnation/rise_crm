<?php   $this->Audio_comment_model = new \Audio_chat\Models\Audio_comment_model();
   $options = array("comment_id" => $audio_comment->id);
   $view_data['audio_comment'] = $this->Audio_comment_model->get_details($options)->getResult();
   $border_botton = (empty($view_data['audio_comment']))?'b-b':'';
?>
<div id="comment_list_container-<?php echo $audio_comment->id; ?>" class="comment_list p15 <?php echo $border_botton;?>">
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
                  <li role="presentation" class="text-center"><?php echo js_anchor(app_lang('delete'), array("class" => " delete dropdown-item", "data-id" => $audio_comment->id, "data-action-url" => get_uri("audio_chat/comment_delete/$audio_comment->id"),"data-fade-out-on-success" => "#comment_list_container-$audio_comment->id", "data-action" => "delete-confirmation" ,"data-reload-on-success" => true));?></li>
                  <li role="presentation" class="text-center"> <?php  echo ajax_anchor(get_uri("audio_chat/audio_comment_reply_form/" . $audio_comment->comment_id."/".$audio_comment->project_id.'/'.$audio_comment->id), app_lang('edit'), array("data-real-target" => "#audio-reply-form-container-" . $audio_comment->id, "class" => "dropdown-item" , "data-fade-out-on-success" => "#comment-$audio_comment->id"));?></li>
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
      <div class="play-data mt10">
         <a href="javascript:;" class="togglePlay" data-start-time="<?php echo timeToSeconds($audio_comment->audio_time);?>" <?php echo $audio_end_time;?> style="border: none; background: none;">
            <i data-feather='play' class='icon-16'></i>
         </a>
         <span class="ml5"><?php echo $audio_comment->audio_time .''.$line.''.$audio_comment->audio_time_end;?></span>
         <p class="mt5 " id="audio_comment-<?php echo $audio_comment->id;?>" >
            <span id="comment-<?php echo $audio_comment->id; ?>"><?php echo $audio_comment->comment; ?></span>
         </p>
      </div>
      <div class="info-data">
         <div class="reply-data">
            <?php
               echo ajax_anchor(get_uri("audio_chat/audio_comment_reply_form/" . $audio_comment->id."/".$audio_comment->project_id), "<i data-feather='corner-up-left' class='icon-16'></i> " . app_lang('reply'), array("data-real-target" => "#audio-reply-form-container-" . $audio_comment->id, "class" => "dark"));
               ?>
            <?php
            $like_data =  $this->Audio_comment_model->commentTask_likeUnlike(array('rel_id'=>$audio_comment->id,'type'=>'comment','staff_id'=>$login_user->id));
               $likeData = $like_data['likeData'];
            if(!empty($likeData)){
               $like_id =$likeData->like_id;
               $is_like =$likeData->is_like;
            }else{
               $like_id = '';
               $is_like = 0;
            } 
            $heartred_class = $is_like =='1' ? 'icon-fill-comment_task' : '';?>
            <a href="#" onclick="comment_task_like_unlike(this); return false" class="ml5" data-like-id="<?php echo $like_id; ?>" data-version-id="<?php echo $audio_comment->audio_version; ?>" data-rel-id="<?php echo $audio_comment->id; ?>" data-project-id="<?php echo $audio_comment->project_id; ?>" data-is-like="<?php echo $is_like; ?>" data-type = "comment"><span><i data-feather="heart" class="icon-16 <?php echo $heartred_class; ?>"></i> <?php echo ($like_data['totalLikes'] >= 1) ? $like_data['totalLikes'] : ''; ?></span></a>
            </div>
         <small><span class="text-off float-end"><?php echo format_to_relative_time($audio_comment->created_at); ?></span></small>
      </div>
   </div>

   <?php
      $reply_caption = app_lang("reply");  
      if (($audio_comment->total_replies > 1)) {
          $reply_caption = app_lang("replies");
      } 
      $class = "";
      if ($audio_comment->total_replies==0) {
         $class ="hide";
      }?>
      <span id="view_replies-<?php echo $audio_comment->id?>" class="<?php echo $class;?> view-replies text-primary">
     <?php  
     echo "<span class='reply_total".$audio_comment->id."'>" . $audio_comment->total_replies . "</span> " . $reply_caption . " <span id='replyUpDown'> <i data-feather='chevron-down' class='icon'></i></span>";
        ?>
   </span>
   <div id="audio-reply-form-container-<?php echo $audio_comment->id; ?>"></div>
</div>
   <div id="comment_reply-list-<?php echo $audio_comment->id; ?>">
      <?php
         
         if(!empty($view_data['audio_comment'])){
           echo view(AUDIO_CHAT."\Views\audio_chat/comment_reply_list", $view_data);
         }
         
      ?>
   </div>
<script>
   $(document).ready(function(){
      $("#comment_list_container-<?php echo $audio_comment->id; ?> .view-replies").on('click', function() {
            var id = $(this).data('id');
            var replies = $('#comment_reply-list-<?php echo $audio_comment->id; ?>');
            var chevron = $(this).find('.icon');
            if (replies.is(':visible')) {
                  replies.hide();
                  $('#replyUpDown').html("<i data-feather='chevron-down' class='icon'></i>");
            } else {
                  replies.show();
                  $('#replyUpDown').html("<i data-feather='chevron-up' class='icon'></i>");
            }
            feather.replace();
        });
   });    
</script>