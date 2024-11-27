<?php

use App\Http\Controllers\Admin\CategoryController;
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return view('welcome');
});


Route::resource('category', CategoryController::class)->only([
    'index',
    'create',
    'store',
    'show',
    'edit',
    'update',
    'destroy'
]);
require __DIR__ . '/admin.php';
