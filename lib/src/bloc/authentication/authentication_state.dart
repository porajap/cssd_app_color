part of 'authentication_bloc.dart';

@immutable
abstract class AuthenticationState extends Equatable{
  @override
  List<Object> get props => [];
}

class AuthenticationUninitialized extends AuthenticationState {}

class AuthenticationAuthenticated extends AuthenticationState {}

class AuthenticationLoading extends AuthenticationState {}

class AuthenticationUnauthenticated extends AuthenticationState {
  final bool showAlert;

  AuthenticationUnauthenticated({this.showAlert = false});

  @override
  List<Object> get props => [showAlert];

  @override
  String toString() => 'AuthenticationUnauthenticated { showAlert: $showAlert}';
}