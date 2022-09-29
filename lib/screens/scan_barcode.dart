import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scan/scan.dart';
import 'package:scanestein/components/ocr_dialog.dart';
import 'package:scanestein/components/scanned_qr_dialog.dart';
import 'package:scanestein/constants.dart';

class BarcodeScan extends StatefulWidget {
  const BarcodeScan({Key? key}) : super(key: key);

  @override
  State<BarcodeScan> createState() => _BarcodeScanState();
}

class _BarcodeScanState extends State<BarcodeScan> {
  String qrCode = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan QR'),
        backgroundColor: Color(0xff1186d9),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: RaisedButton.icon(
              elevation: 10,
              padding: EdgeInsets.all(14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              icon:
              Icon(Icons.camera_alt_rounded, color: Colors.white, size: 20),
              color: Color(0xff0080f7),
              label: Text('Camera', style: kScanTextStyles),
              onPressed: () async {
                scanQRCode();
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Center(
            child: RaisedButton.icon(
              elevation: 10,
              padding: EdgeInsets.all(14),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8)),
              icon: Icon(FontAwesomeIcons.photoFilm,
                  color: Colors.white, size: 20),
              color: Color(0xff0080f7),
              label: Text(' Gallery', style: kScanTextStyles),
              onPressed: () async {
                scanImageQR();
              },
            ),
          ),
          // if (qrCode!=null)
          //   Center(child: Text('$qrCode')),
        ],
      ),
    );
  }


  XFile? _imageFile;

  void scanImageQR() async {
    try {
      final pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        _imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      setState(() {});
    }
  }

  void getRecognisedText(XFile image) async {
    var imagePath = image.path;
    String? result = await Scan.parse(imagePath);
    print(result);
    showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (BuildContext context) => OCRDialog(scannedText: result)
    );
  }


  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#11d9aa',
        'Cancel',
        true,
        ScanMode.BARCODE,
      );

      if (!mounted) return;

      setState(() {
        this.qrCode = qrCode;
        showMaterialModalBottomSheet(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
              ),
            ),
            context: context,
            builder: (BuildContext context) => ScannedQRDialog(qrCode: qrCode)
        );
      });
    } on PlatformException {
      qrCode = ' ';
    }
  }
}
