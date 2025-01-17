part of 'task_bloc.dart';

abstract class TaskState extends Equatable {
  const TaskState();

  @override
  List<Object> get props => [];
}

final class TaskInitial extends TaskState {}

class TaskLoading extends TaskState {}

class TaskLoaded extends TaskState {
  final List<Tasks> tasks;

  const TaskLoaded({required this.tasks});

  @override
  List<Object> get props => [tasks];
}

class TaskAdded extends TaskState {
  final Tasks task;

  const TaskAdded({required this.task});

  @override
  List<Object> get props => [task];
}

class TaskUpdated extends TaskState {
  final Tasks task;

  const TaskUpdated({required this.task});

  @override
  List<Object> get props => [task];
}

class TaskDeleted extends TaskState {
  final int id;

  const TaskDeleted({required this.id});

  @override
  List<Object> get props => [id];
}

class TaskError extends TaskState {
  final String message;

  const TaskError({required this.message});

  @override
  List<Object> get props => [message];
}

class TaskPaginated extends TaskState {
  final List<Tasks> tasks;
  final bool hasReachedMax;

  const TaskPaginated({required this.tasks, required this.hasReachedMax});

  @override
  List<Object> get props => [tasks, hasReachedMax];
}
