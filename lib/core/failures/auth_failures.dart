abstract class AuthFailure {}

class LocalAuthFailure extends AuthFailure {}

class RegisterFailure extends AuthFailure {}

class LoginFailure extends AuthFailure {}

class WrongPasswordFailure extends AuthFailure {}

class EmailAlreadyInUseFailure extends AuthFailure {}

class PasswordChangeFailure extends AuthFailure {}

class NameChangeFailure extends AuthFailure {}
