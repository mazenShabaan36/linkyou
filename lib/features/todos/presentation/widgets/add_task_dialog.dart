import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkyou_task/core/di/service_locator.dart';
import 'package:linkyou_task/features/todos/presentation/bloc/bloc/task_bloc.dart';

import '../../../../core/widgets/custom_text_field.dart';

class AddTaskDialog extends StatelessWidget {
  const AddTaskDialog({super.key, required this.controller});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<TaskBloc>(param1: 1),
      child: BlocBuilder<TaskBloc, TaskState>(
        builder: (context, state) {
          return AlertDialog(
            title: const Text('Add Task'),
            content: CustomTextField(
              controller: controller,
              labelText: 'Enter Task',
              validator: null,
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  context.read<TaskBloc>().add(
                        AddTaskEvent(todo: controller.text, completed: false),
                      );
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          );
        },
      ),
    );
  }
}
