import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:linkyou_task/core/network/network_info.dart';
import 'package:linkyou_task/features/auth/data/datasources/auth_remote_data_soucre.dart';
import 'package:linkyou_task/features/todos/data/data_sources/tasks_remote_data_sources.dart';
import 'package:linkyou_task/features/todos/data/repositories/task_repositories_impl.dart';

import '../../features/auth/data/repositories/auth_repository_impl.dart';
import '../../features/auth/domain/repositories/auth_repository.dart';
import '../../features/auth/presentation/bloc/bloc/auth_bloc.dart';
import '../../features/todos/domain/entities/task.dart';
import '../../features/todos/domain/repositories/task_repository.dart';
import '../../features/todos/presentation/bloc/bloc/task_bloc.dart';

final getIt = GetIt.instance;

void setupDependencies() {
  getIt.registerLazySingleton(() => Connectivity());

  // Register NetworkInfo
  getIt.registerLazySingleton<NetworkInfo>(
    () => NetworkInfoImpl(connectivity: getIt<Connectivity>()),
  );
  final dio = Dio();
  //getIt.registerLazySingleton<Dio>(() => dio);
  dio.interceptors.add(LogInterceptor(
    request: true,
    requestHeader: true,
    requestBody: true,
    responseHeader: true,
    responseBody: true,
    error: true,
  ));

  getIt.registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(dio: getIt<Dio>()));
  getIt.registerLazySingleton<Box<Tasks>>(() => Hive.box<Tasks>('tasks'));
  getIt.registerLazySingleton(() => dio);
  getIt.registerLazySingleton<AuthRepository>(
    () =>
        AuthRepositoryImpl(authRemoteDataSource: getIt<AuthRemoteDataSource>()),
  );
  getIt.registerLazySingleton<TasksRemoteDataSources>(
    () => TasksRemoteDataSourceImpl(
        dio: getIt<Dio>(), taskBox: getIt<Box<Tasks>>()),
  );

  getIt.registerFactoryParam<TaskRepository, int, void>(
    (userId, _) => TaskRepositoriesImpl(
        tasksRemoteDataSources: getIt<TasksRemoteDataSources>(),
        taskBox: getIt<Box<Tasks>>(),
        userId: userId),
  );

  getIt
      .registerFactory(() => AuthBloc(authRepository: getIt<AuthRepository>()));
  getIt.registerFactoryParam<TaskBloc, int, void>(
    (userId, _) => TaskBloc(
      taskRepository: getIt<TaskRepository>(param1: userId),
      userId: userId,
    ),
  );
}
