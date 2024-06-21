<?php

namespace Custom\Config;

use CodeIgniter\Events\Events;



Events::on('pre_system', function () {

    helper("audio_chat_helper");

});