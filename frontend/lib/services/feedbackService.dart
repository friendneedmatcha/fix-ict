import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/feedbackModel.dart';
import 'package:frontend/models/userModel.dart';
import 'package:frontend/services/authService.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Feedbackservice {
  final dio = Dio();
  final _authService = AuthService();
  final String? _apiUrl = dotenv.env['API_URL'] ?? "http://10.5.55.154:3038";

  Feedbackservice() {
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

  Future<Feedbackmodel> create(Feedbackmodel data) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('accessToken');

      final res = await dio.post(
        "$_apiUrl/report/${data.reportId}/feedback",
        data: {'rating': data.rating, 'comment': data.comment},
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (res.statusCode == 200 || res.statusCode == 201) {
        return Feedbackmodel.fromJson(res.data['data']);
      }
      throw Exception('create failed');
    } on DioException catch (e) {
      throw Exception(e.response?.data['message'] ?? 'create failed');
    }
  }
}
