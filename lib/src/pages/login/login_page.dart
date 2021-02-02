import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cssd_app_color/src/bloc/authentication/authentication_bloc.dart';
import 'package:cssd_app_color/src/bloc/login/login_bloc.dart';
import 'package:cssd_app_color/src/pages/home/home_page.dart';
import 'package:cssd_app_color/src/utils/Constants.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isRemember = false;
  final usernameController = TextEditingController(text: "");
  final passwordController = TextEditingController(text: "");
  bool disableButton = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginBloc>(
      create: (_) => LoginBloc(authenticationBloc: BlocProvider.of<AuthenticationBloc>(context)),
      child: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("${Constants.IMAGE_DIR}/login_bg.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          body: GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: BlocListener<LoginBloc, LoginState>(
              listener: (context, state){

              },
              child: Container(
                padding: EdgeInsets.only(left: 30, right: 30, top: 50),
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: SafeArea(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Image.asset(
                          "${Constants.LOGO_HEALTH}",
                          width: 200,
                        ),
                        SizedBox(height: 30),
                        Text(
                          "Welcome !",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Please Sign in to continue",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                        SizedBox(height: 70),
                        _buildForm(),
                        SizedBox(height: 20),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            if (state is LoginStateRememberToggle) {
                              isRemember = state.isRemember;
                            }
                            return _buildRemember(contextBloc: context);
                          },
                        ),
                        SizedBox(height: 30),
                        BlocBuilder<LoginBloc, LoginState>(
                          builder: (context, state) {
                            BotToast.closeAllLoading();

                            if (state is LoginStateLoginPressLoading) {
                              BotToast.showLoading();
                              disableButton = state.disableButton;
                            }

                            if (state is LoginStateLoginPress) {
                              BotToast.closeAllLoading();
                              disableButton = state.disableButton;
                            }
                            return _buildButton(contextBloc: context);
                          },
                        ),
                        SizedBox(height: 30),
                        _buildForgot(),
                        SizedBox(height: 60),
                        _buildBottomLogo(),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        TextFormField(
          controller: usernameController,
          cursorColor: Theme.of(context).cursorColor,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            labelText: 'Username',
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            suffixIcon: Icon(
              Icons.account_circle_rounded,
              color: Colors.white,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.white,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.white,
              ),
            ),
          ),
        ),
        SizedBox(height: 30),
        TextFormField(
          controller: passwordController,
          cursorColor: Theme.of(context).cursorColor,
          style: TextStyle(
            color: Colors.white,
            fontSize: 16,
          ),
          decoration: InputDecoration(
            labelText: 'Password',
            labelStyle: TextStyle(
              color: Colors.white,
            ),
            suffixIcon: Icon(
              Icons.lock_outlined,
              color: Colors.white,
            ),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.white,
              ),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                width: 2,
                color: Colors.white,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRemember({BuildContext contextBloc}) {
    return Container(
      child: Row(
        children: [
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              BlocProvider.of<LoginBloc>(contextBloc).add(LoginEventRememberToggle(isRemember: isRemember));
            },
            child: Container(
              decoration: BoxDecoration(
                color: isRemember ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
              ),
              child: isRemember
                  ? Icon(
                      Icons.check,
                      size: 18,
                      color: Colors.white,
                    )
                  : Icon(
                      Icons.check_box_outline_blank,
                      size: 18,
                      color: Colors.white,
                    ),
            ),
          ),
          SizedBox(width: 10),
          InkWell(
            splashColor: Colors.transparent,
            onTap: () {
              BlocProvider.of<LoginBloc>(contextBloc).add(LoginEventRememberToggle(isRemember: isRemember));
            },
            child: Text(
              "Remember me",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton({BuildContext contextBloc}) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        child: RaisedButton(
          padding: EdgeInsets.only(top: 15, bottom: 15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
            side: BorderSide(
              color: Constants.SECONDARY_COLOR,
            ),
          ),
          onPressed: disableButton ? null : () => validateForm(contextBloc: contextBloc),
          color: Constants.SECONDARY_COLOR,
          textColor: Colors.white,
          child: Text(
            "Login",
            style: TextStyle(fontSize: 16),
          ),
          disabledColor: Constants.SECONDARY_COLOR,
        ),
      ),
    );
  }

  Widget _buildForgot() {
    return Container(
      child: Center(
        child: InkWell(
          onTap: () {
            print("Forgot Your Password");
          },
          child: Text(
            "Forgot Your Password?",
            style: TextStyle(
              color: Colors.black54,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildBottomLogo() {
    return Container(
      child: Center(
        child: Image.asset(
          "${Constants.LOGO_STERILE}",
          width: 190,
        ),
      ),
    );
  }

  void validateForm({BuildContext contextBloc}) {
    if (usernameController.text.trim().isEmpty || passwordController.text.trim().isEmpty) {
      dialogLoginFailed(contextBloc);
    } else {
      BlocProvider.of<LoginBloc>(contextBloc).add(LoginEventPressLogin(
        username: usernameController.text.trim(),
        password: passwordController.text.trim(),
        isRemember: isRemember,
        disableButton: true,
      ));
    }
  }

  dialogLoginFailed(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
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
