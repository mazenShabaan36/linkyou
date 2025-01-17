import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'task.g.dart';

@HiveType(typeId: 0)
class Tasks extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String todo;
  @HiveField(2)
  final bool completed;
  @HiveField(3)
  final int userId;

  const Tasks({
    required this.id,
    required this.todo,
    required this.completed,
    required this.userId,
  });
  @override
  List<Object?> get props => [id, todo, completed, userId];
}
