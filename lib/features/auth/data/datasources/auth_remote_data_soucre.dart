import 'package:dio/dio.dart';
import 'package:linkyou_task/core/erorrs/failures.dart';
import 'package:linkyou_task/core/utils/api_constant.dart';
import 'package:linkyou_task/features/auth/domain/entities/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class AuthRemoteDataSource {
  Future<User> login(String username, String password);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final Dio dio;
  AuthRemoteDataSourceImpl({required this.dio});
  @override
  Future<User> login(String username, String password) async {
    try {
      final response = await dio.post(
        ApiConstants.loginUrl,
        data: {'username': username, 'password': password},
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      if (response.statusCode == 200) {
        final userData = response.data;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setInt('userId', userData['id']);
        return User(
          id: userData['id'],
          username: userData['username'],
          email: userData['email'],
          firstName: userData['firstName'],
          lastName: userData['lastName'],
          gender: userData['gender'],
          image: userData['image'],
          token: userData['accessToken'],
        );
      } else {
        throw const ServerFailuer(message: 'Invalid credentials');
      }
    } on DioException catch (e) {
      throw ServerFailuer(message: e.response?.data['message'] ?? 'Dio Error');
    } catch (e) {
      throw ServerFailuer(message: e.toString());
    }
  }
}
