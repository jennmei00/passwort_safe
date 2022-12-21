import 'package:equatable/equatable.dart';

abstract class PasswordFailure {}

class DBFailure extends PasswordFailure with EquatableMixin {
  @override
  List<Object?> get props => [];
}
