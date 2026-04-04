import 'package:flutter/material.dart';
import 'package:frontend/models/userModel.dart';
import 'package:frontend/services/authService.dart';

class AuthProvider extends ChangeNotifier {
  Usermodel? _userdata;
  bool _loading = false;
  bool _isAuthenticate = false;
  String? _error;

  Usermodel? get userdata => _userdata;
  bool get isLoading => _loading;
  bool get isAuthenticate => _isAuthenticate;
  String? get error => _error;

  final _authService = AuthService();

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
}
