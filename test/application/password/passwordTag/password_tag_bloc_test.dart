import 'package:community_material_icon/community_material_icon.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:password_safe/application/password/passwordTag/password_tag_bloc.dart';
import 'package:password_safe/core/failures/password_failures.dart';
import 'package:password_safe/domain/entities/id.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/domain/repositories/password_repository.dart';

import 'password_tag_bloc_test.mocks.dart';

@GenerateMocks([PasswordRepository])
void main() {
  late PasswordTagBloc passwordTagBloc;
  late MockPasswordRepository mockPasswordRepository;

  setUp(() {
    mockPasswordRepository = MockPasswordRepository();
    passwordTagBloc =
        PasswordTagBloc(passwordRepository: mockPasswordRepository);
  });

  test('initState should be PasswordFormState.initial', () {
    //assert
    expect(passwordTagBloc.state.runtimeType,
        equals(PasswordTagState.initial().runtimeType));
  });

  group('InitializePasswordDetailContainer', () {
    final tPassword = Password(
      id: UniqueID.fromUniqueString('1'),
      title: 'TestTitle',
      name: 'TestName',
      email: 'test@email.de',
      password: 'TestPassword',
      link: 'TestLink',
      info: 'InfoText',
      icon: CommunityMaterialIcons.netflix,
      favTag: false,
      emailTag: false,
      webTag: false,
    );

    test('password should be tPassword', () async {
      //act
      passwordTagBloc.add(InitializePassword(password: tPassword));

      await emitsDone;

      //assert
      expect(passwordTagBloc.state.password, tPassword);
    });
  });

  group('TagPressedEvent', () {
    final tPassword = Password(
      id: UniqueID.fromUniqueString('1'),
      title: 'TestTitle',
      name: 'TestName',
      email: 'test@email.de',
      password: 'TestPassword',
      link: 'TestLink',
      info: 'InfoText',
      icon: CommunityMaterialIcons.netflix,
      favTag: false,
      emailTag: false,
      webTag: false,
    );

    // final favTag = false;
    // final emailTag = false;
    // final webTag = false;

    final tAddTag = false;
    final tTag = 1;

    test('should call update', () async {
      //arrange
      when(mockPasswordRepository.update(any))
          .thenAnswer((_) async => Right(unit));

      //act
      passwordTagBloc.add(InitializePassword(password: tPassword));
      passwordTagBloc.add(TagPressedEvent(
        addTag: tAddTag,
        tag: tTag,
      ));

      await untilCalled(mockPasswordRepository.update(any));

      //assert
      verify(mockPasswordRepository.update(any));
      verifyNoMoreInteractions(mockPasswordRepository);
    });

    test('should get falure and first isSaving=true then isSaving=false',
        () async {
      //arrange
      when(mockPasswordRepository.update(any))
          .thenAnswer((_) async => Left(DBFailure()));

      //act
      passwordTagBloc.add(InitializePassword(password: tPassword));
      passwordTagBloc.add(TagPressedEvent(
        addTag: tAddTag,
        tag: tTag,
      ));

      await untilCalled(mockPasswordRepository.update(any));
      expect(passwordTagBloc.state.isSaving, true);
      await emitsDone;

      //assert
      expect(passwordTagBloc.state.isSaving, false);
      expect(passwordTagBloc.state.failureOrSuccessOption,
          optionOf(Left(DBFailure())));
    });
  });
}
