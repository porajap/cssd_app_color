part of 'login_bloc.dart';

@immutable
abstract class LoginEvent extends Equatable{
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class LoginEventRememberToggle extends LoginEvent{
  final bool isRemember;

  LoginEventRememberToggle({this.isRemember});

  @override
  List<Object> get props => [isRemember];

  @override
  String toString() => 'LoginEventRememberToggle {isRemember: $isRemember}';
}

class LoginEventPressLogin extends LoginEvent{
  final String username;
  final String password;
  final bool isRemember;
  final bool disableButton;

  LoginEventPressLogin({this.username, this.password, this.isRemember, this.disableButton});

  @override
  List<Object> get props => [username, password, isRemember, disableButton];
}
