import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:frontend/models/userModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Userservice {
  final dio = Dio();
  final String? _apiUrl = dotenv.env['API_URL'] ?? "http://10.5.55.154:3038";

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
}
