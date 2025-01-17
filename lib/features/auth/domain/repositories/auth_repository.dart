import 'package:dartz/dartz.dart';

import '../../../../core/erorrs/failures.dart';
import '../entities/user.dart';


abstract class AuthRepository {
  Future<Either<Failure, User>> login(String username, String password);
}