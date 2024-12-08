<?php

namespace App\Commands;

use CodeIgniter\CLI\BaseCommand;
use CodeIgniter\CLI\CLI;

class StartCommand extends BaseCommand
{
    protected $group       = 'Custom';
    protected $name        = 'start';
    protected $description = 'Run the CodeIgniter server using php spark serve';

    public function run(array $params)
    {
        CLI::write('Running php spark serve...', 'green');

        // Path absolut ke file spark
        $sparkPath = realpath(__DIR__ . '/../../spark');
        
        if ($sparkPath === false || !file_exists($sparkPath)) {
            CLI::error('Could not find the spark file.');
            return;
        }

        // Dapatkan alamat IP dari komputer ini
        $ipAddress = getHostByName(getHostName());
        CLI::write("Web : http://$ipAddress:8080/", 'yellow');
        CLI::write("api : http://$ipAddress:8080/api", 'yellow');

        // Jalankan perintah php spark serve
        $command = "php \"$sparkPath\" serve --host 0.0.0.0";

        // Gunakan exec untuk menjalankan perintah
        exec($command, $output, $status);

        // Tampilkan output dari perintah php spark serve
        foreach ($output as $line) {
            CLI::write($line);
        }

        // Periksa apakah ada kesalahan
        if ($status !== 0) {
            CLI::error('Failed to start the server.');
        }
    }
}
