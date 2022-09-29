import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:scanestein/constants.dart';
import 'package:path_provider/path_provider.dart';
import 'package:scanestein/functionality/share.dart';
import 'package:scanestein/functionality/save.dart';

class bottom_dialog extends StatelessWidget {
  bottom_dialog({required this.qrData, this.color});

  final qrKey = GlobalKey();
  late String qrData;
  final color;
  // final image;

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<void> _copyFile() async {
    final path = await _localPath;
    Clipboard.setData(
        new ClipboardData(text: "content://${_localPath}/image.png"));
    return;
  }

  ShareQR share = ShareQR();
  SaveQR save = SaveQR();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 20.0),
            child: SizedBox(
              height: 5.0,
              width: 50.0,
              child: Divider(
                thickness: 5.0,
                color: Colors.blueAccent,
              ),
            ),
          ),
          Container(
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: 25.0, bottom: 30.0),
                child: RepaintBoundary(
                  key: qrKey,
                  child: QrImage(
                    data: qrData,
                    errorCorrectionLevel: QrErrorCorrectLevel.H,
                    embeddedImage: AssetImage('image/default_middle_logo.png'),
                    embeddedImageEmitsError: false,
                    embeddedImageStyle: QrEmbeddedImageStyle(size: Size(50, 50)),
                    size: 250,
                    foregroundColor: color,
                    version: QrVersions.auto,
                  ),
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton.icon(
                onPressed: () {
                  save.save(qrKey: qrKey);
                  showDialog(
                      context: context,
                      builder: (context) {
                        Future.delayed(Duration(seconds: 1), () {
                          Navigator.of(context).pop(true);
                        });
                        return AlertDialog(
                          title: Text('Saved to gallery'),
                        );
                      });
                },
                icon: Icon(
                  Icons.download_rounded,
                  color: Color(0x9906bd95),
                  size: 30,
                ),
                label: Text('DOWNLOAD', style: kDownloadButton),
              ),
              TextButton.icon(
                onPressed: () {
                  share.share(qrKey: qrKey);
                },
                icon: Icon(
                  Icons.share_rounded,
                  color: Color(0x9906bd95),
                  size: 30,
                ),
                label: Text('SHARE', style: kDownloadButton),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
