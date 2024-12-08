<?php namespace App\Controllers\Api;

use CodeIgniter\RESTful\ResourceController;
use App\Models\FavouriteModel;

class FavouriteController extends ResourceController
{
    protected $modelName = 'App\Models\FavouriteModel';
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
        $favourites = $this->model->findAll();
        return $this->result(0, 'List of all favourites', $favourites);
    }

    public function showFav()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json || !isset($json->favourite_id)) {
            return $this->result(1, 'Invalid request or missing Favourite ID', null);
        }
        $favourite = $this->model->find($json->favourite_id);
        if (!$favourite) {
            return $this->result(1, 'Favourite not found', null);
        }
        return $this->result(0, 'Details of favourite', $favourite);
    }

    public function create()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json) {
            return $this->result(1, 'Invalid request', null);
        }
        $data = [
            'food_id' => $json->food_id ?? null,
            'user_id' => $json->user_id ?? null
        ];
        if ($this->model->insert($data) === false) {
            return $this->result(1, 'Failed to add favourite', $this->model->errors());
        }
        return $this->result(0, 'Favourite added successfully', null);
    }

    public function updateFav()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json || !isset($json->favourite_id)) {
            return $this->result(1, 'Invalid request or missing Favourite ID', null);
        }
        $data = [
            'food_id' => $json->food_id ?? null,
            'user_id' => $json->user_id ?? null
        ];
        if ($this->model->update($json->favourite_id, $data) === false) {
            return $this->result(1, 'Failed to update favourite', $this->model->errors());
        }
        return $this->result(0, 'Favourite updated successfully', null);
    }

    public function deleteFav()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        if (!$json || !isset($json->favourite_id)) {
            return $this->result(1, 'Invalid request or missing Favourite ID', null);
        }
        if (!$this->model->delete($json->favourite_id)) {
            return $this->result(1, 'Failed to delete favourite or favourite not found', null);
        }
        return $this->result(0, 'Favourite deleted successfully', null);
    }

    public function getByUserId()
    {
        $this->handleCORS();
        $json = $this->request->getJSON();
        $userId = $json->user_id; // Or get from POST data as required
        if (!$userId) {
            return $this->result(1, 'User ID is required', null);
        }

        $favourites = $this->model->getByUserId($userId);
        if (empty($favourites)) {
            return $this->result(0, 'No favourites found for this user', null);
        }

        return $this->result(0, 'Favourites retrieved successfully', $favourites);
    }
}
