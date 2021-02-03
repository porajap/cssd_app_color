import 'dart:async';
import 'dart:io';

import 'package:cssd_app_color/src/pages/color/color_setting.dart';
import 'package:cssd_app_color/src/utils/CompressAndGetFile.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'dart:ui' as ui;
import 'package:image/image.dart' as img;
import 'package:flutter/services.dart' show ByteData, rootBundle;
import 'package:image_picker/image_picker.dart';

class ColorPage extends StatefulWidget {
  @override
  _ColorPageState createState() => _ColorPageState();
}

enum SingingCharacter { bradford, lowry }

class _ColorPageState extends State<ColorPage> {
  SingingCharacter _character = SingingCharacter.bradford;

  int documentStatus = 3;
  var currentStep = 0;

  File imagePath;
  GlobalKey imageKey = GlobalKey();
  GlobalKey paintKey = GlobalKey();

  bool useSnapshot = true;

  GlobalKey currentKey;

  TextEditingController edtResult = TextEditingController(text: '');
  StreamController<Color> _stateController = StreamController<Color>();
  String rgbText = "-";
  img.Image photo;

  double positionX = 0;
  double positionY = 0;

  int colorR = 0, colorG = 0, colorB = 0;

  @override
  void initState() {
    currentKey = useSnapshot ? paintKey : imageKey;

    super.initState();
  }

  void _getSetting() async {

  }

  void _showPhotoLibrary(BuildContext contextBloc) async {
    File _file = await ImagePicker.pickImage(source: ImageSource.gallery);
    File _fileCompress = await CompressAndGetFile().compressFile(file: _file);
    setState(() {
      useSnapshot = true;
      imagePath = _fileCompress;
    });
  }

  void _showCamera(BuildContext contextBloc) async {
    File _file = await ImagePicker.pickImage(source: ImageSource.camera);
    File _fileCompress = await CompressAndGetFile().compressFile(file: _file);
    setState(() {
      imagePath = _fileCompress;
      useSnapshot = true;
    });
  }

  void _showOptions(BuildContext contextBloc) async {
    setState(() {
      useSnapshot = false;
    });
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return Container(
              height: 150,
              child: Column(children: <Widget>[
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _showCamera(context);
                    },
                    leading: Icon(Icons.photo_camera),
                    title: Text("Take a picture from camera")),
                ListTile(
                    onTap: () {
                      Navigator.pop(context);
                      _showPhotoLibrary(context);
                    },
                    leading: Icon(Icons.photo_library),
                    title: Text("Choose from photo library"))
              ]));
        });
  }

  void _goPage(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ColorSetting(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PromoveCheck'),
        actions: [
          Row(
            children: [
              InkWell(
                onTap: () {
                  _showOptions(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.camera_alt_rounded,
                  ),
                ),
              ),
              SizedBox(width: 10),
              InkWell(
                onTap: () {
                  _goPage(context);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: Icon(
                    Icons.settings,
                  ),
                ),
              ),
            ],
          )
        ],
        centerTitle: true,
      ),
      body: StreamBuilder(
        initialData: Colors.white,
        stream: _stateController.stream,
        builder: (buildContext, snapshot) {
          Color selectedColor = snapshot.data ?? Colors.white;
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Protein Measurement'),
                    Text('( Moving Drop Platform x Mobile Detector )'),
                  ],
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: ListTile(
                      title: const Text('Bradford'),
                      leading: Radio(
                        value: SingingCharacter.bradford,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListTile(
                      title: const Text('Lowry'),
                      leading: Radio(
                        value: SingingCharacter.lowry,
                        groupValue: _character,
                        onChanged: (SingingCharacter value) {
                          setState(() {
                            _character = value;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              Expanded(
                child: imagePath != null
                    ? RepaintBoundary(
                        key: paintKey,
                        child: GestureDetector(
                          onPanDown: (details) {
                            searchPixel(details.globalPosition);
                          },
                          onPanUpdate: (details) {
                            searchPixel(details.globalPosition);
                          },
                          child: Stack(
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.height - 200,
                                width: MediaQuery.of(context).size.width,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: FileImage(imagePath),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                              Transform(
                                transform: Matrix4.translationValues(positionX, positionY, 0.0),
                                child: Container(
                                  width: 30,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.all(Radius.circular(100)),
                                    border: Border.all(
                                      width: 2,
                                      color: Colors.red,
                                      style: BorderStyle.solid,
                                    ),
                                  ),
                                  child: Icon(
                                    Icons.add,
                                    color: Colors.red,
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      )
                    : Container(
                        height: 100,
                        decoration: BoxDecoration(color: Colors.grey),
                      ),
              ),
              SingleChildScrollView(
                child: Container(
                  padding: EdgeInsets.all(8),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: EdgeInsets.only(bottom: 8),
                                  child: Row(
                                    children: [
                                      Text('Colors : '),
                                      Container(
                                        height: 50,
                                        width: 150,
                                        color: selectedColor,
                                      )
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text('Coordinate'),
                                    SizedBox(width: 20,),
                                    Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Text('X : ${positionX.toStringAsFixed(3)}'),
                                        Text('Y : ${positionY.toStringAsFixed(3)}'),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10,),
                                Text('R : $colorR'),
                                Text('G : $colorG'),
                                Text('B : $colorB'),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Flexible(
                            flex: 2,
                            child: Text('Concentration of sample'),
                          ),
                          Flexible(
                            flex: 1,
                            child: TextField(
                              controller: edtResult,
                              decoration: InputDecoration(
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.black45, width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.grey, width: 1.0),
                                ),
                                hintText: '?',
                              ),
                            ),
                          ),
                          Flexible(
                            flex: 1,
                            child: Text('ug.mL-1'),
                          ),
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        alignment: Alignment.centerRight,
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: Text('By Teerapat.O' ,style:  TextStyle(fontWeight: FontWeight.bold),),
                      ),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  void searchPixel(Offset globalPosition) async {
    await useSnapshot ? loadSnapshotBytes() : loadImageBundleBytes();
    _calculatePixel(globalPosition);
  }

  void _calculatePixel(Offset globalPosition) {
    RenderBox box = currentKey.currentContext.findRenderObject();
    Offset localPosition = box.globalToLocal(globalPosition);

    double px = localPosition.dx;
    double py = localPosition.dy;

    if (!useSnapshot) {
      double widgetScale = box.size.width / photo.width;
      print(py);
      px = (px / widgetScale);
      py = (py / widgetScale);
    }

    int pixel32 = photo.getPixelSafe(px.toInt(), py.toInt());
    int hex = abgrToArgb(pixel32);
    Color myColor = Color(hex);
    String _stringRgb = 'red: ${myColor.red} green: ${myColor.green} blue: ${myColor.blue}';
    print(_stringRgb);
    setState(() {
      rgbText = _stringRgb;

      positionX = px - 15;
      positionY = py - 15;

      colorR = myColor.red;
      colorG = myColor.green;
      colorB = myColor.blue;

      double result = 0.0;
      if (_character == SingingCharacter.bradford) {
        result = (colorR - 1.159) / 2.453;
      } else if (_character == SingingCharacter.lowry) {
        result = (colorR - 0.4786) / 0.4486;
      }
      edtResult.text = result.toStringAsFixed(3);
    });

    _stateController.add(Color(hex));
  }

  Future<void> loadImageBundleBytes() async {
    ByteData imageBytes = await rootBundle.load(imagePath.path);
    setImageBytes(imageBytes);
  }

  Future<void> loadSnapshotBytes() async {
    RenderRepaintBoundary boxPaint = paintKey.currentContext.findRenderObject();
    ui.Image capture = await boxPaint.toImage();
    ByteData imageBytes = await capture.toByteData(format: ui.ImageByteFormat.png);
    setImageBytes(imageBytes);
    capture.dispose();
  }

  void setImageBytes(ByteData imageBytes) {
    List<int> values = imageBytes.buffer.asUint8List();
    photo = null;
    photo = img.decodeImage(values);
  }
}

int abgrToArgb(int argbColor) {
  int r = (argbColor >> 16) & 0xFF;
  int b = argbColor & 0xFF;
  return (argbColor & 0xFF00FF00) | (b << 16) | r;
}
