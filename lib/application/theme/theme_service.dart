import 'package:flutter/cupertino.dart';
import 'package:password_safe/domain/repositories/theme_repository.dart';

abstract class ThemeService extends ChangeNotifier {
  late bool isDarkmodeOn;

  Future<void> toggleTheme();
  Future<void> setTheme({required bool mode});
  Future<void> init();
}

class ThemeServiceImpl extends ChangeNotifier implements ThemeService {
  final ThemeRepository themeRepository;
  ThemeServiceImpl({required this.themeRepository});

  @override
  bool isDarkmodeOn = true;

  @override
  Future<void> init() async {
    final modeOrFailure = await themeRepository.getThemeMode();
    modeOrFailure.fold(
        (failure) => setTheme(mode: true), (mode) => setTheme(mode: mode));
  }

  @override
  Future<void> setTheme({required bool mode}) async {
    isDarkmodeOn = mode;
    notifyListeners();
    await themeRepository.setThemeMode(mode: isDarkmodeOn);
  }

  @override
  Future<void> toggleTheme() async {
    isDarkmodeOn = !isDarkmodeOn;
    await setTheme(mode: isDarkmodeOn);
  }
}
