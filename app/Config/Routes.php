<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
$routes->get('/', 'Home::index');

$routes->group('api', ['namespace' => 'App\Controllers\Api'], function ($routes) {
    $routes->group('auth', function ($routes) {
        $routes->match(['post'], 'register', 'AuthController::register');
        $routes->match(['post'], 'login', 'AuthController::login');
        $routes->match(['post'], 'change-password', 'AuthController::changePassword');
    });

    $routes->group('user', function ($routes) {
        $routes->get('/', 'UserController::index');
        $routes->post('create', 'UserController::create');
        $routes->get('get-user', 'UserController::getAllUser');
        $routes->post('update', 'UserController::updateUser');
        $routes->post('delete', 'UserController::deleteUser');
    });

    $routes->group('food', function ($routes) {
        $routes->get('/', 'FoodController::index');
        $routes->post('create', 'FoodController::create');
        $routes->post('update', 'FoodController::updateFood');
        $routes->post('delete', 'FoodController::deleteFood');
    });

    $routes->group('food-detail', function ($routes) {
        $routes->get('/', 'FoodDetailController::index');
        $routes->post('create', 'FoodDetailController::create');
        $routes->post('update', 'FoodDetailController::updateFood');
        $routes->post('delete', 'FoodDetailController::deleteFood');
        $routes->post('get-by-food-id', 'FoodDetailController::getByFoodId');
    });

    $routes->group('favourites', function($routes) {
        $routes->get('/', 'FavouriteController::index');
        $routes->post('show', 'FavouriteController::showFav');
        $routes->post('create', 'FavouriteController::create');
        $routes->post('update', 'FavouriteController::updateFav');
        $routes->post('delete', 'FavouriteController::deleteFav');
        $routes->post('by-user', 'FavouriteController::getByUserId');
    });
});
