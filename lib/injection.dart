import 'package:get_it/get_it.dart';
import 'package:password_safe/application/password/controller/controller_bloc.dart';
import 'package:password_safe/application/password/observer/observer_bloc.dart';
import 'package:password_safe/application/password/passwordForm/passwordform_bloc.dart';
import 'package:password_safe/application/theme/theme_service.dart';
import 'package:password_safe/domain/repositories/password_repository.dart';
import 'package:password_safe/domain/repositories/theme_repository.dart';
import 'package:password_safe/infrastructure/datasources/db_local_datasource.dart';
import 'package:password_safe/infrastructure/datasources/theme_local_datasource.dart';
import 'package:password_safe/infrastructure/repositories/password_repository_impl.dart';
import 'package:password_safe/infrastructure/repositories/theme_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.I; // sl == service locator

Future<void> init() async {
  //! application layer
  sl.registerLazySingleton<ThemeService>(
      () => ThemeServiceImpl(themeRepository: sl()));

  //! state management
  sl.registerFactory(() => ControllerBloc(passwordRepository: sl()));
  sl.registerFactory(() => ObserverBloc(passwordRepository: sl()));
  sl.registerFactory(() => PasswordformBloc(passwordRepository: sl()));

  //! repos
  sl.registerLazySingleton<PasswordRepository>(
      () => PasswordRepositoryImpl(dbLocalDatasource: sl()));
  sl.registerLazySingleton<ThemeRepository>(
      () => ThemeRepositoryImpl(themeLocalDatasource: sl()));

  //! datasources
  sl.registerLazySingleton<DBLocalDatasource>(() => DBLocalDatasourceImpl());
  sl.registerLazySingleton<ThemeLocalDatasource>(
      () => ThemeLocalDatasourceImpl(sharedPreferences: sl()));

  //! extern
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}