import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/userModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  final dio = Dio();
  final String? _apiUrl = dotenv.env['API_URL'] ?? "http://10.5.55.154:3038";

  Future<Usermodel> login(Usermodel user) async {
    // print(_apiUrl);
    try {
      final res = await dio.post(
        "$_apiUrl/auth/login",
        data: {'email': user.email, 'password': user.password},
        // data: user.toJson(),
      );
      print(res.data['data']['token']['accessToken']);
      print(res.data['data']['token']['refreshToken']);
      // print(res);
      if (res.statusCode == 201) {
        final prefs = await SharedPreferences.getInstance();

        await prefs.setString(
          'accessToken',
          res.data['data']['token']['accessToken'],
        );
        await prefs.setString(
          'refreshToken',
          res.data['data']['token']['refreshToken'],
        );

        return Usermodel.fromJson(res.data['data']['user']);
      } else {
        throw Exception('Login failed ${res.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Login failed');
    }
  }

  Future<Usermodel> register(Usermodel user) async {
    try {
      final res = await dio.post("$_apiUrl/auth/register", data: user.toJson());
      print(res.data);
      if (res.statusCode == 201 || res.statusCode == 200) {
        final prefs = await SharedPreferences.getInstance();
        if (res.data['data'] != null && res.data['data']['token'] != null) {
          await prefs.setString(
            'accessToken',
            res.data['data']['token']['accessToken'],
          );
          await prefs.setString(
            'refreshToken',
            res.data['data']['token']['refreshToken'],
          );
        }
        // ---------------------------------------
        return Usermodel.fromJson(res.data['data']['user']);
      } else {
        throw Exception('Registration failed');
      }
    } on DioException catch (e) {
      print(e.response?.data);
      throw Exception(e.response?.data['message'] ?? 'Registration failed');
    }
  }

  Future<void> logout() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refreshToken');

      await dio.post(
        "$_apiUrl/auth/logout",
        options: Options(headers: {'Authorization': 'Bearer $refreshToken'}),
      );
    } catch (e) {
      print("Server logout error: $e");
    } finally {
      final prefs = await SharedPreferences.getInstance();
      await prefs.clear();
    }
  }

  Future<String?> refreshAccessToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString('refreshToken');
      if (refreshToken == null) return null;

      final res = await dio.post(
        "$_apiUrl/auth/refresh",
        options: Options(headers: {'Authorization': 'Bearer $refreshToken'}),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        final newToken = res.data['accessToken'];
        await prefs.setString('accessToken', newToken);
        return newToken;
      }
      return null;
    } catch (e) {
      return null;
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
