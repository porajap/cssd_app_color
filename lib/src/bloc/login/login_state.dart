part of 'login_bloc.dart';

@immutable
abstract class LoginState extends Equatable{
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginStateLoading extends LoginState {}

class LoginStateRememberToggle extends LoginState{
  final bool isRemember;

  LoginStateRememberToggle({this.isRemember});

  @override
  List<Object> get props => [isRemember];

  @override
  String toString() => 'LoginStateRememberToggle {isRemember: $isRemember}';
}

class LoginStateLoginPressLoading extends LoginState{
  final bool disableButton;
  LoginStateLoginPressLoading({this.disableButton});

  @override
  List<Object> get props => [disableButton];

  @override
  String toString() => 'LoginStateLoginPressLoading {disableButton: $disableButton}';
}

class LoginStateLoginPress extends LoginState{
  final bool error;
  final bool disableButton;

  LoginStateLoginPress({this.error, this.disableButton});

  @override
  List<Object> get props => [error, disableButton];

  @override
  String toString() => 'LoginStateLoginPress {error: $error, disableButton: $disableButton}';
}