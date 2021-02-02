import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cssd_app_color/src/utils/Constants.dart';

class CreatePage extends StatefulWidget {
  @override
  _CreatePageState createState() => _CreatePageState();
}

class _CreatePageState extends State<CreatePage> {
  int documentStatus = 3;


  @override
  Widget build(BuildContext context) {

    int activeStep = 4;
    int upperBound = 0;

    return Container(
      padding: EdgeInsets.all(10),
      height: MediaQuery.of(context).size.height,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [


        ],
      ),
    );
  }


}
