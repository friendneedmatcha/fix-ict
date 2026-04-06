import 'package:flutter/material.dart';
import 'package:frontend/models/reportModel.dart';
import 'package:frontend/services/reportService.dart';
import 'package:image_picker/image_picker.dart';

class ReportProvider extends ChangeNotifier {
  List<ReportModel> _topFive = [];
  bool _loading = false;
  String? _error;

  List<ReportModel> get topFive => _topFive;
  bool get isLoading => _loading;
  String? get error => _error;

  final _reportService = ReportService();

  Future<void> fetchTopFive() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _topFive = await _reportService.getTopFive();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  List<ReportModel> _reports = [];
  List<ReportModel> get reports => _reports;

  Future<void> fetchAll() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _reports = await _reportService.getAll();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<bool> updateReport({
    required int id,
    required String status,
    required String note,
    required int updatedBy,
    XFile? imageFile,
  }) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      await _reportService.updateReport(
        id: id,
        status: status,
        note: note,
        updatedBy: updatedBy,
        imageFile: imageFile,
      );
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
