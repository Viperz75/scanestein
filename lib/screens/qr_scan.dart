import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:image_picker/image_picker.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:scanestein/components/ocr_dialog.dart';
import 'package:scanestein/components/scanned_qr_dialog.dart';
import 'package:scanestein/constants.dart';
import 'package:scan/scan.dart';

class QRScan extends StatefulWidget {
  const QRScan({Key? key}) : super(key: key);

  @override
  State<QRScan> createState() => _QRScanState();
}

class _QRScanState extends State<QRScan> {
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
  String scanned_text = "";

  void scanImageQR() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);
      if (pickedImage != null) {
        _imageFile = pickedImage;
        setState(() {});
        getRecognisedText(pickedImage);
      }
    } catch (e) {
      setState(() {});
    }
  }

  // void getRecognisedText(XFile image) async {
  //   var imagePath = image.path;
  //   String? result = await Scan.parse(imagePath);
  //   print(imagePath);
  //
  //   if (result != null){
  //     await showMaterialModalBottomSheet(
  //         shape: RoundedRectangleBorder(
  //           borderRadius: BorderRadius.only(
  //             topLeft: Radius.circular(20.0),
  //             topRight: Radius.circular(20.0),
  //           ),
  //         ),
  //         context: context,
  //         builder: (BuildContext context) => OCRDialog(scannedText: result)
  //     );
  //   }
  // }

  void getRecognisedText(XFile image) async {
    final inputImage = InputImage.fromFilePath(image.path);
    final detectQR = GoogleMlKit.vision.barcodeScanner();
    final barcodes = await detectQR.processImage(inputImage);
    await detectQR.close();

    scanned_text = '';

    for (Barcode barcode in barcodes) {
      print(barcode.displayValue);
      scanned_text = barcode.displayValue.toString();
    }

    await showMaterialModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
        ),
        context: context,
        builder: (BuildContext context) => OCRDialog(scannedText: scanned_text));
  }

  Future<void> scanQRCode() async {
    try {
      final qrCode = await FlutterBarcodeScanner.scanBarcode(
        '#11d9aa',
        'Cancel',
        true,
        ScanMode.QR,
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
            builder: (BuildContext context) => ScannedQRDialog(qrCode: qrCode));
      });
    } on PlatformException {
      qrCode = ' ';
    }
  }
}
