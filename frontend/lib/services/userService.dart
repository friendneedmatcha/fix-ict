import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/userModel.dart';
import 'package:frontend/services/authService.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userservice {
  final dio = Dio();
  final _authService = AuthService();
  final String? _apiUrl = dotenv.env['API_URL'] ?? "http://10.5.55.154:3038";

  Userservice() {
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
  Future<Usermodel> updateProfile(
    int id,
    Usermodel user, {
    XFile? imageFile,
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      Map<String, dynamic> map = {
        "firstName": user.firstName,
        "lastName": user.lastName,
        "tel": user.tel,
        "email": user.email,
      };

      if (imageFile != null) {
        final bytes = await imageFile.readAsBytes();
        map["file"] = MultipartFile.fromBytes(bytes, filename: imageFile.name);
      }

      FormData formData = FormData.fromMap(map);

      final res = await dio.put(
        "$_apiUrl/user/$id",
        data: formData,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        return Usermodel.fromJson(res.data['data']);
      }
      throw Exception('Update failed');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Update failed');
    }
  }

  Future<List<Usermodel>> getAllUsers() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      final res = await dio.get(
        "$_apiUrl/user",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (res.statusCode == 200) {
        return (res.data as List)
            .map((item) => Usermodel.fromJson(item))
            .toList();
      }
      throw Exception('Failed to load users');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed to load users');
    }
  }

  Future<void> createUser(Usermodel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      final res = await dio.post(
        "$_apiUrl/user",
        data: user.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (res.statusCode != 200 && res.statusCode != 201) {
        throw Exception('Create user failed');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Create user failed');
    }
  }

  Future<Usermodel> updateUser(int id, Usermodel user) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      // ✅ ส่งเฉพาะ field ที่ backend รับ แทนการใช้ toJson()
      final Map<String, dynamic> data = {};
      if (user.firstName != null) data['firstName'] = user.firstName;
      if (user.lastName != null) data['lastName'] = user.lastName;
      if (user.email != null) data['email'] = user.email;
      if (user.tel != null) data['tel'] = user.tel;
      if (user.password != null) data['password'] = user.password;
      if (user.role != null) data['role'] = user.role;

      final res = await dio.put(
        "$_apiUrl/user/$id",
        data: data,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        return Usermodel.fromJson(res.data['data']);
      }
      throw Exception('Update failed');
    } on DioException catch (e) {
      print(e.response?.data);
      throw Exception(e.response?.data['message'] ?? 'Update failed');
    }
  }

  Future<void> deleteUser(int id) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      final res = await dio.delete(
        "$_apiUrl/user/$id",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (res.statusCode != 200 && res.statusCode != 201) {
        throw Exception('Delete failed');
      }
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Delete failed');
    }
  }
}
