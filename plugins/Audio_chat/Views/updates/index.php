<div class="modal-body clearfix">
    <div class="container-fluid">
        <div class="card">
            <div id="app-update-container" class="card-body font-14">
                <?php if (count($installable_updates) || count($downloadable_updates)) { ?>
                    <div class="row">
                        <div class="col-md-6 text-center">
                            <div class="alert alert-danger">
                                <h4 class="tw-font-bold !tw-text-base tw-mb-1"><?php echo app_lang("current_version");?></h4>
                                <p class="tw-font-semibold tw-mb-0"><?php echo $current_version;?></p>
                            </div>
                        </div>
                        <div class="col-md-6 text-center">
                            <div class="alert alert-success">
                                <h4 class="tw-font-bold !tw-text-base tw-mb-1"><?php echo app_lang("latest_version");?></h4>
                                <p class="tw-font-semibold tw-mb-0"><?php echo $latest_version;?></p>
                            </div>
                        </div>
                    </div>
                    <script type='text/javascript'>
                        $(document).ready(function () {
                            appAlert.warning("Before performing an update, it is <b>strongly recommended to create a full backup</b> of your current installation <b>(files and database)</b> and review the change log.", {container: "#app-update-container", animate: false});
                            $(".app-alert-message").css("max-width", 1000);
                        });
                    </script>

                    <?php
                    foreach ($installable_updates as $salt => $version) {
                        echo "<p><a class='do-update' data-version='$version' data-salt='$salt' href='#'>Click here to Install the version - <b>$version</b></a></p>";
                    }
                    foreach ($downloadable_updates as $salt => $version) {
                        echo "<p class='download-updates text-center text-warning' data-salt='$salt' data-version='$version'>Yay! New version <b>$version</b> found, awaiting for download.</p>";
                    }
                } else { ?>
                    <div class="row">
                        <div class="col-md-6 text-center">
                            <div class="alert alert-success">
                                <h4 class="tw-font-bold !tw-text-base tw-mb-1"><?php echo app_lang("current_version");?></h4>
                                <p class="tw-font-semibold tw-mb-0"><?php echo $current_version;?></p>
                            </div>
                        </div>
                        <div class="col-md-6 text-center">
                            <div class="alert alert-success">
                                <h4 class="tw-font-bold !tw-text-base tw-mb-1"><?php echo app_lang("latest_version");?></h4>
                                <p class="tw-font-semibold tw-mb-0"><?php echo $current_version;?></p>
                            </div>
                        </div>
                    </div>
                <?php
                    }
                ?>
                <div class="b-t pt15 mt10">
                    <?php echo anchor("proReport_updates/systeminfo", app_lang("server_info"), array("class" => "btn btn-warning", "target" => "_blank")); ?>
                </div>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">
    "use strict";
    $(document).ready(function () {
        var startDownload = function () {
            var $link = $(".download-updates").first(),
                    version = $link.attr("data-version"),
                    salt = $link.attr("data-salt");

            if ($link.length) {
                $link.replaceWith("<p class='downloading downloading-" + version + " text-center mt10'><span class='download-loader spinning-btn spinning'></span> Downloading the version - <b>" + version + "</b>. Please wait...</p>");
                $.ajax({
                    url: "<?php echo_uri("proReport_updates/download_updates/"); ?>" + "/" + version + "/" + salt,
                    dataType: "json",
                    success: function (response) {
                        if (response.success) {
                            $(".downloading").html("<a class='do-update btn btn-success' data-version='" + version + "' data-salt='" + salt + "'href='#'>Click here to Install the version - <b>" + version + "</b></a>").removeClass("downloading");
                            startDownload();
                        } else {
                            $(".downloading").html("<p>" + response.message + "</p>").removeClass("downloading").addClass("alert alert-danger");
                        }
                    }
                });
            }
        };

        startDownload();

        $('body').on('click', '.do-update', function () {
            var version = $(this).attr("data-version");
            var salt = $(this).attr("data-salt");
            $("#app-update-container").html("<h3><span class='download-loader-lg spinning-btn spinning'></span> Installing version - " + version + ". Please wait... </h3>");
            $.ajax({
                url: "<?php echo_uri("proReport_updates/do_update/"); ?>" + "/" + version + "/" + salt,
                dataType: "json",
                success: function (response) {
                    $("#app-update-container").html("");
                    if (response.success) {
                        appAlert.success(response.message, {container: "#app-update-container", animate: false});
                    } else {
                        appAlert.error(response.message, {container: "#app-update-container", animate: false});
                    }
                    setTimeout(function () {
                        location.reload();
                    }, 2000);
                }
            });
        });

<?php if (isset($error)) { ?>
            appAlert.error("<?php echo $error; ?>", {container: "#app-update-container", animate: false});
<?php } ?>

    });
</script>