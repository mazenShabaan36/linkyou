import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linkyou_task/core/erorrs/failures.dart';

import 'package:linkyou_task/features/todos/domain/entities/task.dart';
import 'package:linkyou_task/features/todos/domain/repositories/task_repository.dart';
import 'package:linkyou_task/features/todos/domain/usecases/get_tasks_usecase.dart';
import 'package:mockito/mockito.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late GetTasks usecase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = GetTasks(mockTaskRepository);
  });

  final tTasks = [
    Tasks(id: 1, todo: 'Task 1', completed: false, userId: 1),
    Tasks(id: 2, todo: 'Task 2', completed: true, userId: 1),
  ];

  test('should get tasks from the repository', () async {
    // Arrange
    when(mockTaskRepository.getTasks(1, 10, 0))
        .thenAnswer((_) async => Right(tTasks));

    // Act
    final result = await usecase(GetTasksParams(userId: 1, limit: 10, skip: 0));

    // Assert
    expect(result, Right(tTasks));
    verify(mockTaskRepository.getTasks(1, 10, 0));
    verifyNoMoreInteractions(mockTaskRepository);
  });

  test('should return a failure when the repository fails', () async {
    // Arrange
    when(mockTaskRepository.getTasks(1, 10, 0))
        .thenAnswer((_) async => const Left(ServerFailuer(message: 'Failed')));

    // Act
    final result = await usecase(GetTasksParams(userId: 1, limit: 10, skip: 0));

    // Assert
    expect(result, const Left(ServerFailuer(message: 'Failed')));
    verify(mockTaskRepository.getTasks(1, 10, 0));
    verifyNoMoreInteractions(mockTaskRepository);
  });
}
