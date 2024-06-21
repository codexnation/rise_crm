<?php

namespace App\Libraries;

use Psr\Http\Message\RequestInterface;
use Google\Http\MediaFileUpload;
use GuzzleHttp\Psr7\Request;

class Google
{

    private $Settings_model;

    public function __construct()
    {
        $this->Settings_model = model("App\Models\Settings_model");

        //load resources
        require_once(APPPATH . "ThirdParty/Google/google-api-php-client-2-15-0/autoload.php");
    }

    //authorize connection
    public function authorize()
    {
        $client = $this->_get_client_credentials();
        $this->_check_access_token($client, true);
    }

    //check access token
    private function _check_access_token($client, $redirect_to_settings = false)
    {
        //load previously authorized token from database, if it exists.
        $accessToken = get_setting("google_drive_oauth_access_token");
        if (get_setting("google_drive_authorized") && $accessToken && !$redirect_to_settings) {
            $client->setAccessToken(json_decode($accessToken, true));
        }

        // If there is no previous token or it's expired.
        if ($client->isAccessTokenExpired()) {
            // Refresh the token if possible, else fetch a new one.
            if ($client->getRefreshToken()) {
                $client->fetchAccessTokenWithRefreshToken($client->getRefreshToken());
                if ($redirect_to_settings) {
                    app_redirect("settings/integration/google_drive");
                }
            } else {
                $authUrl = $client->createAuthUrl();
                app_redirect($authUrl, true);
            }
        } else {
            if ($redirect_to_settings) {
                app_redirect("settings/integration/google_drive");
            }
        }
    }

    //fetch access token with auth code and save to database
    public function save_access_token($auth_code)
    {
        $client = $this->_get_client_credentials();

        // Exchange authorization code for an access token.
        $accessToken = $client->fetchAccessTokenWithAuthCode($auth_code);

        $error = get_array_value($accessToken, "error");

        if ($error)
            die($error);


        $client->setAccessToken($accessToken);

        // Save the token to database
        $new_access_token = json_encode($client->getAccessToken());

        if ($new_access_token) {
            $this->Settings_model->save_setting("google_drive_oauth_access_token", $new_access_token);

            //got the valid access token. store to setting that it's authorized
            $this->Settings_model->save_setting("google_drive_authorized", "1");
        }

        //create parent folder
        $this->_create_folder(get_setting('app_title'), "parent");
    }

    //check a folder if it exists of not
    private function _is_folder_exists($service, $folder_name)
    {
        $exists = false;

        $parameters['q'] = "mimeType='application/vnd.google-apps.folder' and trashed=false";
        $files = $service->files->listFiles($parameters);

        if (in_array($folder_name, array_column((array) $files->files, 'name'))) {
            $exists = true;
        }

        return $exists;
    }

    //save all the folders and temporary files ID into database as serialized data
    private function _save_id($name = "", $id = "", $type = "folder", $path_type = "node")
    {
        if ($path_type == "parent") {
            //save parent folder id
            //save it individually because app title might be change later
            $this->Settings_model->save_setting("google_drive_parent_folder_id", $id);
        } else {
            $final_ids = array();
            if ($type == "folder") {
                $setting_name = "google_drive_folder_ids";
                $ids = get_setting($setting_name);
            } else {
                $setting_name = "google_drive_temp_file_ids";
                $ids = get_setting($setting_name);
            }

            if (!empty($ids) && is_array(@unserialize($ids))) {
                $final_ids = unserialize($ids);
            }

            $final_ids[$name] = $id;

            $this->Settings_model->save_setting($setting_name, serialize($final_ids));
        }
    }

    //download file 
    public function download_file($file_id = "")
    {
        $service = $this->_get_drive_service();
        $response = $service->files->get($file_id, array(
            'alt' => 'media'
        ));
        return $response->getBody()->getContents();
    }

    //get file content
    public function get_file_content($file_id = "")
    {
        try {
            $service = $this->_get_drive_service();
            $response = $service->files->get($file_id, array(
                'alt' => 'media'
            ));
    
            $content_type_header = $response->getHeader('Content-Type');
            $mime_type = "";
            if ($content_type_header) {
                $mime_type = $content_type_header[0];
            }
            return array("mime_type"=>$mime_type, "contents"=>$response->getBody()->getContents());

        } catch (\Exception $e) {
            return json_decode($e->getMessage(), true);
        }
        
    }

    //get service
    private function _get_drive_service()
    {
        $client = $this->_get_client_credentials();
        $this->_check_access_token($client);

        return new \Google_Service_Drive($client);
    }

    //get folder and temp file ID
    private function _get_id($name = "", $type = "folder")
    {
        if ($type == "folder") {
            $stored_ids = get_setting("google_drive_folder_ids");
        } else {
            $stored_ids = get_setting("google_drive_temp_file_ids");
        }

        $ids = $stored_ids ? unserialize($stored_ids) : array();

        //for temp file id, remove old one
        if ($type == "file" && get_array_value($ids, $name)) {
            $final_ids = $ids;
            unset($final_ids[$name]);
            $this->Settings_model->save_setting("google_drive_temp_file_ids", serialize($final_ids));
        }

        return get_array_value($ids, $name);
    }

    //create folder
    private function _create_folder($folder_name = "", $path_type = "node")
    {
        $service = $this->_get_drive_service();

        if (!$this->_is_folder_exists($service, $folder_name)) {
            $file = new \stdClass();

            if ($path_type == "parent") {
                //create parent folder with app title
                //in future, all uploads will be into this folder
                $fileMetadata = new \Google_Service_Drive_DriveFile(
                    array(
                        'name' => $folder_name,
                        'mimeType' => 'application/vnd.google-apps.folder'
                    )
                );

                $file = $service->files->create($fileMetadata, array('fields' => 'id'));
            } else {
                //this are the node folders
                if (get_setting("google_drive_parent_folder_id")) {
                    //check if the parent folder exists
                    $fileMetadata = new \Google_Service_Drive_DriveFile(array(
                        'name' => $folder_name,
                        'parents' => array(get_setting("google_drive_parent_folder_id")),
                        'mimeType' => 'application/vnd.google-apps.folder',
                    ));
                    $file = $service->files->create($fileMetadata, array(
                        'uploadType' => 'multipart',
                        'fields' => 'id'
                    ));
                } else {
                    $this->_create_folder(get_setting('app_title'), "parent");
                }
            }

            //save folder id
            if (isset($file->id)) {
                $this->_save_id($folder_name, $file->id, "folder", $path_type);

                return $file->id;
            } else {
                return "";
            }
        } else {
            return $this->_get_id($folder_name);
        }
    }

    //upload file to temp folder
    public function upload_file_old($temp_file, $file_name, $folder_name = "", $file_content = "")
    {
        $service = $this->_get_drive_service();

        $folder_id = $this->_create_folder($folder_name);
        $fileMetadata = new \Google_Service_Drive_DriveFile(array(
            'name' => $file_name,
            'parents' => array($folder_id)
        ));

        if ($file_content) {
            //file contents
            $content = $file_content;
            $finfo = new \finfo(FILEINFO_MIME);
            $mime_type = $finfo->buffer($file_content);
        } else {
            //file path
            $content = file_get_contents($temp_file);
            $mime_type = mime_content_type($temp_file);
        }

        $file = $service->files->create($fileMetadata, array(
            'data' => $content,
            'mimeType' => $mime_type,
            'uploadType' => 'multipart',
            'fields' => 'id'
        ));

        $this->_make_file_as_public($service, $file->id);

        //save id's for temp files
        if ($folder_name == "temp") {
            $this->_save_id($file_name, $file->id, "file");
        } else {
            return array("file_name" => $file_name, "file_id" => $file->id, "service_type" => "google");
        }
    }

    //upload file to temp folder
    public function upload_file($temp_file, $file_name, $folder_name = "", $file_content = "", $file_size = 0)
    {
        $service = $this->_get_drive_service();

        $folder_id = $this->_create_folder($folder_name);

        $meta = array(
            'name' => $file_name,
            'parents' => array($folder_id)
        );

        $fileMetadata = new \Google_Service_Drive_DriveFile($meta);

        $google_drive_file_id = "";


        if ($file_content) {

            $finfo = new \finfo(FILEINFO_MIME);
            $mime_type = $finfo->buffer($file_content);

            $file = $service->files->create($fileMetadata, array(
                'data' => $file_content,
                'mimeType' => $mime_type,
                'uploadType' => 'multipart',
                'fields' => 'id'
            ));

            $google_drive_file_id = $file->id;
        } else {

            $mime_type = mime_content_type($temp_file);
            $client = $this->_get_client_credentials();
            $this->_check_access_token($client);

            $request_body = $meta;
            $request_body["mimeType"] = $mime_type;

            $access_token = get_array_value($client->getAccessToken(), "access_token");

            //Note: 
            //The suggested url by google drive documentaion is https://www.googleapis.com/upload/drive/v3/files?uploadType=media. 
            //https://developers.google.com/drive/api/guides/manage-uploads
            //But there might be any bug in the MediaFileUpload. So, use the following url: 
            //https://www.googleapis.com/drive/v3/files?uploadType=resumable

            $request = new Request(
                'POST',
                'https://www.googleapis.com/drive/v3/files?uploadType=resumable',
                array(
                    "Authorization" => 'Bearer ' . $access_token,
                    "Content-Type" => "application/json"
                ),
                json_encode($request_body)
            );

            $chunk_size = 1024 * 1024 * 3; // 3MB

            $media_file = new MediaFileUpload(
                $client,
                $request,
                "application/json",
                json_encode($request_body),
                true,
                $chunk_size
            );

            $media_file->setFileSize($file_size);

            $temp_file_content = fopen($temp_file, 'r');
            while (!feof($temp_file_content)) {

                $chunk = fread($temp_file_content, $chunk_size);

                $media_file->nextChunk($chunk);
            }

            fclose($temp_file_content);

            // The upload is complete.
            //find the file id

            $curl = curl_init();
            curl_setopt($curl, CURLOPT_URL, $media_file->getResumeUri());
            curl_setopt($curl, CURLOPT_POST, true);
            curl_setopt($curl, CURLOPT_RETURNTRANSFER, true);
            curl_setopt($curl, CURLOPT_POSTFIELDS, "file=1"); //could be any data. 

            $headers = array(
                "Authorization" => "Bearer $access_token",
                "Content-Type" => "applicaito/json",
                "Content-length" => 6 //google drive api requires a content lenght for post re
            );
            curl_setopt($curl, CURLOPT_HTTPHEADER, $headers);

            $result = curl_exec($curl);
            curl_close($curl);


            if ($result) {
                $result = json_decode($result);
                $google_drive_file_id =  $result->id;
            }
        }

        $this->_make_file_as_public($service, $google_drive_file_id);

        //save id's for temp files
        if ($folder_name == "temp") {
            $this->_save_id($file_name, $google_drive_file_id, "file");
        } else {
            return array("file_name" => $file_name, "file_id" => $google_drive_file_id, "service_type" => "google");
        }
    }

    //make drive file as public
    private function _make_file_as_public($service, $file_id = "")
    {
        $permission = new \Google_Service_Drive_Permission(array(
            'type' => 'anyone',
            'role' => 'reader'
        ));

        $service->permissions->create($file_id, $permission);
    }

    //move temp files to permanent directory 
    public function move_temp_file($file_name, $new_filename, $folder_name)
    {
        $service = $this->_get_drive_service();

        $fileId = $this->_get_id($file_name, "file");
        $folderId = $this->_create_folder($folder_name);
        $emptyFileMetadata = new \Google_Service_Drive_DriveFile();

        // Retrieve the existing parents to remove
        $file = $service->files->get($fileId, array('fields' => 'parents'));
        $previousParents = join(',', $file->parents);

        // Move the file to the new folder
        $file = $service->files->update($fileId, $emptyFileMetadata, array(
            'addParents' => $folderId,
            'removeParents' => $previousParents,
            'fields' => 'id, parents'
        ));

        //rename file with new name
        $this->_rename_file($service, $fileId, $new_filename);

        return array("file_name" => $new_filename, "file_id" => $fileId, "service_type" => "google");
    }

    //rename file
    private function _rename_file($service, $file_id, $new_filename)
    {
        $file = new \Google_Service_Drive_DriveFile();
        $file->setName($new_filename);

        $service->files->update($file_id, $file, array(
            'fields' => 'name'
        ));
    }

    //delete file
    public function delete_file($file_id)
    {
        $service = $this->_get_drive_service();
        $service->files->delete($file_id);
    }

    //get client credentials
    private function _get_client_credentials()
    {
        $url = get_uri("google_api/save_access_token");

        $client = new \Google_Client();
        $client->setApplicationName(get_setting('app_title'));
        $client->setRedirectUri($url);
        $client->setClientId(get_setting('google_drive_client_id'));
        $client->setClientSecret(get_setting('google_drive_client_secret'));
        $client->setScopes(\Google_Service_Drive::DRIVE);
        $client->setAccessType("offline");
        $client->setPrompt('select_account consent');

        return $client;
    }
}
