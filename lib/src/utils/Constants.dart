import 'package:flutter/material.dart';

class Constants{
  //app name
  static const String APP_NAME = "N Sterile";

  //routes
  static const String COLOR_ROUTE = "/color";
  static const String HOME_ROUTE = "/home";
  static const String LOGIN_ROUTE = "/login";

  //app font
  static const String APP_FONT = "PoppinsLight";

  //images
  static const String IMAGE_DIR = "lib/src/assets/images";

  //login
  static const String LOGO_STERILE = "$IMAGE_DIR/n_sterile_logo.png";
  static const String LOGO_HEALTH = "$IMAGE_DIR/n_health_logo.png";

  //color
  static const Color PRIMARY_COLOR = Color.fromRGBO(26, 90, 162, 1);
  static const Color SECONDARY_COLOR = Color.fromRGBO(101, 147, 245, 1);
  static const Color LIGHT_COLOR = Color.fromRGBO(240, 243, 244, 1);
}