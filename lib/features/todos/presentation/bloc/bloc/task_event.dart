part of 'task_bloc.dart';

abstract class TaskEvent extends Equatable {
  const TaskEvent();

  @override
  List<Object> get props => [];
}

class FetchTasksEvent extends TaskEvent {}

class AddTaskEvent extends TaskEvent {
  final String todo;
  final bool completed;

  const AddTaskEvent({
    required this.todo,
    required this.completed,
  });

  @override
  List<Object> get props => [todo, completed];
}

class UpdateTaskEvent extends TaskEvent {
  final int id;
  final bool completed;

  const UpdateTaskEvent({
    required this.id,
    required this.completed,
  });

  @override
  List<Object> get props => [id, completed];
}

class DeleteTaskEvent extends TaskEvent {
  final int id;

  const DeleteTaskEvent({
    required this.id,
  });

  @override
  List<Object> get props => [id];
}

class LoadMoreTasksEvent extends TaskEvent {
  final int limit;
  final int skip;

  const LoadMoreTasksEvent({required this.limit, required this.skip});

  @override
  List<Object> get props => [limit, skip];
}
