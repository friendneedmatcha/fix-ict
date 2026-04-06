import 'package:flutter/material.dart';
import 'package:frontend/models/feedbackModel.dart';
import 'package:frontend/models/userModel.dart';
import 'package:frontend/services/authService.dart';
import 'package:frontend/services/feedbackService.dart';
import 'package:frontend/services/userService.dart';
import 'package:image_picker/image_picker.dart';

class Feedbackprovider extends ChangeNotifier {
  Feedbackmodel? _feedback;
  bool _loading = false;
  String? _error;

  Feedbackmodel? get feedback => _feedback;
  bool get isLoading => _loading;
  String? get error => _error;

  final _feedbackService = Feedbackservice();

  Future<bool> create(Feedbackmodel data) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _feedback = await _feedbackService.create(data);
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
