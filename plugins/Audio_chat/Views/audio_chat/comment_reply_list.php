<?php $this->Audio_comment_model = new \Audio_chat\Models\Audio_comment_model(); ?>
<div class="ml35 mt15">
   <?php foreach ($audio_comment as $comm_reply) { ?>
   <div  id="reply_list_container-<?php echo $comm_reply->id?>" class="reply_total_count comment_list p15 b-b">
      <div class="clearfix mb15">
         <div class="d-flex">
            <div class="w-100">
               <div class="d-flex">
                  <div class="flex-shrink-0 me-2">
                     <span class="avatar avatar-xs">
                     <img src="<?php echo get_avatar($comm_reply->created_by_avatar); ?>" alt="..." />
                     </span>
                  </div>
                  <div class="w-100">
                     <div class="mt10"><?php echo get_team_member_profile_link($comm_reply->comment_by, $comm_reply->created_by_user, array("class" => "dark strong")); ?></div>
                  </div>
               </div>
            </div>
            <?php if ($login_user->is_admin || $comm_reply->comment_by == $login_user->id) { ?>
            <div class="flex-shrink-0">
               <span class="float-end dropdown">
                  <div class="text-off dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="true" >
                      <i data-feather="chevron-down" class="icon"></i>
                  </div>
                  <ul class="dropdown-menu" role="menu" >
                     <li role="presentation" class="text-center"><?php echo ajax_anchor(get_uri("audio_chat/comment_delete/$comm_reply->id"), app_lang('delete'), array("class" => "dropdown-item delete_comment", "title" => app_lang('delete'), "data-fade-out-on-success" => "#reply_list_container-$comm_reply->id" ,"id"=>"delete_comment")); ?> </li>
                     <li role="presentation" class="text-center"> <?php  echo ajax_anchor(get_uri("audio_chat/audio_comment_reply_form/" . $comm_reply->comment_id."/".$comm_reply->project_id.'/'.$comm_reply->id), app_lang('edit'), array("data-real-target" => "#audio-reply-form-container-" . $comm_reply->id, "class" => "dropdown-item" , "data-fade-out-on-success" => "#comment-reply-$comm_reply->id"));?></li>
                  </ul>
               </span>
            </div>
            <?php } ?>
         </div>
         <p class="mt5 " id="audio_comment_reply-<?php echo $comm_reply->id;?>" ><span id="comment-reply-<?php echo $comm_reply->id; ?>"><?php echo $comm_reply->comment; ?></span></p>
         <div class="info-data">
         <div class="reply-data">
            <?php
            echo ajax_anchor(get_uri("audio_chat/audio_comment_reply_form/" . $comm_reply->comment_id."/".$comm_reply->project_id), "<i data-feather='corner-up-left' class='icon-16'></i> " . app_lang('reply'), array("data-real-target" => "#audio-reply-form-container-" . $comm_reply->id, "class" => "dark"));
            ?>
            <?php
            $like_data =  $this->Audio_comment_model->commentTask_likeUnlike(array('rel_id'=>$comm_reply->id,'type'=>'comment','staff_id'=>$login_user->id));
               $likeData = $like_data['likeData'];
            if(!empty($likeData)){
               $like_id =$likeData->like_id;
               $is_like =$likeData->is_like;
            }else{
               $like_id = '';
               $is_like = 0;
            } 
            $heartred_class = $is_like =='1' ? 'icon-fill-comment_task' : '';?>
            <a href="#" onclick="comment_task_like_unlike(this); return false" class="ml5" data-like-id="<?php echo $like_id; ?>" data-version-id="<?php echo $comm_reply->audio_version; ?>" data-rel-id="<?php echo $comm_reply->id; ?>" data-project-id="<?php echo $comm_reply->project_id; ?>" data-is-like="<?php echo $is_like; ?>" data-type = "comment"><span><i data-feather="heart" class="icon-16 <?php echo $heartred_class; ?>"></i> <?php echo ($like_data['totalLikes'] >= 1) ? $like_data['totalLikes'] : ''; ?></span></a>
            </div>
         <small><span class="text-off float-end"><?php echo format_to_relative_time($comm_reply->created_at); ?></span></small>
      </div>


      </div>
   <div id="audio-reply-form-container-<?php echo $comm_reply->id; ?>"></div>
   </div>
   <?php } ?>
</div>
<script>
   $(document).ready(function(){
      $(".delete_comment").click(function(){
           var totalCount = $("#comment_reply-list-<?php echo $comm_reply->comment_id; ?> .reply_total_count").length;
           if(totalCount > 1){
               $(".reply_total<?php echo $comm_reply->comment_id; ?>").text(totalCount-1); 
           }else{
               $("#view_replies-<?php echo $comm_reply->comment_id; ?>").html("");
           }
       });
   });
   
</script>