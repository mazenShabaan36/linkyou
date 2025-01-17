
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:linkyou_task/core/erorrs/failures.dart';
import 'package:linkyou_task/features/todos/domain/entities/task.dart';
import 'package:linkyou_task/features/todos/domain/repositories/task_repository.dart';
import 'package:linkyou_task/features/todos/presentation/bloc/bloc/task_bloc.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';


class MockTaskRepository extends Mock implements TaskRepository {}

void main() {
  late TaskBloc taskBloc;
  late MockTaskRepository mockTaskRepository;

  setUp(() {
    mockTaskRepository = MockTaskRepository();
    taskBloc = TaskBloc(taskRepository: mockTaskRepository, userId: 1);
  });

  final tTasks = [
    Tasks(id: 1, todo: 'Task 1', completed: false, userId: 1),
    Tasks(id: 2, todo: 'Task 2', completed: true, userId: 1),
  ];

  blocTest<TaskBloc, TaskState>(
    'emits [TaskLoading, TaskLoaded] when FetchTasksEvent is added',
    build: () {
      when(mockTaskRepository.getTasks(1, 10, 0))
          .thenAnswer((_) async => Right(tTasks));
      return taskBloc;
    },
    act: (bloc) => bloc.add(FetchTasksEvent()),
    expect: () => [
      TaskLoading(),
      TaskPaginated(tasks: tTasks, hasReachedMax: false),
    ],
  );

  blocTest<TaskBloc, TaskState>(
    'emits [TaskLoading, TaskError] when FetchTasksEvent fails',
    build: () {
      when(mockTaskRepository.getTasks(1, 10, 0))
          .thenAnswer((_) async => const Left(ServerFailuer(message: 'Failed')));
      return taskBloc;
    },
    act: (bloc) => bloc.add(FetchTasksEvent()),
    expect: () => [
      TaskLoading(),
      TaskError(message: 'Failed'),
    ],
  );
}