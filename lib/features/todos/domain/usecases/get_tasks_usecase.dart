import 'package:dartz/dartz.dart';
import 'package:linkyou_task/features/todos/domain/entities/task.dart';

import '../../../../core/erorrs/failures.dart';
import '../repositories/task_repository.dart';

class GetTasks {
  final TaskRepository taskRepository;

  GetTasks(this.taskRepository);

  Future<Either<Failure, List<Tasks>>> call(GetTasksParams params) async =>
      await taskRepository.getTasks(params.userId, params.limit, params.skip);
}

class GetTasksParams {
  final int userId;
  final int limit;
  final int skip;

  GetTasksParams({
    required this.userId,
    required this.limit,
    required this.skip,
  });
}
