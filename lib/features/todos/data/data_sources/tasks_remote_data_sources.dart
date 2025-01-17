import 'package:dio/dio.dart';
import 'package:hive/hive.dart';
import 'package:linkyou_task/core/erorrs/failures.dart';
import 'package:linkyou_task/core/utils/api_constant.dart';
import 'package:linkyou_task/features/todos/domain/entities/task.dart';

abstract class TasksRemoteDataSources {
  Future<List<Tasks>> getTasks(int userId, int limit, int skip);
  Future<Tasks> addTask(String todo, bool completed, int userId);
  Future<Tasks> updateTask(int id, bool completed, int userId);
  Future<void> deleteTask(int id, int userId);
}

class TasksRemoteDataSourceImpl implements TasksRemoteDataSources {
  final Dio dio;
  final Box<Tasks> taskBox;

  TasksRemoteDataSourceImpl({required this.dio, required this.taskBox});
  @override
  Future<Tasks> addTask(String todo, bool completed, int userId) async {
    try {
      final response = await dio.post(ApiConstants.todosAdd,
          data: {'todo': todo, 'completed': completed, 'userId': userId});
      if (response.statusCode == 201) {
        final task = Tasks(
          id: response.data['id'],
          todo: response.data['todo'],
          completed: response.data['completed'],
          userId: response.data['userId'],
        );
        return task;
      } else {
        throw ServerFailuer(message: response.data['message']);
      }
    } catch (e) {
      throw ServerFailuer(message: e.toString());
    }
  }

  @override
  Future<void> deleteTask(int id, int userId) async {
    try {
      final response = await dio.delete('${ApiConstants.todosDelete}$id');
      if (response.statusCode == 200) {
        return;
      } else {
        throw ServerFailuer(message: response.data['message']);
      }
    } catch (e) {
      throw ServerFailuer(message: e.toString());
    }
  }

  @override
  Future<List<Tasks>> getTasks(int userId, int limit, int skip) async {
    final response =
        await dio.get('${ApiConstants.todosUser}/$userId', queryParameters: {
      'limit': limit,
      'skip': skip,
    });
    if (response.statusCode == 200) {
      final tasks = (response.data['todos'] as List)
          .map((task) => Tasks(
                id: task['id'],
                todo: task['todo'],
                completed: task['completed'],
                userId: task['userId'],
              ))
          .toList();
      return tasks;
    } else {
      throw ServerFailuer(message: response.data['message']);
    }
  }

  @override
  Future<Tasks> updateTask(int id, bool completed, int userId) async {
    try {
      final response = await dio.put('${ApiConstants.todosUpdate}$id',
          data: {'completed': completed});
      if (response.statusCode == 200) {
        final task = Tasks(
          id: response.data['id'],
          todo: response.data['todo'],
          completed: response.data['completed'],
          userId: response.data['userId'],
        );
        return task;
      } else {
        throw ServerFailuer(message: response.data['message']);
      }
    } catch (e) {
      throw ServerFailuer(message: e.toString());
    }
  }
}
