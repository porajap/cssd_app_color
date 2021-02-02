import 'package:cssd_app_color/src/bloc/BlocObserver.dart';
import 'package:cssd_app_color/src/bloc/authentication/authentication_bloc.dart';
import 'package:cssd_app_color/src/my_app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  Bloc.observer = SimpleBlocObserver();
  runApp(
    BlocProvider<AuthenticationBloc>(
      create: (_) => AuthenticationBloc()..add(AppStarted()),
      child: MyApp(),
    ),
  );
}