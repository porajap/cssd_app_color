import 'package:bot_toast/bot_toast.dart';
import 'package:cssd_app_color/src/pages/color/color_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:cssd_app_color/src/pages/home/home_page.dart';
import 'package:cssd_app_color/src/pages/login/login_page.dart';
import 'package:cssd_app_color/src/utils/Constants.dart';

import 'bloc/authentication/authentication_bloc.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _route = <String, WidgetBuilder>{
      Constants.COLOR_ROUTE: (context) => ColorPage(),
      Constants.HOME_ROUTE: (context) => HomePage(),
      Constants.LOGIN_ROUTE: (context) => LoginPage(),
    };

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));

    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en'),
        const Locale('th'),
      ],
      locale: const Locale('th'),
      debugShowCheckedModeBanner: false,
      title: Constants.APP_NAME,
      builder: BotToastInit(),
      navigatorObservers: [BotToastNavigatorObserver()],
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: Constants.APP_FONT,
      ),
      routes: _route,
      home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
        cubit: BlocProvider.of<AuthenticationBloc>(context),
        builder: (context, state) {
          BotToast.closeAllLoading();

          if (state is AuthenticationAuthenticated) {
            return HomePage();
          }

          if (state is AuthenticationUnauthenticated) {
            if (state.showAlert) {
              WidgetsBinding.instance.addPostFrameCallback(
                (_) => {
                  showAlertDialog(context),
                },
              );
            }
            return ColorPage();
            return LoginPage();
          }

          if (state is AuthenticationLoading) {
            return Container(
              color: Colors.white,
              child: Expanded(
                child: Center(
                  child: Image.asset(
                    Constants.LOGO_STERILE,
                    width: 100,
                  ),
                ),
              ),
            );
          }
          return Container(
            color: Colors.white,
            child: Expanded(
              child: Center(
                child: Image.asset(
                  Constants.LOGO_STERILE,
                  width: 100,
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void showAlertDialog(BuildContext context) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Login failed"),
          content: Text("Username or Password is incorrect."),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("Close"),
            ),
          ],
        );
      },
    );
  }
}
