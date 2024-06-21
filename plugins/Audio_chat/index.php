<?php
defined('PLUGINPATH') or exit('No direct script access allowed');
/*
  Plugin Name: Audio Chat
  Description: Audio Chat Module
  Version: 1.0
  Requires at least: 3.0
  Author: codexnation
  Author URL: https://codexnation.com
 */
define("AUDIO_CHAT","Audio_chat");
use App\Controllers\Security_Controller;
//Load Module Helpers
helper('audio_chat_helper');
//install dependencies
register_installation_hook(AUDIO_CHAT, function ($item_purchase_code) {
    include PLUGINPATH . AUDIO_CHAT."/install/do_install.php";
});
//activate dependencies
register_activation_hook(AUDIO_CHAT, 'audio_chat_activation_function');
function audio_chat_activation_function(){
    include PLUGINPATH . AUDIO_CHAT."/install/install.php"; 
}
//uninstall remove data from database
register_uninstallation_hook(AUDIO_CHAT, function () {
    $dbprefix = get_db_prefix();
});

app_hooks()->add_action('app_hook_role_permissions_extension', function () {
    echo view(AUDIO_CHAT.'\Views\settings\permission', []);
});
app_hooks()->add_filter('app_filter_role_permissions_save_data', function ($permissions) {
    $request = \Config\Services::request();
    $permissions["add_audio_project_per"] = $request->getPost('add_audio_project_per');
    $permissions["edit_audio_project_per"] = $request->getPost('edit_audio_project_per');
    $permissions["delete_audio_project_per"] = $request->getPost('delete_audio_project_per');
    return $permissions;
});
// app_hooks()->add_filter('app_filter_clients_project_details_tab', 'app_filter_clients_project_details_tab');
app_hooks()->add_filter('app_filter_team_members_project_details_tab', 'app_filter_clients_project_details_tab');
if (!function_exists('app_filter_clients_project_details_tab')) {
    function app_filter_clients_project_details_tab($hook_tabs, $project_id = 0){
        if(can_manage_has_permission("add_audio_project_per","yes") ||can_manage_has_permission("edit_audio_project_per","yes") || can_manage_has_permission("delete_audio_project_per","yes")){
            $hook_tabs['audio_chat'] ="audio_chat/version_waveform/".$project_id; 
             return $hook_tabs;
        }
    }
}
