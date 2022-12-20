part of 'password_tag_bloc.dart';

class PasswordTagState {
  final Password password;
  final bool tagAdded;
  final bool isSaving;
  final Option<Either<PasswordFailure, Unit>> failureOrSuccessOption;

  PasswordTagState(
      {required this.password,
      required this.tagAdded,
      required this.isSaving,
      required this.failureOrSuccessOption});

  factory PasswordTagState.initial() => PasswordTagState(
        password: Password.empty(),
        tagAdded: true,
        isSaving: false,
        failureOrSuccessOption: none(),
      );

  PasswordTagState copyWith({
    Password? password,
    bool? tagAdded,
    bool? isSaving,
    Option<Either<PasswordFailure, Unit>>? failureOrSuccessOption,
  }) {
    return PasswordTagState(
      password: password ?? this.password,
      tagAdded: tagAdded ?? this.tagAdded,
      isSaving: isSaving ?? this.isSaving,
      failureOrSuccessOption:
          failureOrSuccessOption ?? this.failureOrSuccessOption,
    );
  }
}
