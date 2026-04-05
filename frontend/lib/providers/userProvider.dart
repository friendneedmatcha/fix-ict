import 'package:flutter/material.dart';
import 'package:frontend/models/userModel.dart';
import 'package:frontend/services/authService.dart';
import 'package:frontend/services/userService.dart';
import 'package:image_picker/image_picker.dart';

class Userprovider extends ChangeNotifier {
  Usermodel? _userdata;
  bool _loading = false;
  bool _isAuthenticate = false;
  String? _error;

  Usermodel? get userdata => _userdata;
  bool get isLoading => _loading;
  bool get isAuthenticate => _isAuthenticate;
  String? get error => _error;

  final _userService = Userservice();

  Future<bool> updateProfile(Usermodel user, {XFile? imageFile}) async {
    _loading = true;
    notifyListeners();

    try {
      final updatedUser = await _userService.updateProfile(
        user.id!,
        user,
        imageFile: imageFile,
      );

      _userdata = updatedUser;

      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  List<Usermodel> _users = [];
  List<Usermodel> get users => _users;

  Future<void> fetchAllUsers() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _users = await _userService.getAllUsers();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> createUser(Usermodel user) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      await _userService.createUser(user);
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> updateUser(int id, Usermodel user) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final updated = await _userService.updateUser(id, user);
      final index = _users.indexWhere((u) => u.id == id);
      if (index != -1) _users[index] = updated;
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      return false;
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> deleteUser(int id) async {
    _error = null;

    try {
      await _userService.deleteUser(id);
      _users.removeWhere((u) => u.id == id);
      notifyListeners();
      return true;
    } catch (e) {
      _error = e.toString();
      notifyListeners();
      return false;
    }
  }
}
