import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:cssd_app_color/src/bloc/authentication/authentication_bloc.dart';
import 'package:cssd_app_color/src/models/UserModel.dart';
import 'package:cssd_app_color/src/services/AuthenticationService.dart';

part 'login_event.dart';

part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {

  final AuthenticationBloc authenticationBloc;

  LoginBloc({this.authenticationBloc}) : super(null);

  LoginState get initialState => LoginStateLoading();

  AuthenticationService authenticationService = AuthenticationService();

  UserModel userLogin = UserModel();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
      switch(event.runtimeType){
        case LoginEventRememberToggle:
          yield* _mapLoginEventRememberToggle(event);
          break;
        case LoginEventPressLogin:
          yield* _mapLoginEventPressLogin(event);
          break;
      }
  }

  Stream<LoginState> _mapLoginEventRememberToggle(LoginEventRememberToggle event) async* {
    yield LoginStateRememberToggle(isRemember: !event.isRemember);
  }

  Stream<LoginState> _mapLoginEventPressLogin(LoginEventPressLogin event) async* {
    userLogin.username = event.username.trim();
    userLogin.password = event.password.trim();
    userLogin.isRemember = event.isRemember;

    yield LoginStateLoginPressLoading(disableButton: true);
    await Future.delayed(Duration(seconds: 1));

    authenticationBloc.add(LoggedIn(user: userLogin));

    yield LoginStateLoginPress(disableButton: false);
  }
}
