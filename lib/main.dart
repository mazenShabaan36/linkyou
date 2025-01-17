import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:linkyou_task/features/auth/presentation/pages/login_page.dart';
import 'package:linkyou_task/features/todos/domain/entities/task.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/di/service_locator.dart';
import 'features/auth/presentation/bloc/bloc/auth_bloc.dart';
import 'features/todos/presentation/bloc/bloc/task_bloc.dart';
import 'features/todos/presentation/pages/task_page.dart';

void main() async {
  setupDependencies();
 
  WidgetsFlutterBinding.ensureInitialized();
   final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getInt('userId');
  await Hive.initFlutter();
  Hive.registerAdapter(TasksAdapter()); // Register TaskModel adapter
  await Hive.openBox<Tasks>('tasks');
  runApp(MyApp(
    userId: userId,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, this.userId});
  final int? userId;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter LinkYou',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
      ),
      home: userId != null
          ? BlocProvider(
              create: (context) =>
                  getIt<TaskBloc>(param1: userId!)..add(FetchTasksEvent()),
              child: const TaskPage(),
            )
          : BlocProvider(
              create: (context) => getIt<AuthBloc>(),
              child: LoginPage(),
            ),
    );
  }
}
