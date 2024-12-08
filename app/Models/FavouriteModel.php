<?php namespace App\Models;

use CodeIgniter\Model;

class FavouriteModel extends Model
{
    protected $table      = 'favourite';
    protected $primaryKey = 'favourite_id';

    protected $returnType     = 'array';
    protected $useSoftDeletes = false;

    protected $allowedFields = ['food_id', 'user_id'];

    protected $useTimestamps = false;
    protected $validationRules    = [];
    protected $validationMessages = [];
    protected $skipValidation     = false;

    /**
     * Retrieve user's favourite foods along with user and food data.
     *
     * @param int $userId
     * @return array
     */
    public function getByUserId($userId)
    {
        return $this->select('favourite.*, users.name as user_name, users.email, food.nama as food_name, food.jenis, food.images')
                    ->join('users', 'users.user_id = favourite.user_id')
                    ->join('food', 'food.food_id = favourite.food_id')
                    ->where('favourite.user_id', $userId)
                    ->findAll();
    }
}
