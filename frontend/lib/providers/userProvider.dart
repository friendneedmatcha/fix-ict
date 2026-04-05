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
}
