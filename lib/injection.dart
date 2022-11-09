import 'package:get_it/get_it.dart';
import 'package:password_safe/application/theme/theme_service.dart';
import 'package:password_safe/domain/repositories/theme_repository.dart';
import 'package:password_safe/infrastructure/datasources/theme_local_datasource.dart';
import 'package:password_safe/infrastructure/repositories/theme_repository_impl.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.I; // sl == service locator

Future<void> init() async {
  //! application layer
  sl.registerLazySingleton<ThemeService>(() => ThemeServiceImpl(themeRepository: sl()));

  //! Usecases

  //! repos
  sl.registerLazySingleton<ThemeRepository>(() => ThemeRepositoryImpl(themeLocalDatasource: sl()));

  //! datasources
  sl.registerLazySingleton<ThemeLocalDatasource>(() => ThemeLocalDatasourceImpl(sharedPreferences: sl()));

  //! extern
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}