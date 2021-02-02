import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:cssd_app_color/src/models/UserModel.dart';
import 'package:cssd_app_color/src/services/AuthenticationService.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc extends Bloc<AuthenticationEvent, AuthenticationState> {
  AuthenticationBloc() : super(AuthenticationUninitialized());

  AuthenticationState get initialState => AuthenticationUninitialized();

  final authService = AuthenticationService();

  @override
  Stream<AuthenticationState> mapEventToState(AuthenticationEvent event) async* {
    switch(event.runtimeType){
      case AppStarted:
        yield*_mapAppStartedToState(event);
        break;
      case LoggedIn:
        yield* _mapLoggedInToState(event);
        break;
      case LoggedOut:
        yield* _mapLoggedOutToState(event);
        break;
    }
  }

  Stream<AuthenticationState> _mapAppStartedToState(AppStarted event) async* {
    final bool isLogin = await authService.checkLogin();

    if (isLogin) {
      yield AuthenticationAuthenticated();
    } else{
      yield AuthenticationUnauthenticated();
    }
  }

  Stream<AuthenticationState> _mapLoggedInToState(LoggedIn event) async*{
    yield AuthenticationLoading();
    final bool success = await authService.login(user: event.user);
    if (success) {
      yield AuthenticationAuthenticated();
    } else{
      yield AuthenticationUnauthenticated(showAlert: true);
    }
  }

  Stream<AuthenticationState> _mapLoggedOutToState(LoggedOut event) async* {
    yield AuthenticationLoading();
    await authService.logout();
    yield AuthenticationUnauthenticated();
  }
}
