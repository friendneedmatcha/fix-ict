import 'package:flutter/material.dart';
import 'package:frontend/models/categoryModel.dart';
import 'package:frontend/services/categoryService.dart';

class CategoryProvider extends ChangeNotifier {
  List<Categorymodel> _categories = [];
  bool _loading = false;
  String? _error;

  List<Categorymodel> get categories => _categories;
  bool get isLoading => _loading;
  String? get error => _error;

  final _categoryService = CategoryService();

  Future<void> fetchAll() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _categories = await _categoryService.getAll();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }
}
