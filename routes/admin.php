<?php

use App\Http\Controllers\Admin\CategoryController;
use App\Http\Controllers\Admin\DashboardController;
use App\Http\Controllers\Admin\LoginController;
use Illuminate\Support\Facades\Route;




Route::middleware(['admin_guest'])->prefix('/admin/')->name('admin.')->group(function () {
    // set in URL [ http://127.0.0.1:8000   "/admin/login "   ]
    Route::get('login', [LoginController::class, 'showLoginPage'])
        ->name('login.page'); // set in form " admin.login.page "

    Route::post('login', [LoginController::class, 'login'])->name('login');
});

Route::middleware(['admin_auth:admin,user'])->prefix('/admin/')->name('admin.')->group(function () {
    Route::get('admin/dashboard', [DashboardController::class, 'index'])->name('dashboard');
    Route::get('admin/logout', [DashboardController::class, 'logout'])->name('logout');
});

// Route::get('/admin-forms', [CategoryController::class, 'index']);
// Route::get('/admin-forms', [CategoryController::class, 'create']);
// Route::post('/admin-forms', [CategoryController::class, 'store']);
// Route::get('/admin-forms/{id}', [CategoryController::class, 'show']);
// Route::post('/admin-forms/{id}', [CategoryController::class, 'edit']);
// Route::put('/admin-forms/{id}', [CategoryController::class, 'update']);
// Route::delete('/admin-forms/{id}', [CategoryController::class, 'destroy']);
