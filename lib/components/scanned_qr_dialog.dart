import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:scanestein/constants.dart';

class ScannedQRDialog extends StatelessWidget {
  ScannedQRDialog({required this.qrCode});

  final qrCode;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
          Padding(
            padding: EdgeInsets.only(top: 50, bottom: 50),
            child: Center(
              child: Text(qrCode, style: kScannedStyle, textAlign: TextAlign.center,),
            ),
          ),
          TextButton.icon(
            onPressed: () async {
              await FlutterClipboard.copy(qrCode).then(
                    (value) => print('copied'),
              );
              const snacks = SnackBar(
                content: Text(
                  'Copied',
                  textAlign: TextAlign.center,
                ),
                elevation: 10,
                behavior: SnackBarBehavior.floating,
                margin: EdgeInsets.all(5),
              );
              ScaffoldMessenger.of(context).showSnackBar(snacks);
            },
            icon: Icon(
              Icons.copy_rounded,
              color: Colors.black,
              size: 30,
            ),
            label: Text('COPY', style: kDownloadButton),
          ),
        ],
      ),
    );
  }
}
