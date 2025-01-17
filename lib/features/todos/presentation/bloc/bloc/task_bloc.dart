import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:linkyou_task/core/di/service_locator.dart';
import 'package:linkyou_task/features/todos/domain/entities/task.dart';

import '../../../domain/repositories/task_repository.dart';

part 'task_event.dart';
part 'task_state.dart';

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  final TaskRepository taskRepository;
  final int userId;
  int _skip = 0;
  final int _limit = 10;
  bool _hasReachedMax = false;
  TaskBloc({required this.taskRepository, required this.userId})
      : super(TaskInitial()) {
    on<FetchTasksEvent>(_onFetchTasks);
    on<LoadMoreTasksEvent>(_onLoadMoreTasks);
    on<AddTaskEvent>(_onAddTask);
    on<UpdateTaskEvent>(_onUpdateTask);
    on<DeleteTaskEvent>(_onDeleteTask);
  }
  void _onFetchTasks(FetchTasksEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    _skip = 0;
    _hasReachedMax = false;
    final localTasks = getIt<Box<Tasks>>().values.toList();
    if (localTasks.isNotEmpty) {
      emit(TaskPaginated(tasks: localTasks, hasReachedMax: false));
    }
    final result = await taskRepository.getTasks(userId, _limit, _skip);
    result.fold(
      (failure) => emit(TaskError(message: failure.message)),
      (tasks) {
        _skip += tasks.length;
        emit(TaskPaginated(tasks: tasks, hasReachedMax: tasks.length < _limit));
      },
    );
  }

  void _onLoadMoreTasks(
      LoadMoreTasksEvent event, Emitter<TaskState> emit) async {
    if (_hasReachedMax) return;

    final result = await taskRepository.getTasks(userId, _limit, _skip);
    result.fold(
      (failure) => emit(TaskError(message: failure.message)),
      (tasks) {
        _skip += tasks.length;
        _hasReachedMax = tasks.length < _limit;
        final currentTasks = (state as TaskPaginated).tasks;
        emit(TaskPaginated(
          tasks: currentTasks + tasks,
          hasReachedMax: _hasReachedMax,
        ));
      },
    );
  }

  void _onAddTask(AddTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final result =
        await taskRepository.addTask(event.todo, event.completed, userId);
    result.fold(
      (failure) => emit(TaskError(message: failure.message)),
      (task) => emit(TaskAdded(task: task)),
    );
  }

  void _onUpdateTask(UpdateTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final result =
        await taskRepository.updateTask(event.id, event.completed, userId);
    result.fold((failure) => emit(TaskError(message: failure.message)), (task) {
      emit(TaskUpdated(task: task));
      add(FetchTasksEvent());
    });
  }

  void _onDeleteTask(DeleteTaskEvent event, Emitter<TaskState> emit) async {
    emit(TaskLoading());
    final result = await taskRepository.deleteTask(event.id, userId);
    result.fold((failure) => emit(TaskError(message: failure.message)), (_) {
      emit(TaskDeleted(id: event.id));
      add(FetchTasksEvent());
    });
  }
}
