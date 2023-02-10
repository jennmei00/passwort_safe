import 'package:community_material_icon/community_material_icon.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:password_safe/application/password/controller/controller_bloc.dart';
import 'package:password_safe/core/failures/password_failures.dart';
import 'package:password_safe/domain/entities/id.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/domain/repositories/password_repository.dart';

import 'controller_bloc_test.mocks.dart';

@GenerateMocks([PasswordRepository])
void main() {
  late ControllerBloc controllerBloc;
  late MockPasswordRepository mockPasswordRepository;

  setUp(() {
    mockPasswordRepository = MockPasswordRepository();
    controllerBloc = ControllerBloc(passwordRepository: mockPasswordRepository);
  });

  test('initState should be ControllerInitial', () {
    //assert
    expect(controllerBloc.state, equals(ControllerInitial()));
  });

  group('DeletePasswordEvent', () {
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

    test('should call delete if event is added', () async {
      //arrange
      when(mockPasswordRepository.delete(tPassword))
          .thenAnswer((_) async => Right(unit));

      //act
      controllerBloc.add(DeletePasswordEvent(password: tPassword));
      await untilCalled(mockPasswordRepository.delete(tPassword));

      //assert
      verify(mockPasswordRepository.delete(tPassword));
      verifyNoMoreInteractions(mockPasswordRepository);
    });

     test('should emit in progress then the success state after event is added', () async {
      //arrange
      when(mockPasswordRepository.delete(tPassword))
          .thenAnswer((_) async => Right(unit));

      //assert later
      final expected = [
        ControllerInProgress(),
        ControllerSuccess(),
      ];

      expectLater(controllerBloc.stream, emitsInOrder(expected));

      //act
      controllerBloc.add(DeletePasswordEvent(password: tPassword));
    });

    test('should emit in progress then the failure state after event is added -> db failure', () async {
      //arrange
      when(mockPasswordRepository.delete(tPassword))
          .thenAnswer((_) async => Left(DBFailure()));

      //assert later
      final expected = [
        ControllerInProgress(),
        ControllerFailure(passwordFailure: DBFailure()),
      ];

      expectLater(controllerBloc.stream, emitsInOrder(expected));

      //act
      controllerBloc.add(DeletePasswordEvent(password: tPassword));
    });
  });

  group('UpdatePasswordEvent', () {
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

    test('should call update if event is added', () async {
      //arrange
      when(mockPasswordRepository.update(tPassword))
          .thenAnswer((_) async => Right(unit));

      //act
      controllerBloc.add(UpdatePasswordEvent(password: tPassword));
      await untilCalled(mockPasswordRepository.update(tPassword));

      //assert
      verify(mockPasswordRepository.update(tPassword));
      verifyNoMoreInteractions(mockPasswordRepository);
    });

     test('should emit in progress then the success state after event is added', () async {
      //arrange
      when(mockPasswordRepository.update(tPassword))
          .thenAnswer((_) async => Right(unit));

      //assert later
      final expected = [
        ControllerInProgress(),
        ControllerSuccess(),
      ];

      expectLater(controllerBloc.stream, emitsInOrder(expected));

      //act
      controllerBloc.add(UpdatePasswordEvent(password: tPassword));
    });

    test('should emit in progress then the failure state after event is added -> db failure', () async {
      //arrange
      when(mockPasswordRepository.update(tPassword))
          .thenAnswer((_) async => Left(DBFailure()));

      //assert later
      final expected = [
        ControllerInProgress(),
        ControllerFailure(passwordFailure: DBFailure()),
      ];

      expectLater(controllerBloc.stream, emitsInOrder(expected));

      //act
      controllerBloc.add(UpdatePasswordEvent(password: tPassword));
    });
  });
}
