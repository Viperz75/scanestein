import 'dart:io';
import 'package:flutter/rendering.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:ui' as ui;
import 'package:share_plus/share_plus.dart';


class ShareQR{

  void share({required var qrKey}) async {
    try {
      RenderRepaintBoundary boundary = qrKey.currentContext!.findRenderObject() as RenderRepaintBoundary;
//captures qr image
      var image = await boundary.toImage();
      final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
      final pngBytes = byteData!.buffer.asUint8List();
//app directory for storing images.
      final appDir = await getApplicationDocumentsDirectory();
//current time
      var datetime = DateTime.now();
//qr image file creation
      var file = await File('${appDir.path}/$datetime.png').create();
//appending data
      await file.writeAsBytes(pngBytes);
//Shares QR image
      await Share.shareFiles(
        [file.path],
        mimeTypes: ["image/png"],
        text: "Scan the code",
      );
    } catch (e) {
      print(e.toString());
    }
  }
}