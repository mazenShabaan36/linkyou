import 'package:dartz/dartz.dart';

import '../../../../core/erorrs/failures.dart';
import '../repositories/task_repository.dart';

class DeleteTaskUsecase {
  final TaskRepository taskRepository;

  DeleteTaskUsecase({required this.taskRepository});

  Future<Either<Failure, void>> call(int id, int userId) async =>
      await taskRepository.deleteTask(id, userId);
}