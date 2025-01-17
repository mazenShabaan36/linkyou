import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linkyou_task/core/erorrs/failures.dart';
import 'package:linkyou_task/features/todos/domain/entities/task.dart';
import 'package:linkyou_task/features/todos/domain/repositories/task_repository.dart';
import 'package:linkyou_task/features/todos/domain/usecases/add_task_usecase.dart';
import 'package:mockito/mockito.dart';

class MockTaskRepository extends Mock implements TaskRepository {
  void main() {
    late AddTaskUseCase addTaskUseCase;
    late MockTaskRepository mockTaskRepository;

    setUp(() {
      mockTaskRepository = MockTaskRepository();
      addTaskUseCase = AddTaskUseCase(mockTaskRepository);
    });

    final tTasks = Tasks(id: 1, todo: 'Task 1', completed: false, userId: 1);
    test('should add tasks to the repository', () async {
      // Arrange
      when(mockTaskRepository.addTask('Task 1', false, 1))
          .thenAnswer((_) async => Right(tTasks));

      // Act
      final result = await addTaskUseCase('Task 1', false, 1);

      // Assert
      expect(result, Right(tTasks));
      verify(mockTaskRepository.addTask('Task 1', false, 1));
      verifyNoMoreInteractions(mockTaskRepository);
    });

    test('should return a failure when the repository fails', () async {
      // Arrange
      when(mockTaskRepository.addTask('Task 1', false, 1)).thenAnswer(
          (_) async => const Left(ServerFailuer(message: 'Failed')));

      // Act
      final result =
          await AddTaskUseCase(mockTaskRepository).call('Task 1', false, 1);

      // Assert
      expect(result, const Left(ServerFailuer(message: 'Failed')));
      verify(mockTaskRepository.addTask('Task 1', false, 1));
      verifyNoMoreInteractions(mockTaskRepository);
    });
  }
}
