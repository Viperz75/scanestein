import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:clipboard/clipboard.dart';
import 'package:scanestein/constants.dart';

class ScanQrPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ScanQrPageState();
}

class _ScanQrPageState extends State<ScanQrPage> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  // Future<void> answer() async {
  //   //   if (result != null) {
  //   //     await showMaterialModalBottomSheet(
  //   //       shape: RoundedRectangleBorder(
  //   //         borderRadius: BorderRadius.only(
  //   //           topLeft: Radius.circular(20.0),
  //   //           topRight: Radius.circular(20.0),
  //   //         ),
  //   //       ),
  //   //       context: context,
  //   //       builder: (BuildContext context) => Column(
  //   //         children: [Text('${result!.code}')],
  //   //       ),
  //   //     );
  //   //   } else {
  //   //     print('nothing');
  //   //   }
  //   // }
  Widget buildResult()  =>  Container(
    child: Text(''),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        actions: [
          IconButton(
              onPressed: () {
                controller!.toggleFlash();
              },
              icon: Icon(Icons.flash_on_rounded))
        ],
      ),
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                  borderRadius: 10,
                  borderLength: 20,
                  borderWidth: 10,
                  cutOutSize: MediaQuery.of(context).size.width * 0.7),
            ),
          ),
          if (result != null)
            buildResult(),
          // Expanded(
          //   flex: 1,
          //   child: Column(
          //     children: [
          //       SizedBox(
          //         height: 20,
          //       ),
          //       (result != null)
          //           ? Container(
          //               child: Text(
          //                 '${result!.code}',
          //                 textAlign: TextAlign.center,
          //               ),
          //               width: MediaQuery.of(context).size.width * 0.8,
          //             )
          //           : const Text("Scan a qr"),
          //     ],
          //   ),
          // ),
          // Column(
          //   children: [
          //     Card(
          //       shape: RoundedRectangleBorder(
          //         borderRadius: BorderRadius.circular(10),
          //       ),
          //       color: Color(0xff00e0e0),
          //       child: IconButton(
          //         onPressed: () async {
          //           await FlutterClipboard.copy('${result!.code}').then(
          //             (value) => print('copied'),
          //           );
          //           const snacks = SnackBar(
          //             content: Text(
          //               'Copied',
          //               textAlign: TextAlign.center,
          //             ),
          //             elevation: 10,
          //             behavior: SnackBarBehavior.floating,
          //             margin: EdgeInsets.all(5),
          //           );
          //           ScaffoldMessenger.of(context).showSnackBar(snacks);
          //         },
          //         icon: Image.asset('image/copy.png'),
          //       ),
          //     ),
          //     Text('Copy', style: kScanTextStyles),
          //     SizedBox(height: 5),
          //   ],
          // ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}

// (result != null)
// ? Text(
// 'Barcode Type: ${describeEnum(result!.format)} Data: ${result!.code}')
// : const Text("Scan a qr"),
