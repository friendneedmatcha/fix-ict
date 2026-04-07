import 'package:flutter/material.dart';
import 'package:frontend/models/userModel.dart';
import 'package:frontend/services/authService.dart';

class AuthProvider extends ChangeNotifier {
  // varible instanace
  Usermodel? _userdata;
  bool _loading = false;
  bool _isAuthenticate = false;
  String? _error;

  // method

  Usermodel? get userdata => _userdata;
  bool get isLoading => _loading;
  bool get isAuthenticate => _isAuthenticate;
  String? get error => _error;

  final _authService = AuthService();

  void updateUserData(Usermodel newUser) {
    _userdata = newUser;
    notifyListeners(); 
  }

  Future<bool> login(Usermodel user) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _userdata = await _authService.login(user);
      _isAuthenticate = true;
      return true;
    } catch (e) {
      _error = e.toString();
      _isAuthenticate = false;
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> register(Usermodel user) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _userdata = await _authService.register(user);
      _isAuthenticate = true;
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> logout() async {
    _loading = true;
    notifyListeners();

    try {
      await _authService.logout();
    } finally {
      _userdata = null;
      _isAuthenticate = false;
      _loading = false;
      notifyListeners();
    }
  }
}
