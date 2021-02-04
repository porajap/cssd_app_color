import 'package:bot_toast/bot_toast.dart';
import 'package:cssd_app_color/src/models/ColorsSettingModel.dart';
import 'package:cssd_app_color/src/services/ColorService.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ColorSetting extends StatefulWidget {
  @override
  _ColorSettingState createState() => _ColorSettingState();
}

class _ColorSettingState extends State<ColorSetting> {
  ColorService colorService = ColorService();
  TextEditingController edtBradfordA = TextEditingController(text: '0');
  TextEditingController edtBradfordB = TextEditingController(text: '0');
  TextEditingController edtLowryA = TextEditingController(text: '0');
  TextEditingController edtLowryB = TextEditingController(text: '0');

  Future<String> getSetting() async {
    ColorSettingModel settingData = await colorService.getSetting();
    setState(() {
      edtBradfordA.text = settingData.bradfordA;
      edtBradfordB.text = settingData.bradfordB;
      edtLowryA.text = settingData.lowryA;
      edtLowryB.text = settingData.lowryB;
    });
  }

  Future<Null> saveSetting() async {
    String result = await colorService.saveSetting(
      bradfordA: edtBradfordA.text,
      bradfordB: edtBradfordB.text,
      lowryA: edtLowryA.text,
      lowryB: edtLowryB.text,
    );
    FocusScope.of(context).unfocus();
    BotToast.showText(
      text: result,
      align: Alignment.center,
      clickClose: true,
      duration: Duration(milliseconds: 750),
      onClose: () {
        getSetting();
      },
    );
  }

  @override
  void initState() {
    getSetting();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
        centerTitle: true,
        actions: [
          InkWell(
            onTap: () {
              saveSetting();
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Icon(
                Icons.save,
              ),
            ),
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //   children: [
            //     Row(
            //       children: [
            //         Text(
            //           '[R]',
            //           style: TextStyle(color: Colors.red),
            //         ),
            //         Text(' = red color'),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         Text(
            //           '[G]',
            //           style: TextStyle(color: Colors.green),
            //         ),
            //         Text(' = green color'),
            //       ],
            //     ),
            //     Row(
            //       children: [
            //         Text(
            //           '[B]',
            //           style: TextStyle(color: Colors.blue),
            //         ),
            //         Text(' = blue color'),
            //       ],
            //     ),
            //   ],
            // ),
            SizedBox(height: 10),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Bradford',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(' Y '),
                      Text(' = '),
                      Text(' AX '),
                      Text(' + '),
                      Text(' B '),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(' A '),
                            Text(' = '),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: TextFormField(
                                  controller: edtBradfordA,
                                  keyboardType: TextInputType.numberWithOptions(decimal: false, signed: true),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black45, width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                    ),
                                    hintText: '',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(' B '),
                            ),
                            Text(' = '),
                            Expanded(
                              child: TextFormField(
                                controller: edtBradfordB,
                                keyboardType: TextInputType.numberWithOptions(decimal: false, signed: true),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black45, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                  ),
                                  hintText: '',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
            SizedBox(height: 20),
            Container(
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(),
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    alignment: Alignment.center,
                    child: Text(
                      'Lowry',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(' Y '),
                      Text(' = '),
                      Text(' AX '),
                      Text(' + '),
                      Text(' B '),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(' A '),
                            Text(' = '),
                            Expanded(
                              child: Padding(
                                padding: EdgeInsets.only(right: 5),
                                child: TextFormField(
                                  controller: edtLowryA,
                                  keyboardType: TextInputType.numberWithOptions(decimal: false, signed: true),
                                  decoration: InputDecoration(
                                    focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.black45, width: 1.0),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                    ),
                                    hintText: '',
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 5),
                              child: Text(' B '),
                            ),
                            Text(' = '),
                            Expanded(
                              child: TextFormField(
                                controller: edtLowryB,
                                keyboardType: TextInputType.numberWithOptions(decimal: false, signed: true),
                                decoration: InputDecoration(
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.black45, width: 1.0),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                  ),
                                  hintText: '',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
