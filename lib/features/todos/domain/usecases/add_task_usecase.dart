import 'package:dartz/dartz.dart';

import '../../../../core/erorrs/failures.dart';
import '../entities/task.dart';
import '../repositories/task_repository.dart';

class AddTaskUseCase {
  final TaskRepository taskRepository;
  AddTaskUseCase(this.taskRepository);

  Future<Either<Failure, Tasks>> call(String todo, bool completed,int userId) async =>
      await taskRepository.addTask(todo, completed, userId);
}