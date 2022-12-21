import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:password_safe/application/theme/theme_service.dart';
import 'package:password_safe/domain/failures/failures.dart';
import 'package:password_safe/domain/repositories/theme_repository.dart';

import 'theme_service_test.mocks.dart';

@GenerateMocks([ThemeRepository])
void main() {
  late MockThemeRepository mockThemeRepository;
  late ThemeService themeService;

  late int listenerCount;

  setUp(() {
    listenerCount = 0;
    mockThemeRepository = MockThemeRepository();
    themeService = ThemeServiceImpl(themeRepository: mockThemeRepository)
      ..addListener(() {
        listenerCount += 1;
      });
  });

  test('check if default value for darkmode is true', () {
    //assert
    expect(themeService.isDarkmodeOn, true);
  });

  group('setThemeMode', () {
    const tMode = false;

    test(
        'should set the theme to the parameter it gets, store theme information',
        () async {
      //arrange
      themeService.isDarkmodeOn = true;
      when(mockThemeRepository.setThemeMode(mode: anyNamed('mode')))
          .thenAnswer((_) async => true);

      //act
      await themeService.setTheme(mode: tMode);

      //assert
      expect(themeService.isDarkmodeOn, tMode);
      verify(mockThemeRepository.setThemeMode(mode: tMode));
      expect(listenerCount, 1);
    });
  });

  group('toggleThemeMode', () {
    const tMode = false;

    test('should toggle current theme mode, store theme information', () async {
      //arrange
      themeService.isDarkmodeOn = true;
      when(mockThemeRepository.setThemeMode(mode: anyNamed('mode')))
          .thenAnswer((_) async => true);

      //act
      await themeService.toggleTheme();

      //assert
      expect(themeService.isDarkmodeOn, tMode);
      verify(mockThemeRepository.setThemeMode(mode: tMode));
      expect(listenerCount, 1);
    });
  });

  group('init', () {
    const tMode = true;

    test(
        'should get a theme mode from local data source and use it and notify listeners',
        () async {
      //arrange
      themeService.isDarkmodeOn = true;
      when(mockThemeRepository.getThemeMode())
          .thenAnswer((_) async => const Right(tMode));
      when(mockThemeRepository.setThemeMode(mode: anyNamed('mode')))
          .thenAnswer((_) async => true);

      //act
      await themeService.init();

      //assert
      expect(themeService.isDarkmodeOn, tMode);
      verify(mockThemeRepository.getThemeMode());
      expect(listenerCount, 1);
    });

    test(
        'should start with dark mode if no theme is returned from local source and nofiy listeners',
        () async {
      //arrange
      themeService.isDarkmodeOn = true;
      when(mockThemeRepository.getThemeMode())
          .thenAnswer((_) async => Left(CacheFailure()));
      when(mockThemeRepository.setThemeMode(mode: anyNamed('mode')))
          .thenAnswer((_) async => true);

      //act
      await themeService.init();

      //assesrt
      expect(themeService.isDarkmodeOn, true);
      verify(mockThemeRepository.getThemeMode());
      expect(listenerCount, 1);
    });
  });
}
