import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/reportModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ReportService {
  final Dio dio = Dio();
  final String? _apiUrl = dotenv.env['API_URL'] ?? "http://10.5.55.154:3038";

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

  Future<List<ReportModel>> getAllReports() async {
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

      throw Exception("Fetch report failed");
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Fetch report failed');
    }
  }

  Future<List<ReportModel>> getTop() async {
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

      throw Exception("Fetch report failed");
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Fetch report failed');
    }
  }

  // Future<ReportModel> updateReport(
  //   int id,
  //   ReportModel report, {
  //   File? imageFile,
  // }) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final token = prefs.getString('accessToken');

  //     Map<String, dynamic> map = {};

  //     if (report.title != null) map['title'] = report.title;
  //     if (report.location != null) map['location'] = report.location;
  //     if (report.priority != null) map['priority'] = report.priority;
  //     if (report.description != null) map['description'] = report.description;
  //     if (report.userId != null) map['userId'] = report.userId;
  //     if (report.categoryId != null) map['categoryId'] = report.categoryId;

  //     if (imageFile != null) {
  //       map["file"] = await MultipartFile.fromFile(
  //         imageFile.path,
  //         filename: imageFile.path.split('/').last,
  //       );
  //     }

  //     FormData formData = FormData.fromMap(map);

  //     final res = await dio.put(
  //       "$_apiUrl/report/$id",
  //       data: formData,
  //       options: Options(
  //         headers: {
  //           'Authorization': 'Bearer $token',
  //           'Content-Type': 'multipart/form-data',
  //         },
  //       ),
  //     );

  //     if (res.statusCode == 200 || res.statusCode == 201) {
  //       return ReportModel.fromJson(res.data['data']);
  //     }

  //     throw Exception("Update report failed");
  //   } on DioException catch (e) {
  //     throw Exception(e.response?.data['message'] ?? 'Update report failed');
  //   }
  // }

  // Future<void> deleteReport(int id) async {
  //   try {
  //     final prefs = await SharedPreferences.getInstance();
  //     final token = prefs.getString('accessToken');

  //     final res = await dio.delete(
  //       "$_apiUrl/report/$id",
  //       options: Options(headers: {'Authorization': 'Bearer $token'}),
  //     );

  //     if (res.statusCode != 200 && res.statusCode != 201) {
  //       throw Exception("Delete failed");
  //     }
  //   } on DioException catch (e) {
  //     throw Exception(e.response?.data['message'] ?? 'Delete failed');
  //   }
  // }
}
