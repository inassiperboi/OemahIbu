<?php namespace App\Controllers\Api;

use CodeIgniter\RESTful\ResourceController;
use App\Models\UserModel;

class UserController extends ResourceController
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

    public function index()
    {
        $this->handleCORS();
        $users = $this->model->findAll();
        return $this->result(0, 'List of all users', $users);
    }

    public function getAllUser()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json) {
            return $this->result(1, 'Invalid request', null);
        }
        $user = $this->model->getDataById($json->user_id ?? null);
        if (!$user) {
            return $this->result(1, 'User not found', null);
        }
        return $this->result(0, 'User details', $user);
    }

    public function create()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json) {
            return $this->result(1, 'Invalid request', null);
        }
        $data = [
            'name' => $json->name ?? '',
            'email' => $json->email ?? '',
            'password' => $json->password ?? '',
            'phone' => $json->phone ?? '',
            'code' => $json->code ?? ''
        ];
        if ($this->model->insert($data) === false) {
            return $this->result(1, 'User registration failed', $this->model->errors());
        }
        return $this->result(0, 'User registered successfully', $data);
    }

    public function updateUser()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json || !isset($json->user_id)) {
            return $this->result(1, 'Invalid request or missing User ID', null);
        }
        $id = $json->user_id;
        $data = [
            'name' => $json->name ?? null,
            'email' => $json->email ?? null,
            'password' => $json->password ?? null,
            'phone' => $json->phone ?? null,
            'code' => $json->code ?? null
        ];
        if ($this->model->update($id, $data) === false) {
            return $this->result(1, 'User update failed', $this->model->errors());
        }
        return $this->result(0, 'User updated successfully', null);
    }

    public function deleteUser()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json || !isset($json->user_id)) {
            return $this->result(1, 'Invalid request or missing User ID', null);
        }
        $id = $json->user_id;
        if (!$this->model->delete($id)) {
            return $this->result(1, 'Failed to delete user or user not found', null);
        }
        return $this->result(0, 'User deleted successfully', null);
    }
}
