import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';


class OCRDialog extends StatelessWidget {
  OCRDialog({required this.scannedText});

  final scannedText;

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
                padding: EdgeInsets.only(
                    top: 25.0, bottom: 30.0, left: 30, right: 30),
                child: Text(
                  scannedText,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 20),
            child: TextButton.icon(
              onPressed: () async {
                await FlutterClipboard.copy(scannedText);
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
              icon: Icon(Icons.copy_rounded),
              label: Text('Copy Text'),),
          )
        ],
      ),
    );
  }
}
