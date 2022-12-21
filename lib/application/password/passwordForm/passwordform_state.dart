part of 'passwordform_bloc.dart';

class PasswordformState with EquatableMixin {
  final Password password;
  final bool showErrorMessages;
  final bool isSaving;
  final bool isEditing;
  final Option<Either<PasswordFailure, Unit>> failureOrSuccessOption;

  PasswordformState({
    required this.password,
    required this.showErrorMessages,
    required this.isSaving,
    required this.isEditing,
    required this.failureOrSuccessOption,
  });

  factory PasswordformState.initial() => PasswordformState(
        password: Password.empty(),
        showErrorMessages: false,
        isEditing: false,
        isSaving: false,
        failureOrSuccessOption: none(),
      );

  PasswordformState copyWith({
    Password? password,
    bool? showErrorMessages,
    bool? isSaving,
    bool? isEditing,
    Option<Either<PasswordFailure, Unit>>? failureOrSuccessOption,
  }) {
    return PasswordformState(
      password: password ?? this.password,
      showErrorMessages: showErrorMessages ?? this.showErrorMessages,
      isSaving: isSaving ?? this.isSaving,
      isEditing: isEditing ?? this.isEditing,
      failureOrSuccessOption:
          failureOrSuccessOption ?? this.failureOrSuccessOption,
    );
  }

  @override
  List<Object?> get props => [];
}
