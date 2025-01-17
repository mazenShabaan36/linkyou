import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linkyou_task/core/erorrs/failures.dart';

import 'package:linkyou_task/features/todos/domain/entities/task.dart';
import 'package:linkyou_task/features/todos/domain/repositories/task_repository.dart';
import 'package:linkyou_task/features/todos/domain/usecases/delete_task_usecase.dart';
import 'package:mockito/mockito.dart';

class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late DeleteTaskUsecase usecase;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    usecase = DeleteTaskUsecase(taskRepository: mockTaskRepository);
  });

  final tTasks = [
    Tasks(id: 1, todo: 'Task 1', completed: false, userId: 1),
    Tasks(id: 2, todo: 'Task 2', completed: true, userId: 1),
  ];

  test('should delete tasks from the repository', () async {
    // Arrange
    when(mockTaskRepository.deleteTask(1, 10))
        .thenAnswer((_) async => const Right(null));

    // Act
    final result = await usecase(1, 10);

    // Assert
    expect(result, Right(tTasks));
    verify(mockTaskRepository.deleteTask(1, 10));
    verifyNoMoreInteractions(mockTaskRepository);
  });

  test('should return a failure when the repository fails', () async {
    // Arrange
    when(mockTaskRepository.deleteTask(1, 10))
        .thenAnswer((_) async => const Left(ServerFailuer(message: 'Failed')));

    // Act
    final result = await usecase(1, 10);

    // Assert
    expect(result, const Left(ServerFailuer(message: 'Failed')));
    verify(mockTaskRepository.deleteTask(1, 10));
    verifyNoMoreInteractions(mockTaskRepository);
  });
}
