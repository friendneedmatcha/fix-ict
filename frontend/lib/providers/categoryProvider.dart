import 'package:flutter/material.dart';
import 'package:frontend/models/categoryModel.dart';
import 'package:frontend/models/userModel.dart';
import 'package:frontend/services/authService.dart';
import 'package:frontend/services/categoryService.dart';
import 'package:frontend/services/reportService.dart';

class Categoryprovider extends ChangeNotifier {
  // varible instanace
  List<Categorymodel> _catdata = [];
  bool _loading = false;
  String? _error;

  // method

  List<Categorymodel> get categories => _catdata;
  bool get isLoading => _loading;
  String? get error => _error;

  // final _authService = AuthService();
  final _catService = Categoryservice();

  // void updateUserData(Usermodel newUser) {
  //   _userdata = newUser;
  //   notifyListeners();
  // }

  Future<void> getAll() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _catdata = await _catService.getAll();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Future<bool> register(Usermodel user) async {
  //   _loading = true;
  //   _error = null;
  //   notifyListeners();

  //   try {
  //     _userdata = await _authService.register(user);
  //     _isAuthenticate = true;
  //     return true;
  //   } catch (e) {
  //     _error = e.toString();
  //     return false;
  //   } finally {
  //     _loading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<void> logout() async {
  //   _loading = true;
  //   notifyListeners();

  //   try {
  //     await _authService.logout();
  //   } finally {
  //     _userdata = null;
  //     _isAuthenticate = false;
  //     _loading = false;
  //     notifyListeners();
  //   }
  // }
}
