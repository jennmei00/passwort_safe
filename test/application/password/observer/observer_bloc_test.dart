import 'package:community_material_icon/community_material_icon.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:password_safe/application/password/observer/observer_bloc.dart';
import 'package:password_safe/core/failures/password_failures.dart';
import 'package:password_safe/domain/entities/id.dart';
import 'package:password_safe/domain/entities/password.dart';
import 'package:password_safe/domain/repositories/password_repository.dart';

import 'observer_bloc_test.mocks.dart';

@GenerateMocks([PasswordRepository])
void main() {
  late ObserverBloc observerBloc;
  late MockPasswordRepository mockPasswordRepository;

  setUp(() {
    mockPasswordRepository = MockPasswordRepository();
    observerBloc = ObserverBloc(passwordRepository: mockPasswordRepository);
  });

  test('initState should be ObserverInitial', () {
    //assert
    expect(observerBloc.state, equals(ObserverInitial()));
  });

  group('GetAllEvent', () {
    final tPassword = Password(
      id: UniqueID(),
      title: 'TestTitle',
      name: 'TestName',
      email: 'test@email.de',
      password: 'TestPassword',
      link: 'TestLink',
      info: 'Infotext',
      icon: CommunityMaterialIcons.netflix,
      favTag: false,
      emailTag: false,
      webTag: false,
    );

    test('should call passwords if event is added', () async {
      //arrange
      when(mockPasswordRepository.getAll()).thenAnswer((_) async* {
        yield Right([tPassword]);
      });

      //act
      observerBloc.add(GetAllEvent());
      await untilCalled(mockPasswordRepository.getAll());

      //assert
      verify(mockPasswordRepository.getAll());
      verifyNoMoreInteractions(mockPasswordRepository);
    });

    test('should emit loading then the success state after event is added',
        () async {
      //arrange
      when(mockPasswordRepository.getAll()).thenAnswer((_) async* {
        yield Right([tPassword]);
      });

      //assert later
      final expected = [
        ObserverLodaing(),
        ObserverSuccess(passwords: [tPassword])
      ];

      expectLater(observerBloc.stream, emitsInOrder(expected));

      //act
      observerBloc.add(GetAllEvent());
    });

    test(
        'should emit loading then the error state after event is added -> passwords fails -> db failure',
        () async {
      //arrange
      when(mockPasswordRepository.getAll()).thenAnswer((_) async* {
        yield Left(DBFailure());
      });

      //assert late
      final expected = [
        ObserverLodaing(),
        ObserverFailure(passwordFailure: DBFailure())
      ];

      expectLater(observerBloc.stream, emitsInOrder(expected));

      //act
      observerBloc.add(GetAllEvent());
    });
  });

  // group('PasswordUpdatedEvent', () {
  //   final tPassword = Password(
  //     id: UniqueID(),
  //     title: 'TestTitle',
  //     name: 'TestName',
  //     email: 'test@email.de',
  //     password: 'TestPassword',
  //     link: 'TestLink',
  //     icon: CommunityMaterialIcons.netflix,
  //     favTag: false,
  //     emailTag: false,
  //     webTag: false,
  //   );

  //   test('should call event when updating password', () async {
  //     //arrange
  //     when(mockPasswordRepository.update(tPassword))
  //         .thenAnswer((_) async => Right(unit));

  //     //act
  //     observerBloc
  //         .add(PasswordUpdatedEvent(failureOrPasswords: Right([tPassword])));
  //     // await untilCalled(mockPasswordRepository.update(tPassword));

  //     //assert
  //     verify(PasswordUpdatedEvent(failureOrPasswords: Right([tPassword])));
  //     verifyNoMoreInteractions(mockPasswordRepository);
  //   });
  // });
}
