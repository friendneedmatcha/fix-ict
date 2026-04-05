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
