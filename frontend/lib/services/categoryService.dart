import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/categoryModel.dart';

class Categoryservice {
  final dio = Dio();
  final String? _apiUrl = dotenv.env['API_URL'] ?? "http://10.5.55.154:3038";

  Future<List<Categorymodel>> getAll() async {
    // print(_apiUrl);
    try {
      final res = await dio.get(
        "$_apiUrl/category",
        // data: {'email': user.email, 'password': user.password},
        // data: user.toJson(),
      );
      print(res.data);
      // print(res);
      if (res.statusCode == 200) {
        final raw = res.data;
        List<dynamic> list;

        if (raw is List) {
          list = raw; // ถ้า return เป็น array ตรงๆ
        } else if (raw is Map && raw['data'] != null) {
          list = raw['data'] as List; // ถ้า return เป็น { data: [...] }
        } else {
          list = [];
        }

        return list
            .map((e) => Categorymodel.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        throw Exception('Login failed ${res.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Login failed');
    }
  }

  // Future<Usermodel> logout() async {
  //   try {
  //     final res = await dio.post(
  //       "$_apiUrl/auth/login",
  //       data: {'email': user.email, 'password': user.password},
  //     );
  //     print(res.data['data']['token']['accessToken']);
  //     print(res.data['data']['token']['refreshToken']);
  //     // print(res);
  //     if (res.statusCode == 201) {
  //       final prefs = await SharedPreferences.getInstance();

  //       await prefs.setString(
  //         'accessToken',
  //         res.data['data']['token']['accessToken'],
  //       );
  //       await prefs.setString(
  //         'refreshToken',
  //         res.data['data']['token']['refreshToken'],
  //       );

  //       return Usermodel.fromJson(res.data['data']['user']);
  //     } else {
  //       throw Exception('Login failed ${res.statusCode}');
  //     }
  //   } on DioException catch (e) {
  //     throw Exception(e.response?.data['message'] ?? 'Login failed');
  //   }
  // }
}
