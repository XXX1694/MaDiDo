import 'package:get_it/get_it.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do/core/services/notification_service.dart';
import 'package:to_do/core/services/review_service.dart';
import 'package:to_do/features/settings/data/repositories/settings_repository.dart';
import 'package:to_do/features/settings/presentation/bloc/settings_bloc.dart';
import 'package:to_do/features/todo/data/datasources/todo_local_datasource.dart';

import 'package:to_do/features/todo/data/models/todo_model.dart';
import 'package:to_do/features/todo/data/repositories/todo_repository_impl.dart';
import 'package:to_do/features/todo/domain/repositories/todo_repository.dart';
import 'package:to_do/features/todo/domain/usecases/add_todo_usecase.dart';
import 'package:to_do/features/todo/domain/usecases/delete_todo_usecase.dart';
import 'package:to_do/features/todo/domain/usecases/update_todo_usecase.dart';
import 'package:to_do/features/todo/domain/usecases/watch_todos_usecase.dart';
import 'package:to_do/features/todo/presentation/bloc/todo_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // External
  final dir = await getApplicationDocumentsDirectory();
  final isar = await Isar.open([TodoModelSchema], directory: dir.path);
  sl
    ..registerLazySingleton(() => isar)
    // Data Sources
    ..registerLazySingleton<TodoLocalDataSource>(
      () => TodoLocalDataSourceImpl(sl()),
    )
    // Repositories
    ..registerLazySingleton<TodoRepository>(
      () => TodoRepositoryImpl(localDataSource: sl()),
    )
    // Use Cases
    ..registerLazySingleton(() => WatchTodosUseCase(sl()))
    ..registerLazySingleton(() => AddTodoUseCase(sl(), sl()))
    ..registerLazySingleton(() => UpdateTodoUseCase(sl(), sl()))
    ..registerLazySingleton(() => DeleteTodoUseCase(sl(), sl()));

  // External - Prefs
  final prefs = await SharedPreferences.getInstance();
  sl
    ..registerLazySingleton(() => prefs)
    // Settings Repository
    ..registerLazySingleton<SettingsRepository>(
      () => SettingsRepositoryImpl(sl()),
    )
    // Services
    ..registerLazySingleton(NotificationService.new);
  await sl<NotificationService>().init();
  await sl<NotificationService>().requestPermissions();
  sl
    ..registerLazySingleton(() => ReviewService(sl()))
    // Blocs
    ..registerFactory(
      () => TodoBloc(
        watchTodosUseCase: sl(),
        addTodoUseCase: sl(),
        updateTodoUseCase: sl(),
        deleteTodoUseCase: sl(),
        reviewService: sl(),
      ),
    )
    ..registerFactory(() => SettingsBloc(repository: sl()));
}
