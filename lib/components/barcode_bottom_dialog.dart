import 'package:flutter/material.dart';
import 'package:scanestein/functionality/save.dart';
import 'package:scanestein/functionality/share.dart';
import 'package:syncfusion_flutter_barcodes/barcodes.dart';
import 'package:scanestein/constants.dart';

class BarcodeBottomDialog extends StatelessWidget {
  BarcodeBottomDialog({required this.data});

  final qrKey = GlobalKey();
  final data;

  SaveQR save = SaveQR();
  ShareQR share = ShareQR();

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
          Container(
            height: 200,
            child: Padding(
              padding: EdgeInsets.only(
                  top: 30.0, bottom: 40.0, left: 10.0, right: 10.0),
              child: RepaintBoundary(
                key: qrKey,
                child: SfBarcodeGenerator(
                  value: data,
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
                onPressed: () => share.share(qrKey: qrKey),
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
