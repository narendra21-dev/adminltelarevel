<?php

namespace App\Http\Controllers\Admin;

use App\Http\Controllers\Controller;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;

class LoginController extends Controller
{
    public function showLoginPage()
    {
        return view('admin.auth.login');
    }


    public function login(Request $request)
    {
        $request->validate([
            'email' => 'required|email',
            'password' => 'required'
        ]);

        if (Auth::attempt($request->only('email', 'password'))) {

            // $user = Auth::user();
            // if ($user->hasRole('admin')) {
            return redirect()->route('admin.dashboard');
            // }
          
        }

        return back()->withErrors([
            'email' => 'The provided credentials do not match our records'
        ]);
    }
}
