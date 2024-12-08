<?php namespace App\Models;

use CodeIgniter\Model;

class FoodModel extends Model
{
    protected $table      = 'food';
    protected $primaryKey = 'food_id';

    protected $returnType     = 'array';
    protected $useSoftDeletes = false;

    protected $allowedFields = ['jenis', 'nama', 'kesulitan', 'images'];

    protected $useTimestamps = false;
    protected $validationRules    = [];
    protected $validationMessages = [];
    protected $skipValidation     = false;
}
