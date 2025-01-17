import 'package:dartz/dartz.dart';
import 'package:linkyou_task/core/erorrs/failures.dart';
import 'package:linkyou_task/features/todos/domain/entities/task.dart';

abstract class TaskRepository {
  Future<Either<Failure,List<Tasks>>> getTasks(int userId,int limit, int skip);
  Future<Either<Failure,Tasks>> addTask(String todo, bool completed,int userId);
  Future<Either<Failure,Tasks>> updateTask(int id, bool completed,int userId);
  Future<Either<Failure,void>> deleteTask(int id,int userId);
}
