import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:linkyou_task/core/erorrs/failures.dart';
import 'package:linkyou_task/features/todos/data/data_sources/tasks_remote_data_sources.dart';
import 'package:linkyou_task/features/todos/domain/repositories/task_repository.dart';
import 'package:linkyou_task/features/todos/domain/entities/task.dart';

class TaskRepositoriesImpl implements TaskRepository {
  TasksRemoteDataSources tasksRemoteDataSources;
  final Box<Tasks> taskBox;
  final int userId;
  TaskRepositoriesImpl(
      {required this.tasksRemoteDataSources, required this.taskBox,required this.userId});
  @override
  Future<Either<Failure, Tasks>> addTask(
      String todo, bool completed, int userId) async {
    try {
      final remoteTasks =
          await tasksRemoteDataSources.addTask(todo, completed, userId);
      await taskBox.add(remoteTasks);
      return Right(remoteTasks);
    } on DioException catch (e) {
      return Left(ServerFailuer(message: e.message ?? 'An error occurred'));
    } catch (e) {
      return Left(ServerFailuer(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteTask(int id, int userId) async {
    try {
      final remoteTasks = await tasksRemoteDataSources.deleteTask(id, userId);
      return Right(remoteTasks);
    } on DioException catch (e) {
      return Left(ServerFailuer(message: e.message ?? 'An Error Occured'));
    } catch (e) {
      return Left(ServerFailuer(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<Tasks>>> getTasks(
      int userId, int limit, int skip) async {
    try {
      final remoteTasks =
          await tasksRemoteDataSources.getTasks(userId, limit, skip);
      await taskBox.clear();
      await taskBox.addAll(remoteTasks);
      return Right(remoteTasks);
    } catch (e) {
      return Left(ServerFailuer(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, Tasks>> updateTask(
      int id, bool completed, int userId) async {
    try {
      final remoteTasks =
          await tasksRemoteDataSources.updateTask(id, completed, userId);
      return Right(remoteTasks);
    } on DioException catch (e) {
      return Left(ServerFailuer(message: e.message ?? 'An Error Occured'));
    } catch (e) {
      return Left(ServerFailuer(message: e.toString()));
    }
  }
}
