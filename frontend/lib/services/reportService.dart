import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/reportModel.dart';
import 'package:frontend/services/authService.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportService {
  final dio = Dio();
  final _authService = AuthService();
  final String? _apiUrl = dotenv.env['API_URL'] ?? "http://10.5.55.154:3038";

  ReportService() {
    dio.interceptors.add(
      InterceptorsWrapper(
        onError: (DioException error, ErrorInterceptorHandler handler) async {
          if (error.response?.statusCode == 401) {
            final newToken = await _authService.refreshAccessToken();
            if (newToken != null) {
              error.requestOptions.headers['Authorization'] =
                  'Bearer $newToken';
              final response = await dio.fetch(error.requestOptions);
              return handler.resolve(response);
            }
          }
          return handler.next(error);
        },
      ),
    );
  }

  Future<List<ReportModel>> getTopFive() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      final res = await dio.get(
        "$_apiUrl/report/top",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (res.statusCode == 200) {
        return (res.data as List)
            .map((item) => ReportModel.fromJson(item))
            .toList();
      }
      throw Exception('Failed to load reports');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to load reports');
    }
  }

  Future<List<ReportModel>> getAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      final res = await dio.get(
        "$_apiUrl/report",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (res.statusCode == 200) {
        return (res.data as List)
            .map((item) => ReportModel.fromJson(item))
            .toList();
      }
      throw Exception('Failed to load reports');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to load reports');
    }
  }

  Future<void> updateReport({
    required int id,
    required String status,
    required String note,
    required int updatedBy,
    XFile? imageFile,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      Map<String, dynamic> map = {
        'status': status,
        'note': note,
        'updatedBy': updatedBy.toString(),
      };

      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes();
        map['file'] = MultipartFile.fromBytes(bytes, filename: imageFile.name);
      }

      final formData = FormData.fromMap(map);

      await dio.patch(
        "$_apiUrl/report/$id",
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Update failed');
    }
  }

  Future<ReportModel> createReport(
    ReportModel report, {
    File? imageFile,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      Map<String, dynamic> map = {
        "title": report.title,
        "location": report.location,
        "priority": report.priority,
        "description": report.description,
        "userId": report.userId,
        "categoryId": report.categoryId,
      };

      if (imageFile != null) {
        map["file"] = await MultipartFile.fromFile(
          imageFile.path,
          filename: imageFile.path.split('/').last,
        );
      }

      FormData formData = FormData.fromMap(map);

      final res = await dio.post(
        "$_apiUrl/report",
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        return ReportModel.fromJson(res.data['data']);
      }

      throw Exception("Create report failed");
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Create report failed');
    }
  }

  Future<ReportModel> getById(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      final res = await dio.get(
        "$_apiUrl/report/$id",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (res.statusCode == 200) {
        return ReportModel.fromJson(res.data);
      }

      throw Exception('Failed to load report');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to load report');
    }
  }
}
