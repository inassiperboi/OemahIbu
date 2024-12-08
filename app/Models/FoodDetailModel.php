<?php namespace App\Models;

use CodeIgniter\Model;

class FoodDetailModel extends Model
{
    protected $table      = 'food_detail';
    protected $primaryKey = 'food_detail_id';

    protected $returnType     = 'array';
    protected $useSoftDeletes = false;

    protected $allowedFields = ['food_id', 'bahan', 'langkah', 'tips', 'bumbu', 'pelengkap', 'xs1', 'xs2','xs3'];

    protected $useTimestamps = false;
    protected $validationRules    = [];
    protected $validationMessages = [];
    protected $skipValidation     = false;

     /**
     * Get food detail by food ID and join it with the food table.
     *
     * @param int $foodId
     * @return array
     */
    public function getByFoodId($foodId)
    {
        // Membangun query dengan builder
        $builder = $this->db->table('food'); // Memulai query pada tabel food
        $builder->select('food.*, food_detail.*'); // Memilih semua kolom dari food dan food_detail
        $builder->join('food_detail', 'food.food_id = food_detail.food_id', 'left'); // Menggunakan LEFT JOIN
        $builder->where('food.food_id', $foodId); // Menetapkan kondisi where untuk food.food_id

        // Menjalankan query dan mendapatkan hasilnya
        $result = $builder->get()->getResult();

        return $result;
    }
}
