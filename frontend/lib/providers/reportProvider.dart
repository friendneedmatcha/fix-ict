import 'dart:io';
import 'package:flutter/material.dart';
import 'package:frontend/models/reportModel.dart';
import 'package:frontend/services/reportService.dart';

class ReportProvider extends ChangeNotifier {
  ReportModel? _report;
  bool _loading = false;
  String? _error;

  ReportModel? get report => _report;
  bool get isLoading => _loading;
  String? get error => _error;

  final _reportService = ReportService();

  List<ReportModel> _reports = [];
  List<ReportModel> _reportTop = [];

  List<ReportModel> get reports => _reports;
  List<ReportModel> get reportTop => _reportTop;

  Future<bool> createReport(ReportModel report, {File? imageFile}) async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      final newReport = await _reportService.createReport(
        report,
        imageFile: imageFile,
      );

      _reports.add(newReport);

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

  Future<void> fetchAllReports() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _reports = await _reportService.getAllReports();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  Future<void> fetchTop() async {
    _loading = true;
    _error = null;
    notifyListeners();

    try {
      _reportTop = await _reportService.getTop();
    } catch (e) {
      _error = e.toString();
    } finally {
      _loading = false;
      notifyListeners();
    }
  }

  // Future<bool> updateReport(
  //   int id,
  //   ReportModel report, {
  //   File? imageFile,
  // }) async {
  //   _loading = true;
  //   _error = null;
  //   notifyListeners();

  //   try {
  //     final updated = await _reportService.updateReport(
  //       id,
  //       report,
  //       imageFile: imageFile,
  //     );

  //     final index = _reports.indexWhere((r) => r.userId == report.userId);
  //     if (index != -1) _reports[index] = updated;

  //     notifyListeners();
  //     return true;
  //   } catch (e) {
  //     _error = e.toString();
  //     return false;
  //   } finally {
  //     _loading = false;
  //     notifyListeners();
  //   }
  // }

  // Future<bool> deleteReport(int id) async {
  //   _error = null;
  //   notifyListeners();

  //   try {
  //     await _reportService.deleteReport(id);
  //     _reports.removeWhere((r) => r.userId == id.toString());
  //     notifyListeners();
  //     return true;
  //   } catch (e) {
  //     _error = e.toString();
  //     notifyListeners();
  //     return false;
  //   }
  // }
}
