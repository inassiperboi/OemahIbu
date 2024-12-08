<?php namespace App\Controllers\Api;

use CodeIgniter\RESTful\ResourceController;
use App\Models\FoodDetailModel;

class FoodDetailController extends ResourceController
{
    protected $modelName = 'App\Models\FoodDetailModel';
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
        $foodDetails = $this->model->findAll();
        return $this->result(0, 'List of all food details', $foodDetails);
    }

    public function showById()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json || !isset($json->food_detail_id)) {
            return $this->result(1, 'Invalid request or missing Food Detail ID', null);
        }
        $foodDetail = $this->model->find($json->food_detail_id);
        if (!$foodDetail) {
            return $this->result(1, 'Food detail not found', null);
        }
        return $this->result(0, 'Details of food detail', $foodDetail);
    }

    public function create()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json) {
            return $this->result(1, 'Invalid request', null);
        }
        $data = [
            'food_id' => $json->food_id ?? '',
            'bahan' => $json->bahan ?? '',
            'langkah' => $json->langkah ?? '',
            'tips' => $json->tips ?? '',
            'bumbu' => $json->bumbu ?? '',
            'pelengkap' => $json->pelengkap ?? ''
        ];
        if ($this->model->insert($data) === false) {
            return $this->result(1, 'Failed to add food detail', $this->model->errors());
        }
        return $this->result(0, 'Food detail added successfully', null);
    }

    public function updateFood()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json || !isset($json->food_detail_id)) {
            return $this->result(1, 'Invalid request or missing Food Detail ID', null);
        }
        $data = [
            'food_id' => $json->food_id ?? null,
            'bahan' => $json->bahan ?? null,
            'langkah' => $json->langkah ?? null,
            'tips' => $json->tips ?? null,
            'bumbu' => $json->bumbu ?? null,
            'pelengkap' => $json->pelengkap ?? null
        ];
        if ($this->model->update($json->food_detail_id, $data) === false) {
            return $this->result(1, 'Failed to update food detail', $this->model->errors());
        }
        return $this->result(0, 'Food detail updated successfully', null);
    }

    public function deleteFood()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json || !isset($json->food_detail_id)) {
            return $this->result(1, 'Invalid request or missing Food Detail ID', null);
        }
        if (!$this->model->delete($json->food_detail_id)) {
            return $this->result(1, 'Failed to delete food detail or food detail not found', null);
        }
        return $this->result(0, 'Food detail deleted successfully', null);
    }

    public function getByFoodId()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json || !isset($json->food_id)) {
            return $this->result(1, 'Invalid request or missing Food ID', null);
        }
        $foodDetails = $this->model->getByFoodId($json->food_id);
        if (!$foodDetails) {
            return $this->result(1, 'No details found for this food ID', null);
        }
        return $this->result(0, 'Food details retrieved successfully', $foodDetails);
    }
}
