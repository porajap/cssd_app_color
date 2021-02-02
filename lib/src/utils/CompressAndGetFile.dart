import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart' as path_provider;

class CompressAndGetFile {
  Future<File> compressFile({File file}) async {
    var img = AssetImage(file.path);
    var config = new ImageConfiguration();
    AssetBundleImageKey key = await img.obtainKey(config);
    // ByteData data = await key.bundle.load(key.name);
    var dir = await path_provider.getTemporaryDirectory();
    // file.writeAsBytesSync(data.buffer.asUint8List());

    var targetPath = dir.absolute.path + "/${getRandomString(4)}.jpg";
    var fileCompress = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path,
      targetPath,
      quality: 100,
      minWidth: 1500,
      minHeight: 1500,
    );

    return fileCompress;
  }

  String _chars = 'abcdefghijklmnopqrstuvwxyz';
  Random _rnd = Random();

  String getRandomString(int length) => String.fromCharCodes(
        Iterable.generate(
          length,
          (_) => _chars.codeUnitAt(
            _rnd.nextInt(_chars.length),
          ),
        ),
      );
}
