import 'package:community_material_icon/community_material_icon.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:password_safe/application/password/passwordForm/passwordform_bloc.dart';
import 'package:password_safe/core/failures/password_failures.dart';
import 'package:password_safe/domain/entities/id.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/domain/repositories/password_repository.dart';

import 'passwordform_bloc_test.mocks.dart';

@GenerateMocks([PasswordRepository])
void main() {
  late PasswordformBloc passwordformBloc;
  late MockPasswordRepository mockPasswordRepository;

  setUp(() {
    mockPasswordRepository = MockPasswordRepository();
    passwordformBloc =
        PasswordformBloc(passwordRepository: mockPasswordRepository);
  });

  test('initState should be PasswordFormState.initial', () {
    //assert
    expect(passwordformBloc.state, equals(PasswordformState.initial()));
  });

  group('InitializePasswordDetailContainer', () {
    final tPassword = Password(
      id: UniqueID(),
      title: 'TestTitle',
      name: 'TestName',
      email: 'test@email.de',
      password: 'TestPassword',
      link: 'TestLink',
      icon: CommunityMaterialIcons.netflix,
      favTag: false,
      emailTag: false,
      webTag: false,
    );

    test('isEditing should be false', () async {
      //act
      passwordformBloc.add(InitializePasswordDetailContainer(password: null));

      //assert
      expect(passwordformBloc.state.isEditing, false);
    });

    test('password should be tPassword and isEditing should be true', () async {
      //act
      passwordformBloc
          .add(InitializePasswordDetailContainer(password: tPassword));

      await emitsDone;

      //assert
      expect(passwordformBloc.state.isEditing, true);
      expect(passwordformBloc.state.password, tPassword);
    });
  });

  group('SafePressedEvent', () {
    final tPassword = Password(
      id: UniqueID.fromUniqueString('1'),
      title: 'TestTitle',
      name: 'TestName',
      email: 'test@email.de',
      password: 'TestPassword',
      link: 'TestLink',
      icon: CommunityMaterialIcons.netflix,
      favTag: false,
      emailTag: false,
      webTag: false,
    );

    final tTitle = 'TestTitle';
    final tName = 'TestName';
    final tEmail = 'test@email.de';
    final tPasswordText = 'TestPassword';
    final tLink = 'TestLink';
    final tIcon = CommunityMaterialIcons.netflix;

    test('should call update', () async {
      //arrange
      when(mockPasswordRepository.update(any))
          .thenAnswer((_) async => Right(unit));

      //act
      passwordformBloc
          .add(InitializePasswordDetailContainer(password: tPassword));
      passwordformBloc.add(SafePressedEvent(
        title: tTitle,
        name: tName,
        email: tEmail,
        passwordText: tPasswordText,
        link: tLink,
        icon: tIcon,
      ));

      await untilCalled(mockPasswordRepository.update(any));

      //assert
      verify(mockPasswordRepository.update(any));
      verifyNoMoreInteractions(mockPasswordRepository);
    });

    test('should call create', () async {
      //arrange
      when(mockPasswordRepository.create(any))
          .thenAnswer((_) async => Right(unit));

      //act
      passwordformBloc.add(InitializePasswordDetailContainer(password: null));
      passwordformBloc.add(SafePressedEvent(
        title: tTitle,
        name: tName,
        email: tEmail,
        passwordText: tPasswordText,
        link: tLink,
        icon: tIcon,
      ));

      await untilCalled(mockPasswordRepository.create(any));

      //assert
      verify(mockPasswordRepository.create(any));
      verifyNoMoreInteractions(mockPasswordRepository);
    });

    
  });
}
