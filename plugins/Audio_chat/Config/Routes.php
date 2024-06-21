<?php
namespace Config;
$routes = Services::routes();
$Audio_chat = ['namespace' => 'Audio_chat\Controllers'];
$routes->get('audio_chat', 'Audio_chat::index', $Audio_chat);
$routes->get('audio_chat/version_waveform/(:any)', 'Audio_chat::version_waveform/$1', $Audio_chat);
$routes->post('audio_chat/version_waveform/(:any)', 'Audio_chat::version_waveform/$1', $Audio_chat);

$routes->get('audio_chat/(:any)', 'Audio_chat::$1', $Audio_chat);
$routes->post('audio_chat/(:any)', 'Audio_chat::$1', $Audio_chat);
$routes->post('audio_chat/validate_audio_file', 'Audio_chat::validate_audio_file', $Audio_chat);

$routes->get('task', 'Task::index', $Audio_chat);
$routes->post('task/tasks_modal_form/(:any)', 'Task::tasks_modal_form/$1', $Audio_chat);
$routes->post('task/save', 'Task::save', $Audio_chat);
