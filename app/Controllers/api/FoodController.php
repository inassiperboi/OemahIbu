<?php namespace App\Controllers\Api;

use CodeIgniter\RESTful\ResourceController;
use App\Models\FoodModel;

class FoodController extends ResourceController
{
    protected $modelName = 'App\Models\FoodModel';
    protected $format    = 'json';

    private function result($code, $info, $data)
    {
        $result = new \stdClass();
        $result->code = $code;
        $result->info = $info;
        $result->data = $data;
        return $this->respond($result);
    }

    private function saveBase64Image($base64Image)
    {
        if (empty($base64Image)) {
            return null;
        }
        $imageData = base64_decode(preg_replace('#^data:image/\w+;base64,#i', '', $base64Image));
        $filePath = FCPATH . 'uploads/' . uniqid() . '.png';
        if (!is_dir(FCPATH . 'uploads')) {
            mkdir(FCPATH . 'uploads', 0777, true);
        }
        file_put_contents($filePath, $imageData);
        return 'uploads/' . basename($filePath);
    }

    public function index()
    {
        $this->handleCORS();
        $foods = $this->model->findAll();
        return $this->result(0, 'List of all foods', $foods);
    }

    public function getFoodById()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json || !isset($json->food_id)) {
            return $this->result(1, 'Invalid request or missing Food ID', null);
        }
        $food = $this->model->find($json->food_id);
        if (!$food) {
            return $this->result(1, 'Food not found', null);
        }
        return $this->result(0, 'Details of food', $food);
    }

    public function create()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json) {
            return $this->result(1, 'Invalid request', null);
        }
        $data = [
            'jenis' => $json->jenis ?? '',
            'nama' => $json->nama ?? '',
            'kesulitan' => $json->kesulitan ?? '',
            'images' => $this->saveBase64Image($json->images ?? '')
        ];
        if ($this->model->insert($data) === false) {
            return $this->result(1, 'Failed to add food', $this->model->errors());
        }
        return $this->result(0, 'Food added successfully', null);
    }

    public function updateFood()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json || !isset($json->food_id)) {
            return $this->result(1, 'Invalid request or missing Food ID', null);
        }
        $data = [
            'jenis' => $json->jenis ?? null,
            'nama' => $json->nama ?? null,
            'kesulitan' => $json->kesulitan ?? null,
            'images' => $this->saveBase64Image($json->images ?? null)
        ];
        if ($this->model->update($json->food_id, $data) === false) {
            return $this->result(1, 'Failed to update food', $this->model->errors());
        }
        return $this->result(0, 'Food updated successfully', null);
    }

    public function deleteFood()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json || !isset($json->food_id)) {
            return $this->result(1, 'Invalid request or missing Food ID', null);
        }
        if (!$this->model->delete($json->food_id)) {
            return $this->result(1, 'Failed to delete food or food not found', null);
        }
        return $this->result(0, 'Food deleted successfully', null);
    }
}
