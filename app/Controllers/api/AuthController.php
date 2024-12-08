<?php namespace App\Controllers\Api;

use CodeIgniter\RESTful\ResourceController;
use App\Models\UserModel;

class AuthController extends ResourceController
{
    protected $modelName = 'App\Models\UserModel';
    protected $format    = 'json';

    private function result($code, $info, $data)
    {
        $result = new \stdClass();
        $result->code = $code;
        $result->info = $info;
        $result->data = $data;
        return $this->respond($result);
    }

    public function register()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json) {
            return $this->result(1, 'Invalid request', null);
        }

        $userModel = new UserModel();
        $data = [
            'name' => $json->name ?? '',
            'email' => $json->email ?? '',
            'password' => $json->password ?? '',
            'phone' => $json->phone ?? '',
            'code' => $json->code ?? ''
        ];

        if ($userModel->insert($data) === false) {
            return $this->result(1, 'Failed to register user', $userModel->errors());
        }

        return $this->result(0, 'User registered successfully', null);
    }

    public function login()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json) {
            return $this->result(1, 'Invalid request', null);
        }

        $userModel = new UserModel();
        $user = $userModel->login($json->code ?? '', $json->password ?? '');
        if (!$user) {
            return $this->result(1, 'Invalid login credentials', null);
        }

        return $this->result(0, 'Successfully logged in', $user);
    }

    public function changePassword()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json) {
            return $this->result(1, 'Invalid request', null);
        }

        $userModel = new UserModel();
        $updated = $userModel->changePassword($json->user_id, $json->new_password ?? '');
        if (!$updated) {
            return $this->result(1, 'Failed to update password', null);
        }

        return $this->result(0, 'Password updated successfully', null);
    }
}
