import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cssd_app_color/src/bloc/authentication/authentication_bloc.dart';
import 'package:cssd_app_color/src/bloc/home/home_bloc.dart';
import 'package:cssd_app_color/src/pages/create_request/create_page.dart';
import 'package:cssd_app_color/src/pages/dashboard/dashboard_page.dart';
import 'package:cssd_app_color/src/pages/return_confirm/return_page.dart';
import 'package:cssd_app_color/src/pages/tracking/tracking_page.dart';
import 'package:cssd_app_color/src/utils/Constants.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String titlePage = "Dashboard";

  @override
  Widget build(BuildContext context) {
    return BlocProvider<HomeBloc>(
      create: (_) => HomeBloc()..add(EventHomeChangePage(pageName: "DASHBOARD")),
      child: BlocListener<HomeBloc, HomeState>(
        listener: (context, state) {

        },
        child: BlocBuilder<HomeBloc, HomeState>(
          builder: (context, state){
            if (state is StateHomeChangePage) {
              titlePage = state.titlePage;
            }

            return Scaffold(
              appBar: AppBar(
                backgroundColor: Constants.PRIMARY_COLOR,
                title: Text("$titlePage"),
                centerTitle: true,
              ),
              drawer: SafeArea(
                child: Container(
                  padding: EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width - 80,
                  decoration: new BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.only(
                        topRight: const Radius.circular(20),
                      )),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Icon(
                              Icons.close_rounded,
                              size: 28,
                              color: Colors.black87,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),
                      Image.asset(
                        "${Constants.LOGO_STERILE}",
                        width: 180,
                      ),
                      SizedBox(height: 40),
                      Text(
                        "Lorem Ipsum",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 40),
                      BlocBuilder<HomeBloc, HomeState>(
                        builder: (context, state) {

                          String _pageName;

                          if (state is StateHomeChangePage) {
                            _pageName = state.pageName;
                          }


                          return Expanded(
                            child: ListView(
                              children: [
                                buildDrawerMenu(
                                    menuTitle: "Dashboard",
                                    menuIcon: Icons.av_timer_rounded,
                                    menuColor: _pageName == "DASHBOARD" ?  Constants.PRIMARY_COLOR : Colors.black54,
                                    contextBloc: context,
                                    pageName: "DASHBOARD"
                                ),
                                buildDrawerMenu(
                                    menuTitle: "Request",
                                    menuIcon: Icons.question_answer,
                                    menuColor: _pageName == "REQUEST" ?  Constants.PRIMARY_COLOR : Colors.black54,
                                    contextBloc: context,
                                    pageName: "REQUEST"
                                ),
                                buildDrawerMenu(
                                    menuTitle: "Return Confirm",
                                    menuIcon: Icons.check_circle_outline_rounded,
                                    menuColor: _pageName == "RETURN" ?  Constants.PRIMARY_COLOR : Colors.black54,
                                    contextBloc: context,
                                    pageName: "RETURN"
                                ),
                                buildDrawerMenu(
                                    menuTitle: "Tracking",
                                    menuIcon: Icons.label_important,
                                    menuColor: _pageName == "TRACKING" ?  Constants.PRIMARY_COLOR : Colors.black54,
                                    contextBloc: context,
                                    pageName: "TRACKING"
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                      Divider(
                        thickness: 1,
                      ),
                      Container(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        child: Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Transform(
                                alignment: Alignment.center,
                                transform: Matrix4.rotationY(math.pi),
                                child: Icon(
                                  Icons.logout,
                                  color: Constants.SECONDARY_COLOR,
                                ),
                              ),
                              SizedBox(width: 20),
                              InkWell(
                                onTap: askForConfirmToLogout,
                                child: Text(
                                  "Logout",
                                  style: TextStyle(color: Constants.SECONDARY_COLOR, fontSize: 18),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              body: Container(
                padding: EdgeInsets.only(top: 10),
                child: SafeArea(
                  child: BlocBuilder<HomeBloc, HomeState>(
                    builder: (context, state){
                      String _pageName;

                      if (state is StateHomeChangePage) {
                        _pageName = state.pageName;
                      }

                      switch(_pageName){
                        case "DASHBOARD":
                          return Center(
                            child: DashBoardPage(),
                          );

                        case "REQUEST":
                          return Center(
                            child: CreatePage(),
                          );

                        case "RETURN":
                          return Center(
                            child: ReturnConfirmPage(),
                          );

                        case "TRACKING":
                          return Center(
                            child: TrackingPage(),
                          );

                        default :
                          return Center(
                            child: DashBoardPage(),
                          );
                      }
                    },
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget buildDrawerMenu({String menuTitle, String pageName, IconData menuIcon, Color menuColor, BuildContext contextBloc}) {
    return ListTile(
      title: Text(
        '$menuTitle',
        style: TextStyle(color: menuColor),
      ),
      leading: Icon(
        menuIcon,
        color: menuColor,
      ),
      onTap: () {
        BlocProvider.of<HomeBloc>(contextBloc).add(EventHomeChangePage(pageName: pageName));
        Navigator.pop(context);
      },
    );
  }

  void askForConfirmToLogout() {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Do you want to logout?"),
          actions: <Widget>[
            FlatButton(
              child: Text(
                "Cancel",
                style: TextStyle(color: Colors.grey),
              ),
              onPressed: () {
                Navigator.of(dialogContext).pop(); // Dismiss alert dialog
              },
            ),
            FlatButton(
              child: Text("Confirm"),
              onPressed: () {
                Navigator.of(dialogContext).pop();
                BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut()); // Dismiss alert dialog
              },
            ),
          ],
        );
      },
    );
  }
}
