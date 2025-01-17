import 'package:dartz/dartz.dart';
import 'package:linkyou_task/features/todos/domain/entities/task.dart';

import '../../../../core/erorrs/failures.dart';
import '../repositories/task_repository.dart';

class UpdateTaskUsecase {
  final TaskRepository taskRepository;
  UpdateTaskUsecase({required this.taskRepository});

  Future<Either<Failure, Tasks>> call(int id, bool completed,int userId) async =>
      await taskRepository.updateTask(id, completed, userId);
}