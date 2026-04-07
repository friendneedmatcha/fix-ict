import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/categoryModel.dart';
import 'package:frontend/services/authService.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CategoryService {
  final dio = Dio();
  final _authService = AuthService();
  final String? _apiUrl = dotenv.env['API_URL'] ?? "http://10.5.55.154:3038";

  CategoryService() {
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

  Future<List<Categorymodel>> getAll() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      final res = await dio.get(
        "$_apiUrl/category",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (res.statusCode == 200) {
        return (res.data['data'] as List)
            .map((item) => Categorymodel.fromJson(item))
            .toList();
      }
      throw Exception('Failed to load categories');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'Failed');
    }
  }
}
