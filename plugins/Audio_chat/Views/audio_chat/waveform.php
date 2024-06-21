<?php
load_css(
    array(
        "plugins/Audio_chat/assets/css/audio_chat.css",
    )
);
// echo $_COOKIE['theme_color'];
/*if($_COOKIE['theme_color'] == "1E202D"){
    load_css(
        array(
            "plugins/Audio_chat/assets/css/audio_chat_dark.css",
        )
    );
}*/
?>
<style type="text/css">
   .close-button {
        position: absolute;
        cursor: pointer;
        font-size: 12px;
        color: 20c897;
       /*    background-color: #d23e43;*/
        width: 20px;
        height: 20px;
        line-height: 20px;
        text-align: center;
        border-radius: 50%;
        z-index: 10; 
   }
   .waveform-container {
        position: relative;
   }
   .click-marker {
        position: absolute;
        background-color: rgba(255, 0, 0, 0.5);
        padding: 2px 5px;
        border-radius: 3px;
   }
   .comment_list:hover{
        background-color: #eef1f9;
   }
   .icon-fill-comment_task {
       fill: #29689e;
   }
   .comment-border{
        border-style: solid;
   }
   .comment_list_highlight {
       background-color: #eef1f9;
   }
   .ml-17{
        margin-left: -17px;
    }
    .mr-17{
        margin-right: -17px;
    }
</style>
<div class="row new_audio_version">
   <div class="col-md-8">
      <div class="card">
         <div class="card-header">
            <div class="row">
               <div class="col-auto">
                  <span class=""><b><?php echo app_lang('audio_version'); ?></b></span>
               </div>
               <div class="col-auto">
                  <span class="dropdown ">
                     <div class="text-off dropdown-toggle " type="button" data-bs-toggle="dropdown" aria-expanded="true" >
                        <span class=""> <?php echo $audio_chat->version;?> <i data-feather="chevron-down" class="icon"></i></span>
                     </div>
                     <ul class="dropdown-menu" role="menu" id="version_dropdown">
                        <li role="presentation" class="text-center"><?php echo modal_anchor(get_uri("audio_chat/modal_form/".$project_id), "<i data-feather='plus-circle' class='icon-16'></i> " . app_lang('add_audio_chat'), array("class" => "dropdown-item", "title" => app_lang('add_audio_chat'))); ?> </li>
                        <?php $sr =1;  foreach (get_audio_chat_version($project_id) as $chat_version) { 
                           ?>
                        <li role="presentation" class="text-center"><a href="#" onclick="change_version(<?php echo $project_id.",".$chat_version->id?>); return false" class=" dropdown-item <?php echo ($chat_version->id==$audio_chat->id)?'active':''?>"> V <?php echo $sr.' ('.$chat_version->version .')';?></a></li>
                        <?php $sr++; } ?>
                     </ul>
                  </span>
               </div>
                <?php 
                if ($login_user->is_admin || $audio_chat->created_by == $login_user->id || can_manage_has_permission('edit_audio_project_per','yes')) { ?>
               <div class="col-auto ms-auto">
                  <?php $stasus_data = audio_version_status($audio_chat->status); ?>
                  <span class="dropdown ">
                     <div class="text-off dropdown-toggle " type="button" data-bs-toggle="dropdown" aria-expanded="true" >
                        <span class="" id="version_status"><?php echo $stasus_data['name']; ?></span><i data-feather="chevron-down" class="icon"></i>
                     </div>
                     <ul class="dropdown-menu" role="menu">
                        
                        <?php foreach (audio_version_status() as $status) { ?>
                        <li role="presentation" class=""><a href="#" onclick="change_version_status(<?php echo $audio_chat->id .','.$status['id']?>); return false" class="dropdown-item "> <?php echo $status['name'] ;?></a></li>
                        <?php }  ?>
                     </ul>
                  </span>
               </div>
           <?php } ?>
               <?php if ($login_user->is_admin || $audio_chat->created_by == $login_user->id || can_manage_has_permission('edit_audio_project_per','yes')) { ?>
               <div class="col-auto">
                  <span class="dropdown float-end">
                     <div class="text-off dropdown-toggle " type="button" data-bs-toggle="dropdown" aria-expanded="true" >
                        <i data-feather="more-horizontal" class="icon"></i>
                     </div>
                     <ul class="dropdown-menu" role="menu">
                        <li role="presentation" class="text-center"><?php echo  modal_anchor(get_uri("audio_chat/modal_form/".$project_id), "<i data-feather='edit' class='icon-16'></i> " .app_lang('edit') , array("class" => " edit dropdown-item", "title" => app_lang('audio_chat_edit'), "data-post-id" => $audio_chat->id) ) ?> </li>
                        <?php if($login_user->is_admin || can_manage_has_permission('delete_audio_project_per','yes')){ ?>
                        <li role = "presentation" class="text-center"> <a href="#" onclick="audio_chat_project_delete(this); return false" class="dropdown-item" data-version-id="<?php echo $audio_chat->id; ?>"><i data-feather="x" class="icon-16"></i> <?php echo app_lang("delete");?></a></li>
                        <?php } ?>
                     </ul>
                  </span>
               </div>
               <?php } ?>
            </div>
         </div>
         <div class="card-body">
            <div class="wave-data">
                <div id="waveform"></div>  
                <div class="wave-custom-data">
                    <div class="btn-data">
                        <div class="player-btn">
                            <button id="zoom-in"><i data-feather="zoom-in" class="icon-16"></i></button>
                            <button id="zoom-out" disabled><i data-feather="zoom-out" class="icon-16"></i></button> 
                            <!-- <button id="stopBtn" class="waves-effect waves-light"><i data-feather="stop-circle" class="icon-16"></i></button> -->
                            <?php echo  form_dropdown("speedSelect", audio_setPlaybackRate(), '1.0', "class='' id='speedback'");?>
                        </div>
                        <div>
                            <?php echo modal_anchor(get_uri("task/tasks_modal_form/".$audio_chat->id), "<i data-feather='plus-circle' class='icon-16'></i> " . app_lang('add_task'), array("class" => "btn btn-default","id"=>"add_task" ,"title" => app_lang('add_task'),'data-post-project_id'=>$project_id,'data-post-audio_time'=>'','data-post-audio_seconds'=>'')); ?>
                            <a href="javascript:;" class="btn btn-default" onclick="comment_form('show')"><i data-feather='plus-circle' class='icon-16'></i> <?php echo app_lang('comment');?></a>
                        </div>
                    </div>
                </div>              
            </div>
            
            <div class="mt15" id="comments_form">
               <?php echo form_open(get_uri("audio_chat/comment_save"), array("id" => "audio_comment-form", "class" => "general-form", "role" => "form")); ?>
               <input type="hidden" name="project_id" value="<?php echo $audio_chat->project_id;?>">
               <input type="hidden" name="audio_version" value="<?php echo $audio_chat->id;?>">
               <input type="hidden" name="id" value="">
               <div class="row g-0 align-items-center">
                  <div class="col-auto">
                     <input type="text" name="audio_time" value="00:00" id="audio_time" class="form-control" readonly >
                     <input type="hidden" name="audio_seconds" value="00:00" id="audio_seconds" class="form-control" >
                  </div>
                  <div class="col ml5">
                     <?php
                        echo form_input(array(
                            "id" => "comment",
                            "name" => "comment",
                            "class" => "form-control",
                            "placeholder" => app_lang('add_comment_for'),
                            "data-rule-required" => true,
                            "data-msg-required" => app_lang("field_required"),
                            "data-rich-text-editor" => true,
                        ));
                        ?>
                  </div>
                  <div class="col-auto">
                     <div class="chat-input-links ms-2">
                        <div class="links-list-item">
                           <button type="submit" class="btn btn-success"><span data-feather="check-circle" class="icon-16"></span> <i class="ri-send-plane-2-fill align-bottom"></i></button>
                           <a href="javascript:;" class="btn btn-default" onclick="comment_form('hide')">X</a>
                        </div>
                     </div>
                  </div>
               </div>
               <?php echo form_close(); ?>
            </div>
         </div>
      </div>
   </div>
   <div class="col-md-4 ml-17">
      <div class="card mr-17">
         <div class="card-header">
            <div class="row">
                <div class="col-auto">
                   <span class="dropdown">
                      <div class="text-off dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="true" >
                         <span class="ml10" id="order_by_data"> <?php echo app_lang('newestFirst');?></span><i data-feather="chevron-down" class="icon"></i>
                      </div>
                      <ul class="dropdown-menu" role="menu">
                         <?php foreach (comments_task_order_by_filter() as $key=>$value) {?>
                         <li role="presentation" class="text-center">
                            <a href="#" onclick="comment_task_order_by(this); return false" class="dropdown-item" data-version-id="<?php echo $audio_chat->id; ?>" data-project-id="<?php echo $audio_chat->project_id; ?>" data-order-by=<?php echo $key;?>><?php echo $value;?></a>
                         </li>
                         <?php }?>
                      </ul>
                   </span>
                </div>
                <div class="col-auto ms-auto">
                    <span class="dropdown float-end">
                     <div class="text-off dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="true" >
                        <i data-feather="download" class="icon"></i>
                     </div>
                     <ul class="dropdown-menu" role="menu">
                        <li role="presentation" class="text-center"><a href="<?php echo get_uri('audio_chat/download_csv_comment_task/'.$audio_chat->id); ?>" class="dropdown-item"><?php echo app_lang('download_as_csv');?></a></li>
                        <li role="presentation" class="text-center"><a href="<?php echo get_uri('audio_chat/comment_export_as_excle/'.$audio_chat->id) ?>" class="dropdown-item"><?php echo app_lang('export_as_excel');?></a></li>
                     </ul>
                  </span>
                </div>
            </div>
         </div>
         <!-- <div class="card-body" id="audio_comment_list" style="overflow:auto ;height: 450px;"> -->
         <div class="card-body" id="audio_comment_list">
            <?php 
               if(!empty($audio_version)){
                   foreach ($audio_version as $key => $aud_v_detail) { 
                       if ($aud_v_detail->comment_type =='comment') {
                           if ($aud_v_detail->comment_id == 0) {
                              $view_data['audio_comment'] = $aud_v_detail;
                              echo view(AUDIO_CHAT."\Views\audio_chat/comment_list", $view_data);
                           }  
                       }else{
                           $view_data['audio_comment'] = $aud_v_detail;
                           echo view(AUDIO_CHAT."\Views/tasks/task_list", $view_data);
                       }
                   }
                } else{ ?>
            <div id="no_comments_yet" class="text-center mt25"><?php echo app_lang('no_comments_yet');?></div>
            <?php } ?>
         </div>
      </div>
   </div>
</div>
<div class="modal fade" id="delete_audio_project_modal" tabindex="-1" role="dialog">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">
                    <span class="title"><?php echo app_lang("audio_chat_delete");?></span>
                </h4>
            </div>
            <?php echo form_open(get_uri("audio_chat/delete"), array("id" => "audio_chat_delete-form", "class" => "general-form bg-white custom-js-form", "role" => "form")); ?>
            <div class="modal-body clearfix">
                <div class="container-fluid">
                    <input type="hidden" name="id" value="<?php echo $audio_chat->id; ?>" />
                    <div class="mb-3 form-group">
                        <div class="row">
                            <div class="col-md-1">
                                <?php
                                    echo form_checkbox(array(
                                        "id" => "task_delete",
                                        "name" => "task_delete",
                                        "value" => "1",
                                        "class" => "form-check-input",
                                    ));
                                ?>
                            </div>
                            <label for="heading" class="col-md-11"><?php echo app_lang('task_delete'); ?></label>
                        </div>
                    </div>
                    <div class="mb-3">
                        <div class="row">
                            <label for="" class="col-md-12"><?php echo app_lang("delete_confirmation_message");?></label>
                        </div>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-danger">
                    <span data-feather="trash-2" class="icon-16"></span> <?php echo app_lang('delete'); ?>
                </button>
                <button type="button" class="btn btn-default" data-bs-dismiss="modal">
                    <span data-feather="x" class="icon-16"></span> <?php echo app_lang('cancel'); ?>
                </button>
            </div>
            <?php echo form_close(); ?>
        </div>
    </div>
</div>

<?php
   load_js(array(
       "plugins/".AUDIO_CHAT."/assets/js/wave/wavesurfer.min.js",
       "plugins/".AUDIO_CHAT."/assets/js/wave/timeline.min.js",
       "plugins/".AUDIO_CHAT."/assets/js/wave/hover.min.js",
       "plugins/".AUDIO_CHAT."/assets/js/wave/regions.min.js",
       "plugins/".AUDIO_CHAT."/assets/js/wave/zoom.min.js",
   ));
   ?>
<script type="text/javascript">
   // $('#comments_form').hide();
    var wavesurfer;
    $(document).ready(function () {
         audioUrl = '<?php echo base_url("/plugins/".AUDIO_CHAT."/files/audio/".$audio_chat->project_id."/".$audio_chat->audio_file) ?>';
           wavesurfer = WaveSurfer.create({
            container: '#waveform',
            height: 220,
            waveColor: '#6690F4',
            progressColor: '#7495e0',
            cursorColor: '#d23e43',
            backgroundColor:'#000',
            mediaControls: true,
            autoplay: false,
            dragToSeek: false,
            autoCenter: true,
            autoScroll: false,
            dragToSeek: true,
            url: audioUrl,
            hideScrollbar: true,
            // plugins: [topTimeline],
            //barWidth: 1,
        });
        const wsTimeline = wavesurfer.registerPlugin(
            WaveSurfer.Timeline.create({
                height: 20,
                timeInterval: 2,
                primaryLabelInterval: 10,
                offset: 5,
                style: {
                    fontSize: '10px',
                    color: '#999',
                },
            }),
        )
        const wshover = wavesurfer.registerPlugin(WaveSurfer.Hover.create({
            lineColor: '#ff0000',
            lineWidth: 2,
            labelBackground: '#555',
            labelColor: '#fff',
            labelSize: '11px',
        }));
        const wsRegions = wavesurfer.registerPlugin(WaveSurfer.Regions.create({
           //  
        }));
        wsRegions.enableDragSelection({
            color: 'rgba(54, 247, 211, 0.20)',
        });
        var speedSelect = document.getElementById('speedback');
        speedSelect.addEventListener('change', function() {
            var selectedSpeed = parseFloat(this.value);
            wavesurfer.setPlaybackRate(selectedSpeed);
        });
        $('#waveform').on('click', function (e) {
            const clickTime = wavesurfer.getCurrentTime();
            const formattedTime = convertToTimeFormat(clickTime);
            $('#audio_time').val(formattedTime);
            $('#audio_seconds').val(clickTime);
            var addTaskButton = document.getElementById('add_task');
            if (addTaskButton) {
                addTaskButton.setAttribute('data-post-audio_time', formattedTime);
                addTaskButton.setAttribute('data-post-audio_seconds', clickTime);
            }
        });
        // wsRegions.on('region-updated', (region) => {
        //     const starTime = convertToTimeFormat(region.start);
        //     const endTime = convertToTimeFormat(region.end);
        //     // $('#audio_time').val(starTime+ ' - ' + endTime);
        //     // showCloseButton(region); 
        //   console.log('Updated region', region)
        // });
        let flag = false;
        let currentRegion = null;
        let previousRegion = null;
        wsRegions.on('region-created', function(region) {
            currentRegion = region;
            if (previousRegion && previousRegion.color=='rgba(54, 247, 211, 0.20)') {
                previousRegion_remove(previousRegion);
                // previousRegion.remove();
            }
            previousRegion = currentRegion;
            if(previousRegion.color=='rgba(54, 247, 211, 0.20)'){
                showCloseButton(region);
            }
            if(region.color=='rgba(54, 247, 211, 0.20)'){
                const starTime = convertToTimeFormat(region.start);
                const endTime = convertToTimeFormat(region.end);
                $('#audio_time').val(starTime+ '-' + endTime);
                $('#audio_seconds').val(region.start+ '-' + region.end);
                var addTaskButton = document.getElementById('add_task');
                if (addTaskButton) {
                    addTaskButton.setAttribute('data-post-audio_time', starTime+ '-' + endTime);
                    addTaskButton.setAttribute('data-post-audio_seconds', region.start+ '-' + region.end);
                }

            }
            if (flag == true) {
                region.remove();
            }
            feather.replace();
        });
       //  wsRegions.on('region-created', function (region) {
       //      const starTime = convertToTimeFormat(region.start);
       //      const endTime = convertToTimeFormat(region.end);
       //         $('#audio_time').val(starTime+ ' - ' + endTime);
       //         showCloseButton(region);
       //         console.log('created region', region);
       //  });
       //  wsRegions.on('region-out', function(region) {
       //      var regions = wsRegions.regions;
       //      regions.forEach(function (item) {
       //          console.log('region',region.id)
       //          console.log('item',item.id)
       //           if(region.color=='rgba(54, 247, 211, 0.20)' && region.id == item.id){
       //              item.remove();
       //          }
       //      });
       // });
        wavesurfer.on('ready', (duration) => {
            const wsZoom = wavesurfer.registerPlugin(WaveSurfer.Zoom.create({
                scale: 0.5,
                maxZoom: 100,
            }));
        });
        wavesurfer.on('audioprocess', (currentTime) => {
            const formattedTime = convertToTimeFormat(currentTime);
            $('#audio_time').val(formattedTime);
            $('#audio_seconds').val(currentTime);
            var addTaskButton = document.getElementById('add_task');
            if (addTaskButton) {
                addTaskButton.setAttribute('data-post-audio_time', formattedTime);
                addTaskButton.setAttribute('data-post-audio_seconds', currentTime);
            }
        });
       // const random = (min, max) => Math.random() * (max - min) + min;
       // const randomColor = () => `rgba(${random(0, 255)}, ${random(0, 255)}, ${random(0, 255)}, 0.5)`;
        wavesurfer.on('decode', () => {
          <?php foreach ($audio_version as $key => $au_version) {  
         if ($au_version->comment_id == 0) { ?>
            var region = wsRegions.addRegion({
                start: <?php echo timeToSeconds($au_version->audio_time); ?>,
                // end: <?php echo timeToSeconds($au_version->audio_time); ?>,
                content:'',
                // color: 'rgba(0, 0, 2, 0.1)',
                color: 'rgba(54, 247, 208, 0.20)',
                drag: false,
                resize: true,
            });
            var regionElement = region.element;
            regionElement.style.top = '40px'; 
            regionElement.innerHTML = `<div class="comment" style="font-size:10px;color:white">
               <div class="user-image" data-start-time="<?php echo timeToSeconds($au_version->audio_time); ?>">
                   <img src="<?php echo get_avatar($au_version->created_by_avatar); ?>" alt="User Image" class="user_image_play" style="height: auto; max-width: 30px; border-radius: 30px; box-shadow: 0 0 0 5px #495057;" data-start-time="<?php echo timeToSeconds($au_version->audio_time); ?>">
               </div>
               <div class="on-playbtn-<?php echo $au_version->id;?>" data-start-time="<?php echo timeToSeconds($au_version->audio_time); ?>" style="display:none; position: absolute; top: -4px; left: -3px; right: 0;">
                   <button class="user_image_play" data-start-time="<?php echo timeToSeconds($au_version->audio_time);?>" style="background: none; border: 3px solid #000; border-radius: 100%; display: flex; align-items: center; justify-content: center;  width: 37px;
    height: 37px;"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-play icon-16"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg></button>
               </div>
               <div class="comment-content-<?php echo $au_version->id;?>" style="width: 70px; background-color: #2d2e2e; display: none; position: absolute; top: 3px; left: 30px; padding: 3px; z-index: 10;">
                   <span class="user-name"><?php echo $au_version->created_by_user; ?> <small><?php echo $au_version->audio_time; echo ($au_version->audio_time_end==null)?'':' - '.$au_version->audio_time_end?></small></span><br>
                   <span><?php echo $au_version->comment; ?></span>
               </div>
           </div>`;
            $(region.element).on('mouseenter', '.user-image', function() {
                $(this).siblings('.on-playbtn-<?php echo $au_version->id; ?>').fadeIn();
                $(this).siblings('.comment-content-<?php echo $au_version->id; ?>').fadeIn();
            }).on('mouseleave', '.comment', function() {
                $(this).find('.on-playbtn-<?php echo $au_version->id; ?>').hide();
                $(this).find('.comment-content-<?php echo $au_version->id; ?>').fadeOut();
           });
            $(regionElement).find('.user_image_play').on('click', function() {
                <?php if ($au_version->comment_type =='comment') {?>
                $('#comment_list_container-<?php echo $au_version->id;?> .togglePlay').trigger('click');
                $('.comment_list').removeClass('comment_list_highlight');   
                $('#comment_list_container-<?php echo $au_version->id;?>').addClass('comment_list_highlight');
                var elmntToView = document.getElementById("comment_list_container-<?php echo $au_version->id;?>");
                
            <?php } else{?>
                $('#task_list_container-<?php echo $au_version->id;?> .togglePlay').trigger('click');
                $('.comment_list').removeClass('comment_list_highlight');   
                $('#task_list_container-<?php echo $au_version->id;?>').addClass('comment_list_highlight');
                var elmntToView = document.getElementById("task_list_container-<?php echo $au_version->id;?>");
            <?php } ?>
            $('html, body').animate({
                    scrollTop: $("#comment_list_container-<?php echo $au_version->id;?>").offset().top
                }, 2000);
                // elmntToView.scrollIntoView(); 
                // var startTime = $(this).data('start-time');
                // wavesurfer.play();
                // wavesurfer.seekTo(startTime / wavesurfer.getDuration());
                feather.replace();
            });
        <?php } } ?>     
        });
        wavesurfer.on('interaction', () => {
            // wavesurfer.clearRegions();
            // wavesurfer.play()
        });        
        let currentButton = null; 
        let endTime = null;
        let hightlightRegion = null;
        
        $(document).on('click', '.togglePlay', function() {
            const startTime = parseInt($(this).data('startTime'));
            endTime = parseInt($(this).data('endTime'));
            if (currentButton === this) {
                if (wavesurfer.isPlaying()) {
                    wavesurfer.pause();
                    $(this).html('<i data-feather="play" class="icon-16"></i>');
                    feather.replace();
                } else {
                    wavesurfer.play();
                    $(this).html('<i data-feather="pause" class="icon-16"></i>');
                    feather.replace();
                }
                return;
            }
            if (currentButton) {
                wavesurfer.pause();
                $(currentButton).html('<i data-feather="play" class="icon-16"></i>');
                feather.replace();
            }
            if (hightlightRegion && hightlightRegion.color=='rgba(54, 247, 211, 0.20)') {
                previousRegion_remove(hightlightRegion);
            }
            if (!isNaN(endTime)) {
                hightlightRegion= wsRegions.addRegion({
                    start: startTime,
                    end: endTime,
                    content: '',
                    color: 'rgba(54, 247, 211, 0.20)',
                    drag: false,
                    resize: true,
                });
                $('.close-button').remove();
            }
            wavesurfer.seekTo(startTime / wavesurfer.getDuration());
            wavesurfer.play();
            $(this).html('<i data-feather="pause" class="icon-16"></i>');
            feather.replace();
            currentButton = this;
        });
        wavesurfer.on('audioprocess', function() {
            if (endTime && wavesurfer.getCurrentTime() >= endTime) {
                wavesurfer.pause();
                if (currentButton) {
                    $(currentButton).html('<i data-feather="play" class="icon-16"></i>');
                    feather.replace();
                    currentButton = null;
                }
            }
        });
        wavesurfer.on('finish', function() {
            if (currentButton) {
                currentButton.innerHTML = '<i data-feather="play" class="icon-16"></i>';
                feather.replace(); 
                currentButton = null;
            }
        });
        $("#audio_comment-form").appForm({
       isModal: false,
            onSuccess: function (result) {
                $('#comment').val('');
                $("#audio_comment_list").prepend(result.data);
                $('#no_comments_yet').hide();
                // $('#comments_form').hide();
                $('#comment').removeClass("border border-secondary");
                var startTime = timeToSeconds_js(result.comment_datail.audio_time);
                var region = wsRegions.addRegion({
                    start: startTime,
                    end: startTime,
                    content:'',
                    color: 'rgba(54, 247, 208, 0.20)',
                    drag: false,
                    resize: true,
                });
                var audio_end_time = (result.comment_datail.audio_time_end === null) ? '' : ' - ' + result.comment_datail.audio_time_end;
                var regionElement = region.element;
                regionElement.style.top = '40px'; 
                regionElement.innerHTML = `
                <div class="comment" style="font-size:10px;color:white">
                       <div class="user-image" data-start-time="`+startTime+`">
                           <img src="`+result.profile+`" alt="User Image" class="user_image_play" style="height: auto; max-width: 30px; border-radius: 30px;box-shadow: 0 0 0 5px #495057;" data-start-time="`+startTime+`">
                           
                       </div>
                       <div class="on-playbtn-`+result.comment_datail.id+`" data-start-time="`+startTime+`" style="display:none;position: absolute; top: -4px; left: -3px; right: 0;">
                           <button class="user_image_play" data-start-time="`+startTime+`" style="border: none; background: none; border: 3px solid #000; border-radius: 100%; display: flex; align-items: center; justify-content: center;  width: 37px;height: 37px;"><svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-play icon-16"><polygon points="5 3 19 12 5 21 5 3"></polygon></svg></button>
                       </div>
                       <div class="comment-content-`+result.comment_datail.id+`" style="width: 70px; background-color: #2d2e2e; display: none; position: absolute; top: 3px; left: 30px; padding: 3px; z-index: 10;">
                           <span class="user-name">`+ result.comment_datail.created_by_user +` <small>`+ result.comment_datail.audio_time  +` `+ audio_end_time +`</small></span><br>
                           <span>`+ result.comment_datail.comment+`</span>
                       </div>
                   </div>`;
                 $(region.element).on('mouseenter', '.user-image', function() {
                        // $(this).hide();
                        $(this).siblings('.on-playbtn-'+result.comment_datail.id).fadeIn();
                        $(this).siblings('.comment-content-'+result.comment_datail.id).fadeIn();
                    }).on('mouseleave', '.comment', function() {
                        $(this).find('.on-playbtn-'+result.comment_datail.id).hide();
                        $(this).find('.comment-content-'+result.comment_datail.id).fadeOut();
                        // $(this).find('.user-image').show();
                   });
                $(regionElement).find('.user_image_play').on('click', function() {
                    $('#comment_list_container-'+result.comment_datail.id+' .togglePlay').trigger('click');
                    $('.comment_list').removeClass('comment_list_highlight');   
                    $('#comment_list_container-'+result.comment_datail.id).addClass('comment_list_highlight');
                    var elmntToView = document.getElementById("comment_list_container-"+result.comment_datail.id);
                    elmntToView.scrollIntoView();
                    //var startTime = $(this).data('start-time');
                    //wavesurfer.play();
                    //wavesurfer.seekTo(startTime / wavesurfer.getDuration());
                    feather.replace();
                });
                $('.close-button').remove();
                feather.replace();
            }
        });
        $("#audio_chat_delete-form").appForm({
            onSuccess: function (result) {
                location.reload();
            }
        });
        const zoom = wavesurfer.registerPlugin(WaveSurfer.Zoom.create({

        }));
        document.getElementById('zoom-in').addEventListener('click', function() {
            var zoomLevel = wavesurfer.options.minPxPerSec * 2;
            document.getElementById('zoom-out').removeAttribute('disabled');
            if(zoomLevel>0){
                wavesurfer.zoom(zoomLevel);
            }else{
                wavesurfer.zoom(50);
            }
        });
        document.getElementById('zoom-out').addEventListener('click', function() {
            var zoomLevel = wavesurfer.options.minPxPerSec / 2;
            document.getElementById('zoom-out').setAttribute('disabled', 'disabled');
            if(zoomLevel>0){
                wavesurfer.zoom(-zoomLevel);
            }else{
                wavesurfer.zoom(-50);
            }
        });
        $(document).on('click', '.comment_list', function() {
            $('.comment_list').removeClass('comment_list_highlight');   
            $(this).addClass('comment_list_highlight');
        });
        /*document.querySelector('#stopBtn').addEventListener('click', function () {
            wavesurfer.stop();
        });*/
        
        function previousRegion_remove(region) {
           var regions = wsRegions.regions;
            regions.forEach(function (item) {
                 if(region.id == item.id){
                    region.remove();
                }
            });
       }
        $(document).on('click', '#comment', function() {
            $("#comment").addClass("border border-secondary");
        });   

    });
    function showCloseButton(region) {
        $('.close-button').remove();
        const closeButton = document.createElement('div');
        closeButton.className = 'close-button';
        closeButton.textContent = 'X'; 
        const regionElement = region.element;
        const regionRect = regionElement.getBoundingClientRect();
        const closeButtonTop = regionRect.top - 3; 
        const closeButtonLeft = regionRect.left + regionRect.width - 1; 
        closeButton.style.top = `${closeButtonTop}px`;
        closeButton.style.left = `${closeButtonLeft}px`;
        closeButton.addEventListener('click', function (e) {
            previousRegion=null;
            e.stopPropagation(); 
            region.remove(); 
            $(this).remove(); 
        });
        document.body.appendChild(closeButton);
    }
    function change_version(project_id,id) {
        $.ajax({
            url : "<?php echo get_uri("audio_chat/version_waveform/");?>"+project_id,
            data:{id : id},
            method:'post',
            dataType:'json',
            success:function(response) {
                $(".new_audio_version").parent().html("");
                $("#project-audio_chat-section").append(response.data);
            }
        });
    }
    function convertToTimeFormat(currentTime) {
        let hours = Math.floor(currentTime / 3600);
        let minutes = Math.floor((currentTime % 3600) / 60);
        let seconds = Math.floor(currentTime % 60);
        let timeString = "";
        if (hours > 0) {
            timeString += hours + ":";
        }
        minutes = (minutes < 10) ? "0" + minutes : minutes;
        seconds = (seconds < 10) ? "0" + seconds : seconds;
        timeString += minutes + ":" + seconds;
        return timeString;
    }
    
   function timeToSeconds_js(time) {
       const timeParts = time.split(':');
       let seconds = 0;
       if (timeParts.length === 3) {
           seconds += parseInt(timeParts[0], 10) * 3600; 
           seconds += parseInt(timeParts[1], 10) * 60;   
           seconds += parseInt(timeParts[2], 10);        
       } else if (timeParts.length === 2) {
           seconds += parseInt(timeParts[0], 10) * 60;   
           seconds += parseInt(timeParts[1], 10);        
       } else if (timeParts.length === 1) {
           seconds += parseInt(timeParts[0], 10);        
       }
       return seconds;
   } 
   function comment_form(type) {
       if(type=='show'){
          $('#comments_form').show();
       }else{
           $('#comments_form').hide();
           $('#comment').val('');
           $('#comment').removeClass("border border-secondary");
       }
   }
   function comment_task_like_unlike(element) {
    var $element = $(element);
    var like_id = $element.attr('data-like-id');
    var version_id = $element.attr('data-version-id');
    var rel_id = $element.attr('data-rel-id');
    var project_id = $element.attr('data-project-id');
    var is_like = $element.attr('data-is-like');
    var type = $element.attr('data-type');
   
    $.ajax({
        url: '<?php echo_uri("audio_chat/add_remove_like_unlike") ?>/' + rel_id,
        type: 'POST',
        dataType: 'json',
        data: { version_id: version_id, rel_id: rel_id, project_id: project_id, type: type, is_like: is_like, like_id: like_id },
        success: function(response) {
            $element.attr('data-is-like', response.likeData.is_like);
            $element.attr('data-like-id', response.likeData.like_id);
            var totalLike = response.totalLikes >= 1 ? response.totalLikes : '';
            var iconHtml = response.likeData.is_like == '1' ? 
                "<i data-feather='heart' class='icon-16 icon-fill-comment_task'></i> " + totalLike : 
                "<i data-feather='heart' class='icon-16'></i> " + totalLike;
            $element.html(iconHtml);
            feather.replace();
        }
    });
   }
   function comment_task_order_by(element) {
    var $element = $(element);
    var version_id = $element.attr('data-version-id');
    var project_id = $element.attr('data-project-id');
    var order_by = $element.attr('data-order-by');
    
    $.ajax({
        url: '<?php echo_uri("audio_chat/change_comment_task_order_by") ?>/' + version_id,
        type: 'POST',
        dataType: 'json',
        data: { project_id: project_id, order_by: order_by },
        success: function(response) {
            $('#audio_comment_list').html(response.data);
            $('#order_by_data').text(response.order_by);
            feather.replace();
        }
    });
   }
   function change_version_status(id,status_id) {
    $.ajax({
        url : "<?php echo get_uri("audio_chat/change_version_status/");?>"+id,
        data:{status_id : status_id},
        method:'post',
        dataType:'json',
        success:function(response) {
            $("#version_status").text(response.data.name);
        }
    });
   }
    function audio_chat_project_delete(element) {
        $('#task_delete').prop('checked', false);
        $('#delete_audio_project_modal').modal('show');
   }

</script>