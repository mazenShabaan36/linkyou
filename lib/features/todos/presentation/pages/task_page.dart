import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:linkyou_task/features/todos/presentation/widgets/add_task_dialog.dart';

import '../bloc/bloc/task_bloc.dart';

class TaskPage extends StatelessWidget {
  const TaskPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Tasks')),
      body: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          if (state is TaskLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is TaskPaginated) {
            return NotificationListener<ScrollNotification>(
              onNotification: (notification) {
                if (notification is ScrollEndNotification &&
                    notification.metrics.pixels ==
                        notification.metrics.maxScrollExtent &&
                    !state.hasReachedMax) {
                  context.read<TaskBloc>().add(
                        LoadMoreTasksEvent(limit: 10, skip: state.tasks.length),
                      );
                }
                return true;
              },
              child: ListView.builder(
                itemCount: state.tasks.length + (state.hasReachedMax ? 0 : 1),
                itemBuilder: (context, index) {
                  if (index < state.tasks.length) {
                    final task = state.tasks[index];
                    return ListTile(
                      title: Text(task.todo),
                      trailing: Checkbox(
                        value: task.completed,
                        onChanged: (value) {
                          context.read<TaskBloc>().add(
                                UpdateTaskEvent(
                                  id: task.id,
                                  completed: value!,
                                ),
                              );
                        },
                      ),
                      onLongPress: () {
                        context
                            .read<TaskBloc>()
                            .add(DeleteTaskEvent(id: task.id));
                      },
                    );
                  } else {
                    return const Padding(
                      padding: EdgeInsets.all(16.0),
                      child: Center(child: CircularProgressIndicator()),
                    );
                  }
                },
              ),
            );
          } else if (state is TaskError) {
            return Center(child: Text(state.message));
          } else {
            return const Center(child: Text('No tasks found'));
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showAddTaskDialog(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTaskDialog(BuildContext context) {
    final TextEditingController controller = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AddTaskDialog(controller: controller);
      },
    );
  }
}
