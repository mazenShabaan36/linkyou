import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:linkyou_task/core/erorrs/failures.dart';
import 'package:linkyou_task/features/auth/data/datasources/auth_remote_data_soucre.dart';
import 'package:linkyou_task/features/auth/domain/entities/user.dart';
import 'package:linkyou_task/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;

  AuthRepositoryImpl({required this.authRemoteDataSource});

  @override
  Future<Either<Failure, User>> login(String username, String password) async {
    try {
      final userAuth = await authRemoteDataSource.login(username, password);
      return Right(userAuth);
    } on DioException catch (e) {
      return Left(ServerFailuer(message: e.message ?? 'Dio Error occurred'));
    } catch (e) {
      return Left(ServerFailuer(message: e.toString()));
    }
  }
}
