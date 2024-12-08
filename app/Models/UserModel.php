<?php namespace App\Models;

use CodeIgniter\Model;

class UserModel extends Model
{
    protected $table      = 'users';
    protected $primaryKey = 'user_id';

    protected $returnType     = 'array';
    protected $useSoftDeletes = false;

    protected $allowedFields = ['name', 'code', 'password', 'phone', 'email', 'token'];

    protected $useTimestamps = false;
    protected $validationRules    = [];
    protected $validationMessages = [];
    protected $skipValidation     = false;

    protected $beforeInsert = ['beforeInsert'];
    protected $beforeUpdate = ['beforeUpdate'];

    protected function beforeInsert(array $data)
    {
        $data = $this->passwordHash($data);
        return $data;
    }

    protected function beforeUpdate(array $data)
    {
        $data = $this->passwordHash($data);
        return $data;
    }

    protected function passwordHash(array $data)
    {
        if (isset($data['data']['password']))
        {
            $data['data']['password'] = password_hash($data['data']['password'], PASSWORD_DEFAULT);
        }
        return $data;
    }

    public function getDataById($id)
    {
        return $this->asArray()
                    ->where([$this->primaryKey => $id])
                    ->first();
    }

    public function getDataByToken($token)
    {
        return $this->asArray()
                    ->where(['token' => $token])
                    ->first();
    }

    public function changePassword($id, $newPassword)
    {
        return $this->update($id, ['password' => $newPassword]);
    }

    public function login($code, $password)
    {
        $user = $this->asArray()
                     ->where(['code' => $code])
                     ->first();

        if ($user && password_verify($password, $user['password'])) {
            unset($user['password']); // It's a good practice to unset the password before returning
            return $user;
        }

        return false;
    }
}
